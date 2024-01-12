Return-Path: <bpf+bounces-19410-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A668182BA89
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 06:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CB5C1F25950
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 05:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B995B5B6;
	Fri, 12 Jan 2024 04:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B1UYWJoR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B266510783
	for <bpf@vger.kernel.org>; Fri, 12 Jan 2024 04:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3368abe1093so4650772f8f.2
        for <bpf@vger.kernel.org>; Thu, 11 Jan 2024 20:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705035591; x=1705640391; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FOOUx4Ss7vDbZlo1jZ4GPwu60gD4kb4g1E5l5jRdNoE=;
        b=B1UYWJoRXAgXtZP0G7Jh12ffZ30LX79V4C+TlPcesFGudwgXaBD3CoFUEapMfZUu4g
         13D4eDMNkbqFKr2KgFaaFUNNcoIKRwetED/7xJwRj/fRRk3fggyk3UeYKvcBuZsgV3O+
         S4096/LwW5+lx1GGPXy2qeecJr5Rg5FeoA0KdNznAUNt1D2JH4kjkp48/wi3YmEO2Xc/
         78Bk0lZQTCYHOgxof51ewuP0iudNnszB8HzG4wJHSPFfp9MwQWpOBe+ZhmjMCO3Ad5Bz
         F9pC4fykK+qMRmRKI47Z24vFokff8Kw0d4jTFln/ywo/0Kj5zttue+3fDicB39orLjU6
         dnFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705035591; x=1705640391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FOOUx4Ss7vDbZlo1jZ4GPwu60gD4kb4g1E5l5jRdNoE=;
        b=a+TCWKPHKhciNdCGTOihcHAt+OFCmKLAanqJc8I6/qIQh0w5tyT1Rs904wg02IkOFQ
         tVNN0qtFgA5vbDIDeyNEwnqAug8CMQblIgChehJglfvH/kkFr4zByEiH/kx8TzIAN6E7
         SsxlaBV3lhcbmb8HgI5cXPtVDvL2zA93IcHpFFosrUqJ0InQMxaP5MVsWP4ZhnyfAV1T
         FNhRhtJK21ViRKxAiO8vRNrdjvh6RpFD+q388Pr2lw/+oqQPDKgKczZd/O8SfYcO/ZEv
         zwJ3qi2Mwr1qT2CWibATl+CmKVzC1hDaVKbJVa5v8IVLtHd2jZ3VD7LKQ4JG29od0NxO
         pHXw==
X-Gm-Message-State: AOJu0YyXrjRAff8vHMEblg4KlVTe7u3AFgEQFEFqi2lZKY8x4wvFQNoW
	bmlvKkN3gKycqpwG4ruqzz5nfWkwNv8Bg4cu1Jk=
X-Google-Smtp-Source: AGHT+IGQRN0LfQ2tH14pVJOJICr/LuD6rk8qmx04O6vTKf+wGEMeeTqxrbmPj3CKtrEJvBPo0Z520bHU00WfVHNCTa8=
X-Received: by 2002:adf:f889:0:b0:337:39c7:2a3 with SMTP id
 u9-20020adff889000000b0033739c702a3mr351053wrp.129.1705035590667; Thu, 11 Jan
 2024 20:59:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240112041649.2891872-1-yonghong.song@linux.dev>
In-Reply-To: <20240112041649.2891872-1-yonghong.song@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 11 Jan 2024 20:59:39 -0800
Message-ID: <CAADnVQLH66gFbyqekSEbpzc+CRYkbMxcCAtBvMcCJo+8tfauqg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Fix a 'unused function' compilation error
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 8:17=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
> Building the kernel with latest llvm18, I hit the following error:
>
>  /home/yhs/work/bpf-next/kernel/bpf/verifier.c:4383:13: error: unused fun=
ction '__is_scalar_unbounded' [-Werror,-Wunused-function]
>   4383 | static bool __is_scalar_unbounded(struct bpf_reg_state *reg)
>        |             ^~~~~~~~~~~~~~~~~~~~~
>  1 error generated.
>
> Patches [1] and [2] are in the same patch set. Patch [1] removed
> the usage of __is_scalar_unbounded(), and patch [2] re-introduced
> the usage of the function. Currently patch [1] is merged into
> bpf-next while patch [2] does not, hence the above compilation
> error is triggered.
>
> To fix the compilation failure, let us temporarily make
> __is_scalar_unbounded() not accessible through macro '#if 0'.
> It can be re-introduced later when [2] is ready to merge.
>
>   [1] https://lore.kernel.org/bpf/20240108205209.838365-11-maxtram95@gmai=
l.com/
>   [2] https://lore.kernel.org/bpf/20240108205209.838365-15-maxtram95@gmai=
l.com/

Ouch. Sorry. This interaction between patches was unexpected.
Instead of this particular if 0 patch, is there a way to amend pushed
patches to avoid this issue?

