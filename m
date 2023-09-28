Return-Path: <bpf+bounces-11029-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9FDE7B1875
	for <lists+bpf@lfdr.de>; Thu, 28 Sep 2023 12:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 372F428245D
	for <lists+bpf@lfdr.de>; Thu, 28 Sep 2023 10:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25CB34CCC;
	Thu, 28 Sep 2023 10:44:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6602817F5;
	Thu, 28 Sep 2023 10:44:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41AB9C433C7;
	Thu, 28 Sep 2023 10:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695897861;
	bh=FvmhE1zWN7G0I1REAabVQr+yUPNKpb+BRUhnlZA70m4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=pGUVE5en0exvjekKAMOQnWXPVBsU97kTtTAS0PxYVpySk8PdEzqhSspiONSumjOpg
	 ozkApq+2UPkiSa5V7km9Ay2W6zLXQE6oq4+gHtLgeGrP/e5umP7HIT10yXz8gQrO0I
	 5v18VrJGdBpPOM5iHlp2yAIogcDlDFzA0paoEzu4UorjvXAM96HAKR4PokXNJvP2hQ
	 h+jNwrGBL6OVV4USGMfQP7BDoX5gc6cWWJbchN8tl0aFYVikFUa1/ShAsJHk/6j/pd
	 hOz8MAVGdlks3O9dUQtcdqok/ktvvC8LSrBUV5TJNqddYbwtkUC2lAx2vi7K7gsRqZ
	 og9jKDYKcUc/w==
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
Subject: Re: [PATCH bpf-next v2 0/6] Zbb support and code simplification for
 RV64 JIT
In-Reply-To: <20230919035839.3297328-1-pulehui@huaweicloud.com>
References: <20230919035839.3297328-1-pulehui@huaweicloud.com>
Date: Thu, 28 Sep 2023 12:44:18 +0200
Message-ID: <87h6neo9vh.fsf@all.your.base.are.belong.to.us>
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

Nice work!

Did you measure how the instruction count changed for, say, test_bpf.ko
and test_progs?


Bj=C3=B6rn

