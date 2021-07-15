Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 370F13C96EE
	for <lists+bpf@lfdr.de>; Thu, 15 Jul 2021 06:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232572AbhGOEL7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Jul 2021 00:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbhGOEL6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 15 Jul 2021 00:11:58 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30CEBC06175F
        for <bpf@vger.kernel.org>; Wed, 14 Jul 2021 21:09:06 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id i5so7430659lfe.2
        for <bpf@vger.kernel.org>; Wed, 14 Jul 2021 21:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=4Gs9vJw/+dYcphNpbIIlmg0+5uBWdEfH2u8t1plP4s4=;
        b=SjGgvNcm0gvb9VCUQ2PKkRwohT0PnkpWfFU8atTumWiWbz+ilylm67f5DNT5O23MOP
         2RyPyxVWS5XWtvIRyGunoVrFrNlFR40YacDZYgL/bTiCpkajRQdOawujzw86OHuWASIr
         zs2Htgv0rf5KLkGy1ztNgOftTIsgDGBfiy/GXz9objoDE94NXFIZZIDhZCbGrUEl5zKa
         lthZaKqXdmmj4Ipxpdc0cn7nUGv+HjxBU0iGUavNa1R1JxaVX6DbBRu0t2L9/i6Hjn7W
         q7a+uXnxKZ6KR2NClSoZP2+8snZr2xSh+qmoaokIejlL3ZD49WYtPpdWzs9hg/v7Eu7o
         N8PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=4Gs9vJw/+dYcphNpbIIlmg0+5uBWdEfH2u8t1plP4s4=;
        b=VNH5Hiz+RCy4Rys7LdrLLc1K9aFf+3x9Rq7s9xreofsPcHYoAYzGORP4tw3kZcEUtv
         uwYlSpPWetp+uWk2/mljH2KSp1YWOimEkzLmHRzZS92htfrvhxZdB8hHfb5jLdXKAtgm
         jKG3NBatmveefBD8M8bj2iUXeldh49dylIMpnoJcJc+IP9b0tPCxtn9dsYVMSVCSrIQV
         aUg+RwNE01JvqiLv+pYioCjGEHHM/qRif7lTCJPb4GZdIH2Lll3IbmI24TMEiIP5sob7
         edEL96ntVzUQxPjqLopDZPkLkrBV3/u2J7fxm6uQ05+nU+7RFbTUh5Lg9ydOHwz4aQtj
         ydHQ==
X-Gm-Message-State: AOAM53319mcbTkPQ3nDQPg/j2SW5Jn9QS1DLTbBJ3JJhRZ3ofBRadje+
        G0E4D2xR815PQzpdDUGBHgkqaSDm9GOZ64Upohk=
X-Google-Smtp-Source: ABdhPJz7WPuQgqUmko5yjuxAgzHsB13SqNLb66TeLhOHZ3EkFuS5Z6xgkJK44U6P1w49Q92tPytjGHgF/8K0dut+Ph4=
X-Received: by 2002:ac2:5ddb:: with SMTP id x27mr1475484lfq.539.1626322144425;
 Wed, 14 Jul 2021 21:09:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAJg8tTyEfS35qGuDj2yCyLkGi4V+_0Comw_dO7qnJUzJQD1t0w@mail.gmail.com>
In-Reply-To: <CAJg8tTyEfS35qGuDj2yCyLkGi4V+_0Comw_dO7qnJUzJQD1t0w@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 14 Jul 2021 21:08:53 -0700
Message-ID: <CAADnVQKMKavv84V3UoFdGA_dvOu6PhMLiHyuhDk8VcUQTse-UQ@mail.gmail.com>
Subject: Re: modified BPF backend, a request for consideration
To:     Dmitri Makarov <dmitri@solana.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jul 14, 2021 at 7:58 PM Dmitri Makarov <dmitri@solana.com> wrote:
>
> Hi Alexei,
>
> I work on an llvm-based compiler with modified BPF backend. Our changes a=
re incompatible with the BPF verifier. However, I added a target feature th=
at isolates our changes from the main BPF backend. My organization is inter=
ested in integrating our changes into the main llvm repository to simplify =
keeping our llvm-based toolchain updated with the new llvm releases. I real=
ize our changes are not interesting for BPF maintainers/code owners, but wo=
uld you maybe consider some path for accepting our modified BPF Target if i=
t's not affecting the main (and only) BPF Target?  What would be your recom=
mendation for us to move forward with this?

It's hard to say without looking at the changes.
For example, new instructions, optimization passes, custom debug-info are a=
ll
within scope of what can be added. The verifier might not understand
these things today,
but if it fits the path where BPF ISA might end up in the future we can com=
e up
with a way to land it.
So please submit a diff for llvm repo and cc these folks.
