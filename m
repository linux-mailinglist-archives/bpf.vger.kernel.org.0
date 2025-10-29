Return-Path: <bpf+bounces-72901-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97871C1D746
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 22:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74AE618936A6
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 21:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B62431A808;
	Wed, 29 Oct 2025 21:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="exB7UP3E"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6F031A7F9
	for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 21:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761773504; cv=none; b=Jg1SO8ZeY/4kr1OxrruR7Iegeoa83BX9nS4VUWXKbTytDDI/a3bJyYIsoNPgdA8ZCX87E86AbXUgwHqVsp//2+lRPn2YPRwGfkgqSNtul8JrAo5/50NXU1NuTpstTQt7pXPUlJhAWQzEx9LL8VZcN9PipM3VOT/JN/KtWRV7wzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761773504; c=relaxed/simple;
	bh=1r742rFKrn5XLKAk0Rt9RmGLkL/QWjG+EVnpl/zHnek=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mtlA3hyPFzCF4mkjGLsk5BmdlNtdVlzwwe94ZduKGG5GQGMFaRSuB84SLRORZU8WvdYWMd9ffMkLh4lRYDVV/zB9ttmQnsHXYQYAVL1we8Om9FF0s5TFTGcZW+DeUikOLWThvyiQcZRJ4uKDPGqNf6+oh1DGp2hciRzDskn1zOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=exB7UP3E; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-340324d333dso352288a91.2
        for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 14:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761773502; x=1762378302; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ddl4f6cfjYw0fyU3ioXurFvMDBLvmdDbVYw8BC7msm4=;
        b=exB7UP3EvL7uKpTUwEwrnzfgkAS0HBBFSzdYKS/g6AuDtzwdsqi3ZpGy8a4El/JWUt
         Xp1yU2SAtn1H80Hl7Y659QnTI2enjkH9FDdY53gLmwtzcM5NIq7JnusIUTPdBdej6t60
         nX1iSR8IhS/4yIO0HPDGpJAQEi+q7xzo44Zdyv9wYK5eMRm+3krN1c1LQPPJkGebu1te
         7MrigiA0Z6frmE9WdIchLskNTq+3W+sb2ypU15yYDGN/NsNgaYhAuV/kE0MmiHk24mPI
         xmMyJ/09y+uzpmF+VUZ1w7cke3osuXNjQYmavvxRvKbZUBlwbzIP5eHxd8G5gCKcoloT
         kylw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761773502; x=1762378302;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ddl4f6cfjYw0fyU3ioXurFvMDBLvmdDbVYw8BC7msm4=;
        b=S+Y+j7jVXmbyE6bU/hmqY1Hu/b6j9N+tZTtp/m5iv/5MQsBkKZQ7JL+7BmbN9fPmpL
         C9KoDYC/anvBE9yGjhvwMFnNoHtK1HBmDczh0vEcJqydT6MCcUOrB+1QMVEhH/tStXAl
         AR0OupJMsALBl8ApBK8cAi7GLEN8+AUgqRueYinzkeGr7kT1sR2SgW8+Psqq4DJ2UkVC
         5Ex3IVkemgNU50g6lIN8GIsrX8bSKuA0wA0DOmUnuKS8yPONC0WXEd9AVrllvVY0cl8e
         66YVkzEIESkAP7Ch0dZp3JPPuNm+W2pIlCXDeX2tiR0Z578abnFWH6TmPjqOaSLa4Csd
         NxaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXS/12KJKRe/VbaEhmHJIFQBMpjKlpHH7bvroHh6fq/IC54B479HI27ezPeVtubaCNudN8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8Bo5K8TBQRafVix7e6xtTRGcJr8Gm0avaaG5q3jjLhLxMBR/a
	e1uIwGr9qhopF/C9tEByMuhwl4gfS+O2osb/j/86nLn4SkrEQ1zowiXRDXkbFtO2
X-Gm-Gg: ASbGncsI9sZKq1htIRhOsz11eRx80vWMT5WVTzjDOTB0o1OJpoDP0rcNc1rC6uJAjxR
	2IIhJZlTVvC5feV17o1lzwWc4hFuZWdpPKE3UwgyiFxzPnApYwfhsq61rtPdTBqXsqAarNYrNS+
	taWjrAk7HKGl2WecktfpB31njc/cIn5bC6k/wppT91akhD9oVbv0TGSgvfjowtcNlsNwgON/8ZT
	lKX7lC5npKm3EHFK/QJ5FvZwwa9D1qv08ILDpfqRQLtEYmqKNJ1gZGG2JnbQXLLXWmzQAQJs0gg
	yak/e4cS0SAMnRvdtDjAbJG9vXSsILx8WXOcbPb+FoeqUt9EE4xL2Sv0OE1sfcrYgZstQEqPh9z
	73d5oVNeQUStN/ZdIbXYMFQzNlj5GkPalmBJg/XyY94OSosYFj2X7BB4ER6TjwEmJbALnzTv2wL
	qrkL/05Jyk/7nWg9qDtCdPsEsvHA==
