Return-Path: <bpf+bounces-59497-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25CCCACC440
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 12:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D626D171DFA
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 10:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3231D5CC4;
	Tue,  3 Jun 2025 10:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fulRfTzz"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1104A4A0C;
	Tue,  3 Jun 2025 10:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748946150; cv=none; b=Tz5LHrFx2M4rSjD0R+mvOwiwYLLBk+432DZ+k1wTBjyNW5vcAtg/WPzuw/g48iNkXwd+TgEBIGl64koQBKmMUKCtQBuzlk3OnEgJdHuIMWXWnRReLmmt6jNcZwB0Itm8zw98Z3ioBkSvu40K1GZ0bUdeY+dyVmKIMyatoNteS2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748946150; c=relaxed/simple;
	bh=e7yqMDg2vt7z+8aK8lyIZJlFr72PvieQH9tXRFDemD0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BIBZshbq4K17W6uUMP1x4iUENSQRbAvKauCWvpTpyaND5teMOjnigv5pMagW/yYPGG4t4pcyJskGj8JESsFv+4/fyh27fPw5+psdXxOvAPWZU3R8A2tgmMyyyhW2KmZt8YyfyvpNxDj4dxAdjptB7qoQr86MBloNi4iEQ7XTAj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fulRfTzz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF38FC4CEED;
	Tue,  3 Jun 2025 10:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748946149;
	bh=e7yqMDg2vt7z+8aK8lyIZJlFr72PvieQH9tXRFDemD0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fulRfTzz+oUa0Xt8zcriYz8wY0yHxRbtSy2/Q4yPYHVkUrP/vfQjmTwvG1B+qETMg
	 6+tLpIKlMhxe3PZ4BH2T1iMebyAjPQfqDlnBUDdo70mGAeeBZnS8Ieu6RiCTWSGpKR
	 S5c3h0kmqWKqs2sA52HGb3U9j6AMGWlnnLl9KFrou+kB+1eNqGPUYRCrTwppEJrFrO
	 p+7zLSiwBaqlnca0Kq1atGY0wPfFx/ILKcy/V1Qwr5MtFuoUqS5L3atha2Ua1Xau6K
	 k9pb5T9Jyd4a6Gfk0P2LxrnrG6aZiDBIPqX4UEzYSfLY80nsFMChI/7IB8tqXTvn+6
	 KgJsW6QWLAZ1Q==
Message-ID: <736d2e41-5ee8-43d9-888e-954382fcca21@kernel.org>
Date: Tue, 3 Jun 2025 11:22:25 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 bpf-next 8/9] bpftool: add BTF dump "format meta" to
 dump header/metadata
To: Alan Maguire <alan.maguire@oracle.com>, andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 masahiroy@kernel.org, ihor.solodrai@linux.dev, dwarves@vger.kernel.org,
 bpf@vger.kernel.org, ttreyer@meta.com
References: <20250528095743.791722-1-alan.maguire@oracle.com>
 <20250528095743.791722-9-alan.maguire@oracle.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20250528095743.791722-9-alan.maguire@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2025-05-28 10:57 UTC+0100 ~ Alan Maguire <alan.maguire@oracle.com>
> Provide a way to dump BTF metadata info via bpftool; this
> consists of BTF size, header fields and kind layout info
> (if available); for example
> 
> $ bpftool btf dump file vmlinux format meta
> size 5169836
> magic 0xeb9f
> version 1
> flags 0x1
> hdr_len 40
> type_len 3041436
> type_off 0
> str_len 2128279
> str_off 3041436
> kind_layout_len 80
> kind_layout_off 5169716
> kind 0    UNKNOWN    flags 0x0    info_sz 0    elem_sz 0
> kind 1    INT        flags 0x0    info_sz 4    elem_sz 0
> kind 2    PTR        flags 0x0    info_sz 0    elem_sz 0
> kind 3    ARRAY      flags 0x0    info_sz 12   elem_sz 0
> kind 4    STRUCT     flags 0x0    info_sz 0    elem_sz 12
> ...
> 
> JSON output is also supported:
> 
> $ bpftool -j btf dump file vmlinux format meta | jq


Just so that you know, we have "bpftool -p" (which is the short version
for "bpftool --json --pretty") that will prettify the output without
requiring you to pipe to jq.


> {
>   "size": 5169836,
>   "header": {
>     "magic": 60319,
>     "version": 1,
>     "flags": 1,
>     "hdr_len": 40,
>     "type_len": 3041436,
>     "type_off": 0,
>     "str_len": 2128279,
>     "str_off": 3041436,
>     "kind_layout_len": 80,
>     "kind_layout_offset": 5169716,
>   },
>   "kind_layouts": [
>     {
>       "kind": 0,
>       "name": "UNKNOWN",
>       "flags": 0,
>       "info_sz": 0,
>       "elem_sz": 0
>     },
>     {
>       "kind": 1,
>       "name": "INT",
>       "flags": 0,
>       "info_sz": 4,
>       "elem_sz": 0
>     },
> ...
> 
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  tools/bpf/bpftool/bash-completion/bpftool |  2 +-
>  tools/bpf/bpftool/btf.c                   | 90 ++++++++++++++++++++++-
>  2 files changed, 88 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
> index 1ce409a6cbd9..8accc9e153a7 100644
> --- a/tools/bpf/bpftool/bash-completion/bpftool
> +++ b/tools/bpf/bpftool/bash-completion/bpftool
> @@ -928,7 +928,7 @@ _bpftool()
>                              return 0
>                              ;;
>                          format)
> -                            COMPREPLY=( $( compgen -W "c raw" -- "$cur" ) )
> +                            COMPREPLY=( $( compgen -W "c raw meta" -- "$cur" ) )
>                              ;;
>                          root_id)
>                              return 0;


