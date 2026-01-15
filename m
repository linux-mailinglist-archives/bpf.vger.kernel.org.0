Return-Path: <bpf+bounces-79125-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC92ED27E3D
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 19:59:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B93330F031D
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 18:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B283A3C1974;
	Thu, 15 Jan 2026 18:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T0bCzxLh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92642E0925
	for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 18:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768502779; cv=none; b=riv+YRc+FHe1iPm9VVWl7PJ+lsEQ0vGFk3aRp5lRH/4h2WqGq4o9JExrTwO1ztOJBcp2HfK01/iKHI7wmnvcgkmQ2jLGD9gSvuc+/+oernrwTkAU59SsSeJ/XU694T8l4d9hp9NOw+9kffE390OrTL7RC815SgMUWGEzl1If+D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768502779; c=relaxed/simple;
	bh=Hn4heZb/nreknw+fPjHzuyTDewzMGMs0XNHjB30wtRg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XwI+GXi6mtOByngq/LsOzjYWgniCcd0KcTqpgIX6mppXq25KmccIoJx+xbtpM6/pEtDa/ZJzIYjpHvy+O/0bNv9JbZXm92zksIS9gk7IGikn0nvr+9EmOhAi3rEgdI2Lq++082E0Pa1wNfWC1sZdZ9zTd0dspa+8GUBot/jM7MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T0bCzxLh; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2a0d5c365ceso9282275ad.3
        for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 10:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768502769; x=1769107569; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Hn4heZb/nreknw+fPjHzuyTDewzMGMs0XNHjB30wtRg=;
        b=T0bCzxLhqw07vGrh3HjdLtlqOrKBAzHUXDrYe4VWsbjcXpjcKdY/pSR5JxaKUreeDA
         bwWxRhOQO95L6ZYeI5K9DLWP8xU2rPhpP1vlOY2m5ciD6bYSjvHK72KvbFM2RqKAHejQ
         MUyuU/SYZX7hpcUjBIAFNXnsRgB4vGpju8VKP8loViNdmw6WIwTyaSXRDmw7ZnuK1EYt
         OkOyso6Igg/skfHwbhLm+CvQ/HuXx0/iOkZu5RO2iG5grxwonKAgy80Lz0jc4hj3v4Pk
         Ry110mygxlOlk4iqr1WCbdK2Z0Xo1qS4J2l+uUI8pw+Jgt5o7cjTBRLouGmF8AuQ+dQQ
         IQgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768502769; x=1769107569;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hn4heZb/nreknw+fPjHzuyTDewzMGMs0XNHjB30wtRg=;
        b=n+tGViZn7g0ZzXNemn6TcGaH1N2jJJ7sc7oe9RDp3Y4Ngp8FA20+qihiIcw9AR/oED
         hXu75SIYV3Vkmq+wL67mhys5whtVKBveE/nw/H8jz0oHmesbSulNXFhmU0msA5H9EGdJ
         p/XB+rkIu3Jo4XLc9wXMIDS8N6fN7uWmC5XW3NIcMU9r3NiOex5ao1ot0p6MYpkBYfc4
         ysFqmeAAxAlqX7NyX6heape6q0PfO1xWiqPyxu0nxkA7EB+XfoLRiNGsIs2O16oQDN7L
         bPy5nnyORvfOzyKSW0Mr//Bv+XdeuGDdy84TPsWx4R3dBtFXtEUDV27PNwgWv4TvgV2L
         uk7w==
X-Forwarded-Encrypted: i=1; AJvYcCUprAwPYBJHL4B9nENLPz6J1lf8HrTp2i+bb0cJVBCLdfa+bR8Hg41jGea/2qE4BBFWbwA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEFbICEeIzFpbbs7Odspk1Ih4tgcTfkx4o/Ha0RUE3BTtbrjhM
	WPGeZos7R5LlowSz4jr3CGR5vzRKygiw/pMX2XBkgrMbD0VwTYny+rEE
X-Gm-Gg: AY/fxX5XmkR3a4d1bYefYVqiEAbmuy8rnymbiLIQXk3XFPe7S3fTKzYaHZSLKT0+xgV
	Jc768FFZ36dgfWnpC91Xtgg2uR9/aRXrviVJgxdXrMtaTlfO+kQmAddb1yaNAnYxp44GDqkaWUe
	MyXd3errjW+lwvaenR/8obawasPYcsr534VhHmc0uOEF4JJNvXy23E+kOAwIFtXUVH9uJTCitON
	HXve2M59nrmnJ49KTJ5bQ82p7Vgqz7oEZcWEmqpMLWz0J5hwSUS9FVl0xD1lgl5smqzy1ZR6ztS
	LlUvO+neASoAHGQN7qz+VkwEDqClAybQyayJQYdR0CjVrmN58g3Lr6F9/516ZPKoq4XMhvxMuJ4
	cvQMEYOe1Yl4+/ni0/OAt39j9NMw8YDop+XGpNqvIB2w/il1tRcs8nsAKG6Rymv+szGOHeq23D4
	ZOub5uZ3TVU+dLPvxO2ehNZaT1wmutHmtZFRCuPT3+ZhjP+6YA03A=
X-Received: by 2002:a17:902:c407:b0:29f:b3e5:5186 with SMTP id d9443c01a7336-2a7189733b9mr1643135ad.56.1768502769136;
        Thu, 15 Jan 2026 10:46:09 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7190ab96fsm461235ad.13.2026.01.15.10.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 10:46:08 -0800 (PST)
Message-ID: <b010e4c8352fffbbdec683cae4ad46b9bf5fa419.camel@gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests: bpf: Add test for multiple
 syncs from linked register
From: Eduard Zingerman <eddyz87@gmail.com>
To: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay12@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Martin KaFai Lau	 <martin.lau@kernel.org>, Kumar
 Kartikeya Dwivedi <memxor@gmail.com>, Mykyta Yatsenko
 <mykyta.yatsenko5@gmail.com>, kernel-team@meta.com
Date: Thu, 15 Jan 2026 10:46:05 -0800
In-Reply-To: <20260115151143.1344724-3-puranjay@kernel.org>
References: <20260115151143.1344724-1-puranjay@kernel.org>
	 <20260115151143.1344724-3-puranjay@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-01-15 at 07:11 -0800, Puranjay Mohan wrote:
> Before the last commit, sync_linked_regs() corrupted the register whose
> bounds are being updated by copying known_reg's id to it. The ids are
> the same in value but known_reg has the BPF_ADD_CONST flag which is
> wrongly copied to reg.
>=20
> This later causes issues when creating new links to this reg.
> assign_scalar_id_before_mov() sees this BPF_ADD_CONST and gives a new id
> to this register and breaks the old links. This is exposed by the added
> selftest.
>=20
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---

Confirm the test behavior on master vs master+patch #1.

Tested-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

