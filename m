Return-Path: <bpf+bounces-64061-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA39BB0DFD8
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 17:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09C225422A7
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 15:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980E02EBBA3;
	Tue, 22 Jul 2025 15:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JnxN5b7v"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9F32EAB9D;
	Tue, 22 Jul 2025 15:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753196483; cv=none; b=UXXi/corK8D1Dz/oDXd1sRG5LejpettSix/1iQ6xMqymybhmkBYbYTYRWUnubj1InI0A66W/k7wGPK8L66biuHN2GLtQPvmKBjq3Gfmx5mhNGIExlNsjDivSV0bEY36ubxq3L43hqIKDp5IdN4dSWMs9GfdvkAi+O4simCOXbgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753196483; c=relaxed/simple;
	bh=ODw7MX6fJ+xbDJFpC64OYpS7OWsjIRt61ZkUvAYMTo8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n9rmB8J4RiFdUPUG4bJQi+6vK4TFEmIY8fS3jOFr+8amTyoEQWn+4Gx7Ocibso+t6hS2HBSESjRTRYL5NHriA134wqdXDowpxIxK6pQMuddz+3bIGKpuy2FKzqe9vMMs8Mi/uxjOdFFIBKdTsidn7srkEvmHS+P8v8ursPLTU4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JnxN5b7v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4A45C4CEF1;
	Tue, 22 Jul 2025 15:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753196482;
	bh=ODw7MX6fJ+xbDJFpC64OYpS7OWsjIRt61ZkUvAYMTo8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JnxN5b7vIB4F83m6cRVPf8eXyh86jbEGwTq6a7YSGVEE8APm3sVbjLlFBC9HkTWRL
	 Td3jq9VZ9yNPW4RUfo1EFLZ84rKCbhKP5iyViQ6+bxjoeYxkRQDR+Igw1b2JvkYuRq
	 TdryU5AC32FvhIFixHr6MgVpUx8A3970YZRT1W6LMSEC2WOJw1+uKazNGNYidBP9lp
	 +82MYDvbr8wZQ5MoHHUcrpUGvixRNKmw80BMTVlxDGXgWkX8RSToVoyE2NOVDS0JOT
	 YYxQ51oJ4kZdWLVww0OVQa3p/96vfCDC9+fmH/kX2KfAYwB4BlWy9rqikj8B2L0vYp
	 w0QTOZgqdtFhg==
Message-ID: <4dcd2d25-5955-4364-9b6a-42d66dee0a6b@kernel.org>
Date: Tue, 22 Jul 2025 16:01:18 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 1/3] bpftool: Add bpf_token show
To: Tao Chen <chen.dylane@linux.dev>, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
 kuba@kernel.org, hawk@kernel.org
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20250722115815.1390761-1-chen.dylane@linux.dev>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20250722115815.1390761-1-chen.dylane@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2025-07-22 19:58 UTC+0800 ~ Tao Chen <chen.dylane@linux.dev>
> Add `bpftool token show` command to get token info
> from bpffs in /proc/mounts.
> 
> Example plain output for `token show`:
> token_info  /sys/fs/bpf/token
> 	allowed_cmds:
> 	  map_create          prog_load
> 	allowed_maps:
> 	allowed_progs:
> 	  kprobe
> 	allowed_attachs:
> 	  xdp
> token_info  /sys/fs/bpf/token2
> 	allowed_cmds:
> 	  map_create          prog_load
> 	allowed_maps:
> 	allowed_progs:
> 	  kprobe
> 	allowed_attachs:
> 	  xdp
> 
> Example json output for `token show`:
> [{
> 	"token_info": "/sys/fs/bpf/token",
> 	"allowed_cmds": ["map_create", "prog_load"],
> 	"allowed_maps": [],
> 	"allowed_progs": ["kprobe"],
> 	"allowed_attachs": ["xdp"]
> }, {
> 	"token_info": "/sys/fs/bpf/token2",
> 	"allowed_cmds": ["map_create", "prog_load"],
> 	"allowed_maps": [],
> 	"allowed_progs": ["kprobe"],
> 	"allowed_attachs": ["xdp"]
> }]
> 
> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> ---

> diff --git a/tools/bpf/bpftool/token.c b/tools/bpf/bpftool/token.c
> new file mode 100644
> index 00000000000..f72a116f9c6
> --- /dev/null
> +++ b/tools/bpf/bpftool/token.c

> +static int show_token_info(void)
> +{
> +	FILE *fp;
> +	struct mntent *ent;
> +	bool hit = false;
> +
> +	fp = setmntent(MOUNTS_FILE, "r");
> +	if (!fp) {
> +		p_err("Failed to open: %s", MOUNTS_FILE);
> +		return -1;
> +	}
> +
> +	if (json_output)
> +		jsonw_start_array(json_wtr);
> +
> +	while ((ent = getmntent(fp)) != NULL) {
> +		if (strncmp(ent->mnt_type, "bpf", 3) == 0) {
> +			if (has_delegate_options(ent->mnt_opts)) {
> +				__show_token_info(ent);
> +				hit = true;
> +			}
> +		}
> +	}
> +
> +	if (json_output)
> +		jsonw_end_array(json_wtr);
> +
> +	if (!hit)
> +		p_info("Token info not found");

Woops I take this one back. It made sense to have a p_info() message in
your v1 because you were only looking at one bpffs mount point, but now
we list all the ones we find, we should remove this message and silently
ignore mount points without token info (and I think we can remove the
"hit" variable entirely). Sorry! :)

The rest of this patch looks good to me, thank you

Quentin

