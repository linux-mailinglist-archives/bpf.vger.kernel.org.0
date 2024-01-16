Return-Path: <bpf+bounces-19581-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B0282EB41
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 10:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A798D1F24265
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 09:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240E6125CF;
	Tue, 16 Jan 2024 09:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kyYuLsTk"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77F4125B6;
	Tue, 16 Jan 2024 09:05:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EDB9C433C7;
	Tue, 16 Jan 2024 09:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705395919;
	bh=3wk1068K3TGnKtsD4ebXyJqtioBrDnPmvG2cESe+G+M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=kyYuLsTk+AwGm9v+g6IMhpKFglDFLgAC7I/fQR7W5ZA2o3bwhXXYZJewj6240JCdr
	 SzVp7ogn6Yo+XOwWQfjGeLRikqyioBeMeX4b0hsfDxCkc5dfEhZWcsH2CIz+jtB/zk
	 eVHqC20RFbIVWkYEtythRDb/NA0xlnLaGWL7WK3Qmxf9R3E9h+o39jhuU3NG/KsZkC
	 dv5avLtcXQvsxav4PB6ovovnMQ8aUxsqS7Kslw81HWZIsp9+zRmq7B8LewCGKlZYja
	 vxJp1NHgu9DZYic6fuulRPbkgRlkbk96GarbFafdhH53LiDPt//04kQvZGg03O2AiT
	 QSFSl20zs97nw==
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
 <luke.r.nels@gmail.com>, Pu Lehui <pulehui@huawei.com>
Subject: Re: [PATCH bpf-next v2 0/6] Zbb support and code simplification for
 RV64 JIT
In-Reply-To: <421fcfcd-6be6-4dfc-9948-3b57c7517538@huaweicloud.com>
References: <20230919035839.3297328-1-pulehui@huaweicloud.com>
 <87h6neo9vh.fsf@all.your.base.are.belong.to.us>
 <421fcfcd-6be6-4dfc-9948-3b57c7517538@huaweicloud.com>
Date: Tue, 16 Jan 2024 10:05:13 +0100
Message-ID: <87le8ptzqu.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Pu Lehui <pulehui@huaweicloud.com> writes:

> On 2023/9/28 18:44, Bj=C3=B6rn T=C3=B6pel wrote:
>> Pu Lehui <pulehui@huaweicloud.com> writes:
>>=20
>>> Add Zbb support [0] to optimize code size and performance of RV64 JIT.
>>> Meanwhile, adjust the code for unification and simplification. Tests
>>> test_bpf.ko and test_verifier have passed, as well as the relative
>>> testcases of test_progs*.
>>=20
>> Nice work!
>>=20
>> Did you measure how the instruction count changed for, say, test_bpf.ko
>> and test_progs? >
>
> Sorry for not responding for so long.

Welcome back!

> I made statistics on the number of body instructions and the changes are=
=20
> as follows:
>
> test_progs:
> 1. verifier_movsx: 260 -> 224
> 2. verifier_bswap: 180 -> 56
>
> test_bpf.ko:
> 1. MOVSX: 154 -> 146
> 2. BSWAP: 336 -> 136
>
> We can see that the change in BSWAP is obvious, and the change in MOVSX=20
> is in line with expectations.

Thank you. I'll test/review the v3 during the week!


Cheers,
Bj=C3=B6rn

