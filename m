Return-Path: <bpf+bounces-62655-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB68AFC8BC
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 12:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A8F01BC295B
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 10:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F8F2D877F;
	Tue,  8 Jul 2025 10:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V257i3PT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4663E2D8397
	for <bpf@vger.kernel.org>; Tue,  8 Jul 2025 10:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751971359; cv=none; b=OlWs9KRSpmzPrQQsBPT8UkM0kay7HiiMXL9jJ93HMwp3L0bOYJbjq0HMSJ4Q18DCa44TaOHuTnP3s9HAf/W3ppVDB0ORleeIM+nCzZmKR1vrhgrYgN0sONRQjLVnB+ewK24x8n4y8AQ95+s/0xP8d16jMi5HAEk7e9LLdhNGsnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751971359; c=relaxed/simple;
	bh=bTCTa6Mwqe4GnHNCELzHaTjK1iQCBesayXI9d8cDMi8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KxStfvs6KW2Q4OlS6cBR/VswRt/yqex6ckoYkrHHkoWrrDyJYhlHOHPrlrl3QYQa5auJeJmp9orS9v36vGm0gyZuZ2rSMuR0jVX1DYQyuexiaOOrOEs9+ZCLVlIW7Qdk+l41uuLXKAa3HEplIdVrnh1UNwYZhwVQCSrVb4ksjhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V257i3PT; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3141b84bf65so4032078a91.1
        for <bpf@vger.kernel.org>; Tue, 08 Jul 2025 03:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751971357; x=1752576157; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=E+zs0lshQKkOmgoxNZn8R5M+qsXiLHj1hLeQOq8/cA4=;
        b=V257i3PTEzm1rbVPClQCTl+P2I9ekeX8XM5Kt57+tC+fL361c1X/Bqf5ih6Y1SIydE
         /DLbSvbw7EAHs2kYl12qPcbqrz6AApbQLvdnAX/LGMk+2jyzntKr+1gsBkfJM6YwBS76
         32Jjsiu6r/UOB1Z26eQprP9DkOvTgM7l/00dfD0/NnXyrfWexqyJsSPc5bz7b6ShhFlG
         BWXXCyFQwjQuMEeVnzjZhuB+ysvTdzZKCCBwnZiCIMA+er3skXCmq6aJFeJuOSJK+P7B
         /ShVt/R6m5PKy1Kv5eMH7fg2FV16tJxxvURpDTVJ6OZIKQyVLRd6s4X6fRxrrkzaahB/
         RHUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751971357; x=1752576157;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E+zs0lshQKkOmgoxNZn8R5M+qsXiLHj1hLeQOq8/cA4=;
        b=iP1BehQwqMAY0WDx8JEQGM3+TToOyhNYrAeUuQdmrCFnKrHgmBWYnAffkgdrA1/oyf
         yVkGknQ3/9Q++J8MGUQ//VIFCjmAnQnHS3mDlmDThyaGr1pygLZaQtffObg5BUvr9JgH
         MBIKSA+z8edclPGj0XY4s7iZYkRqjfy7ze7SMvJbqVc5i8zMGCUkAlCs/xrShFtIGiVB
         zUB5SYl60zDGCghXHh2FbOgoHh7nyRjI7wN5lpwAoAR8e3wANMwOFiDNXIrJqs9w1XOc
         5T6rDivNEot+67G+ab8KkcEoH3P3hVZB+qbwMeeY9T//V6FlBD+wA8csIzEwvSA4f8n8
         /38g==
X-Gm-Message-State: AOJu0YygSJUI0BpmlBLyvODO2n+uKTaM0Ae6/ZMZNqZUr1f1kcr8tL/Y
	sXFZQzUo/rsYiqkHDrNmQr/RmLVxHEQ0Cpk7YK5ngtJQA/9EX6XMNNoz
X-Gm-Gg: ASbGncv308DtwM5TL5dDGyaH7RXGWPC5J0TkS3mYTHowHmwlJ2j/JjLT4RJnZppNrbz
	/0soDZy2i2GGS1rlXe7IJH1ehknLza7xgApmY25IzAMfinVbTbTeOUPDO1MCnwT4BP/sXldTy0a
	CZU4MBG24QIW1AYs36/ech1YPuEVMV4psdZEo4p9j3BD0TnArh2+O0TsA2B7LcsQLW5j+0O2Yre
	DnquGPGmwOHms/GdSMumFoSvsOKDWQxWTxZfnIpxYyD6D+c2dk/K0pwZ/3x2BGEHB3fp/LaDAyQ
	EBK17D184DSqVOCobeRAaRcdTeBzt4rg1BWOSOlKbhyfIzui9j65aC1bjQ==
