Return-Path: <bpf+bounces-66616-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE34B377AD
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 04:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 760012A50CE
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 02:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE12272E4E;
	Wed, 27 Aug 2025 02:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fS+mwt9Q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3866B27707
	for <bpf@vger.kernel.org>; Wed, 27 Aug 2025 02:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756261404; cv=none; b=SlrcdZHiPlpkB6Zw8XDN1wVbbJvwsaI6jVSFt8ors1a8HlEZckJ/dziestO40GFle3962TsyUNvMKHlhgB/c/Rs8PHI72APyVgn1KsjLsNH9rcVGXYCvrMtCL3GQawUhYt78rFujsvs8vuKcNo54puGPJH0eGj8sF9YmcRfGVB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756261404; c=relaxed/simple;
	bh=Oan4Phs7yjycRaPckO1F2kwDFSlozimxAHWvYV7rPXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BMKJqRAHpRNdpWfv2NzU0WlZ8Jbp0Hrn9eY7AfvcmepfzCeusy2Jkh9N2tpi+GyRb5/6OalBznlf5eelIJWlKbpSnn8yQXVKDw/xL3PNk+ZH9CsIJATfXrIcd+VpeHqwj0v1hWtxSTtZlOkbymh8kjH88j1+OJlLyjM9A1oOY4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fS+mwt9Q; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45b5c12dd87so28791405e9.2
        for <bpf@vger.kernel.org>; Tue, 26 Aug 2025 19:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756261400; x=1756866200; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oan4Phs7yjycRaPckO1F2kwDFSlozimxAHWvYV7rPXo=;
        b=fS+mwt9QMRc431pZzhnKwKteUpV2u7how7ssTqN0IEX5rLvb4uEucKvkE2u/GVF4Ie
         tAcPCgC3wvkvju3t3qF2qKEa8USdiS1SAY/0o1bxhnQdX2Q/zX6ZIA8VF3NctZKB4CcH
         26k3zD4mcS7Te9zJ7RmpBqtpBslAcIHn7olPwaImmFj2jmG3nVdgNgD56zw8nOOGMKBh
         a+Uh+LgLPbESmNZKx8D0UwYzquiMR17n7hMTmkZdC8iYgcvLPv3puO2IVTEXZKJCUash
         G0P+1+RkjAZwJcengoXpbaJ7DFMHVqXb5+NMw8i1tVeOMDsFGj6biknMA+nqYupSGwdE
         D7Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756261400; x=1756866200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oan4Phs7yjycRaPckO1F2kwDFSlozimxAHWvYV7rPXo=;
        b=Z5sfkN7nDIR6qtstnrFWKNdsrudMbWWfa5OLTc1DQ9iP2l66YIGkhUFWwvkI+Uz2xW
         8iTOjSDsbiKVcp57SlNbWC5EqOS49DVyI0OyzzwMMkRoZyn2ICkFg0xVSy5vmYwbyfox
         /4KlAZKjEmi2cBZ2uDeCsq/bDkyAA9/ABJ2vaNn9jbduosJCRZExBqJfDtn/pGZxvWcP
         +FUB28v9mXsh115ntak5GQKx8IVFQvEq98hCvhPWMUKiMtr+Gyp7Wlf8fw7A4rANWe2Z
         rx8eKatcLmK25/v79wNL7RPCgI+0HSK6NEdD1gv9A6ydMrmzB4hyyMs1iPCcXTNznu6w
         1tfA==
X-Gm-Message-State: AOJu0Ywo/swbdwLkiHGDYvZc2IV7qhWYeSKdkEHC87UoyP2L/qCssBYn
	NxB7W7PG0VOi+wR7XHKJI8NLToTFhImMuLqxXWjce/Tx7Fu6Yzhul9RB7RBeajgwjpKEJPuf1UN
	sWgkH8FmuVhAA1GJjYfPfW5oCVmrFrFM=
X-Gm-Gg: ASbGncsA7gS6LEqoJfoPnm03r1S/ygh/eW5QTS2CznzN0cC5zKQyaeeiNI26YAnMmAg
	oJ9hc1A9kHDjz6Rd69glJ0khshhymMbBMCitL2tF5TQ9iH+qhcRw/oY+YXFRxiZdUXAuXn+osL3
	0we25gv1LhZqCDE93FziJOB6JqEHyh7S+cNUbFfFXdxNA3Ia/v4RBv3TXZYOKq46kUlfhKdC+tO
	pGKNibgbJKFSeLuMTA58yRDI7ZWtNrKgEOz
X-Google-Smtp-Source: AGHT+IEjxXTGedqFksjhbO9wY9a2XWj7oPRpAOX0oiscCtFTs5xBfXBRoAmDhVY1lQtYBY6qaJKEsWP2n16e6xZz0Ok=
X-Received: by 2002:a05:6000:240e:b0:3c8:89e9:6aa7 with SMTP id
 ffacd0b85a97d-3c889e96e2fmr8979405f8f.2.1756261400250; Tue, 26 Aug 2025
 19:23:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a08c7c19-1831-481f-9160-0583d850347a@linux.dev>
In-Reply-To: <a08c7c19-1831-481f-9160-0583d850347a@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 26 Aug 2025 19:23:08 -0700
X-Gm-Features: Ac12FXyt11HFruYGrnEwQRV6wW3Js4UU4syCVUOGXU9x-lwoxi-BYMX5wxXwcfA
Message-ID: <CAADnVQJz9ekB_LjSjRzJLmM_fvdCbeA+pFY20xviJ-qgwFtXWw@mail.gmail.com>
Subject: Re: [BUG] Deadlock triggered by bpfsnoop funcgraph feature
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 7:13=E2=80=AFPM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> Hi,
>
> I=E2=80=99ve encountered a reproducible deadlock while developing the fun=
cgraph
> feature for bpfsnoop [0].

debug it pls.
Sounds like you're implying that the root cause is in bpf,
but why do you think so?

You're attaching to things that shouldn't be attached to.
Like rcu_lockdep_current_cpu_online()
so effectively you're recursing in that lockdep code.
See big lock there. It will dead lock for sure.

