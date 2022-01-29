Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39C214A2AE5
	for <lists+bpf@lfdr.de>; Sat, 29 Jan 2022 02:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344784AbiA2BLs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Jan 2022 20:11:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiA2BLr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 Jan 2022 20:11:47 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D22BC061714;
        Fri, 28 Jan 2022 17:11:46 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id x11so7711918plg.6;
        Fri, 28 Jan 2022 17:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sKsBVhQwSlJcRatjipRMtQLnHaf6lN3tRXCvoF5/r20=;
        b=puOMkZ0UFGv9hyGOgycf4HKKTdfZqIGO1mTa/jfGvU4s52IdOFDx07S+Y+hkfcroi5
         wa8t9B+tb1Mdxsl9DSHh57cjQLi8qZ8iY0IXkAEhw914wvy/cPM9+Zhz1vqB1YtfhWbV
         D1dDGEMpDPTc8AwnDiBMYXs3i429EAI1d0x6GhgylerxkcMn+3EP+/2MEsldY8RjW6Im
         xEJkGOEtdmHkH80zc2weJ9eMATeLBwGpkKhpI+0ffNn/BT4P9uXRAcO4owmMcon1Nbrf
         9MqewY7KWoLlWuE0MHuvIJIQm/62c+wrFiVoKa9rj2npQ3z/OBJJW/iN/zAX6puCSxeR
         4rtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sKsBVhQwSlJcRatjipRMtQLnHaf6lN3tRXCvoF5/r20=;
        b=gzZT1ydAZ97oWjMqhlGta1MY3Yrpd+yKWn8vBUXGxHinC4WVQ50c010+ZFd3a3WWdN
         qaU2WEJ0niE7AT+Fcf6c7V09fBxSXkUD/8OcDJ5CV/o148XJOr64imXIjg8LtMGCa4yR
         +NIXIoJ8pG4/XytNRoHTFgjrQRvSSeRltS7U8qn19MFfAcxX+zm1OioF5BmbR5A/wJCH
         DRGioeLCqAZ7KrI64sj3qkynCMTG8qyn5QwQemK1jepgHdMxpRRJY5645jn2AQAviMoe
         U7baBw3Cw4tpP1I5wDCapkrteWZJ56EyTNSUvLumLPQfylU5taFWVOwb0ZzFb2+kcvk1
         FzOQ==
X-Gm-Message-State: AOAM532tF9Gu5724+ttvxYCCDueXqPkgkpug8FROPmL8Tt9u+Rgxchf2
        LKNzGUSK6yzoRXkKfVnP4WwWr6YfrWIGrk6/KLg=
X-Google-Smtp-Source: ABdhPJwpZJefhaXw6b9jI+aK36Vigr5rNrt3zdJ8hyeB/f3ZBlfA/8bmw/aLvPYYd7zdgrbxJhmkE5wrT7fcFfxdJF8=
X-Received: by 2002:a17:902:e54c:: with SMTP id n12mr10841591plf.78.1643418705879;
 Fri, 28 Jan 2022 17:11:45 -0800 (PST)
MIME-Version: 1.0
References: <20211210172034.13614-1-mcroce@linux.microsoft.com>
 <CAADnVQJRVpL0HL=Lz8_e-ZU5y0WrQ_Z0KvQXF2w8rE660Jr62g@mail.gmail.com>
 <CAFnufp33Dm_5gffiFYQ+Maf4Bj9fE3WLMpFf3cJ=F5mm71mTEQ@mail.gmail.com>
 <CAADnVQ+OeO=f1rzv_F9HFQmJCcJ7=FojkOuZWvx7cT-XLjVDcQ@mail.gmail.com>
 <CAFnufp3c3pdxu=hse4_TdFU_UZPeQySGH16ie13uTT=3w-TFjA@mail.gmail.com>
 <CAFnufp35YbxhbQR7stq39WOhAZm4LYHu6FfYBeHJ8-xRSo7TnQ@mail.gmail.com>
 <177da568-8410-36d6-5f95-c5792ba47d62@fb.com> <CAADnVQJZvgpo-VjUCBL8YZy8J+s7O0mv5FW+5sx8NK84Lm6FUQ@mail.gmail.com>
 <CAFnufp3ybOFMY=ObZFvbmr+c70CPUrL2uYp1oZQmffQBTyVy_A@mail.gmail.com>
 <CAADnVQ+cvD2rwa-hRQP8agj8=SXuun3dv-PZpK5=kJ2Ea_0KCg@mail.gmail.com> <CAFnufp3MHW9su8pouUqg__DToSHEx=HZccrpR49hSdsuEnpW0g@mail.gmail.com>