X-Google-Smtp-Source: AGHT+IGgalyhGttDl0asggo2qDYcO5hYrccXgY7wn34va1CtVFcApcd2LmaaavordXOxIA07If2hMQ==
X-Received: by 2002:a17:90b:3d8a:b0:311:fde5:e224 with SMTP id 98e67ed59e1d1-31c21c8b142mr2887213a91.6.1751971357383;
        Tue, 08 Jul 2025 03:42:37 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c22073013sm1808089a91.23.2025.07.08.03.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 03:42:36 -0700 (PDT)
Message-ID: <36c4355b71136704ff5ecd867a8a2905415c838c.camel@gmail.com>
Subject: Re: [RFC bpf-next 8/9] libbpf: support llvm-generated indirect jumps
From: Eduard Zingerman <eddyz87@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>, Yonghong Song
	 <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko	 <andrii@kernel.org>, Anton Protopopov <aspsk@isovalent.com>,
 Daniel Borkmann	 <daniel@iogearbox.net>, Quentin Monnet <qmo@kernel.org>
Date: Tue, 08 Jul 2025 03:42:34 -0700
In-Reply-To: <32da86698de643097bbd2b1f15221730b063a527.camel@gmail.com>
References: <20250615085943.3871208-1-a.s.protopopov@gmail.com>
				 <20250615085943.3871208-9-a.s.protopopov@gmail.com>
				 <1c17cd755a3e8865ad06baad86d42e42e289439a.camel@gmail.com>
				 <f8bc4e5469e73b99943ff7783fbe4a7758bbbe32.camel@gmail.com>
				 <aF5v8Yw5LUgVDgjB@mail.gmail.com>
			 <454128db01c0a01f3459783cd5a0ea37af01c34e.camel@gmail.com>
		 <e8a7a143ad1ebb087ff06032068201023aa893f4.camel@gmail.com>
	 <32da86698de643097bbd2b1f15221730b063a527.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-07-08 at 01:30 -0700, Eduard Zingerman wrote:
> On Mon, 2025-07-07 at 12:07 -0700, Eduard Zingerman wrote:
> > On Thu, 2025-07-03 at 11:21 -0700, Eduard Zingerman wrote:
> >=20
> > [...]
> >=20
> > > > > >   .jumptables
> > > > > >     <subprog-rel-off-0>
> > > > > >     <subprog-rel-off-1> | <--- jump table #1 symbol:
> > > > > >     <subprog-rel-off-2> |        .size =3D 2   // number of ent=
ries in the jump table
> > > > > >     ...                          .value =3D 1  // offset within=
 .jumptables
> > > > > >     <subprog-rel-off-N>                          ^
> > > > > >                                                  |
> > > > > >   .text                                          |
> > > > > >     ...                                          |
> > > > > >     <insn-N>     <------ relocation referencing -'
> > > > > >     ...                  jump table #1 symbol
> >=20
> > [...]
> >=20
> > I think I got it working in:
> > https://github.com/eddyz87/llvm-project/tree/separate-jumptables-sectio=
n

Pushed fixes. Relocations are now emitted for gotox and reference
correct symbol:

0000000000000000 <foo>:
       0:       if w1 > 0x1f goto +0x10 <foo+0x88>
       1:       w1 =3D w1
       2:       r1 <<=3D 0x3
       3:       r2 =3D 0x0 ll
                0000000000000018:  R_BPF_64_64  .BPF.JT.0.0
       5:       r2 +=3D r1
       6:       r1 =3D *(u64 *)(r2 + 0x0)
       7:       gotox r1
                0000000000000038:  R_BPF_64_64  .BPF.JT.0.0
       8:       goto +0x8 <foo+0x88>

Two llvm BPF unit tests are failing:

 Failed Tests (2):
  LLVM :: CodeGen/BPF/CORE/offset-reloc-fieldinfo-2-bpfeb.ll
  LLVM :: CodeGen/BPF/CORE/offset-reloc-fieldinfo-2.ll

But I think current state should be sufficient for basic testing.

