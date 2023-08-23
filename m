Return-Path: <bpf+bounces-8403-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8905785F70
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 20:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A16AB280DEA
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 18:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DDFB1F93A;
	Wed, 23 Aug 2023 18:17:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0221F186;
	Wed, 23 Aug 2023 18:17:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0A21C4167D;
	Wed, 23 Aug 2023 18:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692814628;
	bh=oVc34mgV3FCHCFRuWZIFh7s3iqRrh+uYOxu0gKgphbc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=gbl8Ho+OIJFBCVGkffy0ZCht+2m9HlRKIBb+duA+VU3Ht+iJBwRrlDv1vyAcArPps
	 Zt+17ndNPH54GvaNh/oBz8tlBp/nZAKHignXtbUKnNPqEXWmn3dDwp8IdgFhJ8dzMa
	 HwHKIDXMJ/uqCIpdB9JTLjEwfbPOPgvWn/4EcmIItoiStt0TL5MgXoTiF6XzgsTZc5
	 bigYmUMs41UnYcr88jWVP9DxRfX06OOqGxR7uKaYnhAJ8+iFtBDDtMzniXIGA81gaS
	 OOFuFsMwDe2Y85oXpD1Z0ZR1GWeBrnQWqGy7cpsInsjF3Jm7lgOBAmuPeCPpGKTTQI
	 BQMCMes+TQKog==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Pu Lehui <pulehui@huaweicloud.com>, linux-riscv@lists.infradead.org,
 bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Yonghong Song <yhs@fb.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri
 Olsa <jolsa@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Xu Kuohai
 <xukuohai@huawei.com>, Puranjay Mohan <puranjay12@gmail.com>, Pu Lehui
 <pulehui@huawei.com>, Pu Lehui <pulehui@huaweicloud.com>
Subject: Re: [PATCH bpf-next 2/7] riscv, bpf: Support sign-extension load insns
In-Reply-To: <20230823231059.3363698-3-pulehui@huaweicloud.com>
References: <20230823231059.3363698-1-pulehui@huaweicloud.com>
 <20230823231059.3363698-3-pulehui@huaweicloud.com>
Date: Wed, 23 Aug 2023 20:17:05 +0200
Message-ID: <87h6oplj32.fsf@all.your.base.are.belong.to.us>
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
> Add Support sign-extension load instructions for RV64.
>
> Signed-off-by: Pu Lehui <pulehui@huawei.com>

Acked-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>