X-Google-Smtp-Source: AGHT+IHEN45HY4TetGbOmmX0H72v6MSi5p4ndVoZMAmFvy7/xrXSel9OsR+pbiTgdh2EMLsKd9uhtw==
X-Received: by 2002:a17:90b:2886:b0:340:48f2:5e2d with SMTP id 98e67ed59e1d1-34048f26013mr1378167a91.9.1761773502360;
        Wed, 29 Oct 2025 14:31:42 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:3086:7e8a:8b32:fa24? ([2620:10d:c090:500::5:6b34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-340509a3001sm135574a91.10.2025.10.29.14.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 14:31:42 -0700 (PDT)
Message-ID: <68754a9c03b960d5057de816b217e824e51021a1.camel@gmail.com>
Subject: Re: [PATCH v8 bpf-next 08/11] libbpf: support llvm-generated
 indirect jumps
From: Eduard Zingerman <eddyz87@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>, bpf@vger.kernel.org, Alexei
 Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Anton
 Protopopov <aspsk@isovalent.com>,  Daniel Borkmann <daniel@iogearbox.net>,
 Quentin Monnet <qmo@kernel.org>, Yonghong Song <yonghong.song@linux.dev>
Date: Wed, 29 Oct 2025 14:31:40 -0700
In-Reply-To: <20251028142049.1324520-9-a.s.protopopov@gmail.com>
References: <20251028142049.1324520-1-a.s.protopopov@gmail.com>
	 <20251028142049.1324520-9-a.s.protopopov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-10-28 at 14:20 +0000, Anton Protopopov wrote:
> For v4 instruction set LLVM is allowed to generate indirect jumps for
> switch statements and for 'goto *rX' assembly. Every such a jump will
> be accompanied by necessary metadata, e.g. (`llvm-objdump -Sr ...`):
>=20
>        0:       r2 =3D 0x0 ll
>                 0000000000000030:  R_BPF_64_64  BPF.JT.0.0
>=20
> Here BPF.JT.1.0 is a symbol residing in the .jumptables section:
>=20
>     Symbol table:
>        4: 0000000000000000   240 OBJECT  GLOBAL DEFAULT     4 BPF.JT.0.0
>=20
> The -bpf-min-jump-table-entries llvm option may be used to control the
> minimal size of a switch which will be converted to an indirect jumps.
>=20
> Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> ---

The update looks good to me, but I noticed one more thing.

I'm seeing the following messages when rebuilding bpf_gotox using
llvm main, where Yonghong added __BPF_FEATURE_GOTOX.

    CLNG-BPF [test_progs-cpuv4] bpf_gotox.bpf.o
    GEN-SKEL [test_progs-cpuv4] bpf_gotox.skel.h
  libbpf: elf: skipping relo section(13) .rel.jumptables for section(6) .ju=
mptables
  libbpf: elf: skipping relo section(13) .rel.jumptables for section(6) .ju=
mptables

Looking at the llvm-readelf results for the object file:

  Relocation section '.rel.jumptables' at offset 0x5a28 contains 263 entrie=
s:
      Offset             Info             Type               Symbol's Value=
  Symbol's Name
  0000000000000000  0000000300000002 R_BPF_64_ABS64         000000000000000=
0 syscall
  0000000000000008  0000000300000002 R_BPF_64_ABS64         000000000000000=
0 syscall
  0000000000000010  0000000300000002 R_BPF_64_ABS64         000000000000000=
0 syscall
  ...

Note the number of entries (263) above.
When compiled with -S instead of -c, jump tables are printed as:

        .section        .jumptables,"",@progbits
  BPF.JT.4.0:
        .quad   LBB4_5
        .quad   LBB4_4
        ...

Counting these LBBs gives 263 as well, so I assume the relocations are
for label references.

Given that relocation addend is always zero, I don't think we need
these relocations, but I can't figure at the moment, on how to
convince llvm not to emit these.

Yonghong, do you have any ideas?
This is done for OutStreamer->emitValue(Value: LHS, Size: EntrySize);
entries in BPFAsmPrinter::emitJumpTableInfo().

Or I might be wrong and addend is not guaranteed to be zero.
Then we need to handle these on libbpf side.
Spent two hours trying to figure this out, no definite answer yet,
will continue investigation later.

[...]

