Return-Path: <bpf+bounces-28958-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 748E88BEEB7
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 23:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AEC228416E
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 21:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F45154434;
	Tue,  7 May 2024 21:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="An1Ga/9q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859B073194;
	Tue,  7 May 2024 21:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715116284; cv=none; b=nmZvm0nbebkgLc33I8q9IkjCrtyTFsKr2etcN1+zQcSfdTE9TyUY0CERb88Runn51Ra+Z6b8GZ4zUvuAn7DEp7pSnVjK+8MNsPWBZX0QoQRcDOsv1Gf8BgYyPyTcBlUcvWiaAzhZfK1BPBX2IRNkDuadXMG9EMgBSMbGvSM4NmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715116284; c=relaxed/simple;
	bh=hUnhz1NVyy7PtRXPsnKo9H2h0HnWJcS3PSKYXjur+4k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TmAPL8PSbfMrcxz1TgBiwFgK7MAXaA0GMZ4pPIh/IxXMQ/GlqlxmMnkWue1E6zb4Q8EOtz7J3Lv7mrZ9MKa320GuXhTPIEzkCvL24cBlTW7o1jG5kRntYU4ez+LLRa5mbX6Jdjc9SulrNqM2h9P3ZHTIZnIFFjGHlSeyaqqsUOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=An1Ga/9q; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a59ce1e8609so31547566b.0;
        Tue, 07 May 2024 14:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715116281; x=1715721081; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i6vkfrYxkTWMLC3pWIYCfpNHSZEGxvaA/kewDPj/b+g=;
        b=An1Ga/9qNOLdJoz4is1T2kOZjVe4ZFHarDwqItP4FoseeVYB3i2K8S0laErAuVfRca
         dq2VqFbURRB1cF3LGIMl3PRWTIUtEyp7DehNAYLEMZdGnkZWHUMzBdVG2/F6TqMIss/M
         bcV5u8KAEOG7kPzQxfmklsA6RGCBIVY6Nkzu1WT0QU54fkeXLRVoSUP+xObol7tdZ0MA
         HuU5vaJ3ox3zyc1debR7KO28kJr34Sv1Wpo0n3c5zDwe4omrJy0lCo6cb8Ml4XxhUbPC
         IUAR4oYeX5wa4JKVLzeK4uwiNCRCFrEJ6LxkXMzdQR5yIIAtlOv7RkcHCpPaXqmXx6iQ
         QYuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715116281; x=1715721081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i6vkfrYxkTWMLC3pWIYCfpNHSZEGxvaA/kewDPj/b+g=;
        b=W8dv4ia4QTCrWRfW22Mdn8jYospdMfpZC2tdH7Mrrh5aRgfiTo6NCP6+qjqrzEbcRK
         phyvckvAf8+R6wzNaHQIrnOL362njGzPwZYO9uzoVG5vJjajo/rAMZYt1+OtiO0ilUX/
         JC/ZfW39ELAtT8S7fuNpHNfkUaEU3c/xq0YMCMUJE17a9V/lgYp/NEdOaQwPVKPQz2oS
         A0fL5UeY647iOSMJugWPd1PJZXLZME0qlxH6tHhgIVWFCDMpgx5xZEp+NrzQ0MstuL3T
         NBG5rqRdxdO/fDj95BekYo0wfXyInwe36Qz6o7s2+RwsLK/c2sv2qGZr2ky9FaXYT84r
         CZgA==
X-Forwarded-Encrypted: i=1; AJvYcCXYo5y8up7s5rRQOBLjjciLHezwcGNyWILhN1jklP2y5qh0sAy090ciGXRS78+CoDvLI31nFfxnTPCyQbARvZnGQcoYPzU16ccALZDBfWDzp4d5jfB3WzKCJfMATE/qa4Vm
X-Gm-Message-State: AOJu0YyTczDipq16VFMUf/zxrcwv3zp+SazU9dXwzqDluJH6qJ0UAgCM
	X+uxx4dYcKo++Om1UumO5w1iqku0VNNLMo3n0HcIG8zNSFZrq6QfV5mOYWgcTU+hx1kmF/TiDe0
	SQlRFtNMttMn5HjuqROTi2u0V01E=
X-Google-Smtp-Source: AGHT+IGg3LPBz/H7y9XDsPWkWB46sk9/NabvXyMn4SHr+Vq7+VTJU+2HWX90IfMsTaWF6XcajPHOa9xwR1WC4DEgbUI=
X-Received: by 2002:a17:907:7651:b0:a59:bbea:14e8 with SMTP id
 a640c23a62f3a-a59e4cf8697mr306595366b.17.1715116280626; Tue, 07 May 2024
 14:11:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240502151854.9810-1-puranjay@kernel.org> <20240502151854.9810-3-puranjay@kernel.org>
In-Reply-To: <20240502151854.9810-3-puranjay@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 7 May 2024 14:11:06 -0700
Message-ID: <CAEf4Bzb27L-UKMmqDZF5V90FeN6z4wKNfeJK2JNv9sG5VMLR=A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 2/4] riscv, bpf: inline bpf_get_smp_processor_id()
To: Puranjay Mohan <puranjay@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Zi Shen Lim <zlim.lnx@gmail.com>, Xu Kuohai <xukuohai@huawei.com>, 
	Florent Revest <revest@chromium.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	puranjay12@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 2, 2024 at 8:19=E2=80=AFAM Puranjay Mohan <puranjay@kernel.org>=
 wrote:
>
> Inline the calls to bpf_get_smp_processor_id() in the riscv bpf jit.
>
> RISCV saves the pointer to the CPU's task_struct in the TP (thread
> pointer) register. This makes it trivial to get the CPU's processor id.
> As thread_info is the first member of task_struct, we can read the
> processor id from TP + offsetof(struct thread_info, cpu).
>
>           RISCV64 JIT output for `call bpf_get_smp_processor_id`
>           =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>
>                 Before                           After
>                --------                         -------
>
>          auipc   t1,0x848c                  ld    a5,32(tp)
>          jalr    604(t1)
>          mv      a5,a0
>
> Benchmark using [1] on Qemu.
>
> ./benchs/run_bench_trigger.sh glob-arr-inc arr-inc hash-inc
>
> +---------------+------------------+------------------+--------------+
> |      Name     |     Before       |       After      |   % change   |
> |---------------+------------------+------------------+--------------|
> | glob-arr-inc  | 1.077 =C2=B1 0.006M/s | 1.336 =C2=B1 0.010M/s |   + 24.=
04%   |
> | arr-inc       | 1.078 =C2=B1 0.002M/s | 1.332 =C2=B1 0.015M/s |   + 23.=
56%   |
> | hash-inc      | 0.494 =C2=B1 0.004M/s | 0.653 =C2=B1 0.001M/s |   + 32.=
18%   |
> +---------------+------------------+------------------+--------------+
>
> NOTE: This benchmark includes changes from this patch and the previous
>       patch that implemented the per-cpu insn.
>
> [1] https://github.com/anakryiko/linux/commit/8dec900975ef
>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> ---

same about carrying over acks:

Acked-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>

>  arch/riscv/net/bpf_jit_comp64.c | 26 ++++++++++++++++++++++++++
>  include/linux/filter.h          |  1 +
>  kernel/bpf/core.c               | 11 +++++++++++
>  kernel/bpf/verifier.c           |  4 ++++
>  4 files changed, 42 insertions(+)
>

[...]

