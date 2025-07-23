Return-Path: <bpf+bounces-64159-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 617BDB0F019
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 12:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 803BE188EA56
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 10:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24BA28CF47;
	Wed, 23 Jul 2025 10:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eDRfbOSn"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9E3286D7E;
	Wed, 23 Jul 2025 10:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753267212; cv=none; b=W0WEDyeh2HuICdx5FqqnUuyXYLny5CIqsuy+qXA/4mx33vq6MbiBvpygI3Pbf7XbzL82zEGIFk7w5Z8q59E3aji/rlatc1hlrknnY42WHAcx5URFvFAcGdJ5XzcXBBSzkuzfkqe9ZF59IRKOOvAyIEdMJtQzc9yZtaqYPGc7Os4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753267212; c=relaxed/simple;
	bh=MuzfPzq6Kx1Ph620ocMX1QX0+aapeqqAzwuBYPv1JL8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VzLsJqOE2FfMSyaiw199ip+MCSN1ubAxjpPns1K9LVVUfxi6zOxjalXjcYLfgJ4pjbOlx9skxNtV7cPNO0nVgORSDjbhEh/0MoaDZ/5l2n2ACFO5mXCJMve+aqr/L6XvoczgkQAKCJgzVmpO48xtjD+/xJQyqnLCvs0J5KXmOMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eDRfbOSn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C865AC4CEE7;
	Wed, 23 Jul 2025 10:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753267210;
	bh=MuzfPzq6Kx1Ph620ocMX1QX0+aapeqqAzwuBYPv1JL8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eDRfbOSn/l5uSIxpIjU27Z8RDS4DV6d0ADrVap0LcbGVCPOi9OGQRel9tYKbBCDdK
	 ByjJ3l3MFCeeeQ0UZtdepdjqSxRH/kmK9+qHXzfiw2Us43Ez9NkJnjW1lE4rFPHEjQ
	 SvEZ0L7VKsB5X9stWW0dfq8B2TiddmQsbaRF4tsoQ98S0keKHqYQNCTZ82Pvq8EFe3
	 Lke8ErrmBUbcjzxwAabD8UOwhC9HjEZvnJPoTdVh/Jbn7qq6CFAXjf0BZU2tzcF2lY
	 B75zy5z5PBDF+0OY7RN5F2HjlEW9xy86NnQLPMQV+zZZYoUBSl5GXRNmYKtbB9HMa1
	 DoVoatWIo5auw==
Message-ID: <1dd1a433-ecdf-437d-bc71-6d1b65b74cc8@kernel.org>
Date: Wed, 23 Jul 2025 11:40:06 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 1/3] bpftool: Add bpf_token show
To: Tao Chen <chen.dylane@linux.dev>, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
 kuba@kernel.org, hawk@kernel.org
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20250723033107.1411154-1-chen.dylane@linux.dev>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20250723033107.1411154-1-chen.dylane@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2025-07-23 11:31 UTC+0800 ~ Tao Chen <chen.dylane@linux.dev>
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

[...]

> diff --git a/tools/bpf/bpftool/token.c b/tools/bpf/bpftool/token.c
> new file mode 100644
> index 00000000000..06b56ea40b8
> --- /dev/null
> +++ b/tools/bpf/bpftool/token.c

[...]

> +static int do_help(int argc, char **argv)
> +{
> +	if (json_output) {
> +		jsonw_null(json_wtr);
> +		return 0;
> +	}
> +
> +	fprintf(stderr,
> +		"Usage: %1$s %2$s { show | list }\n"
> +		"	%1$s %2$s help\n"


One more nit: applying and testing the help message locally, I noticed
that the alignement is not correct:

    $ ./bpftool token help
    Usage: bpftool token { show | list }
            bpftool token help

The two "bpftool" should be aligned. This is because you use a tab for
indent on the "help" line. Can you please replace it with spaces to fix
indentation, and remain consistent with what other files do?

After that change, you can add:

    Reviewed-by: Quentin Monnet <qmo@kernel.org>

