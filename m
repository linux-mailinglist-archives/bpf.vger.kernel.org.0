Return-Path: <bpf+bounces-55742-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4017A862CE
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 18:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2F1C7B329D
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 16:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1236E2144D5;
	Fri, 11 Apr 2025 16:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bnjiYj6k"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3632C3FB31;
	Fri, 11 Apr 2025 16:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744387345; cv=none; b=cB6G7K1WRXOr3jaoeR2UoTSdAO3SbOt61ehUVIoYAmceRZnd9O2/NkdQHdoN0fajcSpxhFi12bGMS7gBvHO1yhUEC38rkqtFYxNwdQnt5qo/l4IFwjlx+izegEc4u8a2TesYG7zaBwQlLDCSrq7WAID0nSomh++NBFPMXZ8Uis0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744387345; c=relaxed/simple;
	bh=FBhKAhCk/Hs4jh6mOB55KPo132DTLmqr0zUPgw6DWE4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iulaEI19wTMDTv1FfBS8E6ptjqUAmFfo7ltPBZaREJDHzw90POe+bhpdk1aIbn+q/+Gs0TWNd4o7rRJbL5ZTjiTZORvzhEmtRhlfl5eYCLpndL3BLsuXQg99A0iDCHWCZiX+OdXo47RTo4XJbB72pRSxtowtK4S+/KFe7Xp3mcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bnjiYj6k; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-223fd89d036so28663275ad.1;
        Fri, 11 Apr 2025 09:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744387343; x=1744992143; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C3DPNfADpRbO1wif/yzIDEg2UdfSfF1zHSCMQvWGdmc=;
        b=bnjiYj6k6QuOY4HRTlpR+uwXSq9zZrkMmgd7kp966jIEVi33vPuVTcUZDnCO2EfKop
         U/OOu4Enq8iNVQzTuO+872xTjsiXxs2ssBiluNRFHrOcZ+2kUHkeB5u7reysnyHGJlVw
         FdYaI7NtcXmF4fFIDTDanLa6MOalkZ9JxqJvyFJ/OJs9licThWUO/wC6ZE3na1dmQcp5
         n97vg4+Q9NlE1/xcBI5RPMuw6R01eU/Fh2KMTmv6uqFuLQWPfT/utdBjrFwaz91IT1Rv
         fAioWEmha/zrw/L3XDfIYNbBuxOtsyPb11kUdBc4bG9bE4g68Ynsf1pFVTWRiD1cfscA
         YwVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744387343; x=1744992143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C3DPNfADpRbO1wif/yzIDEg2UdfSfF1zHSCMQvWGdmc=;
        b=XYF4E9PJypIJIMa9L4i8TJdXubLZsN5U1edTTgTmBN6PNLcQ3ewh4uRAyXVF1iUtzS
         LsTeUB0PGMaOq8PFzJWt8Te/ELrFG/Ci6Fn2DTTZc1woro7rPjpSeKOBfgy2iIeiSaoL
         Rd6V1G7NfitYjC4fBKl7glyg7V4RHZpohltNWTbmNWKjL0+7NQCbeSau1KZR/zYjg0ry
         sVAQj5nk8ZYKE8WqMwIWF1gS+g7R5Rvf6AhBabt6na8wY+vRV99qHmtty1YULhrdw8NF
         gmlTYZaUKD+Rz/Xf19emLZLNdAzzRCaafdXOgl8dFW818SDCY6rDF0/yqc2MtWEpODQn
         0TDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwZa3LRXb5aUVKo0mVKbDsg7wbjVCyisdg8i2efN7peJK1ztKPahgoMoS/rsN3IrINh1xFhqFUU/N4I39bwRI1w6uk@vger.kernel.org, AJvYcCV6mmuh82YQyxZzcnYvT4gEZxqkGUiUMZzLG075Fp0NXVH3ICKXhb2VsOiqcwsbk3vftCoZi39g0aE3K1YA@vger.kernel.org, AJvYcCWupsh5INAoZGbrw7EdmfhaOp0Qq4WolxL/CgxRlNEV/sQbMx6PlmdzYdJdFAjPzapiUdY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzITOh3RACCP4FPNNaZ64AotDTdvmOpTx/z1By0vBA3/0Hawzdp
	x9nwUikqSGgX4RaOZsuKSMJPhZAPLGdpwlF3b1YzMDsjqsuUkPMTmlr07X0ZLPR98yB/FipW+wo
	h//OFt7WlnIPn5y61QhwQI4JVb/k=
