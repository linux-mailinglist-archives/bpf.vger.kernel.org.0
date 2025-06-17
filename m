Return-Path: <bpf+bounces-60840-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 364DDADDC88
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 21:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B8ED40164E
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 19:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16EA2E3AFD;
	Tue, 17 Jun 2025 19:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hh/GMYWP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6152E54B8
	for <bpf@vger.kernel.org>; Tue, 17 Jun 2025 19:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750189283; cv=none; b=U+bfl8USBk5h2I1jYy2eS8l8iZtrHt/MZxwSwFw4deTVIeIWURRvDAdH8cK7cdspDRakFVHQfPkhe8nJCtx5DfWJCLSm5ACUqjVFCWO1SSGNkFky9tKvj/KWSEbEceU+xUjbRbLXQLf8EyuicfocQ0QGth9NRBK/mb3t7n9afLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750189283; c=relaxed/simple;
	bh=AGLzjS/1BSwPsignAbDfqrKx1gFrVsCrqfvij3dlhnE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MW13qnFjXlFuyZQ2rpdwY1cmhgBPMG2CMJxhXEn5VOrKTDQ1vAhMrZ/MQ+zU4BL+VPcAjRqrM8qdyXLsVU88cGXtP9TvB9mCSTIi189anSi9+NJoqVxctQ6kQ4to94VZJOY/3YYh3nYGsOZX5K7o1J1t5r1dL8xrmgCYesR8nww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hh/GMYWP; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a4fb9c2436so3583378f8f.1
        for <bpf@vger.kernel.org>; Tue, 17 Jun 2025 12:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750189280; x=1750794080; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HZqYeuK1FaEvKvrYFUWYLp2RzFp1z+Zs06p+gSmOzj4=;
        b=hh/GMYWPYWvJGZcTJcwcPJ4F8HHiBfjQ5B3z1N5wvXeCQS8Hfj16bjEROLiPVpdrve
         xSanOUtkLaiuHvILTbgZLO/yH0Z/6owzSgxWWrexH5eKZe47NzGJgP21SHP7x3ps0N0s
         qFsywbWzjrp0roa9PL/X8gBHHNGNbS5Qi36P+tWEwb09qQJyIEu5e5ygjDA+HAq8hnvn
         NHW3sPSNILAVOSkyosVZWR8bv5CHNp2BOcO57ie6nQ1DAxcHo3DEAtKvfG5Ekg17wqY5
         /tIWwmunyQedYKPLGDqqYwdMdZgfV7XesZP6x79VVIYDuvqKd/QwXqbkNsS3nrX8Drsc
         ywwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750189280; x=1750794080;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HZqYeuK1FaEvKvrYFUWYLp2RzFp1z+Zs06p+gSmOzj4=;
        b=dRIe6KslkX1Tm+x0pTAXAoA6zfLK8kfSFGzRsHrclkjmyavnMbD0vB/m7V0ltgUDQS
         443hVww4ke7nL4sAGfAlT1/y0x2lGqWTfk9tnOq9g3wIb3j8FrIxyGjF7h4aJylDP9Kh
         yk2mgQ0RnBCLlnhIPeY8d40/jjqYXtsaEmwLzibcy+hc98gQJdGiM/kpsFF7zo9SmMK9
         Ipc8xbNEmlKR+r/KFm4CmBAxO6qOV+6qpkXpumJzQRocqmDXvj+qO8ZV2hF01FYyq7UK
         yPc1+4viLNS9mPjCYMpih6gXeBZ97agiC5vUMbPN/KE8bFhIpr3Eh+I/1v+/Jn2nAHCu
         3k3Q==
X-Gm-Message-State: AOJu0YxdTejETqLO1Ty26LB+OzBEfor83iqupCqJd/NFWbBpbkuPVmH6
	JGL7yAh2YYx9QlgbljdenrkgHeDySRCFY/kkG8HWT+wbfLWlsH3+ZnwIoWX4gn64fBlQrmrOgKS
	k0KFAkbtrVMUGVswY/bfWDDUGN0AMkxk=
X-Gm-Gg: ASbGncvoh38jqybPlB2owuLeToxXQq0vr8aydMuxaqfiJW+8mxLkD3MQMjpQUvbUnmT
	Fq4Mtk1z2Yjhe8NrxLEoV/SbDBVWUYsNYJP+Q+PaCkPu6HoL8rL+lchaWUHswkP9X2SNWRgUZvv
	Ffld/0A4jkNiXC3JnGbnZx9BbQM5F7BudFf+Z8McfvOyxTLsXmyZ66NiumnW+NURqX+pTSkQ==
X-Google-Smtp-Source: AGHT+IFAJxYXP8dnb1WiHEDcOINadBPPSaqSajMhmHCRyUofhMc+MJCmyWsI/QxSshxrPB2O6nQmOTna4RPLz0vTSE0=
X-Received: by 2002:a05:6000:2c13:b0:3a5:1241:ce99 with SMTP id
 ffacd0b85a97d-3a5723ad5dfmr11509509f8f.24.1750189279566; Tue, 17 Jun 2025
 12:41:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250615085943.3871208-1-a.s.protopopov@gmail.com> <20250615085943.3871208-5-a.s.protopopov@gmail.com>
In-Reply-To: <20250615085943.3871208-5-a.s.protopopov@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 17 Jun 2025 12:41:08 -0700
X-Gm-Features: Ac12FXw61DqooyiJYNKbx-WPlsIfOpoNUu3LtC9cgOrB52_7xqdSChKbldVvrZ0
Message-ID: <CAADnVQLtPuWOQmeJhPtBf-wyR8PS=u+1Wg4DtNVNZ7kPF5QZ0Q@mail.gmail.com>
Subject: Re: [RFC bpf-next 4/9] bpf, x86: allow indirect jumps to r8...r15
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Anton Protopopov <aspsk@isovalent.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, 
	Quentin Monnet <qmo@kernel.org>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 15, 2025 at 1:55=E2=80=AFAM Anton Protopopov
<a.s.protopopov@gmail.com> wrote:
>
> Currently, the emit_indirect_jump() function only accepts one of the
> RAX, RCX, ..., RBP registers as the destination. Prepare it to accept
> R8, R9, ..., R15 as well. This is necessary to enable indirect jumps
> support in eBPF.
>
> Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> ---
>  arch/x86/net/bpf_jit_comp.c | 26 +++++++++++++++++++-------
>  1 file changed, 19 insertions(+), 7 deletions(-)
>
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 923c38f212dc..37dc83d91832 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -659,7 +659,19 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_=
type t,
>
>  #define EMIT_LFENCE()  EMIT3(0x0F, 0xAE, 0xE8)
>
> -static void emit_indirect_jump(u8 **pprog, int reg, u8 *ip)
> +static void __emit_indirect_jump(u8 **pprog, int reg, bool ereg)

Instead of adding bool flag make reg to be bpf reg
instead of x86 reg, tweak the signature to
emit_indirect_jump(..., u32 reg, ..),
and add is_ereg(reg) inside.

Also drop RFC tag next time. Let CI do the work.

