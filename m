Return-Path: <bpf+bounces-51246-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4C9A324BC
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 12:23:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0DB43A1F7F
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 11:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ABD320B7F1;
	Wed, 12 Feb 2025 11:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j9oYcWyE"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5B820B20B;
	Wed, 12 Feb 2025 11:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739359394; cv=none; b=NPWzO0fAcDM2OntUYkbwGi35Lu+3QglYPWTECG57ROmW1Va3XkEhRouhP1m80zEzT1Cob8FgsmSIFRGPSAdyO8IWS/6M9RUPX9ULeYZxFu+xVYYmv9Xq2Zz6y0KO7dSGbOshPK3TSRJ3G+Qqc3ZHqVcz4Jd8RsvC6Rfw4DYbKrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739359394; c=relaxed/simple;
	bh=AFkdpmQGP5sZCinnR86xf7GsJoERsE6FIzmh5/b05Wc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VkWAS+w+HWvDkm4oCD6M+g0FqkQC2LO4rOJAXnA+5xIGvui43k5JxHpaBCY2P3/SrZlDX5zYrr4fDnd/ZCoZTOczZmK5/R2dk3K3LnEKKub5sRhiGoSZ+4fDkOmbEGbHJEuwiFvn9BOe93P9B8fNY1h1FtoKDVaAh4Lm4xmxDGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j9oYcWyE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FD78C4CEEA;
	Wed, 12 Feb 2025 11:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739359393;
	bh=AFkdpmQGP5sZCinnR86xf7GsJoERsE6FIzmh5/b05Wc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=j9oYcWyET1Y99zTPzXgG1tUszc57+SXSP9vsTdJewDv42tUKYzpNHJs32gdtQGDyO
	 znZM6aYzVP66470OQhaejv6lzBkCJZJXegPvQVkdWL8YUixxiAb0FR2V8axhCBt29p
	 7kotXdoXw/0C9DMPmfX24b87QpgXMSy8zp9iPLZIa+gxS01rckXqrUBgKn/nZvg62E
	 Y/7BEYPNhywmURoNgHmCeLYFSsAonZhz4/Z5W4SmvbXDcFff54/g+VnWmvt+5/E4/b
	 DQOjhw91HW6tkkxnWzHRdtdcZoXSf8ZTz1WFP5FX6o70af6uXQmvluf5V9zN+LQPBn
	 wNRnErW8CI+Rw==
Message-ID: <3541c732-9c7a-4de9-b658-c194fd52a361@kernel.org>
Date: Wed, 12 Feb 2025 11:23:09 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3] bpftool: Check map name length when map
 create
To: Rong Tao <rtoax@foxmail.com>, andrii.nakryiko@gmail.com, ast@kernel.org,
 daniel@iogearbox.net
Cc: Rong Tao <rongtao@cestc.cn>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>,
 "open list:BPF [TOOLING] (bpftool)" <bpf@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <tencent_AF066A426F591F977D2A73AF00A34A883808@qq.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <tencent_AF066A426F591F977D2A73AF00A34A883808@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2025-02-12 09:20 UTC+0800 ~ Rong Tao <rtoax@foxmail.com>
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
> The map name provided in the command line is truncated, but no warning is
> reported. This submission checks the length of the map name.
> 
> Reviewed-by: Quentin Monnet <qmo@kernel.org>
> Signed-off-by: Rong Tao <rongtao@cestc.cn>
> ---
> v2: https://lore.kernel.org/lkml/tencent_26592A2BAF08A3A688A50600421559929708@qq.com/
> v1: https://lore.kernel.org/lkml/tencent_1C4444032C2188ACD04B4995B0D78F510607@qq.com/
> ---
>  tools/bpf/bpftool/map.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
> index ed4a9bd82931..9617e64d3d11 100644
> --- a/tools/bpf/bpftool/map.c
> +++ b/tools/bpf/bpftool/map.c
> @@ -1270,6 +1270,10 @@ static int do_create(int argc, char **argv)
>  		} else if (is_prefix(*argv, "name")) {
>  			NEXT_ARG();
>  			map_name = GET_ARG();
> +			if (strlen(map_name) > BPF_OBJ_NAME_LEN - 1) {
> +				p_info("Warning: map name is longer than %d characters, it will be truncated.\n",


Change looks mostly good, thanks! Two small things to address with this
message string:

- Please remove the trailing '\n', p_info() adds it already.
- Please replace %d with %u. The value is unsigned, and we've merged a
commit to clean these up recently, 17c3dc50294b ("bpftool: Using the
right format specifiers").


> +				      BPF_OBJ_NAME_LEN - 1);
> +			}
>  		} else if (is_prefix(*argv, "key")) {
>  			if (parse_u32_arg(&argc, &argv, &key_size,
>  					  "key size"))


