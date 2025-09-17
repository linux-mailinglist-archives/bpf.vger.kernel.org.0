Return-Path: <bpf+bounces-68675-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4CFB808C9
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 17:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F7637AD5F2
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 15:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E76733AEBF;
	Wed, 17 Sep 2025 15:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d/2vpZgh"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B567033595A
	for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 15:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758122782; cv=none; b=FM91kEDEIlK3hUS7gmTuUAa7gg4OZovwbbjhArEciqHyxbryzeTW03q+ltpinoC+RW6D7IAtfBGw0XVeQlUnYO5N0kp3O0pFzQG7/FXbFi56bT8sOalZt+6vczhXiNm8R8fQSeBJ2D90X78JTGrBFefJpFZdhOZgNViyiZeVnXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758122782; c=relaxed/simple;
	bh=uY22s3QDPwbHA6Rd3qt3azYHKB0tyl0hse28tTW8vU0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rzD1e5MHBnj/6eVDpXjN288D4aoZFE8EiyApyNJd/ymywdTXazrwStGUB2gYED2nyzQM9wQiWBSsQcqxTMDr4b5e7Iue6rmeFDrQKBWLVNQvOal4NSK/tNVApzQ7yljZqeySXR9aXgerfuBhVEWxz4Rc06Djxe1CNrq0KATWxBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d/2vpZgh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A291C4CEE7;
	Wed, 17 Sep 2025 15:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758122782;
	bh=uY22s3QDPwbHA6Rd3qt3azYHKB0tyl0hse28tTW8vU0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=d/2vpZghHoXP6jV9KbcdYj/coq6Aw/fA9EqTHiyvcQjGTgj0OZ3yyH4MNItEy7Rmk
	 wWYbS/aP9ISh2HQOMLZY2Kw+EPpTEq7hNnB0YCCJ+SV0YaPHoFzW+o7G0hdM2as6Yw
	 MWpZDXHaFZW0WMzNiJzckWa5/o0oYzOXuaEnmn6MtpcUIwkPBsXw9fpWdUohJNo0f6
	 AEsd6ktSzJXIV/JPOjDDBQ9eIraciFIHLkmMDGoAaJu52tdiR6jSYY9W5XjC88y/xg
	 Ov7zoERkP5sJL1OwNfFfIxBuU2JgU9TxGY5xWwSHnp0xR4NX2OP8XzS8C3euZxN0UB
	 zDoJnPufuT1eg==
Message-ID: <7949d9ee-b463-4fd4-830e-0bb74fb5b2a0@kernel.org>
Date: Wed, 17 Sep 2025 16:26:18 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bpftool: Fix -Wuninitialized-const-pointer warnings with
 clang >= 21
To: Tom Stellard <tstellar@redhat.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org
References: <20250917135758.289415-1-tstellar@redhat.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20250917135758.289415-1-tstellar@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2025-09-17 06:57 UTC-0700 ~ Tom Stellard <tstellar@redhat.com>
> This fixes the build with -Werror -Wall.
> 
> btf_dumper.c:71:31: error: variable 'finfo' is uninitialized when passed as a const pointer argument here [-Werror,-Wuninitialized-const-pointer]
>    71 |         info.func_info = ptr_to_u64(&finfo);
>       |                                      ^~~~~
> 
> prog.c:2294:31: error: variable 'func_info' is uninitialized when passed as a const pointer argument here [-Werror,-Wuninitialized-const-pointer]
>  2294 |         info.func_info = ptr_to_u64(&func_info);
>       |
> 
> Signed-off-by: Tom Stellard <tstellar@redhat.com>
> ---
>  tools/bpf/bpftool/btf_dumper.c | 2 ++
>  tools/bpf/bpftool/prog.c       | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/tools/bpf/bpftool/btf_dumper.c b/tools/bpf/bpftool/btf_dumper.c
> index 4e896d8a2416..363d3e592ce2 100644
> --- a/tools/bpf/bpftool/btf_dumper.c
> +++ b/tools/bpf/bpftool/btf_dumper.c
> @@ -68,6 +68,8 @@ static int dump_prog_id_as_func_ptr(const struct btf_dumper *d,
>  	memset(&info, 0, sizeof(info));
>  	info.nr_func_info = 1;
>  	info.func_info_rec_size = finfo_rec_size;
> +	/* Silence -Wuninitialized-const-pointer warning in clang >= 21. */
> +	memset(&finfo,  0, sizeof(finfo));


Thanks for this! How about simply initialising the variable when we
declare it, instead?

	struct bpf_func_info finfo = {};

This would avoid adding the memset() and comment in the middle of the
function, and keep it slightly more readable?

Thanks,
Quentin

