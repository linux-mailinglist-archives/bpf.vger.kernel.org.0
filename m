Return-Path: <bpf+bounces-59495-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1433DACC33B
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 11:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D89CF188FFB5
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 09:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9395A281524;
	Tue,  3 Jun 2025 09:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XZG2M14i"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1971478C91;
	Tue,  3 Jun 2025 09:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748943411; cv=none; b=ayBuy64cwpQBgMGavzn6V43I6rxRZsB5c7vz9R1MsR4ywzKgG/NLb4ri1BcDUp1iIfbqlbXuWZnQWNqW4SSVg5PSiIcYlZeXFsL5/GcON9nEi/LxhNacvrTmb7K7e458ueNE6gnujJ6FpRXqdoTiistODaHz88nKiM58YePJV5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748943411; c=relaxed/simple;
	bh=y5NijpC1W+kaj0Db6iS/C/FXikX2cDrmNfwqHGZF9wY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IQhCHyK03I6kz/s3/LfQo1va1ZfMzfnaz5PqokZRdQmzLdMMJvfOShKR1jQ0N3JunZi8kUN8qqGnYZuB1Nkh2sFMJdWPT6H9xArOpo3XYB7e/32134W75P6SoHimp5+kcv/exeGsX23oNwP9mkA2qfW7dforuS60vsafgffh/3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XZG2M14i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8128AC4CEEF;
	Tue,  3 Jun 2025 09:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748943410;
	bh=y5NijpC1W+kaj0Db6iS/C/FXikX2cDrmNfwqHGZF9wY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XZG2M14i2pIgwU/dE4wgqR1O5udb2CfYWIVR4gvZxauprVJGINfLDovYq/c19TNwA
	 YXoehwNxFdiHjPhZ683gu13qqRWeXmR/jhjSLRrYAnuHENNN9hlALkMepuosf5/Ol0
	 x+l01FSzL7Us6cvwLH3EKRDscRQyg4v2tjDH5DR6FTsnzvz4nC3K9dU8lr8n+AoA1/
	 dCPj/L5JaqtlqhVMxMKQteFBhn6IYQ/bg4rt2g3giAMSRq84s5z0yp14DYar6LpiMB
	 HYdPW+O6TMj98pn9cJFCYHsJ4etq7WH5Lj8RtyK8+ytHt/VdkNK9z3Gvn/wUBgq9J8
	 fAWI/H3wPWTUA==
Message-ID: <c3b326ea-8d79-47c1-82b7-a9f2f46ab0c3@kernel.org>
Date: Tue, 3 Jun 2025 10:36:46 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 3/3] bpftool: Display cookie for raw_tp link
 probe
To: Tao Chen <chen.dylane@linux.dev>, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, jolsa@kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250603022610.3005963-1-chen.dylane@linux.dev>
 <20250603022610.3005963-3-chen.dylane@linux.dev>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20250603022610.3005963-3-chen.dylane@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/06/2025 03:26, Tao Chen wrote:
> Display cookie for raw_tp link probe, in plain mode:
> 
>  #bpftool link
> 
> 22: raw_tracepoint  prog 14
>         tp 'sys_enter'  cookie 23925373020405760
>         pids test_progs(176)
> 
> And in json mode:
> 
>  #bpftool link -j | jq
> 
> [
>   {
>     "id": 47,
>     "type": "raw_tracepoint",
>     "prog_id": 79,
>     "tp_name": "sys_enter",
>     "cookie": 23925373020405760,
>     "pids": [
>       {
>         "pid": 274,
>         "comm": "test_progs"
>       }
>     ]
>   }
> ]
> 
> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> ---
>  tools/bpf/bpftool/link.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
> index 52fd2c9fac..bd37f364be 100644
> --- a/tools/bpf/bpftool/link.c
> +++ b/tools/bpf/bpftool/link.c
> @@ -484,6 +484,7 @@ static int show_link_close_json(int fd, struct bpf_link_info *info)
>  	case BPF_LINK_TYPE_RAW_TRACEPOINT:
>  		jsonw_string_field(json_wtr, "tp_name",
>  				   u64_to_ptr(info->raw_tracepoint.tp_name));
> +		jsonw_lluint_field(json_wtr, "cookie", info->raw_tracepoint.cookie);
>  		break;
>  	case BPF_LINK_TYPE_TRACING:
>  		err = get_prog_info(info->prog_id, &prog_info);
> @@ -876,6 +877,8 @@ static int show_link_close_plain(int fd, struct bpf_link_info *info)
>  	case BPF_LINK_TYPE_RAW_TRACEPOINT:
>  		printf("\n\ttp '%s'  ",


Nit: See how we use a double space at the end of the string here, to
separate the different fields in the plain output...


>  		       (const char *)u64_to_ptr(info->raw_tracepoint.tp_name));
> +		if (info->raw_tracepoint.cookie)
> +			printf("cookie %llu ", info->raw_tracepoint.cookie);


... Please use a double space here in a similar way, at the end of your
"cookie %llu  " format string.

Looks good otherwise. Thanks,
Quentin

