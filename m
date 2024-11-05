Return-Path: <bpf+bounces-44009-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E16E9BC499
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 06:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FD531C214BC
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 05:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D141B394A;
	Tue,  5 Nov 2024 05:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k2feiB8N"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4400383
	for <bpf@vger.kernel.org>; Tue,  5 Nov 2024 05:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730783968; cv=none; b=TVHp/S5Mq8k0PrUdSmyYHlr6qINlkeCEXgb5WGNzmeIq0Keco7zxVcyoZlyfxpZQ95nb3IAdgz08/Rv7aqPfdnneNkjQiOwzqLflF2dcXF/HHUoTWrFO/jwsaxaCChzbngJqcY84+/JUognRzZLbeGkiEFqsaYcgbynQk/59jh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730783968; c=relaxed/simple;
	bh=aHoxqMdyjJvZDcbHTl5F2k5aRLX6v4tEUFF8tDza72Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D7S2JSeZKwxt1wIyZKx6XQhGbrYf4QtRjNmG2U+RevHaBohHf9OZNNgArwd6mM73D19g8mPKEKp3gO9b/qBCmSIL29mDwdAca8usB+FUtyIkGpX9nJjkLzhSGoKZSIOzeWfCh7X+JaB4XbPpod0wWxbM9hQrj2XZBLf2iLaaMmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k2feiB8N; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-37f52925fc8so3173942f8f.1
        for <bpf@vger.kernel.org>; Mon, 04 Nov 2024 21:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730783965; x=1731388765; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aHoxqMdyjJvZDcbHTl5F2k5aRLX6v4tEUFF8tDza72Y=;
        b=k2feiB8NC3YpaKu5cO8955FxBZA4z8OdHkhO/nuD4KIaobV9PIWMU6md3NKWheE1sD
         5dOll/zB5dG+Vioje7n+Mtq3eNXMvC0nQYflIvmiPMM3szcPNYcZFZYAdNmVnXNBG2yl
         KMXY3ih6+GUzZIt87KYhw9qH5Jg2cUI8R+qi6/lggl8rifvthsckuloLiFLGXK3YnKwm
         zfD5J/Ku4nYJzHoWSG0NHWeIUEE5fjb2Bsfj0Q2tPteSLayCyIte8vn1aZibcqUZGFw3
         xgcL61GW59yM/dgI7hbH/hRVYblYRC3fl3THv9xKYLa7VWo2C4iaCLttIsqcQqXUBkLa
         haEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730783965; x=1731388765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aHoxqMdyjJvZDcbHTl5F2k5aRLX6v4tEUFF8tDza72Y=;
        b=prVYkJW9OqnqhwtU19UfZ/BGNrqy51GV/0kOFDB8bsYgRBNHsTd/EGUN3oCJKXFMJd
         n3D4eSpSRmYrt94mDY9oj2beeb9F+zCHHwBeRoyWW4H8u+MGc7c2jFoqtX9NlQBYW41D
         BNmcP8Xfn/BQQnVvUsevqFmcon+iHpT1JYNVgYOoMEWTZCXJQnSlJ4Eq/WXpjrgdI83L
         RraxHER6KnrjE+BMGoke4z0JuCLaKGmaTNSEpwyqpWFuhJUv7e5iAr5s0PKBSMF5CMvH
         SYrQvWgFqGV8tp8A91nzAAbRU74rFu8R6n3LuXrPsljg9DANgtlx7YtQOe1bzgT5AdI+
         rUWg==
X-Gm-Message-State: AOJu0YyVJ0mK7/y07Q0UzlYf5w0jJyRfteaSg/1w0t4vIRWX+IBnoXBJ
	ZXVP60Enajv15ODYuHbY15FZxdXMBXzkQn5coLubavzPPaPUUQ1GRWKWwZSQ0zT6e1lkvBIPjbB
	XmrAda3u/q0yuUyVSqWXVljN7EYo=
X-Google-Smtp-Source: AGHT+IGf9IzlHH1bBgd4pZWR3feyBtN58mKvEZYmDpTzoYCEPtksblRva4kvRH+VFYLExW5gS8nAFroTEh808KAutTc=
X-Received: by 2002:a5d:64a9:0:b0:36c:ff0c:36d7 with SMTP id
 ffacd0b85a97d-381c7a49031mr14188322f8f.2.1730783965046; Mon, 04 Nov 2024
 21:19:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104193455.3241859-1-yonghong.song@linux.dev>
 <20241104193521.3243984-1-yonghong.song@linux.dev> <CAADnVQ+RGgtLtoc_ODv54gt0donCdd_4sLWS1oWA_nGStjb1KQ@mail.gmail.com>
 <34a35dce-fd05-4353-8eaa-0dc87a78dceb@linux.dev> <06f43c37-a789-49cb-a4b0-bc2c45ae9485@linux.dev>
In-Reply-To: <06f43c37-a789-49cb-a4b0-bc2c45ae9485@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 4 Nov 2024 21:19:13 -0800
Message-ID: <CAADnVQLNMCnpTr5A4yNwGnV1vET1oUt3sGgZGVSHz9amWgaYSQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 05/10] bpf: Allocate private stack for
 eligible main prog or subprogs
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 4, 2024 at 7:44=E2=80=AFPM Yonghong Song <yonghong.song@linux.d=
ev> wrote:
>
>
> Agree. I use alignment 16 to cover all architectures. for x86_64,
> alignment 8 is used. I did some checking in arch/ directory.

hmm. I'm pretty sure x86 psABI requires 16-byte stack alignment,
but I don't know why.

