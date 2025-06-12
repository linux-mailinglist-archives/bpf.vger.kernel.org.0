Return-Path: <bpf+bounces-60538-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6036AD7E67
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 00:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A8F73AA21F
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 22:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3CB2DECDA;
	Thu, 12 Jun 2025 22:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L4eS2pJA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F74E537F8
	for <bpf@vger.kernel.org>; Thu, 12 Jun 2025 22:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749767516; cv=none; b=Na/qkhCmCB/9LnEvt1BWNFyBhoFA46r8xKF3UjA8BN8qxjam2M33y1Y6G4c4kvxZ/G2MBsaUsRqsaLQUIIzPlP4x4ZkPkepwqNYGJT8EERWPju3ChSmzJxqseOYzfGXZOrWWIu0SFHJ41VYZeKhEC2mHw3zSP9TbbZkUOcid334=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749767516; c=relaxed/simple;
	bh=hWB0LQCpJbfqKCVsdYazGfoaGtXFlxzjTZZvxlnEAcU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=atgi9vOL2kYnOIomktrrpM8mjQdJqBalSVL4L9u+4ZAEKYC6DxTdH4uUQrs0ilwwIXzQ2oG/02N6iM437svJesWzc0EfIhZmPqHxaYPlGjHhCBMZdsMQsHjUXoH2FRBw5dVluFPSDSqLRsSccxcToxHis/klFd1fLMUiEMYc4Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L4eS2pJA; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-74800b81f1bso1341342b3a.1
        for <bpf@vger.kernel.org>; Thu, 12 Jun 2025 15:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749767514; x=1750372314; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=q2i1P2fmw6QsHciuWzQuYT+n/Sfc7/3czVKL3lb/Fns=;
        b=L4eS2pJAp1DFbaueup4U5+DsGEMySGlQr1aPwP5sy0ARt+eaveckODVHOgQdjIWMVO
         fW8wRzbUP8GhN7F5Z/ow5tzaNeb0Vl2wS8el86P8plhOhSqn7e83K1wxGpiMrTqZP08w
         gvkzOFOifmfYzhcHCLNx3EqJ2j2G+SfZbEb57HUOkv79lFQhGqHxFSoV6bVorqy/CpAc
         8sPLKk+36XTMDlgSLTP5BcTklX5u6Rytpe0N13t+69TRAoB75pIcnoRvuLIajdNG5I33
         14sBeh4IZfckTAS8YJaW+uJ8Hzyc+31Qso6y7+EoXfQVU04YekxPGf4b9kL+ACIbcojs
         /7xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749767514; x=1750372314;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q2i1P2fmw6QsHciuWzQuYT+n/Sfc7/3czVKL3lb/Fns=;
        b=HmKvhqPWXn9a5Q8nFduyGt2q/ogXw7ThpFTMk3cqL6sINDvURDSBA86ZyhmqRG1oyg
         f52NHo3N9vntCcFL1TF00mtL4BT616JNQZnuDGA/O+222yIQBsBZ5VODvWn+NcTnycLQ
         vNOS3fcm3g6SrVhlO6GS2LRX3W2OjhGdKCFNEu3ccxpvbKEv5NJ+k0cyyKw5lDXDPbAW
         EidyKRXBLIkKi6NZZnz/57Rgyp7+xUxngHgzseJa8rTpj30CsPtat5qh52pFpkkmnksb
         bwAjOqtpzJJ5ZCEzanPcrTYjScVlc128KpvPy2jbvqYRKMJUFCN6nMPWG9xrDgKfCTjp
         mtqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTw5jtPnbgP8Vpj9uZS80ZHKEpwv0HFM0NtHI7WzajsO7tTLZAtBI8HUeHqpOgOYH1w8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNhAEvIM3l16G3Lgt/1h4zpxMQiKBOK65VRP7Z5zmJpS9vgRxS
	dr7LovkRrE+pJBOXJEPZ7x6t5sndpTxs+o3tEb6XoA8XGi6em4x2XlbkJE9Z8V/SxWw=
X-Gm-Gg: ASbGncuF9NAkbdjvpBOn9qSHBudknFdtDDlKo/IfmHZh9FoLlMO8LAVH2icHPVuuwcY
	EtJvZFbIZUibaPY9h4iaXNwceXbWT4WNtTzrlWNfeFTD4JZBfFQDQzSt5NpKc4OxXRYd4f4c/oO
	JXa5gbvMkGVaA+a/CnwlgUFiJSAxsbn39Thzqsj+AgWlq6xgL4WaWdV3WCiRW1kb1zLiBdnVlne
	QvmoEJrBxxN3jvUBaCk0Laj7352V2OArdP+wPsrsBCnofB1I7Yt7SJ8UU2TPiRHONCfxW5rHVJ/
	J8wnDVy0uMOZtQJxaEAS55uUILHOahu6MXBWnpVt6xVW8dQMw3xkSIM7YXE=
X-Google-Smtp-Source: AGHT+IFXB94oVmXUBdFUeVEANCVgt/s7sKdzpiGu+F1BzFH7L6ZB/cVNhuHAsPR41Rl6PN2FA+zkzA==
X-Received: by 2002:a05:6a21:6d98:b0:1f5:8153:93fb with SMTP id adf61e73a8af0-21facbde981mr791889637.10.1749767513723;
        Thu, 12 Jun 2025 15:31:53 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2fe163a498sm235109a12.15.2025.06.12.15.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 15:31:53 -0700 (PDT)
Message-ID: <52242417d9fd90cc13c0bbe009adde93384a4748.camel@gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Initialize "tmp" in propagate_liveness
From: Eduard Zingerman <eddyz87@gmail.com>
To: Song Liu <song@kernel.org>, bpf@vger.kernel.org
Cc: kernel-team@meta.com, andrii@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, 	martin.lau@linux.dev
Date: Thu, 12 Jun 2025 15:31:51 -0700
In-Reply-To: <20250612221100.2153401-1-song@kernel.org>
References: <20250612221100.2153401-1-song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-06-12 at 15:11 -0700, Song Liu wrote:
> With input changed =3D=3D NULL, a local variable is used for "changed".
> Initialize tmp properly, so that it can be used in the following:
>    *changed |=3D err > 0;
>=20
> Otherwise, UBSAN will complain:
>=20
> UBSAN: invalid-load in kernel/bpf/verifier.c:18924:4
> load of value <some random value> is not a valid value for type '_Bool'
>=20
> Fixes: 6b3f95cd99f8 ("bpf: set 'changed' status if propagate_liveness() d=
id any updates")
> Signed-off-by: Song Liu <song@kernel.org>
> ---

Should add UBSAN to my config, sorry.
There is also a `tmp` in __mark_chain_precision, unitialized as well.
Could you please re-send v2 with both fixed?

[...]

