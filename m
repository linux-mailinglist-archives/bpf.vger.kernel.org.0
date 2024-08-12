Return-Path: <bpf+bounces-36922-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0CC94F621
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 19:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7807A28418D
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 17:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF01118950A;
	Mon, 12 Aug 2024 17:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gnrLbN6P"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F363B13A24D
	for <bpf@vger.kernel.org>; Mon, 12 Aug 2024 17:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723485436; cv=none; b=gWb2Xqj4DT78ae5iI5K0g5rszbqcqMnnlkV4noJGKPVMCY6VAr8EGNtgYiEVy3DlKfQLf/WNoqpeEjXoZDBFivgxgLLsiKvXaYpM6jwED/T3OacUF1hlf7CiX/JUQ2XizKngJwwwf7Vvdf6ZZIRHSC4OISm2F82y+INj9qe52OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723485436; c=relaxed/simple;
	bh=TrV4fmRx0wpjW+xxyTqcrRTqeIPdbsxMeMBi1Rs7/WY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BZBQBGdo+xTgLIm2T1nM+zdWO2r4nWnd6+l+WEUHp+vZRswYlaP57vT1f/sjeiixigaIDegHK68P6ZLTZEiN8SL1LPqOdbu0dG9OIEnZhV14sxYIXjRbQ7xi2Oj9rvYb0KHhUZY5FJGxrgSXGROuX34vZtOc+rwCrcLunOBcMT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gnrLbN6P; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2cd34c8c588so3060416a91.0
        for <bpf@vger.kernel.org>; Mon, 12 Aug 2024 10:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723485434; x=1724090234; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BCb9F6demJ6AWQ14luWgh+6Z8zBsYS1NOiTvchwUJVQ=;
        b=gnrLbN6PFltBULl9jbJbPsTdXrNv2Cxp4o6CTjw7e0rgjPkazBsHXhCi2W5BO9Mn+w
         RXlurYcXT5B1s8hHSNtgIcPOMmsA5+8DGW1o/szVaXGoqcMHqKAS42jarmRuCEDTQF8x
         DH6C0cGekPkvSf7Yg9l9xDQaUz7cug5ZB1GQ9c/G9kcbPYkcI/A2qXkvqzKTfTKC1Rvn
         XakKzAPFCkN6fgTPsoPgFzVdIjG3RMm/w35SpYZDc5mumpJsXHP/8q4xbaVfCDVm3Pfm
         3/Yws4ochOg8749zOh41fisbuFzIo6phmntV3qQqxss84rjxc12QtiL/vXMrBbX2n77I
         Hx4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723485434; x=1724090234;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BCb9F6demJ6AWQ14luWgh+6Z8zBsYS1NOiTvchwUJVQ=;
        b=tMvjsBwiqBSgN3ZmlaZkEh0Xc7KeNjDKNrOV+F6v4PFQBkh3q0qq/LfxYEkEcfsPFf
         geArZ2VKs4xD6Wl8K3q/EwRyuk+QBXPFIX5DDOjOyntxVf2/Xz4CgJ1JFC4x+s00PRJl
         2j0+vZGV1B40QXn0P9jwOSVv/+hUOmSSFBDFa0xrDT8N70DpBCStoVE5gNxASAyeRBai
         NIS9oS9YVCWSGwooXGKEZvtrTLxDLG6ycOW/ofWv0ZasRr56LLlkJjDm2QDk1ey+zqcs
         Tlf5rRfWeUivUDAcVFcErKG5MQ6afv8Tndx8K/K1NlJZuSoHiQgVjaObVNuMe+jxmAXi
         KeFA==
X-Forwarded-Encrypted: i=1; AJvYcCU6K7mbwN+woDpeAmnRl/PQVE4G83zy6exzIHOzOctVlkzizEuuN8papCxMuVUZYYmAmxOPiIgeLNl3SGVK+VuClpYE
X-Gm-Message-State: AOJu0YxUB6chSrN4JTDlI5yw3j4LbxhTlDDxcD4QlYm6yfI2bKhuZF21
	vZ8CiHsm/izyMQ/IxXL/QQ3AD9Bt3s3YP+TQwjLEFjNxyiw3rFxzeH1HArYvfgI=
