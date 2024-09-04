Return-Path: <bpf+bounces-38936-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 646C296C9A1
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 23:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6B5CB22ADD
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 21:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6CD8155A5D;
	Wed,  4 Sep 2024 21:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JQTtIP1S"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055DD1F19A;
	Wed,  4 Sep 2024 21:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725486051; cv=none; b=UxzGV5YNGK0l1g6/1+5xoTZWncJXNl0qlWQxFN67qj6nStITvfa9MpHo1M7S1nZIF1uBi1HNtQoHHkEmxEKPnac/iSyOmK+L7ZW/rTcGVjHsMLE8dIlBobGHR87/iGjgKN9pw06OO/46JMdHBXpiD4eYRHWG1FghDBLMAJNLSos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725486051; c=relaxed/simple;
	bh=3jC+iB8LXk2g+woM5Y9U9me2VFlRvUSz20ui7/n/wZ4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W7hPtezAZRsEjGQHIgXh4cUMGAE9A+okVE1wwrdQlFPwG84zXrAwlyjsKsTLspTB3soUbmw/LR4I/vcffCvr8L1fxOdwZC9pagWpnUA5QwFodvldAqGDZyDV3qxT1w5I/077/maXeZThqrhnX2JuuAEzPzIR4Jsbfs/kwzWsoSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JQTtIP1S; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7141b04e7b5so49437b3a.2;
        Wed, 04 Sep 2024 14:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725486049; x=1726090849; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=C6QnB0bivarKFkHaA1aPrUAuJ4bGbwKRQFPnKJW2rw0=;
        b=JQTtIP1StFcOuFFa59/alZkQ8EEzdzwcRK0Jz2ZJ3soWw6bDCQwnemlsZDZ8gI0v9G
         BHLH2qMAwBcs7PfIKRn1rUCMnBATNTjfpUsNHglIR8C+uZigUybXGqdH0odZOWbdkfC4
         7eXb0hojsLT2zVYgZ54Y3WrK8sJO5A3tTPaOu/qgHAz/bvBtBkvUMWUvKrS+9vaD5tL8
         7OCVDUq9FKk27GWsDSQ5+b+IStaXbo8gAhjhJWdksTiq5qqt/LVwr0ithXR9n9bYjnsI
         +kC7clAIPNHaUHuwnS+b5XerQE8buHgdK6xGNXpIwJvrUZ+P3fT1x3+EsTmqGThybbkM
         0C8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725486049; x=1726090849;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C6QnB0bivarKFkHaA1aPrUAuJ4bGbwKRQFPnKJW2rw0=;
        b=E/hnbDDwIixwHggaR+SEMlc+DU7BWW1gxQhDS63j1wboRwP0/TDy4LATbdUnORtGRY
         T8i7xMGLY4/I1Rj/UrzOV+/umQDppmgYjD4TqMX1+YsYF4mRpIZ/71gnEKpCl4tRqN1L
         O8rBwqjl9HnEkYbdtG9giO9SQc611VewcnFetu9zDBCy65BDO7Hrey1Bxlz2Qc07aEPe
         Uj2wSyHYn++hlbsxeBvOCciTd2//NCVwX0/8Zd/6CW4qeTNXcgz+4h8wRimzSXmIfYZP
         yBqD0Cd/pWmmTw/R9j1NHEfVnNmxvsANIJmonU2xGxrciyrov4n2TZFoLugES59GYwUD
         nycw==
X-Forwarded-Encrypted: i=1; AJvYcCWSUPkyVoXk0Z9kLmadZ061wskVXBApWFnI7So6vig4UWnwGML7hbS/8p0t4nzceVY2M5c=@vger.kernel.org, AJvYcCXYbu+DLOeD+W0/79IzlAjXcA6ESTZF4dflqUdyf8v4gR7jcWCoMnsmjBih2TK4nsdWHacfiFHu@vger.kernel.org
X-Gm-Message-State: AOJu0YxsCTukTyoYcFccrcMvCbogMx4avus1vkaf7JJLCVf9IJHfsKdn
	DjXmbwNaS1DbN09qN4uZULTWls2l/iaO/zhv5shbQwXEKRcr2ADwITTSpF7V
X-Google-Smtp-Source: AGHT+IGlyStJ0g4GAO1ieaJxDs6FlD1BfC4Uze7aD5XcMPDK1viRwnVvH1qfR0BSkioqYCTi1ioWGg==
X-Received: by 2002:a05:6a00:1886:b0:70d:2c8d:bed0 with SMTP id d2e1a72fcca58-715dfc43a62mr26466036b3a.24.1725486048998;
        Wed, 04 Sep 2024 14:40:48 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71787132e34sm667668b3a.137.2024.09.04.14.40.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 14:40:48 -0700 (PDT)
Message-ID: <29983336a7196f3efd220e7bf1ae67703f1bdfbd.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 05/10] selftests/bpf: Support local rootfs
 image for vmtest
From: Eduard Zingerman <eddyz87@gmail.com>
To: Pu Lehui <pulehui@huaweicloud.com>, bpf@vger.kernel.org, 
	linux-riscv@lists.infradead.org, netdev@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 =?ISO-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>, Puranjay Mohan
 <puranjay@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Pu Lehui
 <pulehui@huawei.com>
Date: Wed, 04 Sep 2024 14:40:43 -0700
In-Reply-To: <20240904141951.1139090-6-pulehui@huaweicloud.com>
References: <20240904141951.1139090-1-pulehui@huaweicloud.com>
	 <20240904141951.1139090-6-pulehui@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-09-04 at 14:19 +0000, Pu Lehui wrote:
> From: Pu Lehui <pulehui@huawei.com>
>=20
> Support vmtest to use local rootfs image generated by [0] that is
> consistent with BPF CI. Now we can specify the local rootfs image
> through the `-l` parameter like as follows:
>=20
>   vmtest.sh -l ./libbpf-vmtest-rootfs-2024.08.22-noble-amd64.tar.zst -- .=
/test_progs
>=20
> Meanwhile, some descriptions have been flushed.
>=20
> Link: https://github.com/libbpf/ci/blob/main/rootfs/mkrootfs_debian.sh [0=
]
> Signed-off-by: Pu Lehui <pulehui@huawei.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]


