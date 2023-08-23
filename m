Return-Path: <bpf+bounces-8404-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5CCC785F7C
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 20:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0FF91C20D02
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 18:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0BC1F940;
	Wed, 23 Aug 2023 18:22:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACE41ED47;
	Wed, 23 Aug 2023 18:22:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B3CFC433C7;
	Wed, 23 Aug 2023 18:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692814952;
	bh=XhVMfYe6nZ70KASS+6EJs35VBb/ki/oYhS3+q7aUePk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=NcY+bvqoB9qC4bweo8x0eJ0J8rf67mYWnwOTgH119X4FJSTkmGmW6NNlZIdAc5CBI
	 jEbzWOskfSFAzVHOkAa8WIaZJjaKkjgI+KskIt4QJOQMP4pcprGCO8W98ILkUZWk57
	 B6cpUER6Hj6Po6AkeHaZ2mh78oEPcL54YCvoMQQwB5YRInWMOjnreX5ApzUsMLmylH
	 doGEgmbO3f7CtJXnzFiHsuS0LMKeSyPK2jQhTbhzIQI1zLOZH3nG0hjhhjjwj3kDSX
	 pBhjAYzwBAvw1P0ulpouX0/J5wJloO+tcfcCCOaeX1s2qSLyZHtccGNIYNbqyielGo
	 /ZjZGW4pv/nDw==
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
Subject: Re: [PATCH bpf-next 4/7] riscv, bpf: Support 32-bit offset jmp insn
In-Reply-To: <20230823231059.3363698-5-pulehui@huaweicloud.com>
References: <20230823231059.3363698-1-pulehui@huaweicloud.com>
 <20230823231059.3363698-5-pulehui@huaweicloud.com>
Date: Wed, 23 Aug 2023 20:22:29 +0200
Message-ID: <87cyzdliu2.fsf@all.your.base.are.belong.to.us>
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
> Add support 32-bit offset jmp instruction for RV64.
>
> Signed-off-by: Pu Lehui <pulehui@huawei.com>

Acked-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>

