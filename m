Return-Path: <bpf+bounces-26878-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8D048A5E1E
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 01:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9205D1F22A69
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 23:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB10158D94;
	Mon, 15 Apr 2024 23:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fag92VRt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FBA1272B8;
	Mon, 15 Apr 2024 23:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713223030; cv=none; b=Dhk90T1JiC9SU6BELvAYBpS+FckIw4RfQu6IShzS5pv7uU/W0NYVwsMwrKGLPIYH54k3zNb8ODU1dkQlT2MLOnh8NblV//URUDlz5R0fjc9h3YMnl/PFfzbjOcrSuI6mcJx0ucYIaeb0hQ+b88kbdqy6SAKgfcqnpp1BJH2cCzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713223030; c=relaxed/simple;
	bh=idkIPd4643iMp6zp5cWydiUKzewJWHnlG0YbVeUo8v0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GSXpS3orheRWVhtIBWqHSHb2d+02K+NQLySy7gh6rcF8AMqhALd4sjGb6G5f+lzrEBUYYjbT17hl8cyGW2qk6D1WK0gTABffgLd/NKQQTTSt43MgE7DmsdZJfZah2/8SHaAA6o9IXs3jzIDBDhgd5PIDfpGd3HCPzMJoGqdJdgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fag92VRt; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-343d2b20c4bso2873330f8f.2;
        Mon, 15 Apr 2024 16:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713223027; x=1713827827; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ruJIf0VvZi4YUJJHl+VqnTHRzLwdSGx7P/d+L8YCyOQ=;
        b=fag92VRtHUmyr0EqviDUb6u3X5+KG3RkSeHljMK9DMI+liz8zlJ241yo4UqHt4ja9R
         2YhE2HQZjxflJmHIuv/D91FXnOtspBCCgL5hlnPYJpx5r+seUxAQs9GpSiTp53oO6e5d
         r2XNQX2RdC8dLXspNDauCLBO85PJRWYl7CVGM0emdYYUz+XKJLtvB5bv3/CCGd8PYp+9
         ONwS2KjDqTIjCRvwxRSfmt7wtxBZNZ3pJLyLosbaaZgUG0Jvj5eE1Afv14zRtS8yXOFL
         UOGEYcdxSIDOuhxF6A7nKQouviijz4axXxWg8xL/DNbhpdS95XhkqWci7AW3mXbhO2/a
         fJvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713223027; x=1713827827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ruJIf0VvZi4YUJJHl+VqnTHRzLwdSGx7P/d+L8YCyOQ=;
        b=lIoUaMEqu++X0vTKx/gv/WHsGMlyrz6gwBAdwIx9lUl7r7Ly1JWw7uGj4MmXwGmnJL
         d0wDduqZCjRNceiESvKW5VJSetvJViLUEQShqU+BfuT1lht779Z/PuJRTSw0gWZryrTO
         0+cIB1KFfcPjS2do8XdV+xUKwaVWCQwBoEH6658lTgGCt5GPfnuFv8NkKvR39vnhcAOc
         8d3HNRoTkyY2B59056v+ZRvLskhgLLyHbQEoTtJDk0Zfg9GXd0+QLtxKSYpSG8+bdr+t
         VYJ2I2KxZ40AzPDbnZPDOl6VSScd/jIsOPVd1o36Caok/ma2MOp9kG6ZEh0SzY44vyzf
         ECXA==
X-Forwarded-Encrypted: i=1; AJvYcCX4EAzfAKWbmVZF9HcGodhnu5esVDZUgwBTxFtJeJvOd5xO4Vo+rFdzefF2LBWJfycsRxd/VYfEJpwVDTkeLGY79Kfjqz9PMjW0
X-Gm-Message-State: AOJu0Yw1o9nF26mUNGmQGtaaqzmP5TzZp/8QkoTbJG9Qa6slY7EdkADq
	QdfahjCsQpOzfabFgP1k8mbh+w5x3nO1Pu+cf11JWft9gMU0+k8jEYKV1PlTjL1aT9dntKDL3Vq
	mfGR5GEU0VwzbEjMp+PlqkZReQgY=
X-Google-Smtp-Source: AGHT+IEecAmwVB3re9uIi+jukJ6rI2C+0KFoXSMsLiYE6FwY01cNohbu9XFzE7AdG3SFvLMvaGvCMIgTcEx0lintfg8=
X-Received: by 2002:a05:6000:1150:b0:343:a117:7d2 with SMTP id
 d16-20020a056000115000b00343a11707d2mr6631391wrx.71.1713223026568; Mon, 15
 Apr 2024 16:17:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415230612.658798-1-martin.kelly@crowdstrike.com>
In-Reply-To: <20240415230612.658798-1-martin.kelly@crowdstrike.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 15 Apr 2024 16:16:55 -0700
Message-ID: <CAADnVQKfo-s4vXopJJ50Q4KP-mPKCbOc_8Pwz9u=uUn2=NU1ww@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: clarify libbpf skeleton header licensing
To: Martin Kelly <martin.kelly@crowdstrike.com>
Cc: bpf <bpf@vger.kernel.org>, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 4:07=E2=80=AFPM Martin Kelly
<martin.kelly@crowdstrike.com> wrote:
>
> Add an explicit statement clarifying that generated BPF code bundled
> inside a libbpf skeleton header may have a license distinct from the
> skeleton header (in other words, the bundled code does not alter the
> skeleton header license). This is a follow-up from a previous thread
> discussing licensing terms:
> https://lore.kernel.org/bpf/54d3cb9669644995b6ae787b4d532b73@crowdstrike.=
com/#r
>
> Signed-off-by: Martin Kelly <martin.kelly@crowdstrike.com>
> ---
>  Documentation/bpf/bpf_licensing.rst | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/bpf/bpf_licensing.rst b/Documentation/bpf/bpf_=
licensing.rst
> index b19c433f41d2..05bc1b845e64 100644
> --- a/Documentation/bpf/bpf_licensing.rst
> +++ b/Documentation/bpf/bpf_licensing.rst
> @@ -89,4 +89,8 @@ Packaging BPF programs with user space applications
>
>  Generally, proprietary-licensed applications and GPL licensed BPF progra=
ms
>  written for the Linux kernel in the same package can co-exist because th=
ey are
> -separate executable processes. This applies to both cBPF and eBPF progra=
ms.
> +separate executable processes. In particular, BPF code bundled inside a =
libbpf
> +skeleton header may have a different license than that of its surroundin=
g
> +skeleton. In other words, the license of the bundled BPF code does not a=
lter the
> +license of the skeleton header nor of a program including the header. Th=
is
> +paragraph applies to both cBPF and eBPF programs.

The doc is clear enough. This is unnecessary.
Otherwise we'll start listing every project that bundles bpf prog
in some form.

