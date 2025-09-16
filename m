Return-Path: <bpf+bounces-68549-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27589B5A352
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 22:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90FBA1888501
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 20:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A7331BCBE;
	Tue, 16 Sep 2025 20:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hqgYY9GF"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD55E31BCA1
	for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 20:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758054840; cv=none; b=FvjXEfYrv3WohEQn13kw13qTANZlu4R82tfajoIjq0+aRiREaZEjGBWL9wnZmjyfvJAMxHNb04ziDm/cY4pBovg06ZsIdKXqqvX93YjVz3H5DDlj3SgYjWQe0QlminYic8I7GQnVWvyvlvm4mViqsUiFLQjz60KYIQNXpMAuppQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758054840; c=relaxed/simple;
	bh=9rDdehJvOEhs6iPtebgLin/+11e8MWgodKIs6hOdAnY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=UGCYLOVxUW27yJZ67jJqeytE4EqXqycu0drBiAPOME+bj/1tDZrp5MmVK6OmmIfMPIUcxK08LXNorWjmTMypDBGkigHmdUpEWv0z2QV1TKGC8BihWEOPCcEkmZyIUuleuq6yBYmfQjagIcLgquIwIqc/drpAwqjRObwjT/a3z0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hqgYY9GF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADFA0C4CEEB;
	Tue, 16 Sep 2025 20:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758054840;
	bh=9rDdehJvOEhs6iPtebgLin/+11e8MWgodKIs6hOdAnY=;
	h=Date:From:Subject:To:References:In-Reply-To:From;
	b=hqgYY9GFrRRdHM2jhT7VSi1d7EtOFU/Ux3l6sQDxlxhXrR9dD9pYto/pJzbrl0AqG
	 usj4m2fUXoF0DWbObXEmcmI8x0wPXSqB3ZQOlsZpJa3QU3AXj1DbLvpm45sfpVCBsP
	 QWzLbr9pkj2PboJ11OUyVYd3IyaLGpzXH7BO0G9oOMhG0UzuRcKTAn4KsufvgRP6lE
	 5IsTB8TkQG3DfDVAydstU6nQnP0LwXsDq8BEGzdOByzHCyN/lnla79kDZUc7RsjpBe
	 vzRMQ1xViLtP9nk32FoLv3vKW5mMAivGJXbJYmY+A+91do3sqMlmfUAwXz8jVWsln3
	 lQdZ9sxftdVtw==
Message-ID: <0ef006c7-fb6d-4a97-b42d-f70c91a8cf72@kernel.org>
Date: Tue, 16 Sep 2025 21:33:57 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Quentin Monnet <qmo@kernel.org>
Subject: Re: [PATCH v2 bpf-next 12/13] bpftool: Recognize insn_array map type
To: Anton Protopopov <a.s.protopopov@gmail.com>, bpf@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Anton Protopopov <aspsk@isovalent.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>
References: <20250913193922.1910480-1-a.s.protopopov@gmail.com>
 <20250913193922.1910480-13-a.s.protopopov@gmail.com>
Content-Language: en-GB
In-Reply-To: <20250913193922.1910480-13-a.s.protopopov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2025-09-13 19:39 UTC+0000 ~ Anton Protopopov <a.s.protopopov@gmail.com>
> Teach bpftool to recognize instruction array map type.
> 
> Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> ---
>  tools/bpf/bpftool/Documentation/bpftool-map.rst | 2 +-
>  tools/bpf/bpftool/map.c                         | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/Documentation/bpftool-map.rst b/tools/bpf/bpftool/Documentation/bpftool-map.rst
> index 252e4c538edb..3377d4a01c62 100644
> --- a/tools/bpf/bpftool/Documentation/bpftool-map.rst
> +++ b/tools/bpf/bpftool/Documentation/bpftool-map.rst
> @@ -55,7 +55,7 @@ MAP COMMANDS
>  |     | **devmap** | **devmap_hash** | **sockmap** | **cpumap** | **xskmap** | **sockhash**
>  |     | **cgroup_storage** | **reuseport_sockarray** | **percpu_cgroup_storage**
>  |     | **queue** | **stack** | **sk_storage** | **struct_ops** | **ringbuf** | **inode_storage**
> -|     | **task_storage** | **bloom_filter** | **user_ringbuf** | **cgrp_storage** | **arena** }
> +|     | **task_storage** | **bloom_filter** | **user_ringbuf** | **cgrp_storage** | **arena** | **insn_array** }


Thanks Anton!
That's a long line. As you'll likely respin your series, could you wrap
and start a new line, please?


>  
>  DESCRIPTION
>  ===========
> diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
> index c9de44a45778..79b90f274bef 100644
> --- a/tools/bpf/bpftool/map.c
> +++ b/tools/bpf/bpftool/map.c
> @@ -1477,7 +1477,7 @@ static int do_help(int argc, char **argv)
>  		"                 devmap | devmap_hash | sockmap | cpumap | xskmap | sockhash |\n"
>  		"                 cgroup_storage | reuseport_sockarray | percpu_cgroup_storage |\n"
>  		"                 queue | stack | sk_storage | struct_ops | ringbuf | inode_storage |\n"
> -		"                 task_storage | bloom_filter | user_ringbuf | cgrp_storage | arena }\n"
> +		"                 task_storage | bloom_filter | user_ringbuf | cgrp_storage | arena | insn_array }\n"


Same here. Other than these:

Acked-by: Quentin Monnet <qmo@kernel.org>

