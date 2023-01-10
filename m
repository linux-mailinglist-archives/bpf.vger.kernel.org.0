Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAF67663749
	for <lists+bpf@lfdr.de>; Tue, 10 Jan 2023 03:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237857AbjAJCZj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 9 Jan 2023 21:25:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237851AbjAJCZg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Jan 2023 21:25:36 -0500
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19AF127190
        for <bpf@vger.kernel.org>; Mon,  9 Jan 2023 18:25:33 -0800 (PST)
X-QQ-mid: bizesmtp66t1673317524tc8kezwm
Received: from smtpclient.apple ( [1.202.165.115])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 10 Jan 2023 10:25:22 +0800 (CST)
X-QQ-SSF: 01000000000000708000000A0000000
X-QQ-FEAT: UMQM+3VOEYuKeYzL7GXY/71f8FuSE8zQZvExJTA2Fh0ySTJihHLQePjibrYoC
        NyQN8VSvucMLPi9LTA3TIr3kgwMjPyBWcjtklKFsOCwTAesz383oCyB9KWjaSgsO703Q4PN
        3r7oDbgQj8lBjRXZoihqrWkHVmBIA/oo8K+jPR0M/BRs11x2/+SkHI6m/NIv2mSOafXDxEA
        s0Z95Y20T00nNFYBjwlun0IADukWJ6791F7gsYriVqpMfYf6J0mSnG9jnOEHHeXCdprfGPG
        wGVYy1aE6k6KFo6RVY4405s6dUO0qplJSdg6slR3g7uw7n5+ab4t7n05Y5UeluLufl+uYXO
        WmMRvmZjMv7rr7wR0gR+FVHfK/6AQnVl9NzWtrQqYt15ZmWN3cxhAwUvoL3Zg==
X-QQ-GoodBg: 0
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.20.0.1.32\))
Subject: Re: [bpf-next v4 1/2] bpf: hash map, avoid deadlock with suitable
 hash mask
From:   Tonghao Zhang <tong@infragraf.org>
In-Reply-To: <28f6d8e5-f01d-d63b-a326-aa4e63b5c804@linux.dev>
Date:   Tue, 10 Jan 2023 10:25:22 +0800
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Hou Tao <houtao1@huawei.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <22C7F5C2-073C-4692-B847-C090F7E69B79@infragraf.org>
References: <20230105092637.35069-1-tong@infragraf.org>
 <28f6d8e5-f01d-d63b-a326-aa4e63b5c804@linux.dev>
To:     Martin KaFai Lau <martin.lau@linux.dev>
X-Mailer: Apple Mail (2.3693.20.0.1.32)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:infragraf.org:qybglogicsvr:qybglogicsvr5
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Jan 10, 2023, at 9:52 AM, Martin KaFai Lau <martin.lau@linux.dev> wrote:
> 
> On 1/5/23 1:26 AM, tong@infragraf.org wrote:
>> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
>> index 5aa2b5525f79..974f104f47a0 100644
>> --- a/kernel/bpf/hashtab.c
>> +++ b/kernel/bpf/hashtab.c
>> @@ -152,7 +152,7 @@ static inline int htab_lock_bucket(const struct bpf_htab *htab,
>>  {
>>  	unsigned long flags;
>>  -	hash = hash & HASHTAB_MAP_LOCK_MASK;
>> +	hash = hash & min_t(u32, HASHTAB_MAP_LOCK_MASK, htab->n_buckets -1);
>>    	preempt_disable();
>>  	if (unlikely(__this_cpu_inc_return(*(htab->map_locked[hash])) != 1)) {
>> @@ -171,7 +171,7 @@ static inline void htab_unlock_bucket(const struct bpf_htab *htab,
>>  				      struct bucket *b, u32 hash,
>>  				      unsigned long flags)
>>  {
>> -	hash = hash & HASHTAB_MAP_LOCK_MASK;
>> +	hash = hash & min_t(u32, HASHTAB_MAP_LOCK_MASK, htab->n_buckets -1);
> 
> Please run checkpatch.pl.  patchwork also reports the same thing:
> https://patchwork.kernel.org/project/netdevbpf/patch/20230105092637.35069-1-tong@infragraf.org/
> 
> CHECK: spaces preferred around that '-' (ctx:WxV)
> #46: FILE: kernel/bpf/hashtab.c:155:
> +	hash = hash & min_t(u32, HASHTAB_MAP_LOCK_MASK, htab->n_buckets -1);
> 	                                                                ^
> 
> CHECK: spaces preferred around that '-' (ctx:WxV)
> #55: FILE: kernel/bpf/hashtab.c:174:
> +	hash = hash & min_t(u32, HASHTAB_MAP_LOCK_MASK, htab->n_buckets -1);
> 
> btw, instead of doing this min_t and -1 repeatedly, ensuring n_buckets is at least HASHTAB_MAP_LOCK_COUNT during map_alloc should be as good?  htab having 2 or 4 max_entries should be pretty uncommon.
> 
I think we should not limit the max_entries, while it’s not common use case. But for performance, we can introduce htab->n_buckets_mask = HASHTAB_MAP_LOCK_COUNT & (htab->n_buckets -1) ?
