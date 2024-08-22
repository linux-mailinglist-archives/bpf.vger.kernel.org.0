Return-Path: <bpf+bounces-37820-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF88A95ACA1
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 06:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27258B220E7
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 04:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDF03B192;
	Thu, 22 Aug 2024 04:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hTCRweAf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BC61CAA6
	for <bpf@vger.kernel.org>; Thu, 22 Aug 2024 04:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724301571; cv=none; b=s3yMsocU1QH0m+LotUKK4w80aDTBjPnqUoqREOIVHM26UoIO6RzSczMw4BceIiwlxdW8Kz3bA2D0LH6XVe3wXzK5N96vjMjTwhuoDai7esCfDVH5hvIfPZw/PGN85KK8i076a2VAhy6ws4yxV/LcOR15dQJTNX+XmPoRFItLQFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724301571; c=relaxed/simple;
	bh=6Gflp2SoAzIWo8R30GH5ivXe0GY5RkQJbnpaNylFoOE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ntENKB0KTMUsl5rPLZ8jsQvPGcidBuvDMI6ZQPhDx1Smw/4ohER3wWbEyjRT8r/AzgPlIR7ERtQSS/NhD4TXyAIsAf77Ujxw2g8JgRKggm5XUPvRJW1Yl3xg0LAMI24CtwVtaXumDfyES2ngG4gMeakGSV7De34tM+0gILHFsf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hTCRweAf; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-70943b07c2cso268152a34.1
        for <bpf@vger.kernel.org>; Wed, 21 Aug 2024 21:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724301569; x=1724906369; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=toB0bpQdHL2MIfqFCcixUYrx89Y6SXM1/Ydy+yE8YKs=;
        b=hTCRweAfYgN1Wrtuq3PyqADySDJoKDZYZ03LL96wcJgDgJZRHnTeRf5oD5ayS80BZY
         A9+9hgF+ZnwknEKTwGXAEc7Zh/w6WEaLBt6BKTb1EeKo7NxsOl/nPRXla7XtwS5CsHi9
         /NFseZXEEx+EHjTtlrI7mWYmHmcnhmBNhzdEQLIWmFgneIOznhc7m3/x8DXPYD1/lW+c
         I1cAPzlkPGfN6KZFuw6oo38O3PWGVlR9TpCIngxZMZle8eI1cYPeG+6BIeMxugmb1sDp
         s0Zr0RIaxe9t86NxNZC6HDe6bZWyoqlBwylGmCb+zt4BV1AZZo/+KxDQlOh3YaIhSww8
         geOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724301569; x=1724906369;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=toB0bpQdHL2MIfqFCcixUYrx89Y6SXM1/Ydy+yE8YKs=;
        b=O9z/G6beiCyVti0AWjXcnah75lpRaLo8v1izm+o6N5tiMLmth7xr0QAgh6dV+UluHv
         EpmfR6hRPl4QJtPQ4XRSqopdHxun2t/CIxaYUpb8JBYIDLzLPL6dODLQhITFZ+FzekhC
         XtpRpUKn3Y4F0RIRNAS/p2eX11Y8tVPdZzEbkMrg0Hh7s9ATzlElepf4w674HFEfFGbv
         5v4X2woKB+RKOSpJ1yR9jdmj9NGwlMtaa9UXGsE7qmg/D0/HLQy7723BVPCl/zZIpclL
         32mHaSCb1O0U4bdo7fbXVCa8hHOs6jpjm/4OqGJklv5P55vUWM93qNMzbvZ2MzG7yaKA
         scPg==
X-Gm-Message-State: AOJu0YyLbOru9K7ARGLcYcBjNDqdl1l/5+NCmvU/bn0VO/28ZkQUSW4U
	7W1o9s/7a0lYU7GTZAP2D36AnGpYk0iXe8E193LQ2EpKsKW/d/Us