Thanks for the bash completion; could you also please update bpftool's
documentation? The bpftool-btf.rst page (two locations: the "BTF
COMMANDS" summary at the top, and the command description - you could
even add the example from your commit description as an example at the
bottom of the page, if you'd like).


> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
> index 6b14cbfa58aa..686608fb7b6c 100644
> --- a/tools/bpf/bpftool/btf.c
> +++ b/tools/bpf/bpftool/btf.c
> @@ -835,6 +835,86 @@ static int dump_btf_c(const struct btf *btf,
>  	return err;
>  }
>  
> +static int dump_btf_meta(const struct btf *btf)
> +{
> +	const struct btf_header *hdr;
> +	const struct btf_kind_layout *k;
> +	__u8 i, nr_kinds = 0;
> +	const void *data;
> +	__u32 data_sz;
> +
> +	data = btf__raw_data(btf, &data_sz);
> +	if (!data)
> +		return -ENOMEM;
> +	hdr = data;
> +	if (json_output) {
> +		jsonw_start_object(json_wtr);		/* metadata object */
> +		jsonw_uint_field(json_wtr, "size", data_sz);
> +		jsonw_name(json_wtr, "header");
> +		jsonw_start_object(json_wtr);		/* header object */
> +		jsonw_uint_field(json_wtr, "magic", hdr->magic);
> +		jsonw_uint_field(json_wtr, "version", hdr->version);
> +		jsonw_uint_field(json_wtr, "flags", hdr->flags);
> +		jsonw_uint_field(json_wtr, "hdr_len", hdr->hdr_len);
> +		jsonw_uint_field(json_wtr, "type_len", hdr->type_len);
> +		jsonw_uint_field(json_wtr, "type_off", hdr->type_off);
> +		jsonw_uint_field(json_wtr, "str_len", hdr->str_len);
> +		jsonw_uint_field(json_wtr, "str_off", hdr->str_off);
> +	} else {
> +		printf("size %-10u\n", data_sz);
> +		printf("magic 0x%-10x\nversion %-10d\nflags 0x%-10x\nhdr_len %-10u\n",
> +		       hdr->magic, hdr->version, hdr->flags, hdr->hdr_len);
> +		printf("type_len %-10u\ntype_off %-10u\n", hdr->type_len, hdr->type_off);
> +		printf("str_len %-10u\nstr_off %-10u\n", hdr->str_len, hdr->str_off);
> +	}
> +
> +	if (hdr->hdr_len < sizeof(struct btf_header)) {
> +		if (json_output) {
> +			jsonw_end_object(json_wtr);	/* end header object */
> +			jsonw_end_object(json_wtr);	/* end metadata object */
> +		}
> +		return 0;
> +	}
> +	if (hdr->kind_layout_len > 0 && hdr->kind_layout_off > 0) {
> +		k = (void *)hdr + hdr->hdr_len + hdr->kind_layout_off;
> +		nr_kinds = hdr->kind_layout_len / sizeof(*k);
> +	}
> +	if (json_output) {
> +		jsonw_uint_field(json_wtr, "kind_layout_len", hdr->kind_layout_len);
> +		jsonw_uint_field(json_wtr, "kind_layout_offset", hdr->kind_layout_off);
> +		jsonw_end_object(json_wtr);		/* end header object */
> +
> +		if (nr_kinds > 0) {
> +			jsonw_name(json_wtr, "kind_layouts");
> +			jsonw_start_array(json_wtr);
> +			for (i = 0; i < nr_kinds; i++) {
> +				jsonw_start_object(json_wtr);
> +				jsonw_uint_field(json_wtr, "kind", i);
> +				if (i < NR_BTF_KINDS)
> +					jsonw_string_field(json_wtr, "name", btf_kind_str[i]);
> +				else
> +					jsonw_null_field(json_wtr, "name");


Thanks!


> +				jsonw_uint_field(json_wtr, "flags", k[i].flags);
> +				jsonw_uint_field(json_wtr, "info_sz", k[i].info_sz);
> +				jsonw_uint_field(json_wtr, "elem_sz", k[i].elem_sz);
> +				jsonw_end_object(json_wtr);
> +			}
> +			jsonw_end_array(json_wtr);
> +		}
> +		jsonw_end_object(json_wtr);		/* end metadata object */


Why not have the fields unconditionally in JSON?

	...
	  "kind_layout_len": 0,
	  "kind_layout_offset": 0,
	},
	"kind_layouts": [
	]

This would allow tools to know explicitely that there's no kind layout
info, or to loop on kind_layouts without having to check for existence
first.

If the fields are not set, I find it always difficult to know if there's
no kind info or if bpftool didn't support dumping the kind info (in that
case this concern doesn't really apply because we add support for kind
info dump and the "meta" format at the same time, but users don't
necessarily know that).

Thanks,
Quentin

