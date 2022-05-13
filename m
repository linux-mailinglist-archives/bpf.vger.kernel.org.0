Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27B825266B2
	for <lists+bpf@lfdr.de>; Fri, 13 May 2022 18:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382314AbiEMQBP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 May 2022 12:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381614AbiEMQAz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 May 2022 12:00:55 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74AEA3980C
        for <bpf@vger.kernel.org>; Fri, 13 May 2022 09:00:52 -0700 (PDT)
Received: from sslproxy04.your-server.de ([78.46.152.42])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1npXig-0003Hn-OC; Fri, 13 May 2022 18:00:46 +0200
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy04.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1npXig-000TSZ-It; Fri, 13 May 2022 18:00:46 +0200
Subject: Re: [PATCH bpf-next v3 2/5] bpf: implement sleepable uprobes by
 chaining gps
To:     Delyan Kratunov <delyank@fb.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
References: <cover.1652404870.git.delyank@fb.com>
 <1b9c462226d2d7b97293e19ed2d578eb573a4544.1652404870.git.delyank@fb.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <861a77c8-80dc-7360-d7a6-d8eabc84461b@iogearbox.net>
Date:   Fri, 13 May 2022 18:00:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1b9c462226d2d7b97293e19ed2d578eb573a4544.1652404870.git.delyank@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.5/26540/Fri May 13 10:03:59 2022)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 5/13/22 3:22 AM, Delyan Kratunov wrote:
[...]
>   struct bpf_prog_array *bpf_prog_array_alloc(u32 prog_cnt, gfp_t flags);
>   void bpf_prog_array_free(struct bpf_prog_array *progs);
> +/* Use when traversal over the bpf_prog_array uses tasks_trace rcu */
> +void bpf_prog_array_free_sleepable(struct bpf_prog_array *progs);
>   int bpf_prog_array_length(struct bpf_prog_array *progs);
>   bool bpf_prog_array_is_empty(struct bpf_prog_array *array);
>   int bpf_prog_array_copy_to_user(struct bpf_prog_array *progs,
> @@ -1451,6 +1454,56 @@ bpf_prog_run_array(const struct bpf_prog_array *array,
>   	return ret;
>   }
>   
> +/**
> + * Notes on RCU design for bpf_prog_arrays containing sleepable programs:
> + *
> + * We use the tasks_trace rcu flavor read section to protect the bpf_prog_array
> + * overall. As a result, we must use the bpf_prog_array_free_sleepable
> + * in order to use the tasks_trace rcu grace period.
> + *
> + * When a non-sleepable program is inside the array, we take the rcu read
> + * section and disable preemption for that program alone, so it can access
> + * rcu-protected dynamically sized maps.
> + */

Btw, there are a number of kdoc warnings around your series, pls make sure to
fix or use 'regular' comment:

https://patchwork.hopto.org/static/nipa/641204/12848281/kdoc/stderr
https://patchwork.hopto.org/static/nipa/641204/12848282/kdoc/stderr

I presume otherwise kbuild bot will yell at some point.

Thanks,
Daniel
