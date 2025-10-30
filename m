Return-Path: <bpf+bounces-73061-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F09C21B9B
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 19:19:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EB5E64EEB1A
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 18:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D18365D39;
	Thu, 30 Oct 2025 18:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z2Ev4uXC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA951C6FE8
	for <bpf@vger.kernel.org>; Thu, 30 Oct 2025 18:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761848067; cv=none; b=S5xADz9e74HhTnoBkmF5YDCXJ4c+xPomg3wZOsKqdTfRDWuvIZ7JiBR79vOa8in8z691X3Zfcx0JVbedq0TS3r99pmkJelIQK6uQyCPsMn+gyiYTw2Awbi6uFF+jXCkVJL6B9HWX4UgingTWJ+FKY0qNJfsxxkIXr5J70NCI2B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761848067; c=relaxed/simple;
	bh=Vtup7Vk14+3WzvkzparKCp/zUYoI072L/pGdrLo3/pU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HqlvQryalpzfYD+BMPMwMjkFyUSalu58b/M0L7Kr/gEJ7Mvxq1n5tEl+3fNymfwJddOLcHkEdITzbXSFch/zCDb7S4RwWY24J1GsBLPEi9JSiaZOgwljHTkm7g4MRtae7hjgfEE1iu94a9N+ZQINs/mvBcaD43zTRDqRoz/eYIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z2Ev4uXC; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-33ff5149ae8so1245707a91.3
        for <bpf@vger.kernel.org>; Thu, 30 Oct 2025 11:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761848065; x=1762452865; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kcpEkofwlWURd9gB9IDTOn9GwBh/yocoE4wQi5/K1VQ=;
        b=Z2Ev4uXCxelKw61xA5y2y29Ffwy8+8NfyDPq4JF1tVvmAN5j2TIc3YHhCzzLeT/BVs
         6hCOwDKpl0cGtOuFudPv115znA92bwOiqKFm2wUBR8bcNYncwNVZ1Rgcum6C1NsLIn1x
         8XUCfruXBZbIxn6eMB0O6uAS0Y3HZKoai6Hi1jh0R8thOuy4cNOQhzkMEXofHXWhvzzT
         9p3G6/EG300ulSpGKuFCOlGGzW8nXTYOGvhNwjw0htU+mjDDsHva7sPlFcO3IVqJRwwS
         WzopFm6Z16vCfYRBSWJV3wE3WZ2MnOwH+/dgEOK3k6ihkcFdjs5xpYiOX9ei/jZzQT6R
         XqdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761848065; x=1762452865;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kcpEkofwlWURd9gB9IDTOn9GwBh/yocoE4wQi5/K1VQ=;
        b=kfSZ+B9ZGzh8IlbZOjU45vB8n6TPen7fTKWMpKKRZAbxfUR/As5NNizwxmUm3w4R1l
         3GXxwGqkFt7wYbru/6xLHnXDJCNfAqf3zrpfdRq3FycOjuT3RQImChMOel0IyFQ15NYG
         GKkxFsl2cReq7fgRuzdbL6r+m4mmUjuAs3YecmuAuHHVD5CHYzj+kOVSzi7sRCG/iqcg
         3yEMvhwAsOpAg6gYJdnmV1nZKJyevRJptioMkh81EZqAn1lyDGu//y1b6JtovpDWdsm7
         GPCDV6OCOxVoYLDuelkzvunCFKCFU5FFH/UcVIQkp5r/1KXowZY0StCffX3R9+D97SeG
         EIcw==
X-Forwarded-Encrypted: i=1; AJvYcCVctILP6ClU+Lir5VVMxr4Shqn3TNa3cCFoN+2ZqAziLZsXUoPalFtQ3l+k7qlRFauTV2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/ct211HPfX0aLgeWt+4zNXpjcsvhj2aM/eBK1+MHjjLrJIaKm
	GipG6WSELwuPV5Zu+ENcrGw3juyUe6Kul0gdZpdjCixlsoalG2SPobhA
X-Gm-Gg: ASbGncva1bP0wRX8k70JS4EDMpViGwciI2BbY6FXwVZT79OoCrbBKqxYRJv1wni59MQ
	gDEqGXcbSA4jWb6Q+YQFUn+gaeUrRu6nlUOlWyyT0hq4Y9o7eWUheGoQ4bGDyfE7Py3h0GE8oQS
	csLmeR3x4ouDA+O9eRBPkXexEmOLYx6gHKVJsX+rDqCKLlCSP9UBYRpUHFAJcQn5g0gCuKfGXml
	Qwl6BlL/QyTp3HsAaSyA5VTqb9biMtLg9yV6h3iBuFsVKF2P610sIou4C8FwbveV7nNNlb9SEcq
	GiA6DQFQoBikJiGpNf0y3OPaqa67O0l+SiWKrYfdpeLXON0PQbwLsSJTHe7E/MfAx7YhLZGyjR9
	BhKGRNCQyPKqRIYzmI87PwU0auP+XsOE9JvrSIiRwOAlxQV+7wzxlb7/rqPx9w9Q4OjxrWUgg0g
	5cepw8Zczz
