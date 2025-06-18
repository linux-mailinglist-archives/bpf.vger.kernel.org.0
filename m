Return-Path: <bpf+bounces-60905-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F76ADE991
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 13:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E3B13BA42B
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 11:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F287E28640B;
	Wed, 18 Jun 2025 11:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YTrcSwtm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B5F2877EC
	for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 11:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750244694; cv=none; b=i/Z0VF2qyqIBCVLOTgBge/w1HQ0USkacUDmYif7XHyMz6kCyIoaS8hRWv1Ab4yz/axTfoeBp7aI0hHQFrQxLXpUihe+K7bF/w8wjhnOweSWgjfUwK6R7bBaIyUSmcrX4LZykV+Ml8wMhC6WNwR+iYJnGXbnDthEZEsJCBzGzw0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750244694; c=relaxed/simple;
	bh=eIczfcN4vhkxMo50ZFaODTI8cWj3fBX9gCaJ31hektE=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gdAJ+I7N2cw1PgwBX83k888KmCDX8mb/vjrUmu6JaZcDU9NXlDRnR4BCAvW4oxL0RTaj8oGKPo+FPo7ZjepZjauBZaRS5rLvU62nHbJE+TYfeTw7Xk1LM5j5q+GfR2uR03seIEZbFwh38rmWM3DIZbJ0C4nQI/ylxosKvSN9OAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YTrcSwtm; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-742c7a52e97so5614316b3a.3
        for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 04:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750244692; x=1750849492; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oLAiszpeKj0ujBTJ3aA67+fQuWpA7701FtpvmYTJIlQ=;
        b=YTrcSwtm0vMhXQTAbwu0kNvfBkSjwKlPsblW1bZObiLq0zBQl/3VfeT4iSVDeXmdrh
         8RnC0dG6ZBLjY6e1/zYMk3lp0E7rZIyxwwJ2plca3BRvlSvEmhk4tFo1J+sRJWAWuX23
         6j+2SznFyN5vaDVlgAAgZuZSzjrztd3yekZFinlGMOg9GMKfrBquoqiFeZICuF9Ju8f5
         IknifqSrk+RdPalhFswQ3CtaY4aZHCSP+L2iTpICEUQPBJ87ZcACu5qv79rxuCXTE/Tu
         wJrBVFil5X6pk6tSCQx7TvwTZZm2Zqbx6IZVBN5JCUuiVCw94gL5wFbo5fC8mj7TZtcB
         +wcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750244692; x=1750849492;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oLAiszpeKj0ujBTJ3aA67+fQuWpA7701FtpvmYTJIlQ=;
        b=VasFQgaooadE/Iu6/7LKpMEbZXaCSgDUhdciXTMgjwT1n/qZFRDQzZSX7XmyQY+S54
         XrGxIsyUlxo1AASLfailHxvwF5B9vSahF2S3Ap7qWCn+lze/U8vF3f9mbboS2v8RpkBn
         o2FvCVRUOyQmOHCN6aXdc1p+6tjMYZmDaEfJNRbWQR8w9FBCVcKX0OY8fiYVGOVxUzqh
         9FS2LI/XNGsgTDqIcrGuWi1rQgwU+tOEG3oaTRgDEpg7wjXX17rprvnZ/otPGmnmrVeu
         aTLm6+OXMSkeNAkkAOfxeBqu/wVu9rI2rPBZgAh/BXvi77ry8UnT/B9iR0YteoYsddUx
         4IwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZDmlmW8AKMujYLrQJLwkKCyYCav/M0rQ0P1koKYQ9PDNGIvbH0T+I2gy+Teaw4xRR1F8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+guK5d2PGdaPDTvEslJnBNw60UM9e0LXcYKPyxzA2vspYrmbX
	/48OYLPMHMoa8ii13hpOKGVew0JlX5dCgG/XNEfZL/ghkJx8CqKLKj6U
X-Gm-Gg: ASbGncu9CK9o37pkzSM3/BJESeGV6XIMPpHrwuCFBYtRxYdq+gw+Q0zVdjsY2iJoy2c
	mbGaZyhvDrCIqL+t8DWruScWddfwUAX8UeDedjNx1u7I45uxK/kw73iIhe3AZyjv03rOSBfMRlg
	Hkt2X8Zv0z24k/f2D0b8U5m2fA3BVn61w1TWxNZnJwm9nuFw85AABbEjKiJjYkDs9c2xKisigWS
	Vl69QcnLwRLC+xBTpuTx//lS4iRP5uG/UMhxcuvCyIWae09+EzL2YT4p0NCKzxEtJT5Wgt8P31b
	ql50UOWwKBSGsI9L6jAzHjISel3naVL92Hl+fzIEtr9YsHzXQU0zqgzDdA==
X-Google-Smtp-Source: AGHT+IGOyt8KEDs4yhfF7pBwupgAlLrxDQvtU4cn5rjVwx93sFP0riUPB6E+dn4jxMabMzBdWXXIfg==
X-Received: by 2002:a05:6a21:3982:b0:201:2834:6c62 with SMTP id adf61e73a8af0-21fbd5f2087mr26727637637.25.1750244692364;
        Wed, 18 Jun 2025 04:04:52 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748900d233asm10685863b3a.159.2025.06.18.04.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 04:04:52 -0700 (PDT)
Message-ID: <bf18e12a52cf013b96f8aaa88b062e6bb48ba36c.camel@gmail.com>
Subject: Re: [RFC bpf-next 3/9] selftests/bpf: add selftests for new
 insn_set map
From: Eduard Zingerman <eddyz87@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>, bpf@vger.kernel.org, Alexei
 Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Anton
 Protopopov <aspsk@isovalent.com>,  Daniel Borkmann <daniel@iogearbox.net>,
 Quentin Monnet <qmo@kernel.org>, Yonghong Song <yonghong.song@linux.dev>
Date: Wed, 18 Jun 2025 04:04:50 -0700
In-Reply-To: <20250615085943.3871208-4-a.s.protopopov@gmail.com>
References: <20250615085943.3871208-1-a.s.protopopov@gmail.com>
		 <20250615085943.3871208-4-a.s.protopopov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2025-06-15 at 08:59 +0000, Anton Protopopov wrote:
> Tests are split in two parts.
>=20
> The `bpf_insn_set_ops` test checks that the map is managed properly:
>=20
>   * Incorrect instruction indexes are rejected
>   * Non-sorted and non-unique indexes are rejected
>   * Unfrozen maps are not accepted
>   * Two programs can't use the same map
>   * BPF progs can't operate the map
>=20
> The `bpf_insn_set_reloc` part validates, as best as it can do it from use=
r
> space, that instructions are relocated properly:
>=20
>   * no relocations =3D> map is the same
>   * expected relocations when instructions are added
>   * expected relocations when instructions are deleted
>   * expected relocations when multiple functions are present
>=20
> Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> ---

Nit: term "relocation" is ambiguous, in BPF context first thing that
     comes to mind are ELF relocations that allow CO-RE to work.

[...]



