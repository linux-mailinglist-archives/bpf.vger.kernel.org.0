Return-Path: <bpf+bounces-33675-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82CDB9249C5
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 23:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4C421C22BD4
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 21:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840D0201266;
	Tue,  2 Jul 2024 21:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="INfoNB9R"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE88E1CE0A1
	for <bpf@vger.kernel.org>; Tue,  2 Jul 2024 21:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719954735; cv=none; b=n9JjpkvOfSz1JIxmcEPpTwFyv9Amlq0itphxAfzjqMvjjOg7VRDdckvfMjktugdZADVbhzcGiuvVctggV3vhoKd003zv221Azj6g4KJyWI8EsoYdptSrahVjq4FDI6R8LmywW4s32IWySHAw7eSG7Zpp66zrjU5Y1zuW/Aj3O28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719954735; c=relaxed/simple;
	bh=TLJP/EVcSfA77ewDt56mhNAwTEFGUmp1YC1pVd3yvdI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TTj68YzGC1FbzRlWSgaJbpVjf1AH/93pV/SYmpiuZKCw5HnE0CaIeuEM8MYPfv11MmlVwrMNlDc6W7vKBA079KM9u0jDpkbuovddME+c/el6UhDC44gGlH5TB9QqFSQB+WYSWSCJfuDpiHLDd5Bv+0LYXepB+7Vu/iDL96mLN+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=INfoNB9R; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-70675977d0eso3057893b3a.0
        for <bpf@vger.kernel.org>; Tue, 02 Jul 2024 14:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719954733; x=1720559533; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6Xzq0cKIVdjnwjbr8Yi+YW/27vaWsA3Rw1ZS0h9Gdaw=;
        b=INfoNB9ReYui2x7SetXMBnbT9JK6c2Gk18jgrmVxG4cmHIWbHoyajV/cHjyc9qFouz
         nSM7DhS1YdH5vS9/Bl17wKQpNLFbGqCXtnVD/BHu6zbAUPGmMha5aNWaZ8VKtiR2Nb8d
         +VM02iy3dX1Kes3+rw+DpbhsBC05axHlrwfSRbx+2eW4yZY6j1BlRdmIfWUK6xNNKqk+
         hd+1+Tg9PGqqubO4pkDJlxJrmXH8TMWAYkBfwraUMky3Kcboirtvj/Tya2s77dq7p8gc
         oizajUl4Y1JFfF/KgNcnwWotfxKO/KUhF7piXcHa3O2JU9cH1Gu4Yy+UKjtyL0TUlKBB
         QNJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719954733; x=1720559533;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6Xzq0cKIVdjnwjbr8Yi+YW/27vaWsA3Rw1ZS0h9Gdaw=;
        b=AbiMLChn3dgsCOWrcZP2TGPgKUAfV4kW+zN7JICX0Qp/eT05F7kf2M8ShSf53XVSgd
         3RXcKiYUySpn95XNvcbw/QmFFM6q2Sle6VIDaWyiYyd/J9QmqoMaRb0yUNBwyf7edvCz
         7MF2bb0/6dAFk+GxcqaXYtVtqmDXvVATl0qiN9H76XI846+7uk7m6mh0qZRsc/isqGI6
         LncZN8n19T7WVbgf3OWK0i6ysa/dlTn1Eeww4CX13U4TSHK3gzjuoBXDU2To5VUmsOAv
         /NQjPkw1X7RAczdeMbnzKUNYIM1C60qHxxdUCAxeyJn3ei2iPlayHu4gPGhtUgmQU6RI
         0eeA==
X-Gm-Message-State: AOJu0YxhtLHW1a6EcYk9OpFGLon9MvoiuymGAogVxTNb6GrnvbNozljy
	u0nwx5WzozbTi4vWTN9I9IWOmaiFAvLRnDwUWIZofTSFYzKX+Pr0
X-Google-Smtp-Source: AGHT+IFEayNyvFYVEs6/j+uqIhLakk+2YsV8kFxcC/Wt7iD16LiITtctEEwvOloqrjpb2Z+nTHV29Q==
X-Received: by 2002:a05:6a00:3c8b:b0:704:317f:6388 with SMTP id d2e1a72fcca58-70aaaf39db6mr9165893b3a.31.1719954732889;
        Tue, 02 Jul 2024 14:12:12 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70802564236sm8994133b3a.48.2024.07.02.14.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 14:12:12 -0700 (PDT)
Message-ID: <65581c92184dbea483d9d5dace69da1fc281ce33.camel@gmail.com>
Subject: Re: [RFC bpf-next v1 8/8] selftests/bpf: test
 no_caller_saved_registers spill/fill removal
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev,  jose.marchesi@oracle.com
Date: Tue, 02 Jul 2024 14:12:07 -0700
In-Reply-To: <CAEf4BzbKauxUgFq83V7Nq-g5GXUOtDYok1mXibocBLwiosz+Jw@mail.gmail.com>
References: <20240629094733.3863850-1-eddyz87@gmail.com>
	 <20240629094733.3863850-9-eddyz87@gmail.com>
	 <CAEf4BzbKauxUgFq83V7Nq-g5GXUOtDYok1mXibocBLwiosz+Jw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-07-01 at 17:42 -0700, Andrii Nakryiko wrote:

[...]

> You don't seem to have a case where offset is not a multiple of 8
> (though it would have to be a sub-register spill which would be
> "rejected" anyway, so not sure if there is anything to add here)

My bad, will add such a test-case.

>=20
> > diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/=
testing/selftests/bpf/prog_tests/verifier.c

[...]

> > +void test_verifier_nocsr(void)
> > +{
> > +#if defined(__x86_64__)
> > +       RUN(verifier_nocsr);
> > +#endif /* __x86_64__ */
>=20
> maybe #else <mark-as-skipped> ?

Right, makes sense.

[...]

> > +++ b/tools/testing/selftests/bpf/progs/verifier_nocsr.c
> > @@ -0,0 +1,437 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include <linux/bpf.h>
> > +#include <bpf/bpf_helpers.h>
> > +#include "bpf_misc.h"
> > +
> > +#define __xlated_bpf_get_smp_processor_id              \
> > +       __xlated(": w0 =3D ")                             \
>=20
> how will this work for no_alu32 mode?

The patch is applied by kernel, and it does not care about alu32
compiler flags:

	insn_buf[0] =3D BPF_MOV32_IMM(BPF_REG_0, (u32)(unsigned long)&pcpu_hot.cpu=
_number);
	insn_buf[1] =3D BPF_MOV64_PERCPU_REG(BPF_REG_0, BPF_REG_0);
	insn_buf[2] =3D BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_0, 0);

[...]

