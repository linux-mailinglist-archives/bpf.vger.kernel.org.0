Return-Path: <bpf+bounces-53598-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8BF8A570A2
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 19:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB6291899CDC
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 18:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC2924291E;
	Fri,  7 Mar 2025 18:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hX4W95Oa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB8424290E;
	Fri,  7 Mar 2025 18:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741372582; cv=none; b=J531P9fEVnit+IVC5XY1chruEswo4FpsizwazufzR21D85TTS7+cNzr6zhOG5BrofJmuOmkNtqeRkDz6rp5WkIZjfPEIwbpWttYpP7XChvJCpJsvgO6cgG/vZ5LhaXUsJhfq67r24wwsDETz6Ikz0Zw2sLH4ijejsfm0WyAjas0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741372582; c=relaxed/simple;
	bh=VjTH6plqcZvBDdddTjogwWTre64qSdiWPcfRztS5aBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XL4rzUOpchq0lbBwcn4LtijyyhMYm7EYttYtgr6OtxaGK4+8er3MeLoRbKoh54shl9AUMmi+LUYiHZ9Q86pT/7PyGgSOtxBjPUSy4W8QigkpputF2vJyVJ6qqXWzCrhts6dJlWs3tprYWoKabmvNA+3rxXFSILD44UNbWm4tb2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hX4W95Oa; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-38f2f391864so1239341f8f.3;
        Fri, 07 Mar 2025 10:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741372578; x=1741977378; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VjTH6plqcZvBDdddTjogwWTre64qSdiWPcfRztS5aBs=;
        b=hX4W95Oak6Z9hNElv4CIhN+B9/iG04dfRGzVhUq3ziFCHwaF6dpMBQxapzDvEEeJmc
         xDdEO+OmNlclaWvO1JFl8A60GZ53FB7rZxppxSjQXH82SKsPHr/gvTEvbOB573SqGGlo
         L1sxthw6F9hcANO9GSvKB7drfNhLlocIruqQdV/ozfouMxrX3vqeRBnl2V2ZD5bVVhBB
         tabsYsmYzW+OjN4GHGZ9uCeS4bbET3j7q12wKvPuCnq9XU4HOD+3kIl8X+oreenHdYnH
         cSPek37CrFx3djuZi2QXfJIPW1KaHQnHiSNjXYfc5KBbmQwWUoBvyhhNi1yoFuVzdLMV
         0ahg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741372578; x=1741977378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VjTH6plqcZvBDdddTjogwWTre64qSdiWPcfRztS5aBs=;
        b=bsvGbkCA9oSm6ZEvlMy79gGYtbi8mLVKhsEvMMFpHp/3lqW0DM6CtS1yIRva6xv1Mv
         0d1rNZdFajOF5HoqOwFWsQORF4eys9zmWnTMdmqCnub5kaW7Zta8EFvD62OZT2XqUO7A
         A9W2bruIEmCEvX+KrMVKhToerQQFrY1SRAN5Hi44r/8vPZR1q+MEyuCFlRehr8mqyRrQ
         O7/pzGWrOCMKmAjQDPVSBwUEy4a+IwivzqDTJiNxjTfAzk9Au7QYmye9OKHx/8mkHIvw
         3cD+Voe81g0GKQDD4DMsFUQrnXMSY3bCfARstyREb1vFvdmhAEIbSayMVFDV/sZ9hAbn
         +R4w==
X-Forwarded-Encrypted: i=1; AJvYcCUQjLrSuk7bxVlsqp9nBS1Xo43+0myqqELPzch1WVg8eW7bKoJqXG22LHf5j7E0C2O7wBU=@vger.kernel.org, AJvYcCVequTi3GTLSHDsrOv9leC07lGMYW9bJ9XOKubCydK0NUXV+ub0PqNvXGye+kIRF7D/AS4LnZC7@vger.kernel.org
X-Gm-Message-State: AOJu0Yzpx+OzSHNY923R7PXvcT75g7CvGeX3ew5eXN8jE2nVoG14t2A/
	r8X4Jbmt/w1Y9ONkWPsmaCW4wIexHrn19V+tSoQ+GrLoz76jp2eZTAuGrqDYL8gYSscWF00OUzx
	A1OSYD1B8UJOVsqomojMhX21lWUI=
X-Gm-Gg: ASbGncu7e3HE4N2slkASqRkfDVR/16l3kMNpTKv5ry9hLiiPL+lHIZhunqn13IoLydl
	cdUGnCb8QaaoMasvS6x/0bzmqMF+nJ9W43uK6I7SKOSX+JA4LiH4js500iAn5DA4XJLmtUh4Cjg
	vORBoUqvNWM1JWQ6BxVBH3j/OJxJOr7In6kj8Yulod2A==
X-Google-Smtp-Source: AGHT+IHlvUpuSooxXfPhmkTusPhnLkL/yc72Dx2QTIS3ymC3v9Vz/0sdHbQYUmMIyDampec7Zi3b7Mx6uk/gP/CSqlQ=
X-Received: by 2002:a5d:5f45:0:b0:390:f832:383f with SMTP id
 ffacd0b85a97d-39132d05b37mr3138939f8f.2.1741372578489; Fri, 07 Mar 2025
 10:36:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307-sockmap-del-link-cleanup-v1-1-a042364bbeb1@rbox.co>
In-Reply-To: <20250307-sockmap-del-link-cleanup-v1-1-a042364bbeb1@rbox.co>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 7 Mar 2025 10:36:07 -0800
X-Gm-Features: AQ5f1JpfgsurUPak953XsgB71wbqVXT4pcqyFsYJte6awhb500iB0p1CGpj3OfM
Message-ID: <CAADnVQLm9mvH=s_64RUcxOTMV7F_iAMN28PDVn8F9hw1kbeTAg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf, sockmap: Simplify iteration on link removal
To: Michal Luczaj <mhal@rbox.co>
Cc: John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 2:17=E2=80=AFAM Michal Luczaj <mhal@rbox.co> wrote:
>
> Since commit 75e072a390da ("bpf, sockmap: Fix update element with same"),
> using the _safe variant of list_for_each_entry() is unnecessary.

This is too subtle.
Somebody modifying this function next would have to keep
all these nuances in mind.
Let's keep it as-is.

pw-bot: cr

