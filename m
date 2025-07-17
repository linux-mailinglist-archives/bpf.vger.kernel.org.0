Return-Path: <bpf+bounces-63647-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D66B09344
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 19:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BC92A424AE
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 17:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35F82FD88F;
	Thu, 17 Jul 2025 17:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IhpvK4p3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C9E2FE313;
	Thu, 17 Jul 2025 17:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752773635; cv=none; b=cBL1M5Qy0MJ6HhVvy4Xn/vbjmF547fd8dsPxzjUzMXytQwrHKlc+G0HhSuw8q0rc9+ZiE4EumYAV2vmD3JASpVtQXKKgBmzHFStNZjitqu5ofZOzL6lr/A1DICGsL1hSwAhmS/r7UK9L4iC74Ij378BKRmxHhsI2oK8nN98OP+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752773635; c=relaxed/simple;
	bh=Ir4ckRUA5c4ZdEYRHXih9x14eSjGxmby1TED5CRBisU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QJAiS3Nrhdf9YvyZrksk/iGrtUgIIqsm11Uk2sE6MxQu3SsEwD5EAeKhvelQSlD7pKexsdj7I+2RXrHFG3yM6eS/tTmABlTtNPNtCyMfoNbbce0CWOX8er759phocBx60GQonm5nc3VbEz1OzO4fa6YwGnj/0200CiNuRj/tRTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IhpvK4p3; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-30008553e7eso350316fac.2;
        Thu, 17 Jul 2025 10:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752773633; x=1753378433; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ir4ckRUA5c4ZdEYRHXih9x14eSjGxmby1TED5CRBisU=;
        b=IhpvK4p33wvtH8TldwxiCXd8+ZSgfhy5n1WwIrmK+rJ7eddFFVzI4Z6s4lHyQ0YHhI
         /36z/J/9G/u+dXOydu4b3Bao+PpxR2z/AhN+sp5qFmGxmX6ZK+1J7AUCiOJO2ENgNIOV
         9AVsaEx/7YG0rNtsL+ZZ4iLTBvVcxxniUFjZADtzo7Wogoi09T9wL1cZBle4D1h7soP0
         H0N9fbyA3sXUfVsBo4QC7xKChwslllPgyPwiQt7URs4MgmIQcEtgZngDMbNM3WmHdmfu
         L4xy6I71ckgDH1xfdShCZju1OCOLyWKdisIAvMCa+AApYydoqJEIMkair+yE3mr8Rka/
         BtcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752773633; x=1753378433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ir4ckRUA5c4ZdEYRHXih9x14eSjGxmby1TED5CRBisU=;
        b=lUiQM/GMvQWBFPlWZukNNFbjWjxz+aGpqN1pBbWh7ftiOGp4qDIyGLzIB/owGVbObP
         SOO8vpYEqcDngjkTiIWSrZ7OPQVpP8LgZbpNoZvl3wCr2bcp80dPfeq3tGboOcoxhtPy
         hnpgVtX76PVzkrCuwOThfZzlXBv8SdOHCATmZ8eIQEsi+/Zj7QFYP7LRUH9YvPcjHpZo
         x4PzEvpG2VmRJlIHWxpK3LpvOC7aAJmKyJyTsFMpBClooOHzYrn4tdfqf4yt83VWo72U
         c5wqllz/ReFhFmuacg/NeR8aipPptSADFn8H6H3IJkBHdvnFO+g1FZf3S/w+T3DaCmxD
         XdOw==
X-Forwarded-Encrypted: i=1; AJvYcCU9PZGeLKvp4ibXfbiwh7dSdKGkEQQOLQqtkB+zWsrmMJ+eLKez3Rxes/H+tF0nf3XQBBi621rz5lM3Bm/Y@vger.kernel.org, AJvYcCUwiWnKFP0uiGnNqVIZN1owmdRo5IutyniR2XDerldbAQBcF5tatkkP5H3uYfHlIB/0koA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2K1FaLiEIwWLLE8Xtziwv7jZcNDjSWkk1tgi+N7FNk8Bml2Zz
	z14WY8KyGAS17azYx9lfROM15qQNh3kR6KjWv5oBhuqgIn/X8zsjiUAZyLABvsWFkWoVrN4erCY
	p2nEvEtFVn0WoOT7F44JPO2iavJzUtDg=
X-Gm-Gg: ASbGncsgAa4RD37b/z5gYw0xPj1+JJJb1cLgBVrioCsJVG/VTugPfTpTSuTQkF7C3av
	T5GrfShUWM35cCQsQ5fm0nJVAQ6TBNhmMWGkEVbS1sidmC7QP+xPiGgApbCJ3pR6k/nbxFmGo3l
	YdXU+d3/LLd1cGUHS+8YsnK2FE/3+pWFGsneWHFTXk7fcDNLUbros6z23IMPWlFuuRamamH0zHU
	6PyIACa
X-Google-Smtp-Source: AGHT+IE3OqHuOP71bWOI0K5lvnOBfAxmV67CujVwlsH27p7aT3RJwVULSnI3/51i4mRGaUvRwtqIC4U9KT9rvFqML9U=
X-Received: by 2002:a05:6870:3b0a:b0:2d5:23a3:faa7 with SMTP id
 586e51a60fabf-2ffaf255917mr6851745fac.6.1752773632901; Thu, 17 Jul 2025
 10:33:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250717115936.7025-1-suchitkarunakaran@gmail.com> <CAEf4BzZ+OTkaXmtWPbOGB0OWz5xmj-d06UWchooO+iUyDHar4g@mail.gmail.com>
In-Reply-To: <CAEf4BzZ+OTkaXmtWPbOGB0OWz5xmj-d06UWchooO+iUyDHar4g@mail.gmail.com>
From: Suchit K <suchitkarunakaran@gmail.com>
Date: Thu, 17 Jul 2025 23:03:41 +0530
X-Gm-Features: Ac12FXwK07iRYjwoYqN42-IryjF5d0QqJxt83znwv8mcgyEmn1cG39hmlBlE-m4
Message-ID: <CAO9wTFgLOymS+VDcUTCHZ7niu_gEgN-N-F1uX-Kpm+uqvaMrQg@mail.gmail.com>
Subject: Re: [PATCH] libbpf: Replace strcpy() with memcpy() in bpf_object__new()
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> This is user-space libbpf code, where the API contract mandates that
> the path argument is a well-formed zero-terminated C string. Plus, if
> you look at the few lines above, we allocate just enough space to fit
> the entire contents of the string without truncation.
>
> In other words, there is nothing to fix or improve here.
>

Even though it=E2=80=99s safe in this context, would it still be a good ide=
a
to replace strcpy() with something like memcpy() since it's
deprecated? I=E2=80=99m still a beginner in kernel development and trying t=
o
find my way around, so I=E2=80=99d appreciate any guidance.

