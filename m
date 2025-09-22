Return-Path: <bpf+bounces-69234-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B79AB9215D
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 17:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CCF52A3D47
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 15:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F13930EF92;
	Mon, 22 Sep 2025 15:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UU2d17AE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F40530E0E6
	for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 15:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758556552; cv=none; b=Ly4zJ2B4frteDMXB50QS+w4Pjxze84JOnu2IL4VE+qoUPzAR0EazUhPhSk9k0/mDXDzdNQXKDyLNsAnNFFbBTDoy9wf7C0uTdm1Lly03TromcaFKJQTEgWbhRV0qKhV3SLcyPaT7ZJQTfLjL/xfvVAf4KtvksBZdihH2UNxL/AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758556552; c=relaxed/simple;
	bh=zKhd5kbeKppM9tP5IFjWUEKG0aqUGHUSQZU5BziWV5Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jvd8DpM2nMDLIKXL1sFunOQlLUxOm2kG3o6DeqaDRHeqGb7A/ngpjxifpW/ZGhVfTvzQLmIHQRGP+i0VQAJ+97K9pilRFmKl4E3Ebjg7ndP0v+7w6pevfpz4X9pHb+jws6hh4Zf04umcctK904tJIet/8EqwduL+fRHTInhQdSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UU2d17AE; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3324fdfd54cso1448550a91.0
        for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 08:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758556551; x=1759161351; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zKhd5kbeKppM9tP5IFjWUEKG0aqUGHUSQZU5BziWV5Q=;
        b=UU2d17AEdgZo0hXBP+da84jso5VtjRDy7WPhwcBVdUCWRg86ZDW7jUJ2DAIpo1xhui
         rZUz4KZtEK1ttsDq0XDWvl1iQxN9Wv83BiTASUVoamOmNmE9H0gB1SqVra6O4sqyi6qY
         PVmXU09CortLhpbUCBEYqnINwXSUjVhzzdDU97p3xkvbBYLtU2pgiAgTg+GJJO2lc0t5
         S3nTjLUDoiOmybue9k5KAkEDOzAOapn7vDWsCvRDc3Fwvd/7s/8zfPzrFKA6RmQI4EqS
         3YR8dd3LFEGXGtCmJciU8IY+8vd+XoM/UQzMkF1baskDJ4xyZJgItmZpOi+vgStraXMJ
         mIDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758556551; x=1759161351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zKhd5kbeKppM9tP5IFjWUEKG0aqUGHUSQZU5BziWV5Q=;
        b=oZ3Dtj478rmOE2A+GS32VcnQGxEVFgTNC0jjWbLbkcmHljYravEpr0al4sjLLEbnnh
         wbjCSO74yw1ZblVTgMyJiZhuh17U4dj7pGpKcgSCpLSjium/VwLOQB+VO6x2nac96IeK
         WbH2N7sxRDUETrdg5uerMdkDb9ZKbOyagbXoydhgp7TCM/bsoBF3gRZC5Nm6vZqS3d71
         aLWB3B3Ev38yo77nfuq9BZM3j1m3mJ8z0PEXdDbsqV8tAt9jjj2McKd/r9/ff08gtyUo
         6iqfC2NpfDmLflPGTwC21hp1z6iVXwOFGsfzAU04f8J8a+ctlzblnVDhUmVgCRVb2I44
         9p6A==
X-Forwarded-Encrypted: i=1; AJvYcCUFZYqSP0eAN+thqQuIn1GdAVOuPAOTLQCT1803wvX2BVpzjZtQH7YZTPZhEj4FmgpdiAk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxAgv6SCNv6FX32v072kJpv/HwxBjXFnrv4wBy1aKBsHognUNY
	lZfSDxp1DWDA/sQuwmEvAVT3ftJQGvLHMcikUOf+R4fZdy35ovxem0c5/L+0bPkrK5JXWgJxEKV
	ey5n03X5f9TGDtf7j+hUAWSedukbAYTNnnA==
X-Gm-Gg: ASbGncs68Jm3n9CaEAU/STMW1ZE0ZdLQ22X8z114AyIYdIoTC7Eez526nv1cT6flDsa
	KFY5NSPqHY/osy2lBjZQ0zdUb9Kp1BAuTZEBYeycNxOhjB6LmpTPRFc3m6JQ8hAWgn5WlTJdT1y
	M8QLoTq8ale6Vp1Dk0Gn9L3lVOwMS+H41sFSWrkC6Gv0DLeG6pkfovZlSGHX0eI61XNg0xziZxt
	ADxy+//hqARx/j9xe5Q3Nk=
X-Google-Smtp-Source: AGHT+IH/craAUuC/Ixwy2yPxGrtrESRbjWs3dZ3PdaVtMPq8BSoZaDjBShXnKIrESsMMpNfHvaum0Bou7tkghT7mhMM=
X-Received: by 2002:a17:90b:5547:b0:330:4604:3ae8 with SMTP id
 98e67ed59e1d1-330983416fcmr14935056a91.21.1758556550651; Mon, 22 Sep 2025
 08:55:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922131725.378691-1-quic_ckantibh@quicinc.com>
In-Reply-To: <20250922131725.378691-1-quic_ckantibh@quicinc.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 22 Sep 2025 08:55:36 -0700
X-Gm-Features: AS18NWA6PUw6EJIsjtt8GzyvEAwdmMm-NuBlC2YazjESbIsx1mYkY0Xf2wO7h-4
Message-ID: <CAEf4Bzagg84sok_Ho7Z-eaEst8go47f1fxSdtAWy0M4cPN04zw@mail.gmail.com>
Subject: Re: [PATCH] libbpf: increase probe_name buffer size to avoid format-truncation
To: Sanjay Chitroda <quic_ckantibh@quicinc.com>
Cc: linux-kernel@vger.kernel.org, andrii@kernel.org, sanjayembeddese@gmail.com, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Adding back bpf@

On Mon, Sep 22, 2025 at 6:17=E2=80=AFAM Sanjay Chitroda
<quic_ckantibh@quicinc.com> wrote:
>
> Yes, This is due to GCC being overly aggressive with its warning.
> Also, Here is regression commit:
> https://github.com/torvalds/linux/commit/4dde20b1aa85d69c4281eaac9a7cf
>

It's not a regression, (potential) truncation is expected and is fine.

