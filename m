Return-Path: <bpf+bounces-65035-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0271EB1AE6D
	for <lists+bpf@lfdr.de>; Tue,  5 Aug 2025 08:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B61E13A8147
	for <lists+bpf@lfdr.de>; Tue,  5 Aug 2025 06:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9964621930B;
	Tue,  5 Aug 2025 06:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="budyNfZX"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA7EA927;
	Tue,  5 Aug 2025 06:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754375705; cv=none; b=jlyae3W44KJnfeeWg5XrzYvGYmwhTWGg7vxFDr7nARMTqZAOKmXiaMJfFAGsF2vPKG8QNDhjMlYAHAEsjYRWCBEJh1rpVuczXCTKIQLkK79POZmdPIXn4h2aJ72Y8CVM5r3Jb+MrSMHLuKk60FiB4izOq+2ETsfX7wNl1f4gVCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754375705; c=relaxed/simple;
	bh=9mChLtQ6RkKxgwEml2njrUb50R/l++pJ6t2PvzlxK3g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SLf74aMyrTVtOXZyDyANYxPQ7VaV7aj0XEMcJaNIy3JwDxk+zo+mbKqZdClseSHcXECJt1qkH2yftqFg9SnycqJr7dI85P7rAFIBUmIoJpQECZz3uBdhRUk4lWDYlvoUtVLV3Ds0I7ziSNOvtSoq7cf8tjoR/+BwmoKlTDmKX8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=budyNfZX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DF97C4CEF4;
	Tue,  5 Aug 2025 06:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754375704;
	bh=9mChLtQ6RkKxgwEml2njrUb50R/l++pJ6t2PvzlxK3g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=budyNfZXX1lQB0TGDcAYS3o2sdL3imRucp9UOlpAh0usbpU34FwQlpdd5EK3ZxM5Y
	 GSu99OxSh5gTNoPBUi11dEauH8kDw7MMtOCAoimrWFCT9VH3XeMkUaPlEQdmCfCp0A
	 /sxu9YZFAA+6GETSFPh1CW0jgIMSZYLjqjo71wZHIk6/k2bif+DyKa+3shoYNq7hY6
	 A3Pwqs8uUSHTcIwFuLH1ImIpTMIz3HiXO5zpjCKwffs/jIImC/3EGmWeHHAyWf19ol
	 U22sP4i1L11+Wj0LBWBHvkpvJL8Qz9amaDMqCBZVx6WF/IVD0y+3qH2cqYasJIIkpG
	 4dMtN7+rZYm1w==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Pu Lehui <pulehui@huaweicloud.com>, bpf@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, Alexandre Ghiti <alex@ghiti.fr>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard
 Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Pu Lehui
 <pulehui@huawei.com>
Subject: Re: [PATCH bpf-next 09/10] riscv, bpf: Add support arena atomics
 for RV64
In-Reply-To: <20250719091730.2660197-10-pulehui@huaweicloud.com>
References: <20250719091730.2660197-1-pulehui@huaweicloud.com>
 <20250719091730.2660197-10-pulehui@huaweicloud.com>
Date: Tue, 05 Aug 2025 08:35:01 +0200
Message-ID: <87zfce1dka.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Pu Lehui <pulehui@huaweicloud.com> writes:

> From: Pu Lehui <pulehui@huawei.com>
>
> Add arena atomics support for RMW atomics and load-acquire and
> store-release instructions. Non-Zacas cmpxchg is implemented via loop,
> which is not currently supported because it requires more complex
> extable and loop logic.
>
> Signed-off-by: Pu Lehui <pulehui@huawei.com>

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>

