Return-Path: <bpf+bounces-78599-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7A1D14400
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 18:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9DC573128952
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 17:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5579B3793D6;
	Mon, 12 Jan 2026 17:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bV0+ERHk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A144D3793B3
	for <bpf@vger.kernel.org>; Mon, 12 Jan 2026 17:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768237320; cv=none; b=i2PHatoTWzcHUjy02P3rmJEQT92j/hR74MitjUo8CpxTXIpeNUuEiAxhG54q3Ies6GYKHfdM6S2/kTsCtLJJGbB+QiwZNpSQ38Q9KNPmLzW22VLEX9IMwTHz4aa+CHHZ5Vy5JL2aYmDTYOy1chwa/bxep9bjMOMoVXVuiwsgVkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768237320; c=relaxed/simple;
	bh=lukVQ7KDZXgDePhwHjEBoVHZr7RkstS38svXbD+t2r0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XAUhm1eknzjgSDRzlxI58lJs5Mi66iA0fPxuje/l+rY1RGiYFdvWQzPgt+fUCTwU79qg51+3KXDKWGb+vuSJPOjkJlflHE0piokjZwLBlUizsCsOjL1Gb+vdVIeFvHCzT6efTrVcXW/z0ulQaQziZ69WgbLeSMgph3Jtmz+8wmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bV0+ERHk; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47d182a8c6cso39372155e9.1
        for <bpf@vger.kernel.org>; Mon, 12 Jan 2026 09:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768237314; x=1768842114; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lukVQ7KDZXgDePhwHjEBoVHZr7RkstS38svXbD+t2r0=;
        b=bV0+ERHk3i0KzzgXoWIw03UwL/u6RjBy/Lk0flrnAYl2bYvM7b/uC56LLcZ1fWAzhv
         48FjFSLhknK0F29Rc5wqVpJi5+K7yJVE+7aeVb+A+7jsXowkClodTNdFWyujsyl22hhq
         9EpX5pBMXWP+lrAfBx71DVcOW/FDYSotCIzDcWsW0Um27K+HjRjKp2PcmhjXRhiwhu0Y
         dB3w/syjLX1yrsVgO+pNonppsB4XcwpH90f0RIROtZO/Q3N2fT3tAQV/ICjv9mDi7Xvw
         1sXy1eodfywmu6zWbkckog7mFAk6vEHw+gaZMTmxdqSeM3Q6TyrCBcCaEfd2wMucVhX8
         V5og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768237314; x=1768842114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lukVQ7KDZXgDePhwHjEBoVHZr7RkstS38svXbD+t2r0=;
        b=h0ep9mQh1c9OIKQdZUGRKAazidQWFkfDE7Hdje7yplng/2/7YhKjz4Ovl+MmWshtxN
         RSaVOm0T+A+/hzrGHOWV3IXZei86HSBcZs0ppV7CLhbUw2lyC1zSqWshj7fchcUCw8gE
         Xx9t7v795WGRAmVBHxE9Hsqz6u/0SnotbnnTTtvTEjyQMZsMZCJThijYJINPZb/yjDq2
         OygCu/+6m8/klKqj8rbew/P/eOP6TlKMGdOKoSAvGMTkLXXTMjmfCTgIOQLPMUz3b0CW
         Y9yApDAN83sMB7ktMRphbCLfHtvtrdtChZKRL/6FrwJBUq37vtDlw7s/VNdrYNirpV4k
         6Lhg==
X-Forwarded-Encrypted: i=1; AJvYcCU5zLzOFG1tFprDGhN8xrsGwigjlDE0sxCapsnT+UtdaPRwN7geVKu9gfTwO/08N9vMx6g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxHKavkeR1vLikpOdp+62L+Jt/obtRw4rM7iKk5Trq4vPIQ+qS
	Sp2ktlfnqNXIq44UqLXEDJrKMa58D8q3RQHh9koHqHRTNaMwOKZsuggscC3lc8buqVsAUnnC0+w
	64kv0CYVHowRW8CYK9xWIYB4Gi06GmPU=
X-Gm-Gg: AY/fxX4kf/naSvgojbI8oH2WvytPznaGvAzNKdsPNWHPTDujO/M7zEUJ0HZjs7wbsr1
	uLACz9EWDi78iY3FuxV24A9dgF1qwPRtz0/BtuBHHMQexpe9Mfc4n6LMzRWhgGtOoCgiqC6Fl4j
	wAz75+uRwD9KDqiT1ovOpfiOrhKYas1WugSynQHx+aBbd+niS9U3jfThtfI4m3x7CKOAakEeghD
	kaAooESaQdh4xpUaUFL77P9EFPFoI6Wa4rCht3fHF9uGYH7KRSqrgNc0Rj9zirYuXBFbs00ofv5
	fsaOBgEGhaY=
X-Google-Smtp-Source: AGHT+IFvGRZzqyjHWJDJYgNsKv9Tbb8vJ0Z8L/ie3Mosac44Bzb7BJs1Zkq34W2OJET3bLfRZghsAl66EnWrpvcgaQw=
X-Received: by 2002:a05:600c:a04:b0:47d:5dae:73b1 with SMTP id
 5b1f17b1804b1-47d84b3b668mr237910895e9.23.1768237313950; Mon, 12 Jan 2026
 09:01:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251219142948.204312-1-dongml2@chinatelecom.cn> <6964d168.050a0220.57989.2241SMTPIN_ADDED_BROKEN@mx.google.com>
In-Reply-To: <6964d168.050a0220.57989.2241SMTPIN_ADDED_BROKEN@mx.google.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 12 Jan 2026 09:01:42 -0800
X-Gm-Features: AZwV_Qhc3LzN7Q_zg3hJWdrpRhvqt6NT_zOW9RTteSioPtIzHVqMW0n3FVX8wQI
Message-ID: <CAADnVQJwh7Eh=NF3Qj+fiLDXnk5Wn+VpuBDuPsTZjKWCiXPJjQ@mail.gmail.com>
Subject: Re: [PATCH bpf v2] riscv, bpf: fix incorrect usage of BPF_TRAMP_F_ORIG_STACK
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: Menglong Dong <menglong8.dong@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Pu Lehui <pulehui@huawei.com>, Puranjay Mohan <puranjay@kernel.org>, pjw@kernel.org, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alex Ghiti <alex@ghiti.fr>, 
	bpf <bpf@vger.kernel.org>, linux-riscv <linux-riscv@lists.infradead.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2026 at 2:48=E2=80=AFAM Andreas Schwab <schwab@linux-m68k.o=
rg> wrote:
>
> It's rc5 and this is still not merged.

It was merged weeks ago. Sitting in the bpf tree. It will get to Linus
this week.

