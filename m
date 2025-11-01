Return-Path: <bpf+bounces-73218-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA53C27433
	for <lists+bpf@lfdr.de>; Sat, 01 Nov 2025 01:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5524F1A27603
	for <lists+bpf@lfdr.de>; Sat,  1 Nov 2025 00:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C851C84A6;
	Sat,  1 Nov 2025 00:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cEVxPZQy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B91634EC
	for <bpf@vger.kernel.org>; Sat,  1 Nov 2025 00:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761956410; cv=none; b=fKPef7A+gootHOtySCcbYQvWIwG74/F5gWA7FSFPRmrU/mNfamvi2XRnY0OObZl/3LRmkXuGjODDQPWCLU9UGyndwPhEsSw/ok65kIPJJ5KkL0YHpkiTXU6Dfj9DQhztl+17m+9TFaB6tBt3SBF8222BXooE2qB9uiKS6Ob18ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761956410; c=relaxed/simple;
	bh=+CLbNx0+SCLkDIniWRg4lwdqf5by9vfde27UuYHGViU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iedc/CvpHDir8mcaWhxzXKIdNI7OENvlfqkTIQf3anNWyrSJ+F/7P2XEtLj15qJE45cgontIkQuBkvAoHxkMZ1uBNrrGlS09QFCyoF0YTIRjdiYNbXgvdckfHkqCSy0u4uvd/hYvC6MyCmTMS8c4bjBIBzrmg7RJeQD9fauZeB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cEVxPZQy; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-426f1574a14so1802837f8f.3
        for <bpf@vger.kernel.org>; Fri, 31 Oct 2025 17:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761956407; x=1762561207; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+CLbNx0+SCLkDIniWRg4lwdqf5by9vfde27UuYHGViU=;
        b=cEVxPZQynHD6EVYmi8B7DVKrmIX+D86kI5J1eyjbpM+4S5aqXmGZUHIeZi9HURHdSg
         NFbmizHnaM6aHfgpJ0nIAp205iBzeltylEEal3kF3wqgnAIlD6PALzd1W+DxvYZCBulb
         oWTvxbRXUn5VeL+iW6WuD8HfAZHeTR0Fcs0TH7hpA30cv4HBFAIFQte2Z+MnISfhpsvF
         q9AVlnzRKeFZLa7YtxXezTRCCryEnb5rvjCrwk0b00eWOvIN1nR2UM7QKVBpglByX+m/
         pNqa2Zx3kVFOBftlpMi+IfIrs73JB2O96RY5iYv93inZ21emikzS7Xxn6VZrc06A/3Ys
         tE/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761956407; x=1762561207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+CLbNx0+SCLkDIniWRg4lwdqf5by9vfde27UuYHGViU=;
        b=hy77Gi0QQsXWqlWMODy8mAzuxi+VMRvEE9L2atpvIPzMvJ0UMeWBrgGgUl6zTJhXZK
         RiKa2pzwgHFreN5VtR4kuXn0WA7fmQ2q7ClgQcMfVfqrUFb/gryEygbc5L4Lojc1+MaQ
         lEnuhBU91zhBgb16lW6mROHfUBv9mh/6TSi6ChuQwA1Oxzh5ZqKDxNNnVYS8hXOnq34p
         Qj43moiNFW7XQXwW9anNYeQzXYSnmIRTEYIeoILyAyxhb2FOI1+4eFex3C6034AGXMWQ
         CYzAkvbKg7JxmTxutwH2nemo6FN8ZBBq999NDFvjCeBMhKYr0pF0z7wDJnxQXeygFmDs
         dKZQ==
X-Gm-Message-State: AOJu0YxCBqIPs16fa5YChorOeo0yZFQOHN9ylIu3pQbGcrAuwTCU4ElU
	PwJU/F6ZKB89/+pdb3/EoiRwma2akl0LHs8lcNHznlsbiP3PhOD5RoUrnI29HiKeP9myVgsTwfB
	J/Flq/WT4MV7bFjZV0m9HE1YJOjGbPqc=
X-Gm-Gg: ASbGncsHQgqn5/FgZRHisATRO5dDQN2Wz/TAmgnjVqtrDCU+7/0oKG7Ia3ReoqP7ibg
	fEbq8aqU8B/Khcdyq67PbRBnBX3YzHrWV9DFA2b5GMEaH+EXzOSXfRZ//7bV0wxrXscRlA/fFaG
	6LNh5gBaJ9ZoOG/3AVSgIHnf5lqnsywnmtG4/G2OZ4j2YOA1s/5P0AN1gNOCQE7dmxuiwNnxpCn
	5SSemjmvmJ2N0PYPOSyRNqQV3OitPJVqjTJi0VhFpQRsPFueeHrGTzs2d1uRVfEoql+/3SswLxM
	8pHrw/JH+PfX8ywED/RwWOP1UX3iszrnN6e1STw=
X-Google-Smtp-Source: AGHT+IHNYlEWOUMUtDvrTK4geQQrmMKnQJBQrV6hcEirA2F2JhOkgWTEMrJG0KJ/zrGB83nhreewf0v0Vbb+Cn07cBE=
X-Received: by 2002:a05:6000:4283:b0:427:8e5:39df with SMTP id
 ffacd0b85a97d-429bd67bd2dmr4146048f8f.21.1761956407306; Fri, 31 Oct 2025
 17:20:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027175023.1521602-1-song@kernel.org>
In-Reply-To: <20251027175023.1521602-1-song@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 31 Oct 2025 17:19:54 -0700
X-Gm-Features: AWmQ_blwHGysxMuw7rx01dYjPj9zdTLkr7fwqsaiFUdesnwh3GVJuzrF-PEto30
Message-ID: <CAADnVQ+azh4iUmq4_RHYatphAaZUGsW0Zo8=vGOT1_fv-UYOaA@mail.gmail.com>
Subject: Re: [PATCH v4 bpf 0/3] Fix ftrace for livepatch + BPF fexit programs
To: Song Liu <song@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, live-patching@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Kernel Team <kernel-team@meta.com>, Jiri Olsa <olsajiri@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 10:50=E2=80=AFAM Song Liu <song@kernel.org> wrote:
>
> livepatch and BPF trampoline are two special users of ftrace. livepatch
> uses ftrace with IPMODIFY flag and BPF trampoline uses ftrace direct
> functions. When livepatch and BPF trampoline with fexit programs attach t=
o
> the same kernel function, BPF trampoline needs to call into the patched
> version of the kernel function.
>
> 1/3 and 2/3 of this patchset fix two issues with livepatch + fexit cases,
> one in the register_ftrace_direct path, the other in the
> modify_ftrace_direct path.
>
> 3/3 adds selftests for both cases.
>
> ---
>
> Changes v3 =3D> v4:
> 1. Add helper reset_direct. (Steven)
> 2. Add Reviewed-by from Jiri.
> 3. Fix minor typo in comments.

Steven,

can you apply the fixes or should I take them ?
If so, pls ack.

