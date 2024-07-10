Return-Path: <bpf+bounces-34376-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E8792CE83
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 11:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0190E1F24E18
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 09:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00CB18FA12;
	Wed, 10 Jul 2024 09:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oxl/s9cS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2FC18EFCC
	for <bpf@vger.kernel.org>; Wed, 10 Jul 2024 09:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720604803; cv=none; b=qt5oRXG7MigANrINNisTfZmSPWBlV9u1gz5vxsmr3RVVEnsa0WhYqbhNpxiJwOxo0VQdDH/Fq5Vz4UyH5xmVWP0ypYLmO3LS61E4xi1qD61RcM37++GOgWOuufojPfaB8Mkv79fqBL5wW62aRmWase87635aRU1dpiX2RcBocvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720604803; c=relaxed/simple;
	bh=TQeN/K8tHSnlxNqRKNIJj7AIwQjE4gyPzvc6RYQdYbA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DzGa8xIXDEmrISB7ZDXqJuKsvUWgxl20e9DVyTLlCtxvvMaUpnab4xuzaJYLEriy+DaMLSGtQWk5eO2Bg/pGCiU6hOJnX9SDtDkdC3dsF/iXp0AIeFI1+5nKbkmmM3LxHVuNLKLUnJu66sZPZG7yVR3ND+fbMERsK5NTpSqgYyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oxl/s9cS; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f65a3abd01so43293345ad.3
        for <bpf@vger.kernel.org>; Wed, 10 Jul 2024 02:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720604801; x=1721209601; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eSE3wDqulFgObcRB5NgGZrsM8izcX2Z0N+55mRKuxx4=;
        b=Oxl/s9cSVqYc5Sqi4jzheT1EAA4+RpLej59mm1gW7nMaSDdNzMMLq0jcDdidS/zR4B
         wQ7/TRZORinGtH3S0DIiDKEXtq+BwiNK7XlYpNdquH1642yvRAU+26B0RzsCFm1Ue/6I
         gF0uRZRwN8DsE+Fjl54v1GwKIxZ7FbI1otxGkPhXzCfZyGX62VsiCXNUG/poM720Zlw2
         6Cg/VvC2mF9lLGztQ2msEO9vl4KioqWe3xdh8UvRI79vGE1FtxgkgYwIVki2tJYSR8mt
         piw2YETt71VKfEzeBN5ugtdhR8yK50wsY02ja9RrIDyVx3D7z5BanAKlJWAWbz8BDoSa
         37PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720604801; x=1721209601;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eSE3wDqulFgObcRB5NgGZrsM8izcX2Z0N+55mRKuxx4=;
        b=mRU+buc99S4vg4Qb4MnZeVo/SZs0Uu3LQYb1lMUTfVvHp6OthmeqKjuDnUFXfMNc/B
         cAg/d2dWqLlN+f61+v1vz0tCH69UKdWVLHmK7hJ0eGJO/LjRw6TRLt4gShdlG70NMtEG
         KYQTsBsAGDnGtQBg+Kni/V6Cenl8LHS5otH0jlbVqtpvBRmWNDgoK7vA2Dvc8QDTrmES
         oesBHxYmheIAD1/UyBfAze/fB/s7HOPqy03qsbEjGI/cSFIX3wrahbIkQL51/6338QOI
         FakJsDXXyytjdCT8EaCdVbo0ID78DWhKFAXKgxQKsH5+/nKBGDW32Oxn5lNFJdfSn9d2
         Vgtw==
X-Gm-Message-State: AOJu0Yx2TVP1TqTs+zp+HQd2AwRJ9ZbarAaP775fbhZ30aWJS4/uGrlx
	yacDe4z3YOIyGSQwXSlq1YFleN76OgZuE20d/32WJFmlYpSqbbhT
X-Google-Smtp-Source: AGHT+IGDCyCr3eXmon8Mmja94871ugShsPm9WOtcPwFQ0KFlnSLpPHFNb9vNHpvdkx2ZEN1kbWAvjA==
X-Received: by 2002:a17:902:d50a:b0:1fb:7e03:42e4 with SMTP id d9443c01a7336-1fbb6f14167mr44671405ad.69.1720604801156;
        Wed, 10 Jul 2024 02:46:41 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6a12223sm29748835ad.33.2024.07.10.02.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 02:46:40 -0700 (PDT)
Message-ID: <e11a67d2f4181eb31a4e7e10333b237715a975cb.camel@gmail.com>
Subject: Re: [RFC bpf-next v2 2/9] bpf: no_caller_saved_registers attribute
 for helper calls
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev,  puranjay@kernel.org, jose.marchesi@oracle.com,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 10 Jul 2024 02:46:35 -0700
In-Reply-To: <CAEf4BzaC--u8egj_JXrR4VoedeFdX3W=sKZt1aO9+ed44tQxWw@mail.gmail.com>
References: <20240704102402.1644916-1-eddyz87@gmail.com>
	 <20240704102402.1644916-3-eddyz87@gmail.com>
	 <CAEf4BzaC--u8egj_JXrR4VoedeFdX3W=sKZt1aO9+ed44tQxWw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-07-09 at 16:42 -0700, Andrii Nakryiko wrote:

[...]

> > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.=
h
> > index 2b54e25d2364..735ae0901b3d 100644
> > --- a/include/linux/bpf_verifier.h
> > +++ b/include/linux/bpf_verifier.h
> > @@ -585,6 +585,15 @@ struct bpf_insn_aux_data {
> >          * accepts callback function as a parameter.
> >          */
> >         bool calls_callback;
> > +       /* true if STX or LDX instruction is a part of a spill/fill
> > +        * pattern for a no_caller_saved_registers call.
> > +        */
> > +       u8 nocsr_pattern:1;
> > +       /* for CALL instructions, a number of spill/fill pairs in the
> > +        * no_caller_saved_registers pattern.
> > +        */
> > +       u8 nocsr_spills_num:3;
>=20
> despite bitfields this will extend bpf_insn_aux_data by 8 bytes. there
> are 2 bytes of padding after alu_state, let's put this there.
>=20
> And let's not add bitfields unless absolutely necessary (this can be
> always done later).

Unfortunately the bitfields are still necessary, here is pahole output
after moving fields and removing bitfields:

struct bpf_insn_aux_data {
	...
	u8                         alu_state;            /*    62     1 */
	u8                         nocsr_pattern;        /*    63     1 */
	/* --- cacheline 1 boundary (64 bytes) --- */
	u8                         nocsr_spills_num;     /*    64     1 */

	/* XXX 3 bytes hole, try to pack */

	unsigned int               orig_idx;             /*    68     4 */
	...

	/* size: 80, cachelines: 2, members: 20 */
	/* sum members: 73, holes: 1, sum holes: 3 */
	/* padding: 4 */
	/* last cacheline: 16 bytes */
};

While with bitfields:

        /* size: 72, cachelines: 2, members: 20 */

[...]

