Return-Path: <bpf+bounces-72378-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4A0C119DC
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 23:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 113AC4F0A0F
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 22:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931CD328B5B;
	Mon, 27 Oct 2025 22:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LsGirAhX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EA031282F
	for <bpf@vger.kernel.org>; Mon, 27 Oct 2025 22:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761602962; cv=none; b=KhPzEK3Ssu0MIahvOrZKNqUs5gkGwuPqJyMY3J0mCEGD2u1ISCPa+Gb7OUUi3qzNp0pYINjQi7D82BT8xE7gQX5v0qeZ1cbnhMLrS3W4f9qNtCmPCQOP3SQrP4h2i3dLqR/37ey1mQ7JmXsOQ6ezuORDA2T10wNq0Z6nYHfPg6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761602962; c=relaxed/simple;
	bh=aK1nMaqFAbRL/1IYifFke4Hk+m8rpr/2flRVL3AYGrg=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oMaHOq/2CIeBSNm/PYbzdtzv5WWqOalaHUIoVlv5/h/PMZtaIXNAOVLanplxOhOB+thpeP+m1rebZ0GEGaaFwp6kHcJdJFgeKLV90zqiGKjq8pZqw2p6pJSRnbLh1QDzjo7H4QoybVGbP5fUm7HuULK0UqKQ+EVBrgC/TLoYY+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LsGirAhX; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b6ceb3b68feso4119803a12.0
        for <bpf@vger.kernel.org>; Mon, 27 Oct 2025 15:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761602960; x=1762207760; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xcZtBLM3XoUjP95trMtZBXqxh99ZJ8unMssreheHaqk=;
        b=LsGirAhXY98P27Z3gCRnzHitdsZdaWUVRUEFR4VgUtoGz7MjfHPc6xlo0xWopBLPzn
         IQeyXNk8ay80CNnpv+Im5abzed6tJ5R5HNYn+C12AjSxkXyy61i6C/ELmH3iP6jV7TyB
         RD+cCXVOECf0XBZ1KkrJuQ8OpLItOvZyX6v3z8AStQHXToYzudLlk6asoNKOyfQZL0aU
         JnEeOeZtQ+d4efG768Exd8I5myZgIGs1ed+AlW4meC8xUoCeL8naw0FU1yWmzlS3fiK0
         7Xk24SafRb6PX+jlezj6sK5oYd/B+RHSJ0ZXj84pf00SgvvV29b1R8ng9C2RatNdMupx
         HQpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761602960; x=1762207760;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xcZtBLM3XoUjP95trMtZBXqxh99ZJ8unMssreheHaqk=;
        b=laJNzluEuqs7iXJlcrVKn17HzWzgTcba+wMHWfM6fkLBXEQrBXq9hRlqz03wa15BT4
         vdcIZAEwvdjq6Kyup0Wk5fYhUCnVvSnLiUM3DWvy/ypaYoz90pkxpVwPfikJM81vWy2L
         0ZydUoTb79ER5tPDWyluOm3LQsiO8N7/iTtO4x9me4ou4cnIh+BxIKMZP9f3i24lV3U/
         WE0FykdkmBYE5SdDJ+kLDV0x5oSfMdZGT5LXdzdrzRInNTEC3aSIiFLHRHjt7gGiINZm
         WmSQZEf8Yl6G/EHXFKiu9NA21Ln1ohEO1oOuTviQtiFwYyYpuYWX8oUXcpLhVW+4wyPi
         EsUg==
X-Forwarded-Encrypted: i=1; AJvYcCXPQ9H0LXKkuaHtfoT68d0jA1EIHMNb3uAXKaMDwYumEjcnKcrQ8QvFaNMnG05zeKXjsKM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAliKoaDZfcU9GVJQRptTVvjHovbbrU/jllyqRRZrqfqtEgQyM
	dxewaduT9dnUc0uESO1mg+3C/5a5tJvxmQl+/m3Cz5YVLLnnfR42EljFFpk9GaVC
X-Gm-Gg: ASbGncv+Rfm33OoalCvPkrXC4Sp2JjjcH5OuR+MHHjMlDa7cDGKhkgoyrfjpO1rd0DS
	L4Yj9hs0VXTXlwlMj605VcH4ihn+rFUsyohHD59x8JCDdYQutkyOBYhpPbTW9/A/jhnV+BtaTdK
	4g2EZkia/xl+PYeI6b0U2BLTmqFMtPXKIwr1Mf+09MgnZX2WFFd2GJuXJGcYJOCv9+i4kCdOphs
	pwlTXPI2gseCQw9ZIv6sV0J8ChhkfRAoOEGhJpGejOdsKx1OeeI/Z0NN+/+VWBdwUtQ6QKBspoR
	6q227OcGq6+FbIRpeDuRNo6an6ORSm+A591Q0hygVAHikbfmkyA/b0RgGlsPDeH4UV8frhM75a+
	a/XKSKRfVx9VyIV/MkMgVwZXjUYxJtOhpzDoGLdecQFwQkRQDMP8V9YOlEiaW/opDGKCGmLNtgv
	cLttdrjQX5
X-Google-Smtp-Source: AGHT+IE6oxQmz0QlYVxaDGNJpWbAL5UVAPs5mV6ouffXADEawcULIxmWejRt0nKikpeyvcckW6+FxQ==
X-Received: by 2002:a17:902:e788:b0:290:b10f:9aec with SMTP id d9443c01a7336-294cc77a4b7mr10007605ad.26.1761602959585;
        Mon, 27 Oct 2025 15:09:19 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed7d1fdesm9768925a91.5.2025.10.27.15.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 15:09:19 -0700 (PDT)
Message-ID: <d5bcbdd872d91f693e8270ebf4e455a74b6babcc.camel@gmail.com>
Subject: Re: [PATCH v7 bpf-next 09/12] libbpf: support llvm-generated
 indirect jumps
From: Eduard Zingerman <eddyz87@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>, bpf@vger.kernel.org, Alexei
 Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Anton
 Protopopov <aspsk@isovalent.com>,  Daniel Borkmann <daniel@iogearbox.net>,
 Quentin Monnet <qmo@kernel.org>, Yonghong Song <yonghong.song@linux.dev>
Date: Mon, 27 Oct 2025 15:09:16 -0700
In-Reply-To: <20251026192709.1964787-10-a.s.protopopov@gmail.com>
References: <20251026192709.1964787-1-a.s.protopopov@gmail.com>
	 <20251026192709.1964787-10-a.s.protopopov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2025-10-26 at 19:27 +0000, Anton Protopopov wrote:
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
> ---

Aside from a nit spotted by ai, I think this patch looks good.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

