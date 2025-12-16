Return-Path: <bpf+bounces-76726-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE1ECC4A3D
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 18:23:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D52BB3064BFD
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 17:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FDAE2C17A1;
	Tue, 16 Dec 2025 17:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mTo9RRel"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D6519CD0A
	for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 17:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765905612; cv=none; b=VRqgDuCY978Z9DKom/6RF0OtzREvnB8zAf0T+6l/z9jEIyXCcExGdGjTGyfWeayNNoLqtzpiUPi0wAzs52VYuhOYwtEF+HJALYIYStHol233YnFuuj+vgvMhtFYvMRXm+ls4cY4SVKnNR369UDXweQ01jfGNDdIdaucNrTgpv/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765905612; c=relaxed/simple;
	bh=Q3xSUzpZVzpM72qz1ELqk18PlnXt2ts3aZ5ceF8wcGg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DOXizFRR+9XcpRYNB7yxq7AK78akjAcMrPZhH0Ig4euMJc8WRuBbMRVKUR1r5GEVK+IL8OUCJZFSjI3VwqaIzOTx7bdHLzUm2ivCgp0/M3Yfa6i/+8X7JsobTL2Q+Am7y6cXnlFT9LVZ89Gw5hgclzQiTJOOtLXDTMFC3kN3N2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mTo9RRel; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-42fb0fc5aa4so3490282f8f.1
        for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 09:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765905609; x=1766510409; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q3xSUzpZVzpM72qz1ELqk18PlnXt2ts3aZ5ceF8wcGg=;
        b=mTo9RRelNpvtIRN1FEebCYtoTjkOiG75JQRTOkKdRTOmyXkP7RUOdyzXE4tTIO8jQa
         fuLzY5CBaeN18rUvUGKNvqN/dHonBaavBLsim/RoJ97AqdzQU1A/B1c/gX2C1BswIwlM
         3wKa+WK9LWJ2HHfCCjgpdfxx1ZVzFfr0iSAY9yc7S6FEhd+JezPdXpbRDSqeK+O3qbiY
         Ekk4AAVawc3lX9iP1nuTWz2GubEc7xUYzQrboZi4TK1EeH/palD/BpUNQ+v0P1BQaLkX
         y1afqt0yn+5/Rsi6QHrpItpORQAFVwRCcxc1ccJcfJ286f86aB+oJx141JzrVL5Qfilp
         kYAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765905609; x=1766510409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q3xSUzpZVzpM72qz1ELqk18PlnXt2ts3aZ5ceF8wcGg=;
        b=hMVxVIfVMth/dVO0h2TpKmwwBz2A6pKmLi8XVukDS3idzxT6ABta+CjOW2IvwC+yeK
         uhpcnbWNHd8jSskNh0viheUKeklAz3IAMFlKFafIcgBer8re8mWieV6zzRrzYMBSyUno
         v8a/6eBmc8yp47z/rXcM+L1saROXnXG0wSA7UA1+arLsIiiC0CZQJZLgZpsoe6TaSc9S
         HioeXc2N0Lo7mb5MCK2mWczGGCDLGB//TDtYovpUyoMFFxbOFdM95VODjR6RKdPFXPSX
         yMZ2XxhqTSgzq7HSwYFDlfcMWs4vFLXKvq7eJJq2gfCbSzTmXPUIbakc4gklaWMb4hy9
         erzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkVAPbUhCaUDnIlq0PI7376H74jYUJX8sN3aWEwuF/RJ4aF3k38TPkNFz3UWUjeB20j0E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBIYUTTLK29MLd6QQtt1edtoPewx/NVZXBnytj6hNCVmikoCuJ
	btBqbHZW9kLSXAQum1OFrPnAo3iKRjtPzzVeZq7DKKWh7oKkvh/GmMbRY6lcLCTWdxXKAye8aFq
	6BuNHK63spj7cUEKkA90zg3laz1Kf78v5Dw==
X-Gm-Gg: AY/fxX7hm2ef4/S/RzFmNWxOygI/b+DdbMzzi/T0qVilR6RuxbP5mnSWGAZH70yywf/
	ZT+Jj9SAgTQhwLOw1SaZyl+/JY8gvV5kJHMVYVSAPmU91JAM6wtKn/ULQo05yb+AR0optERI3Mq
	BdPgudVeMoNTxcbgE/2NbKLqD/RHY7fijJwzPOttVUg81ssKt+yMdCFjgedBs5mvTJXc+ry+Zvy
	JlqADedLEK9VK0lOMilnCZT0MgMdwD1P2MfYTDHQ8HWBGdGt9RMcEevMnVk3H7BW24iBIU07h+t
	+7TR6PPa4H8=
X-Google-Smtp-Source: AGHT+IHZzJ9MmaPu/VQj1S6qIKv69/SRg5KzI0V+EFB1zK9bjBi9qIGvZ8Ui604hf52nWS8omHX8esMDC2/jcQPwkwk=
X-Received: by 2002:a05:6000:1842:b0:430:f622:8cd4 with SMTP id
 ffacd0b85a97d-430f62292admr10212354f8f.49.1765905608455; Tue, 16 Dec 2025
 09:20:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAO3Qcbi-bLkOGQdYRwCGTX2+TZuRyXrGS-GXmU=AzeeeUoa-aA@mail.gmail.com>
In-Reply-To: <CAO3Qcbi-bLkOGQdYRwCGTX2+TZuRyXrGS-GXmU=AzeeeUoa-aA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 16 Dec 2025 09:19:57 -0800
X-Gm-Features: AQt7F2pjySzwZjFiHlNkmsZ02WA3DAvIqs-qq6rlvifEU8mQzGV4ixmQsNk3A7E
Message-ID: <CAADnVQ+TsLfhJDa8ghqBHbP4wJCaB8CeMJa7SuDJoT6LavoF9Q@mail.gmail.com>
Subject: Re: [RFC] Rust implementation of BPF verifier
To: cb m <mcb2720838051@gmail.com>
Cc: rust-for-linux <rust-for-linux@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, ojeda@kernel.org, 
	Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 16, 2025 at 9:09=E2=80=AFAM cb m <mcb2720838051@gmail.com> wrot=
e:
>
> # RFC: Rust Implementation of BPF Verifier
>
> > **To:** rust-for-linux@vger.kernel.org
> > **Cc:** bpf@vger.kernel.org, Alexei Starovoitov, Daniel Borkmann, Migue=
l Ojeda, Andrii Nakryiko
>
> ## Summary
>
> With Rust now officially adopted as a core language in the Linux kernel (=
2025 Kernel Maintainer Summit), this RFC proposes a Rust implementation of =
the BPF verifier.

Not interested.

