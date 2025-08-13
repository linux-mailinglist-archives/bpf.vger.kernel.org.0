Return-Path: <bpf+bounces-65558-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C30B254ED
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 23:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7F615A1D3E
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 21:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C062D3731;
	Wed, 13 Aug 2025 21:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ZZ/d0ZJe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6D92BD00E
	for <bpf@vger.kernel.org>; Wed, 13 Aug 2025 21:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755118942; cv=none; b=hBJpflVdIKdi5cA6Z1797Dj3u7/PQqxAYFNVcoz8Q7oVVrvFwm+lmCvSM3zu//Xp+91IGvkAwJXUAJb3r6jkcYK0riyYG4ehiipkdHNzLaCJGVfQLjzS+RaaEeFgSlgD6QYdgVl5A/bCfiGpofh8He0HPvddbxnMnvrfW+iZOYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755118942; c=relaxed/simple;
	bh=7Sq4L0c2nWPTCDqZUHYRelBKQrlX/ySnaFOTeYR71P4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eCcBBMr5AmvEb0pVdBzRUGI4PlZUlBYuSxaD0+Zz0lLc1p0VaOjfSWp/0wZj0I/JvN8oVmkkUySvHWBPFok3+Mh/Fz/NRPZkOfj6wnLu4oJcCxor6wPoRqVP73ie5fXSQjqQt5gtW7jLBRiLVxX9vnDie0FKz0dsY3gtB6ltusM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ZZ/d0ZJe; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b471754bf05so209860a12.2
        for <bpf@vger.kernel.org>; Wed, 13 Aug 2025 14:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1755118938; x=1755723738; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PDYcmpvGq5GnRcKH/wXhuqWMX4zThVNazmLmfLUlg4U=;
        b=ZZ/d0ZJevw/kdMil5G3l8gW/OA1lrofeBfeE87R6bezEqe0NIidwwVsoNk3TooaZN9
         anBNfrFrwUdy8h2J50OQ4D/iZuz0e+FCmxkMWMl89q5iQE1x5NkeKPet/gfXER+8Maui
         E1LBUEo+JeYLc6ihBHt5L1s5u4T8VAS2W3IW7R+zKnE9d0McelIRdYmWZ/l0ytpY8cv/
         6SymFga1+H6UTmhswgJs1Qgy2M+tK4heo/TuhBv93bxFXRDAxaXvO7XZGbwFDGJNN0e4
         nDAwkHMDh7dU3vN3OmD/M3NAmgebrMQ2LiStOpAyk7hD6J5/vR5HP7SC/lQ9rk3+DJcd
         94Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755118938; x=1755723738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PDYcmpvGq5GnRcKH/wXhuqWMX4zThVNazmLmfLUlg4U=;
        b=jy6PUGPu5c4OnpVGxPUYpqInIrMN9FKqYrZ+7JJyGqGwLJfog+OD0w47aMoo7qvLyn
         rod8Z96FiTdEIA+2NjMThAdaABUDPq9uIJOdqK4ANlUcvIlNtWsIjITf9yI/z4V8BHv7
         zNZuVJUYIZxQiWfIdzqJCaWx3sItFXGZjWbCMaE1m9WusUWvcyTM710cE8Bwkn717YQA
         kDWc2J0InNTRzuPiA52rPnhBZf+qgjRcNp65fG64B3R9lYZ9KPq7VmUC90DwIlLiTdIH
         yIbuRIub8AS59NCFjencJfoJCPWhrsMCG3wVUT0dZKi2zfoi90VvOT04De7Uq2YDH9ZT
         XayA==
X-Gm-Message-State: AOJu0Yxg01NzJEqJamiYtDhJ3/U8pGA7xvWRM2eAGSzo1LXOa3UAkGB/
	O+8bN7hkA1aMcBJNoIyJrAAxS1ZfsnKn2GqMsHH3kzesuqz9273JXweEx4wzOYKBo8zegPmkv0v
	rm2x1y6SPz0+JaBwJNOMl09GADRzOp1S+bnNJBevAP5SeF8WWqWUY1A==
