Return-Path: <bpf+bounces-38421-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30757964BCC
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 18:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB8821F228E9
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 16:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F06F1B3F14;
	Thu, 29 Aug 2024 16:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QSzj/rze"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F58AEAD5
	for <bpf@vger.kernel.org>; Thu, 29 Aug 2024 16:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724949464; cv=none; b=BaOj6ysOP70NOuA0nwI3NuIxqh4xv1YTg0JorRB4ysIRyP2VZRjYAAbFmvIWyxlycP0nI/AqzZCJ+qQKd30so01dR19ECIIrsNLI2RCeEomLhtxDO3P1G4XnsJe3OGCwMHHyIY1g1cAp+tBWa7ByTPvF9+3xQxUgdpazI7Jm6KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724949464; c=relaxed/simple;
	bh=JkaMwPZ21LWqNHMJVSQCN/ygSCdWSYp2urHqACt1uz0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DQyiqo14W135r5ka2kcJv5zYlbcXfHv9uO+hNLFgCghE/ZOLCA6VmGlx/+6QskLm7arJb9rP9VXVaEmW4KsdzmnKDIooj1FMfkmRpWK768ktrCTfrbhGzYtRffYn07mkx8AHU7Limpq9tf/c28auL5xV7ydcr20mXF6dE2f7yjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QSzj/rze; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-427fc97a88cso7801565e9.0
        for <bpf@vger.kernel.org>; Thu, 29 Aug 2024 09:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724949461; x=1725554261; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JkaMwPZ21LWqNHMJVSQCN/ygSCdWSYp2urHqACt1uz0=;
        b=QSzj/rzePlLzdTw/Uy7KNvfPuAXqF0M4g4HqVc5vSxiA2u7Qe2ATm8ST4zmFjBl74t
         8HNs+IL4mmk/N6TlCk7N9dPfdjnTWhU4vhz/oVHerhUtjHeuXzzhc9hOsW4L8ynD8m6s
         oXkafO3+1YrkF4bOcsCPvFG9qhxTvPWCessmZPQ5iFnYj9ToVPjrpe1+XMoj4kz57OWB
         J+VnVdLTRAembt8EpWk4NJW7fxiM6KWyHcS+wuL019BUQJk/NO+fW7va5o0Zy6Xh9Esm
         6vIWofm3PDtguucj+ez2cfOx9yLIk6bG1xpvHFLY2VSXBCfnW1sqGCR14GrvKuz/NyzZ
         Sflg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724949461; x=1725554261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JkaMwPZ21LWqNHMJVSQCN/ygSCdWSYp2urHqACt1uz0=;
        b=W5ougGUHcpUss/qGYXu12NqUuDLrPXsudDjuveHdUwAbnAhoBZzKMQLzOrLntrmrTk
         pH/sP51C1wFF09zBwdPXh97hwkcyf/xsKx0QRXURPZ+mZH1CkE4uOlRlkVsT3Bfm5/rH
         aNAYX200azTixAiqO/3meWQuISoUqh+1wBGo/e9NAnd8G5cjq4dCpOhtP90kHMqVxCXG
         fUtP2E02RCsZWP9xGPp/+2M65pOyxcstVIttpjnqZckcY+Njl9vSfD0GNKSmvixZgQOt
         Hq4wFlnMrlL04ID/jUtWKtVBkjEbDZv0xc+vjiKIuiqXRW6RkO5ZXdgrGFPVDOM0WOjZ
         3gCw==
X-Gm-Message-State: AOJu0Ywk3LOZtid5a1YemC1PXUicfm2HeUCbtXo5EYNg9VYmcL5f4DQE
	Ok0XDkxlE2IFmfNyFuVHoKvyYBSnLh1POcG6BKtzOAJlBEOiYWdf9RKJbNp77k+onFFo6d27+GE
	bpdSDaRWwR3Mlc9df4AG+Hss3hTU=
X-Google-Smtp-Source: AGHT+IHfBDIaXMOciZjdU+Kp0LodvRrhwbQqyw9in2/9RSSnIAdtRRBzwLEj7MBJZft8VanKjdsGF2ktLSZ3JjysdzY=
X-Received: by 2002:a05:600c:310b:b0:427:dac4:d36 with SMTP id
 5b1f17b1804b1-42bb02444aamr27518995e9.7.1724949460562; Thu, 29 Aug 2024
 09:37:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240825200406.1874982-1-yonghong.song@linux.dev>
 <CAADnVQ+5HD1ZxBqpDgNuwPkO1+VGzm1yqhxuDD4HYtkRYHwXiA@mail.gmail.com>
 <7e2ad37e-e750-4cbd-8305-bf16bbebcc53@linux.dev> <CAADnVQLbknLw9fOhgbSNaNzKi5gfQTP74vXQu3D1P2OVF81b+Q@mail.gmail.com>
 <0723964d-97b9-4b48-995c-3c9efa980f5a@linux.dev>
In-Reply-To: <0723964d-97b9-4b48-995c-3c9efa980f5a@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 29 Aug 2024 09:37:29 -0700
Message-ID: <CAADnVQJ1WRVy1Zto=7N86PpYshLyjTXwwtawrhuok3ydAsjTCQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf, x64: Fix a jit convergence issue
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Daniel Hodges <hodgesd@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 6:55=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
>
>
> So we need to apply the same checking is_imm8_cond_offset() to jmp insn.
> This should cover all cases.

Looks like it.
If I'm reading it correctly is_imm8_cond_offset() doesn't need
to be 127-4 for jmp. It can be 127-3, since jmp insn can grow by 3 bytes.
But to avoid thinking twice I'd use the same is_imm8_cond_offset()
for both jmp_cond and jmp.

