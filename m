Return-Path: <bpf+bounces-74113-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C56AC49CC2
	for <lists+bpf@lfdr.de>; Tue, 11 Nov 2025 00:41:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 723804EFCD7
	for <lists+bpf@lfdr.de>; Mon, 10 Nov 2025 23:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC362F7471;
	Mon, 10 Nov 2025 23:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hDZiciJF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93829242D78
	for <bpf@vger.kernel.org>; Mon, 10 Nov 2025 23:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762817997; cv=none; b=RclWFEtmuWRgZfODiLJ+Eu2+9m5jG44BnHWL7tLQm5fyU9Q3dUF7T5kWa4zWPdEZHlTkWC4SJptiMp2Ai4IAn04a33IvGKfJOgHDgfezlKuI2QirX8699QBoPCUuy/HwvNXZogjGd5wfBEZRBwHyTGH/2tYgznk9R8dlErL/b8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762817997; c=relaxed/simple;
	bh=VGhiF/e/EodKVtu0lcUJF+y9EskrHIsom7DTo37U4Mw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PB7uLW+Zugdr6NjGK6tZ9e92/b1Ls5yuyr60qBgl3vAe3JQfG/sLXWbfyFbvPiNFbJowbnzXfh1tvNPMTmdWJk4qb0A5ct2S0wG+HEgI/xFRwUvhMachiQmFQHh108hdeIreCfZZUtc49IGp7KWPd2MipdTWfWJwT0xvaNJd0ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hDZiciJF; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7aa2170adf9so2940719b3a.0
        for <bpf@vger.kernel.org>; Mon, 10 Nov 2025 15:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762817996; x=1763422796; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BHmlnx43/ODOf6o99IDeEmkqXBb0+e6k2QGR4NtXnmc=;
        b=hDZiciJFY7fuOiSSMkVzQv6HAjJEfflBdhIlaE9xo786JcLwjN03SQBYlb+mHhe5kU
         6fyoFXkb+Ff5iLmHBe8YwRokfAZ+PrjPhP9yXJ3gi2qk25eFX/YRH6EGGwXabMp0GRDA
         YuamZCKHPO0nqP4aRi52ZQIi1uUsy+NHARbxe0e4nWuTTgFnBvPx+O9FZUUVbzoSjPr1
         yUe/FJI4aNIQEHiINkUTFL1IgbfYdtJQjKYqe4Z6vtA3g1DXlkf+tTPdmko29wpyb9yq
         W9ltzLLrZHa/AxO+uaZMVosl2+s2glTWVcYcZ0DYJes4LQ3U/c38ZHLXc+8hhpFpeuYU
         oMyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762817996; x=1763422796;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BHmlnx43/ODOf6o99IDeEmkqXBb0+e6k2QGR4NtXnmc=;
        b=Uy/er4azKIDAEVnEhzf37ZATEbcRp8bidcqquqP/glLOH3qsOWHWSf4HVs7x+zLawl
         65DaGpkTr6kURgSK7CbIPX58uFjQiQozPMwynYSxDR9xZ0S3QCy7CgRH95lz6JR6Q6a/
         1WRmQvY6yMC1abpo+QZyW8ES/JqpztXHZ49neqciHPjeYmMKmKnl8uHKhhHTqyxmJrm7
         8ybCFe/ih6kCGPJsMP+8yIsvZ5PZtnjQwDhVYgWOKuFm0P6Lbc8Nf34N6i+MkprZzKzP
         IsfzhPk6/joUfmXwgcGOU0TFTLs8pPBI9NQfZ30tmVmGSDFcTaRfa8QU5Mn0fUcGOUzt
         KE/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUWpEimv0Qkk3QDtEDdFvaHVDRsNeH5guZ8GAaGX64d27XBxocJpjU3xjoNtOmw0CyQU1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQdhmS/h4+hXb8JSLB74h6chwbcZYdKxydlI8rNTgO8QVVxlxW
	deVDjRWY1W9dZ3defLvZJ90qgfOfXTjjKJhE8DjqK+k2bpTQMLceBIbZ