X-Gm-Gg: ASbGncsuvaHODmpmjbLKlCacs0MZFpvolTY8PBWY1F3L02PglhMPtijtudueLkGwp0w
	D3BxoE2hGWGc+OXzDtJD/sOZAAY+TJgnM1B1oK5iltiLmX8YMICybphfU9u3jHDWY0c60QJJIuK
	tPYzu3YZD51FcwGL7AGcHUQWb0wnHFdWBUl9pD+Lre75XJiHyWtHkGCaOz6XzZOY48H5LJYf9oe
	g0RHqY=
X-Google-Smtp-Source: AGHT+IGiYnCEJarZUMsQTkKeyOA6xYKcU8FKy/vval7IrvZnKFoHwiLj/QXM2eZhJhmHHcd5HZCnpE4B/A2FqlOY6O4=
X-Received: by 2002:a17:903:1590:b0:240:6406:c471 with SMTP id
 d9443c01a7336-244584d3ea0mr7225385ad.10.1755118937877; Wed, 13 Aug 2025
 14:02:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813205526.2992911-1-kpsingh@kernel.org> <20250813205526.2992911-9-kpsingh@kernel.org>
In-Reply-To: <20250813205526.2992911-9-kpsingh@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 13 Aug 2025 17:02:05 -0400
X-Gm-Features: Ac12FXzp_hhYxPxfyJ_yhH3oL7S216L16ifPT_wlsUm91HMM7nJa8jJhGAwjElM
Message-ID: <CAHC9VhR=VQ9QB6YfxOp2B8itj82PPtsiF8K+nyJCL26nFVdQww@mail.gmail.com>
Subject: Re: [PATCH v3 08/12] bpf: Implement signature verification for BPF programs
To: KP Singh <kpsingh@kernel.org>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	bboscaccy@linux.microsoft.com, kys@microsoft.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 4:55=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrote=
:
>
> This patch extends the BPF_PROG_LOAD command by adding three new fields
> to `union bpf_attr` in the user-space API:
>
>   - signature: A pointer to the signature blob.
>   - signature_size: The size of the signature blob.
>   - keyring_id: The serial number of a loaded kernel keyring (e.g.,
>     the user or session keyring) containing the trusted public keys.
>
> When a BPF program is loaded with a signature, the kernel:
>
> 1.  Retrieves the trusted keyring using the provided `keyring_id`.
> 2.  Verifies the supplied signature against the BPF program's
>     instruction buffer.
> 3.  If the signature is valid and was generated by a key in the trusted
>     keyring, the program load proceeds.
> 4.  If no signature is provided, the load proceeds as before, allowing
>     for backward compatibility. LSMs can chose to restrict unsigned
>     programs and implement a security policy.
> 5.  If signature verification fails for any reason,
>     the program is not loaded.
>
> Signed-off-by: KP Singh <kpsingh@kernel.org>
> ---
>  crypto/asymmetric_keys/pkcs7_verify.c |  1 +
>  include/linux/verification.h          |  1 +
>  include/uapi/linux/bpf.h              | 10 +++++++
>  kernel/bpf/helpers.c                  |  2 +-
>  kernel/bpf/syscall.c                  | 42 ++++++++++++++++++++++++++-
>  tools/include/uapi/linux/bpf.h        | 10 +++++++
>  tools/lib/bpf/bpf.c                   |  2 +-
>  7 files changed, 65 insertions(+), 3 deletions(-)

It's nice to see a v3 revision, but it would be good to see some
comments on Blaise's reply to your v2 revision.  From what I can see
it should enable the different use cases and requirements that have
been posted.

https://lore.kernel.org/linux-security-module/87sei58vy3.fsf@microsoft.com

--=20
paul-moore.com

