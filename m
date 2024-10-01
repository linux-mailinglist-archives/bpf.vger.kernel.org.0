Return-Path: <bpf+bounces-40632-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 928EE98B1ED
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 03:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 555CA2811AB
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 01:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D9122094;
	Tue,  1 Oct 2024 01:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kcAe639F"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B2CC8C0
	for <bpf@vger.kernel.org>; Tue,  1 Oct 2024 01:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727747466; cv=none; b=WfafYXblUHo7WjSUi2ZphSg+05Hb2QEncTEAThbEie++oASduTdkPLMKteAjzP7JtcRAeF/aN+Mr65V49Upk7lq2ixoN9wLuqZy4D4OSzBiQAhUcYqdSxjIJul3OCX+aF02ernOspLoqxmPXZ9K5nmcc4O2rvGMANhQgfYF6w7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727747466; c=relaxed/simple;
	bh=7iSatZ+4hUQaJQjbACDNi7CNb0P0WfWMkEmJDHyA2nE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CEb0HDDoQU0T8Oc6Us1ECJBYRMMMLBrVdiCc0/JhOmSShVwDsuufOVCH1TggAOBKrpT49ljG/LO2/6ZE2Bu6dUd5R4mzfzoWYT+VX3bRvJQxeqrPm3IUxw5qFEaYcOyDZgT1K/28RDlMJ33SRNSSnUi/j7qd+vo9QlX7FXPVpIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kcAe639F; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-37cd5016d98so2486889f8f.1
        for <bpf@vger.kernel.org>; Mon, 30 Sep 2024 18:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727747463; x=1728352263; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PxWx/wdYDgk3bq+3VgKSKVH0oBS1zBveroHqSiUTxvk=;
        b=kcAe639FFqHxEfnJT6YtmiRk34UkO6lDCmZIWZuKqwCOo/tYk4MRYHgtafjwMsOvIt
         mJCaDcFoYOxOkMdScET6iLkElUZmX7WgXhdy7YAaxa8EJPUST0t2KJx24dsgpUBWSb6g
         uemeflXsW85NQGNiQnMKRVUSECQPxDfUMC8XJ/XB3396KVtxAiiZUR6cnk3DWg4FPytw
         jzsdQ7p65ilmPmzC7tQ/2uQ+P4w3AFWWBe5oa8miwVruUOkuRt3zQVmgBlciipYdTv5l
         gmr17k0a44AErnAIInO+04IR77fnkuiK1/YLscNOPMoh96SwdHoqLl6XdytIZr2lQaSj
         ndoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727747463; x=1728352263;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PxWx/wdYDgk3bq+3VgKSKVH0oBS1zBveroHqSiUTxvk=;
        b=Q48bo43MraV+E0BWFxN6S9OyAKSQS79hbb1q8FAI43a7f1gnTPMw/58fn8Q/4vySRE
         RxlTQ+RDmLIni1v9sTAFpDTmCrpNoozjWfAOQhEK+rekLnxcdUPpN9gF8WmCm239ZzzT
         nK0sXLCRfZIW+12wr0vOpOPteOrFQCDrPbGIvbdZwg6Y7in0KPe14QjmdLxsjr2svwSp
         XwkC0njsxq08bIXkGeCABGvd8fetuAZKTOEFvpI8hiPiObqVaAeQfRWieZNc+DNnBCbX
         qnf6v7BH7HsrHuqc8gsktu7VBh2CfbF853dk2d6Pvo9Q1NjC8RZ7oI2jwsHTOtsS0Cr5
         3kPw==
X-Gm-Message-State: AOJu0YwfYeg1Y0W1h2gqt9XfqLE6HY0kVwNka/P1PDid5AbWTDU1oLiI
	gkQ2agiJIwYL5HvTOLSEex5yZ/SiJOCvqyH9vq1iwbCqkfsr9DfksJXIpE3qQHSw0iqVw/s+KXl
	GuhUe1aUNQo82UsQ0+6uYHKwZiB/sofek
