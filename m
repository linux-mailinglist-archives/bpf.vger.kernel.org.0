Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCF214DE281
	for <lists+bpf@lfdr.de>; Fri, 18 Mar 2022 21:28:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235658AbiCRU34 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Mar 2022 16:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240684AbiCRU3z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Mar 2022 16:29:55 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0AAB2A3A5E
        for <bpf@vger.kernel.org>; Fri, 18 Mar 2022 13:28:35 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id qa43so19068634ejc.12
        for <bpf@vger.kernel.org>; Fri, 18 Mar 2022 13:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=z+/MS9ElbOM4o1aPEm6MKeyVpGIJ9I4RDGjl/xsQpzE=;
        b=ghyaPZStBQprd9VvITu53ig3o2QTzFPSoPy0MSBFGnMO81gBMKnSxKF2zJazX7wKyM
         Rb+rfj5AMt2X0opxurfrFWErrJlgjJX+O+0TwxSSJdDsLHo/fJQxl8NvvjYZvv+OzRRg
         uwxoMpqOs/nNLL+IV5ebTai3Cna7lOm9N6RB/mfjMVIXYfeqArQlcslBLlQfg1iuC8Js
         kqAdWpDBQ1zS5boFa4otooFNhYCLzvdoc9yw6TGg/bFsjLRstf6WTscuFKTnk3BD7VH2
         XUOZo3CuVpiT/CCx7+JRh6GRa7SR/UTtZooxJNQ4jfGbCsslxbLBhWAzttH13g9K1/O8
         4K/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=z+/MS9ElbOM4o1aPEm6MKeyVpGIJ9I4RDGjl/xsQpzE=;
        b=bCv+Z9xCvyrhx8W4AMFJXvwf1xgUQ0BsrgW8ISVcN+0CbancYOTeMTxn3Wmiqzbzkv
         GaVFVcn/sWwWu7HyIC+RXY5mLt07gQnH1V7zvZw08uj4akuZZd3Xo6LVqcohr97i+ovc
         T/6Fjy1/mNJlofj/+HKtDmnBeTykN2rLNz/eUjtZz5e6C5KSjxQA2gTqMRKs93VCZag0
         0G63mqSsqv4JxV4olVOo/smWmhpc8e+EZtF62M9WTg6HmzVmBnIw1XHyPos0aFkZ0HHM
         v+8m0FMs2TbdSBvQQwrPIAzUyEWpCXTL0I4Xb9Mkkgl93WXXqMbPxM6IIlklNKpS5T0L
         fSIQ==
X-Gm-Message-State: AOAM530F+1uSRPVefcBAI76tyHb1L+NNwjZC9TUKXGiiqShn9NQTirJn
        FzbSva6CMvOgm4VwyI9rXrs=
X-Google-Smtp-Source: ABdhPJxESKChoad7OiTi7ueGZQq3H4FS9/XId+KUqjfjhlh9i4mZwaUFEme917pu8lMiCvlTQtX5ug==
X-Received: by 2002:a17:907:7d9e:b0:6df:9fe8:856a with SMTP id oz30-20020a1709077d9e00b006df9fe8856amr7947802ejc.373.1647635314089;
        Fri, 18 Mar 2022 13:28:34 -0700 (PDT)
Received: from krava ([83.240.61.119])
        by smtp.gmail.com with ESMTPSA id dd6-20020a1709069b8600b006df08710d00sm4128200ejc.85.2022.03.18.13.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 13:28:33 -0700 (PDT)
Date:   Fri, 18 Mar 2022 21:28:31 +0100
From:   Jiri Olsa <olsajiri@gmail.com>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com
Subject: Re: [PATCH bpf-next] bpftool: add BPF_TRACE_KPROBE_MULTI to attach
 type names table
Message-ID: <YjTrb3xpkpmLaM8V@krava>
References: <20220318150106.2933343-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220318150106.2933343-1-andrii@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 18, 2022 at 08:01:06AM -0700, Andrii Nakryiko wrote:
> BPF_TRACE_KPROBE_MULTI is a new attach type name, add it to bpftool's
> table. This fixes a currently failing CI bpftool check.

right, I forgot about this

> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  tools/bpf/bpftool/common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
> index 606743c6db41..b091923c71cb 100644
> --- a/tools/bpf/bpftool/common.c
> +++ b/tools/bpf/bpftool/common.c
> @@ -56,7 +56,6 @@ const char * const attach_type_name[__MAX_BPF_ATTACH_TYPE] = {
>  	[BPF_CGROUP_UDP6_RECVMSG]	= "recvmsg6",
>  	[BPF_CGROUP_GETSOCKOPT]		= "getsockopt",
>  	[BPF_CGROUP_SETSOCKOPT]		= "setsockopt",
> -
>  	[BPF_SK_SKB_STREAM_PARSER]	= "sk_skb_stream_parser",
>  	[BPF_SK_SKB_STREAM_VERDICT]	= "sk_skb_stream_verdict",
>  	[BPF_SK_SKB_VERDICT]		= "sk_skb_verdict",
> @@ -76,6 +75,7 @@ const char * const attach_type_name[__MAX_BPF_ATTACH_TYPE] = {
>  	[BPF_SK_REUSEPORT_SELECT]	= "sk_skb_reuseport_select",
>  	[BPF_SK_REUSEPORT_SELECT_OR_MIGRATE]	= "sk_skb_reuseport_select_or_migrate",
>  	[BPF_PERF_EVENT]		= "perf_event",
> +	[BPF_TRACE_KPROBE_MULTI]	= "trace_kprobe_bulti",

typo ;-)                                                ^

jirka

>  };
>  
>  void p_err(const char *fmt, ...)
> -- 
> 2.30.2
> 
