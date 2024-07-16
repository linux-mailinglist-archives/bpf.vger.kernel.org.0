Return-Path: <bpf+bounces-34923-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 688E8932F01
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 19:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99EC31C22187
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 17:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19411A00F7;
	Tue, 16 Jul 2024 17:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CyzLEzqo"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56288FC19;
	Tue, 16 Jul 2024 17:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721150645; cv=none; b=Wr69SJdNeStxzQisjAscJrRWLYR36UBp5B+K25pri+xwZ6Ntf06cfDJlbP7wJqd60SL7vVW5MVDBMdW3GLdPSJzS1bg8eVTP4sXO4KOEN2yMEM6e/1n1qTgY9WjWdyH2JKO2cOuBZmzoljkJit2sY7+/OCcvfdQ5QP31cG/g0NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721150645; c=relaxed/simple;
	bh=maqJJ8JOcCHKmOOCb03Wwna2hc6VDYkqvLaEn2pXw70=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=BimP7u97B5Ct2KdwJHy2EwqStPKE+bQTqm9NkUhnq1nX1cxpUKZpfdyTLiHaRSkC5gVJHv+V0GJ0LaA6iW829MalJ5n4Bjx6in3314RGlh4ZAaq7Ir7uoKxJ48O3p6fU68M7FibImPM/D45K+b6xQRQnCo1b08PYTP5ePxeG1Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CyzLEzqo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E295C4AF0D;
	Tue, 16 Jul 2024 17:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721150645;
	bh=maqJJ8JOcCHKmOOCb03Wwna2hc6VDYkqvLaEn2pXw70=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=CyzLEzqo/u+GtFgpYc8Tn861Nw8W8eKt+qD7/J3OCrtjJwPeNYrxYYWLEMFAC86bh
	 iD9Cv/PbzHNkrIguMftmDQzf0c81vA4PY38xMZSEvUjSCNsSC1g9/+Teaz9GvARhfL
	 00u/b5IHoupE6ciu2ECQnBYWrffCX3mTNroh8gv3LM0jzfzbMGeJJKsqFLydGmtAD1
	 zO1itCa8/UCy4amt8y7a/04VjW2E9za1S96eT7hVZCx59NQzP31CMLOBuobHpIt7Oj
	 hPPn8NYMBP89j71xDK9khhxB8ohf+4lsY6EW3NdrcMsCxP9tFuwdyGsV1b1Q3GOCbZ
	 ww4lqpC4Ok12A==
Message-ID: <dd993a42-574c-4697-8319-5d3deea2f2cb@kernel.org>
Date: Tue, 16 Jul 2024 18:23:59 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Quentin Monnet <qmo@kernel.org>
Subject: Re: [RFC PATCH bpf-next 3/3] bpftool: add document for net
 attach/detach on tcx subcommand
To: Tao Chen <chen.dylane@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240715113704.1279881-1-chen.dylane@gmail.com>
 <20240715113704.1279881-4-chen.dylane@gmail.com>
Content-Language: en-GB
In-Reply-To: <20240715113704.1279881-4-chen.dylane@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2024-07-15 12:37 UTC+0100 ~ Tao Chen <chen.dylane@gmail.com>
> This commit adds sample output for net attach/detach on
> tcx subcommand.
> 
> Signed-off-by: Tao Chen <chen.dylane@gmail.com>
> ---
>  .../bpf/bpftool/Documentation/bpftool-net.rst | 22 ++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/bpf/bpftool/Documentation/bpftool-net.rst b/tools/bpf/bpftool/Documentation/bpftool-net.rst
> index 348812881297..64de7a33f176 100644
> --- a/tools/bpf/bpftool/Documentation/bpftool-net.rst
> +++ b/tools/bpf/bpftool/Documentation/bpftool-net.rst
> @@ -29,7 +29,7 @@ NET COMMANDS
>  | **bpftool** **net help**
>  |
>  | *PROG* := { **id** *PROG_ID* | **pinned** *FILE* | **tag** *PROG_TAG* | **name** *PROG_NAME* }
> -| *ATTACH_TYPE* := { **xdp** | **xdpgeneric** | **xdpdrv** | **xdpoffload** }
> +| *ATTACH_TYPE* := { **xdp** | **xdpgeneric** | **xdpdrv** | **xdpoffload** | **tcxingress** | **tcxegress** }
>  
>  DESCRIPTION
>  ===========
> @@ -69,6 +69,8 @@ bpftool net attach *ATTACH_TYPE* *PROG* dev *NAME* [ overwrite ]
>      **xdpgeneric** - Generic XDP. runs at generic XDP hook when packet already enters receive path as skb;
>      **xdpdrv** - Native XDP. runs earliest point in driver's receive path;
>      **xdpoffload** - Offload XDP. runs directly on NIC on each packet reception;
> +    **tcxingress** - Ingress TC. runs on ingress net traffic;
> +    **tcxegress** - Egress TC. runs on egress net traffic;


I'd keep "TCX" rather than "TC" in the docs, please, to avoid confusion
with programs attached to clsact qdiscs, for example.

