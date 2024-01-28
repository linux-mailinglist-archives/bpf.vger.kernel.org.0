Return-Path: <bpf+bounces-20524-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6C883F889
	for <lists+bpf@lfdr.de>; Sun, 28 Jan 2024 18:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 268992833F1
	for <lists+bpf@lfdr.de>; Sun, 28 Jan 2024 17:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217FB2D05E;
	Sun, 28 Jan 2024 17:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ws3xH1Mh"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9912E18EA1;
	Sun, 28 Jan 2024 17:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706463047; cv=none; b=SLPdUTJZUqLd2dVS6avIOKm5huw846V0hB4d6b15YKf2JfUAt3erPVtBam7vgqRdSn1PJkIHh4LXYQ80y3bHIir7gwwQO/y5aC1T16/1clqrzFT8NbRYEMbQhtKrfrug150qG5jlZviEPOsNQSG9R/W8chZkUuTgGBmkaQrZg6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706463047; c=relaxed/simple;
	bh=TrcKnw6RTm/SZmRtoNZUPC9uNj6goijl09eHns8H8rQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gvwqZ8TipMrwQFUPOrzRdqBVT+Fkw0uR3kcqOMZCzvUXTVSBndJNqTmN4wG47hAVjZbfZtsg/LGWw8eAFdpBBfEV1zbbr0F6NotBK2OM41QT7PcGwNvJknt2i45TqA+G8EZ/4UyzDeuiJWWKENDKv0qD0S9aJvUeOTqHQ1l6RvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ws3xH1Mh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81C37C433C7;
	Sun, 28 Jan 2024 17:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706463047;
	bh=TrcKnw6RTm/SZmRtoNZUPC9uNj6goijl09eHns8H8rQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Ws3xH1MhFp/9IvryJ1ia30C56JKvXh75sO6NrPcq1aaSx2IvpM4nlgu2l1yk7Vtiv
	 9OQADff1fWuWpGR13UlB/hM6WA/5KLTFp4Ao5xg8ZglfAp6t6xc/AAvjiPdu+dxr2f
	 6l4TtF1+FbqvmHXv6J7VwQrbVl2GC9DXt0btuKamDhChFDG3UrGNryWL3tvcenwr2O
	 2sTw8Oea0PjYacI1EkVdYSSEzZMkAARjPPKxEoIKqIKeJNmwA4KrR8V6ZYrlefOyuU
	 wV4r+RCE2+8JJX1ICM4IThQB7Nt7rLeyO1WvUjamOv9DU3E1SFQ5v19oeqk/pOuyXv
	 RDLQHBxx1O2GA==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Pu Lehui <pulehui@huaweicloud.com>, bpf@vger.kernel.org,
 linux-riscv@lists.infradead.org, netdev@vger.kernel.org
Cc: Song Liu <song@kernel.org>, Puranjay Mohan <puranjay12@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Yonghong Song <yhs@fb.com>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Luke Nelson
 <luke.r.nels@gmail.com>, Pu Lehui <pulehui@huawei.com>, Pu Lehui
 <pulehui@huaweicloud.com>
Subject: Re: [PATCH bpf-next 0/3] Use bpf_prog_pack for RV64 bpf trampoline
In-Reply-To: <20240123103241.2282122-1-pulehui@huaweicloud.com>
References: <20240123103241.2282122-1-pulehui@huaweicloud.com>
Date: Sun, 28 Jan 2024 18:30:44 +0100
Message-ID: <87ttmxcqm3.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Pu Lehui <pulehui@huaweicloud.com> writes:

> We used bpf_prog_pack to aggregate bpf programs into huge page to
> relieve the iTLB pressure on the system. We can apply it to bpf
> trampoline, as Song had been implemented it in core and x86 [0]. This
> patch is going to use bpf_prog_pack to RV64 bpf trampoline. Since Song
> and Puranjay have done a lot of work for bpf_prog_pack on RV64,
> implementing this function will be easy. But one thing to mention is
> that emit_call in RV64 will generate the maximum number of instructions
> during dry run, but during real patching it may be optimized to 1
> instruction due to distance. This is no problem as it does not overflow
> the allocated RO image.
>
> Tests about regular trampoline and struct_ops trampoline have passed, as
> well as "test_verifier" with no failure cases.
>
> Link: https://lore.kernel.org/all/20231206224054.492250-1-song@kernel.org=
 [0]

Tested-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com> #riscv

