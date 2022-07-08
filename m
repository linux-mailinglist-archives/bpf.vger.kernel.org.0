Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4546656B5A9
	for <lists+bpf@lfdr.de>; Fri,  8 Jul 2022 11:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237206AbiGHJfR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Jul 2022 05:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237254AbiGHJfQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Jul 2022 05:35:16 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86B425A2F8
        for <bpf@vger.kernel.org>; Fri,  8 Jul 2022 02:35:14 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id k30so18072077edk.8
        for <bpf@vger.kernel.org>; Fri, 08 Jul 2022 02:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MUzkur2V51PvqmkJzytl5Qlj+WVVJTYs2M1RiKzQN2s=;
        b=hE8tQ1x/LMcqyWLm9sLKPLY2DtDwMfJ3bE7egTTUqkT+7BC5D7nq5Jvydjy7892kbU
         djqLpARvHwFOhTocl5oDrI6NZT9hftF2B+AlitXK/VnhixBN3/BV2llaaJZ4KUs2QjLR
         aSwW9jt0qxg4DX2tHzK3oKkZJBSPdQq47go4pnKVDGompsZfy9oMquN2hFquPT2fH332
         7GxjSWNw1Dg5PxP/HB57SzRVAgISDm9Tt9Mr855WiCtXfXD6RqfIIpMaeDUC90b27S4y
         oxmjOjhiVxiZIQ6X3u/U2UbqGonlke8Lr2ECwQ4mSa7a1B0KAQORgBwWDOhwbbaKELRG
         XHeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MUzkur2V51PvqmkJzytl5Qlj+WVVJTYs2M1RiKzQN2s=;
        b=z+bbqG2L5Mzp7NwyDFbPPgc+HLrYu82YMUqdcmKhl0Gz+hC0DLLgbOyeh7tGLhaLjk
         72pg5BLGm1Xk28oyphY5mRqIV5UUVgTYTBsK6r5Y2hthcYFAPPfwXKzHId6BHC2OXOCX
         hIDRyOrxSO/cD9N97qTekM7B/AVj3F9+pGySaxLviVLnP6dBKd1tWBnbVkn/08hHERHL
         qZ4Z3iNDhrlK5yvdqsxOUltUm5BHJnOzbH9GxZZjPNNYnr6eImLI3A5CKZS/C8VHJ2Pi
         EhJ0ORihRwpTXEsYjtQA68DF+IKjBv1UB6ofP8KoV9INh2TBZObkpk80CC92Lgcz4q5/
         zUug==
X-Gm-Message-State: AJIora9ssp9WEAiNv+6YBztlThWkK0Hmt1PAr7UYA1A+bCdzLUJxG4dX
        N/9k6M9K8t4ZO0eQsGdVtIQ=
X-Google-Smtp-Source: AGRyM1sIPeJ+lEBb8a2k3hCChapnY2pzTeSqyXGpi2BHti5NyIJYq5jRNRxE4m909EYgWT38ZqzfRw==
X-Received: by 2002:a50:ff0e:0:b0:433:5d15:eada with SMTP id a14-20020a50ff0e000000b004335d15eadamr3498104edu.102.1657272913075;
        Fri, 08 Jul 2022 02:35:13 -0700 (PDT)
Received: from krava ([151.14.22.253])
        by smtp.gmail.com with ESMTPSA id kv12-20020a17090778cc00b0072637b9c8c0sm180994ejc.219.2022.07.08.02.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 02:35:12 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Fri, 8 Jul 2022 11:35:09 +0200
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, Ilya Leoshkevich <iii@linux.ibm.com>,
        Kenta Tada <kenta.tada@sony.com>,
        Hengqi Chen <hengqi.chen@gmail.com>
Subject: Re: [PATCH RFC bpf-next 2/3] libbpf: add ksyscall/kretsyscall
 sections support for syscall kprobes
Message-ID: <Ysf6TRzh9hgsAjep@krava>
References: <20220707004118.298323-1-andrii@kernel.org>
 <20220707004118.298323-3-andrii@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220707004118.298323-3-andrii@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jul 06, 2022 at 05:41:17PM -0700, Andrii Nakryiko wrote:

SNIP

> +static int probe_kern_syscall_wrapper(void)
> +{
> +	/* available_filter_functions is a few times smaller than
> +	 * /proc/kallsyms and has simpler format, so we use it as a faster way
> +	 * to check that __<arch>_sys_bpf symbol exists, which is a sign that
> +	 * kernel was built with CONFIG_ARCH_HAS_SYSCALL_WRAPPER and uses
> +	 * syscall wrappers
> +	 */
> +	static const char *kprobes_file = "/sys/kernel/tracing/available_filter_functions";
> +	char func_name[128], syscall_name[128];
> +	const char *ksys_pfx;
> +	FILE *f;
> +	int cnt;
> +
> +	ksys_pfx = arch_specific_syscall_pfx();
> +	if (!ksys_pfx)
> +		return 0;
> +
> +	f = fopen(kprobes_file, "r");
> +	if (!f)
> +		return 0;
> +
> +	snprintf(syscall_name, sizeof(syscall_name), "__%s_sys_bpf", ksys_pfx);
> +
> +	/* check if bpf() syscall wrapper is listed as possible kprobe */
> +	while ((cnt = fscanf(f, "%127s%*[^\n]\n", func_name)) == 1) {

nit cnt is not used/needed

jirka

> +		if (strcmp(func_name, syscall_name) == 0) {
> +			fclose(f);
> +			return 1;
> +		}
> +	}
> +
> +	fclose(f);
> +	return 0;
> +}
> +
>  enum kern_feature_result {
>  	FEAT_UNKNOWN = 0,
>  	FEAT_SUPPORTED = 1,
> @@ -4722,6 +4781,9 @@ static struct kern_feature_desc {
>  	[FEAT_BTF_ENUM64] = {
>  		"BTF_KIND_ENUM64 support", probe_kern_btf_enum64,
>  	},
> +	[FEAT_SYSCALL_WRAPPER] = {
> +		"Kernel using syscall wrapper", probe_kern_syscall_wrapper,
> +	},
>  };
>  

SNIP