X-Google-Smtp-Source: AGHT+IEIJFCqRK5fmYoCwrGl+QJ0y1CWAPwdeO4FuIAWLitfXFlm35OyyJsisB3C02Vdd+zs1cnJlCRic1hR8FGlWWw=
X-Received: by 2002:adf:e6c7:0:b0:374:c7a3:3349 with SMTP id
 ffacd0b85a97d-37cd5b292c9mr7791315f8f.51.1727747462640; Mon, 30 Sep 2024
 18:51:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240927033904.2702474-1-yonghong.song@linux.dev>
In-Reply-To: <20240927033904.2702474-1-yonghong.song@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 30 Sep 2024 18:50:51 -0700
Message-ID: <CAADnVQJZLRnT3J31CLB85by=SmC2UY1pmUZX0kkyePtVdTdy9A@mail.gmail.com>
Subject: Re: [PATCH bpf-next] docs/bpf: Document some special sdiv/smod operations
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 8:39=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
> Patch [1] fixed possible kernel crash due to specific sdiv/smod operation=
s
> in bpf program. The following are related operations and the expected res=
ults
> of those operations:
>   - LLONG_MIN/-1 =3D LLONG_MIN
>   - INT_MIN/-1 =3D INT_MIN
>   - LLONG_MIN%-1 =3D 0
>   - INT_MIN%-1 =3D 0
>
> Those operations are replaced with codes which won't cause
> kernel crash. This patch documents what operations may cause exception an=
d
> what replacement operations are.
>
>   [1] https://lore.kernel.org/all/20240913150326.1187788-1-yonghong.song@=
linux.dev/
>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  .../bpf/standardization/instruction-set.rst   | 25 +++++++++++++++----
>  1 file changed, 20 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Docu=
mentation/bpf/standardization/instruction-set.rst
> index ab820d565052..d150c1d7ad3b 100644
> --- a/Documentation/bpf/standardization/instruction-set.rst
> +++ b/Documentation/bpf/standardization/instruction-set.rst
> @@ -347,11 +347,26 @@ register.
>    =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>
>  Underflow and overflow are allowed during arithmetic operations, meaning
> -the 64-bit or 32-bit value will wrap. If BPF program execution would
> -result in division by zero, the destination register is instead set to z=
ero.
> -If execution would result in modulo by zero, for ``ALU64`` the value of
> -the destination register is unchanged whereas for ``ALU`` the upper
> -32 bits of the destination register are zeroed.
> +the 64-bit or 32-bit value will wrap. There are also a few arithmetic op=
erations
> +which may cause exception for certain architectures. Since crashing the =
kernel
> +is not an option, those operations are replaced with alternative operati=
ons.
> +
> +.. table:: Arithmetic operations with possible exceptions
> +
> +  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +  name   class       original                       replacement
> +  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +  DIV    ALU64/ALU   dst /=3D 0                       dst =3D 0
> +  SDIV   ALU64/ALU   dst s/=3D 0                      dst =3D 0
> +  MOD    ALU64       dst %=3D 0                       dst =3D dst (no re=
placement)
> +  MOD    ALU         dst %=3D 0                       dst =3D (u32)dst
> +  SMOD   ALU64       dst s%=3D 0                      dst =3D dst (no re=
placement)
> +  SMOD   ALU         dst s%=3D 0                      dst =3D (u32)dst
> +  SDIV   ALU64       dst s/=3D -1 (dst =3D LLONG_MIN)   dst =3D LLONG_MI=
N
> +  SDIV   ALU         dst s/=3D -1 (dst =3D INT_MIN)     dst =3D (u32)INT=
_MIN
> +  SMOD   ALU64       dst s%=3D -1 (dst =3D LLONG_MIN)   dst =3D 0
> +  SMOD   ALU         dst s%=3D -1 (dst =3D INT_MIN)     dst =3D 0

This is a great addition to the doc, but this file is currently
being used as a base for IETF standard which is in its final "edit" stage
which may require few patches,
so we cannot land any changes to instruction-set.rst
not related to standardization until RFC number is issued and
it becomes immutable. After that the same instruction-set.rst
file can be reused for future revisions on the standard.
Hopefully the draft will clear the final hurdle in a couple weeks.
Until then:
pw-bot: cr

