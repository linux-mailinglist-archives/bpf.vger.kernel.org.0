Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82F0068DD1C
	for <lists+bpf@lfdr.de>; Tue,  7 Feb 2023 16:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbjBGPfK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Feb 2023 10:35:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbjBGPfJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Feb 2023 10:35:09 -0500
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC57538EB0
        for <bpf@vger.kernel.org>; Tue,  7 Feb 2023 07:35:05 -0800 (PST)
Received: by mail-qt1-f179.google.com with SMTP id 5so7157879qtp.9
        for <bpf@vger.kernel.org>; Tue, 07 Feb 2023 07:35:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lSEKfRJDc685nE+ruWwUrtuSKx5CqhEGU5RBFwsJp+M=;
        b=dtgdErhg9WybhWzka0oCqJWZ8g7XG0QxQjoDJjzL+PVkupREmiYiN87d2eGTdPNLQ7
         r/RyFk3O3k6vt984hxgF0OJMN15awu3GyI4U7lJbJT1RYYzREqYO9BKRj/qEMwpIn5LB
         ooChgilgpl6imMW+Jl8OseNHg8bml0fZREWGbf9BWabYwewlNf2dzs1h7i2iypGMgRK9
         AWSR/HvAjefSm+PCyErkzleMYsJPsLUBQNurANGqthMxiW2m4zXx4YAhNm2FD1C4Vs4I
         HUKjhS25HutJgvLV6uvymQO366TMpT3VjbVRluIQl8zkQgfBJ21heuGb5wEAYMzVuMqf
         GVmA==
X-Gm-Message-State: AO0yUKVOs8UD4InWI8WHJkk5Jso3cuFqMjFJySePxDLoZbtNEwZiW0hp
        XwFjKwKdfH6fb77bMiTlxfw=
X-Google-Smtp-Source: AK7set9hPs9LWqYhTVgeuBEpGFvCH5BEkx3/tulkCeUjg3TnJNNZwgZvrTi+TAibGlQzsO8v+p0l/g==
X-Received: by 2002:a05:622a:294:b0:3b8:2844:b7e1 with SMTP id z20-20020a05622a029400b003b82844b7e1mr6261821qtw.46.1675784104632;
        Tue, 07 Feb 2023 07:35:04 -0800 (PST)
Received: from maniforge.lan ([2620:10d:c091:480::1:9bc3])
        by smtp.gmail.com with ESMTPSA id el18-20020a05622a431200b003a81eef14efsm9486335qtb.45.2023.02.07.07.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 07:35:04 -0800 (PST)
Date:   Tue, 7 Feb 2023 09:35:07 -0600
From:   David Vernet <void@manifault.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Artem Savkov <asavkov@redhat.com>
Subject: Re: [PATCHv3 bpf-next 8/9] selftests/bpf: Remove extern from kfuncs
 declarations
Message-ID: <Y+Jvq2AG5B/dKMIq@maniforge.lan>
References: <20230203162336.608323-1-jolsa@kernel.org>
 <20230203162336.608323-9-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230203162336.608323-9-jolsa@kernel.org>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 03, 2023 at 05:23:35PM +0100, Jiri Olsa wrote:
> There's no need to keep the extern in kfuncs declarations.
> 
> Suggested-by: David Vernet <void@manifault.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---

Acked-by: David Vernet <void@manifault.com>

