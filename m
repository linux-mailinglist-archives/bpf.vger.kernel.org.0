Return-Path: <bpf+bounces-73242-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C93C9C28267
	for <lists+bpf@lfdr.de>; Sat, 01 Nov 2025 17:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6EE254E6E14
	for <lists+bpf@lfdr.de>; Sat,  1 Nov 2025 16:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC59A232785;
	Sat,  1 Nov 2025 16:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CZrF5ckD"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397797261E;
	Sat,  1 Nov 2025 16:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762014103; cv=none; b=Mvj7D8+Jj/f/zuiTHGM5A0MkbCVxjRZm8DqBu7myeu7KAmmAHVchDMmCWmkHMXG1lK22zNYsUQz85E1JYBjMehUPATcCkJHZ79zBmw3eV0oJqwuPuYD4rD9jRG/rNm8q9C0d+BBqd7289+EG0mcwXBVLPeQRjlHPdoytMlLsd4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762014103; c=relaxed/simple;
	bh=Km66RJwQQxV+8CR2ObsBdUgb7ngLhyd9lGAsheFjTAs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=JfDRDooaFPiD040dVc7pCeYdVbKB6XTzzvvcIxmStoSAFHmlgEfX38/gnWsJiAoE+5udkIB5QKBwBZEDgjgj47OsBo6X5Xdw1mKjV27SRwpz6RNiaWlHlbjVIFxLpsLrs5B/Ix9HGnL9RA+aLiN2gpwYmiaCTfmaS3TeT9u3qNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CZrF5ckD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19C97C4CEF1;
	Sat,  1 Nov 2025 16:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762014102;
	bh=Km66RJwQQxV+8CR2ObsBdUgb7ngLhyd9lGAsheFjTAs=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=CZrF5ckDZ43GO7b3JaA6tiFFfclnDYyDtXWdegKPnQzzucZUGfqj2Jxi1EyhTJqrq
	 6T9cR8P7Q2HDlWJ4+VHhzYRfWVc6B6zuqXlDy368CW+7X0xGdBsG9BJfzYK5+aPYFF
	 52hdE8mY9SJ2jIo6VlqsKEuetoNrLrtqxU+Di8MgnqMYqvOUWgQtexrnsnadFVExtc
	 /NX2gZMR3e44NYyOM168cOOTwfVZmEr+gkZrUXe+HaLV12+ZPpED2Ee3P0bWmD8bqi
	 l65gFK54w1lhgcDGohXHMxxidl3y1MCCVd/lYCRnRgeYmy1mRyX8ct96eLtrlr1T2D
	 LFKw3FtTz01pA==
Message-ID: <43c23468-530b-45f3-af22-f03484e5148c@kernel.org>
Date: Sat, 1 Nov 2025 16:21:37 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Quentin Monnet <qmo@kernel.org>
Subject: Re: [PATCH] bpftool: Add 'head' option for tcx attach to insert at
 chain start
To: Gyutae Bae <gyutae.bae@navercorp.com>, bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Siwan Kim <siwan.kim@navercorp.com>,
 Daniel Xu <dxu@dxuuu.xyz>, Jiayuan Chen <jiayuan.chen@linux.dev>,
 Tao Chen <chen.dylane@linux.dev>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
References: <20251023093150.25411-1-gyutae.bae@navercorp.com>
Content-Language: en-GB
In-Reply-To: <20251023093150.25411-1-gyutae.bae@navercorp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2025-10-23 18:31 UTC+0900 ~ Gyutae Bae <gyutae.bae@navercorp.com>
> Add support for the 'head' option when attaching tcx_ingress and
> tcx_egress programs. This option allows inserting a BPF program at
> the beginning of the TCX chain instead of appending it at the end.
> 
> The implementation queries the first program ID in the chain and uses
> BPF_F_BEFORE flag with the relative_id to insert the new program before
> the existing first program. If the chain is empty, the program is simply
> attached normally.
> 
> This change includes:
> - Add get_first_tcx_prog_id() helper to retrieve the first program ID
> - Modify do_attach_tcx() to support head insertion using BPF_F_BEFORE
> - Update documentation to describe the new 'head' option
> - Add bash completion support for the 'head' option on tcx attach types
> - Add example usage in the documentation
> 
> The 'head' option is only valid for tcx_ingress and tcx_egress attach
> types. For XDP attach types, the existing 'overwrite' option remains
> available.
> 
> Example usage:
>   # bpftool net attach tcx_ingress name tc_prog dev lo head
> 
> This feature is useful when the order of program execution in the TCX
> chain matters and users need to ensure certain programs run first.


Hi, thank you for this patch!

Sorry for the delay, your message was filtered as spam for some reason
and I just found it today; I note that I can't find it on Patchwork or
on Lore either, so you'll have to resend it. I also have some comments,
inline below.