In-Reply-To: <CAFnufp3MHW9su8pouUqg__DToSHEx=HZccrpR49hSdsuEnpW0g@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 28 Jan 2022 17:11:34 -0800
Message-ID: <CAADnVQL8D0cBixtqnOok621gfXnBs4sZSTSTKBodrtRzwBFsHQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: limit bpf_core_types_are_compat() recursion
To:     Matteo Croce <mcroce@linux.microsoft.com>
Cc:     Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 28, 2022 at 4:36 PM Matteo Croce <mcroce@linux.microsoft.com> wrote:
>
> On Fri, Jan 28, 2022 at 9:09 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Fri, Jan 28, 2022 at 10:51 AM Matteo Croce
> > <mcroce@linux.microsoft.com> wrote:
> > >
> > > On Fri, Jan 28, 2022 at 6:31 AM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > On Mon, Dec 20, 2021 at 10:34 PM Yonghong Song <yhs@fb.com> wrote:
> > > > >
> > > > >
> > > > > https://reviews.llvm.org/D116063 improved the error message as below
> > > > > to make it a little bit more evident what is the problem:
> > > > >
> > > > > $ clang -target bpf -O2 -g -c bug.c
> > > > >
> > > > > fatal error: error in backend: SubroutineType not supported for
> > > > > BTF_TYPE_ID_REMOTE reloc
> > > >
> > > > Hi Matteo,
> > > >
> > > > Are you still working on a test?
> > > > What's a timeline to repost the patch set?
> > > >
> > > > Thanks!
> > >
> > > Hi Alexei,
> > >
> > > The change itself is ready, I'm just stuck at writing a test which
> > > will effectively calls __bpf_core_types_are_compat() with some
> > > recursion.
> > > I guess that I have to generate a BTF_KIND_FUNC_PROTO type somehow, so
> > > __bpf_core_types_are_compat() is called again to check the prototipe
> > > arguments type.
> > > I tried with these two, with no luck:
> > >
> > > // 1
> > > typedef int (*func_proto_typedef)(struct sk_buff *);
> > > bpf_core_type_exists(func_proto_typedef);
> > >
> > > // 2
> > > void func_proto(int, unsigned int);
> > > bpf_core_type_id_kernel(func_proto);
> > >
> > > Which is a simple way to generate a BTF_KIND_FUNC_PROTO BTF field?
> >
> > What do you mean 'no luck'?
> > Have you tried what progs/test_core_reloc_type_id.c is doing?
> > typedef int (*func_proto_typedef)(long);
> > bpf_core_type_id_kernel(func_proto_typedef);
> >
> > Without macros:
> > typedef int (*func_proto_typedef)(long);
> >
> > int test() {
> >    return __builtin_btf_type_id(*(typeof(func_proto_typedef) *)0, 1);
> > }
> > int test2() {
> >    return __builtin_preserve_type_info(*(typeof(func_proto_typedef) *)0, 0);
> > }
> >
> >
> > compiles fine and generates relos.
>
> Yes, I tried that one.
> We reach bpf_core_apply_relo_insn() but not bpf_core_spec_match(),
> since cands->len is 0.
>
> [   16.424821] bpf_core_apply_relo_insn:1202 cands->len: 0
>
> That's a very simple raw_tracepoint/sys_enter program:

Did you forget to attach it ?

If it's doing bpf_core_type_id_kernel(func_proto_typedef)
then, of course, cands->len will be zero.
You need to add this typedef to bpf_testmod first.
Then use two typedef flavors: func_proto_typedef___match
and func_proto_typedef___doesnt_match
with matching and mismatching prototypes, so
both can call into bpf_core_types_are_compat() and
return different results.
Then build on top to test recursion.
