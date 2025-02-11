Return-Path: <bpf+bounces-51127-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A84A3085B
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 11:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C89E3A3888
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 10:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99D21F4286;
	Tue, 11 Feb 2025 10:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wq/SldKK"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD171F236B;
	Tue, 11 Feb 2025 10:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739269232; cv=none; b=jUu3BmbxWo1NhzlfFmVZfKN7Oc3/OqgFqJKhRwrc6Z+1VUzR2Bm7GwGQ7Vhnu+X+hXBiFcH8moDwTFt2tICeiRinHaeFP6l3eND+CF2+QVDv/2xwKl4HCLY304GAnCuit/k7VNY3phH0bYgg2eHgmO5EGXBITV9HORZEy6W3AY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739269232; c=relaxed/simple;
	bh=9lfDDB4rPknt5HbAKTNtzSaIA0xDJDNjOynJmOPHlww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FyPgCwpDljrAgSwc15L91jS4F2R1dlexHuEcIbGlncNipA22r4L7EUAMVWKrxqDYZcnEjxw6OEFMIXLKrKbUoQNi8H+boha3BhQdXfIqx+JQdSLk+JjvKr6HIGlOLIYPlhezf9tyYZW22qwjGdWh1wk+1rG4thge/97OPOsOm3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wq/SldKK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D36F6C4CEE4;
	Tue, 11 Feb 2025 10:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739269232;
	bh=9lfDDB4rPknt5HbAKTNtzSaIA0xDJDNjOynJmOPHlww=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Wq/SldKKohls9L9zYrH4MQRYuMqwGfi2zjJVZwBuaNe/hJgqgOBAxn86Np0sygFlr
	 VjM6FNh9QxQnmC0fRI5cDzFZqEewMdcfiOA3t+Bb22o+I3NsMgQwOGlMLLv1XOE8kl
	 2MFWWG0RE8gxSVHERYQDqwXmoPJVsgRPS+4dkn9GHo1qxt7tUvDaFHRETowVa7zSp4
	 p8IiwNiTfpfDMuftOrfBXNzq4tFM4IyBtqWxECmbecIrV3FoNJ6S+5CVLRFP0cSUxh
	 CwyPLqIhzB1izTsBM/bzyvD4+HvcLEpgjn1mFqj8vfNL0ZfsX/uZDoGVBCHjTZ/emU
	 Aa87q2ahTP8kA==
Message-ID: <3da61b9b-fa44-4a45-bccb-40a23ef997ce@kernel.org>
Date: Tue, 11 Feb 2025 10:20:27 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] bpftool: Check map name length when map create
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
References: <tencent_1C4444032C2188ACD04B4995B0D78F510607@qq.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <tencent_1C4444032C2188ACD04B4995B0D78F510607@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2025-02-11 16:45 UTC+0800 ~ Rong Tao <rtoax@foxmail.com>
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
> ---
>  tools/bpf/bpftool/map.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
> index ed4a9bd82931..fa00f7865065 100644
> --- a/tools/bpf/bpftool/map.c
> +++ b/tools/bpf/bpftool/map.c
> @@ -1330,6 +1330,12 @@ static int do_create(int argc, char **argv)
>  		goto exit;
>  	}
>  
> +	if (strlen(map_name) > BPF_OBJ_NAME_LEN - 1) {
> +		p_err("The map name is too long, should be less than %d\n",


Nit: I'd drop "The" (and the capital letter) for consistency with other
messages in bpftool; and I'd replace "less than ..." with "no longer
than %d characters\n" to make it explicit and avoid confusion between
"strictly less" and "less or equal".


> +		      BPF_OBJ_NAME_LEN - 1);
> +		goto exit;
> +	}
> +
>  	set_max_rlimit();
>  
>  	fd = bpf_map_create(map_type, map_name, key_size, value_size, max_entries, &attr);


There's no need to defer the check until after we've parsed all
arguments. Can you move it to the location where we retrieve the name,
please?:

		[...]
		} else if (is_prefix(*argv, "name")) {
			NEXT_ARG();
			map_name = GET_ARG();
		} else ...

pw-bot: cr

Apart from these, it's a good idea to fix it, thank you!
Quentin

