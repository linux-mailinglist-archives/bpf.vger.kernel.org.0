Return-Path: <bpf+bounces-38337-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8CC9637F0
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 03:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68A592850FD
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 01:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C415B1C6A1;
	Thu, 29 Aug 2024 01:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JrKC8wKc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8578814
	for <bpf@vger.kernel.org>; Thu, 29 Aug 2024 01:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724895976; cv=none; b=kkzjpXMqSGfowjmQIXA8B5Mi9u8lIVusqEXbtQW8GMOerNqY15zC9dyDyh0JsmaxuOat0MK5HgbwMucA7beC3NUqLw7bXDy77ASvJ7YQDssGcyFjU+/1aW/l/S0T1bHbRdWMx6TIG+YHtawqIJiks2aLT+5JLDkE850O94Smkrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724895976; c=relaxed/simple;
	bh=E1f6Vzt+AYOhHsqvgQVqRKkfhnqh86zmCGFv9EbTHZk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jy931GqTPbbVdwlT75HqtDQqohEbCEZ69poTQMXizQ8gQYfroRksQksN8Ao2PM94DuxxnruMT55Hsb4OT5WTxygRjmLNlELryCoRPPS8Izckv7l8N0791LagFESA2G1tJ7m2KTBQcQnCMuyg+sj1wMysQ73F4MDmhiT5DjGIFqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JrKC8wKc; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3718c176ed7so71880f8f.2
        for <bpf@vger.kernel.org>; Wed, 28 Aug 2024 18:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724895973; x=1725500773; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E1f6Vzt+AYOhHsqvgQVqRKkfhnqh86zmCGFv9EbTHZk=;
        b=JrKC8wKceNaXBf64PiTB5YzstuZX/BdW7VCX+4gH2WbsuuKePse/qJ3OoHy9nQP22l
         d4dEtPunCR6hYJjsy2VP5YZz3ILH74sdm98RgIQQZI0fO2Y2pH70/7NAuPerUrcxemtq
         IDezhuWLAoUODNbr+BLBi/VgkpxLft1zPTjB6tmpQhmKU0RZDo/XKWd2v/uVB+ZeI0gR
         j5nWmFxpTOKIBnLyXHPv6eJNl9Op8QoORxB9PqjMozGnwixVc6v1/OTBW1XK+flFEEf7
         LE4IW8wIvgh9PH0LtYQXlG0LwFSLy0BhLOzywsfh1qsq96UOvnPHszcSw6vclOK/O+GF
         wgVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724895973; x=1725500773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E1f6Vzt+AYOhHsqvgQVqRKkfhnqh86zmCGFv9EbTHZk=;
        b=j13S1FcRuvqHgW200CEbjpCvUzFo7fKnv5hQIFbSAfXajIeE3G4WW26sqWU1aQ2i3U
         IsOy9s/zBTvJMQMplNy9WxtgfO/YbV8V4yLzy+UoTUXznBxQDz57V7INArG3icLjo2MD
         EKhzbDpZ67KLygoEZYuAandACJaA/bWh5++mt1DQQzy6e2ChXwrfN7zUlnSeBkw9uMOe
         04DMc3UaqHH6jCLjOxHndj3vDBdFz7JauHQ/JKezlU9eYulGTFXiAf/dT0aGYrw4/9e1
         s4tppNBC9HGuY92nOTSHe1NKS2nFOuBLqbGQfyPgc3Mj1wND4nSfEy1xYowaJYzdekhc
         uSIw==
X-Forwarded-Encrypted: i=1; AJvYcCWXBGk1xfG26r5UkfY1Tn+GcchbgTlP+kt6szoLamdTB8K6mIydf0m1BAvuZYEpC8wpIqc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9CN00tUMTLQ97qD6T+IW+MBuQdoxPshMQbU46+jcUOwmxkhPX
	JllbLrjd7eDwdooOVCQ4uNbZy/+qzoHJ5TlalF0HQVUR0G/FVn7QufL5H+8af5AOanmMphhRLMI
	CWkcdv6Ze8RSELOboz+v9CiypIEs=
X-Google-Smtp-Source: AGHT+IENevEE01iykZwl2IDKD/F3Ppf6+qL94djp/zhZ0iphstPbOpsLneZ/sJuvx8LxBCzkiABmKr/lLLq/VkUofRg=
X-Received: by 2002:adf:f008:0:b0:371:93eb:78a4 with SMTP id
 ffacd0b85a97d-3749b52ec3dmr738159f8f.9.1724895972778; Wed, 28 Aug 2024
 18:46:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240827194834.1423815-1-martin.lau@linux.dev>
 <20240827194834.1423815-2-martin.lau@linux.dev> <9bcfc97f011f4b4d5dc312e26074d0c1d744af02.camel@gmail.com>
In-Reply-To: <9bcfc97f011f4b4d5dc312e26074d0c1d744af02.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 28 Aug 2024 18:46:01 -0700
Message-ID: <CAADnVQKfuWjpDxL=0OYMe_u37tTpPgPUW3-5L7X-QVUGh5x1gw@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 1/9] bpf: Move insn_buf[16] to bpf_verifier_env
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Yonghong Song <yonghong.song@linux.dev>, 
	Amery Hung <ameryhung@gmail.com>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 5:41=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Tue, 2024-08-27 at 12:48 -0700, Martin KaFai Lau wrote:
> > From: Martin KaFai Lau <martin.lau@kernel.org>
> >
> > This patch moves the 'struct bpf_insn insn_buf[16]' stack usage
> > to the bpf_verifier_env. A '#define INSN_BUF_SIZE 16' is also added
> > to replace the ARRAY_SIZE(insn_buf) usages.
> >
> > Both convert_ctx_accesses() and do_misc_fixup() are changed
> > to use the env->insn_buf.
> >
> > It is a prep work for adding the epilogue_buf[16] in a later patch.
> >
> > Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
> > ---
>
> Not sure if this refactoring is worth it but code looks correct.
> Note that there is also inline_bpf_loop()
> (it needs a slightly bigger buffer).

Probably worth it in the follow up, since people complain that
this or that function in verifier.c reaches stack size limit
when compiled with sanitizers.
These buffers on stack are the biggest consumers.