X-Google-Smtp-Source: AGHT+IFBiWYCqVlNq7GBXOAnWZc1/aOYSfiiOLwn/xhRDYKo7CeXGkPPR46k88mNB/caOZBOSj/EIQ==
X-Received: by 2002:a05:6830:418b:b0:709:3585:fd7e with SMTP id 46e09a7af769-70e046c8147mr950878a34.12.1724301569455;
        Wed, 21 Aug 2024 21:39:29 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d5eba23554sm2859374a91.25.2024.08.21.21.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 21:39:29 -0700 (PDT)
Message-ID: <b058840690d79648405839c2af767a783a41bef8.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: test for malformed
 BPF_CORE_TYPE_ID_LOCAL relocation
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev,  cnitlrt@gmail.com
Date: Wed, 21 Aug 2024 21:39:24 -0700
In-Reply-To: <CAEf4BzaVjrHSi9eh9-YP37tsH2B5n0ah3m290Y7_v6zBXrEBiw@mail.gmail.com>
References: <20240822001837.2715909-1-eddyz87@gmail.com>
	 <20240822001837.2715909-3-eddyz87@gmail.com>
	 <CAEf4BzaVjrHSi9eh9-YP37tsH2B5n0ah3m290Y7_v6zBXrEBiw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-08-21 at 21:29 -0700, Andrii Nakryiko wrote:

[...]

> > +       btf_fd =3D bpf_btf_load(&raw_btf, sizeof(raw_btf), &opts);
> > +       saved_errno =3D errno;
> > +       if (btf_fd < 0 || env.verbosity > VERBOSE_NORMAL) {
> > +               printf("-------- BTF load log start --------\n");
> > +               printf("%s", log);
> > +               printf("-------- BTF load log end ----------\n");
> > +       }
> > +       if (btf_fd < 0) {
> > +               PRINT_FAIL("bpf_btf_load() failed, errno=3D%d\n", saved=
_errno);
> > +               return;
> > +       }
> > +
> > +       memset(log, 0, sizeof(log));
>=20
> generally speaking there is no need to memset log buffer (maybe just a
> first byte, to be safe)

Will change.

> on the other hand, just `union bpf_attr attr =3D {};` is breakage
> waiting to happen, I'd do memset(0) on that, we did run into problems
> with that before (I believe it was systemd)

Compilers optimize out 'smth =3D {}' where 'smth' escapes?
I mean, I will change it to memset(0), but the fact that you observed
such behaviour is disturbing beyond limit...

I already run into gcc vs clang behaviour differences for the first
iteration of this test where I had:

    union bpf_attr {
	.prog_type =3D ...
    };

clang did not zero out all members of the union, while gcc did.

> > +       attr.prog_btf_fd =3D btf_fd;
> > +       attr.prog_type =3D BPF_TRACE_RAW_TP;
> > +       attr.license =3D (__u64)"GPL";
> > +       attr.insns =3D (__u64)&insns;
> > +       attr.insn_cnt =3D sizeof(insns) / sizeof(*insns);
> > +       attr.log_buf =3D (__u64)log;
> > +       attr.log_size =3D sizeof(log);
> > +       attr.log_level =3D log_level;
> > +       attr.func_info =3D (__u64)funcs;
> > +       attr.func_info_cnt =3D sizeof(funcs) / sizeof(*funcs);
> > +       attr.func_info_rec_size =3D sizeof(*funcs);
> > +       attr.core_relos =3D (__u64)relos;
> > +       attr.core_relo_cnt =3D sizeof(relos) / sizeof(*relos);
> > +       attr.core_relo_rec_size =3D sizeof(*relos);
>=20
> I was wondering for a bit why you didn't just use bpf_prog_load(), and
> it seems like it's due to core_relos fields?

Yes, it is in commit message :)

> I don't see why we can't extend the bpf_prog_load() API to allow to
> specify those. (would allow to avoid open-coding this whole bpf_attr
> business, but it's fine as is as well)

Maybe extend API as a followup?
The test won't change much, just options instead of bpf_attr.

[...]


