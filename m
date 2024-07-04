Return-Path: <bpf+bounces-33902-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4885C927B82
	for <lists+bpf@lfdr.de>; Thu,  4 Jul 2024 19:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C992DB21F3F
	for <lists+bpf@lfdr.de>; Thu,  4 Jul 2024 17:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D321B11EA;
	Thu,  4 Jul 2024 17:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m1NRD0j9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6D918AED
	for <bpf@vger.kernel.org>; Thu,  4 Jul 2024 17:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720112416; cv=none; b=SwBfgmlQqltt4qx23a2uxo7HH9XQtlfTXUZQTGsVNsFfs3KYsRCayx1IL67mnQe2db7jV3gG653HArN0cH7aoM152afSsCgW0GQ1OJUVlZ+3ggRLlye6AsTWHyM7DuA+Ip8cQdk4UocdMGWrhx3v6/MKuzn0GX+4KNu5ctbkjYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720112416; c=relaxed/simple;
	bh=yHsPUxMQpZKZoIkxduMGwQLI6SZ+kjn71XdcUKAtK7E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hhu5++BVjKDVgwZnz6Qr4d3RESAe6iD3iXRotQHQTT762K0yCS+mtKScyK9ImS7HBWpFUFQ2OKf4OYNmb4OWKYTOw0eQbdcwKWQ/2qIVIylToOeVaZfQsIDB60s9uE4d7nrYXm4AxrGXueUGBc/kZ8aVjxppDCl68j4FuU7lScw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m1NRD0j9; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-6eab07ae82bso474102a12.3
        for <bpf@vger.kernel.org>; Thu, 04 Jul 2024 10:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720112415; x=1720717215; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yHsPUxMQpZKZoIkxduMGwQLI6SZ+kjn71XdcUKAtK7E=;
        b=m1NRD0j9ZWMVxC6PNsRIxzrwDeL3TbugvsPf9xVAsF1nSGhz4pHr59y6abBnL580fj
         7kDFG72tNlvnDmCKIzPgvwceELUfpJt5r3Y36OXnvcde9JadTxs7BtGNesgLalqKyN7+
         F2B1iQBKdr0v3HkNRZXlcy5QdfPxyjEJNGqDh4XJNls/TTWu0q2u5VNOsx8Gfpj9Uxj/
         CYmmTqm1iwbMGjm4RnVblJpFPYh4o86MXpTkED15ZL+XcHdtxUZ6SmyBv9yljEUJ2O8L
         b8qTFCC5KsejWLGc7KwO/soSDccstocZgjJYcvztygM/GtJ5qr98W7jen6yiSKHJWQmp
         BEcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720112415; x=1720717215;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yHsPUxMQpZKZoIkxduMGwQLI6SZ+kjn71XdcUKAtK7E=;
        b=OW8c9X0DTvRLq9CTqbSrn7RQ7NuVkaEAJJuhTK3P/u2SaIAXPIg0TTrdVZBmkjvOd/
         DhJaZ0J1zJ6fDRj4xyWXagcZshCyoqVrcD7iWFxqlRuAM2W6dG3Mi3lIGsqxbgaiKzcV
         wJ9232+H5wqR+iNcU8HF/H5KbPIDxdcCjH94MvdwO6Ne9z3OEg8tC0JuRK5dHswZZD+K
         B6qDr1ubZug4O+0SYljEGMqkIexG9a+5xhu6RBNBpxsfGuaAz/da1t/Qv3SHMfBTFGmO
         MqEUGB8rCTOMKxbVFF8ky6pDhala7cEcNhc5d3JdCYKKpI2liiLiljHt8Zkz6+bkhWof
         DKPw==
X-Gm-Message-State: AOJu0Yy+c3yMhpxtoGVILTERMrOM+bRHVbFhjeBSyKOHqfIUQOqoohIN
	UuGJFzIlPFY82u0XDkYKVkNeBjhXoUKUsmuaXTHFc4Fij2EOZiYIP6qhGA==
X-Google-Smtp-Source: AGHT+IFaL2rJbNbUyuUEjSMUxJ/cqoEvS/SolpksA9BOOIdR/dG0Jdq5TjeeZlMKs+N8M5IogCNn+w==
X-Received: by 2002:a05:6a20:2450:b0:1be:d2b0:76da with SMTP id adf61e73a8af0-1c0cc74abefmr2380757637.23.1720112413803;
        Thu, 04 Jul 2024 10:00:13 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fb2ebeb132sm19544125ad.49.2024.07.04.10.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 10:00:13 -0700 (PDT)
Message-ID: <133f0ecd9ecd92268169034d329e87d22118588e.camel@gmail.com>
Subject: Re: [RFC bpf-next v1 3/8] bpf, x86: no_caller_saved_registers for
 bpf_get_smp_processor_id()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Puranjay Mohan <puranjay@kernel.org>, Andrii Nakryiko
	 <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev,  jose.marchesi@oracle.com, puranjay12@gmail.com
Date: Thu, 04 Jul 2024 10:00:08 -0700
In-Reply-To: <mb61ped8ak95g.fsf@kernel.org>
References: <20240629094733.3863850-1-eddyz87@gmail.com>
	 <20240629094733.3863850-4-eddyz87@gmail.com>
	 <CAEf4BzangPmSY3thz6MW5rMzcA+eOgjD4QNfg2b594u8Qx-45A@mail.gmail.com>
	 <ab7694e6802ddab1ea49994663ca787e98aa25a1.camel@gmail.com>
	 <CAEf4Bza7nmnFDvuPLU2xRQ-mZifUKLSiq3ZuE91MCaPoTqtBXw@mail.gmail.com>
	 <mb61ped8ak95g.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-07-03 at 11:27 +0000, Puranjay Mohan wrote:

[...]

> The correct way to do this would be to change call_csr_mask() to have:
>=20
> verifier_inlines_helper_call(env, insn->imm) || bpf_jit_inlines_helper_ca=
ll(insn->imm)

Hi Puranjay,

I've added bpf_jit_inlines_helper_call() logic in RFC v2 [1].
If you have a riscv setup at hand, would it be possible to ask you to
run test case 'verifier_nocsr/canary_arm64_riscv64' on it?
I verified that it works for arm64 in [2,3] but it would be nice to
have it checked on riscv, which is currently not a part of the CI.

Thanks,
Eduard

[1] https://lore.kernel.org/bpf/20240704102402.1644916-1-eddyz87@gmail.com/
[2] https://github.com/kernel-patches/bpf/actions/runs/9792217835/job/27037=
905408?pr=3D7274
[3] https://productionresultssa19.blob.core.windows.net/actions-results/6fb=
742ca-e78f-420e-9f1c-66e1e23365ef/workflow-job-run-0caa83a1-3221-5ca7-0e7d-=
7eb42ae68938/logs/job/job-logs.txt?rsct=3Dtext%2Fplain&se=3D2024-07-04T10%3=
A32%3A00Z&sig=3Dgb0wAZ%2FPMOfZwCCtJyTqAogIyKZ%2F3lCZCfPUpMdN8rE%3D&ske=3D20=
24-07-04T18%3A36%3A08Z&skoid=3Dca7593d4-ee42-46cd-af88-8b886a2f84eb&sks=3Db=
&skt=3D2024-07-04T06%3A36%3A08Z&sktid=3D398a6654-997b-47e9-b12b-9515b896b4d=
e&skv=3D2023-11-03&sp=3Dr&spr=3Dhttps&sr=3Db&st=3D2024-07-04T10%3A21%3A55Z&=
sv=3D2023-11-03