X-Gm-Gg: ASbGncuI8vn/PXCY7QbjF1W0fnXts5a19fO7wqLsD7SfUvhJ4YETcDEZGw4rxMNHV81
	bCipw89WgwXAhxI1O7xig2oIw0OQfi/CiEXztrcPS7UmMO+nAwc79FG7Sm3DFAk6JnMc9DSqWUk
	Dc8OcbRR439Px3zqMNDdGQjOuxTHGHY8TZ6iyIo04YQJzvaqhb6SiZuWY1aLb6fzEUI8SNk6/W8
	31rgmmko43hQomHJkNjxHMCKFYn53LstDlQ4NdOkLzt3sCm+9Dp84zcbVTmiybcLnMyd62QyWRm
	VZrRMgFTNm+YnGNRYQDbA07ocwAN775P5GVt2OO1UWAl2TGz2xPRlxgGeslhtYa2H2FWGBjYKE7
	GCLbECiCVRW+RVni7ymL9gmcApu5os8wKsjzaIlAf4g0yac1A5ZPdejgLs2kIkPMM6AyrsCzu2F
	zLF83cuRCcY5lfLAoAHHYwrb/ksUFUDIxmoHc=
X-Google-Smtp-Source: AGHT+IFxvx8xA9i7tcEfOCfeO/utThr6ilFVT7+WfyYPvjDZgeQPFPnAsFhDHja4Ki83iNASWPgn3g==
X-Received: by 2002:a05:6a20:431b:b0:34e:865e:8a65 with SMTP id adf61e73a8af0-353a3d55ca1mr12354827637.52.1762817995797;
        Mon, 10 Nov 2025 15:39:55 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:5ff:e0da:7503:b2a7? ([2620:10d:c090:500::7:ecb1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0cc179f77sm12873081b3a.34.2025.11.10.15.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 15:39:55 -0800 (PST)
Message-ID: <1f9f885d202005d25d553b525228829a6c1b4dbb.camel@gmail.com>
Subject: Re: [PATCH v4 bpf-next 1/2] bpf: properly verify tail call behavior
From: Eduard Zingerman <eddyz87@gmail.com>
To: Martin Teichmann <martin.teichmann@xfel.eu>, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org
Date: Mon, 10 Nov 2025 15:39:53 -0800
In-Reply-To: <4952b7bf8a0b50352b31bee7ddf89e7809101af6.camel@gmail.com>
References: <998304ddd050ef81ce6281ebb88130e836c07fc3.camel@gmail.com>
		 <20251110151844.3630052-2-martin.teichmann@xfel.eu>
	 <4952b7bf8a0b50352b31bee7ddf89e7809101af6.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-11-10 at 12:28 -0800, Eduard Zingerman wrote:
> On Mon, 2025-11-10 at 16:18 +0100, Martin Teichmann wrote:
>=20
> [...]
>=20
> > diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
> > index a7240013fd9d..54f4772d990c 100644
> > --- a/kernel/bpf/liveness.c
> > +++ b/kernel/bpf/liveness.c
> > @@ -500,6 +500,10 @@ bpf_insn_successors(struct bpf_verifier_env *env, =
u32 idx)
> >  	if (opcode_info->can_jump)
> >  		succ->items[succ->cnt++] =3D idx + bpf_jmp_offset(insn) + 1;
> > =20
> > +	if (unlikely(insn->code =3D=3D (BPF_JMP | BPF_CALL) && insn->src_reg =
=3D=3D 0
> > +		     && insn->imm =3D=3D BPF_FUNC_tail_call))
> > +		succ->items[succ->cnt++] =3D idx;
> > +
> >  	return succ;
> >  }
> > =20
>=20
> Hi Martin,
>=20
> This is a clever hack and I like it, but let's not do that.
> It is going to be a footgun if e.g. someone would use
> bpf_insn_successors() to build intra-procedural CFG.
> Instead, please allocate a jt object for tail calls as in the diff
> attached (on top of your patch-set). Please also extend
> compute_live_registers.c to cover this logic.

clear_insn_aux_data() will also need an update to avoid leaking
env->insn_aux_data[...].jt for tail calls...

> Other than that, I think that patch logic and tests are fine.
>=20
> Thanks,
> Eduard
>=20
> [...]

