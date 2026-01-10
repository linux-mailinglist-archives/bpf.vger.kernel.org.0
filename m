Return-Path: <bpf+bounces-78442-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D54FD0CDB2
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 03:48:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 155AA3025F9F
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 02:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D852737EE;
	Sat, 10 Jan 2026 02:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cKzs2ijA"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CAB19F40B;
	Sat, 10 Jan 2026 02:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768013323; cv=none; b=YHpBAqSkt/vzStGotyY+yfZhnfcyEj+EOFHjkkpywdeQ6YqBbdx5lKAhbCVcigaE9PBpjSz9wh7GmxfTlFRKJNBnbd0wg+M7p5vBO+k3mjQKMpVTo3JC769vIiROvb+JkGE3wZbMt0UpV7jzIvTPgjyzItTCvgZuj8WzjCULEd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768013323; c=relaxed/simple;
	bh=aHklHrw3blkZTH/0dkEA0bbd0UzqokyvlwjwMUkFJ+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aqUBwjg1H6NYb07h7Ih1LpNHd4+MtukAYRXsaUfWAKoyj98YD/YSbh3dmBE7lzelLuOcxOGFmyEBYbckf/l/vaimb+SGeaaapovxdCwe9S5+gYLkH/7xp/YboqFswAILH/kTapOdIRd9bT1ih+vGx6ONShLpAakUMF7H5BZ54ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cKzs2ijA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5285C4CEF1;
	Sat, 10 Jan 2026 02:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768013322;
	bh=aHklHrw3blkZTH/0dkEA0bbd0UzqokyvlwjwMUkFJ+I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cKzs2ijAhsSN1EV6QfNfuKlh6Xv3xXPxVPuj1DgzWBT5IvHwSwBP4bjd29GV4s8ZR
	 hWoI8MRq0Cbuy1z2IJ3BwNwUF8Z+w+J86aAjZVSx4zIqEcm8nB/jln5PkJdNtYZrYx
	 3hYih38pJYJkTpuzxVdHYXp2SvvPtbychTu0zlLV2pXSUE7SY2WYFIiQdYOMJyV9/P
	 iODqPP0R0xzrPHEBYuOfrAfpf1JzzhFNMrGTLAFIgY0xeVDPTmZv/j1YDxx9lHtB+3
	 eniLuTxdJr6uNm5dteGR99PuUA0IbOcvSksvAhNzvxjYDw1dCQ4S9yRQFnxSxfRWGL
	 dNC8gS5bOoNlg==
Message-ID: <2886aafa-871f-4bc2-9d7b-3dc69f3a5424@kernel.org>
Date: Sat, 10 Jan 2026 02:48:36 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] bpftool: Add 'prepend' option for tcx attach to insert
 at chain start
To: gyutae.opensource@navercorp.com, bpf@vger.kernel.org,
 Daniel Borkmann <daniel@iogearbox.net>
Cc: linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Gyutae Bae <gyutae.bae@navercorp.com>,
 Siwan Kim <siwan.kim@navercorp.com>, Daniel Xu <dxu@dxuuu.xyz>,
 Jiayuan Chen <jiayuan.chen@linux.dev>, Tao Chen <chen.dylane@linux.dev>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
References: <43c23468-530b-45f3-af22-f03484e5148c@kernel.org>
 <20260107022911.81672-1-gyutae.opensource@navercorp.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20260107022911.81672-1-gyutae.opensource@navercorp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/01/2026 02:29, gyutae.opensource@navercorp.com wrote:
> From: Gyutae Bae <gyutae.bae@navercorp.com>
> 
> Add support for the 'prepend' option when attaching tcx_ingress and
> tcx_egress programs. This option allows inserting a BPF program at
> the beginning of the TCX chain instead of appending it at the end.
> 
> The implementation uses BPF_F_BEFORE flag which automatically inserts
> the program at the beginning of the chain when no relative reference
> is specified.
> 
> This change includes:
> - Modify do_attach_tcx() to support prepend insertion using BPF_F_BEFORE
> - Update documentation to describe the new 'prepend' option
> - Add bash completion support for the 'prepend' option on tcx attach types
> - Add example usage in the documentation
> 
> The 'prepend' option is only valid for tcx_ingress and tcx_egress attach
> types. For XDP attach types, the existing 'overwrite' option remains
> available.
> 
> Example usage:
>   # bpftool net attach tcx_ingress name tc_prog dev lo prepend
> 
> This feature is useful when the order of program execution in the TCX
> chain matters and users need to ensure certain programs run first.
> 
> Co-developed-by: Siwan Kim <siwan.kim@navercorp.com>
> Signed-off-by: Siwan Kim <siwan.kim@navercorp.com>
> Signed-off-by: Gyutae Bae <gyutae.bae@navercorp.com>
> ---
> Hi Daniel.
> 
> Thank you for the detailed feedback. Thanks to your explanation,
> I now understand that BPF_F_BEFORE and BPF_F_AFTER work as standalone flags.
> This has made the implementation much simpler and cleaner.
> 
> Thanks,
> Gyutae.
> 
> Changes in v3:
> - Simplified implementation by using BPF_F_BEFORE alone (Daniel)
> - Removed get_first_tcx_prog_id() helper function (Daniel)
> 
> Changes in v2:
> - Renamed 'head' to 'prepend' for consistency with 'overwrite' (Quentin)
> - Moved relative_id variable to relevant scope inside if block (Quentin)
> - Changed condition style from '== 0' to '!' (Quentin)
> - Updated documentation to clarify 'overwrite' is XDP-only (Quentin)
> - Removed outdated "only XDP-related modes are supported" note (Quentin)
> - Removed extra help text from do_help() for consistency (Quentin)
> 
>  .../bpf/bpftool/Documentation/bpftool-net.rst | 30 ++++++++++++++-----
>  tools/bpf/bpftool/bash-completion/bpftool     |  9 +++++-
>  tools/bpf/bpftool/net.c                       | 23 +++++++++++---
>  3 files changed, 50 insertions(+), 12 deletions(-)
> 

[...]

> diff --git a/tools/bpf/bpftool/net.c b/tools/bpf/bpftool/net.c
> index cfc6f944f7c3..1a2ba3312a82 100644
> --- a/tools/bpf/bpftool/net.c
> +++ b/tools/bpf/bpftool/net.c
> @@ -666,10 +666,16 @@ static int get_tcx_type(enum net_attach_type attach_type)
>  	}
>  }
> 
> -static int do_attach_tcx(int progfd, enum net_attach_type attach_type, int ifindex)
> +static int do_attach_tcx(int progfd, enum net_attach_type attach_type, int ifindex, bool prepend)
>  {
>  	int type = get_tcx_type(attach_type);
> 
> +	if (prepend) {
> +		LIBBPF_OPTS(bpf_prog_attach_opts, opts,
> +			.flags = BPF_F_BEFORE
> +		);
> +		return bpf_prog_attach_opts(progfd, ifindex, type, &opts);
> +	}
>  	return bpf_prog_attach(progfd, ifindex, type, 0);
>  }
> 
> @@ -685,6 +691,7 @@ static int do_attach(int argc, char **argv)
>  	enum net_attach_type attach_type;
>  	int progfd, ifindex, err = 0;
>  	bool overwrite = false;
> +	bool prepend = false;
> 
>  	/* parse attach args */
>  	if (!REQ_ARGS(5))
> @@ -710,8 +717,16 @@ static int do_attach(int argc, char **argv)
>  	if (argc) {
>  		if (is_prefix(*argv, "overwrite")) {
>  			overwrite = true;


Just one minor thing, can we error out here if the attach type is tcx
please? Like you do for "prepend" below, when it's not tcx. So that we
don't let users believe they're overwriting their program.


> +		} else if (is_prefix(*argv, "prepend")) {
> +			if (attach_type != NET_ATTACH_TYPE_TCX_INGRESS &&
> +			    attach_type != NET_ATTACH_TYPE_TCX_EGRESS) {
> +				p_err("'prepend' is only supported for tcx_ingress/tcx_egress");
> +				err = -EINVAL;
> +				goto cleanup;
> +			}
> +			prepend = true;
>  		} else {
> -			p_err("expected 'overwrite', got: '%s'?", *argv);
> +			p_err("expected 'overwrite' or 'prepend', got: '%s'?", *argv);
>  			err = -EINVAL;
>  			goto cleanup;
>  		}


Looks good otherwise, thank you! Pending that change:

Reviewed-by: Quentin Monnet <qmo@kernel.org>