> 
> Co-developed-by: Siwan Kim <siwan.kim@navercorp.com>
> Signed-off-by: Siwan Kim <siwan.kim@navercorp.com>
> Signed-off-by: Gyutae Bae <gyutae.bae@navercorp.com>
> ---
>  .../bpf/bpftool/Documentation/bpftool-net.rst | 17 ++++++-
>  tools/bpf/bpftool/bash-completion/bpftool     |  9 +++-
>  tools/bpf/bpftool/net.c                       | 51 +++++++++++++++++--
>  3 files changed, 70 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/Documentation/bpftool-net.rst b/tools/bpf/bpftool/Documentation/bpftool-net.rst
> index a9ed8992800f..e161039a7d1e 100644
> --- a/tools/bpf/bpftool/Documentation/bpftool-net.rst
> +++ b/tools/bpf/bpftool/Documentation/bpftool-net.rst
> @@ -24,7 +24,7 @@ NET COMMANDS
>  ============
>  
>  | **bpftool** **net** { **show** | **list** } [ **dev** *NAME* ]
> -| **bpftool** **net attach** *ATTACH_TYPE* *PROG* **dev** *NAME* [ **overwrite** ]
> +| **bpftool** **net attach** *ATTACH_TYPE* *PROG* **dev** *NAME* [ **overwrite** | **head** ]


How about "prepend" rather than "head"? The meaning would be more
explicit to me, and it would be consistent with "overwrite", which is a
verb as well.


>  | **bpftool** **net detach** *ATTACH_TYPE* **dev** *NAME*
>  | **bpftool** **net help**
>  |
> @@ -72,6 +72,10 @@ bpftool net attach *ATTACH_TYPE* *PROG* dev *NAME* [ overwrite ]
>      **tcx_ingress** - Ingress TCX. runs on ingress net traffic;
>      **tcx_egress** - Egress TCX. runs on egress net traffic;
>  
> +    For **tcx_ingress** and **tcx_egress** attach types, the **head** option
> +    can be used to attach the program at the beginning of the chain instead of
> +    at the end.


Thanks! Would you mind updating the description of the "overwrite"
keyword above this, to mention that "overwrite" only applies to
XDP-related types (and to remove the note saying only XDP-related types
are supported by the command, while at it)?


> +
>  bpftool net detach *ATTACH_TYPE* dev *NAME*
>      Detach bpf program attached to network interface *NAME* with type specified
>      by *ATTACH_TYPE*. To detach bpf program, same *ATTACH_TYPE* previously used
> @@ -191,6 +195,17 @@ EXAMPLES
>        tc:
>        lo(1) tcx/ingress tc_prog prog_id 29
>  
> +|
> +| **# bpftool net attach tcx_ingress name tc_prog2 dev lo head**
> +| **# bpftool net**
> +|
> +
> +::
> +
> +      tc:
> +      lo(1) tcx/ingress tc_prog2 prog_id 30
> +      lo(1) tcx/ingress tc_prog prog_id 29
> +
>  |
>  | **# bpftool net attach tcx_ingress name tc_prog dev lo**
>  | **# bpftool net detach tcx_ingress dev lo**
> diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
> index 53bcfeb1a76e..7aba07e8629d 100644
> --- a/tools/bpf/bpftool/bash-completion/bpftool
> +++ b/tools/bpf/bpftool/bash-completion/bpftool
> @@ -1142,7 +1142,14 @@ _bpftool()
>                              return 0
>                              ;;
>                          8)
> -                            _bpftool_once_attr 'overwrite'
> +                            case ${words[3]} in
> +                                tcx_ingress|tcx_egress)
> +                                    _bpftool_once_attr 'head'
> +                                    ;;
> +                                *)
> +                                    _bpftool_once_attr 'overwrite'
> +                                    ;;
> +                            esac


Thanks for this!


