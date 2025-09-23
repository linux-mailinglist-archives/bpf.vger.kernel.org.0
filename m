Return-Path: <bpf+bounces-69475-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06CE5B97628
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 21:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2EF93AB794
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 19:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9319430276E;
	Tue, 23 Sep 2025 19:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W5fEaQ6T"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891F026F2BE
	for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 19:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758656671; cv=none; b=gMofjdjPPz+vbEkhw+Ml1GlXIioalDt2MbZT8NDfFr6a8MufRCvJfNW8kJ/uoRqdqUdEzuQM0+HPNPpphWdSimPI71Ga2y/FyBqiYUc+ktxbx/T0agWWdR5F0FpOfbhZ5joOh/ueUsZ7mYhx4bHNsYxAc376CxO+bvGZM8NW+iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758656671; c=relaxed/simple;
	bh=mlhXxck+1KIHh5XXz+Agq8ifv60l3Tf/bOCp94Ta1lk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FYLvgRQa8JRHzab9/83jmv9xRRftL7p/A7ME0W4IiPu77rsKwAFXIgwjrtJn0nqyTkh8g6woRp+WNEEQY50VLlGVBQeTeYVtK0ES2ensXWGoX36l88gh5ZvU6Z0MsYib8HEPmnxKAwy317RY4vxDsGzFX5fLDSto4vTlk+Ydnas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W5fEaQ6T; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3f3a47b639aso2059242f8f.2
        for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 12:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758656668; x=1759261468; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q9dzY3Qqzo0BO7MfLLYwdYuF5VTNdZS6DrQwOZVBDlA=;
        b=W5fEaQ6TCQQWKIKaO9AThh9yA59/K/zMi4vXA2DkLQTxE0sKX19k8P/Ai8NaDFr3IZ
         Ucn0J13Jzi5b5H8PIEONkVUg2dquleIE9J2/YK89UezlpYNGhuNjviJhNqWKHQOpDta5
         GZQQaXLjg8LIo9s4auWPvGhpYQJlelrwiGPlOLrI5xrfnXCe1B5ZBLBDKXnM+3aND31l
         HFSMkZJhiWPygIS+jljxR8O6nc0sftlICdU4g5n85/6wdz0ii6Vmb0X5UAn2hmgsx0N9
         lP7vd7QrSltiPV1TTR7GnmdB3N5wvWAXKm9+Zq7JODTpuOMp1HEoktFYHWI8owTRmKKG
         FnPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758656668; x=1759261468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q9dzY3Qqzo0BO7MfLLYwdYuF5VTNdZS6DrQwOZVBDlA=;
        b=fHsxrLLDEOggDtXrnGtiGMZXkP3lTRxVwYicPovt2ehvSM1HVAMYkI8EBErb4JjIDi
         1hPt5oZtnhQTBsp2JfGPCg1+Q0wYrj77ywFbJIUC7vIHCQWT+TtmprF78iEt+GnsD2u4
         ENlatMnjVuKxAFbEK+0u5kkjmaINj6HXS5ZtleRYTAM+MWyjLvM9SxAyAv3KC4GgcOp9
         62wZAyO6OH3fqfjtMHla+eOA4I1vUcCetOUv9H396ADNDpIQ6ioqifcRI6nTTVwzkpia
         xQPsoE9dlPblf8c6SSRub9HrM4CZurmFjh4k91NqCu2CRNqvWsgYO4owVDE01XNViNNL
         qNUw==
X-Gm-Message-State: AOJu0YxqvnsQBTmWkXURcQnGVCjCtw1C3O+xcZHmHKTGKDYBJaSiY2XK
	g20ATPmQcT2lRak+Dokn0gy6Y9vIQB/yLm4Al9+zW7HtZ72CAUhdtTD3GfXnlSvmk5kL7bsV7J/
	oFNuYtQ0t+2VrbbqSBvC/VvSA1S7qJZo=
X-Gm-Gg: ASbGnctzSuVliJ6urCri5IbHEMampPc+EamAOefl0vFDips/726EP+aD9WTGgdt6o8l
	wdMoE/S0RonTu2199CM5bwkOnr3OUUSQjss3zi5F39AdbfuZMP7Zm8kKVkxNvdvPP6uXCOqcUP5
	N2hmwhsXkqD8O4yVd52TOqWJSIOEhuuZnLF6hJFKgacWz7Xs+udznd3s7ErT5ueDVHERFfvLx6e
	89LXYg=
X-Google-Smtp-Source: AGHT+IHq2IJDi8mmlwSVIIcn/6tc9u4lzytGgEkFZoW5jzWWxdo0Uow78J93WySLaCw4UAvB8G9PSHETZS9YRIMu7Uk=
X-Received: by 2002:a05:6000:401f:b0:3ec:db87:e908 with SMTP id
 ffacd0b85a97d-405c5bd8314mr2874731f8f.7.1758656667647; Tue, 23 Sep 2025
 12:44:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918034243.205940-1-leon.hwang@linux.dev>
In-Reply-To: <20250918034243.205940-1-leon.hwang@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 23 Sep 2025 12:44:16 -0700
X-Gm-Features: AS18NWC_amuuNyDtJRt31SmIJG6Pxz0h7vQA1r4SDGcKhKQSfz5GfMiejw6guOg
Message-ID: <CAADnVQ+PwdO4OgUsWin5c4KC9uOgEcM=wkTevLmJPzRbqjXaYA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 0/2] bpf: Allow union argument in trampoline
 based programs
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Amery Hung <ameryhung@gmail.com>, 
	Menglong Dong <menglong8.dong@gmail.com>, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 8:43=E2=80=AFPM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> While tracing 'release_pages' with bpfsnoop[0], the verifier reports:
>
> The function release_pages arg0 type UNION is unsupported.
>
> However, it should be acceptable to trace functions that have 'union'
> arguments.
>
> This patch set enables such support in the verifier by allowing 'union'
> as a valid argument type.
>
> Changes:
> v2 -> v3:
> * Address comments from Alexei:
>   * Reuse the existing flag BTF_FMODEL_STRUCT_ARG.
>   * Update the comment of the flag BTF_FMODEL_STRUCT_ARG.

It was applied. pw-bot missed it.