X-Google-Smtp-Source: AGHT+IEn52yL7pSxnBLUnGix/Xzp6qmHgnSmUWDTBPRm6Rz63xRLfZxZBerU0na5VfE8liZAQGZCNg==
X-Received: by 2002:a17:90a:7448:b0:2d1:b49d:7f2 with SMTP id 98e67ed59e1d1-2d392548219mr1230226a91.22.1723485434154;
        Mon, 12 Aug 2024 10:57:14 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3931f1255sm385053a91.53.2024.08.12.10.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 10:57:13 -0700 (PDT)
Message-ID: <551847ff89db0df953c455761e746a0d80d3a968.camel@gmail.com>
Subject: Re: [PATCH bpf 1/2] bpf: Fix a kernel verifier crash in stacksafe()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>, 
 Alexei Starovoitov
	 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
	 <daniel@iogearbox.net>, Kernel Team <kernel-team@fb.com>, Martin KaFai Lau
	 <martin.lau@kernel.org>, Daniel Hodges <hodgesd@meta.com>
Date: Mon, 12 Aug 2024 10:57:09 -0700
In-Reply-To: <CAADnVQJjY9NU7WBxUNqOnLEpm6KhgHL0M_YobQ=2ZjMUHq3_eA@mail.gmail.com>
References: <20240812052106.3980303-1-yonghong.song@linux.dev>
	 <ffac004eab4bfe98c5323a62c6e47b25354589bb.camel@gmail.com>
	 <CAADnVQ+-om1OWRyUvWoiVg5pKM7cxOCVw4wZqdZM1JTRTg4-5g@mail.gmail.com>
	 <d2ca7ec0b51fef86ef8cd71202ee5b6de7dc42cf.camel@gmail.com>
	 <CAADnVQJjY9NU7WBxUNqOnLEpm6KhgHL0M_YobQ=2ZjMUHq3_eA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-08-12 at 10:50 -0700, Alexei Starovoitov wrote:
> On Mon, Aug 12, 2024 at 10:47=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.=
com> wrote:
> >=20
> > On Mon, 2024-08-12 at 10:44 -0700, Alexei Starovoitov wrote:
> >=20
> > [...]
> >=20
> > > Should we move the check up instead?
> > >=20
> > > if (i >=3D cur->allocated_stack)
> > >           return false;
> > >=20
> > > Checking it twice looks odd.
> >=20
> > A few checks before that, namely:
> >=20
> >                 if (!(old->stack[spi].spilled_ptr.live & REG_LIVE_READ)
> >                     && exact =3D=3D NOT_EXACT) {
> >                         i +=3D BPF_REG_SIZE - 1;
> >                         /* explored state didn't use this */
> >                         continue;
> >                 }
> >=20
> >                 if (old->stack[spi].slot_type[i % BPF_REG_SIZE] =3D=3D =
STACK_INVALID)
> >                         continue;
> >=20
> >                 if (env->allow_uninit_stack &&
> >                     old->stack[spi].slot_type[i % BPF_REG_SIZE] =3D=3D =
STACK_MISC)
> >                         continue;
> >=20
> > Should be done regardless cur->allocated_stack.
>=20
> Right, but then let's sink old->slot_type !=3D cur->slot_type down?

It does not seem correct to swap the order for these two checks:

		if (exact !=3D NOT_EXACT && i < cur->allocated_stack &&
		    old->stack[spi].slot_type[i % BPF_REG_SIZE] !=3D
		    cur->stack[spi].slot_type[i % BPF_REG_SIZE])
			return false;

		if (!(old->stack[spi].spilled_ptr.live & REG_LIVE_READ)
		    && exact =3D=3D NOT_EXACT) {
			i +=3D BPF_REG_SIZE - 1;
			/* explored state didn't use this */
			continue;
		}

if we do, 'slot_type' won't be checked for 'cur' when 'old' register is not=
 marked live.


