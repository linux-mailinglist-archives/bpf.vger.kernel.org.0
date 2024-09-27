Return-Path: <bpf+bounces-40375-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 846BB987CA4
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 03:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D5F21F23E9F
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 01:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8708022087;
	Fri, 27 Sep 2024 01:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nmXJtDMX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FAA3BBF6
	for <bpf@vger.kernel.org>; Fri, 27 Sep 2024 01:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727401035; cv=none; b=X/JnuyFMJtPKqawVWwex0+Mu2557i0hifQEC7NVm2Wa6GayKWjIOzye/V9dx+HPYMecIJpQn+C1BwCrGiSXGjHZshWIaOckM8Q54eNctPD2S2C0HvAe1m7pZscxYciXsGGhMHjBE4Me3sxKoKSdUX5JubO5IWoi6tUgaB7nf3vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727401035; c=relaxed/simple;
	bh=vc61OX6CwRr6ElSmUhtCRjoDAGU/1p5+lZOEOAq17jc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cA+vLP8r+cbn6b1B+raOGXy6q4zQkt6KCW0DXOF3kRWLN0FTVDGVCJKfAAW+ZVUEwI/uxcHNsTUZE6FXieENPFghemeYl4hFp8lsVdlMZbJt7ATokGuWZmTo8HTJUnT6YRGMt4ATusLA2Zf4SbzCezRbCitNSn19ldQ1vM/YwGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nmXJtDMX; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7179802b8fcso1254296b3a.1
        for <bpf@vger.kernel.org>; Thu, 26 Sep 2024 18:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727401033; x=1728005833; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vc61OX6CwRr6ElSmUhtCRjoDAGU/1p5+lZOEOAq17jc=;
        b=nmXJtDMX4xheuAOPn8sRUEN6YKGYyieHsqedjoCRXaLbGlF9fiJJAOqQMs+iYPJYp5
         zkwwqrWF5CIbdSyOZjIhwA9EegHLPzitIrH9RxggAWXgv0GJKsQgate9vjOCdgmKCz85
         mlFZFAUpMh5eWgloMnDRaHUg4pCc65xi5Lr6fO4NHHl4bbEm3UezQMqrdoWIXgIWG4nv
         szLygIyxHBUPlKlF2iS3g4A7akYQgAUMbXAJxphbIol+y0+PohSGQ0AyB7MV1mB9QUge
         sm6WIgnR10SfmF55QZkCfp5RKmD1sS5K8nZUJMqGPVoeHe38PR+Buy9hsCMAvA3tDXQZ
         BYww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727401033; x=1728005833;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vc61OX6CwRr6ElSmUhtCRjoDAGU/1p5+lZOEOAq17jc=;
        b=cW4Afs7MUbz+xdEGAE5eKaGDPs7h1RxGeko6x+/ryOv9yB9XMw7wDcOFmSqpogWvMR
         SeDVXPStN/PjgqgM4jkqQSKOn1mVf5YU94SBHoJmZjDgOJr2n3jlLxRUB7w1yjaBwm4a
         kUPgybGT18W9xmJj0jZrBSyTzB3qSoayAnv7TH1C8vtEOVYNZ3HttkgSQW4bJJ6+EYzC
         BuXAs7wIHHwUTkssOOgFpxF5uTMRghO/HBTrn5fm8pK+JPv70ae9xxV4FD2z4uhj9UIA
         luIDmsTzfZhjRDRHYZBQta2EpESjZYhZoVeWkXkAano0EhXsxwQ98AC9XlZNny8fduF/
         KIww==
X-Forwarded-Encrypted: i=1; AJvYcCXZI7RBIaUIUSC61TgWOgLRtBuVwR904kFqF8VUGXv0pIw0y8bsRLCblcZTsVJCJCxtQaU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDQzkf4KNqjmy/NB7NA9PpkruKN+hJHUvskX2lN0z+3rd0u+8e
	aXKJTX4pRd82oKFRTiwvfdMCL0cF7kJuftK0riMEvulBbcwBDG8a
X-Google-Smtp-Source: AGHT+IEQI0zHudAkgMpkvnLrpw72oU7DFjwO1IqESUNiMzrUyJ8BwjSbChRZHa2/Ekwm9c/CWw6rAw==
X-Received: by 2002:a05:6a00:84f:b0:706:67c9:16d0 with SMTP id d2e1a72fcca58-71b2606656emr2500140b3a.26.1727401032939;
        Thu, 26 Sep 2024 18:37:12 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b264bc896sm534471b3a.76.2024.09.26.18.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 18:37:12 -0700 (PDT)
Message-ID: <efa0ba9ce828010cd6fea1efa45b17c1b0800ace.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 0/2] bpf: Add kfuncs for read-only string
 operations
From: Eduard Zingerman <eddyz87@gmail.com>
To: Viktor Malik <vmalik@redhat.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,  Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Date: Thu, 26 Sep 2024 18:37:07 -0700
In-Reply-To: <cover.1727335530.git.vmalik@redhat.com>
References: <cover.1727335530.git.vmalik@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-09-26 at 09:29 +0200, Viktor Malik wrote:
> Kernel contains highly optimised implementation of traditional string
> operations. Expose them as kfuncs to allow BPF programs leverage the
> kernel implementation instead of needing to reimplement the operations.
>=20
> These will be very helpful to bpftrace as it now needs to implement all
> the string operations in LLVM IR.

Note that existing string related helpers take a pointer to a string
and it's maximal length, namely:
- bpf_strtol
- bpf_strtoul
- bpf_snprintf_btf
- bpf_strncmp

The unbounded variants that are being exposed in this patch-set
(like strcmp) are only safe to use if string is guaranteed to be null termi=
nated.
Verifier does not check this property at the moment (idk how easy/hard
such analysis might be).

I'd suggest not to expose unbounded variants of string functions.

[...]