X-Gm-Gg: ASbGncs6ZXDo/CqGJy043ApfKMzPWfS1vnbOuESSdWm1+kfbDN1JoQpAkKbd8InCvzA
	3QRpldyZuEhCZ4RX9qHRDcn3maWbIAlcZFv2iEsoSWeVAQ5S8dv0c8YR3SF01p0Li4sy4OmPbI/
	2Xb6UPiyu3PIT9iooNPIE8UXUfMDlsyShA9mOv
X-Google-Smtp-Source: AGHT+IGE6SwOYErmeGW2zkfo9iEtcidg/4bcd7sx1oOsxjrLzNGHC5Ih6AYkQc+8dfsKufqVyATMTAoEoVaFDP5FwK0=
X-Received: by 2002:a17:902:d544:b0:224:f12:3735 with SMTP id
 d9443c01a7336-22bea4c622cmr51167305ad.31.1744387342268; Fri, 11 Apr 2025
 09:02:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250411121756.567274-1-jolsa@kernel.org>
In-Reply-To: <20250411121756.567274-1-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 11 Apr 2025 09:02:10 -0700
X-Gm-Features: ATxdqUFMdxe1xSqNq0fGhqgKKXiKqkLATtLR8xwfoX2J_XiJhj9ETSYhQ_MQ18U
Message-ID: <CAEf4BzbvMYJf5LLxwamYpzzu=Sewzti-FR-9o4AGfU+KZu0b1Q@mail.gmail.com>
Subject: Re: [PATCHv2 perf/core 1/2] uprobes/x86: Add support to emulate nop instructions
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	x86@kernel.org, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 11, 2025 at 5:18=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding support to emulate all nop instructions as the original uprobe
> instruction.
>
> This change speeds up uprobe on top of all nop instructions and is a
> preparation for usdt probe optimization, that will be done on top of
> nop5 instruction.
>
> With this change the usdt probe on top of nop5 won't take the performance
> hit compared to usdt probe on top of standard nop instruction.
>
> Suggested-by: Oleg Nesterov <oleg@redhat.com>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
> v2 changes:
> - follow Adndrii/Oleg's suggestion and emulate all the nops
>
>  arch/x86/kernel/uprobes.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> index 9194695662b2..262960189a1c 100644
> --- a/arch/x86/kernel/uprobes.c
> +++ b/arch/x86/kernel/uprobes.c
> @@ -840,6 +840,12 @@ static int branch_setup_xol_ops(struct arch_uprobe *=
auprobe, struct insn *insn)
>         insn_byte_t p;
>         int i;
>
> +       /* x86_nops[i]; same as jmp with .offs =3D 0 */
> +       for (i =3D 1; i <=3D ASM_NOP_MAX; ++i) {

i <=3D ASM_NOP_MAX && i <=3D insn->length

?

otherwise what prevents us from reading past the actual instruction bytes?


or, actually, shouldn't we just check memcmp(x86_nops[insn->length])
if insn->length < ASM_NOP_MAX ?


> +               if (!memcmp(insn->kaddr, x86_nops[i], i))
> +                       goto setup;
> +       }
> +
>         switch (opc1) {
>         case 0xeb:      /* jmp 8 */
>         case 0xe9:      /* jmp 32 */
> --
> 2.49.0
>

