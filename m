Return-Path: <bpf+bounces-49180-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E776A14F27
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 13:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A72253A8479
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 12:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137CD1FE47D;
	Fri, 17 Jan 2025 12:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jei1z9Sz"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBEF1F63F3
	for <bpf@vger.kernel.org>; Fri, 17 Jan 2025 12:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737117117; cv=none; b=JuCWfpK0iQ0U4zDzD9uSPp6a/q57hfsM99e9aXrraxWpSFmEoEL5AU4VcdzMdcHwOCBUlUK0CchntxW/dOR4TKk2C+sW2/zYfWp79uyAIY/+OHphSzzJC4ZztR4Byo/uvhl68UMI3MOOACyDDuUSq+KpCwHzmfejTG8W91d54zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737117117; c=relaxed/simple;
	bh=cG+NXn2zCusF5VUR3pUaeml250nFwcMoSMK/EDe8o78=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GxoxEIb9Tah4XHdmDbG+QVGnjZYQV7iU5o4IK2tdayJw2vL+t46GquEhW3L3lSVm3iL68vU+7wlS6UQQrwXGCRNj7PVoyWQM2Ji256nin1bz2pzFGoE4HMAfFe1EhPY8I2hK+c6eYwUipA3stSlGjxYw+AKrfzLw9iubMd+wbvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jei1z9Sz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2405C4CEDF;
	Fri, 17 Jan 2025 12:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737117117;
	bh=cG+NXn2zCusF5VUR3pUaeml250nFwcMoSMK/EDe8o78=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Jei1z9SzZeCr6nvUHd6YKLbKxQDW043bnzxYUuk0FJssCo708BC42gCKR7m1xB15v
	 RcFEFRS64oDDyeH5ZRlBQ3UEnSSrRisCbTS3FucEQPshcDzHzpWcAHiFnj4AVh/xQc
	 VpEMG3oI4h9Wed7r10C6yIyfYPq/ZFRc2GCO5YcCi73XJMx1gKhxQFQnOVa74m8TWR
	 j7GNKV/qn3qVIgbjunGTyWedDNGM3txnkKsrpzSKnmYmt7XPZBnYy1dLKgD+t/GfwI
	 DYzSK0o+kJQ72AivbOtfyq29SvTmXPHFG4JKZgQMIgZOCD9vRt68UmGU+bMLVH7u3e
	 vnY7VDjYzdTHQ==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 9EE1817E785E; Fri, 17 Jan 2025 13:31:43 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To: Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Hao Luo
 <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>, Daniel
 Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, houtao1@huawei.com, xukuohai@huawei.com
Subject: Re: [PATCH bpf-next v3 2/5] bpf: Bail out early in
 __htab_map_lookup_and_delete_elem()
In-Reply-To: <20250117101816.2101857-3-houtao@huaweicloud.com>
References: <20250117101816.2101857-1-houtao@huaweicloud.com>
 <20250117101816.2101857-3-houtao@huaweicloud.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 17 Jan 2025 13:31:43 +0100
Message-ID: <87sephoc40.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hou Tao <houtao@huaweicloud.com> writes:

> From: Hou Tao <houtao1@huawei.com>
>
> Use goto statement to bail out early when the target element is not
> found, instead of using a large else branch to handle the more likely
> case. This change doesn't affect functionality and simply make the code
> cleaner.
>
> Signed-off-by: Hou Tao <houtao1@huawei.com>

Yeah, nice cleanup :)

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@kernel.org>

