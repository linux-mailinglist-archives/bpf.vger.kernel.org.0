Return-Path: <bpf+bounces-20746-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 234B48428C1
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 17:05:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3F10281E2A
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 16:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E6D86AC9;
	Tue, 30 Jan 2024 16:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mAylsLi7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE886BB25;
	Tue, 30 Jan 2024 16:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706630744; cv=none; b=ANyYmfQZ/1n2R5/0bcaj5HNgI9F/iR+V4WOJ+G662MaP6E1zSh6ijbqRO+PNnnVCxV9xz1WbsDjkq3wDY6NFzyOu4eSTK5ZUXc7I8t9tAzbU8oRHxPlG9sKgJ56xKPKsLqvi7a9yXP0vN2+VyBQIwjj0EWD+1Wf/09dfv2anblY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706630744; c=relaxed/simple;
	bh=XNZMtU9+NSZPjnlFT4YalaCcT7iFvu8+aCgq4SJNd0A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nSMZ2ucjaHCOh4mpaEd1UqCEpJwaUmip/R7Sz6514qb4z7XjzrWgHAYYuepR+qRa5QLBD3RsX8QH5hZva/V+momc0eeHgsSd7UtImRJG21RUahQ3TPlx6rjNR+jWSjnbkhvLnODT+7zQOeINQ5WvU2BDvEBBQh7w7wm7nkGewFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mAylsLi7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 821A9C433F1;
	Tue, 30 Jan 2024 16:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706630743;
	bh=XNZMtU9+NSZPjnlFT4YalaCcT7iFvu8+aCgq4SJNd0A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=mAylsLi7KI3habSsXIBFUxmtVp/tIwg5DU6P0+JwN4GBwB1qLMTbD9X0iFEqUd6fW
	 GXEt64guYmUQMVMtu416Z8ENRTrqLRbg17l/bVau274uMGtvxxGj2zjpAC+Tsq5dlk
	 YK+NwQ7ODYLB+SUBWR5rMWpJK1200L9Du5nPMY1OTfBC1r4wLjcy2Zwi3H65kJdnRs
	 gOsKSwOHm2Moc7LbYuLBJ24Hp/wBI9VtaF5acZtSH0ghnGT8JeMOJnoIYVhKG3WBlX
	 cr2iuoTxl8ge+X3JSKGrArwa0TxrHYWXe0wYWDKdZrRbzyH25hFY73OSEXcRWBagIz
	 3KFoPDuALG6vA==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Pu Lehui <pulehui@huaweicloud.com>, bpf@vger.kernel.org,
 linux-riscv@lists.infradead.org, netdev@vger.kernel.org
Cc: Song Liu <song@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Yonghong Song <yhs@fb.com>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Luke Nelson
 <luke.r.nels@gmail.com>, Pu Lehui <pulehui@huawei.com>, Pu Lehui
 <pulehui@huaweicloud.com>
Subject: Re: [PATCH bpf-next v2 3/4] riscv, bpf: Add RV_TAILCALL_OFFSET
 macro to format tailcall offset
In-Reply-To: <20240130040958.230673-4-pulehui@huaweicloud.com>
References: <20240130040958.230673-1-pulehui@huaweicloud.com>
 <20240130040958.230673-4-pulehui@huaweicloud.com>
Date: Tue, 30 Jan 2024 17:05:41 +0100
Message-ID: <878r46q016.fsf@all.your.base.are.belong.to.us>
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
> Add RV_TAILCALL_OFFSET macro to format tailcall offset, and correct the
> relevant comments.
>
> Signed-off-by: Pu Lehui <pulehui@huawei.com>

Acked-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>

