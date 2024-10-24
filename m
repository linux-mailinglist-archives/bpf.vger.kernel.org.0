Return-Path: <bpf+bounces-42986-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D461D9AD916
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 03:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 040EB1C218CD
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 01:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E1F208D7;
	Thu, 24 Oct 2024 01:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zbxwe9h8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BF0BE6C;
	Thu, 24 Oct 2024 01:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729731909; cv=none; b=o97m6TjGv4a3cUP4sY0B2UBMBslNPDvhhMZlK2qZ/3MwF10YbrWYQnqcyDOuTrfFTvi5Z/i2PFYHE2rGYFwBsURQF+8/MUxRKWHQhU70HngT6vt0yZDV4BVLm9DCIZ7lC9UAmRGeIMgL9xV+oomhMmWouZ59KpAccJRJze4rvZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729731909; c=relaxed/simple;
	bh=VwmoJBYAlvdeAwr3NyiwJYWThIBjXS2RFKMcwFAmyv0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pb1afnX5QUUb1H7Jtmt8Zqm5obWI2Em70JgO2CTB056cJEDrhldr6GKiFmn3PgnmIEAv+ceUrjHB7HOI/z15+10qsbCTqKLxmjQXkbUGFVSyaTRJVjfK7CWW7/cw6TRB1s7Hd8JbEOpLljIaGCdRL9N3SIehwo1miUBwIUXaDoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zbxwe9h8; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-37d49ffaba6so205998f8f.0;
        Wed, 23 Oct 2024 18:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729731906; x=1730336706; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VwmoJBYAlvdeAwr3NyiwJYWThIBjXS2RFKMcwFAmyv0=;
        b=Zbxwe9h85M/sKWlr4kjEmq27Rt2wVYBzyCi4u34fpRLUxgKNi9TOiVqAJ05xCbChnz
         dnnKiA87XuqGNybKyjKZZB6g+aINHwDT/Dd86qJBIAQM1bddIqtRa8JxQBdR6zY4emj7
         Nl7idxtIgsjKUbzwYRJGBi9wEn+3QPAAGWT0gS3HB1/TVHrmAyO3UL9YOA0K3Npl1UeX
         kMd4afIV68XuqJQAaUH7ovTkY8twYg////cKxJck8hZRbm6qp8nYQIJSVrQzEqdGpedh
         MNBLjcEDFUUbj+naP2DCaWcjZBcT4Cq372LL1TwxPJXIll2hvVR8wwWuaCRo5+jdmmlv
         c53Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729731906; x=1730336706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VwmoJBYAlvdeAwr3NyiwJYWThIBjXS2RFKMcwFAmyv0=;
        b=mvuPoN8t8iQY8yaph+GPtLsL54y5vUvR0wDOq0TBWoAUVc00zAVMEqLIpECbTtnSAO
         XZSkBMHDMFN59jygHuEGtJFJIYW928QytJMXVoIfKoNvovuKF8ZwBXmuqYNyk20SXXvU
         +mXvN12xWk1eKFv5O1A6UybgZZnR52FHL7a2qsf3j45PSpzCb6RAAA9PbciOi+1uz8ex
         cmYC7e4DTrV8RP+1k32dzCNKmPaInMRJmFg+vI3nLBsh4c37IZWEmyzhZSSEgn5D2ME5
         hc+7TYKgGOJXBktddbxyg60G9p2qGZFdXPaOeNZGlFan74zP7nPNZ23HClHD9DTMh4w6
         STnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGtr4jLwDMg6yhdMnJ/tDpkSAXu+GE/qsnOVClaJB0thkuFbq8X02xonittefRI3jM4QY=@vger.kernel.org, AJvYcCXFbEuMF+YR9zSw4xKcOHSzGTgJRvnfdfmbiBlglRDzMq6NFfCujN7S+z/ntQS83lmXTLaoDxx3zRxS22aW@vger.kernel.org
X-Gm-Message-State: AOJu0YyU4gp1sZ+HS6BTIas5TzUZ/pezbyoGcUaRPVPw2Q6xmGxwEO4g
	o4Z+BJotFivfAXffDkYxgPPYu7USUI+I2w/l7t8c+Rhu0U9C/vsNamJ2Q3qTCkTry34474heyKg
	VrjlCXyIPewT2GVMuni1sDJvbc3c=
X-Google-Smtp-Source: AGHT+IEReK+2bo3a2EDoGND9G6OU4ntwKP5Y36zhBXB5tuTWaCOFLZsetWRsYrUG0doujB/TpkelkILpV7zgrP4lsEI=
X-Received: by 2002:a05:6000:1fab:b0:37d:39f8:a77a with SMTP id
 ffacd0b85a97d-37efcef0d2dmr3263113f8f.8.1729731905614; Wed, 23 Oct 2024
 18:05:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zxma0Vt6kwWFe1hx@slm.duckdns.org> <Zxma-ZFPKYZDqCGu@slm.duckdns.org>
In-Reply-To: <Zxma-ZFPKYZDqCGu@slm.duckdns.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 23 Oct 2024 18:04:54 -0700
Message-ID: <CAADnVQLsUZ9SoWomC_2tSw=KsK6YkdDTmg7Hmr8wk-GHMv3kNQ@mail.gmail.com>
Subject: Re: [PATCH sched_ext/for-6.13 2/2] sched_ext: Replace
 set_arg_maybe_null() with __nullable CFI stub tags
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, bpf <bpf@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Kernel Team <kernel-team@meta.com>, sched-ext@meta.com, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 5:55=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> ops.dispatch() and ops.yield() may be fed a NULL task_struct pointer.
> set_arg_maybe_null() is used to tell the verifier that they should be NUL=
L
> checked before being dereferenced. BPF now has an a lot prettier way to
> express this - tagging arguments in CFI stubs with __nullable. Replace
> set_arg_maybe_null() with __nullable CFI stub tags.
>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: Martin KaFai Lau <martin.lau@kernel.org>
> Cc: Alexei Starovoitov <ast@kernel.org>

for this and 1st patch:
Acked-by: Alexei Starovoitov <ast@kernel.org>

Nice cleanup!