>  .../bpf/bpf_testmod/bpf_testmod_kfunc.h       | 38 +++++++++----------
>  1 file changed, 19 insertions(+), 19 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
> index 86d94257716a..27d4494444c8 100644
> --- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
> +++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
> @@ -10,32 +10,32 @@
>  #define __ksym
>  #endif
>  
> -extern struct prog_test_ref_kfunc *
> +struct prog_test_ref_kfunc *
>  bpf_kfunc_call_test_acquire(unsigned long *scalar_ptr) __ksym;
> -extern struct prog_test_ref_kfunc *
> +struct prog_test_ref_kfunc *
>  bpf_kfunc_call_test_kptr_get(struct prog_test_ref_kfunc **p, int a, int b) __ksym;
> -extern void bpf_kfunc_call_test_release(struct prog_test_ref_kfunc *p) __ksym;
> +void bpf_kfunc_call_test_release(struct prog_test_ref_kfunc *p) __ksym;
>  
> -extern void bpf_kfunc_call_test_mem_len_pass1(void *mem, int len) __ksym;
> -extern int *bpf_kfunc_call_test_get_rdwr_mem(struct prog_test_ref_kfunc *p, const int rdwr_buf_size) __ksym;
> -extern int *bpf_kfunc_call_test_get_rdonly_mem(struct prog_test_ref_kfunc *p, const int rdonly_buf_size) __ksym;
> -extern int *bpf_kfunc_call_test_acq_rdonly_mem(struct prog_test_ref_kfunc *p, const int rdonly_buf_size) __ksym;
> -extern void bpf_kfunc_call_int_mem_release(int *p) __ksym;
> -extern u32 bpf_kfunc_call_test_static_unused_arg(u32 arg, u32 unused) __ksym;
> +void bpf_kfunc_call_test_mem_len_pass1(void *mem, int len) __ksym;
> +int *bpf_kfunc_call_test_get_rdwr_mem(struct prog_test_ref_kfunc *p, const int rdwr_buf_size) __ksym;
> +int *bpf_kfunc_call_test_get_rdonly_mem(struct prog_test_ref_kfunc *p, const int rdonly_buf_size) __ksym;
> +int *bpf_kfunc_call_test_acq_rdonly_mem(struct prog_test_ref_kfunc *p, const int rdonly_buf_size) __ksym;
> +void bpf_kfunc_call_int_mem_release(int *p) __ksym;
> +u32 bpf_kfunc_call_test_static_unused_arg(u32 arg, u32 unused) __ksym;
>  
> -extern void bpf_testmod_test_mod_kfunc(int i) __ksym;
> +void bpf_testmod_test_mod_kfunc(int i) __ksym;
>  
> -extern __u64 bpf_kfunc_call_test1(struct sock *sk, __u32 a, __u64 b,
> +__u64 bpf_kfunc_call_test1(struct sock *sk, __u32 a, __u64 b,
>  				__u32 c, __u64 d) __ksym;
> -extern int bpf_kfunc_call_test2(struct sock *sk, __u32 a, __u32 b) __ksym;
> -extern struct sock *bpf_kfunc_call_test3(struct sock *sk) __ksym;
> -extern long bpf_kfunc_call_test4(signed char a, short b, int c, long d) __ksym;
> +int bpf_kfunc_call_test2(struct sock *sk, __u32 a, __u32 b) __ksym;
> +struct sock *bpf_kfunc_call_test3(struct sock *sk) __ksym;
> +long bpf_kfunc_call_test4(signed char a, short b, int c, long d) __ksym;
>  
> -extern void bpf_kfunc_call_test_pass_ctx(struct __sk_buff *skb) __ksym;
> -extern void bpf_kfunc_call_test_pass1(struct prog_test_pass1 *p) __ksym;
> -extern void bpf_kfunc_call_test_pass2(struct prog_test_pass2 *p) __ksym;
> -extern void bpf_kfunc_call_test_mem_len_fail2(__u64 *mem, int len) __ksym;
> +void bpf_kfunc_call_test_pass_ctx(struct __sk_buff *skb) __ksym;
> +void bpf_kfunc_call_test_pass1(struct prog_test_pass1 *p) __ksym;
> +void bpf_kfunc_call_test_pass2(struct prog_test_pass2 *p) __ksym;
> +void bpf_kfunc_call_test_mem_len_fail2(__u64 *mem, int len) __ksym;
>  
> -extern void bpf_kfunc_call_test_destructive(void) __ksym;
> +void bpf_kfunc_call_test_destructive(void) __ksym;
>  
>  #endif /* _BPF_TESTMOD_KFUNC_H */
> -- 
> 2.39.1
> 
