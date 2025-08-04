Return-Path: <bpf+bounces-65016-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8033DB1AA24
	for <lists+bpf@lfdr.de>; Mon,  4 Aug 2025 22:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F94D3ADD01
	for <lists+bpf@lfdr.de>; Mon,  4 Aug 2025 20:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354ED21B9C3;
	Mon,  4 Aug 2025 20:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JQXUKdMw"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC7443ABC;
	Mon,  4 Aug 2025 20:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754339529; cv=none; b=FxIJ+hfg+LiMx9aLaSWOOlk4JMCYqT+/ENnsKgmCM5Yus9nHuCjnnAv7i4yN07jAyOQrskucAgySx/qvAT68yYAdq/zJX0DGsfijeLEqMcVt4c6HF01zMrQgU4R3NKLTCqbWOJL8TQMdOVS6gb0iMPlO7P/dFC4Ruxeqehj1CUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754339529; c=relaxed/simple;
	bh=40RPmmhgenS++dUjxETl8DxV/XFXspYQo4HXXmsrhls=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qhMk/YO7bg+o3mJLb5oSwoXiF3A3owGHG5ku6PALPQtsSBfyMLnGe3NCqZp+WnocYRZVSTlR2/C8htQFxkjxLOQmT/vA19AGB1p6iMF0uh1O9WZZFgCkFVH7f3BO+4D/MrR5TlM0K0py7IHBzW2wjOuLOHSaVNRNQLCakkwiZko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JQXUKdMw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7F95C4CEE7;
	Mon,  4 Aug 2025 20:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754339529;
	bh=40RPmmhgenS++dUjxETl8DxV/XFXspYQo4HXXmsrhls=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=JQXUKdMwFWEh72JN1E6XzW9gB6pcSUBn7mgP4hBUHV2TpolWdTSfQw4mCxYy4Zy3E
	 lUtaIyYa44cze8FqCym9EpaeMrWsTATwoH27xF95eprgUJJmuX8DtRZ/QiocXQ8aIA
	 jc4t2gY8jGLgkj3U/lrseTF3ovLDIfeRF/v10YguErQe6smk0ksBMrsbOIRzb55XFY
	 28W/sTdccRNJl6jdGHkTr0BO8ndO2VYz/Ani6KoevoXAVgowgiDbhXZFgVj5gAS4iR
	 Enk6figXDmKEHpnxpASTpbq88kekHHfDpVfBD7xWDRHwvW+N9ywUM1E/OOSiU10oIJ
	 LNeyo9+ssoqnQ==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Pu Lehui <pulehui@huaweicloud.com>, bpf@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, Alexandre Ghiti <alex@ghiti.fr>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard
 Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Pu Lehui
 <pulehui@huawei.com>
Subject: Re: [PATCH bpf-next 05/10] riscv, bpf: Add rv_ext_enabled macro for
 runtime detection extentsion
In-Reply-To: <20250719091730.2660197-6-pulehui@huaweicloud.com>
References: <20250719091730.2660197-1-pulehui@huaweicloud.com>
 <20250719091730.2660197-6-pulehui@huaweicloud.com>
Date: Mon, 04 Aug 2025 22:32:06 +0200
Message-ID: <87ms8e3k1l.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Nit: Subject: s/extentsion/extension/

Pu Lehui <pulehui@huaweicloud.com> writes:

> From: Pu Lehui <pulehui@huawei.com>
>
> Add rv_ext_enabled macro to check whether the runtime detection
> extension is enabled.
>
> Signed-off-by: Pu Lehui <pulehui@huawei.com>

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>

