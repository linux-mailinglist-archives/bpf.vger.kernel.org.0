Return-Path: <bpf+bounces-64580-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A032EB14624
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 04:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57A1F1AA168A
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 02:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364AC1FDA8C;
	Tue, 29 Jul 2025 02:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mXwa4Ae+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA5B1CBEB9;
	Tue, 29 Jul 2025 02:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753755932; cv=none; b=lPZFykJpIBIX3F4qrnHznbw0SXiu9PiG0T3fV/rKdPOsKMuT/ZkzRQYz7cPCtn2ptqWo3sxg97TUGe6rTj3UgC65uyZINjBKPOV1P8s2qtIEd6dSeeTRS6dKUncDV4WYNvYeNZ9NnLIkf5erTqmC9vRpkbD1SPBwr1UyuglRBAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753755932; c=relaxed/simple;
	bh=PXjNhxEO4cFLBt03AdZO0iWMl2b6xnP3bx3pdGAHeF4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZnZUR+4/Em1LJtf/SQUu8ql1B1JXz9bIk1vm2T7xifnb+bCosJ8HErrHSZYBIVpFBzk+7U6ejJFpaoQnfEeObbX1goj08Z50RNpkGmX8QERmBwCPvk9K2D19mPDJFkBNNimkGleRsE6bZRPrQS0B4XtTQ/HANHsV39N2obq7b+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mXwa4Ae+; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4563bc166a5so2387045e9.1;
        Mon, 28 Jul 2025 19:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753755929; x=1754360729; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PXjNhxEO4cFLBt03AdZO0iWMl2b6xnP3bx3pdGAHeF4=;
        b=mXwa4Ae+j2Uxmis1x14JpE3RLXQtANKhOOcW4rVAix3lI6X0rHVc7a7S6SpvEJXZUw
         6HELfnqLadzQT/juE3B+ezJcycZsj78qfWWzJDkerhKIAMfPDVJEuLiGyQRQbZ6qfP8Y
         rQrQU0f9gMg3Zlr/gz7XGaS05bZp+ZKQBntkYus0vtVq6BxgPXmSfqXD1jJtG7dGkhhd
         TAsodn50qgloVzSNkI5hUIEs/ckcmlOFOBxIxO8I+iPf0UlaX23wLe+3/yGRBkhMAU9J
         WNVukNpLedsbz4OwuHMohvcr4z0PXExFHthneVQVP/ILz3FXscnz6bY67asHmzLtoc4z
         gRKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753755929; x=1754360729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PXjNhxEO4cFLBt03AdZO0iWMl2b6xnP3bx3pdGAHeF4=;
        b=RUWEvF20coeldoLV/aglG9tO+FMULs2UrwKB9FfTPt1LP9qUq1DieCdmBvoe/XBUAM
         9H14Y7oSkEpjIKe/jgpKHsm5RZxYSzV0P8gVlsSl0aU+VBXZL0z87u/F+Y+YaQdaNSgl
         D6MvYTtindFg99W6Zy8fslk8UEeNwlK1jWr51tvOf/fQGEeTf98GnDZyQu3aI+D4GLnc
         4Ff0GEriM3i/T30iGtur8Cj2Erztqrk4IHvvTMjeTFr0LnE3Z8uKKiApB4QFOQavXlDp
         vYGpJeoaze5UU5wu5W1qit9KWa/FR8AQDZJN5dQsMqCeLEklYz5YSgd9DH+j6SCJAPUl
         GXJA==
X-Forwarded-Encrypted: i=1; AJvYcCVAcy2GwbvzMrmu61tHAzXShit9M9AJfJjxllN0Q0RidAj25UI2uH6vFuFi+KwsaDa9wVew4DkrNo5oBT413pEfTlOygWc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9AzyGahn2rgWY0EXNOafmut1l0hU8R/FjD76KkA30u9wXc8Vz
	CBSw4OSks/WM+uEJBkmR3nKHWHzSP/ii5EAspaMx28W1+K/YW4O8PdAlkBobqoTLzZRCGPnMioZ
	dKBpyMba4PIwijBUeoZ6n+L5+hkE4Alk=
X-Gm-Gg: ASbGncvdGRVT3jko9uSNH6i1iHZkyX2ejToI5GZegC94aB7T3WcgX/YWsvdAvtgJBOs
	0rB96NjerRcB2iDbsnqbSdTODaS/+wy7+zf/0Q8ANJZk3h3bL7ETbICmRabs3rJlgzd2j0+NABh
	0mxnnBDxPb8mJKcgZoIQyAYViHf685BqKhyOFIiBlVZIP04Vs3nhdvwABE+eW97nEpzpxEcNSs0
	hSp9yBe2YWeMxqZtHbgC8x8SAy5hpIpTXf/
X-Google-Smtp-Source: AGHT+IFxWdvxsUSFaROqGAO4kc9bYlGfgMU5FeYQGxyZshtmoTWyG9OAzT7fCwhwcv4zB4u8R9TjxmSQhkx2sdDCqsQ=
X-Received: by 2002:a05:600c:1c1c:b0:455:f7d5:1224 with SMTP id
 5b1f17b1804b1-4588d1436cdmr12053535e9.9.1753755929084; Mon, 28 Jul 2025
 19:25:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721211958.1881379-1-kpsingh@kernel.org> <20250721211958.1881379-5-kpsingh@kernel.org>
In-Reply-To: <20250721211958.1881379-5-kpsingh@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 28 Jul 2025 19:25:18 -0700
X-Gm-Features: Ac12FXyXkvO-s_DSEDn3fu9CiFiIsNhylc30Gc-pELDTvkbFLbAFfqdL70qwydY
Message-ID: <CAADnVQJ=8Y_k=JtbNQuhTTCJn33iAniAEh6MLN1BfTZ6pmP=WA@mail.gmail.com>
Subject: Re: [PATCH v2 04/13] libbpf: Support exclusive map creation
To: KP Singh <kpsingh@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, LSM List <linux-security-module@vger.kernel.org>, 
	Blaise Boscaccy <bboscaccy@linux.microsoft.com>, Paul Moore <paul@paul-moore.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2025 at 2:20=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrote=
:
>
>
> +/**
> + * @brief **bpf_map__get_exclusive_program()** returns the exclusive pro=
gram
> + * that is registered with the map (if any).
> + * @param map BPF map to which the exclusive program is registered.
> + * @return the registered exclusive program.
> + */
> +LIBBPF_API struct bpf_program *bpf_map__get_exclusive_program(struct bpf=
_map *map);

I couldn't find patches where it's used.
Do we actually need it?

