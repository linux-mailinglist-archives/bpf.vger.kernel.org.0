Return-Path: <bpf+bounces-8405-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC32A785F7F
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 20:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66D52281365
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 18:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B6F1F942;
	Wed, 23 Aug 2023 18:23:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A811F92D;
	Wed, 23 Aug 2023 18:23:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7909C433C7;
	Wed, 23 Aug 2023 18:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692815002;
	bh=WzID2EzMEfCohyHPts0WT9PJhyOAL8gtNo0yNFo222k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=nHi74GSArPCX6tsrvWUvjB6bIqFXo56oNWG46oEQIguTa42473eow8AYx7hdnLvvz
	 6wkMif+2Xs1k9wtF3muFezXeM1aXN/klDkoYhtoFQQrP5Xbs/zzZfNWwZ/0euLBPIP
	 xcYLtreVYPmiG9wOnISvAybxdBXVVv+V+U7t9d3iLJq7fwD7TMr3tNDJH1SUEb8sfR
	 JzJQR6Gp1gOefz5soSbZF+oawVPwPrYVLU7KS7QM9w/kwXeeUDppyXN1N8+W0v6NaQ
	 vt7kh3IuFW5sFg0IfXGj9QBTQ/4oI3EBEl4nTKUlJwGUfLeFAEzUFJ9h5VB/wUN3uo
	 Z20EFbMgkiW2g==
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
Subject: Re: [PATCH bpf-next 5/7] riscv, bpf: Support signed div/mod insns
In-Reply-To: <20230823231059.3363698-6-pulehui@huaweicloud.com>
References: <20230823231059.3363698-1-pulehui@huaweicloud.com>
 <20230823231059.3363698-6-pulehui@huaweicloud.com>
Date: Wed, 23 Aug 2023 20:23:19 +0200
Message-ID: <878ra1liso.fsf@all.your.base.are.belong.to.us>
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
> Add support signed div/mod instructions for RV64.
>
> Signed-off-by: Pu Lehui <pulehui@huawei.com>

Acked-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>

