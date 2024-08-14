Return-Path: <bpf+bounces-37182-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8402D951EFC
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 17:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FCB9288B32
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 15:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB01C1B5836;
	Wed, 14 Aug 2024 15:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R9rbK/+s"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41711B4C47;
	Wed, 14 Aug 2024 15:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723650413; cv=none; b=GijOlhTn/APSF+Jk4+tx697e+gczbZdxETCSwDn5zEGosxcuKAGXRXWAz/Pz/ko25EDVnRLVxszIFvbEvx/4mcjXyiXVI8IcW3ZzQAPETcc8ZQKP7EkyPKhoW0n7A4O6DD78ZVhj5cju+doDunMdAVSZEfwWy/D+mxsNjenZ+jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723650413; c=relaxed/simple;
	bh=V98U3jCry57U4aW6dz/YHzEaRCu3ocsWlI6bKED4zi4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GEoQF9I1TrjOlSGjfNmgolxwVpM5GnjJ8BCqz5qwOrWnzIixAXxFUWwj25Sg+nszveUea1WZHpeR/tDzXMRIfIEIoZjIAx3j6P/8+krO5WgC7OYpMLqR9x60e/WjXeIfz0YflGFaoJ18kk4Dfv6kZDqwSIu4ZGNfqk6680VlAeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R9rbK/+s; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3687f8fcab5so25186f8f.3;
        Wed, 14 Aug 2024 08:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723650410; x=1724255210; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V98U3jCry57U4aW6dz/YHzEaRCu3ocsWlI6bKED4zi4=;
        b=R9rbK/+subVhm+qF2oDPnLZQbgMN8O8yTc70tkW2OIANt6FaGJoQXaomXCpqbcQI8h
         YVfCf5JvB/iMXOUgrQgLX3J3+JsXh+yI/pvZu0JkCGlLXLM6HwTd4VtMJQxETUpDWWOx
         Yq6pbqi29whbRWQySC6zmEStCBxkb5R1GK04qfW16i4dQ+dNlLr8BQfHRNIApQmNmxOd
         CqOkzOSKr7TsS8Gsjyekq4TSzioKO8qLDMqZ6Vtaqh8D7HgmTrFMOnfpmEJBBVvac875
         h07pIlBPqj9GEZj8nfvn2ihQTruldJHU5sJrGOGHfZYLmwg24EiiVs0m9ATTMLfacCtu
         HDGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723650410; x=1724255210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V98U3jCry57U4aW6dz/YHzEaRCu3ocsWlI6bKED4zi4=;
        b=cDY8LWhcnnrdfFFnMBgcgQokpRYJoL6pyJwS6IVm/HdUJ1+AsQ7sKf2HbSQqvZweNk
         FYhAujSo1WcBl4Ql8zZStLeLJh15vn14ZbOgGwrdZhVBF2hXGuPun6t/X1aOkKLaeX88
         9+bTWqHKUu88oP7H41YRM2mh9s0/4MfuzfirNVr72rAGKXXJ+tokstEeZwscuvD1Zz3z
         Eqp5nHb8beqpEhD4eRzfRZ7/nXTATxmUbWOD2PvkDEKgO2Xa8MaaGsPgBo81EhduWMkv
         DLKFdbr/PLpJ4d0/YhHnseEEfbK4zgFLw20aGBiSwHaJYDKWCPIADE7AtF6ORw7RR//A
         SV3A==
X-Forwarded-Encrypted: i=1; AJvYcCXNe70C8LRI/YpK06idImB+/CEwmegrYfzcR/8EXtfaloo/qKKfbw3FJ2iQzLShEsVS/wA7TMA9mF4QkXlUCp96c80bMjBKew9/4mjDNyELpVz7Qws9+RvxwdXlcq/S2AU27NyvSbNe/Q/sd8VJz9i0N4XmSmaKttXdREbnDvi3vFDe
X-Gm-Message-State: AOJu0YyHIbQy+2Fn79k3ZbtDwQLKixhoPxCP2Tcomy0XT5+UNLbeD+52
	snlDlxuRR1umAI5JRvlZAQGoDFPM3p+RY9dcX6c7b8FY50ocvG4SnfAsjBqlCMr5MOc1GEGFtCS
	f27SJjJrHm+ZiNQGTQ+q1V4gbHro=
X-Google-Smtp-Source: AGHT+IEhlHRyEw+qi7xVhThlYz/esvqlaaHKizoRnHdoqbmGK7jkzYrmvkgfq8k4DCAE2nFrtbKwvRWPvufyKIqzw98=
X-Received: by 2002:a05:6000:4388:b0:371:83a8:afee with SMTP id
 ffacd0b85a97d-37183a8b1d2mr475768f8f.27.1723650409921; Wed, 14 Aug 2024
 08:46:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813151752.95161-2-thorsten.blum@toblux.com>
 <CAADnVQKEgG5bXvLMLYupAZO6xahWHU7mc06KFfseNoYUvoJbRQ@mail.gmail.com>
 <2A7DB1E6-4CCE-446E-B6F1-4A99D3F87B57@toblux.com> <CAADnVQKw5x6sTwj62p4vxSqtjdisHEKhtKdPp_zK4t7rtDuWhQ@mail.gmail.com>
 <968A8194-61C0-4F9A-ADB6-8A6BB57E2A57@toblux.com>
In-Reply-To: <968A8194-61C0-4F9A-ADB6-8A6BB57E2A57@toblux.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 14 Aug 2024 08:46:38 -0700
Message-ID: <CAADnVQJWdiwoUqtF9CgKgkLD0oHeTaOkUhsfz0Y=0Ow+79KyxA@mail.gmail.com>
Subject: Re: [PATCH] bpf: Annotate struct bpf_cand_cache with __counted_by()
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Eddy Z <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 1:51=E2=80=AFPM Thorsten Blum <thorsten.blum@toblux=
.com> wrote:
>
> On 13. Aug 2024, at 20:57, Alexei Starovoitov <alexei.starovoitov@gmail.c=
om> wrote:
> > On Tue, Aug 13, 2024 at 10:59=E2=80=AFAM Thorsten Blum <thorsten.blum@t=
oblux.com> wrote:
> >> On 13. Aug 2024, at 18:28, Alexei Starovoitov <alexei.starovoitov@gmai=
l.com> wrote:
> >>> On Tue, Aug 13, 2024 at 8:19=E2=80=AFAM Thorsten Blum <thorsten.blum@=
toblux.com> wrote:
> >>>>
> >>>> Add the __counted_by compiler attribute to the flexible array member
> >>>> cands to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
> >>>> CONFIG_FORTIFY_SOURCE.
> >>>>
> >>>> Increment cnt before adding a new struct to the cands array.
> >>>
> >>> why? What happens otherwise?
> >>
> >> If you try to access cands->cands[cands->cnt] without incrementing
> >> cands->cnt first, you're essentially accessing the array out of bounds
> >> which will fail during runtime.
> >
> > What kind of error/warn do you see ?
> > Is it runtime or compile time?
>
> I get a runtime error with Clang 18 [3].

...

> [3] https://godbolt.org/z/cKee95777

This is user space.
I'm not asking about generic description of the counted_by feature.
I want to see the actual runtime report from the kernel.
Can it even compile the kernel with -fsanitize=3Dundefined ?

pw-bot: cr

