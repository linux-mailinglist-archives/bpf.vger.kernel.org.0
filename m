Return-Path: <bpf+bounces-11031-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 280607B187F
	for <lists+bpf@lfdr.de>; Thu, 28 Sep 2023 12:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 53D3B1C20A6A
	for <lists+bpf@lfdr.de>; Thu, 28 Sep 2023 10:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F64734CEF;
	Thu, 28 Sep 2023 10:46:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4571E34CCC;
	Thu, 28 Sep 2023 10:46:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA0B0C433C7;
	Thu, 28 Sep 2023 10:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695897981;
	bh=kqJ++Rtdj7thsbKhHQVDminaG5K5K/+2jonSvvV1OpI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=h56YuQk9tKBjh3ZLFmkdR1KFT/a/1Qy0YOYw1+/ycZU2SnOa0+F/Ax1ZohhZzj3sH
	 j2tLFCIBr65xLu9vGLM0s5lQQ1+dhLseeQGEPbcGPEiGiKZhZpyZCKQ9ic4AsW0le5
	 xvsdrQyA7defQpCwH2FUVKFAn8ltwKB9DmU3wcpkTK5gs0XNXpNayPBg2NRYR4UW2q
	 E/CpltTDUHQzDDzVcv2c9N8QUXKDaQbQEZkM8G7/pK7ksT2Lm2RlgzvNgoJO5phiGc
	 6bm+VAwEdC0p7xyb5TR0lwC3ZH7TCSSscKEumwsFv10Z8QAyJciK+rchXIWvKbZ5e4
	 /eDW3DSPYb+zA==
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
Subject: Re: [PATCH bpf-next v2 2/6] riscv, bpf: Unify 32-bit zero-extension
 to emit_zextw
In-Reply-To: <20230919035839.3297328-3-pulehui@huaweicloud.com>
References: <20230919035839.3297328-1-pulehui@huaweicloud.com>
 <20230919035839.3297328-3-pulehui@huaweicloud.com>
Date: Thu, 28 Sep 2023 12:46:18 +0200
Message-ID: <877coao9s5.fsf@all.your.base.are.belong.to.us>
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
> For code unification, add emit_zextw wrapper to unify all the 32-bit
> zero-extension operations.
>
> Signed-off-by: Pu Lehui <pulehui@huawei.com>

Acked-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>

