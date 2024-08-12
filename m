Return-Path: <bpf+bounces-36940-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FCC394F7AE
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 21:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 998C0283C52
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 19:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013EB1917F2;
	Mon, 12 Aug 2024 19:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DU9gEAO1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E532F2C;
	Mon, 12 Aug 2024 19:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723492118; cv=none; b=YDrDJL1zoNYQZJ8WCFbr9Gk5QRIV8SFam3Cbnwe/BdZCTAcMRzkETDp8lyWNddKz2R5veQgF7bPf2f2ZUprWPR3YqJQPyauG9g+awgCIz7tgLa4A+IUWt83VfjAJUEvL97Ect1CkntdZpiL/CUKSlP+WwLkRkUZb5O0i/F2U7+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723492118; c=relaxed/simple;
	bh=M/+l4UvQKPZUEX2zTCTBbFnZJ2MokA5NF7Uc4lEDGzo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AybrZ89QcwxYCf5zgiqKUrDZbKoeS17qqR/hW9etCvKVcqJIzkbshbJOX0HsH4AL6p19lAP0cjVltbcsJoSHxgs39k4M2SRCn4PTk+jrlh6oqY9tDT3RF9emwc83FoMsfxwkFpQ7wwv3XeJnXuaAeM0ttdrPIV5hz/qCOuQkzds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DU9gEAO1; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-429d2d7be1eso5908835e9.1;
        Mon, 12 Aug 2024 12:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723492115; x=1724096915; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cw/hwCwaYZg4odjZMbkHzVBtbwYlPfBk7EjkscUZsNU=;
        b=DU9gEAO1i7g8gjErCfFjgp+VLEVllbk8uTPQXJnhOvn4abBtC5gWmLPQcZpfNBB0WQ
         QEc0D4CU+jMy1JO+gP0HpWywucbJR4X8nrjW9i+rTaJQSPpuCrvwNVzyvLrluq3ALBXz
         2qKv0RrEqgSFwevLk6fO29EgH21nc1cIua/KOuYs5MbY9G+BYIaAbCJtLaO6Ie2a5SVX
         /S/cx25PaY00hLz3xKS1rBjEcfyhP5fuPG5TGc56+fCsbWX3hhH78QDKFcEzEKzVCxJM
         klKoI2k3+iROVko9YOcqx9A7z874JlJ8pA3YAExF9eF9n5FkTkQfy5RSkNYMyfEeeTMU
         OmNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723492115; x=1724096915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cw/hwCwaYZg4odjZMbkHzVBtbwYlPfBk7EjkscUZsNU=;
        b=buhMWNvikUFwvQYVlgGZuT5QX3IGGSG9LWVmkYHStfKskoqs0P0Fpv6W8dihwf6Fw/
         9xm0uFUrhHW7dJYlq4XFi1Ete/tMjBn1Cv16aI3Ba26GevvZjrjoIUUUllSOZmDg04i9
         q1u15MNMxEtB6R8qLOUcOwKUVx3EqornGAeC91I4FSvGWysmSjDVtFXqxy/hXyECNtkk
         e1E22i+mmhBZuT9QwkA8ikw7lbqAWDXomyw6aHPvO+2+YpBrLQ6ZgnihIX5bOyTytFvR
         ewsLrUCmaqQFxXxBxBV2yo8hOH578gKoy0x8uXl0/FWFJYkKXuTO5L0wHJr/EAPjjJgU
         JgbA==
X-Forwarded-Encrypted: i=1; AJvYcCUifvk5PhfaLYbrSbZGS8ES5VLQFCXbnH/lswliIBJioN+CUabf5LT0SMxrjwl//5at0AlpUf7kudRdsRhYpLxiXKDBYToawkUuWn6i2OO5iflDTgzoCHgb0CfQosA7gVqWErISyrJJ6Qgv5ANzGblQLkq9ROEUoqEZDOdf1sx9Vx5UE8OE221klljP2ocSeT1m08wcEw==
X-Gm-Message-State: AOJu0Yy2J0TgeNtg92I0QHeHANUJUH4xSvhISgh25AwBbjo2Q9ycXCDk
	wol2jqp2r822rnRAuvbf892IUlmKvkyWNWHUFngIcRTJx2+3ABszBKzuvHk3E99xZgza2juPHFS
	cwm6vC7voLImPwYxgKYPqBy98Gtqq0OAE
X-Google-Smtp-Source: AGHT+IFvcic6S2LwPsHZ0M70buDjM+b3il1n0lZmyWamo1M+rZew+BtovoQ4Dff102hw6aWSQLe/23ie33DSGj0BRoE=
X-Received: by 2002:a05:600c:354f:b0:426:67fa:f7 with SMTP id
 5b1f17b1804b1-429d62bf53bmr4694455e9.9.1723492114811; Mon, 12 Aug 2024
 12:48:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812072803.78139fba@canb.auug.org.au>
In-Reply-To: <20240812072803.78139fba@canb.auug.org.au>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 12 Aug 2024 12:48:23 -0700
Message-ID: <CAADnVQLyvv_pYwYbufmxHAxLXa1xVO1khqzX34B5iJi1_91epw@mail.gmail.com>
Subject: Re: linux-next: duplicate patch in the bpf-next tree
To: Stephen Rothwell <sfr@canb.auug.org.au>, Masami Hiramatsu <mhiramat@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Networking <netdev@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 11, 2024 at 2:28=E2=80=AFPM Stephen Rothwell <sfr@canb.auug.org=
.au> wrote:
>
> Hi all,
>
> The following commit is also in Linus Torvalds' tree as a different commi=
t
> (but the same patch):
>
>   1cbe8143fd2f ("bpf: kprobe: Remove unused declaring of bpf_kprobe_overr=
ide")
>
> This is commit
>
>   0e8b53979ac8 ("bpf: kprobe: remove unused declaring of bpf_kprobe_overr=
ide")
>
> in Linus' tree.

Masami,

What happened here?

Looks like the discussion was suggesting for Menglong to
send v2, which he did and the patch was clearly targeting bpf-next tree:
[PATCH bpf-next] bpf: kprobe:

Why did you silently apply it ?
No one knew that.
Menglong sent v2 and it was applied to bpf-next :(

