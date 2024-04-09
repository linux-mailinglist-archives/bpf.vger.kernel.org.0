Return-Path: <bpf+bounces-26292-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3DA89DC62
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 16:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FA151F21FD0
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 14:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DBA12C695;
	Tue,  9 Apr 2024 14:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fTqRHZKT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6032D2208F;
	Tue,  9 Apr 2024 14:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712673293; cv=none; b=c/a/KG3mouQ1TFy5I3jj+0Q5PbU+zP5glBdT48tHcbHj+ZqaEnEGpHL90dn6TF7qsgf4i1kQtvsCm+39F5Qcn81yniOSImoTpX2PDkLyST8QGdCf+oC/le0JGrAmtCUv+9RqSGI52NUpqxFheRey4jHSP4IZjrg7b9CgWIsXthQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712673293; c=relaxed/simple;
	bh=NPKgKc41FUGhCXtEXqRlUcv4fxp8bMgPLJzLUP5KJxM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T2RfTqq6O7r8ct3xast85t/9pHfWE2/3et2M3vfha8Mgxed/EHHwElOP8PIBUCBPyXGXn4UVfJqzWefFSyQZ2QcElVfXakYTVmvzOx8zg3vnJVqMI89l1IG6siU/R0jMLWDT5dOhoGOuIhOttsD8aqOzz29PKWK5owcGEOd24Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fTqRHZKT; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-516c403cc46so10523756e87.3;
        Tue, 09 Apr 2024 07:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712673289; x=1713278089; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yVnhV40uctUI3GDpyy2rpavAmIoZFoXOQnbEiQe9kbM=;
        b=fTqRHZKTVMR4QWxbghfokoqb04NfE8Z/uQV9a0ZMwVo8P64ph5WhdaT+q24o5pUcAy
         RWKZe/wt7F/X3mnIhI1YiuNKwWuwS2B/QqKQhmQPsaA4qThxXbAZE3hBrhhPt/+jqOAo
         Mb4FZej4Sm/kgXlHDWn7eBMLU2OQudfeAMLQnddVEiFmcbPR0Xuo/gldeAqsCNEdl/CK
         kaD+5ZQplzJ3xe8NqdKRQXWZV9K6U5aSPqEifVO/0oqNqFvurOtDPtZ6QVxkUksZkhNv
         nql7YOojGW+2HQS6IYnENablctT++NN20y8WUSdy5AbKwuQ8NvJ5cF9CqsPmGfrWdezT
         FuRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712673289; x=1713278089;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yVnhV40uctUI3GDpyy2rpavAmIoZFoXOQnbEiQe9kbM=;
        b=r+meUlRz7W3fqsqngX9bTbJryuRIHa53xModXZGA24PCuMCo9pQ3RgvuUGBjTvJJn0
         uhfVkKhffiuM3irjdag8azJ8O1ZozTevdbC5USnl7C6NJlbYQt5qmq7N+HMYvaSc9VvZ
         yBGlFbj0U1CCAGV77qtWonVPnZUH0zDe+72pxhmeTZac7a3S7J7y3SRxgy6a6J0KzQ8P
         s/jPsAFl47M0rOW0VmqvQmVterRpzihZKJezsFWdxtMRotvg3NISgxktqzCm5MpupePm
         CO3+5ZUrALrmmXXGALwPo06eDMBWy50Go51piDsdIpzFCmAVmSUvqNTNFyhmSEyTVlkm
         vcyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZY/wvFW8Fw8hrlH0YBfOalwJYtcm34xN5NQ7gT+W//ECb4W8mzYKC4TIzIOuf+N3J9zB97iq+BmCya9Ls4cBcxIwpgEQdw9xIlFXTyx6xGMoy5l0g6RdY8pI+Qg==
X-Gm-Message-State: AOJu0YxwIAqoOY4fXc95QYF2Us8vvYYDAMPegNyeocNvS6T3WrIWxQLR
	VpKxuDm5iHFl/+UL6y3WpgQFA3zrkenr1EhB9dl4g7LVPnOI6sCY
X-Google-Smtp-Source: AGHT+IE0lL2nzEgKMlULrTQW6Sxr4d1a1rBDE5Nqpt/WGZ9BLbDcdacikChaeR5CDxMvjqUSlyOTAw==
X-Received: by 2002:a19:6a0b:0:b0:515:acda:77f0 with SMTP id u11-20020a196a0b000000b00515acda77f0mr10813682lfu.29.1712673289121;
        Tue, 09 Apr 2024 07:34:49 -0700 (PDT)
Received: from [192.168.100.206] ([89.28.99.140])
        by smtp.gmail.com with ESMTPSA id va12-20020a17090711cc00b00a4eeb5ff4ddsm5745833ejb.152.2024.04.09.07.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 07:34:48 -0700 (PDT)
Message-ID: <db6480e9378f59c367b03f7455372caf7b593348.camel@gmail.com>
Subject: Re: [RFC/PATCHES 00/12] pahole: Reproducible parallel DWARF
 loading/serial BTF encoding
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>, Arnaldo Carvalho de Melo
	 <acme@kernel.org>, dwarves@vger.kernel.org
Cc: Jiri Olsa <jolsa@kernel.org>, Clark Williams <williams@redhat.com>, Kate
 Carcia <kcarcia@redhat.com>, bpf@vger.kernel.org, Kui-Feng Lee
 <kuifeng@fb.com>, Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Date: Tue, 09 Apr 2024 17:34:46 +0300
In-Reply-To: <64bfcf02-030d-471a-871a-e7490d74ca28@oracle.com>
References: <20240402193945.17327-1-acme@kernel.org>
	 <747816d2edd61a075d200ffa5da680d2cc2d6854.camel@gmail.com>
	 <64bfcf02-030d-471a-871a-e7490d74ca28@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-04-04 at 09:05 +0100, Alan Maguire wrote:
[...]

> Could that be the handling of functions with same name, inconsistent
> prototypes? We leave them out deliberately (see
> btf_encoder__add_saved_funcs().
>=20
> > I'll try to figure out the reason for slowdown tomorrow.
> >=20
> > [1] https://github.com/eddyz87/dwarves/tree/sort-btf
> >=20

Fwiw, the best I can do is here:
https://github.com/eddyz87/dwarves/tree/sort-btf

It adds total ordering to BTF types using kind, kflag, vlen, name etc prope=
rties,
and rebuilds final BTF to follow this order. Here are the measurements:

$ sudo cpupower frequency-set --min 3Ghz --max 3Ghz
$ nice -n18 perf stat -r50 pahole --reproducible_build -j --btf_encode_deta=
ched=3D/dev/null vmlinux
           ...
           3.08648 +- 0.00813 seconds time elapsed  ( +-  0.26% )

$ nice -n18 perf stat -r50 pahole -j --btf_encode_detached=3D/dev/null vmli=
nux
           ...
           3.00785 +- 0.00878 seconds time elapsed  ( +-  0.29% )

Which gives 2.6% total time penalty when reproducible build option is used.
./test_progs tests are passing.

Still, there are a few discrepancies in generated BTFs: some function
prototypes are included twice at random (about 30 IDs added/deleted).
This might be connected to Alan's suggestion and requires
further investigation.

All in all, Arnaldo's approach with CU ordering looks simpler.

Best regards,
Eduard

