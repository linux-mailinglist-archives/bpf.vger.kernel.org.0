Return-Path: <bpf+bounces-11030-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EADB47B187B
	for <lists+bpf@lfdr.de>; Thu, 28 Sep 2023 12:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 9EB27282317
	for <lists+bpf@lfdr.de>; Thu, 28 Sep 2023 10:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33B834CE6;
	Thu, 28 Sep 2023 10:46:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880DB31A8D;
	Thu, 28 Sep 2023 10:46:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C6EDC433C8;
	Thu, 28 Sep 2023 10:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695897962;
	bh=h+CNXH1b6Tz9pCCf5S9IaQ4Eb6+7xgTE44+TmH9sZW8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=THpJNRRpXy1xb+2sMAW+kvqp1dtP8aXZmfthzvlK38+OXQEowIh0VJ1mffL0zLUkT
	 QyL5PsTLVmJJHNQ9vrMwOncvfY/GFNLs2IFKBDwOQ8iJlI9eJOOwttlnL6C+t/RjaY
	 Aqho0D/vXyaiQpUAtScMv9abO0TTtc3nQF5bEL4OGH3eqGCwLXwOXNavSTKchMuKvI
	 aAQC34TA2jewdbmYki8umEkJSHo/tJkfucGtqPB8wo+dB8xTGeB21wNMxFJzUBqONE
	 mPHmyP4HDUggC/3kiFN0GLL0kq0d96lPyv/pXVopfYRQHgNE7tQSwSVD0l/Z+A7+VX
	 rZ/vxUE/iCYQg==
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
Subject: Re: [PATCH bpf-next v2 1/6] riscv, bpf: Unify 32-bit sign-extension
 to emit_sextw
In-Reply-To: <20230919035839.3297328-2-pulehui@huaweicloud.com>
References: <20230919035839.3297328-1-pulehui@huaweicloud.com>
 <20230919035839.3297328-2-pulehui@huaweicloud.com>
Date: Thu, 28 Sep 2023 12:45:59 +0200
Message-ID: <87bkdmo9so.fsf@all.your.base.are.belong.to.us>
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
> For code unification, add emit_sextw wrapper to unify all the 32-bit
> sign-extension operations.
>
> Signed-off-by: Pu Lehui <pulehui@huawei.com>

Acked-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>

