Return-Path: <bpf+bounces-51131-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61107A3090C
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 11:49:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B15E11882D61
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 10:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880F31F428C;
	Tue, 11 Feb 2025 10:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rr/kSPUZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086B31C3308;
	Tue, 11 Feb 2025 10:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739270936; cv=none; b=m/OI2LtfHFBA+YYjDptoEEGdksAVHkQsZ5yLT4MrBLJANWzyffge86SrRY5TgCs+wzg0vQPcG7Oi/stT/BfyHSIury5dOOVAGH7otgRW1wFzoTY35zf8x/h/NzlndECA+gZXaOn5Czqll/Hfq7B67PuXeN9tzGJLxJyqJzYzopw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739270936; c=relaxed/simple;
	bh=AEz1K2qnZmqsRk0Zei3uk9ZtCXr4zDtCnPQsxlHA6rU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dp1YuTtElEKG0Py9Hi1JTbbAwY/Ndtg+NK7ESw8DxQIKSMBjXdi6gYtd0u9cDLNYXFMqPVwK6qh3gRzEnFak8AjCVdS4BUiCZIu14F2XRBGXwMEEr20sPZ0Eq1wb3ZcmImTIp0Eb2hrI832drcuVetBT7xxrDZTE3HyGmgHx5mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rr/kSPUZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ECD0C4CEDD;
	Tue, 11 Feb 2025 10:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739270935;
	bh=AEz1K2qnZmqsRk0Zei3uk9ZtCXr4zDtCnPQsxlHA6rU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rr/kSPUZ094v+FxOmX6XTFz5HnSf357O6P5XJKnMtZhCMbQKMqJpcqA9mGJKaoheO
	 kWlVCnKPxazm0zTXPXsJTLBz2ilupdfg360Xhuu5HnKb58AZhY4GC3YC/sfXcqkqzT
	 e4EGdTLU/zjV8y0aEIch9+d4V2A3n8d9tp+xQhmygiJCioeCBEUGlMd++okTDGoraS
	 fNcZALe69mfU9o5LfW+2+EK5boFw46yeccneOv251haF3RPsllF8FBiDcbdwF+L1lo
	 JtiHlkfEM5bATV+NrWVJWrbPQBTRT+HyFD+VJZSM9WXN3l6faYBUmCgzr3Xh6/6ID3
	 +IEG2dYXfhj1w==
Message-ID: <c886e85d-4c24-4a01-b04f-1006dbb7b512@kernel.org>
Date: Tue, 11 Feb 2025 10:48:52 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2] bpftool: Check map name length when map
 create
To: Rong Tao <rtoax@foxmail.com>, ast@kernel.org, daniel@iogearbox.net
Cc: rongtao@cestc.cn, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>,
 "open list:BPF [TOOLING] (bpftool)" <bpf@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <tencent_26592A2BAF08A3A688A50600421559929708@qq.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <tencent_26592A2BAF08A3A688A50600421559929708@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2025-02-11 18:38 UTC+0800 ~ Rong Tao <rtoax@foxmail.com>
> From: Rong Tao <rongtao@cestc.cn>
> 
> The size of struct bpf_map::name is BPF_OBJ_NAME_LEN (16).
> 
> bpf(2) {
>   map_create() {
>     bpf_obj_name_cpy(map->name, attr->map_name, sizeof(attr->map_name));
>   }
> }
> 
> When specifying a map name using bpftool map create name, no error is
> reported if the name length is greater than 15.
> 
>     $ sudo bpftool map create /sys/fs/bpf/12345678901234567890 \
>         type array key 4 value 4 entries 5 name 12345678901234567890
> 
> Users will think that 12345678901234567890 is legal, but this name cannot
> be used to index a map.
> 
>     $ sudo bpftool map show name 12345678901234567890
>     Error: can't parse name
> 
>     $ sudo bpftool map show
>     ...
>     1249: array  name 123456789012345  flags 0x0
>     	key 4B  value 4B  max_entries 5  memlock 304B
> 
>     $ sudo bpftool map show name 123456789012345
>     1249: array  name 123456789012345  flags 0x0
>     	key 4B  value 4B  max_entries 5  memlock 304B
> 
> The map name provided in the command line is truncated, but no error is
> reported. This submission checks the length of the map name.
> 
> Signed-off-by: Rong Tao <rongtao@cestc.cn>


Reviewed-by: Quentin Monnet <qmo@kernel.org>

Thank you!

