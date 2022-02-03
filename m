Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9D64A8242
	for <lists+bpf@lfdr.de>; Thu,  3 Feb 2022 11:25:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232378AbiBCKZB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Feb 2022 05:25:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbiBCKZA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Feb 2022 05:25:00 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E231C061714
        for <bpf@vger.kernel.org>; Thu,  3 Feb 2022 02:25:00 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id e8so4153690wrc.0
        for <bpf@vger.kernel.org>; Thu, 03 Feb 2022 02:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=rcyeINRlj/J3aoqvVEw9ZIv+1qyqHogC5Qsb04shbro=;
        b=pVLmgP6ee2mRYTgwTRc4+9+AhIzJc53tGt5+Rcp+T1OoxSmEtaGqw1z+9tf2Otdnjn
         c3lxgUxyjhWxh3pcrtFL0GwqYgTgBVwp4xOuaAf7RZSFnpF3vlz6E4F93aAE47qsRuSO
         385IfAki2PEUk7tJh/SHOO2OCIfjquECndHrWantyN2nnJY5G+j1+TmSgv8IdgYPDQli
         Q4jgjENers7ewXOFsPthR4AcejXuOH0G252QMhXDJ3LUtWJbdauKRfU3HiWErM43P/O4
         V9B2aNydxgnX0O52eQrqT0HuG+MlNysKYPmjPaL+AsYKU/jIHYZ1DsdFOXCx0NPvNgGQ
         a8wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rcyeINRlj/J3aoqvVEw9ZIv+1qyqHogC5Qsb04shbro=;
        b=ka6EvJkeFiHHsG61+1sf7Fh8FBosePAkQfNX57Fan21uheGCrFc99ZCuFP2BoLNdrY
         vmewx1E05fFa+QqDZBu9PN3YQ9XZF05aXJDDaPutX1tIJvlcVACCOqC6p9rQtoup7TXw
         Q3OpA5dlKSH1jyTnfHWtvRNqIJPnKKP/NZCUan/uII2LW7SVILeRqYvfyijuMIAzjvxz
         dzg3XL7hHExY5VeukBrEAjLqrGYjmWdM9NnojQ/GUkmlpmtjbhUqycNYrfU8AZo9mf3m
         Xu96ov2fEqNUlLDBZgCQuhHKqxrxgmDpZhfogyDDe66LRLWk7cxLAFoa5iCd3yTB38zL
         ERBA==
X-Gm-Message-State: AOAM532SkKFqS5G3mdadsOksu2I//qxBTgwDpcC3s8x/822G2qO27AS2
        SWaLqer8VVOwdhFj3VmLK4XqrQ==
X-Google-Smtp-Source: ABdhPJyO5/vzdEW+Vn7aW3WPtVUtW2RKj7TBvDtZ0yXRCoIZiMgthCBAyYTTmrLJbvSvCVPzctqRTw==
X-Received: by 2002:adf:c3d4:: with SMTP id d20mr28255857wrg.55.1643883898817;
        Thu, 03 Feb 2022 02:24:58 -0800 (PST)
Received: from [192.168.1.8] ([149.86.71.48])
        by smtp.gmail.com with ESMTPSA id i3sm6797402wmd.30.2022.02.03.02.24.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Feb 2022 02:24:58 -0800 (PST)
Message-ID: <86567f94-ec2a-5441-2657-4e8f3f21059d@isovalent.com>
Date:   Thu, 3 Feb 2022 10:24:57 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH bpf-next 2/6] bpftool: stop supporting BPF offload-enabled
 feature probing
Content-Language: en-GB
To:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net
Cc:     kernel-team@fb.com, Simon Horman <simon.horman@corigine.com>,
        David Beckett <david.beckett@netronome.com>
References: <20220202225916.3313522-1-andrii@kernel.org>
 <20220202225916.3313522-3-andrii@kernel.org>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20220202225916.3313522-3-andrii@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2022-02-02 14:59 UTC-0800 ~ Andrii Nakryiko <andrii@kernel.org>
> libbpf 1.0 is not going to support passing ifindex to BPF
> prog/map/helper feature probing APIs. Remove the support for BPF offload
> feature probing.
> 
> Cc: Quentin Monnet <quentin@isovalent.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  tools/bpf/bpftool/feature.c | 29 +++++++++++++++++------------
>  1 file changed, 17 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/feature.c b/tools/bpf/bpftool/feature.c
> index e999159fa28d..9c894b1447de 100644
> --- a/tools/bpf/bpftool/feature.c
> +++ b/tools/bpf/bpftool/feature.c
> @@ -487,17 +487,12 @@ probe_prog_type(enum bpf_prog_type prog_type, bool *supported_types,
>  	size_t maxlen;
>  	bool res;
>  
> -	if (ifindex)
> -		/* Only test offload-able program types */
> -		switch (prog_type) {
> -		case BPF_PROG_TYPE_SCHED_CLS:
> -		case BPF_PROG_TYPE_XDP:
> -			break;
> -		default:
> -			return;
> -		}
> +	if (ifindex) {
> +		p_info("BPF offload feature probing is not supported");
> +		return;
> +	}
>  
> -	res = bpf_probe_prog_type(prog_type, ifindex);
> +	res = libbpf_probe_bpf_prog_type(prog_type, NULL);
>  #ifdef USE_LIBCAP
>  	/* Probe may succeed even if program load fails, for unprivileged users
>  	 * check that we did not fail because of insufficient permissions
> @@ -535,7 +530,12 @@ probe_map_type(enum bpf_map_type map_type, const char *define_prefix,
>  	size_t maxlen;
>  	bool res;
>  
> -	res = bpf_probe_map_type(map_type, ifindex);
> +	if (ifindex) {
> +		p_info("BPF offload feature probing is not supported");
> +		return;
> +	}
> +
> +	res = libbpf_probe_bpf_map_type(map_type, NULL);
>  
>  	/* Probe result depends on the success of map creation, no additional
>  	 * check required for unprivileged users
> @@ -567,7 +567,12 @@ probe_helper_for_progtype(enum bpf_prog_type prog_type, bool supported_type,
>  	bool res = false;
>  
>  	if (supported_type) {
> -		res = bpf_probe_helper(id, prog_type, ifindex);
> +		if (ifindex) {
> +			p_info("BPF offload feature probing is not supported");
> +			return;
> +		}
> +
> +		res = libbpf_probe_bpf_helper(prog_type, id, NULL);
>  #ifdef USE_LIBCAP
>  		/* Probe may succeed even if program load fails, for
>  		 * unprivileged users check that we did not fail because of

Thanks for the Cc. This feature was added for Netronome's SmartNICs and
I don't work with them anymore, so no objection from me (if anything,
that's one more incentive to finalise the new versioning scheme and have
this change under a new major version number!).

+Cc Simon, David: Hi! If you folks are still using bpftool to probe
eBPF-related features supported by the NICs, we'll have to move the
probes to bpftool.

Quentin
