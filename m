Return-Path: <bpf+bounces-63738-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A56B0A7CF
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 17:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78799A860C4
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 15:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71FDF2DECBB;
	Fri, 18 Jul 2025 15:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kx61WjNj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7D42DE1FE;
	Fri, 18 Jul 2025 15:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752853172; cv=none; b=cwsXhKHNPUA3Q1i1N4JxkjSoMicKOvVmPNSZ6Io1cBuGqwohai3AI+tP9IcEVfksxIAZZMDc9bHDOmwC4KRS3exckofznZzLUgrE/ifa7W1uOy7NrDPzzK9Bok5yKOPFVG0jDRZoyGY9c1vnBTRn72He/Vq9nxNCQuaS3tBh05g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752853172; c=relaxed/simple;
	bh=9VSV9uLZb50DfyKoCnVz+avlkKOMbZZ5AZGoFFpkR+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=myo1tFLFlyVpw/m/KNRRjG4Icf+ntQvgfp2tuC7MS8BWHXiRPZul+ERx9Wp3csIVikNDU6Tsv0GjX/VnKv3HQY7EcK2WfiuwBpSCAGD0RZ594Qx50Dj8qrV03puqd8S/7wjxyMtH+dLD1Rcs8CXGURu6qCDOg6bpMcy3llcqjR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kx61WjNj; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ae708b0e83eso394092466b.2;
        Fri, 18 Jul 2025 08:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752853169; x=1753457969; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9VSV9uLZb50DfyKoCnVz+avlkKOMbZZ5AZGoFFpkR+o=;
        b=Kx61WjNjYVsPyp9+RcAroDkuRTrLDQurdCeKzRZ6bA0LdFJcuOFmJSsTp5jMe7l4Gj
         4HnJGeDcuJBYGzos6IVB9EXxoYC62HtrCrhpfU03pi45bAcusJm/uaNN+B/X1Z+XmdGC
         SNbtZkIrQOS1/MdnxH5ZhrL6y7bRJc/E/WdjwGMmlVQTuTaP6QgMiW/zD06k+9n07dWc
         ypmtY0dezqobS5wqyd+xjPKq7E29uHUCo+AvKloyLcqhOEARMlWl0OwK94wOObepges0
         MeN5bB+Q3FXJJdWnd82VP7eWFxo3lbFtCgZQy+vj/LkbtpmMzoJ95vrTImokfqYKFfbV
         4UIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752853169; x=1753457969;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9VSV9uLZb50DfyKoCnVz+avlkKOMbZZ5AZGoFFpkR+o=;
        b=Oo6QLTAV9Q4iti9bsK3BSf65kdQdVycPWkAALAM5NvujrmQzgBZcjvMvhjw0K0n3wh
         R+HRo0xCg+9xfjPtqgPHNlhpAZIzOiheo0R55zVp5zQiHMwzZWhjZlso7oi9OfLy1qJz
         IDTYSKX9K8ETwt0zNPuDblSg9oQnycW9nTuZ4jyntez5NJV0PTASHT2iB/+9UZaeD2oO
         4fRAuIjz/sBdj3t785vujVKSyIES89DufjtUkTYEFMhE6o20F2KNQyliACbH9eYWSMEa
         18XPZ6ijE0oSO7t0uYJPedMOrxP9Mxlkw5Np8accrRjdcGI5A285Yq0Z5xxqBYprxr/S
         Jlyg==
X-Forwarded-Encrypted: i=1; AJvYcCU6++l5CRnunK+ip67N5P6Eu8id59UAtcF13UQdeeogEFz04SmEPghEc43rWqcQQNPlIdmWNF6aaWM6syZt@vger.kernel.org, AJvYcCWoA0eX3Q3RSI7fu7m+fki01yRmtpcaLYrmnHMRCAiqPCPMV3MKznBg2w7Ul877vS6d7+o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1Owlfe8gHrESJQCwADEdh/UhMvuF+fPQ44xueeamTc077ECzi
	ucLp6+cctVk3fY8EClbrJBeDtbtjp0S/dAMRhMTtChLwQ8dysdeDk4THg8TL/JT+INgi2l1VX1v
	ae/0TkE+o7YDGFH+E/cTbluG4+n/FrCBPBQ==
X-Gm-Gg: ASbGncuBO8y8jYON4WiQOoRQBFjnJL0RFtjfpmbJOM9STmn04FF8hMJ1YWGFREbVGcR
	R4w7k8c/GXC5/MDyxHU50YJLo92sRLLvcYbSCuqMz6FOVfRf/1tgzxag4I4juLG84HfXSw8eklq
	nbvZUtiyljLSZZXYhvriylAnPnE1ZygQWWzYJKFq1Z5wZYUjBL3UYDE2qAkgEs7v8C1MTw5unFb
	QrQ8g==
X-Google-Smtp-Source: AGHT+IEpeVxME6aVq15riUIEW3IcE9rZry6wSWfhQX8HqiZb7qciuqAosUdiKMt2TXpE4cJ1jOG0BXke05WcjyCrYC8=
X-Received: by 2002:a17:907:989:b0:ae0:b7ef:1c11 with SMTP id
 a640c23a62f3a-ae9cdd86a54mr1116865766b.5.1752853169232; Fri, 18 Jul 2025
 08:39:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250717115936.7025-1-suchitkarunakaran@gmail.com>
 <CAEf4BzZ+OTkaXmtWPbOGB0OWz5xmj-d06UWchooO+iUyDHar4g@mail.gmail.com> <CAO9wTFgLOymS+VDcUTCHZ7niu_gEgN-N-F1uX-Kpm+uqvaMrQg@mail.gmail.com>
In-Reply-To: <CAO9wTFgLOymS+VDcUTCHZ7niu_gEgN-N-F1uX-Kpm+uqvaMrQg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 18 Jul 2025 08:39:01 -0700
X-Gm-Features: Ac12FXxnbJSkiNaYLXamvASk4rtFXxTiGngAImtikLHkoEBtFQMXFsQXoFL0bO0
Message-ID: <CAEf4Bzayn6UNjjbtgA8i2n4-_kuyERnOZAZMfc4cXTDKrSFr+w@mail.gmail.com>
Subject: Re: [PATCH] libbpf: Replace strcpy() with memcpy() in bpf_object__new()
To: Suchit K <suchitkarunakaran@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 10:33=E2=80=AFAM Suchit K <suchitkarunakaran@gmail.=
com> wrote:
>
> > This is user-space libbpf code, where the API contract mandates that
> > the path argument is a well-formed zero-terminated C string. Plus, if
> > you look at the few lines above, we allocate just enough space to fit
> > the entire contents of the string without truncation.
> >
> > In other words, there is nothing to fix or improve here.
> >
>
> Even though it=E2=80=99s safe in this context, would it still be a good i=
dea
> to replace strcpy() with something like memcpy() since it's

no, there is no need. And keep in mind that this is libbpf library
source code, which is developed as part of kernel repo, but isn't
running inside the kernel itself

> deprecated? I=E2=80=99m still a beginner in kernel development and trying=
 to
> find my way around, so I=E2=80=99d appreciate any guidance.

