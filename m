Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4894466854F
	for <lists+bpf@lfdr.de>; Thu, 12 Jan 2023 22:28:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240781AbjALV23 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Jan 2023 16:28:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234697AbjALV2D (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Jan 2023 16:28:03 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CCE78460A;
        Thu, 12 Jan 2023 13:07:16 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id cf18so41453122ejb.5;
        Thu, 12 Jan 2023 13:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Yi96tsdQR6WdP5GsKIXazABTTCV4uwO+W40vPdabGLI=;
        b=O+QDNRr8kwQzK7WmMnAXpuHQH1PZMeQrj0licS71OUJQMRBomMoDi3AmQzz8Lnc83N
         x+Mv7aWvrwGVwoHnLCcacSlxKMaR4wHkha+1+INzjhp0Yagto/KlW+sK0iJYCw9sIWIo
         4njF6TfQlfvMpl++f3aGEHCmjpqXaV9mBE6MR//WlXMhjtbaSzsGTP17+wvXyyU/DG7+
         QCGC9KHL+BOaCL+deAvdV4ikDEediQNLwppkf3rmONYmC51lp8O+MGtJ+/KD1P1zjGd6
         u3e02epWZTM06DBUdy1FXtAJ8Yl53l5qXXJZKcSsfs9bQRN3YNzEieKSAP0SDL2iBxBL
         qP1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yi96tsdQR6WdP5GsKIXazABTTCV4uwO+W40vPdabGLI=;
        b=i4AgYgeAThuiAB7QJzyNsLP0ziN+rPn8bM7ExkHoeFfhflWUQ9mx+eb2sL6CKfBbZ5
         lUOHQa4Jf7tSkkUmkHZYit3uXUQYbZQf2zDL+J88xue0J41fR95cfdCKCm91seRuatpz
         o2HEmbfXPxJyzhPTIQuGLB0+rJzzqVYAWGpLlcoYXCqtYBn3EVl12MGtYQgMhohw69Eq
         B0YFKRIuWOB1H6fYOKBSqM8FFaP3cToz6oTcT3A2Zz8Un1tgCeVgUjMmdjN+tzhD6Uow
         y7H+2rPYBwKxsVgTB2eLwppQviSBqkmUZvgufNWmBSfGD7eXPRGZGhmoM5zj4pwkOlUZ
         SpRw==
X-Gm-Message-State: AFqh2kpnZ9D9w+MLgP6zEFEGgC9cEdcq+LWFpOOmFcEkr+qbWv8P/mXT
        b6mtAAsNK5/Q/evUvxuQ3NDBntPev0huTYlatMP4bUpG
X-Google-Smtp-Source: AMrXdXvHyknXCPOG1Y++mFApOmYsZxlHbhzKNgms8atKRZ1ze2Wk2vlsO6N3Z+qoW+bToALTQsAAtxAemEQIwO9VCyY=
X-Received: by 2002:a17:907:3103:b0:864:dab4:760f with SMTP id
 wl3-20020a170907310300b00864dab4760fmr279928ejb.633.1673557634775; Thu, 12
 Jan 2023 13:07:14 -0800 (PST)
MIME-Version: 1.0
References: <20230109094247.1464856-1-imagedong@tencent.com>
 <504cc35a-74a8-751a-5899-186d7a0aff87@meta.com> <CADxym3bRciuyM1nYCrbaAwSMRJQvgV=hJFSLeiu9jysejPaTQQ@mail.gmail.com>
 <6c14e7ad-3b6d-4f88-64b8-8e3968d2b2e6@meta.com> <6455133c-87a2-1a0f-7da4-f8b99f02fc95@oracle.com>
In-Reply-To: <6455133c-87a2-1a0f-7da4-f8b99f02fc95@oracle.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 12 Jan 2023 13:07:03 -0800
Message-ID: <CAADnVQJRntdqa4uCHtTrQNAsgGS13DtNV-ue2wTdHQxiuLo_Yg@mail.gmail.com>
Subject: Re: [PATCH] libbpf: resolve kernel function name optimization for kprobe
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     Yonghong Song <yhs@meta.com>,
        Menglong Dong <menglong8.dong@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Menglong Dong <imagedong@tencent.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 12, 2023 at 2:20 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>
> On 12/01/2023 07:23, Yonghong Song wrote:
> >
> >
> > On 1/9/23 7:11 PM, Menglong Dong wrote:
> >> On Tue, Jan 10, 2023 at 4:29 AM Yonghong Song <yhs@meta.com> wrote:
> >>>
> >>>
> >>>
> >>> On 1/9/23 1:42 AM, menglong8.dong@gmail.com wrote:
> >>>> From: Menglong Dong <imagedong@tencent.com>
> >>>>
> >>>> The function name in kernel may be changed by the compiler. For example,
> >>>> the function 'ip_rcv_core' can be compiled to 'ip_rcv_core.isra.0'.
> >>>>
> >>>> This kind optimization can happen in any kernel function. Therefor, we
> >>>> should conside this case.
> >>>>
> >>>> If we failed to attach kprobe with a '-ENOENT', then we can lookup the
> >>>> kallsyms and check if there is a similar function end with '.xxx', and
> >>>> retry.
> >>>
> >>> This might produce incorrect result, so this approach won't work
> >>> for all .isra.0 cases. When a function name is changed from
> >>> <func> to <func>.isra.<num>, it is possible that compiler may have
> >>> make some changes to the arguments, e.g., removing one argument,
> >>> chaning a semantics of argument, etc. if bpf program still
> >>> uses the original function signature, the bpf program may
> >>> produce unexpected result.
> >>
> >> Oops, I wasn't aware of this part. Can we make this function disabled
> >> by default and offer an option to users to enable it? Such as:
> >>
> >>      bpf_object_adapt_sym(struct bpf_object *obj)
> >>
> >> In my case, kernel function rename is common, and I have to
> >> check all functions and do such adaptation before attaching
> >> my kprobe programs, which makes me can't use auto-attach.
> >>
> >> What's more, I haven't seen the arguments change so far, and
> >> maybe it's not a common case?
> >
> > I don't have statistics, but it happens. In general, if you
> > want to attach to a function like <foo>, but it has a variant
> > <foo>.isra.<num>, you probably should check assembly code
> > to ensure the parameter semantics not changed, and then
> > you can attach to kprobe function <foo>.isra.<num>, which
> > I assume current libbpf infrastructure should support it.
> > After you investigate all these <foo>.isra.<num> functions
> > and confirm their argument semantics won't change, you
> > could use kprobe multi to do attachment.
> >
>
> I crunched some numbers on this, and discovered out of ~1600
> .isra/.constprop functions, 76 had a missing argument. The patch series
> at [1] is a rough attempt to get pahole to spot these, and add
> BTF entries for each, where the BTF representation reflects
> reality by skipping optimized-out arguments. So for a function
> like
>
> static int ip6_nh_lookup_table(struct net *net, struct fib6_config *cfg,
>                                const struct in6_addr *gw_addr, u32 tbid,
>                                int flags, struct fib6_result *res);
>
> Examining the BTF representation using pahole from [1], we see
>
> int ip6_nh_lookup_table.isra.0(struct net *net, struct fib6_config *cfg, struct in6_addr *gw_addr, u32 tbid, int flags);
>
> Comparing to the definition, we see the last parameter is missing,
> i.e. the "struct fib6_result *" argument is missing. The calling pattern -
> where the callers have a struct fib6_result on the stack and pass a pointer -
> is reflected in late DWARF info which shows the argument is not actually
> passed as a register, but can be expressed as an offset relative to the current
> function stack (DW_OP_fbreg).
>
> This approach howvever introduces the problem that currently the kernel
> doesn't  allow a "." in a function name. We can fix that, but any BTF encoding
> that introduced optimized functions containing a  "." would have to be opt-in
> via a pahole option, so we do not generate invalid vmlinux BTF for kernels
> without that change.
>
> An alternative approach would be to simply encode .isra functions
> in BTF without the .isra suffix (i.e. using "function_name" not
> "function_name.isra"), only doing the BTF encoding if no arguments were
> optimized out - i.e. if the function signature matches expectations.
> The 76 functions with optimized-out parameters could simply be skipped.
> To me that feels like the simpler approach - it avoids issues
> with function name BTF encoding, and with that sort of model a
> loose-matching kallsyms approach - like that described here - could be used
> for kprobes and fentry/fexit. It also fits with the DWARF representation -
> the .isra suffixes are not present in DWARF representations of the function,
> only in the symbol table and kallsyms, so perhaps BTF should follow suit
> and not add the suffixes. What do you think?

Sounds like a great idea to me.
Addresses this issue in a clean way.
