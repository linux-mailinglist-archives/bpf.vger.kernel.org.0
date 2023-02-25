Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE5906A2571
	for <lists+bpf@lfdr.de>; Sat, 25 Feb 2023 01:20:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjBYAUn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Feb 2023 19:20:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjBYAUm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Feb 2023 19:20:42 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86929703A8
        for <bpf@vger.kernel.org>; Fri, 24 Feb 2023 16:20:40 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id o15so1388571edr.13
        for <bpf@vger.kernel.org>; Fri, 24 Feb 2023 16:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=D1/zjuObshUH0BGSwrK8VVQACYErTtQ7ngYjZMbAgpU=;
        b=Yn1P6/tGfucx0vSdC5WdS/Li4ACPg9wRGkEmXO9SycsXNtVz5nHKayhiNqyaVsNfV7
         58ah5ko66x7L0petreml1U4lUZWMiO09Q1Ytnd8CmC/OGO8W22XKImY5ne3sw4F3pW1C
         rP50FhyIyvaEhN1GcFyB3KSO17k9vGDqnQ7cyQCz2jhE7jgtnk18fvctJ+ROajPU8zdl
         tYDNIwRiihUN41FVJjWPZC8cQjMP2pCYMIEP0piz9uaLCbluCjTvuP6dOOPEENzrO+MR
         /LJJavNNsrDRI1iulu/uNBlKkjVc9PZZDYLzwruo5uO5HWf2HEjBWywGnQqf+VSCWyvM
         59IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D1/zjuObshUH0BGSwrK8VVQACYErTtQ7ngYjZMbAgpU=;
        b=az6cIblmWt4m1sb74/yxdpBY0M7zLPG6VEilcUh0e8MYrw3oqPqvbbHYJhi2dgM28G
         3vePn3Jx/0NYU2GzfvpOqozHALfsCQl3Ubg5OisX5l7VGqNm542HNcNJ4jv4xaOmJ7Jq
         lecqcp9y20YNgK3aBuZCm1ZDe2gCF80xn71K6zYZk7R7afjupyt+Hz95cnzEJ8ZM+dme
         cnwgoZMQZHurErImxWtn4hkwXRr7m31ZHqgaDj+IVMmzvu2KplH609q55YFHhnMkRavE
         4tnu5leDD2hQS1VJWw8T2tWfPoHfH4KhGcm9qlttnuN63NaUHHmrfXYcRifs64aSWrzF
         x0Rw==
X-Gm-Message-State: AO0yUKXGIkjTUgqrflShltsnocm6k+vrrwhgTKWiBQbOoBvm0ToxEnwZ
        xlwuBnDVVO6a6JJQa4992R+bQZW5lcuJ+r7u6iU=
X-Google-Smtp-Source: AK7set+BIesMv+RFPp0ffu/D1Ge129M21k30AMtN0KGuSytDdGQC0Y0OXh7X6ZdcgX3OledMjaJua5HI9pKEo2YFmKk=
X-Received: by 2002:a50:d544:0:b0:4ad:6e3e:7da6 with SMTP id
 f4-20020a50d544000000b004ad6e3e7da6mr8369314edj.6.1677284438871; Fri, 24 Feb
 2023 16:20:38 -0800 (PST)
MIME-Version: 1.0
References: <87y1om25l4.fsf@oracle.com> <PH7PR21MB3878B8C1197ACE5318E332A8A3A89@PH7PR21MB3878.namprd21.prod.outlook.com>
 <87h6va230z.fsf@oracle.com>
In-Reply-To: <87h6va230z.fsf@oracle.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 24 Feb 2023 16:20:27 -0800
Message-ID: <CAADnVQKYGdF9mvp=MB1KgY1veX0qbsZ+SsULqu=GHS-C41pqgA@mail.gmail.com>
Subject: Re: [Bpf] [PATCH] bpf, docs: Document BPF insn encoding in term of
 stored bytes
