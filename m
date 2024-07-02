Return-Path: <bpf+bounces-33680-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 719BC9249D9
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 23:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0039D28506B
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 21:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B436A201275;
	Tue,  2 Jul 2024 21:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OyUh/Llm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FEB201260
	for <bpf@vger.kernel.org>; Tue,  2 Jul 2024 21:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719955272; cv=none; b=Xhk8jMGGgoLw9flINPdS7wyzrIEuaXU37KDZgDzVFelohiQMLiNhTpw1RGlNyG1+BgHUVl2dgeCy3f7xf1VaX/RqyCufYWgOQ4fATMGaKgAmgrc6dsClM+zo29EYu4BiMfLLCZR70vraGesjGFhtxBt2RAuD5Z2OzvlxPuoc3GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719955272; c=relaxed/simple;
	bh=FTv/Fc1u8HfepDkB0OyV4upEp7X6hX7nfl8KpzC5u5k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ECybg19yGW43PQKAmLcxOneeX7jlx67UHp24fFGgp57TxD2UKIfV0kKlmZA2L556jbpyVEVUOUitKoanvbOvwOhAWUCy1179xPanJZApgs23xpdJrlt6a+0aoIyMkW4lvDfVopzYq5pVIwNjL5/cMpl/kEMkwUPCrY7Gqe7Sooo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OyUh/Llm; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-706524adf91so3841494b3a.2
        for <bpf@vger.kernel.org>; Tue, 02 Jul 2024 14:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719955270; x=1720560070; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/HtMjwhfC5FDzBEm5pFUqJM/epqJSOM9pl6jnUtab20=;
        b=OyUh/LlmR8517Dty45H5nPFAwtU03g91y25v1so62Z7/SIKcX+apUbBb/mU4M4E7qW
         jl1VHQqgi/vZ6dYo6NFLoFQRt65YpW1hKTH7B6ov3CXMF5aCh1KqR4fMyebr41AlxHPG
         RyLYnlJYkZ+emDd92QFxo3ym2DeaM5cZwi1jbPYji7uZ97f+yi4eopY8pEMqVVH9mecd
         ofq8FAGQYSIY25TBby4jxoipOd4KqfA8YhxlxjfiO4DtECA9Q50wcM6JabuPRugrL8Aj
         /EGDs6JHn1Moyg6CVEbB8YcCS9jAz/7N/987elK21+hS6oYcMe3b4aVNfN0gMafAloD5
         cZaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719955270; x=1720560070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/HtMjwhfC5FDzBEm5pFUqJM/epqJSOM9pl6jnUtab20=;
        b=FLHau4eIKn81eJN3/1s6blqojPdFTYv2MqStv+6QAyNSiY0tai4mBZoAUFE25mFjns
         srTsDGFMpw9Bc6V8gzhjVTr9vLmFPjDexGJpIP65NRq4wiXhvseKxqxtqFBEmgsTh23W
         FU0/N0dYUIu2uSKRCIqqBhcrqiIvvcfgmFEKqJ4IDd+j1wcRP2rtiF9CQfmA0bk91UMF
         Wmx+/qWU499brorq+2Es1iHzcdazlv9nCIz3AAqRpIszGuu4V/Mw2kGj8PXtBAiBM9vr
         7PwlmgI3lQTFVnl4+4nTbr+eHolfECuZ/VTpm+pnA6dBlRb2A1G5VKJXPFPAp2UOh+e9
         +XvA==
X-Gm-Message-State: AOJu0YwjdlHPIC9DI0GuuYp2v4R5yLvYmfpRiUq8h4CC4Qm7pGBZiRaF
	Efl0K7+7eupQs1nX86dK2uh16jYX3AuD0xowWb450XZ85w3/Y4Rkmrsbpp85pROMdROioeIdmGk
	WP7QSHKstK/sI7c+cu1OLIc6BTqx8/g==
X-Google-Smtp-Source: AGHT+IFX0o1SCJv7Ll47M3YlQNRE3UpFBDNOydiMbhTWt/ffmpct2j1J1SMYV4SrvdHgs6phNeKSM/ZFF694ZcWXzYY=
X-Received: by 2002:a05:6a00:1944:b0:706:8a67:c395 with SMTP id
 d2e1a72fcca58-70aaad2b21dmr12549030b3a.6.1719955270332; Tue, 02 Jul 2024
 14:21:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240629094733.3863850-1-eddyz87@gmail.com> <20240629094733.3863850-9-eddyz87@gmail.com>
 <CAEf4BzbKauxUgFq83V7Nq-g5GXUOtDYok1mXibocBLwiosz+Jw@mail.gmail.com> <65581c92184dbea483d9d5dace69da1fc281ce33.camel@gmail.com>
In-Reply-To: <65581c92184dbea483d9d5dace69da1fc281ce33.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 2 Jul 2024 14:20:58 -0700
Message-ID: <CAEf4BzbGgS8BF791ifsVQyUw8ybypMCFZznijkN+R68LKGEPMg@mail.gmail.com>
Subject: Re: [RFC bpf-next v1 8/8] selftests/bpf: test no_caller_saved_registers
 spill/fill removal
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, jose.marchesi@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 2:12=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Mon, 2024-07-01 at 17:42 -0700, Andrii Nakryiko wrote:
>
> [...]
>
> > You don't seem to have a case where offset is not a multiple of 8
> > (though it would have to be a sub-register spill which would be
> > "rejected" anyway, so not sure if there is anything to add here)
>
> My bad, will add such a test-case.
>
> >
> > > diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tool=
s/testing/selftests/bpf/prog_tests/verifier.c
>
> [...]
>
> > > +void test_verifier_nocsr(void)
> > > +{
> > > +#if defined(__x86_64__)
> > > +       RUN(verifier_nocsr);
> > > +#endif /* __x86_64__ */
> >
> > maybe #else <mark-as-skipped> ?
>
> Right, makes sense.
>
> [...]
>
> > > +++ b/tools/testing/selftests/bpf/progs/verifier_nocsr.c
> > > @@ -0,0 +1,437 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +
> > > +#include <linux/bpf.h>
> > > +#include <bpf/bpf_helpers.h>
> > > +#include "bpf_misc.h"
> > > +
> > > +#define __xlated_bpf_get_smp_processor_id              \
> > > +       __xlated(": w0 =3D ")                             \
> >
> > how will this work for no_alu32 mode?
>
> The patch is applied by kernel, and it does not care about alu32
> compiler flags:
>
>         insn_buf[0] =3D BPF_MOV32_IMM(BPF_REG_0, (u32)(unsigned long)&pcp=
u_hot.cpu_number);

ah, right-right, of course!

>         insn_buf[1] =3D BPF_MOV64_PERCPU_REG(BPF_REG_0, BPF_REG_0);
>         insn_buf[2] =3D BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_0, 0);
>
> [...]

