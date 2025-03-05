Return-Path: <bpf+bounces-53379-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D98A506CE
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 18:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC13D3A633A
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 17:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61748250BFB;
	Wed,  5 Mar 2025 17:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M3y39j1K"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB021946C7
	for <bpf@vger.kernel.org>; Wed,  5 Mar 2025 17:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741197030; cv=none; b=O1OPZrwXFUMIZmtJlyH9x2A1dVnGl1Fy6QNYbNd/pkDR05sjDQbQlT7TrFGFBqtbobwL5uNvT/M19MNBoQQZKfYSZ4736FvusJyd1+KpTzr7pb1M1jFkikgqO60TSfV0ecY0Jznu1jMB0bjTJ9O4HfVPQdNFerwwUyvtXh+IFUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741197030; c=relaxed/simple;
	bh=wNsPDBiwlBT1VFa7KonhouT7ZMhtXdlxyjkPz0UWd4Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ruVCcvWJJo7xSN60Ti7ilV0Fg1nSx0c+38FnVnbidQdMpM1tfLuC94dyaavdSK3BEpTS469IxxUZWV3g6YXcMJ1E4UIykDnjWPz7xeREvwqAYupjBLDL99XqHSTSB67NYHpqeHxILgMsd7uWrteIJ6Tr4p2ZoGTFaEXJJy9gEiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M3y39j1K; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-390e88caa4dso3618482f8f.1
        for <bpf@vger.kernel.org>; Wed, 05 Mar 2025 09:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741197027; x=1741801827; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uJZNjqx8UzQVaqIkOfHbwCvh5Ldz+sHmJlXKnkDPEcM=;
        b=M3y39j1KkSryOqwBn2G1zxOE39S5a+gSY/nijv05a3KVKFawQfrRJmgzoIZrLM3pSL
         tswHLFisaJm5yp1bJQm1OL7bZWKZJkwVTHsN8mVJYSc322Kuohr6SfP8zFKL+TSxyRo3
         JZp4OeerSmkw7T4ImgaLH+NLJbvq8urUxbQgIIcQ7k0Zew3KJTHasZuKE67sbjIKftfZ
         hD0Sab1hQUq2IJsdAUKK1z6Cmbb+HGZEJ6G/3++JB5xSB4Jf1sL9QppeH9/5hCkkPrY4
         5vtZqN7/+9bCgEOKsjTIyQONNLbX/Acgox6xBTfnzE8HbDFfEsoYm5ivfGS7k/r7+YXK
         Vang==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741197027; x=1741801827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uJZNjqx8UzQVaqIkOfHbwCvh5Ldz+sHmJlXKnkDPEcM=;
        b=AHamUeBs9smjO8E4C2iaJMvGNvRVVcQA5aoEtINqQLTBAJoDSjokU0mjW9TposuMH2
         d06b+XnNgvJlBlo3SRAdO48RO5tuAk8N2GXlRW2uS0w++mqIdiKftmgOXqBYPcc9Icy6
         j/cnU+niMHftGKQI0mQTB6Z9ADaufpE7ERipdmeIWberWL5qOQYGTxKOds4k+xsue4wB
         9YuiQPLGBa4JTl7TUPeuTHQu9ZBsoSlR7745wJnwea4KFSk/hKlmPvPgVmEuR3kCTGWU
         oL2DsRbkIMfQgpurEAZefeQLBZDaeHl/6U4Aq0IFoEyqMLhIEGqXFnrHqo/Vgrl6GT4l
         ASnQ==
X-Gm-Message-State: AOJu0YzgdDclEgQ076l0QKvncArDuKO9yWE/eFOEuf2FGwa7C+RNGHq2
	TFCzvcUwc/A0fJrf5tzOO2iL16KFj7RRurLrTMGf2pZyXgQjnMLR00j3HfkUYiCGQnk43NQwZ/e
	MrGzh1X6yPBvWNm5UvACidMdKMnk=
X-Gm-Gg: ASbGncsRjQTlu1EI3IA+y62KmAR30C3WVSO0fPfDLeH1kLGWU0gCI5Uetruliy1gI6Y
	nL49ArPWKdQbY3D/Wq+4fF6i/OtVwpOX4MLoAZ5L7TlTJOd9tvz8jZQxZvioaxH8e6Dl6m1r7pU
	mc5anamUSa9dehVvY2I0feJH/9wFl1yYvbIQ83dP83dA==
X-Google-Smtp-Source: AGHT+IGQv4RZAuv2/9l8Rn0sgTmSmwJcOP5nJClypjF2HaCuXbcfrD9TSYy3Rpjx/YXBN6yfHOiUl/8bw3P9xcA8SkE=
X-Received: by 2002:a05:6000:23c4:b0:390:fe13:e0bb with SMTP id
 ffacd0b85a97d-3911f7c6292mr2427404f8f.51.1741197027230; Wed, 05 Mar 2025
 09:50:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250305161327.203396-1-emil@etsalapatis.com> <20250305161327.203396-2-emil@etsalapatis.com>
In-Reply-To: <20250305161327.203396-2-emil@etsalapatis.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 5 Mar 2025 09:50:16 -0800
X-Gm-Features: AQ5f1JpYmvnL4TQk4yQksiA-PfDPwjWmOkQ1gWx1YNN-ZK1Btp-28R7RRhJKypo
Message-ID: <CAADnVQ+M2KoAvbkWpxfxcbbEEUqkyMAcC0YOYEQ2gMfrwa869Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] bpf: add kfunc for populating cpumask bits
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Tejun Heo <tj@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Hou Tao <houtao@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 5, 2025 at 8:13=E2=80=AFAM Emil Tsalapatis <emil@etsalapatis.co=
m> wrote:
>
> Add a helper kfunc that sets the bitmap of a bpf_cpumask from BPF memory.
>
> Signed-off-by: Emil Tsalapatis (Meta) <emil@etsalapatis.com>
> ---
>  kernel/bpf/cpumask.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> diff --git a/kernel/bpf/cpumask.c b/kernel/bpf/cpumask.c
> index cfa1c18e3a48..2a0770544fc3 100644
> --- a/kernel/bpf/cpumask.c
> +++ b/kernel/bpf/cpumask.c
> @@ -420,6 +420,33 @@ __bpf_kfunc u32 bpf_cpumask_weight(const struct cpum=
ask *cpumask)
>         return cpumask_weight(cpumask);
>  }
>
> +/**
> + * bpf_cpumask_fill() - Populate the CPU mask from the contents of
> + * a BPF memory region.
> + *
> + * @cpumask: The cpumask being populated.
> + * @src: The BPF memory holding the bit pattern.
> + * @src__sz: Length of the BPF memory region in bytes.
> + *
> + */

Since you're adding kdoc, make it complete.
Otherwise there is a warn during the build:

> kernel/bpf/cpumask.c:433: warning: No description found for return value =
of 'bpf_cpumask_fill'

and while at it, could you fix it for other kfuncs?

kernel/bpf/cpumask.c:50: warning: No description found for return
value of 'bpf_cpumask_create'
kernel/bpf/cpumask.c:76: warning: No description found for return
value of 'bpf_cpumask_acquire'

Thanks!