X-Google-Smtp-Source: AGHT+IE14aet7qzT0MVooGUS0zry3BxwljbWZ3dPTpldPTUIieCUHsztTs1rJTFWIdJGB0m/xmNXiA==
X-Received: by 2002:a17:90b:3c06:b0:330:7ff5:2c58 with SMTP id 98e67ed59e1d1-34082fc413dmr1080122a91.7.1761848064840;
        Thu, 30 Oct 2025 11:14:24 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b92f01355f1sm60016a12.9.2025.10.30.11.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 11:14:24 -0700 (PDT)
Message-ID: <6e0b67d02cf7243b01a163589b3b58d1e4a0fdd8.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 0/8] bpf: magic kernel functions
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, bpf@vger.kernel.org, 
	andrii@kernel.org, ast@kernel.org
Cc: dwarves@vger.kernel.org, alan.maguire@oracle.com, acme@kernel.org, 
	tj@kernel.org, kernel-team@meta.com
Date: Thu, 30 Oct 2025 11:14:21 -0700
In-Reply-To: <99115d79a7808ca1290726561e36b64ec56e2a1e.camel@gmail.com>
References: <20251029190113.3323406-1-ihor.solodrai@linux.dev>
		 <50ddff79d33d6e2d57e104f610273d647530ddbc.camel@gmail.com>
	 <99115d79a7808ca1290726561e36b64ec56e2a1e.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-10-29 at 23:11 -0700, Eduard Zingerman wrote:
> On Wed, 2025-10-29 at 17:44 -0700, Eduard Zingerman wrote:
> > On Wed, 2025-10-29 at 12:01 -0700, Ihor Solodrai wrote:
> >=20
> > Do we break compatibility with old pahole versions after this
> > patch-set? Old paholes won't synthesize the _impl kfuncs, so:
> > - binary compatibility between new-kernel/old-pahole + old-bpf
> > =C2=A0 will be broken, as there would be no _impl kfuncs;
> > - new-kernel/old-pahole + new-bpf won't work either, as kernel will
> > be
> > =C2=A0 unable to find non-_impl function names for existing kfuncs.
> >=20
> > [...]
>=20
> Point being, if we are going to break backwards compatibility the
> following things need an update:
> - Documentation/process/changes.rst
>   minimal pahole version has to be bumped
> - scripts/Makefile.btf
>   All the different flags and options for different pahole
>   versions can be dropped.
>=20
> ---
>=20
> On the other hand, I'm not sure this useful but relatively obscure
> feature grants such a compatibility break. Some time ago Ihor
> advocated for just having two functions in the kernel, so that BTF
> will be generated for both. And I think that someone suggested putting
> the fake function to a discard-able section.
> This way the whole thing can be done in kernel only.
> E.g. it will look like so:
>=20
>   __bpf_kfunc void btf_foo_impl(struct bpf_prog_aux p__implicit)
>   { /* real impl here */ }
>=20
>   __bpf_kfunc_proto void btf_foo(void) {}
>=20
> Assuming that __bpf_kfunc_proto hides all the necessary attributes.
> Not much boilerplate, and a tad easier to understand where second
> prototype comes from, no need to read pahole.

Scheme discussed off-list for new functions with __implicit args:
- kernel source code:

    __bpf_kfunc void foo(struct bpf_prog_aux p__implicit)
	BTF_ID_FLAGS(foo, KF_IMPLICIT_ARGS)

- pahole:
  - renames foo to foo_impl
  - adds bpf-side definition for 'foo' w/o implicit args
  vmlinux btf:

    __bpf_kfunc void foo_impl(struct bpf_prog_aux p__implicit);
    void foo(void);

- resolve_btfids puts the 'foo' (the one w/o implicit args) id to all
  id lists (no changes needed for this, follows from pahole changes);
- verifier.c:add_kfunc_call()
  - Sees the id of 'foo' and kfunc flags with KF_IMPLICIT_ARGS
  - Replaces the id with id of 'foo_impl'.

This will break the following scenario:
- new kfunc is added with __implicit arg
- kernel is built with old pahole
- vmlinux.h is generated for such kernel
- bpf program is compiled against such vmlinux.h
- attempt to run such program on a new kernel compiled with new pahole
  will fail.

Andrei and Alexei deemed this acceptable.

