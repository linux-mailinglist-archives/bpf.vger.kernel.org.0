Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 200B35813C6
	for <lists+bpf@lfdr.de>; Tue, 26 Jul 2022 15:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbiGZNFS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Jul 2022 09:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232995AbiGZNFQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Jul 2022 09:05:16 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C24FCAE7C
        for <bpf@vger.kernel.org>; Tue, 26 Jul 2022 06:05:14 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id u5so20066411wrm.4
        for <bpf@vger.kernel.org>; Tue, 26 Jul 2022 06:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc;
        bh=4iTZlTmifSS5KLH9k+l7jspZoCfdU1dtMi9vVEilXJs=;
        b=OPdgOtlfCO/0Q/CwhidChAOuwDyZJ5dYQL8dHv942BjWFqekAKDskoFFQUGVOA4NC0
         JNonvN1dFZhzwp3RX+QsUn268cvcMjyarnZakgpT+WPUGxrl7zOItk97fd2P3C41ftsp
         zRuQ1cDXIAOg609ODLGIgPwADDcp7yS0SGzrG5RnA3xIbkldmhlwefablCnMjYq3Q9Sq
         pJrTMZGLz1TcKL+WnHamUwq9puMOfleg+SbEtxrcWqZnZsDj1z09Vm4g/efr5biRLADJ
         IDCjFLdZuMg82MLJFb6MccFMxdgD/+SPvfXOdhIiIvB6JSIIa+vA+pJ5tDZtjHYeT4Xy
         e8lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc;
        bh=4iTZlTmifSS5KLH9k+l7jspZoCfdU1dtMi9vVEilXJs=;
        b=wXepdYqVqK72yQl2LpVOd03gIu3wwRhSr+X4unXYqnzkLgc4kCZ4umfYtNdXnOYoXt
         /FxLspTVqYTwyOEvQ8wtT8DXVsiurdHLBbEnnpr0c2twS5RS1QgcOzyWDzT6Up+qQFPm
         6SW8u/rVCeLJGM/biEr41QoNPFznFK/FcH8M674pfSePyt8K2nTm0QU6gaZesyay8+AI
         DDWOyJNxGd6d+75ZHmWLbgtoAWq7GC6nb42iTJaov82m2cKGb+osUl3j0RXzb06eqCBX
         gVq6fcCe2kplINkcmU36+7HCoKW9e4yibO9m8gLzt64EdDWSC7wq4bhMD1USOk3ZcNaM
         VYSA==
X-Gm-Message-State: AJIora8wFRseMtHLKREzrndVTPyRsDwgH9QEXyiPf1ZsOb3+7WQJ4fWx
        xdSwILAYvNV9GhU98gd6rXE=
X-Google-Smtp-Source: AGRyM1sAhij5tkRxX/jmBBPVXQaBIqDzvV/k25XMbw5zeSgczB4gmPna11IXotbY8IxfucHvLBR5aQ==
X-Received: by 2002:a5d:4608:0:b0:21e:5755:98a3 with SMTP id t8-20020a5d4608000000b0021e575598a3mr10870141wrq.240.1658840713259;
        Tue, 26 Jul 2022 06:05:13 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id n17-20020a05600c4f9100b003a02cbf862esm18420451wmq.13.2022.07.26.06.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 06:05:12 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Tue, 26 Jul 2022 15:05:11 +0200
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH bpf-next 1/2] libbpf: Extend BPF_KSYSCALL documentation
Message-ID: <Yt/mh+y6KgV50Vwr@krava>
References: <20220723020344.21699-1-iii@linux.ibm.com>
 <20220723020344.21699-2-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220723020344.21699-2-iii@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Jul 23, 2022 at 04:03:43AM +0200, Ilya Leoshkevich wrote:
> Explicitly list known quirks.
> Mention that socket-related syscalls can be invoked via socketcall().
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  tools/lib/bpf/bpf_tracing.h | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
> index f4d3e1e2abe2..9d2feab7d903 100644
> --- a/tools/lib/bpf/bpf_tracing.h
> +++ b/tools/lib/bpf/bpf_tracing.h
> @@ -523,10 +523,16 @@ static __always_inline typeof(name(0)) ____##name(struct pt_regs *ctx, ##args)
>   * Original struct pt_regs * context is preserved as 'ctx' argument. This might
>   * be necessary when using BPF helpers like bpf_perf_event_output().
>   *
> - * At the moment BPF_KSYSCALL does not handle all the calling convention
> - * quirks for mmap(), clone() and compat syscalls transparrently. This may or
> - * may not change in the future. User needs to take extra measures to handle
> - * such quirks explicitly, if necessary.
> + * At the moment BPF_KSYSCALL does not transparently handle all the calling
> + * convention quirks for the following syscalls:
> + *
> + * - mmap(): __ARCH_WANT_SYS_OLD_MMAP.
> + * - clone(): CLONE_BACKWARDS, CLONE_BACKWARDS2 and CLONE_BACKWARDS3.

nit, these could have CONFIG_ prefix to make it more
obvious it's config options

jirka

> + * - socket-related syscalls: __ARCH_WANT_SYS_SOCKETCALL.
> + * - compat syscalls.
> + *
> + * This may or may not change in the future. User needs to take extra measures
> + * to handle such quirks explicitly, if necessary.
>   *
>   * This macro relies on BPF CO-RE support and virtual __kconfig externs.
>   */
> -- 
> 2.35.3
> 
