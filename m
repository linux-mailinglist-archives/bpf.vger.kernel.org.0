Return-Path: <bpf+bounces-20479-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C750483EEF1
	for <lists+bpf@lfdr.de>; Sat, 27 Jan 2024 18:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCD5EB21C2A
	for <lists+bpf@lfdr.de>; Sat, 27 Jan 2024 17:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C622C862;
	Sat, 27 Jan 2024 17:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sBhp9zL4"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1888C8821;
	Sat, 27 Jan 2024 17:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706375534; cv=none; b=dVlXCGWCRGo6D6HJbwen23p9PqfPGJZrE9pepd9kX9ya0Tc7TKIfj70WwEDeHJm/uLTG2FpbnJB8tPzPECrD/SxBw9tq2nZDTR3HgwdJBRB2DP46IOEXc3F8oAAPUY13NE9nHKiH+6tRK+GDNKWzwiOosYImyvBiOvLT/jbpZ54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706375534; c=relaxed/simple;
	bh=b44pzMRT2lqcU3tZ0JVh8LrSvIRpLEfGlaoKxD6+4Uw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=s7LU4WwkjAivPU0gbZ9auZaQSNlij6J+mMPRo00q22JxJO7zr1wihlooxXClQm5H4HYFNXrDgq8dsHr6mJiNCHZDCwTrWDO7Sbl6NTDJmIQZgzsB1bpaKTo1cfkEkV7r4cvnUW6p0MLgjPb9oCdmIWo+KW2e7lTAolZumFTMNzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sBhp9zL4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 174FFC433C7;
	Sat, 27 Jan 2024 17:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706375533;
	bh=b44pzMRT2lqcU3tZ0JVh8LrSvIRpLEfGlaoKxD6+4Uw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=sBhp9zL4D3H+pEMUmv5c8q2Tea4f7NY/KQT0zsLS3Z+tppphAmoFuJVQHp7K4MK6m
	 kHSo9gvUmvUPkDrMjf9rTc6gXzxVmHQgc4D+OOxyaBvBA7dyGLEMNeYVZH2scjoGfs
	 2UO5qvLuKUWc57zGMuVvyuF1+KxmGuc1gCjiik+DSizNOlyWekDFXnaLSl/JMzse8P
	 zmDraQzTgRShqSuJs2B/Oi0su+X5VI3Gos+72JhAB7fvKt2p7xjxmdqBBY31w6JkR4
	 jTaiiwxtS1HN+qrVewohUIHR6CV+LIYX2QeMM5IK0s7SIxv2Wvciajw4psMblXnW5z
	 bR2B7f16AoDSw==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Pu Lehui <pulehui@huaweicloud.com>, bpf@vger.kernel.org,
 linux-riscv@lists.infradead.org, netdev@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh
 <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, Conor Dooley <conor@kernel.org>, Luke Nelson
 <luke.r.nels@gmail.com>, Pu Lehui <pulehui@huawei.com>, Pu Lehui
 <pulehui@huaweicloud.com>
Subject: Re: [PATCH RESEND bpf-next v3 0/6] Zbb support and code
 simplification for RV64 JIT
In-Reply-To: <20240115131235.2914289-1-pulehui@huaweicloud.com>
References: <20240115131235.2914289-1-pulehui@huaweicloud.com>
Date: Sat, 27 Jan 2024 18:12:10 +0100
Message-ID: <877cjuzonp.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Pu Lehui <pulehui@huaweicloud.com> writes:

> Add Zbb support [0] to optimize code size and performance of RV64 JIT.
> Meanwhile, adjust the code for unification and simplification. Tests
> test_bpf.ko and test_verifier have passed, as well as the relative
> testcases of test_progs*.

Lehui, apologies for the delay. Nice work! I have a minor comment in
patch 4, but not a blocker...

For the series,

Tested-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
Acked-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>

