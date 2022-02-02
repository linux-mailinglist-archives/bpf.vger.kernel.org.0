Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B20B64A77F4
	for <lists+bpf@lfdr.de>; Wed,  2 Feb 2022 19:32:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346593AbiBBSao (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Feb 2022 13:30:44 -0500
Received: from linux.microsoft.com ([13.77.154.182]:56588 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346674AbiBBSam (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Feb 2022 13:30:42 -0500
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
        by linux.microsoft.com (Postfix) with ESMTPSA id 69D1A20B8010;
        Wed,  2 Feb 2022 10:30:42 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 69D1A20B8010
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1643826642;
        bh=saUwzlBmQw7hsfFOi/x4+4YXpypfM/v+QZi+szh+Erk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=g8MLyghpydSh+CK2jMQTSrXhsn//Y0c3uHtI/JQefyjy58xhROhlmQrjZM3kM1tH8
         Nj59sVqulm+8CNGgUfF6SansldHxSUlzRcQnXiMNvPphufNatgsCGLsO0Eun7REomJ
         CukH/nVDGQmitpfRzs2XB7JW37cWN7xMluwbQgns=
Received: by mail-pj1-f41.google.com with SMTP id y5-20020a17090aca8500b001b8127e3d3aso315718pjt.3;
        Wed, 02 Feb 2022 10:30:42 -0800 (PST)
X-Gm-Message-State: AOAM531ItDtPZosOnTrlddhw/opomMedyzjlj+LjZizRYJrxZcCddJiZ
        qqoZwIvszodGZILnfKOeApRbqHWhYuRzhOcgUSk=
X-Google-Smtp-Source: ABdhPJyaFGsEEw9s97c2y9b6fB5mOpP0F8wWqK9mIrPFi3+1JqlEmjNySdCFNgf4wyMGxTNADv+bHRIMmcgAhdP5ZmU=
X-Received: by 2002:a17:90b:4c92:: with SMTP id my18mr9483017pjb.15.1643826641822;
 Wed, 02 Feb 2022 10:30:41 -0800 (PST)
MIME-Version: 1.0
References: <20211210172034.13614-1-mcroce@linux.microsoft.com>
 <CAADnVQJRVpL0HL=Lz8_e-ZU5y0WrQ_Z0KvQXF2w8rE660Jr62g@mail.gmail.com>
 <CAFnufp33Dm_5gffiFYQ+Maf4Bj9fE3WLMpFf3cJ=F5mm71mTEQ@mail.gmail.com>
 <CAADnVQ+OeO=f1rzv_F9HFQmJCcJ7=FojkOuZWvx7cT-XLjVDcQ@mail.gmail.com>
 <CAFnufp3c3pdxu=hse4_TdFU_UZPeQySGH16ie13uTT=3w-TFjA@mail.gmail.com>
 <CAFnufp35YbxhbQR7stq39WOhAZm4LYHu6FfYBeHJ8-xRSo7TnQ@mail.gmail.com>
 <177da568-8410-36d6-5f95-c5792ba47d62@fb.com> <CAADnVQJZvgpo-VjUCBL8YZy8J+s7O0mv5FW+5sx8NK84Lm6FUQ@mail.gmail.com>
 <CAFnufp3ybOFMY=ObZFvbmr+c70CPUrL2uYp1oZQmffQBTyVy_A@mail.gmail.com>
 <CAADnVQ+cvD2rwa-hRQP8agj8=SXuun3dv-PZpK5=kJ2Ea_0KCg@mail.gmail.com>
 <CAFnufp3MHW9su8pouUqg__DToSHEx=HZccrpR49hSdsuEnpW0g@mail.gmail.com> <CAADnVQL8D0cBixtqnOok621gfXnBs4sZSTSTKBodrtRzwBFsHQ@mail.gmail.com>
In-Reply-To: <CAADnVQL8D0cBixtqnOok621gfXnBs4sZSTSTKBodrtRzwBFsHQ@mail.gmail.com>
From:   Matteo Croce <mcroce@linux.microsoft.com>
Date:   Wed, 2 Feb 2022 19:30:05 +0100
X-Gmail-Original-Message-ID: <CAFnufp0FTgQ0s_8E5ve+qad4ALMqFatzBK7_OeHSPBskHfqbiw@mail.gmail.com>
Message-ID: <CAFnufp0FTgQ0s_8E5ve+qad4ALMqFatzBK7_OeHSPBskHfqbiw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: limit bpf_core_types_are_compat() recursion
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Jan 29, 2022 at 2:11 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Jan 28, 2022 at 4:36 PM Matteo Croce <mcroce@linux.microsoft.com> wrote:
> >
> > On Fri, Jan 28, 2022 at 9:09 PM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Fri, Jan 28, 2022 at 10:51 AM Matteo Croce
> > > <mcroce@linux.microsoft.com> wrote:
> > > >
> > > > On Fri, Jan 28, 2022 at 6:31 AM Alexei Starovoitov
> > > > <alexei.starovoitov@gmail.com> wrote:
> > > > >
> > > > > On Mon, Dec 20, 2021 at 10:34 PM Yonghong Song <yhs@fb.com> wrote:
> > > > > >
> > > > > >
> > > > > > https://reviews.llvm.org/D116063 improved the error message as below
> > > > > > to make it a little bit more evident what is the problem:
> > > > > >
> > > > > > $ clang -target bpf -O2 -g -c bug.c
> > > > > >
> > > > > > fatal error: error in backend: SubroutineType not supported for
> > > > > > BTF_TYPE_ID_REMOTE reloc
> > > > >
> > > > > Hi Matteo,
> > > > >
> > > > > Are you still working on a test?
> > > > > What's a timeline to repost the patch set?
> > > > >
> > > > > Thanks!
> > > >
> > > > Hi Alexei,
> > > >
> > > > The change itself is ready, I'm just stuck at writing a test which
> > > > will effectively calls __bpf_core_types_are_compat() with some
> > > > recursion.
> > > > I guess that I have to generate a BTF_KIND_FUNC_PROTO type somehow, so
> > > > __bpf_core_types_are_compat() is called again to check the prototipe
> > > > arguments type.
> > > > I tried with these two, with no luck:
> > > >
> > > > // 1
> > > > typedef int (*func_proto_typedef)(struct sk_buff *);
> > > > bpf_core_type_exists(func_proto_typedef);
> > > >
> > > > // 2
> > > > void func_proto(int, unsigned int);
> > > > bpf_core_type_id_kernel(func_proto);
> > > >
> > > > Which is a simple way to generate a BTF_KIND_FUNC_PROTO BTF field?
> > >
> > > What do you mean 'no luck'?
> > > Have you tried what progs/test_core_reloc_type_id.c is doing?
> > > typedef int (*func_proto_typedef)(long);
> > > bpf_core_type_id_kernel(func_proto_typedef);
> > >
> > > Without macros:
> > > typedef int (*func_proto_typedef)(long);
> > >
> > > int test() {
> > >    return __builtin_btf_type_id(*(typeof(func_proto_typedef) *)0, 1);
> > > }
> > > int test2() {
> > >    return __builtin_preserve_type_info(*(typeof(func_proto_typedef) *)0, 0);
> > > }
> > >
> > >
> > > compiles fine and generates relos.
> >
> > Yes, I tried that one.
> > We reach bpf_core_apply_relo_insn() but not bpf_core_spec_match(),
> > since cands->len is 0.
> >
> > [   16.424821] bpf_core_apply_relo_insn:1202 cands->len: 0
> >
> > That's a very simple raw_tracepoint/sys_enter program:
>
> Did you forget to attach it ?
>
> If it's doing bpf_core_type_id_kernel(func_proto_typedef)
> then, of course, cands->len will be zero.
> You need to add this typedef to bpf_testmod first.
> Then use two typedef flavors: func_proto_typedef___match
> and func_proto_typedef___doesnt_match
> with matching and mismatching prototypes, so
> both can call into bpf_core_types_are_compat() and
> return different results.
> Then build on top to test recursion.

Hi,

I'm able to trigger __bpf_core_types_are_compat() recursion now.
What do you think to generate also a prototype which needs 3 recursion
calls, thus invalid, and check that it returns error?
e.g.

typedef int (*func_proto_typedef)(long);
typedef int (*func_proto_typedef___of)(func_proto_typedef);

func_proto_typedef funcp = NULL;
func_proto_typedef___of funcp_of = NULL;

this gives:

[  190.875387] bpf_core_apply_relo_insn:1200 cands->len: 3
[  190.875435] __bpf_core_types_are_compat:6798 level: 2
[  190.875479] __bpf_core_types_are_compat:6798 level: 1
[  190.875506] bpf_core_types_are_compat:6896: ret: 0
[  190.875541] __bpf_core_types_are_compat:6798 level: 2
[  190.875570] __bpf_core_types_are_compat:6798 level: 1
[  190.875599] bpf_core_types_are_compat:6896: ret: 0
[  190.875629] __bpf_core_types_are_compat:6798 level: 2
[  190.875659] __bpf_core_types_are_compat:6798 level: 1
[  190.875686] bpf_core_types_are_compat:6896: ret: -22
failed to open and/or load BPF object

-- 
per aspera ad upstream
