Return-Path: <bpf+bounces-10873-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D637AEDF9
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 15:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 55DF1B209CC
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 13:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DABFE28E36;
	Tue, 26 Sep 2023 13:30:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8016428E17;
	Tue, 26 Sep 2023 13:30:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65BF2C433C8;
	Tue, 26 Sep 2023 13:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695735049;
	bh=PDbcZR8qPDhdOJhOEKqwAYz8JhEa7RPGxuFdjlVwC70=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=FIA+Tdrasc/f1J8sY5um2A/XD5UrwACQK+ZfQRk+MZKzf0k49rBfciCxJJdiLZtOK
	 zTIemt7kNlOCYgf1bvrx7hfivIZ0XS0f1hZWaU8SZlR2pEHXnwywxVW27K63MmmtZd
	 CYh7B47YFYJP0Exw0ruCDS1rJ4saPeEUQdHOMx+Aem3SXDw6booCMTZUaOECBU6YOq
	 lb6xGM20F24KCNsq7SDaK9R/CbJqYswFqcSGIurxJNmE0hOWNZWXr0jvvaDqr0j4wk
	 wbW3VUB0nxsMlz7HbVYr0OoupRaBeyFiNgp7itmAE/+eOUfJSQ5ThROpoylPdgR1p6
	 KA7v893YSk6aA==
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
Date: Tue, 26 Sep 2023 15:30:44 +0200
Message-ID: <8734z1oyd7.fsf@all.your.base.are.belong.to.us>
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

Apologies for the review delay. I'm travelling, and will pick it up ASAP
when I'm back.


Bj=C3=B6rn

