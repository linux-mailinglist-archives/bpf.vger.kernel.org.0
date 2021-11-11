Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A31F844CF39
	for <lists+bpf@lfdr.de>; Thu, 11 Nov 2021 02:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232816AbhKKBuQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Nov 2021 20:50:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232723AbhKKBuQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Nov 2021 20:50:16 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD6BC061766
        for <bpf@vger.kernel.org>; Wed, 10 Nov 2021 17:47:28 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id v20so4500116plo.7
        for <bpf@vger.kernel.org>; Wed, 10 Nov 2021 17:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AtBTFiy71hsD0821NhxHVyTBZ661/Kn40KuRVNo8yZY=;
        b=o5nqb3tLpYD5r5qPR35I+dXehN+HUmU7F/WUQWKzadq4uF96HkDhH0DAriW21ZfXlx
         pDn4GS8BQxRvIl8R5PkT7f5uxQYIyfMjtqgIT58CJciVpB8ODVuMyl5j0/HG9etyBcI8
         0EjRsmhmaaCSWdNC2w69+gpwkTe5RRfYX0fP9icc1SOT3Nv9CZUBKDtUVY4+jZQC+ef9
         nVF9rzmWRzZxvnI9HIKySY5uknXJud+jeqjGLo/G4r/Y+0Ls23HKic0RnHQmsnHjeDpU
         nUlTxWr8v1qZA8t6s47MDUbugY0zb/ktUSiSt24kQ/lm7T/00SWbPpB4Aw9apB2Db+GF
         mWdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AtBTFiy71hsD0821NhxHVyTBZ661/Kn40KuRVNo8yZY=;
        b=mDSA4DxJt9VnOCpkhkwVqEW7qofIJXOpKFFgmuPEU9nJF7UXMIVTMKZq02Z84J0Znm
         wwwzPpAfosp7lzdTsjeR/Mstb/n2Cck9X/3m5q1JRjxtnB1ak4OvC+EPWzmd6zN8e3MZ
         24y5eAeT1+Dm/DDoip9SbMrSOP8VEsCDP02T3RXa+DFPeElw+bb47PkxaKtdVT5sPgcy
         qkyX1avhAkpHYtl2zEJLQi6iKwqL0Y3KFPWiyTTHBb1mb0jbolXvdohw+cLIUJZYZsV8
         ekYWxy89FKXDp7N8SLbICkEicMghgSTXeSo6z9NWwuf8eLwlwPY8vcGpT6RiHD8PjRPq
         2GOA==
X-Gm-Message-State: AOAM530NROsWJcETv1Fp/i/QMLNljWiWd7tzAY72n+96Bk5VaycI4+cO
        AXcRDY/GvWinRUYirdlCXO/fA0MjY4MWwLnLn04=
X-Google-Smtp-Source: ABdhPJxFrRT9oaRqpFnE8aUpOht/Pu6E6/n0obd1EF833mDEOplt07X4VJNLUbkI2EXG6uJ7KxO5SiXsQlbWbjkzIOg=
X-Received: by 2002:a17:90a:17a5:: with SMTP id q34mr22011964pja.122.1636595247564;
 Wed, 10 Nov 2021 17:47:27 -0800 (PST)
MIME-Version: 1.0
References: <20211110051940.367472-1-yhs@fb.com> <20211110052805.qds3qzhabhdr3ah4@ast-mbp.dhcp.thefacebook.com>
 <d2546d58-67ee-0aee-5741-113f0583365b@fb.com> <CAADnVQLeW3s2Dx8+t8ajt=H3r-r8x40wFF18ia+wMbv6WYqdnw@mail.gmail.com>
 <69e9af56-02d8-1ec6-637c-80666788dc08@fb.com>
In-Reply-To: <69e9af56-02d8-1ec6-637c-80666788dc08@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 10 Nov 2021 17:47:16 -0800
Message-ID: <CAADnVQJxML8BUU7O=gEJpEpdRJ1bf_3EhAUzz2SAqUO3hpjj8g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 00/10] Support BTF_KIND_TYPE_TAG for btf_type_tag attributes
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Jose E . Marchesi" <jose.marchesi@oracle.com>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 10, 2021 at 9:04 AM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 11/10/21 8:40 AM, Alexei Starovoitov wrote:
> > On Tue, Nov 9, 2021 at 10:26 PM Yonghong Song <yhs@fb.com> wrote:
> >>
> >>
> >>
> >> On 11/9/21 9:28 PM, Alexei Starovoitov wrote:
> >>> On Tue, Nov 09, 2021 at 09:19:40PM -0800, Yonghong Song wrote:
> >>>> LLVM patches ([1] for clang, [2] and [3] for BPF backend)
> >>>> added support for btf_type_tag attributes. This patch
> >>>> added support for the kernel.
> >>>>
> >>>> The main motivation for btf_type_tag is to bring kernel
> >>>> annotations __user, __rcu etc. to btf. With such information
> >>>> available in btf, bpf verifier can detect mis-usages
> >>>> and reject the program. For example, for __user tagged pointer,
> >>>> developers can then use proper helper like bpf_probe_read_kernel()
> >>>> etc. to read the data.
> >>>
> >>> +#define __tag1 __attribute__((btf_type_tag("tag1")))
> >>> +#define __tag2 __attribute__((btf_type_tag("tag2")))
> >>> +
> >>> +struct btf_type_tag_test {
> >>> +       int __tag1 * __tag1 __tag2 *p;
> >>> +} g;
> >>>
> >>> Can we build the kernel with the latest clang and get __user in BTF ?
> >>
> >> Not yet. The following are the steps:
> >>     1. land this patch set in the kernel
> >>     2. sync to libbpf repo.
> >>     3. pahole sync with libbpf repo, and pahole convert btf_type_tag
> >>        in llvm to BTF
> >>     4. another kernel patch to define __user as
> >>        __attribute__((btf_type_tag("user")))
> >> and then we will get __user in vmlinux BTF.
> >
> > Makes sense. I was wondering whether clang can handle
> > the whole kernel source code with
> > #define __user __attribute__((btf_type_tag("user")))
> > Steps 1,2,3 are necessary to make use of it,
> > but step 4 can be tried out already?
>
> Yes, you try clang -> vmlinux dwarf part of step 4 with
> the following kernel hack:
>
> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> index 05ceb2e92b0e..30e199c30a53 100644
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -32,7 +32,7 @@ static inline void __chk_io_ptr(const volatile void
> __iomem *ptr) { }
>   # ifdef STRUCTLEAK_PLUGIN
>   #  define __user       __attribute__((user))
>   # else
> -#  define __user
> +#  define __user       __attribute__((btf_type_tag("user")))
>   # endif
>   # define __iomem
>   # define __percpu

I've tried the latest LLVM with the above diff and it seems to work!

$ llvm-dwarfdump kernel/bpf/built-in.a |grep -3 btf_type_tag|head
0x00003ace:   DW_TAG_pointer_type

0x00003acf:     DW_TAG_LLVM_annotation
                  DW_AT_name    ("btf_type_tag")
                  DW_AT_const_value    ("user")


Nice!
Didn't notice any warnings. Great.
