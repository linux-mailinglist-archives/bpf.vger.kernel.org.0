Return-Path: <bpf+bounces-78801-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 98AECD1BED7
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 02:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 30FD4307C5CE
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 01:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA8E298CC0;
	Wed, 14 Jan 2026 01:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lduhi7b9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D8D11CBA
	for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 01:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768353895; cv=none; b=NlevX7tihKz7rrkb8pa40bmAR7bOWqJbd/GfxqommjHkWaRl4Fp4Lb9a5gnFN5Drbm2hJYuEbjiJIB2c8OcZzK1HP2Jfv1B2agfg0A5fza9qHutkeJ6nl55l9D+ivEusFFmxtV5iCmPu3BAbSNJFIdSHeB/XnsL8CJrSCrFIkoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768353895; c=relaxed/simple;
	bh=40BrPp0M59FAG3TB67K33T95VY+/hsIzuUC9ymB75As=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A9zD4BXWaieC7XM2ey6I2MUrrGs4av6TrmW+GxXdZP/Bz5DVjnbEYgzhAFTi8EbI8oRsV0K4en1NxW2mupSG6fpr0NF3MwGwoAqIzsL40ZUoD8cF8jFm3lCBAJEaFM9hRwifKmzjkEjZ1uAtIqKBcI67rr8M/zguMjfLMaMiym4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lduhi7b9; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c46d68f2b4eso4944005a12.2
        for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 17:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768353878; x=1768958678; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LLTXxY9Q3BxypQ5k5gaq+M++dRdP5vB+e9T5tp/A1X8=;
        b=Lduhi7b9JGo9tgATMp6qtU2LnoceB5hIntpf7wC05RfdUxZ5TmknqiuM0OrLccjsao
         pJsSHoUuBPvnKs5GHslc4ubbuqmX8FxBZmxhfv81/X6T89eNSFI1dM0R5VNguWuA+38v
         E4pvq8QP9vVoSiI79wH6rqH17uwQ3j5ytR4y0z3bGlycDGMtG3OagIxASBZddHx3efaF
         chkLLEsNR3FabTqKvFRVxPmDC1/bBCnpHCRCeNecu/Vu62Ncaq7M6dUO6TpUYSLyXTvl
         VLah2k3BkAOVruDI2hYTubkO8iJ/wqdKo2YacP+S6E9CtVrQ5OSBbUcjFoBWw7370cZV
         VQhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768353878; x=1768958678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LLTXxY9Q3BxypQ5k5gaq+M++dRdP5vB+e9T5tp/A1X8=;
        b=afoEv/p1l4EchdO15iYslZuySjviGQBQeKw8FruDx71krRmUIbJFNM4wcrzUvQ1mhY
         EPx+MbDXU6aduJqKOPW3mEz0qQhgjcGyZVSk5KYbYuVlG8RuGn9S3XDa/z3SPLYYe7hG
         Z4H6aGC00nBLyfXXYG1vlQ8PqMLP2xmOwgcwhk1YCnTNnyuSrmY+rY/me6lVwWBncQu0
         A/cWeZzALAYFKzymi7YkBraAmsS5lo9O5c6nTQ4DcKn0M4g0foVWvaH7BFFWov17iB3Q
         mjfflwmrUowVgFqgnOJUScyH/FfnOJYCupG/GYtRTL2TILO+vL8XK2sYp3yN8Q8WLZzl
         8J9A==
X-Forwarded-Encrypted: i=1; AJvYcCV39DCtOO3BU2RFQdaPvKh2OozwsqX3J4pEuZ2TJhZAtZKYUJZe48ghhLuX6UhukzzkFJk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb6ThFybIf2HUeeBNEHMYN6PWm/ve7x+uTYSmvnzWZdS2grZHn
	OjbuRgX/dvEWWMohVBzsHUFGQ5HXi+yBIHmIMndrqS3+mAp60IFLmJ7OWxjZv7yoWfx13wCFvzT
	f4xVJ3oPD6QQZ0hhxZUkYlDfhZCbQyGE=
X-Gm-Gg: AY/fxX7MfVNMClBGBmyr2MaA04iQYAG5ja1vuKQiiRxRAbI2zmeq+fPwJTm4kN9YLPP
	lCPgwCty/u0Gpd9ooxH2KYgmUwv+PBQYsrqAxLhRyUn5GKvCoKcnjbY06/lRaoOHKqiL/FSeWCw
	w6cXRyxKTT4/Fyd6yQz+mxPhB15unIyE2/j3yht35nhytoqFizBlgZOLb1doBvtfJl2/FRgr0yW
	hcxMGb/s/my9ROxY6LRAKm2UNMlAMLslMtqU21cQ2oAqnyhHQ3vW+A+1bElixTZYNm+jo311bWn
	mhvTL5apL2Q=
X-Received: by 2002:a05:6a20:4310:b0:36b:38e0:4bf5 with SMTP id
 adf61e73a8af0-38befbc7dc1mr430207637.51.1768353878382; Tue, 13 Jan 2026
 17:24:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260110141115.537055-1-dongml2@chinatelecom.cn> <20260110141115.537055-9-dongml2@chinatelecom.cn>
In-Reply-To: <20260110141115.537055-9-dongml2@chinatelecom.cn>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 13 Jan 2026 17:24:04 -0800
X-Gm-Features: AZwV_QgZnDXM6IYPYS91-BHZn70EC2birCKZHLzCw6UXKOTHAKflwo6NksxnPSs
Message-ID: <CAEf4BzY0s2fe_Xq4MC2PiQaiYZPic=O0mfMaoF5HW-gDnuMQhA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 08/11] libbpf: add fsession support
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, davem@davemloft.net, 
	dsahern@kernel.org, tglx@linutronix.de, mingo@redhat.com, 
	jiang.biao@linux.dev, bp@alien8.de, dave.hansen@linux.intel.com, 
	x86@kernel.org, hpa@zytor.com, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 10, 2026 at 6:12=E2=80=AFAM Menglong Dong <menglong8.dong@gmail=
.com> wrote:
>
> Add BPF_TRACE_FSESSION to libbpf and bpftool.
>
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
> v5:
> - remove the handling of BPF_TRACE_SESSION in legacy fallback path for
>   BPF_RAW_TRACEPOINT_OPEN
> - use fsession terminology consistently
> ---
>  tools/bpf/bpftool/common.c | 1 +

I know it's a trivial change, but we don't normally mix libbpf and
bpftool changes, can you split it into a separate patch?

>  tools/lib/bpf/bpf.c        | 1 +
>  tools/lib/bpf/libbpf.c     | 3 +++
>  3 files changed, 5 insertions(+)

[...]