>                              return 0
>                              ;;
>                      esac
> diff --git a/tools/bpf/bpftool/net.c b/tools/bpf/bpftool/net.c
> index cfc6f944f7c3..d8408a109478 100644
> --- a/tools/bpf/bpftool/net.c
> +++ b/tools/bpf/bpftool/net.c
> @@ -637,6 +637,25 @@ static int net_parse_dev(int *argc, char ***argv)
>  	return ifindex;
>  }
>  
> +static int get_first_tcx_prog_id(int ifindex, enum bpf_attach_type type, __u32 *first_id)
> +{
> +	int ret;
> +
> +	LIBBPF_OPTS(bpf_prog_query_opts, optq);
> +	__u32 prog_ids[1] = {};
> +
> +	optq.prog_ids = prog_ids;
> +	optq.count = ARRAY_SIZE(prog_ids);
> +
> +	ret = bpf_prog_query_opts(ifindex, type, &optq);
> +
> +	if (ret == 0 && optq.count > 0) {
> +		*first_id = prog_ids[0];
> +		return 0;
> +	}
> +	return -1;
> +}
> +
>  static int do_attach_detach_xdp(int progfd, enum net_attach_type attach_type,
>  				int ifindex, bool overwrite)
>  {
> @@ -666,10 +685,20 @@ static int get_tcx_type(enum net_attach_type attach_type)
>  	}
>  }
>  
> -static int do_attach_tcx(int progfd, enum net_attach_type attach_type, int ifindex)
> +static int do_attach_tcx(int progfd, enum net_attach_type attach_type, int ifindex, bool head)
>  {
>  	int type = get_tcx_type(attach_type);
> -
> +	__u32 relative_id = 0;


Nit: Please move relative_id to the relevant scope, we don't need it
defined if "head" is false.


> +
> +	if (head) {
> +		if (get_first_tcx_prog_id(ifindex, type, &relative_id) == 0) {


Nit:

    if (!get_first_tcx_prog_id(ifindex, type, &relative_id)) {


> +			LIBBPF_OPTS(bpf_prog_attach_opts, opts,
> +				.flags = BPF_F_BEFORE | BPF_F_ID,
> +				.relative_id = relative_id
> +			);
> +			return bpf_prog_attach_opts(progfd, ifindex, type, &opts);
> +		}
> +	}
>  	return bpf_prog_attach(progfd, ifindex, type, 0);
>  }
>  
> @@ -685,6 +714,7 @@ static int do_attach(int argc, char **argv)
>  	enum net_attach_type attach_type;
>  	int progfd, ifindex, err = 0;
>  	bool overwrite = false;
> +	bool head = false;
>  
>  	/* parse attach args */
>  	if (!REQ_ARGS(5))
> @@ -710,8 +740,16 @@ static int do_attach(int argc, char **argv)
>  	if (argc) {
>  		if (is_prefix(*argv, "overwrite")) {
>  			overwrite = true;


Note: Not directly related to your contribution, but we could also
filter program types here for the "overwrite" keyword, and raise an
error if it's not an XDP-related type, because we don't overwrite
existing programs for TCX (I think we silently ignore the keyword, at
the moment - not great)


> +		} else if (is_prefix(*argv, "head")) {
> +			if (attach_type != NET_ATTACH_TYPE_TCX_INGRESS &&
> +			    attach_type != NET_ATTACH_TYPE_TCX_EGRESS) {
> +				p_err("'head' is only supported for tcx_ingress/tcx_egress");
> +				err = -EINVAL;
> +				goto cleanup;
> +			}
> +			head = true;
>  		} else {
> -			p_err("expected 'overwrite', got: '%s'?", *argv);
> +			p_err("expected 'overwrite' or 'head', got: '%s'?", *argv);
>  			err = -EINVAL;
>  			goto cleanup;
>  		}
> @@ -728,7 +766,7 @@ static int do_attach(int argc, char **argv)
>  	/* attach tcx prog */
>  	case NET_ATTACH_TYPE_TCX_INGRESS:
>  	case NET_ATTACH_TYPE_TCX_EGRESS:
> -		err = do_attach_tcx(progfd, attach_type, ifindex);
> +		err = do_attach_tcx(progfd, attach_type, ifindex, head);
>  		break;
>  	default:
>  		break;
> @@ -985,7 +1023,7 @@ static int do_help(int argc, char **argv)
>  
>  	fprintf(stderr,
>  		"Usage: %1$s %2$s { show | list } [dev <devname>]\n"
> -		"       %1$s %2$s attach ATTACH_TYPE PROG dev <devname> [ overwrite ]\n"
> +		"       %1$s %2$s attach ATTACH_TYPE PROG dev <devname> [ overwrite | head ]\n"
>  		"       %1$s %2$s detach ATTACH_TYPE dev <devname>\n"
>  		"       %1$s %2$s help\n"
>  		"\n"
> @@ -994,6 +1032,9 @@ static int do_help(int argc, char **argv)
>  		"                        | tcx_egress }\n"
>  		"       " HELP_SPEC_OPTIONS " }\n"
>  		"\n"
> +		"      For tcx_ingress/tcx_egress attach types:\n"
> +		"      head - option attaches the program at the beginning of the chain.\n"
> +		"\n"


I would probably drop that note. Not because it's incorrect, but because
we don't list or explain all keywords in the interactive help for other
commands and it's something that should remain consistent. The
documentation for such keywords at the moment is the man page, I don't
really want a mix of man pages and "--help" description that gets out of
sync.


>  		"Note: Only xdp, tcx, tc, netkit, flow_dissector and netfilter attachments\n"
>  		"      are currently supported.\n"
>  		"      For progs attached to cgroups, use \"bpftool cgroup\"\n"


