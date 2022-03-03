Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 925944CC6AC
	for <lists+bpf@lfdr.de>; Thu,  3 Mar 2022 20:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234817AbiCCUAR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Mar 2022 15:00:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235678AbiCCUAQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Mar 2022 15:00:16 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4841A277D;
        Thu,  3 Mar 2022 11:59:31 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id z12-20020a17090ad78c00b001bf022b69d6so4893533pju.2;
        Thu, 03 Mar 2022 11:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SECZtAQiZYsVQ356zmMgfQ3WYpSqn0ItZ/EiHtTGAJc=;
        b=RoWmxYcU6YwsOuDDXfn3JP+HkgaAX9BLByYYk2G2xpqq9C1Gc0YPJeGcfDHl3oCDpv
         vBnwR2UyIbyuqBetZEMShb3lAMTeLCVn8nX0+nOXoK+kROo/+9Qrv1WU5vBPxELyHvzD
         26eJ6UwDONK2Oe7hlb78veqy92X48SW/OgizCl1q7EBC44ytFTEa+0+8cJSq0655v7OB
         89h+SoeW8gN3ZCAyrzCN4LWs2Zq60i2W1sSow71NpPoKeWo207CHRXnvIImoErSk8N4n
         /9wihC1aeBzpYRkUECOkGU9Hriv8FMXiypzw8/vf3Or+epp7XzDsYmGOvP/SdMd9IUD5
         O5gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SECZtAQiZYsVQ356zmMgfQ3WYpSqn0ItZ/EiHtTGAJc=;
        b=a+xcZ9QVDSrtRT2ptqgIhLgrr2n5kgDc6Fuxm+7oXQhgcJy5Lrnb13cazY9mDcEQrV
         19Gl0ZtDimwS1ymNKp24G9m69JrHhvJYzmgWKvRQkiFDw5dsoWhy0N2M2s835aG1+AC0
         TQ/uLQGFWbQaGNQbBRaaz9NfOCXEh8pbiaC6O6D5xfzZOogRoJtbudBrx+bQLVL5vtoY
         TlVPPkskqmmNhmtlB9NnIfO15W/eqCmqO6ccAx4fFviIPbCzwpvY19x3TlL0cxFA7VNT
         7T/QcUzcUxZVsslUGADCrg2oLzXFSCL84LMxyNwwxLSeaB0jjyvgUOADG8qZr+8/AKiu
         IIig==
X-Gm-Message-State: AOAM533BKWRzg096mael+w1ULBoITwOzvhRvnp8ygJqZ5SIj7Ul95rlN
        jN8JkjpTRxQDWmqM53X33ok63w7w+tfjOAW6uhw=
X-Google-Smtp-Source: ABdhPJzKfZm6JN0YkKE/595KBy78YvkZiDtQ9/t7zs4LdqfhHMk13JQbn81aQKTwiNEbwdtVLjulzwlWARtkHGmBeVM=
X-Received: by 2002:a17:90b:1a81:b0:1bc:c3e5:27b2 with SMTP id
 ng1-20020a17090b1a8100b001bcc3e527b2mr7173547pjb.20.1646337570337; Thu, 03
 Mar 2022 11:59:30 -0800 (PST)
MIME-Version: 1.0
References: <20220225234339.2386398-1-haoluo@google.com> <20220225234339.2386398-5-haoluo@google.com>
 <20220302194141.c4gvqz5v4mmmbwsv@ast-mbp.dhcp.thefacebook.com> <CA+khW7iRP8b69usnAy_j4hrYE-U0hC4Rv65K5m4wuP5ArnWsEQ@mail.gmail.com>
In-Reply-To: <CA+khW7iRP8b69usnAy_j4hrYE-U0hC4Rv65K5m4wuP5ArnWsEQ@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 3 Mar 2022 11:59:19 -0800
Message-ID: <CAADnVQJO2z2_ZO24zdAiSmoSMuhM4oeRcvAkxXiOy7ZV=R2frA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 4/9] bpf: Introduce sleepable tracepoints
To:     Hao Luo <haoluo@google.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Joe Burton <jevburton.kernel@gmail.com>,
        Tejun Heo <tj@kernel.org>, Josh Don <joshdon@google.com>,
        Stanislav Fomichev <sdf@google.com>, bpf <bpf@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 3, 2022 at 11:37 AM Hao Luo <haoluo@google.com> wrote:
>
> On Wed, Mar 2, 2022 at 11:41 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Fri, Feb 25, 2022 at 03:43:34PM -0800, Hao Luo wrote:
> > > diff --git a/include/linux/tracepoint-defs.h b/include/linux/tracepoint-defs.h
> > > index e7c2276be33e..c73c7ab3680e 100644
> > > --- a/include/linux/tracepoint-defs.h
> > > +++ b/include/linux/tracepoint-defs.h
> > > @@ -51,6 +51,7 @@ struct bpf_raw_event_map {
> > >       void                    *bpf_func;
> > >       u32                     num_args;
> > >       u32                     writable_size;
> > > +     u32                     sleepable;
> >
> > It increases the size for all tracepoints.
> > See BPF_RAW_TP in include/asm-generic/vmlinux.lds.h
> > Please switch writeable_size and sleepable to u16.
>
> No problem.
>
> > >
> > > -static const struct bpf_func_proto *
> > > -syscall_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
> > > +/* Syscall helpers that are also allowed in sleepable tracing prog. */
> > > +const struct bpf_func_proto *
> > > +tracing_prog_syscall_func_proto(enum bpf_func_id func_id,
> > > +                             const struct bpf_prog *prog)
> > >  {
> > >       switch (func_id) {
> > >       case BPF_FUNC_sys_bpf:
> > >               return &bpf_sys_bpf_proto;
> > > -     case BPF_FUNC_btf_find_by_name_kind:
> > > -             return &bpf_btf_find_by_name_kind_proto;
> > >       case BPF_FUNC_sys_close:
> > >               return &bpf_sys_close_proto;
> > > -     case BPF_FUNC_kallsyms_lookup_name:
> > > -             return &bpf_kallsyms_lookup_name_proto;
> > >       case BPF_FUNC_mkdir:
> > >               return &bpf_mkdir_proto;
> > >       case BPF_FUNC_rmdir:
> > >               return &bpf_rmdir_proto;
> > >       case BPF_FUNC_unlink:
> > >               return &bpf_unlink_proto;
> > > +     default:
> > > +             return NULL;
> > > +     }
> > > +}
> >
> > If I read this correctly the goal is to disallow find_by_name_kind
> > and lookup_name from sleepable tps. Why? What's the harm?
>
> A couple of thoughts, please correct me if they don't make sense. I
> may think too much.
>
> 1. The very first reason is, I don't know the use case of them in
> tracing. So I think I can leave them right now and add them later if
> the maintainers want them.
>
> 2. A related question is, do we actually want all syscall helpers to
> be in sleepable tracing? Some helpers may cause re-entering the
> tracepoints. For a hypothetical example, if we call mkdir while
> tracing some tracepoints in vfs_mkdir. Do we have protection for this?

If we go with noinline weak nop function approach then we will
get recursion protection for free. All trampoline powered progs have it.
Both sleepable and not.

> Another potential problem is about lookup_name in particular,
> sleepable_tracing could be triggered by any user, will lookup_name
> leak kernel addresses to users in some way? The filesystem helpers
> have some basic perm checks, I would think it's relatively safer.

The tracepoint may be triggerable by any user, but the sleepable
tp bpf prog will be loaded with cap_perfmon permissions, so it has
the rights to read anything.
So I don't see any concerns with enabling lookup_name to both
syscall bpf prog and tp progs.
