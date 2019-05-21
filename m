Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13FAA25753
	for <lists+bpf@lfdr.de>; Tue, 21 May 2019 20:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbfEUSOs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 May 2019 14:14:48 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50354 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727969AbfEUSOs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 May 2019 14:14:48 -0400
Received: by mail-wm1-f68.google.com with SMTP id f204so3940466wme.0
        for <bpf@vger.kernel.org>; Tue, 21 May 2019 11:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=TjP/P7c4gYjeR2oHe3nyYI9DsC4D1Q7fDKW4H12WVsw=;
        b=RI6LK0RHL4fqzbP2qxqY3ZtYP1XFqtDxl4cZdAyPIHnA89BMNkWtRS0E60dvvIlupq
         lPvp2CxK3y4nniGYp+tRydRV9vANAmPR9uxL2+zvcpENNW1bLg9dS/0e+I55JfPKbG0J
         NOJzgpwyPohQDx/V3ZAuefx7J8TJzG6u9907pCeUUevBjvjrG7SBUkxUHN+qJ3FeqYBp
         e4/QffG1Tb2JFo+JvUBf7tbuphp+wpFoOAPofZKAgXadaE+Z78YkVTkmY2L9Om024lyN
         8bC4VkpyW3hbiQPHRbH1NRRpwKqjbEwuPE1slZjniwsutDiE46eL4V5yCgpT4Qz5+psp
         qNWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=TjP/P7c4gYjeR2oHe3nyYI9DsC4D1Q7fDKW4H12WVsw=;
        b=X9UF+MOIxMXcV6HO5JoFOrfritqaeKTrnqPxqvklw5ugQ1Eqyfmdkm1CbRvJlzpKVH
         D89K81J/WboMfR7kDLPq8AM4oYuXjFWSh9f+W34OD+ZbK50Ffb8FjE4sXYR6RIlIvBPk
         v034ejGzg6cNKzlP9WBK0adCV0Xr8nn/vTKmawZ9tflM7daZN4R1Lmv631trsj9fuVbB
         tsGZFo3oRK2hdKTpQRwbldYxy0am4bIypKo4AeaJ5NN2+frz9K4OaAsPMHBWj9VcY4Fi
         h/Zk/bp6qNHJEn8Iugj89Fid4yGyZm/fYWL4el5q99NuBit3RUrOvcn2D2aKXpRuEKfe
         HS1g==
X-Gm-Message-State: APjAAAXqN7fFFsKnHZzMXOBM0gzUcbkVdnafbyrDm19fnpP5v59L5MnI
        ACAnfzi/MUIcaOtW+fwiQESCgA==
X-Google-Smtp-Source: APXvYqyW59rke7avKYpxd3oIQTCxdxdVjEGbLxUs5T/SpXRob5tTmfzVnSBzk2gCjophNevaQe8FyQ==
X-Received: by 2002:a1c:f910:: with SMTP id x16mr4663660wmh.132.1558462486290;
        Tue, 21 May 2019 11:14:46 -0700 (PDT)
Received: from [192.168.0.23] (cpc1-cmbg19-2-0-cust104.5-4.cable.virginm.net. [82.27.180.105])
        by smtp.gmail.com with ESMTPSA id s13sm3798630wmh.31.2019.05.21.11.14.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 11:14:45 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 0/9] eBPF support for GNU binutils
From:   Jiong Wang <jiong.wang@netronome.com>
In-Reply-To: <87d0kbrb3m.fsf@oracle.com>
Date:   Tue, 21 May 2019 19:14:47 +0100
Cc:     binutils@sourceware.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <768B654F-A66B-4CCE-9320-D096538B23F2@netronome.com>
References: <1B2BE52B-527E-436E-AE49-29FA9E044FD3@netronome.com>
 <87d0kbrb3m.fsf@oracle.com>
To:     "Jose E. Marchesi" <jose.marchesi@oracle.com>
X-Mailer: Apple Mail (2.3273)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


> On 21 May 2019, at 18:06, Jose E. Marchesi <jose.marchesi@oracle.com> =
wrote:
>=20
>=20
> Hi Jiong.
>=20
>> Despite using a different syntax for the assembler (the llvm =
assembler
>> uses a C-ish expression-based syntax while the GNU assembler opts for
>> a more classic assembly-language syntax) this implementation tries to
>> provide inter-operability with clang/llvm generated objects.
>=20
>    I also noticed your implementation doesn=E2=80=99t seem to use the =
same sub-register
>    syntax as what LLVM assembler is doing.
>=20
>      x register for 64-bit, and w register for 32-bit sub-register.
>=20
>    So:
>      add r0, r1, r2 means BPF_ALU64 | BPF_ADD | BFF_X
>      add w0, w1, w1 means BPF_ALU | BPF_ADD | BPF_X
>=20
>    ASAICT, different register prefix for different register width is =
also adopted
>    by quite a few other GNU assembler targets like AArch64, X86_64.
>=20
> Right.  I opted for using different mnemonics for alu and alu64
> instructions, as it seemed to be simpler.
>=20
> What was your rationale for using sub-register notation? =20

It is the same instruction operating on different register classes, =
sub-register
is a new register class, so define separate notation for them. This also
simplifies compiler back-end when generating sub-register instructions, =
at
least for LLVM, and is likely for GCC as well.=20

LLVM eBPF backend has full support for generating sub-register ISA,


> Are you
> planning to support instructions (or pseudo-instructions) mixing w and =
x
> registers in the future?
>=20
>> In particular, the numbers of the relocations used for instruction
>> fields are the same.  These are R_BPF_INSN_64 and R_BPF_INSN_DISP32.
>> The later is resolved at load-time by bpf_load.c.
>=20
>    I think you missed the latest JMP32 instructions.
>=20
>      =
https://github.com/torvalds/linux/blob/master/Documentation/networking/fil=
ter.txt#L870
>=20
> Oh thanks for spotting that.
> Adding support for it :)

