Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F11CA5A566A
	for <lists+bpf@lfdr.de>; Mon, 29 Aug 2022 23:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbiH2VrK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Aug 2022 17:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiH2VrJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Aug 2022 17:47:09 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF57785F81
        for <bpf@vger.kernel.org>; Mon, 29 Aug 2022 14:47:07 -0700 (PDT)
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1oSmay-0008Az-Lu; Mon, 29 Aug 2022 23:47:00 +0200
Received: from [85.1.206.226] (helo=linux-4.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1oSmay-0004PY-Dj; Mon, 29 Aug 2022 23:47:00 +0200
Subject: Re: [PATCH v4 bpf-next 06/15] bpf: Optimize element count in
 non-preallocated hash map.
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        davem@davemloft.net
Cc:     andrii@kernel.org, tj@kernel.org, memxor@gmail.com, delyank@fb.com,
        linux-mm@kvack.org, bpf@vger.kernel.org, kernel-team@fb.com
References: <20220826024430.84565-1-alexei.starovoitov@gmail.com>
 <20220826024430.84565-7-alexei.starovoitov@gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <75b5f42d-84f6-4227-0bf9-fb62c89217c7@iogearbox.net>
Date:   Mon, 29 Aug 2022 23:47:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20220826024430.84565-7-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.6/26642/Mon Aug 29 09:54:26 2022)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 8/26/22 4:44 AM, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> The atomic_inc/dec might cause extreme cache line bouncing when multiple cpus
> access the same bpf map. Based on specified max_entries for the hash map
> calculate when percpu_counter becomes faster than atomic_t and use it for such
> maps. For example samples/bpf/map_perf_test is using hash map with max_entries
> 1000. On a system with 16 cpus the 'map_perf_test 4' shows 14k events per
> second using atomic_t. On a system with 15 cpus it shows 100k events per second
> using percpu. map_perf_test is an extreme case where all cpus colliding on
> atomic_t which causes extreme cache bouncing. Note that the slow path of
> percpu_counter is 5k events per secound vs 14k for atomic, so the heuristic is
> necessary. See comment in the code why the heuristic is based on
> num_online_cpus().

nit: Could we include this logic inside percpu_counter logic, or as an extended
version of it? Except the heuristic of attr->max_entries / 2 > num_online_cpus() *
PERCPU_COUNTER_BATCH which toggles between plain atomic vs percpu_counter, the
rest feel generic enough that it could also be applicable outside bpf.

> Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>   kernel/bpf/hashtab.c | 70 +++++++++++++++++++++++++++++++++++++++-----
>   1 file changed, 62 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index bd23c8830d49..8f68c6e13339 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -101,7 +101,12 @@ struct bpf_htab {
>   		struct bpf_lru lru;
>   	};
>   	struct htab_elem *__percpu *extra_elems;
> -	atomic_t count;	/* number of elements in this hashtable */
> +	/* number of elements in non-preallocated hashtable are kept
> +	 * in either pcount or count
> +	 */
> +	struct percpu_counter pcount;
> +	atomic_t count;
> +	bool use_percpu_counter;
>   	u32 n_buckets;	/* number of hash buckets */
>   	u32 elem_size;	/* size of each element in bytes */
>   	u32 hashrnd;
> @@ -552,6 +557,29 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
>   
>   	htab_init_buckets(htab);
>   
> +/* compute_batch_value() computes batch value as num_online_cpus() * 2
> + * and __percpu_counter_compare() needs
> + * htab->max_entries - cur_number_of_elems to be more than batch * num_online_cpus()
> + * for percpu_counter to be faster than atomic_t. In practice the average bpf
> + * hash map size is 10k, which means that a system with 64 cpus will fill
> + * hashmap to 20% of 10k before percpu_counter becomes ineffective. Therefore
> + * define our own batch count as 32 then 10k hash map can be filled up to 80%:
> + * 10k - 8k > 32 _batch_ * 64 _cpus_
> + * and __percpu_counter_compare() will still be fast. At that point hash map
> + * collisions will dominate its performance anyway. Assume that hash map filled
> + * to 50+% isn't going to be O(1) and use the following formula to choose
> + * between percpu_counter and atomic_t.
> + */
> +#define PERCPU_COUNTER_BATCH 32
> +	if (attr->max_entries / 2 > num_online_cpus() * PERCPU_COUNTER_BATCH)
> +		htab->use_percpu_counter = true;
> +
> +	if (htab->use_percpu_counter) {
> +		err = percpu_counter_init(&htab->pcount, 0, GFP_KERNEL);
> +		if (err)
> +			goto free_map_locked;
> +	}
> +
>   	if (prealloc) {
>   		err = prealloc_init(htab);
>   		if (err)
> @@ -878,6 +906,31 @@ static void htab_put_fd_value(struct bpf_htab *htab, struct htab_elem *l)
>   	}
>   }
>   
> +static bool is_map_full(struct bpf_htab *htab)
> +{
> +	if (htab->use_percpu_counter)
> +		return __percpu_counter_compare(&htab->pcount, htab->map.max_entries,
> +						PERCPU_COUNTER_BATCH) >= 0;
> +	return atomic_read(&htab->count) >= htab->map.max_entries;
> +}
> +
> +static void inc_elem_count(struct bpf_htab *htab)
> +{
> +	if (htab->use_percpu_counter)
> +		percpu_counter_add_batch(&htab->pcount, 1, PERCPU_COUNTER_BATCH);
> +	else
> +		atomic_inc(&htab->count);
> +}
> +
> +static void dec_elem_count(struct bpf_htab *htab)
> +{
> +	if (htab->use_percpu_counter)
> +		percpu_counter_add_batch(&htab->pcount, -1, PERCPU_COUNTER_BATCH);
> +	else
> +		atomic_dec(&htab->count);
> +}
> +
> +
