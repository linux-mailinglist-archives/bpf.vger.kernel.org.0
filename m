Return-Path: <bpf+bounces-53411-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4670A50E29
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 22:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03F23189081E
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 21:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26FFB200BBF;
	Wed,  5 Mar 2025 21:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WPD/LN4Y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FF6263F2C
	for <bpf@vger.kernel.org>; Wed,  5 Mar 2025 21:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741211380; cv=none; b=NdKquvFeekd6yFMxHjwtCBIaGx6aZrr0NmflOrzYTtJ46IZ9UgV1J3ATfWG2nnZ4Cj8PtvIiQcUFazxoUk8Yp0wa3b6S6nXNeRi0Pmd/RysMyscQTsqKJg1ulqNYNCvu4EvCyQguGxENTAjGXADy7CZ5cDNb+j2mD09c/oNEqB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741211380; c=relaxed/simple;
	bh=lmIwy2I80VExNUNBA757/lzceVxR1DFLnE9StkELmng=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JgPWGpwvZTkE0UQQ/VsnotdXQ7NMJoCuVJPd5hR5QMvNpWXAzHPArz9aTaBksP1pcc2lo6Go9kFNEb6KtPbocnWtqWABdiC07QfFcZIJ9GXuXccG4KpNSIoJlZJOYwVh8yD7XjGEGiTHMRqpb+KOvj0794PyQv9Lz9IM+YLrdsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WPD/LN4Y; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2fa8ada6662so61088a91.1
        for <bpf@vger.kernel.org>; Wed, 05 Mar 2025 13:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741211378; x=1741816178; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wiiw19kAZWdCjQXoeL/8ynzWln1CbB5iTn2WUA05axg=;
        b=WPD/LN4YX2FnFR/ldSp80bFrq7tDXD+CBufgPHWMY5HZbRSDndYrDHmzjwNWJAYACE
         hQKjgkiUBSlBPauYcw6kJCsRDyJ5ulVEDEJ8viaBNL4sRyDxeHNEKCkJFAH+EwUeDlCi
         xrxxFVgcMl8qF3HxQOp49ADE+rQxfWbmZYSQGytpmONT3CSSXqwETPUzhSQbK5756Ljl
         lmAGo6E1TKl8pLqUFTfLjdRTl6xbO9pI6fAzKw+B1qjHjzhWYah/4ZNXlegVzv+qcOsL
         3wKKVRShOPmJffk8I3eOGDYUnKSmtaA28ZZDI4AgWE/dvm7LhacmltEccrGXpTPokeUx
         GmbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741211378; x=1741816178;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wiiw19kAZWdCjQXoeL/8ynzWln1CbB5iTn2WUA05axg=;
        b=njPcQDj91l3csuEgXvbyREWrrRaiWZ102N0edFhS7x0TjjNIpKxSYC02W3t+vJ0aP0
         ZK6o9rZoW2o2Dumu448JX1TZRXNO6HrCsnHNDucr4Fc/ekaaCBaTUQIWUzFTyE2bjGzi
         7ZTxm6I9k+OySiYRYw4N3i/1lAJOw3SW85Z89tpA9LXTqkFVnDxb6uvT9HY0U+lPy0xZ
         S8D7VlhNeyxrErYRyATYZpbXPpAR6vVpWQXIjhA6g+fa5BGE6Jm/2Z7UrCViLtAC4P1C
         2KXELAyCXEOnTRsQmUSv2tUl8Uq9yQU685nf0S+TdF+LOnRGKs4nWx1gMVkVvTSEgkV2
         BVYg==
X-Forwarded-Encrypted: i=1; AJvYcCW2+kP7h3a0jEW9JTRhGamYJKwK3UWRoHcwIOdXZyoADwBvrimXNQw2B5W6iuMW1Xppr7c=@vger.kernel.org
X-Gm-Message-State: AOJu0YziQWF/FXj2J1nrMwkCgopaPF1XjY5dGydrp7GmlUU9j095MaaH
	2COlO5341JZgp4HJORtcSG3lWMmJ6VUsjdGnItDMQzsLga6D80BK
X-Gm-Gg: ASbGncuWxJRHIIso8kTcJcysiqlXhMOqjLj0KWKSn2EGOcdHUoAdz4cthdGa8M9bDQj
	QyN5hajQqIbRg9a6ge3AZIV9oXuTSQifZ/hkUE/kdeUdMdO0Jn8OXumrDtMCKNkUzZbL0vPnhm4
	/5RtgN01I9l6dfSAEm2X8IhdzXLo1lbDGJvVqZvXLGZPJKVmxZ7Uy9UmRURNXQENaPUGpoGgJl9
	SwLP5xPX1EDGVlm17G5LN/WpecwFbr/CKEvm/TqW1Q5OJwkP45lGhgcLnPTXUSPukTrydoaY+W3
	Vp34QUkZhkeJwTqQeHb4FGgcKD7iFrHLRkmYjUVtew==
X-Google-Smtp-Source: AGHT+IGMy+AM3u+L7o6jSo56IaAEvL9l5dV3TaW6yN6rmMKN7xlemTCc1u5qn28mIAA8p4ZwyArL0Q==
X-Received: by 2002:a17:90b:4a42:b0:2f9:9ddd:689c with SMTP id 98e67ed59e1d1-2ff497e1858mr7557210a91.25.1741211378251;
        Wed, 05 Mar 2025 13:49:38 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff36bf935dsm2055314a91.2.2025.03.05.13.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 13:49:37 -0800 (PST)
Message-ID: <479c41369692d6e38e096b7b8cdfa8d9a6576ea1.camel@gmail.com>
Subject: Re: [PATCH] selftests/bpf: Strerror expects positive number
From: Eduard Zingerman <eddyz87@gmail.com>
To: Feng Yang <yangfeng59949@163.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, 	kernel-team@fb.com, martin.lau@linux.dev,
 yangfeng@kylinos.cn, 	yonghong.song@linux.dev
Date: Wed, 05 Mar 2025 13:49:34 -0800
In-Reply-To: <20250305022234.44932-1-yangfeng59949@163.com>
References: <20250305022234.44932-1-yangfeng59949@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-03-05 at 10:22 +0800, Feng Yang wrote:
> From: Feng Yang <yangfeng@kylinos.cn>
>=20
> Before:
>   failed to restore CAP_SYS_ADMIN: -1, Unknown error -1
>   ...
>=20
> After:
>   failed to restore CAP_SYS_ADMIN: -3, No such process
>   failed to restore CAP_SYS_ADMIN: -22, Invalid argument
>   ...
>=20
> Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
> ---
> Changes in v2:
> - cap_{enable,disable}_effective return -errno. Thanks, Eduard Zingerman!
> - Link to v1: https://lore.kernel.org/all/20250304111722.7694-1-yangfeng5=
9949@163.com
> ---

Thank you for fixing this.
Nit: for a v2 of the patch please use '[PATCH v2]' tag.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]


