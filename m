Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A94865122D
	for <lists+bpf@lfdr.de>; Mon, 19 Dec 2022 19:50:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232420AbiLSSuY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Dec 2022 13:50:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232394AbiLSSuX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Dec 2022 13:50:23 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 270302DFE
        for <bpf@vger.kernel.org>; Mon, 19 Dec 2022 10:50:21 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id k2-20020a17090a514200b002198214abdcso3871225pjm.8
        for <bpf@vger.kernel.org>; Mon, 19 Dec 2022 10:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=APQb2D+bAgLt3P1W8vamMruA1GBV8bS5d60aXK1jM1k=;
        b=MuzB/ZFnLBfCn/Z+PnVgb5VvkijYMe+/3aBexVfEiFr1uNw83rHeLNNZwqN724W6Oj
         inE8cwZg4SPWBKD6/F8FE+axpuG0qd5c5QyUIm5U1fnHq+dYPKmXnyFSV2uRT/44Fyml
         cwXJE9lgO/ti5M42E60/xC5MJ1vLHqt4yv1eIy85TY/LTnUSj/K5ASkohyrhtTCsvUCK
         RdHN95zJXkHa6yYeRKPhIjU9Z9MMy28SXsNzH0nZQvc7hvePK/52WGcQOnngPVEFvg+3
         C0wX4hyqjxFUfxZ7HLzUAlh9amqwKkWwM2/CTu55h7W6YJkUfkk+x7fhrEi36DMfvg+8
         crIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=APQb2D+bAgLt3P1W8vamMruA1GBV8bS5d60aXK1jM1k=;
        b=F2aoUuzhrCVBS70imuYezfRhIhAw2bNiR3BV7ZzizIDvMqeMAvNU3H6jX5hPKfA+8b
         AwWCM/UQ4ljXEjnN31zPW1DPHdGror15C6H3usojo5J/hm2ZtOS1HiGurJhkjp+XYdi8
         R7f8VZ+wMhTNHOBMuDG4rhsWNTGH5IJOEJBmXvuKz+h1kJVbf9ryvnz+dsMYDkFUWfG4
         HLENCvY8E656S3jr7kJGzOVGFqc0HG/el9l2AAilQy6/0IQlUhl/3v8wAeh8Dq/ROfoN
         E3vKpMHFtG3QI5O+A695wvfKKPdXY8g4eZNP1cO/vCkd6U8P91I5waqLmxEhXqo5M3sV
         Afug==
X-Gm-Message-State: AFqh2kpZ/nyYNAvgartmBpJacoFR6YfXHs3Mk+7rLdJbTwVB7d3t0Ate
        N2B6A7uew4RC6Q7M/madIQs+CLI=
X-Google-Smtp-Source: AMrXdXvL0VkqrCC5PX4ou+P9vbHOFBr3/svMkEu8P5mUwS43/myKO/GwGI5q0H4FD+lKKxK16Y7zgq8=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:90b:958:b0:219:5b3b:2b9f with SMTP id
 dw24-20020a17090b095800b002195b3b2b9fmr287553pjb.2.1671475820326; Mon, 19 Dec
 2022 10:50:20 -0800 (PST)
Date:   Mon, 19 Dec 2022 10:50:18 -0800
In-Reply-To: <20221219064613.2932-1-liuxin350@huawei.com>
Mime-Version: 1.0
References: <20221219064613.2932-1-liuxin350@huawei.com>
Message-ID: <Y6CyatoFytXToO/g@google.com>
Subject: Re: [PATCH] libbpf: fix crash when input null program point in USDT API
From:   sdf@google.com
To:     Xin Liu <liuxin350@huawei.com>
Cc:     andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com,
        jolsa@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, yanan@huawei.com,
        wuchangye@huawei.com, xiesongyang@huawei.com,
        kongweibin2@huawei.com, zhangmingyi5@huawei.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 12/19, Xin Liu wrote:
> The API functions bpf_program__attach_perf_event_opts and
> bpf_program_attach_usdt can be invoked by users. However, when the
> input prog parameter is null, the API uses name and obj without
> check. This will cause program to crash directly.

Why do we care about these only? We have a lot of functions invoked
by the users which don't check the arguments. Can the caller ensure
the prog is valid/consistent before calling these?

> Signed-off-by: Xin Liu <liuxin350@huawei.com>
> ---
>   tools/lib/bpf/libbpf.c | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 2a82f49ce16f..0d21de4f7d5c 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -9764,6 +9764,11 @@ struct bpf_link  
> *bpf_program__attach_perf_event_opts(const struct bpf_program *p
>   	if (!OPTS_VALID(opts, bpf_perf_event_opts))
>   		return libbpf_err_ptr(-EINVAL);

> +	if (!prog || !prog->name) {
> +		pr_warn("prog: invalid prog\n");
> +		return libbpf_err_ptr(-EINVAL);
> +	}
> +
>   	if (pfd < 0) {
>   		pr_warn("prog '%s': invalid perf event FD %d\n",
>   			prog->name, pfd);
> @@ -10967,7 +10972,7 @@ struct bpf_link *bpf_program__attach_usdt(const  
> struct bpf_program *prog,
>   					  const struct bpf_usdt_opts *opts)
>   {
>   	char resolved_path[512];
> -	struct bpf_object *obj = prog->obj;
> +	struct bpf_object *obj;
>   	struct bpf_link *link;
>   	__u64 usdt_cookie;
>   	int err;
> @@ -10975,6 +10980,11 @@ struct bpf_link *bpf_program__attach_usdt(const  
> struct bpf_program *prog,
>   	if (!OPTS_VALID(opts, bpf_uprobe_opts))
>   		return libbpf_err_ptr(-EINVAL);

> +	if (!prog || !prog->name || !prog->obj) {
> +		pr_warn("prog: invalid prog\n");
> +		return libbpf_err_ptr(-EINVAL);
> +	}
> +
>   	if (bpf_program__fd(prog) < 0) {
>   		pr_warn("prog '%s': can't attach BPF program w/o FD (did you load  
> it?)\n",
>   			prog->name);
> @@ -10997,6 +11007,7 @@ struct bpf_link *bpf_program__attach_usdt(const  
> struct bpf_program *prog,
>   	/* USDT manager is instantiated lazily on first USDT attach. It will
>   	 * be destroyed together with BPF object in bpf_object__close().
>   	 */
> +	obj = prog->obj;
>   	if (IS_ERR(obj->usdt_man))
>   		return libbpf_ptr(obj->usdt_man);
>   	if (!obj->usdt_man) {
> --
> 2.33.0

