Return-Path: <bpf+bounces-62758-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 709A7AFDFBB
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 07:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5A91560F85
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 05:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB00726AA93;
	Wed,  9 Jul 2025 05:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RQLMZFsn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDED191484
	for <bpf@vger.kernel.org>; Wed,  9 Jul 2025 05:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752040720; cv=none; b=TjH2Rw1zqSsVpke0+DeZETu2veznbHPdn3Jzaic5N8HYKa46Kt1915JTCZ9EY7d9+Us3GuWByYzztViz20vtgcJ5D+F19cNoiD/nKaDn/TgLmthxyS5p0MwYlo5L96VkZ3+cuPDKJScw9qy7jbHiyA7ECy9///nEqB0jyqOehnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752040720; c=relaxed/simple;
	bh=3Cix7vFtQoIi5OMEnufuIsW7TBFba/ZvTky7PcNbdsw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uoKs/gtjHs1w+H/0pPYhSY7cHktl4+QMYQYgZegORikKNyudQmT7muwNCN9+AfwZj5pUwfUBzM53Jl598uxiJHh5/5rGOJqILzTdzL+Om0SMzcaHRU6M7dzvkqk5gRtQAHBYx6iv8Y4QTHNuD9q5D6j+DBNAI88CoEFHH2NEJuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RQLMZFsn; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-748feca4a61so2784696b3a.3
        for <bpf@vger.kernel.org>; Tue, 08 Jul 2025 22:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752040718; x=1752645518; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=w6igvIWKpUn+YbEipW+aNMMD2tc8TCOJUIndk5JgOaI=;
        b=RQLMZFsnPlzBohIaHveeWKRb4m5ipIdRiwVTLJl9M19uLOBQqI2snzEL76jfJ55CNr
         P4yqftM6iHDWm6gmFONB3BfJxVpbWkCLmKq6PFYTV9Omp5xV+fcDGQed05H4J0AAs9u2
         F6dpgOEWIx97dxOWi4prFS86Q23X/uc0/aY3FdapIIIJkoe0WLnUs3kLyAX8aA7n+hAp
         3uzUnUmPd3+p8SsN24wViCiQy2xLs0lT6FCvVKoxZaJJscOsOwBcnOX4M5RqcI8bnAf/
         6PX0C4HS3h/6PZ5NwldHCc7rXdflr/NhniSGqfaiKLS8G9/ZJM+5YNBiZ0HM37L5QMIG
         31/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752040718; x=1752645518;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w6igvIWKpUn+YbEipW+aNMMD2tc8TCOJUIndk5JgOaI=;
        b=SbLWbhirJ0q881oW6Xvf/pE3KVzrv0MaC2r+EbnR4Si0QZM0dl4TfJ9qgB2XtmQ7CZ
         el4VRjQUIXsi/9kA5IlUf2aGAlVBFqgSjekkcZXt9pLFT7eu2aepJaLfZaI9Xl6Y/TpQ
         DAcJ3KkkBTVSxH9B3RPkq7yeDjDgBO89/7uER/81HMEUwSZ1H2KG6v6/4NyEpMgj9n1V
         GvrKRrZPPJwwA8XniFyPiuhRjF/Bsws77k1KG8quwuNdXJzEXaxyKq8CHnbrXEg4u6tW
         jlKmtNGjf8BQlaFERorCz/SQLmDALFuBCCPenQDHxkNJMaeviExdmL6MNygXiEMRZB+O
         HNbw==
X-Forwarded-Encrypted: i=1; AJvYcCXgJ1825KP+h8hJukRz7DW2aA1zX1GBo6xlUQSpDO5xqSE3gTDJQG67Oj3ciJvwYrv498c=@vger.kernel.org
X-Gm-Message-State: AOJu0YymqdjzkeJtZDF4JX64e2Qgn5bSoHf2gBOBrQymlBxdvJzJ/kZw
	watai+MM0RRNTvhzrzGBLceWdAySAKsVv+5Pt/FKbQFPisq1GYQOGc+j
X-Gm-Gg: ASbGnctxqQPl6WjD8eryBjOC2rhek8LfMKG1hN18E5I86CiK7xuBEvBxy0jICnnUbri
	l4VY1++bw+lVKBIysxeTY/+0Y/d+zQomHJ9FJtK4p+jcppCkdDpfmIpedLlzcWoVOXVJmehSo0L
	mPnRNAEt3k0LKwczjnlqsSlvT/LwZNytaqJuR+Qo6PTKx0K90r3eAoV6aWuhf17OMat9nlwCTGi
	FJWoX7obtBbLok9DKpuaA5FV6mY9lrIpSOiWFA/lredEN2eFkKQfJcoKvTFhKtyoeOInzrfasiK
	0B3D5YimrP62Z4r8nN7coc4nM0a0DBcsSLftPc+kCZEIxoQ4hm6pFprBjA==
X-Google-Smtp-Source: AGHT+IHKN/fVhlC8tgwAjW4vQpvBmUYAqXy8xk/p+H7JtSFbP5VgJjDmWrS08DB1M2yRpnvXKkOE9w==
X-Received: by 2002:a05:6a00:39a9:b0:736:5f75:4a3b with SMTP id d2e1a72fcca58-74ea6436169mr2199223b3a.7.1752040718240;
        Tue, 08 Jul 2025 22:58:38 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce418f386sm13635459b3a.101.2025.07.08.22.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 22:58:37 -0700 (PDT)
Message-ID: <f90ea7ec00265ab842e373a69f0ffdbb374f7614.camel@gmail.com>
Subject: Re: [RFC bpf-next 8/9] libbpf: support llvm-generated indirect jumps
From: Eduard Zingerman <eddyz87@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf
 <bpf@vger.kernel.org>,  Alexei Starovoitov	 <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Anton Protopopov	 <aspsk@isovalent.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Quentin Monnet	 <qmo@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>
Date: Tue, 08 Jul 2025 22:58:35 -0700
In-Reply-To: <aG3/MWCOwdk5z0mp@mail.gmail.com>
References: <20250615085943.3871208-1-a.s.protopopov@gmail.com>
	 <20250615085943.3871208-9-a.s.protopopov@gmail.com>
	 <CAADnVQKhVyh4WqjUgxYLZwn5VMY6hSMWyLoQPxt4TJG1812DcA@mail.gmail.com>
	 <690335c5969530cb96ed9b968ce7371fb1f0228a.camel@gmail.com>
	 <aG3/MWCOwdk5z0mp@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-07-09 at 05:33 +0000, Anton Protopopov wrote:

[...]

> I think that this is exactly what I had proposed originally in [1],
> so yes, IMO this looks more elegant indeed. (Back then the feedback was
> that this is too esoteric, and instead the verifier should be taught
> to eat what LLVM generates (<<3 and load).) The instruction can be
> extended (SRC and OFF are unused) to support more formats later.

Well, we did a full circle. At-least everybody is on the same page now :)

>=20
> >        3:       gotox r1
> >                 0000000000000038:  R_BPF_64_64  .BPF.JT.0.0
>=20
> How hard is to teach the LLVM to generate this?
>=20
>   [1] https://lpc.events/event/18/contributions/1941/

This seems to work:
https://github.com/eddyz87/llvm-project/tree/separate-jumptables-section.1

Needs some tests and probably can be simplified a bit.

