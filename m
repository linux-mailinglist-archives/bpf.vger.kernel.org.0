Return-Path: <bpf+bounces-29637-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA9B8C3FE1
	for <lists+bpf@lfdr.de>; Mon, 13 May 2024 13:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A3EE1C22B21
	for <lists+bpf@lfdr.de>; Mon, 13 May 2024 11:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C3E14D293;
	Mon, 13 May 2024 11:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z4L8RDXy"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B2D14C584;
	Mon, 13 May 2024 11:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715600083; cv=none; b=Y6u7oeRqVi9n5WcuZlVbQpr4fPUj7utxsEPSvM+HkoFyuAurLymk5h5D1oaRNMBeZo3nt5zqrrv+hIfpaNTr8grn0/E7s0AjK68aTdw7mIfJXqylTP2sU/XXMTrCG7dX1VRyxzPe1CW1WlgJYXYHfRuUuXh0m69VMYE6QfrpbNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715600083; c=relaxed/simple;
	bh=S9sC2+G9YvC9OP8HvDTTM98Hu931Pe01owG83+5KNZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pYZLr9BFaIE9zOlSpkeIahVVRYuv4iFt+IGQzLvAvSzNT3pWxgr9zSEXE8FeEeObWXLqlYWKaLvqyB5JkpB0rwUFIq9WEVDzVtqEoArwvnKD1rC/UecXI+VRz+iRQ9K78p/Oe0VNAeYbIS3ha1dquokrxp8nE8NJVNioJSdHBpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z4L8RDXy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEEFCC32782;
	Mon, 13 May 2024 11:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715600083;
	bh=S9sC2+G9YvC9OP8HvDTTM98Hu931Pe01owG83+5KNZg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Z4L8RDXykfsx96g7Njx+b5Xqxzj9oHgq1FgwSF5d4EJpdc5cZP4mYeJrED1hOGttk
	 vWrtfE1kNGYJMr8hKQFWQh9i/IMNf2TpiEJINcgw49QVciuSnxreNJILK3sS478qHC
	 3OwjKOqRs6nVf0bxdhCmRntJt6P/A/pZydw5LPSHAfFMPRX6kz+QpO/HeAUxRwOdyS
	 Om7ByeETzoyMazUy8lzfzrUJH3SObWr0VV29WU1wIQdV/a4fblsDVhWDE/bizfw7q1
	 OiIziGBT32CtblG8XOCZ3Fk/a3dhl2gKmAoex9GH1DeqF61My4/qDv/Jxf3I0hzREy
	 y249VWn2DDfQA==
Message-ID: <e7b52f2c-3d8c-4f6d-bf0b-73706e5e6754@kernel.org>
Date: Mon, 13 May 2024 12:34:38 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] bpftool: fix make dependencies for vmlinux.h
To: Artem Savkov <asavkov@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 bpf@vger.kernel.org, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Jan Stancek <jstancek@redhat.com>
References: <20240513112658.43691-1-asavkov@redhat.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20240513112658.43691-1-asavkov@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2024-05-13 12:27 UTC+0100 ~ Artem Savkov <asavkov@redhat.com>
> With pre-generated vmlinux.h there is no dependency on neither vmlinux
> nor bootstrap bpftool. Define dependencies separately for both modes.
> This avoids needless rebuilds in some corner cases.
> 
> Suggested-by: Jan Stancek <jstancek@redhat.com>
> Signed-off-by: Artem Savkov <asavkov@redhat.com>


Looks good, thank you.

Acked-by: Quentin Monnet <qmo@kernel.org>

