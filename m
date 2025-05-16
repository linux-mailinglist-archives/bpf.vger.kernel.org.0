Return-Path: <bpf+bounces-58403-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6636AB9EFD
	for <lists+bpf@lfdr.de>; Fri, 16 May 2025 16:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3A337A9563
	for <lists+bpf@lfdr.de>; Fri, 16 May 2025 14:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649F41A2C25;
	Fri, 16 May 2025 14:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dX14ChcE"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA471F956;
	Fri, 16 May 2025 14:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747407260; cv=none; b=ZPthxPNPRYvv+655Anhv8IsdQ5UksNbXWmwyZvr/fk3vtlr1KsbmkoIaTrlSBD0iD0f7KVASRYDqkL+iGtyo8jmNXSdJyyWo7M/A72Nc2ZRfmZXelQ8yNBmYBkwcpjpkk7xGp1A80hlsnX1cvyxjuLqEel7ONqhrGzi/eBPWvis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747407260; c=relaxed/simple;
	bh=Cf8QadZWGDDyCJt7lheQgOWe/M2QgOZAeDiZVrZayQI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oGUkYqt5j2bqdgEokpgHodoGfBRS18Pjvtp4aHWKQiS5TUrKhgF9CEViy1XlaGyakpIRY+bS7jpN07PI8Eyf2JeYKL+hXAyAT8VcpImpQGxK5SQIoJdN6ymHy3UZWA0M7CQdayhVArQYUO2ME6IEKTL4kncDGGya3cJI0CgeY4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dX14ChcE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEAE7C4CEE4;
	Fri, 16 May 2025 14:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747407259;
	bh=Cf8QadZWGDDyCJt7lheQgOWe/M2QgOZAeDiZVrZayQI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dX14ChcE4UVne4vmtcTb0pmKclnZJxD2X3VevoJ6TFOk9IRG1s8Bqiz1zKE7wmboD
	 DL++P2P/wlCcBx/DiK+8HkKDRikiFQ8yGqnlRydpUAqnsXt3pFmtklGmRefk6weV/g
	 s+NsP9VgI+pOXSbwWptOtNbAWeJ2MaHsbNT6vtlhc3oDvAbi4eOQfzlCPkb2eHCO5+
	 cqAKYJjXVcsk3gVa+nN0AQlJvruEta31b9cl9C88ugdaFRmUYAOmmcnWAn4v61KXiy
	 ub7pqiTxmVRikbqtqUMuA6Jnd8DS+kCivkTZocHxJs7oop3/8TC1gamR6bm/L5fxmW
	 kRcra6B8aq/4Q==
Message-ID: <addf5c1e-9e78-4eb4-902e-06476dc79c90@kernel.org>
Date: Fri, 16 May 2025 15:54:15 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4] bpftool: Add support for custom BTF path in
 prog load/loadall
To: Jiayuan Chen <jiayuan.chen@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>,
 Tao Chen <chen.dylane@gmail.com>, Mykyta Yatsenko <yatsenko@meta.com>,
 linux-kernel@vger.kernel.org
References: <20250516144708.298652-1-jiayuan.chen@linux.dev>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20250516144708.298652-1-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2025-05-16 22:47 UTC+0800 ~ Jiayuan Chen <jiayuan.chen@linux.dev>
> This patch exposes the btf_custom_path feature to bpftool, allowing users
> to specify a custom BTF file when loading BPF programs using prog load or
> prog loadall commands.
> 
> The argument 'btf_custom_path' in libbpf is used for those kernels that
> don't have CONFIG_DEBUG_INFO_BTF enabled but still want to perform CO-RE
> relocations.
> 
> Suggested-by: Quentin Monnet <qmo@kernel.org>
> Reviewed-by: Quentin Monnet <qmo@kernel.org>

Thanks!
Quentin

