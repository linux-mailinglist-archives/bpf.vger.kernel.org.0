Return-Path: <bpf+bounces-46298-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B6A9E77C4
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 18:59:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBAEF16D6F8
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 17:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32DA3203D4D;
	Fri,  6 Dec 2024 17:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h6R3dvrD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088F022068F
	for <bpf@vger.kernel.org>; Fri,  6 Dec 2024 17:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733507964; cv=none; b=hJ24Td0eUoqdqU/ugm59lMbDkv28BwMHaNEXLB9hl6LmSmZNZ9957EJRWrIayMl9MGr9w9kp4MWeJiMU/0RhfkA3gJVu40bOUtFMYWHJz91G8RfROpGKhZBz8n26skvTAYa6+xgY8iqbIr9V8qDqF9M4lVHdNpDHemm254bmcc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733507964; c=relaxed/simple;
	bh=ii2oIRbD3Us/3FFLhG4DybyX0rPHolL9jtCbeTXIFvw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hjvXyX3nZZAGWnYUK8swt4SwKhloDE5e/cP1I22raxDbjCeMo+25s5z6KA0ZdleSu9aKbWG/MQo74t/B1kbi7fUS1lBQvL2V1oHjsD85XQ+7/WVOusUzVnbg5JYMasmKYlsuM39wrkzmSLZD/tcbL2rM5rHAjOdgI4R2velIJII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h6R3dvrD; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-434a736518eso26971545e9.1
        for <bpf@vger.kernel.org>; Fri, 06 Dec 2024 09:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733507961; x=1734112761; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A2HIfWGY6mFjLRI225qnHRsGz1LHHhTVmhnqLZKulss=;
        b=h6R3dvrDBv7Kj7E9UAmT3D11tX765AqRkvWTi7/agzTVDd05S6nIgYQ143Upx7p7Nq
         uQEaXKF2ub9xvNmRcz0ddK61AqkVuwmWsPMN7IbKCKlHSvgjfqAFbzyGC6vedAYguRzs
         VDMk3uGBdrglgD8AJfPpt+YgISAotQicrjGHrRjv3cZDo/K7PDL3DrPT7YFXHE9OPdrS
         lrY9hNdawSU4+a10UDR2OWl9/a01WQ6TPi+/dMtiNYv68Ju5mkAhVJUcutENCMsAlC2/
         qCE0Xxvn7C//Ldf8cdBQOX4uRks4M2fcXLvlZVswCrQ4DIFloNUticrEqsIe/XkS6uqy
         TrwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733507961; x=1734112761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A2HIfWGY6mFjLRI225qnHRsGz1LHHhTVmhnqLZKulss=;
        b=eqqpAVq043/1Ci2VebYZrFcBA4u5WyZ57+H5WWIJeuaIQq6M9uc2MG3pLQHofP6L6T
         C5+SciOsXT4pRjYEp2IN1ff/eiXIYHe4urCYin/VSaJFjgd2oP6g1O33FdmQOPalL4W2
         qSCf9Q0zIEQHkugoqflRaUGua9jqaFSSXqkwRYvRMJm1imLMTRuYwcr7JDSH3DBPMTEh
         9QTyWjCkwqtNOU2Fpliaao+BS0N6XzoYbH5cXvE9vL0TTNuhOqpgbwLQmAuEfMXagZVO
         y1dHr2NoGHERQ1ViG4BWDcbapHWAUetlEj1queDIplXMbWz7/0jHR/y79Dg2yfchlSpU
         6/kA==
X-Gm-Message-State: AOJu0YyGESi9GfqnRWoyGi7HTbms7qWqfYm5NiF2mhWxVHCz+GXN8cnx
	DwQ9Clr24Ha1mH4CWiYHV0ujwuBEh2BaMBicwvolEs75Wje9qf/aRHnV3lJmjIwCbdJA+oXLpJ4
	+0Yh+STtyzyaq3XuccLl4rx0ExyM=
X-Gm-Gg: ASbGncsHc6sX9PnthllazT5wbfdV5rX2PU+cC9oltvAryNUm/IA+NlYTISxlIH3DLti
	sqHek20cC7uH2NSARXbWgbHgR1UlEDrKlI66AY4y0Xw0+Jww=
X-Google-Smtp-Source: AGHT+IGaKdXxudc2JL1ugFvWXasZ9JoRmTS3sGRaXBrccSWj1QzA43TddRZy1AcW2p81Q6Z7QyFFYvRuOB6Cs6m5IrY=
X-Received: by 2002:a05:600c:1f8c:b0:428:d31:ef25 with SMTP id
 5b1f17b1804b1-434ddeb516emr42094415e9.12.1733507961137; Fri, 06 Dec 2024
 09:59:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206161053.809580-1-memxor@gmail.com> <20241206161053.809580-3-memxor@gmail.com>
In-Reply-To: <20241206161053.809580-3-memxor@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 6 Dec 2024 09:59:09 -0800
Message-ID: <CAADnVQ+_XGVsxYji3WYNj1-KhYZwKaFCgQ6aN=yFB3YWpRT78A@mail.gmail.com>
Subject: Re: [PATCH bpf v3 2/3] bpf: Do not mark NULL-checked raw_tp arg as scalar
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Jiri Olsa <jolsa@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, kkd@meta.com, Manu Bretelle <chantra@meta.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 8:11=E2=80=AFAM Kumar Kartikeya Dwivedi <memxor@gmai=
l.com> wrote:
>
> An implication of this fix, which follows from the way the raw_tp fixes
> were implemented, is that all PTR_MAYBE_NULL trusted PTR_TO_BTF_ID are
> engulfed by these checks, and PROBE_MEM will apply to all of them, incl.
> those coming from helpers with KF_ACQUIRE returning maybe null trusted
> pointers. This NULL tagging after this commit will be sticky. Compared
> to a solution which only specially tagged raw_tp args with a different
> special maybe null tag (like PTR_SOFT_NULL), it's a consequence of
> overloading PTR_MAYBE_NULL with this meaning.
>
> Fixes: cb4158ce8ec8 ("bpf: Mark raw_tp arguments with PTR_MAYBE_NULL")
> Reported-by: Manu Bretelle <chantra@meta.com>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  kernel/bpf/verifier.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 82f40d63ad7b..556fb609d4a4 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -15365,6 +15365,12 @@ static void mark_ptr_or_null_reg(struct bpf_veri=
fier_env *env,
>                         return;
>
>                 if (is_null) {
> +                       /* We never mark a raw_tp trusted pointer as scal=
ar, to
> +                        * preserve backwards compatibility, instead just=
 leave
> +                        * it as is.
> +                        */
> +                       if (mask_raw_tp_reg_cond(env, reg))
> +                               return;

The blast radius is getting too big.
Patch 1 is ok, but here we're doubling down on
the hack in commit
cb4158ce8ec8 ("bpf: Mark raw_tp arguments with PTR_MAYBE_NULL")

I think we need to revert the raw_tp masking hack and
go with denylist the way Jiri proposed:
https://lore.kernel.org/bpf/ZrIj9jkXqpKXRuS7@krava/

denylist is certainly less safer and it's a whack-a-mole
comparing to allowlist, but it's much much shorter
according to Jiri's analysis:
https://lore.kernel.org/bpf/Zr3q8ihbe8cUdpfp@krava/

Eduard had an idea how to auto generate such allow/denylist
during the build.
That could be a follow up.

