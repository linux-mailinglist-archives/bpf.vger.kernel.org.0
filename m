Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51F3A4A005D
	for <lists+bpf@lfdr.de>; Fri, 28 Jan 2022 19:52:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237539AbiA1Sv7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Jan 2022 13:51:59 -0500
Received: from linux.microsoft.com ([13.77.154.182]:45742 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbiA1Sv6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 Jan 2022 13:51:58 -0500
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
        by linux.microsoft.com (Postfix) with ESMTPSA id 9399420B6C61;
        Fri, 28 Jan 2022 10:51:58 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9399420B6C61
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1643395918;
        bh=jUz1vj3LTc4nxky/K07D6wr8fvEcSpU5/ssFz4z4Z1Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lvbGvOvrQkNC8NCKPz1Tr0PkCbQ0YOisGb+WePML4fTeR5kF6MJP5BBrDDIz8jDce
         XfydGHauwuFBYflYXCDPql8GE7Yx418XXlUdMv/t/+gprQ8n9NFabrRQY8ENPIGjSq
         Dqpqu22Ta2GPknyCpSHrmUziFjKaPMmfZKGxOuNQ=
Received: by mail-pl1-f171.google.com with SMTP id c9so6895311plg.11;
        Fri, 28 Jan 2022 10:51:58 -0800 (PST)
X-Gm-Message-State: AOAM532p/zmu9vWHqJ1pmCoVaNSv4zmuHBXu8HNFwVoVY6d//TuPxS64
        HLmV/l5cXOp7NzaOigPYull59qR7CN1PB0qzp+4=
X-Google-Smtp-Source: ABdhPJyXDI9twZ31dbqy14P/uFAhzQvWl8ehe9Ifkthejo3c3swvZgsDFKoH1rBIu7s6RRrPOhBpvpEOAFTFcZT7iIE=
X-Received: by 2002:a17:902:e891:: with SMTP id w17mr9523373plg.33.1643395918172;
 Fri, 28 Jan 2022 10:51:58 -0800 (PST)
MIME-Version: 1.0
References: <20211210172034.13614-1-mcroce@linux.microsoft.com>
 <CAADnVQJRVpL0HL=Lz8_e-ZU5y0WrQ_Z0KvQXF2w8rE660Jr62g@mail.gmail.com>
 <CAFnufp33Dm_5gffiFYQ+Maf4Bj9fE3WLMpFf3cJ=F5mm71mTEQ@mail.gmail.com>
 <CAADnVQ+OeO=f1rzv_F9HFQmJCcJ7=FojkOuZWvx7cT-XLjVDcQ@mail.gmail.com>
 <CAFnufp3c3pdxu=hse4_TdFU_UZPeQySGH16ie13uTT=3w-TFjA@mail.gmail.com>
 <CAFnufp35YbxhbQR7stq39WOhAZm4LYHu6FfYBeHJ8-xRSo7TnQ@mail.gmail.com>
 <177da568-8410-36d6-5f95-c5792ba47d62@fb.com> <CAADnVQJZvgpo-VjUCBL8YZy8J+s7O0mv5FW+5sx8NK84Lm6FUQ@mail.gmail.com>
In-Reply-To: <CAADnVQJZvgpo-VjUCBL8YZy8J+s7O0mv5FW+5sx8NK84Lm6FUQ@mail.gmail.com>
From:   Matteo Croce <mcroce@linux.microsoft.com>
Date:   Fri, 28 Jan 2022 19:51:22 +0100
X-Gmail-Original-Message-ID: <CAFnufp3ybOFMY=ObZFvbmr+c70CPUrL2uYp1oZQmffQBTyVy_A@mail.gmail.com>
Message-ID: <CAFnufp3ybOFMY=ObZFvbmr+c70CPUrL2uYp1oZQmffQBTyVy_A@mail.gmail.com>
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

On Fri, Jan 28, 2022 at 6:31 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Dec 20, 2021 at 10:34 PM Yonghong Song <yhs@fb.com> wrote:
> >
> >
> > https://reviews.llvm.org/D116063 improved the error message as below
> > to make it a little bit more evident what is the problem:
> >
> > $ clang -target bpf -O2 -g -c bug.c
> >
> > fatal error: error in backend: SubroutineType not supported for
> > BTF_TYPE_ID_REMOTE reloc
>
> Hi Matteo,
>
> Are you still working on a test?
> What's a timeline to repost the patch set?
>
> Thanks!

Hi Alexei,

The change itself is ready, I'm just stuck at writing a test which
will effectively calls __bpf_core_types_are_compat() with some
recursion.
I guess that I have to generate a BTF_KIND_FUNC_PROTO type somehow, so
__bpf_core_types_are_compat() is called again to check the prototipe
arguments type.
I tried with these two, with no luck:

// 1
typedef int (*func_proto_typedef)(struct sk_buff *);
bpf_core_type_exists(func_proto_typedef);

// 2
void func_proto(int, unsigned int);
bpf_core_type_id_kernel(func_proto);

Which is a simple way to generate a BTF_KIND_FUNC_PROTO BTF field?

Regards,
-- 
per aspera ad upstream
