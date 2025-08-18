Return-Path: <bpf+bounces-65929-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A18B2B432
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 00:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55F8A5828AF
	for <lists+bpf@lfdr.de>; Mon, 18 Aug 2025 22:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA08E2185BC;
	Mon, 18 Aug 2025 22:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bnzc42zl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CAC3451BF
	for <bpf@vger.kernel.org>; Mon, 18 Aug 2025 22:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755557246; cv=none; b=RHQ88BEFzNciEQSR7BYHOcz9fUifFJDwJ1pFTae37vnnZ2lIFOLUiyco12duTYmOu9weEAfbNCxTRBbjTdx9gLiXKiCnFHk6ofCVAzeb2COTAHbY9Bq8dE4XeTYvwRiCIZLUouvyRv4Cntv0ZrzCQehg2gihgj/SFC6FZLdAqF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755557246; c=relaxed/simple;
	bh=vgIWHNpy2bm3u8sSZ/2Rbz3+EV4mw5Lfe1/dcIqqvX0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Hle3WsH4Hj/5muABca9vhnYDat8P+MTnYowh/PWpSpiZzQJkIJhUszOR9WC4Xi60rsWUpHskPFX+iFrDjPqNJ2PRN41ij3lJlcnStU/SINpXeCwCI2QtXaZD3QtfeD0JFjtZdp4O3TYul66LFW4NR5Dwkh6vupYs16y72CzmSxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bnzc42zl; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b4717330f9eso3313823a12.1
        for <bpf@vger.kernel.org>; Mon, 18 Aug 2025 15:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755557244; x=1756162044; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4rCI6LDx9w/jkXkgmagrXi8QYY1Oyi2+zQNeEICpvlw=;
        b=bnzc42zlnwiXfAJbU7HP5X0fCiH33nIz5n3Z/UMqUUvmZL1D+ddlAhGE5WIN4BnpR5
         93x7jWHRZXIUKlyfXsTOtbvGhOruV7ezalb+GjpaDAHOYcp/cefb2GNmGblWnnKfyCiB
         wXDIuIIivz1cMyW3RF+T3coLddzPqFdNLCLX+uWbpwYnow9f60b7lvvZJslv/TiOCFo4
         G8DHfIzYQed4qHDAxiEHxBD4csk8XjHjXVBdGkIFIHiZdu+277oyLhD/etVEqTmPaDOV
         BMHTcKFotc4Hl8FHxzIDmpGZ4BMmrU2ZspT8mCXhncu8F1hGobMLbAk+TXUF4gZd50UA
         vOpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755557244; x=1756162044;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4rCI6LDx9w/jkXkgmagrXi8QYY1Oyi2+zQNeEICpvlw=;
        b=o/hmmEwReDWrUpt+II7kXNah9Hq1P3XEaRVponmDJbxGAPG4tMPPO/LwB3JpC5u2o6
         MotZOQc+WxtgRIs0o4n8JIwnrWmPN9sGjK9Aeno0gStbP5yUPsgJCIeyJLUdpilT+dw6
         eF0mA7zKYexWat8kK0ZDOr0+frrsKNJmAg5eFnpAlN7NwPMSM/JF/exaHDW3DmbKHJsG
         mHCWTPNw8RbbZLTHJHA6oJhZRKLs4iPZSVH50LybIMhAsHD5zlL/9Z4vV3DjZC73GvC1
         DbBdOKt/vPbre7hh3FNpVq4kJiyFA06qj5MZQYy0UITpDkesHqW2f2wqVZ8GxFBwW5t0
         J59g==
X-Gm-Message-State: AOJu0Yy8Qrm6kQ0L9Iqz9nstbMg2oHz65jW+qv7NZdt0uRiBtlA/ihMy
	XRYBjEeTfeFLYMmOGsv/PWqs/IpGRQscj5gp4kFy92K9aDjnXVKktclG
X-Gm-Gg: ASbGncsum3gLY9+tV1aHEMBn2tCI3Pcsy14ZMDylWm/zu9eRmCFFy5p6hqd/z4xJ5XF
	vw4muDsoHgQ3ot7kbYHdGadSTM9J1hOIlMTLWbWPC+PPlIQY8ahwnthds1NP/kwaRzQ+MZuAnwf
	ibyPT6Ms9+VR4FCpfIIh8VNhgVHY39T929mB7oJxnQz5fvHY5bNOdgJl19syHNphv1J+jtNtuH3
	O5P4I0MkK3kFe3fNR24XpGxMGoRsgSF6pRt43RvI/FlHeWKZQQw/SP0jnK0Y/o56Xze9qxBAQBj
	ILU9pZXgNbepuXIYuF7++7WgfbUSca+It/xbmUis+NT5a0tS3D+YNM/hMtLYtj7zE24VP0PROAa
	NKuw24vwBxJMHI7zZvmuf3Vk0NSDo
X-Google-Smtp-Source: AGHT+IH7gDkSKrZHfj9iCZG4iTB+CA/Yta6HVRxgxkXzAD7pZCkIXimr4Ng7mW83r3rfCa30PHNJzg==
X-Received: by 2002:a17:903:46c8:b0:243:e324:a36d with SMTP id d9443c01a7336-245e0307a9amr4154285ad.23.1755557244497;
        Mon, 18 Aug 2025 15:47:24 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:14a::8c7? ([2620:10d:c090:600::1:2a59])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d547c0esm89611995ad.123.2025.08.18.15.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 15:47:24 -0700 (PDT)
Message-ID: <1cb633fd44d74459d2ac0bb84fe0233d56b76242.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next] bpf: improve the general precision of
 tnum_mul
From: Eduard Zingerman <eddyz87@gmail.com>
To: Nandakumar Edamana <nandakumar@nandakumar.co.in>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann	 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Date: Mon, 18 Aug 2025 15:47:22 -0700
In-Reply-To: <e9549198-f0d6-466d-a104-99b228d35dde@nandakumar.co.in>
References: <20250815140510.1287598-1-nandakumar@nandakumar.co.in>
	 <e7cb82ac838e28620324f70907235d2b8c75262f.camel@gmail.com>
	 <e9549198-f0d6-466d-a104-99b228d35dde@nandakumar.co.in>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-08-16 at 10:28 +0530, Nandakumar Edamana wrote:

[...]

> mine vs kernel (bits =3D 6):
>  =C2=A0 better =3D 285059
>  =C2=A0 same=C2=A0 =C2=A0=3D 229058
>  =C2=A0 worse=C2=A0 =3D 17324

Did you found any patterns for cases where new algorithm fairs worse
compared to current?

[...]

