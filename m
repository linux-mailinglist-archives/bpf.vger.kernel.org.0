Return-Path: <bpf+bounces-28875-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA61E8BE61E
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 16:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8413D28CF86
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 14:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EFA715F40C;
	Tue,  7 May 2024 14:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mq6/KdbR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357DC1514C5;
	Tue,  7 May 2024 14:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715092593; cv=none; b=Y9WKM4PQpRdGxZRepq01FmdWDxDivp1E9vqnZtjOLy3YLDrcgrkZB1ms9juj/ZEPvwvHVhS+wVJU7w4TCK5dHBLcTRlHqHvc1xtEQuxgU81XXelN1xtFR5qh0RgB/ZtV+DNlSItgJMct+lUEqV/g44RK/vxB7OhRkxsrJpwr7RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715092593; c=relaxed/simple;
	bh=ltkHF7USXEUiblC57EI2w5ExeCBBkAO5TlznSzRIeWg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r2b7a9Y+qJY5cJ57h/0Lvjx4RTeC9Q1b+65brjXJIi0T3pgLBCqEEWt38oP53aWK3OQhqfs6fhL2AGtyftA+xA/fiW3iUCrNsZwSW/0Yi82ml+msKxoEGomcWXGX6NPYbKJ/l8GsEAz06x+E0a86WRnGTBVtktyamRPgqkdh4EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mq6/KdbR; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-34ef66c0178so1873018f8f.1;
        Tue, 07 May 2024 07:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715092589; x=1715697389; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ltkHF7USXEUiblC57EI2w5ExeCBBkAO5TlznSzRIeWg=;
        b=mq6/KdbRwdTPQMSRwYPD3fXvfvoj3V8L22IKTWwAtkaI/bgezFfzTd8JIJizjhrNWD
         Qd+q2XQh3XY+WRw0DlUK4SyocXMj28jMojqvf8C562Xk+7/+XO+bym6QvTZQauaGHKS5
         xVD8OFy7/ZJsUTEEkXvMIwnnpiuC/t1X5+OXAASr5gAD9IoIsCv8K1u8f9iB/+Oy7XM2
         Rrr461egeZyLcwzcZK0nCPVWaW5uL3cix0l7lnLkEW5GJkWjsYr8EyxGok5OU38nrB9m
         9sjXgQ9VfECgQgmYnjXWZ2NzD0s91OAgP6Sb6vIDS0f5Zuk/EkYOC4Ljq7EIJSWPKrrE
         Rbvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715092589; x=1715697389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ltkHF7USXEUiblC57EI2w5ExeCBBkAO5TlznSzRIeWg=;
        b=X0oaMgafNaKUuL78FMi4536T7kq+I3z70H3FGSiL1YtNGKfo32igi3etCK59qp3dB9
         pKQ4QiMgbJwmNHbue3ewuJrYRI2ubIv4EiIKMu3MOwLss1iKU0QsPaD4URjcIf+etIq/
         a37fuu3R6U7MNj/MZbOC8uTvm9c+F8ScptvZLgPpKt8flpzKQdwoJtQr4n2PW220viQX
         FP8o7ZRBGv3yewqxuYgLaaZ5v9EQm0h/9Rc+Cn216ih4fr4PbBrIjWJ9wuPnwLifWJ+0
         F3o8pyM+oKW+eEyLhWWFICQ8Iayar6D0UPUN7xNih014wnyXv83bnAds4Z2mJ7ddlxLj
         fKrw==
X-Forwarded-Encrypted: i=1; AJvYcCUDH3Z7myb5KGZNqm4JjcOtx26jecXo+mrA51OU4dIR2XDrRg+ASnt2ciqXGGIWXYKaX9Vm1v4BPvIVkvqol5izbS7f/iBxA3kYHjdO
X-Gm-Message-State: AOJu0Yxek0Y3XMvGQbolktFfisSvCEnEm3bNGDyS0Per+iylTlzoAEU0
	QNQ56fsjm4oOdX0M2R+XbQmNw4zfsIGxR8EJ5Gt3s3n0bcKjV3FDrBlgkUTEfE0HQ2bRvDpQV9D
	rLWPFhGk08jGorgghQkQCuIYbHmU=
X-Google-Smtp-Source: AGHT+IHTsLpepLtn1ceKo4nbzm7tDYWoONlZoXEISnwYHFP/Vzwk2BC/YEf3kkUVPJYp9IlI09mYAlfXbVpY7XA7PkQ=
X-Received: by 2002:adf:f8c6:0:b0:34d:9c8f:61a1 with SMTP id
 f6-20020adff8c6000000b0034d9c8f61a1mr11820520wrq.60.1715092589280; Tue, 07
 May 2024 07:36:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507024952.1590681-1-haiyue.wang@intel.com>
In-Reply-To: <20240507024952.1590681-1-haiyue.wang@intel.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 7 May 2024 07:36:17 -0700
Message-ID: <CAADnVQK7zD312WRJboMib8HJnNzN=i2FKH2QxkVVy736b7sNTQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1] bpf,arena: Rename the kfunc set variable
To: Haiyue Wang <haiyue.wang@intel.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 6, 2024 at 7:46=E2=80=AFPM Haiyue Wang <haiyue.wang@intel.com> =
wrote:
>
> Rename the kfunc set variable to specify the 'arena' function scope,
> although the 'UNSPEC' type BPF program is mapped to 'COMMON' hook.
>
> And there is 'common_kfunc_set' defined for real 'common' function in
> file 'kernel/bpf/helpers.c'.

I think common_kfunc_set is a better name to describe that these
two kfuncs are in a common category.
BPF_PROG_TYPE_UNSPEC is a lot less obvious.

There are two static common_kfunc_set in helpers.c and arena.c
and that's fine.

pw-bot: cr

