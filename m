Return-Path: <bpf+bounces-74528-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9DCC5E453
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 17:35:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D13BF3690F1
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 16:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D43329E79;
	Fri, 14 Nov 2025 16:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c2GvzZvc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07C7329E76
	for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 16:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763136898; cv=none; b=DX0zru7uW400WB2uD87gkypUjF1i9d3NJMsBCsH+xZs2yVJT7XKbeYnKnUXHVegV2xUudzTxI+s8YKZJbWLwmxtVawlqNmhcUX4r0v7iGTc0AH0cMc6zjQDjiAu3VlZZHgk7zw9rlghkv7Pbw9ZvU31pmI/PfK1OQGkOnoFOA9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763136898; c=relaxed/simple;
	bh=0KEMRnM9OlC4P/LSEy02FovIuGSAeGZa97d2f7KESG8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hR5s0vlUIr+upiiGC3R7Osjx6EraWkdJfKpIfqm49ArfT+tvPwv01dxAMGoYfM18WVZFwYVPbrkkT7VswU4zOfWWInFj1lIVwdziHEYcsw/93FTS3y04tzCkMH1CKtw/4ybUxTajuc1VSuU+SqGMnaFcy3gxHmvBw0G59VoUbIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c2GvzZvc; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-42b31507ed8so1728515f8f.1
        for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 08:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763136895; x=1763741695; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q9m4N6m+GpmnkcOX3LOBnUDNwNK5sGNIv80VL76U6SA=;
        b=c2GvzZvcLSKuuUgdKpmm30hJtBBR9sYUHCjG3ELiEkl+OE0O/siRD4wbGI8GypbiSR
         fiqotJKhbGqNUEKL5nAxPp7cje0SkJJsMl4dhUCP2tFq6cwQQJnmlHqO4OtGgMx/pWFo
         5KNqDxC8wyEwT8ZBSHvlPWJYUy2OmvME8DT7IZL8qJBkiAF4OuZ4QXfvALklUiOJY1RT
         6fd48zmjcYjcgCQIYqx9mUDWbslxwKYlqLOlsar0ZKo8022BI8MZjNOtG3/MqImgKfQS
         d2q6y8AqlZtiDkrYDjDRpRHj0xx4aSgvXrElZnAUD5C9RxwmapwpgBrZW241v8eSH7Xg
         LLrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763136895; x=1763741695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q9m4N6m+GpmnkcOX3LOBnUDNwNK5sGNIv80VL76U6SA=;
        b=UhIwyHCjUdDQOCEfDPI0S9fk5sN058RQ9sW2xmo5C91R+Ue4QP8ezAwuszFm3lu9UU
         SyRpuLP0WfECeiBMfWF6xvwcUpDpmO9vc73vk3z4le6/eCbA+BvNotmCk5ipHdaRAB2w
         CXFp2oHJizGTr5EvvTYbGmFHfyUun9Whi3MhDC0MYWMWUVY/E8Y+1xzrtRZqvyl3Ze7g
         YoS8qYXz2BfONtib7uRE4QGUv4f3Cfz0tPJbOFNREz8oVLJlHmbznGSDfZRp6LVqY/Yc
         xPDSe1UemW6GDU9s05yuyavPgwG7HWpwPFc3F7HTupnOl+jqYaXYPyTGg8zCzaAds5CN
         X9Tw==
X-Gm-Message-State: AOJu0YxUros50glR1o3oPBE3Q/eTVIqZBEcqGFBAINKHbrNXsLSOS3qq
	Y6l1rcAjaM831N/8wUTUqu952hasZNh4CGqJohbeodjkYiwAoxKqENCanAqTzfRwWdozRDmjb+R
	Ds2wr+rBtnvIL2ndk5roav1Rag4TUSbE=
X-Gm-Gg: ASbGncvw84OScdxeNsUsp37F7JKlJOSghTmERFnXWegy0Wg97DK+Q/P6jaTvO73vdWP
	ZTCHVV+pVjvvSaWqLe0Ph2dUEYZlFxN4RkYy1iSKWhpBJaJ+QQYMxO3Mrrk0UI0XfAADRFa80tQ
	lcd6c3insi2lRvWTN2ri7dditUEcKEOGuDncIdgvZtf0AAgriUEArjK31hpx1RpMptbGfWWSXzU
	qdS6Wnbg63XZmZFW6GFKFwJ2GpdvtFMvjhufjNIit1PXz6Abt9s9O3SHkXIEABvJUlJnXtFQRnR
	8m0bLzc6ZYvYSHD1tBES34eptROq
X-Google-Smtp-Source: AGHT+IHF79deL2JaC4EHdXEWbtnO/OZxWZ1Xl+R66rYMHVHfX9VDSVtfnAeiEp4svQtmx7EsqK9GSy8gkmQZZM0oXhs=
X-Received: by 2002:a5d:5f90:0:b0:429:8a71:d57 with SMTP id
 ffacd0b85a97d-42b59356aadmr3612069f8f.27.1763136894857; Fri, 14 Nov 2025
 08:14:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114031039.63852-1-alexei.starovoitov@gmail.com>
 <f273691ffc4f2ca3a4f6b16abb50804f60aa4fe9.camel@gmail.com> <62b71f16bf43e6045fb3c37a7b4db7d959a17739.camel@gmail.com>
In-Reply-To: <62b71f16bf43e6045fb3c37a7b4db7d959a17739.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 14 Nov 2025 08:14:43 -0800
X-Gm-Features: AWmQ_bluu05ULUMDsAeYUHmYxTL_DSl964t-u1eKy3Jzl6iQCQP9KcJnNRGqN-A
Message-ID: <CAADnVQJ7wQwkuiySTEokaW-nuEPKwKbtW1N0TZKt7Da_etHPxg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Recognize special arithmetic shift in
 the verifier
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, Hao Sun <sunhao.th@gmail.com>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 11:48=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Thu, 2025-11-13 at 23:26 -0800, Eduard Zingerman wrote:
> > On Thu, 2025-11-13 at 19:10 -0800, Alexei Starovoitov wrote:
> >
> > [...]
> >
> > > 227: (85) call bpf_skb_store_bytes#9
> > > 228: (bc) w2 =3D w0
> > > 229: (c4) w2 s>>=3D 31   ;
> > > R2=3Dscalar(smin=3D0,smax=3Dumax=3D0xffffffff,smin32=3D-1,smax32=3D0,=
var_off=3D(0x0; 0xffffffff))
> > > 230: (54) w2 &=3D -134   ;
> > > R2=3Dscalar(smin=3D0,smax=3Dumax=3Dumax32=3D0xffffff7a,smax32=3D0x7ff=
fff7a,var_off=3D(0x0; 0xffffff7a))
> >
> > Forking states is an interesting idea, however something is fishy with
> > the way we handle &=3D. After arithmetic shift the range is known to be=
 [-1,0].
> > I would assume that binary 'and' operation cannot widen the range,
>
> Ok, that's not true for negative numbers.
> Each switch from 1 to 0 lowers minimal value bound.

Yeah. The 'and' logic is difficult to grasp.
First tnum_and() makes var_off=3D(0x0; 0xffffff7a)
Then scalar32_min_max_and() refines bounds to
smin32=3D0x80000000 and smax32=3D0x7fffff7a.
Both bounds are impossible.
It feels we can improve it by keeping
smin32=3D0xffffff7a // -134
smax32=3D0
but it's probably only true when starting from smin32=3D-1

