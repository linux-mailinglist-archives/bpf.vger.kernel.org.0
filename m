Return-Path: <bpf+bounces-67929-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68BEDB5056E
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 20:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EAA13BC796
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 18:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5132FFDC6;
	Tue,  9 Sep 2025 18:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DnC8Zz9Q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8C42FF67F
	for <bpf@vger.kernel.org>; Tue,  9 Sep 2025 18:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757442948; cv=none; b=n6jxHMNnkZxyU5A8Ll2n88TLAWsJ+J0PmGPEKilvrvoRpNxIxG++I8Vr0MzVLNrIqsPpxp3mhswZeI4kGwOO8r6nnIsmV/jZ9vyK8cmBk/KVMkeZoFmM7Tw7eRAs61tHKLzTNYGZROarRhpZQGd5DjebZzkMEJSjhw4O4pD2z38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757442948; c=relaxed/simple;
	bh=w6n4ljxjGOJoq0dBSVBu9j6BBX/CfAkjEUfWg7gkTRc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tyxnQNk8FJ3jDtdcZ5MdokQKNf4HybLMkKEFAwhTs4blw+2fWMXjk3f0FyUvqio0Z22vtMZNPRlXq5U11r2bGGGlhRDgYiTWpbSALozYrXWZIFShzwtzyl0EoabTR6fiA1NNhVdcZI7Z0Re7nmlNdRmI8LPIPkT1wt1l1dMn5J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DnC8Zz9Q; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45df0cde41bso7032075e9.3
        for <bpf@vger.kernel.org>; Tue, 09 Sep 2025 11:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757442945; x=1758047745; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w6n4ljxjGOJoq0dBSVBu9j6BBX/CfAkjEUfWg7gkTRc=;
        b=DnC8Zz9QTI6W+6Cei48oFlwe3zNQ7tuOdfD4u1WENxioD+u0C6iBh9SEv2beV9U4/k
         pavH5AA0iKQTKuuftmmlYGxAP00Hk8HVsmCwKU5f+4DE6SAMWxu3AcfhHf/CZKQIPYnM
         I2RvlFL0Y06HjCrPRwmYa3doRM3hLw9+Ke8a95fOhVlAjqpubk1dZkqb7uJXRlV2rlyZ
         woF+Z8orT08zBo4xRJIXDLY9RZxdEOh+XIWRbfCfZS1yAVjKm0Uo/ptx6EjCUdJOuFp5
         qCto13ZkjUzQAq/7tHZ3gFZX4RpW5zoMmZfu4oo6FqGllREKhC2T90VTzJ9qR88hlvZg
         4MOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757442945; x=1758047745;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w6n4ljxjGOJoq0dBSVBu9j6BBX/CfAkjEUfWg7gkTRc=;
        b=d20x14HeT644mMF3DLgsK7lmsFr8/zhTMH96xbF1Uwb0jIU+nWqVuqzWzOgmBx696n
         4Ts5lc4Ji4LhJaa5RU0chf0G+f9EMYFTusoUwLlyPBVO7ywGr+csuvbWgtnPOQycW4Ua
         w73U/FPBR9iJ8VJOm6thojsVB0ARYSEObtD8czdQrDFSds3X57izmZD50gQdosO9wCJ7
         bMYMIfDYDrDO2VUJaAkcu7NfQToYQx4liopj184MuTV41B2tNHQ+l459tPq8N9kvWbHm
         hEpHems5OM3iBx8aAToY6WYI9dIobkqhTEiAWCbgQKae5KtVYPcOphEq6o3OR4D7jIho
         F5Bw==
X-Gm-Message-State: AOJu0YyiSHZafsJp6SuwDvL67s4UrJctsw7etR2RSq5FeKqaCnMkvYpY
	xwcn3eU7oZKEPrl/PWcMzh9U1yCPAkAwEDe31dmX0FNMmRBDxOYLkcoY815a9GvPzYiqCH4/uci
	8pcwR+m/jKrHdJbyY5BiqeSgNEZU0NcTiRA==
X-Gm-Gg: ASbGncteDIGX9eDq24cXHI8zuSSWD5+pawdIYZWEabYEm5v0De/e07s1ZbpLbwE69dD
	P/8vIII+0rraGWxV7Jb3GBkwZ+kAoAny/3sxZpADpAMOT+ylPD9QraCshG0c6atxfinEbW3ySK0
	guu+9QbCsTNcYean+oM9kIuGYF+k6Q5Z7rVoRFlHkP3lW/OKtBWA+sADTTat6KCz0ZJV/LT1tHb
	h46PFNFETbKqvGfyqFCaQYC2ls/eHI2FA==
X-Google-Smtp-Source: AGHT+IFtkWanWlAJVCH5X7DVdDqrq7p9DxKRMipcihIsw403L/QE23uvLwGFSomVxBzz8Lo1epAZBEDfwseLmF8cjo0=
X-Received: by 2002:a5d:5f96:0:b0:3e3:2c0b:dc3d with SMTP id
 ffacd0b85a97d-3e6428cd2f7mr9724642f8f.17.1757442944557; Tue, 09 Sep 2025
 11:35:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909165917.3354162-1-memxor@gmail.com>
In-Reply-To: <20250909165917.3354162-1-memxor@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 9 Sep 2025 11:35:31 -0700
X-Gm-Features: AS18NWAXBaHMM12hjYasZq8cXWpsVbs4cHjKEksQNrNGcB3vK7etiW4uSBNmcSo
Message-ID: <CAADnVQJozfMWiLkkmFxFsnSS7027rOAKYZogd30D-LyuaGhfMQ@mail.gmail.com>
Subject: Re: [PATCH bpf v1] rqspinlock: Choose trylock fallback for NMI waiters
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, kkd@meta.com, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 9:59=E2=80=AFAM Kumar Kartikeya Dwivedi <memxor@gmai=
l.com> wrote:
>
> A more involved fix to terminate the queue when such a condition occurs
> will be made as a follow up.

Worth adding that the stress test aka selftest for this race
will be targeted bpf-next when the fix lands and trees converge.

