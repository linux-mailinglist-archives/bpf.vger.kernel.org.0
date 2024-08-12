Return-Path: <bpf+bounces-36920-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A3694F61A
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 19:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC5741F21C4A
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 17:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C258187FE9;
	Mon, 12 Aug 2024 17:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XGv10sav"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84295186E36
	for <bpf@vger.kernel.org>; Mon, 12 Aug 2024 17:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723485037; cv=none; b=Q55Qpmy7kZvBxl3YqkiKgQWkV/+vLZs5F+Gs5QVdiSvkntKpD69+4U8yJjll+ULDOdTlo+TE6tDZfmYjXACaVa3nEOYR16odNnOXtK44pGA0TODJwep/o3JXtlkQK5cMFFz801WBcyekJXM3vkFYAaUHHcFKqir30bWYV8KvS7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723485037; c=relaxed/simple;
	bh=f9RdjIKJJTMRD15j3d04Dqo6vNZ5yr5cCSUwrmJc5bA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HiPt98msYvSQ+6S8fwyibi/H8F6g/4pMXon61qLL5NNBF+WJspvWHsqmoL616tnz2ZmwbOwejNgY1fYY3EaXXZBMjVKfaImWB7ekGQUYr2A9Hwmh36473oYnA+Ya9Gty2IOQR+VzIRThQwD5E8O46ROzhAtG9sSe4iPdMgHthTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XGv10sav; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-428ec6c190eso35565525e9.1
        for <bpf@vger.kernel.org>; Mon, 12 Aug 2024 10:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723485035; x=1724089835; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SaBT7wIBwXf7eDQCNd/ELg0jUnVVwC8t9AXJrsxnRZo=;
        b=XGv10savVMaKYkpYJi9rpvYG+Qf500nYxDeWU7Rop6Yyu3V4pdprKipmkXYcLiFZeI
         7VYiTEgJJ87x8YS1Q4NHmucLoA+bkl3eGv+kby20FpdhOvBiw24KEclinjB2zAs9INSr
         I8bBM9l575N/T6SQI5snEHCOrsuYwXvXuBixqzET0HUJfdd1T8Hrtf5Hg6joYzLWo+pS
         +ki5+lKk8nL0XACQ5yixqvkKbXnhZrFcuYeewI69hf2rYnzNf7zfCqaJqrvogLfrQqFe
         fM+XyYz/b8BMQJHR1YkgHDdJqmM34FbIW/94p5R/LeU4+WWDCBFLKr9K6AUYYhGFARyA
         I2zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723485035; x=1724089835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SaBT7wIBwXf7eDQCNd/ELg0jUnVVwC8t9AXJrsxnRZo=;
        b=TQabMwebrMQM9kJROKeqaHj955yb/IQYccbtAc0tPgSa7pmjm3gHvH8D4qQH2g/r9f
         J8x32XAfaPS0nfvUqpCUabdOf2icC+YLk/2L8mcvc24ZnYLiTEEhkd7BBttOg7YPBs6E
         QG4qQHKhO8YHbFy0Ny2gJQFtlyDL41dlz7qBmxMQFLnsJPFM2ha3muLwvZZ0836I1Tsh
         Ek4ISUcOg5vk6VteXDxkBgvoPZLAkrBfOkGF9jii458yGa2uRvXAVwiHtu65hrlOUB+Y
         j4JcWuPuHq0EbrAlYXv41YquoWrNaLQ06SHFZfWeYuedJSMgxIqr6C72Un8VTC8nBfaO
         nkSg==
X-Forwarded-Encrypted: i=1; AJvYcCXYstzJf8BA01mDPVTzDGiMYTPIS6wtdOsyuXSdlUhGo3vIKZF6nETutZ9oju/P8w5jPsb1J0Vtcy7+iFwAYySnIhnG
X-Gm-Message-State: AOJu0Yy/4t3A3HfVbreAcUgEsZ8au8kKOJ60vpE11KIZt5di1feGkUbM
	w+OIwA0n/vS2Emqp+JS8+F2bDe9MqysundRycFStynp398/W6ngCNOrzXo1xUEWhtVdiDMCciKA
	XxpUsXGn3WqT8PRBeVqRPeja//Io=
X-Google-Smtp-Source: AGHT+IGQVx62FLiDaiBuVWYhI59JU35di0M64OUd9Lz1rB0fxbfsHQLIlvZILYW2XwmHLR3jaeD3j4E9UWNmbsd9A7Y=
X-Received: by 2002:a05:6000:178f:b0:367:8909:197b with SMTP id
 ffacd0b85a97d-3716cd2ea96mr1077286f8f.61.1723485034704; Mon, 12 Aug 2024
 10:50:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812052106.3980303-1-yonghong.song@linux.dev>
 <ffac004eab4bfe98c5323a62c6e47b25354589bb.camel@gmail.com>
 <CAADnVQ+-om1OWRyUvWoiVg5pKM7cxOCVw4wZqdZM1JTRTg4-5g@mail.gmail.com> <d2ca7ec0b51fef86ef8cd71202ee5b6de7dc42cf.camel@gmail.com>
In-Reply-To: <d2ca7ec0b51fef86ef8cd71202ee5b6de7dc42cf.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 12 Aug 2024 10:50:23 -0700
Message-ID: <CAADnVQJjY9NU7WBxUNqOnLEpm6KhgHL0M_YobQ=2ZjMUHq3_eA@mail.gmail.com>
Subject: Re: [PATCH bpf 1/2] bpf: Fix a kernel verifier crash in stacksafe()
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kernel Team <kernel-team@fb.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Daniel Hodges <hodgesd@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 10:47=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Mon, 2024-08-12 at 10:44 -0700, Alexei Starovoitov wrote:
>
> [...]
>
> > Should we move the check up instead?
> >
> > if (i >=3D cur->allocated_stack)
> >           return false;
> >
> > Checking it twice looks odd.
>
> A few checks before that, namely:
>
>                 if (!(old->stack[spi].spilled_ptr.live & REG_LIVE_READ)
>                     && exact =3D=3D NOT_EXACT) {
>                         i +=3D BPF_REG_SIZE - 1;
>                         /* explored state didn't use this */
>                         continue;
>                 }
>
>                 if (old->stack[spi].slot_type[i % BPF_REG_SIZE] =3D=3D ST=
ACK_INVALID)
>                         continue;
>
>                 if (env->allow_uninit_stack &&
>                     old->stack[spi].slot_type[i % BPF_REG_SIZE] =3D=3D ST=
ACK_MISC)
>                         continue;
>
> Should be done regardless cur->allocated_stack.

Right, but then let's sink old->slot_type !=3D cur->slot_type down?

