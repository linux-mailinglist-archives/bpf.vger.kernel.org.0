Return-Path: <bpf+bounces-8451-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6640E786A71
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 10:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3125281501
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 08:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F50CA77;
	Thu, 24 Aug 2023 08:44:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C42B24544;
	Thu, 24 Aug 2023 08:44:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3449C433C7;
	Thu, 24 Aug 2023 08:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692866689;
	bh=WjEYwIQ+ih0hWZawOakYEwJaByLhV4TUxI5aS7GWA/0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:From;
	b=Kuw5XgYtBdePEfpDXm+rMna34IdIqO6nIntgkMaZ0tQ68B8B1hPt7xm9wEhMFaERm
	 N2pnkKF6MkAGGbESHjBvdcAJPWyQfe5ibVSsBZ4buLdtsb9+mBIn5sa6v6PCyBp8Ac
	 OwMzgjzf3jf61kmzLquG0YRKp+AsLpUyYjGDKLNvksPIH+BVdGtjgOzawgpfjzPYR3
	 wy89wH1bj77qt+GyXtZ8hocYhI5hYqFXfkdIL6GPqKQ2xRdrUw4LmhmOeaEQzWP9im
	 CxYeg+OPCQfIxeYIEyO4kqPTFUAcl+MKEv1/iLrXtaCma6hgCbYQdAKfsdr2dGN7Ci
	 KCnZ3rJYuVpAw==
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
Subject: Re: [PATCH bpf-next v2 3/7] riscv, bpf: Support sign-extension mov
 insns
In-Reply-To: <20230824095001.3408573-4-pulehui@huaweicloud.com>
Date: Thu, 24 Aug 2023 10:44:46 +0200
Message-ID: <87zg2ghls1.fsf@all.your.base.are.belong.to.us>
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
> Add support sign-extension mov instructions for RV64.
>
> Signed-off-by: Pu Lehui <pulehui@huawei.com>

Acked-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>

