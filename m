Return-Path: <bpf+bounces-8406-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7020C785F85
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 20:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B93C281294
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 18:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD3E1F946;
	Wed, 23 Aug 2023 18:24:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F76F1ED47;
	Wed, 23 Aug 2023 18:24:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81D36C433C8;
	Wed, 23 Aug 2023 18:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692815091;
	bh=Wz+ssdWTwoTiSo2ITnOaFFeZ1XRrz+F/5qzgicEYcis=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=htwvCHPej4Jwnp2UFIBuXIpTeJKk276AumCa8WcFRh4NFFKbauNDVSOpWZC3VBxIl
	 v3n6If3I9FIk/nGZKOfO4IdtpKZ6BxYyUxzAF/vY6w/LExx9uNt30ncKwFMyvMVsmu
	 paeH2C9AMXeRpPfE5YAEjrANcq/0BvLv1rPocJVDJEqny38oz/Z+x6WJVRQh3mHOlh
	 au0NcRUkck+nJnf00QqNJKrZLNs4tZpuFc/161Dsdb1ulHCnW9BLKcnhDfGQnXJzc2
	 oE7d4ZhIL+DoKQsVmoMnjAtvZS/mxW/7IWMim91jFwShUAM2LRNpw7vvpPU2943QWS
	 18mMp4Yydhbpw==
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
Subject: Re: [PATCH bpf-next 6/7] riscv, bpf: Support unconditional bswap insn
In-Reply-To: <20230823231059.3363698-7-pulehui@huaweicloud.com>
References: <20230823231059.3363698-1-pulehui@huaweicloud.com>
 <20230823231059.3363698-7-pulehui@huaweicloud.com>
Date: Wed, 23 Aug 2023 20:24:47 +0200
Message-ID: <875y55liq8.fsf@all.your.base.are.belong.to.us>
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
> Add support unconditional bswap instruction. Since riscv is always
> little-endian, just treat the unconditional scenario the same as
> big-endian conversion.
>
> Signed-off-by: Pu Lehui <pulehui@huawei.com>

Acked-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>

