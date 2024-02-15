Return-Path: <bpf+bounces-22112-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F1B857064
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 23:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CC23285D2E
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 22:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66791468FF;
	Thu, 15 Feb 2024 22:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kOWx0cCR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BBF13DB92
	for <bpf@vger.kernel.org>; Thu, 15 Feb 2024 22:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708035149; cv=none; b=cr6obWnkZZUN21ZMSKYC25u1fkKolegTvosOUlVcw2GKEPtoj7/7Kn+GuZC0JEO9aqixutyfBR/+rg+c4tyj5dno+fQRXY0/HVwJITDl9k4Lq1A6zK2NHKonDf8owqLe3SLiN5Wy0e8GhjlCwVxLF0LYMKgNCZYkauDY6Gl4EHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708035149; c=relaxed/simple;
	bh=CIOXpEDxLl9UG2fHTC1MZ47Oj0rGCygpgOGod1e/rrI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NvCHUxGohRM/u0r/+TYdskqKfW76zL6WR+IsMSWP74+BJkIuIr77C9/Mh7LjR8CQOFLtjRjUT72gKmYSXM4/ML5rlReN+cs1kX0QztoKmsIKvNQM9rOOSJZ4XD+BDMBOaetgBiuDvT8TqSOZ2pqTDtNs9Hbn7kRcIIPzThmanzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kOWx0cCR; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a3cfacf0eadso157342866b.2
        for <bpf@vger.kernel.org>; Thu, 15 Feb 2024 14:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708035146; x=1708639946; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CIOXpEDxLl9UG2fHTC1MZ47Oj0rGCygpgOGod1e/rrI=;
        b=kOWx0cCRICyoUpu7ANc/P5s1okbY+BmRl7vL0S+Ir20DKux6e6M7JWNqelxrluVpc5
         VfmFRpmMLov0j8ifPwELvrRsvhTr5qI5BOoSxBqBUQjQs2Cd8SNGFhSaA65yMmKQ3TXg
         gKuDylv9EhN/cqhthn9ZH1fWj3vxOZnTDp+bAbUxyiBp4SWvIZ8Lua4sLWD+Eo3RtDQ1
         tTPpRd5yIDd3+0jcxo5hM8pg9K0Tl8ry7VEWwdwiBZFesdRmBh8wVtMaX1Y77Bhc85Pa
         wxKrFGel5/ZnOrJsdC1zrP6WERShxW2XvzEVbJ+rxIdFtD8nJSkxKbU/7QSX8FxNTRdE
         bqMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708035146; x=1708639946;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CIOXpEDxLl9UG2fHTC1MZ47Oj0rGCygpgOGod1e/rrI=;
        b=Di4fsVRuEH2W8u9x3BhJZAZZZLvPUrWnSKAdlaNhNlghd6GRRrY9t+u0zHVeftf1Ml
         MCDTWp8Q48MCfTUsZ7a/ovn6XPdS00P4O0RwkwTQxrj8T3yTmDpScRJiSt1Q8JA28DjN
         ONChhb/H7ybqRewCCb3QAHhWzLJYy417wHFiWmHXxk3qr8idrwRZRWXEKAjRwE6C9TmE
         dMWnGTVprkVeTK/ZrgT/63j7dGMTaIMNY8OUvJMANjHyqazh9adhwZ0Vp2ZnlU0rlpOL
         vev/rzSaJAdxZjNBieq8Dgf46QWl9He7y2KkUZwTESSbEAts3CNc6kZ9QZzzUYzCjgFt
         7qbA==
X-Forwarded-Encrypted: i=1; AJvYcCXng8jESdiv+wN6uUZwrMj9j67WMYf9UEG9sEhoCC0rSWhPyyZ5qgD1Y2eRlifmxrg0kuQ6PC8gdEWa9vg1MIS8Iqhs
X-Gm-Message-State: AOJu0Yzm5dOTHB9EvTDcQqbHSt37Ms6vcZdY5IvqO1SX8zuRNEfXdoIg
	PcTlpVyz4Oc/yoXaSK42WO/VrdZmTVLVe4WoS5AmPc4i6jT73ElU
X-Google-Smtp-Source: AGHT+IE2EL6nBXLnN5r2v4tVEk0SJD/0/UZKhZV6sa3kE3WtHQsmkxAawAdioGSg//gdBIwTQ5d89w==
X-Received: by 2002:a17:906:3b99:b0:a3d:8f1a:8af3 with SMTP id u25-20020a1709063b9900b00a3d8f1a8af3mr2207076ejf.14.1708035145760;
        Thu, 15 Feb 2024 14:12:25 -0800 (PST)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id ga30-20020a1709070c1e00b00a3d4c1d86fesm956201ejc.34.2024.02.15.14.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 14:12:25 -0800 (PST)
Message-ID: <440fcc2619dee3bba5762312ddc83f7af3963641.camel@gmail.com>
Subject: Re: [RFC PATCH v1 09/14] bpf, x86: Fix up pc offsets for frame
 descriptor entries
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai
 Lau <martin.lau@kernel.org>, David Vernet <void@manifault.com>,  Tejun Heo
 <tj@kernel.org>, Raj Sahu <rjsu26@vt.edu>, Dan Williams <djwillia@vt.edu>,
 Rishabh Iyer <rishabh.iyer@epfl.ch>, Sanidhya Kashyap
 <sanidhya.kashyap@epfl.ch>
Date: Fri, 16 Feb 2024 00:12:24 +0200
In-Reply-To: <20240201042109.1150490-10-memxor@gmail.com>
References: <20240201042109.1150490-1-memxor@gmail.com>
	 <20240201042109.1150490-10-memxor@gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-02-01 at 04:21 +0000, Kumar Kartikeya Dwivedi wrote:
> Until now, the program counter value stored in frame descriptor entries
> was the instruction index of the BPF program's insn and callsites when
> going down the frames in a call chain. However, at runtime, the program
> counter will be the pointer to the next instruction, and thus needs to
> be computed in a position independent way to tally it at runtime to find
> the frame descriptor when unwinding.
>=20
> To do this, we first convert the global instruction index into an
> instruction index relative to the start of a subprog, and add 1 to it
> (to reflect that at runtime, the program counter points to the next
> instruction). Then, we modify the JIT (for now, x86) to convert them
> to instruction offsets relative to the start of the JIT image, which is
> the prog->bpf_func of the subprog in question at runtime.
>=20
> Later, subtracting the prog->bpf_func pointer from runtime program
> counter will yield the same offset, and allow us to figure out the
> corresponding frame descriptor entry.

Would it be possible to instead embed an address (or index)
of the corresponding frame descriptor in instruction stream itself?
E.g. do LD_imm64 and pass it as a first parameter for bpf_throw()?
Thus avoiding the necessity to track ip changes.

[...]