To:     "Jose E. Marchesi" <jose.marchesi@oracle.com>
Cc:     Dave Thaler <dthaler=40microsoft.com@dmarc.ietf.org>,
        bpf <bpf@vger.kernel.org>, "bpf@ietf.org" <bpf@ietf.org>
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

On Fri, Feb 24, 2023 at 12:59 PM Jose E. Marchesi
<jose.marchesi@oracle.com> wrote:
>
>
> >> -----Original Message-----
> >> From: Bpf <bpf-bounces@ietf.org> On Behalf Of Jose E. Marchesi
> >> Sent: Friday, February 24, 2023 12:04 PM
> >> To: bpf <bpf@vger.kernel.org>
> >> Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>; bpf@ietf.org
> >> Subject: [Bpf] [PATCH] bpf, docs: Document BPF insn encoding in term of
> >> stored bytes
> >>
> >>
> >> This patch modifies instruction-set.rst so it documents the encoding of BPF
> >> instructions in terms of how the bytes are stored (be it in an ELF file or as
> >> bytes in a memory buffer to be loaded into the kernel or some other BPF
> >> consumer) as opposed to how the instruction looks like once loaded.
> >>
> >> This is hopefully easier to understand by implementors looking to generate
> >> and/or consume bytes conforming BPF instructions.
> >>
> >> The patch also clarifies that the unused bytes in a pseudo-instruction shall be
> >> cleared with zeros.
> >>
> >> Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>
> >> ---
> >>  Documentation/bpf/instruction-set.rst | 43 +++++++++++++--------------
> >>  1 file changed, 21 insertions(+), 22 deletions(-)
> >>
> >> diff --git a/Documentation/bpf/instruction-set.rst
> >> b/Documentation/bpf/instruction-set.rst
> >> index 01802ed9b29b..9b28c0e15bb6 100644
> >> --- a/Documentation/bpf/instruction-set.rst
> >> +++ b/Documentation/bpf/instruction-set.rst
> >> @@ -38,15 +38,13 @@ eBPF has two instruction encodings:
> >>  * the wide instruction encoding, which appends a second 64-bit immediate
> >> (i.e.,
> >>    constant) value after the basic instruction for a total of 128 bits.
> >>
> >> -The basic instruction encoding looks as follows for a little-endian processor,
> >> -where MSB and LSB mean the most significant bits and least significant bits,
> >> -respectively:
> >> +The fields conforming an encoded basic instruction are stored in the
> >> +following order:
> >>
> >> -=============  =======  =======  =======  ============
> >> -32 bits (MSB)  16 bits  4 bits   4 bits   8 bits (LSB)
> >> -=============  =======  =======  =======  ============
> >> -imm            offset   src_reg  dst_reg  opcode
> >> -=============  =======  =======  =======  ============
> >> +  opcode:8 src:4 dst:4 offset:16 imm:32 // In little-endian BPF.
> >> +  opcode:8 dst:4 src:4 offset:16 imm:32 // In big-endian BPF.
> >
> > Personally I find this notation harder to understand in general.
> > For example, it encodes (without explanation) the C language
> > assumption that "//" is a comment, ":" indicates a bit width,
> > and the fields are in order from most significate byte to least
> > significant byte.  The text before this change has no such
> > unexplained assumptions.
>
> The fields are not ordered from "most significative byte" to "least
> significative byte".  The fields are ordered as they are stored.  Thats
> the whole point of the patch.
>
> As for //, :N and | below, I think these signs are obvious enough to not
> require further explanation, but I wouldn't mind to use some other
> better notation, if you can suggest one. I am not a very graphical
> person myself.

We're using plenty of C lingvo in this doc including:
dst = dst ^ imm32
and
dst = (u32) ((u32) dst + (u32) src)

So I think '//' is fine to have without extra verbosity.

imo the patch is a nice improvement in readability.
The ldimm64 part is especially nice.
