Return-Path: <bpf+bounces-19694-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE7C382FDDA
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 00:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 661F528690F
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 23:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE1B524F;
	Tue, 16 Jan 2024 23:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="US8JuNh0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6E51E862
	for <bpf@vger.kernel.org>; Tue, 16 Jan 2024 23:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705449362; cv=none; b=LoY9oJEz32tEEG57df6iNI/0VsekKcwFhkzJK3ARNXJI/3Bn46wcw3knsrvk52VuObPvprbd/hStIzthbOTxCXzFMNJ7yO6rTmPoNyWoxF8fNkyh6BRFzHBmX+DU8UUyAGq882a3c8J99f3kYmpUFVmdrq5CNs4iKitKFgVXyJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705449362; c=relaxed/simple;
	bh=00yoyyMqP19Nc9A4crVj8LAlWHSzdzLj5SdR6IQf4fo=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Autocrypt:Content-Type:Content-Transfer-Encoding:User-Agent:
	 MIME-Version; b=ax0XOPHZ7iEDb5168RdCFPXU9PIct22+6pGnHmCbUXXXUYSaMmLd9SNfkkTh9Nq3SDim82K2MfXmTXJ5/DDwqWvb2tAiFxPyQxqXUSa6ovORaJILijhktD2RN31mEGHhtosRCFSRUR8TxedLxHkU7J3dSR+nxkXjnSJsHgxBebk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=US8JuNh0; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a2ac304e526so1026542566b.0
        for <bpf@vger.kernel.org>; Tue, 16 Jan 2024 15:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705449359; x=1706054159; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DxtSP54JD8M/UIlVHpYx0Q6FKvT20pGJ7F3f9DEeQf0=;
        b=US8JuNh0cvhzUs5E9tUzDbQ9Oe1ZKlw30WsGRZcK7OlCL3Wj2kWZt0ngnNHSbo4tKR
         +an7OThkNJr2qe+Mzw4gwgdfq/TmlhQ+qqB37LBBw44pYWvEQI2h91lhdspBeYH//GvD
         m4E3Zk7W1KYZw/GATkmGMZ9pEnmuN1LU0Xyak4N83r7PaRsryVEvkZFmuKu8ECtOpNeY
         lj5Ec6PIOeTmBc9U/Zq7R0qKw6VVY/gkpIbHlY5AAsYWt3O4vxgITJVlwpG0yMWPr3fT
         nHn4vkU8vprhPoWJPEwHmA5Jj8rYmttc1NOo8R8kg9BUrYtd3zZxfqoq/6lKXsf1HccD
         PGeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705449359; x=1706054159;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DxtSP54JD8M/UIlVHpYx0Q6FKvT20pGJ7F3f9DEeQf0=;
        b=NaPoIDulYoYfFqW/a1E3/jqDyD3OfVcXNA1AgmUmrN8NyyYQtAdpQOzuGCVt/IIRoS
         D3p8OAbvireVfuCMcnSgomxwrBmzXX7X8aE03ss5Aa0brZ1TjWY+aRa87t2A9UGD5j+K
         H1/sCRUxH0pjQ1TFe5WZLksIf17qA6oJjrR8anaN1z/GYqLJhMx7dB4gST4wqjYh89BV
         hllkGN6x66Eb28BJ9MRPh4PNlVuRCtzlhU4dwLcxg8YfX8Zkjpmgn3ZOyxaw4Act6l+y
         NUxIYoYi5hQwbjuKQ+URbIykKK8cr7xarSkJZMnen3HftYrqG/yxD/uZIxaWznzkRgmM
         BJGA==
X-Gm-Message-State: AOJu0YzsnV0XUzYgLbKT+f8wL3KsWFmTpD6ECiitOC3Y5nqG47u/eBFq
	OuuWwPVIeZCM1AF5DXho/kI=
