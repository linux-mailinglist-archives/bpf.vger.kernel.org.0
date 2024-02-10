Return-Path: <bpf+bounces-21674-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC49850172
	for <lists+bpf@lfdr.de>; Sat, 10 Feb 2024 02:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 648461C2318C
	for <lists+bpf@lfdr.de>; Sat, 10 Feb 2024 01:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9436442A;
	Sat, 10 Feb 2024 01:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/Pj7usc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54083FF4
	for <bpf@vger.kernel.org>; Sat, 10 Feb 2024 01:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707527739; cv=none; b=QLByks5royUNfWBvf8mOtNw1yept7mAg3EeA9x5rs8RFmlWHqX9whi6SKCqU+Sn/mCQYHJNvRYiazaiNhZXt7f5iS6bJx6bhKDZc4eux7yMmKKu216RzxwUn80q893D/TV8MZgALNc3mJ+zEAJeWGAVBfThpQAcBkjQbAszDLSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707527739; c=relaxed/simple;
	bh=kWf25Sgyykeq8vnol70JSdnhu0+Y0hwNEnlFcuYZCvQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mM8GHxP3HeKQtRdwv5ykMdWrjqDeBZVLZin7FVqSUdq/dBRETUN4xCx3KvqTcZ2HYyfwULr5+7kLGSpc4rtQG4BfdURiIdWiqgGbc2EO9TxsvsDVVvFMl0Da3EKIBu502NSxCsQwAUq7g7kkjN0TFze7grvsCRGaupLQ5tXUxOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N/Pj7usc; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a2f22bfb4e6so206637966b.0
        for <bpf@vger.kernel.org>; Fri, 09 Feb 2024 17:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707527736; x=1708132536; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gFZnYmzeHMAt6iMfxJAYwJ9Dx55YZqUDFu5cZtAPcOk=;
        b=N/Pj7usct5m+gv1WV7rRV7iz0BegGWCereEhuAFPS0jAsShubUFmZMmmttXWgJDgen
         NgyU4Ns1L8/cy27eLv1dR0pdmutS3vKbqSc99nDEjllOvD0BnOsvX32NqdVlQWd9bpBX
         aNwNE04mniYvu/9nsbRaeTd8ZrU6cG73BxJYsx45XqlQW1f9bgoyECi0n7yUYTtyWiz2
         NS6WSut0L2whh/tj3DCPUXFzcheOfKVkv7Mn4cdOvYuUv+xvP68qFiFfbboxM3SjaT0I
         m6h8dNbb/iEAIB7/R4NvXhd0V0xNAFinF5XPFiksXxmXhry0zrYGef7ikEg2Skd8mfD/
         kmpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707527736; x=1708132536;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gFZnYmzeHMAt6iMfxJAYwJ9Dx55YZqUDFu5cZtAPcOk=;
        b=cp42TEcxYmeMj5lssoPT2xpEABGYHxbEgVj7flWXwhIwvdeRvm6P/MGhqBlFp8nM0P
         GCDrSRCrcuXxqzfueXB0oQ6l0sKpPrOzYsmN6oLS3BhYmdNCIWOB+nYHgOyIrZGaeP1J
         cf5BRZZqtsQkokGl1NFneM+/5YNejmYDS7dW8b1ZWStVSazsWiK8QnxDr+scRaSr3+3P
         AAkN1iOKRMACSl6FxQhEUf1gRjQ603boV8q1D4zUoqCNFv4hLhM7+YnOp4o3QndozJ97
         eueCC3FXaYdHoSm176GhFBgATnlpgsVIxwmHnfexymwzCNfriDMXGFqrQs71+dhUKcc5
         aBXw==
X-Gm-Message-State: AOJu0Yy7JTpkOe1D4fY2cJUZEiFcCFj8lc0GYIf8Y95eIWFEK+TZQfmx
	9uuYv4wBwgaMlIFhT2gA0z7XAmd9yGOEX/RbzZXR22uY/g6uXDed
X-Google-Smtp-Source: AGHT+IEMnuyEIt3pscQg52niFTAKyozNBJ3/4waNRyaCnq3XJR0JUqsqyp9kTYL0LcghUUabZXWwPQ==
X-Received: by 2002:a17:906:c7c3:b0:a37:78f1:12f6 with SMTP id dc3-20020a170906c7c300b00a3778f112f6mr416787ejb.67.1707527735986;
        Fri, 09 Feb 2024 17:15:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVFlkoL3XEVAOUHqOOoFLFNx1RLHdAsi8W/8wN4cpjKHyfvlM8WECNdMndRzswx5/RO+iTmNQ7sIEFo+z3I60vw7g9A2bugRoK+da/BZrhTj7TMBkTigMLNzHMLzvybs9/DX4sTaslM3kWStOV92HWZ/OkafXgEkE2f187PFUHOZEsT8kyiyI1KcemtAF97oF0ddUHlRKX2E8C8ab05qDq14UZfDDsa0F1/qzgo5EqSoXfWZShDDW9RiDmJ5JnmDbC59PyXtqCUIBXSsJ1yQUizg+3kTAGF3/U0C6aMfoGe1NT28T0WDBXO7L4/1+yydfxfJnwGEsqX3a9BjKb+H5Edtv8wd96eNe5mJP/QoqItE3oLsq3+Vvr2
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id h12-20020a170906718c00b00a3890e2389bsm1284802ejk.51.2024.02.09.17.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 17:15:35 -0800 (PST)
Message-ID: <25ae80439abad5722719dba1f9951e69e8d01375.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 08/20] bpf: Add x86-64 JIT support for
 bpf_cast_user instruction.
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, memxor@gmail.com,
 tj@kernel.org,  brho@google.com, hannes@cmpxchg.org, lstoakes@gmail.com,
 akpm@linux-foundation.org,  urezki@gmail.com, hch@infradead.org,
 linux-mm@kvack.org, kernel-team@fb.com
Date: Sat, 10 Feb 2024 03:15:34 +0200
In-Reply-To: <20240209040608.98927-9-alexei.starovoitov@gmail.com>
References: <20240209040608.98927-1-alexei.starovoitov@gmail.com>
	 <20240209040608.98927-9-alexei.starovoitov@gmail.com>
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

On Thu, 2024-02-08 at 20:05 -0800, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
>=20
> LLVM generates bpf_cast_kern and bpf_cast_user instructions while transla=
ting
> pointers with __attribute__((address_space(1))).
>=20
> rX =3D cast_kern(rY) is processed by the verifier and converted to
> normal 32-bit move: wX =3D wY
>=20
> bpf_cast_user has to be converted by JIT.
>=20
> rX =3D cast_user(rY) is
>=20
> aux_reg =3D upper_32_bits of arena->user_vm_start
> aux_reg <<=3D 32
> wX =3D wY // clear upper 32 bits of dst register
> if (wX) // if not zero add upper bits of user_vm_start
>   wX |=3D aux_reg
>=20
> JIT can do it more efficiently:
>=20
> mov dst_reg32, src_reg32  // 32-bit move
> shl dst_reg, 32
> or dst_reg, user_vm_start
> rol dst_reg, 32
> xor r11, r11
> test dst_reg32, dst_reg32 // check if lower 32-bit are zero
> cmove r11, dst_reg	  // if so, set dst_reg to zero
> 			  // Intel swapped src/dst register encoding in CMOVcc
>=20
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Checked generated x86 code for all reg combinations, works as expected.
Acked-by: Eduard Zingerman <eddyz87@gmail.com>

