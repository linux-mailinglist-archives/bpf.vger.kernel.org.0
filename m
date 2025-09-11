Return-Path: <bpf+bounces-68201-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD269B53E7C
	for <lists+bpf@lfdr.de>; Fri, 12 Sep 2025 00:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 975E1565B88
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 22:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798FC342CBB;
	Thu, 11 Sep 2025 22:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RcIqS0OJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA8A341AC3
	for <bpf@vger.kernel.org>; Thu, 11 Sep 2025 22:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757628477; cv=none; b=rtoFuYCnImkZW3phozI6P/liNiP40/0aWlx096cCpkRK7nu5GGZm+N6KPd82QK6Ki1IHeS/vsKhcCarrdhpXDXjnjw4KwcBclyso9wtW72yrB3Rtv1PnvOBwr2YCq20bdbTQDNlMT66bIy9OFGkwsQeBu6F8U1E9In38C/f6gXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757628477; c=relaxed/simple;
	bh=jtcnfarZA6UzrvRtmWR0Evc6ldU/VzjjNKluiCCXV3g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=giITvBeHDmbDENU4mV/CBwkMRzR2iWnOsFW/2mY/ES5PVW5u+iFzQOtBEAJRqA5jvfJxSr81hRnuAByoQy/Tl+iGkoTA2Q93JFJHIxzFxst3XM3efWNNpxsvmsT3wRrLBl8V6EBRy74NGYpEOBa+Q9QkrE04ygwKLZcN6isZRcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RcIqS0OJ; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b54abd46747so253868a12.0
        for <bpf@vger.kernel.org>; Thu, 11 Sep 2025 15:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757628475; x=1758233275; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PIzLX4YwMmt2w1/Or//9q2o4ZqfSWElSTB34sVpm3Zk=;
        b=RcIqS0OJWA/zGXGSZ3opfgz7ZnjuLk1z6L5EfBZ/E0HBtVz9JGvaae1M9wfZnxImmX
         cEvxCErQbi5oINYrixRQBEUJcmiiDjrJLw9TJXyZExXj1CTXgRvScRhZg8d81tci6b3N
         pqi4eyEpFGzcFyQU8NOZcnA5gHcf0tniNDCRWRePX/5t3aONz2HgAjwnOLrnaOuO4M2T
         SBVWCbkitv3NHGAY4C3icqiUdmmi+vfZ1UqCR983t1ETWj19TpUrtiBBRRzHbRlOSd1Z
         1Qbup5ek6OCF5OErElOgFPnvdf0THJ7l94bOEIjARxfzyWNHdu7kfdcWnMS/E/B1EQ5Q
         q30Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757628475; x=1758233275;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PIzLX4YwMmt2w1/Or//9q2o4ZqfSWElSTB34sVpm3Zk=;
        b=OMKw5QFmK51b6fpBlv/SMhxQtD7uIZMey21h3o5UuWaUU8dlfP/fCYn/Z0s/I4xA+g
         S+/4Q8oYNIc9tQcnUj1XAMiHkqeQyMGHy5uToYAkktLb3VBivgYE/2OhGEK4mSpWSjd4
         rQtR3q0EfPnie5xWYA+pp2npv9y0M5MropR/G7c0o+YAmZfdFaWNu/MPLptOV4jx3oyb
         FbXj5LvKrPR3UwZ4z5tNx/NzP6ALJJOL14BSxUdTcR3tQdk0E9ZopG5QPtV/GQRJeBfE
         2N1O1kqlg7COyoQOx9m1vdRbvfP6jNcf7GvPdh4IxEutiCqu3see8C2/KsnbPKtU3P5L
         I6Ow==
X-Forwarded-Encrypted: i=1; AJvYcCWejLTi2c9gJk9+M1226h6i6I4TQtM6PaxpZenaW2+6giFWW9Dy1q29JnfaGtHASel0W3E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlZu3H/6yQ2BqJebXNQA4bSXngs2gf5cQJunCf3pC93gu9CZBq
	bYqJEvb8hyetRj3v+IZnxeT/iX5o57tsNUrDCkQ2BCgi441XKgBYd/hO
X-Gm-Gg: ASbGncuKRvcvbCHsbCvP0S3e5G9mEEAJfHLDPQCWhCD1OwCkIzyd0T13HpI2uOvH24X
	TdAuUjkn2UvMt2kWL5ShBQBqQrt/cd0rTpex19jXl67hx6X/Q0KXDfJBnIzV+GhStfV3rnkggqK
	/V45ITVWao3y3dtbS5558M9lK9I4U9IiqgqcH5ZdK6ocx4aqVJtJfHq5gdl1hOjTkHz30Zb3m9/
	PeARKt9yejDHB92AWBzL4Yvylpw0HhJQrOYL9SkFpyx/uzXD3r+tRWv3iuGAPqGk7+rx1C6fbin
	8U7DLIpUeH5cAbyizXMaMJ7URkt4+lOqudvzNU30irh0E7cyNAD4qxye031PNBLeEdjmgje1cE8
	3+J8M6g5plQFwX4dj898=
X-Google-Smtp-Source: AGHT+IGfIKtuAcKICp7ZxJp8lOEaeeLF1BaJMcTC3R/RXVkYiy5e+/ccc4815OulQS5TGLefpo1+Zw==
X-Received: by 2002:a05:6a20:3c8f:b0:248:7a71:c25 with SMTP id adf61e73a8af0-2602c71ab31mr890725637.50.1757628474841;
        Thu, 11 Sep 2025 15:07:54 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607a69a8csm3148324b3a.44.2025.09.11.15.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 15:07:54 -0700 (PDT)
Message-ID: <6fd0e1fdf651f0728d1daf4fad3d6e4d4c11d221.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 09/10] bpf: disable and remove registers
 chain based liveness
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: kernel test robot <lkp@intel.com>, bpf <bpf@vger.kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 clang-built-linux <llvm@lists.linux.dev>, 	oe-kbuild-all@lists.linux.dev,
 Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau
 <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>, Yonghong Song	
 <yonghong.song@linux.dev>
Date: Thu, 11 Sep 2025 15:07:51 -0700
In-Reply-To: <CAADnVQKGwghC=+V8u0tSPdkJ1f4usY5LeYUpxnJno=3xW8tYGg@mail.gmail.com>
References: <20250911010437.2779173-10-eddyz87@gmail.com>
	 <202509112112.wkWw6wJW-lkp@intel.com>
	 <c846a153010e40a52e98b8abe9db69f7d4cadd58.camel@gmail.com>
	 <CAADnVQKGwghC=+V8u0tSPdkJ1f4usY5LeYUpxnJno=3xW8tYGg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-09-11 at 15:00 -0700, Alexei Starovoitov wrote:

[...]

> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -19297,9 +19297,12 @@ static int is_state_visited(struct bpf_verifie=
r_env *env, int insn_idx)
> >                          * the precision needs to be propagated back in
> >                          * the current state.
> >                          */
> > -                       if (is_jmp_point(env, env->insn_idx))
> > -                               err =3D err ? : push_jmp_history(env, c=
ur, 0, 0);
> > -                       err =3D err ? : propagate_precision(env, &sl->s=
tate, cur, NULL);
> > +                       if (is_jmp_point(env, env->insn_idx)) {
> > +                               err =3D push_jmp_history(env, cur, 0, 0=
);
> > +                               if (err)
> > +                                       return err;
> > +                       }
> > +                       err =3D propagate_precision(env, &sl->state, cu=
r, NULL);
>=20
> hmm. init err=3D0 instead and avoid explicit if (err)return err ?

Or like that, yes.