X-Google-Smtp-Source: AGHT+IF4nzsQgrtOpj8tOIYsKk2y2CrR+yPv/GyD27NzHwm5hwQ5XnZ2ndxnSzxvw8cH0/G1V6GtaA==
X-Received: by 2002:a17:906:4c51:b0:a2c:55f1:ca16 with SMTP id d17-20020a1709064c5100b00a2c55f1ca16mr4077768ejw.1.1705449358913;
        Tue, 16 Jan 2024 15:55:58 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id hy7-20020a1709068a6700b00a280944f775sm7065480ejc.153.2024.01.16.15.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 15:55:58 -0800 (PST)
Message-ID: <8bd821ac03d5f74fe8bbd15cf338aa1b9d2bef99.camel@gmail.com>
Subject: Re: asm register constraint. Was: [PATCH v2 bpf-next 2/5] bpf:
 Introduce "volatile compare" macro
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: "Jose E. Marchesi" <jose.marchesi@oracle.com>, "Jose E. Marchesi"
 <jemarch@gnu.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Yonghong
 Song <yonghong.song@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>,  John Fastabend
 <john.fastabend@gmail.com>, bpf <bpf@vger.kernel.org>, Kernel Team
 <kernel-team@fb.com>
Date: Wed, 17 Jan 2024 01:55:56 +0200
In-Reply-To: <CAADnVQKGkPaCMyesJ=U469AOS5iJ=vmL20B7Ya7HFp8ouC3C5g@mail.gmail.com>
References: <20231221033854.38397-1-alexei.starovoitov@gmail.com>
	 <20231221033854.38397-3-alexei.starovoitov@gmail.com>
	 <CAP01T77fbW-9N+Z-2LFS=174HN6v_OJAbR_s6EOfLLW8Oceh_g@mail.gmail.com>
	 <CAADnVQKY4hB4quJX_oyq4GULEJkehXWx6uW1nAYHveyvdyG8sw@mail.gmail.com>
	 <CAADnVQ+tYBpt_aRG5aU3sAYEysKxUOKQ24dBG4bP2kLy8nmmgA@mail.gmail.com>
	 <44a9223b6638673487850eb9d70cc01ef58e9d93.camel@gmail.com>
	 <CAADnVQLmXxn9RrniktuW80XO14oyOmgJ_NboBBC_-CU4O=-v9g@mail.gmail.com>
	 <87h6jm6atm.fsf@oracle.com> <87mste4sjv.fsf@oracle.com>
	 <878r4vra87.fsf@oracle.com>
	 <95388269687be49d7896a881eda8aa3bb89e40a4.camel@gmail.com>
	 <CAADnVQKGkPaCMyesJ=U469AOS5iJ=vmL20B7Ya7HFp8ouC3C5g@mail.gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-01-16 at 09:47 -0800, Alexei Starovoitov wrote:

[...]

> 2.
> case 'w':
> if (Size =3D=3D 32 && HasAlu32)
>=20
> This is probably unnecessary as well.
> When bpf programmer specifies 'w' constraint, llvm should probably use it
> regardless of alu32 flag.
>=20
> aarch64 has this comment:
>     case 'x':
>     case 'w':
>       // For now assume that the person knows what they're
>       // doing with the modifier.
>       return true;
>=20
> I'm reading it as the constraint is a final decision.
> Inline assembly shouldn't change with -mcpu flags.

llvm-mc -arch=3Dbpf -mcpu=3Dv2 compiles the asm below w/o warnings:

	.text
	.file	"test-asm-shifts.c"
	.globl	foo
	.p2align	3
	.type	foo,@function
foo:
	call bar
	w0 +=3D 1
	exit
.Lfunc_end0:
	.size	foo, .Lfunc_end0-foo

However, clang would complain about "w" constraint when used
for inline assembly when CPUv2 is used:

  error: couldn't allocate input reg for constraint 'w'

As Yonghong notes in the sibling thread, this would probably require
enabling 32-bit sub-registers for CPUv2.
Will need some time to investigate.

