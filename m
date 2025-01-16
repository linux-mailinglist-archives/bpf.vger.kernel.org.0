Return-Path: <bpf+bounces-49083-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E54F7A1422E
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 20:23:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1246716B4A2
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 19:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85EFD22BAA4;
	Thu, 16 Jan 2025 19:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jtVz1zpb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41DF4414
	for <bpf@vger.kernel.org>; Thu, 16 Jan 2025 19:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737055423; cv=none; b=OIFgW6R7etutcpASNuXPW6P7ZWj2XQVvFXcyuMzyXbKOx3CnPsDKNJgqHDlTacj7pkpX9dRYz3kSCyKYIkZ5FPA+MMJcqqFpG3Nb/vQf7YU0jQfayP6a030plvJsnTwAt7DKUcbecRNYrxnCjlMDuv0H1UmeLhLiopYQYZ9broQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737055423; c=relaxed/simple;
	bh=qNH7uWrq9o1LUuILfATBboGm2BuwRfheGX2GcAqYbyE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PUL+b/nxHdFb58vPC+O2GnMaDtYwbLEAmv1Uw4dDU6YqODYxXk+awAmblFXcgp0NOsKaLEDTZ+pf8H6HFtsLhQS9KNcMabICH1tygtUybDqkEo+dBy+kcVi8Fvsun/pVzR6CyIRxAPr705j5iV8/FLuWs+4SHHOZ0AWRg6UULhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jtVz1zpb; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21619108a6bso21690505ad.3
        for <bpf@vger.kernel.org>; Thu, 16 Jan 2025 11:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737055421; x=1737660221; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2ByCc1fZsPY5noxSDBDKlMCKmKd0CA1tfO9Shf1zaSQ=;
        b=jtVz1zpbKGu8f3MMpV0NANPowTPmMzenwKmGDP7/u2UexYrUswwxO/et4isCgviMCI
         c9CgmNJ8x0tLVR7IGYpyaVSzQLgdjgOujGBRd3a7tx3CrTRjk/wla7Olv7kZeWn5m9/a
         lIRJCf7WhwoRu6zaB7h1bftDARu0M1mAn4nbziJ5+dhzSNBqk+sSiAXYzWUx+WkY/5dv
         ealPfdnU2//8ZmmvX+5hqOEasRCdmfoDpK9MS2mPmMY7/+waShNmXshfyI00+viH7q0w
         /MrKCxyBL0vURy56QJhVPV+vWtMhZHgombci2nmWDY7YRdFhDpZON4jrbykvSifbdM9+
         tbrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737055421; x=1737660221;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2ByCc1fZsPY5noxSDBDKlMCKmKd0CA1tfO9Shf1zaSQ=;
        b=JwbL+IXnihlHgfruPtwkHnXKp3z/CYamQ2cuj9ZvqxA1FNWSC7uviT1BQd1f9vqU9z
         k6G67bRydCZu8qnM+Y3fExH8Ve0NfvKG1+r4xlM1/7p/D8FKpVItyWOq79V/dtgaKvi2
         eq+V6k/Ly+QU5HTKSJfyOeyOnum2QQi0MOoJylQV3W/8nvq1SsPkMLfKtl5hCdLbXDdX
         MzP7NTKk64GxOhE+x5t8Jc9YLXAD8RGcwMXGHC+mWDb+f2UMgZ7iTZPD3xIzmGpFNZRz
         U91cOSP6WkEGlG7Nadi6vJNfD0T7dQx0clKlHuHcaHEeVZHI3y4gWZowsmAxFhBlykio
         cstA==
X-Forwarded-Encrypted: i=1; AJvYcCURWz6hrxdqMeMZ+eUReVWcQnPznrJN9BmhYZApiGyebgD747x8TRH4DENzQz1XNUboXHU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHqCpXQcIv0ZGcrWQ2c2i+x3Mt3y0Dup4wdsI8oQ5d3SJ47d4C
	77ZFQpANSReCtcsiYdH9MokR+62hOgX7430LqixMCyv4EeEht2le
X-Gm-Gg: ASbGncutnw+DwNcBYq5346PgHgM/mUahdnQW1fbByMP/mHHyqolB4mlUqLpKYWjOAPz
	R1pLkIuedVKEGd4GvLlerav+tt11mYznM9MW4GRESW9k9pnDq4tso5mNa9D+RA7Yg/XJpDpcggz
	2zVjZVkRUPyiccpTntD1XXSNvoni/YGAtaPnGo275z5BOKBQQ6DTf+778sI4dR9lmECI6gnNNxy
	Q7yl/G0i9m99G3b6xQcPtpm/nh6KRd3Ag5iD/JC8BYWlWcj/PLxdg==
X-Google-Smtp-Source: AGHT+IFzQyYuRvdHwei6nFADJeXLGIl/YL9K1/jTGn3fLDFTYbGuiDjk7OZ2fzuSNtuzj6OCxNHKNg==
X-Received: by 2002:a05:6a20:a10e:b0:1e4:745c:4967 with SMTP id adf61e73a8af0-1e88d0dfa1dmr52383987637.3.1737055420973;
        Thu, 16 Jan 2025 11:23:40 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-a9bdd30cdecsm389835a12.57.2025.01.16.11.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 11:23:40 -0800 (PST)
Message-ID: <ba55fbfc5333a9604b482a62686b9aa8652d47bd.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/3] bpf: Allow 'may_goto 0' instruction
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>, Emil
 Tsalapatis <etsal@meta.com>
Date: Thu, 16 Jan 2025 11:23:35 -0800
In-Reply-To: <20250116055129.604354-1-yonghong.song@linux.dev>
References: <20250116055123.603790-1-yonghong.song@linux.dev>
	 <20250116055129.604354-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-01-15 at 21:51 -0800, Yonghong Song wrote:
> Commit 011832b97b31 ("bpf: Introduce may_goto instruction") added support
> for may_goto insn. The 'may_goto 0' insn is disallowed since the insn is
> equivalent to a nop as both branch will go to the next insn.
>=20
> But it is possible that compiler transformation may generate 'may_goto 0'
> insn. Emil Tsalapatis from Meta reported such a case which caused
> verification failure. For example, for the following code,
>    int i, tmp[3];
>    for (i =3D 0; i < 3 && can_loop; i++)
>      tmp[i] =3D 0;
>    ...
>=20
> clang 20 may generate code like
>    may_goto 2;
>    may_goto 1;
>    may_goto 0;
>    r1 =3D 0; /* tmp[0] =3D 0; */
>    r2 =3D 0; /* tmp[1] =3D 0; */
>    r3 =3D 0; /* tmp[2] =3D 0; */
>=20
> Let us permit 'may_goto 0' insn to avoid verification failure for codes
> like the above.
>=20
> Reported-by: Emil Tsalapatis <etsal@meta.com>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]


