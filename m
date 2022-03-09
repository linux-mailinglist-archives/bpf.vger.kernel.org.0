Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7F64D3101
	for <lists+bpf@lfdr.de>; Wed,  9 Mar 2022 15:31:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233539AbiCIOcV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Mar 2022 09:32:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiCIOcU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Mar 2022 09:32:20 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E9F1520FE
        for <bpf@vger.kernel.org>; Wed,  9 Mar 2022 06:31:21 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id bi12so5490028ejb.3
        for <bpf@vger.kernel.org>; Wed, 09 Mar 2022 06:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=PQB1XYobyvRfOVoiVCRsq8RH9cBRYteK2cv6AlZYxXE=;
        b=YLMa4IpHVMWXHKsx1iuUqS04WuR8fw9YmY5yNbwcMHaplBcn6ZQY0icZyOcWgOmxym
         mhLLwCepcq3rABSU2UJV9dI2tTb1oad75O4KM/O7Z26tXHXbxQD+9YfyNrivFhAib8hQ
         HMLage55zb18qhc0a4t0LbWVXFDVA5KGOMlfB/tiq/awMLeZav/bfSA1ofn8mE/fj2Np
         dsEidalIyn1+u7UrImzUuZvUcp3O1TsFh3ocwHlzSvmikDS5BhjbT+QD7HFNDkNz6vns
         WnF83fNJh7/1iCun6RHmbIFtE3AqRJpdVlF4INOZ4Ij18q26xqVnYec7lCYSsc4nwN2R
         QrOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PQB1XYobyvRfOVoiVCRsq8RH9cBRYteK2cv6AlZYxXE=;
        b=s1ru32K+WqMrO0b0M7rw6XgVfwCeFxYhGZhrWZiTKFrcl7OK+8zRRvWk5Hey3RJq2f
         ooJKBr34ipHs8oZuF9t6mVA5SMq5D0LCEc/4HNtnB1ZFTOsvphFM9hIeu+v0g4dRVyk9
         qiD3MuS/3q+Zk65YzxldF8+Xy9fCYhClfiFufzFXtM5JjK7/4h4uy8f9A56L5wtvk/b0
         3B3CiurNKSFuus76j1RRxPBjWDECto1EkgsJNSRnb1i1Ifo6et0IBvIEIhN5xd/mdcQS
         2ahguFMynB5ROEd5VqDkNmf1ZJpdtPhRQnf8ZRdlTwxxh53U2K5V4iIQWMB2qurgtQB7
         Ax9g==
X-Gm-Message-State: AOAM532TATuXWBR0SweOA4Lw3p/6v36cO2KbS7L4ueVj/iLwH9bED+8y
        10XunDFfLNcea90oxdSbVBFvaFCXNGJMnVhE
X-Google-Smtp-Source: ABdhPJxj7EUDKMRuUhEtMCdDjcO7QPmKMhZwG86OOe8f1SYZqKXnSQdfufcFLnxRCd0Cb/m3b/D2Tg==
X-Received: by 2002:a17:907:7e9c:b0:6db:4788:66ab with SMTP id qb28-20020a1709077e9c00b006db478866abmr33323ejc.112.1646836280383;
        Wed, 09 Mar 2022 06:31:20 -0800 (PST)
Received: from [192.168.1.8] ([149.86.77.40])
        by smtp.gmail.com with ESMTPSA id k20-20020a170906681400b006da86bef01fsm798106ejr.79.2022.03.09.06.31.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 06:31:19 -0800 (PST)
Message-ID: <a5df60e1-f0b1-070f-7c93-133f0c562a21@isovalent.com>
Date:   Wed, 9 Mar 2022 14:31:18 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [v2,bpf-next] bpftool: Restore support for BPF offload-enabled
 feature probing
Content-Language: en-GB
To:     =?UTF-8?Q?Niklas_S=c3=b6derlund?= <niklas.soderlund@corigine.com>,
        bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Simon Horman <simon.horman@corigine.com>, oss-drivers@corigine.com
References: <20220309085452.298278-1-niklas.soderlund@corigine.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20220309085452.298278-1-niklas.soderlund@corigine.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2022-03-09 09:54 UTC+0100 ~ Niklas Söderlund <niklas.soderlund@corigine.com>
> Commit 1a56c18e6c2e4e74 ("bpftool: Stop supporting BPF offload-enabled
> feature probing") removed the support to probe for BPF offload features.
> This is still something that is useful for NFP NIC that can support
> offloading of BPF programs.
> 
> The reason for the dropped support was that libbpf starting with v1.0
> would drop support for passing the ifindex to the BPF prog/map/helper
> feature probing APIs. In order to keep this useful feature for NFP
> restore the functionality by moving it directly into bpftool.
> 
> The code restored is a simplified version of the code that existed in
> libbpf which supposed passing the ifindex. The simplification is that it
> only targets the cases where ifindex is given and call into libbpf for
> the cases where it's not.

[...]

> +static bool probe_prog_type_ifindex(enum bpf_prog_type prog_type, __u32 ifindex)
> +{
> +	struct bpf_insn insns[2] = {
> +		BPF_MOV64_IMM(BPF_REG_0, 0),
> +		BPF_EXIT_INSN()
> +	};
> +
> +	switch (prog_type) {
> +	case BPF_PROG_TYPE_SCHED_CLS:
> +		/* nfp returns -EINVAL on exit(0) with TC offload */
> +		insns[0].imm = 2;
> +		break;
> +	case BPF_PROG_TYPE_XDP:
> +		break;
> +	default:
> +		return false;
> +	}

Looking again at this block, you can remove this switch/case completely.
Moving 0 by default into R0 was best in generic libbpf's probes because
there were a number of types that wouldn't accept 2 as a return value;
but here you can just return 2 all the time, for XDP this will mean
XDP_PASS and the nfp accepts it. (Do keep the comment on nfp returning
-EINVAL on exit(0), though, please.)

> +
> +	return probe_prog_load_ifindex(prog_type, insns, ARRAY_SIZE(insns),
> +				       NULL, 0, ifindex);
> +}
> +
>  static void
>  probe_prog_type(enum bpf_prog_type prog_type, bool *supported_types,
>  		const char *define_prefix, __u32 ifindex)
> @@ -488,11 +564,19 @@ probe_prog_type(enum bpf_prog_type prog_type, bool *supported_types,
>  	bool res;
>  
>  	if (ifindex) {
> -		p_info("BPF offload feature probing is not supported");
> -		return;
> +		switch (prog_type) {
> +		case BPF_PROG_TYPE_SCHED_CLS:
> +		case BPF_PROG_TYPE_XDP:
> +			break;
> +		default:
> +			return;
> +		}
> +
> +		res = probe_prog_type_ifindex(prog_type, ifindex);
> +	} else {
> +		res = libbpf_probe_bpf_prog_type(prog_type, NULL);
>  	}
>  
> -	res = libbpf_probe_bpf_prog_type(prog_type, NULL);
>  #ifdef USE_LIBCAP
>  	/* Probe may succeed even if program load fails, for unprivileged users
>  	 * check that we did not fail because of insufficient permissions
> @@ -521,6 +605,35 @@ probe_prog_type(enum bpf_prog_type prog_type, bool *supported_types,
>  			   define_prefix);
>  }
>  
> +static bool probe_map_type_ifindex(enum bpf_map_type map_type, __u32 ifindex)
> +{
> +	LIBBPF_OPTS(bpf_map_create_opts, opts);
> +	int key_size, value_size, max_entries;
> +	int fd;
> +
> +	opts.map_ifindex = ifindex;
> +
> +	key_size	= sizeof(__u32);
> +	value_size	= sizeof(__u32);
> +	max_entries	= 1;
> +
> +	switch (map_type) {
> +	case BPF_MAP_TYPE_HASH:
> +	case BPF_MAP_TYPE_ARRAY:
> +		break;
> +	default:
> +		return false;
> +	}

This switch/case should probably not be here. Either skip
probe_map_type_ifindex() entirely if you assume other map types are not
supported, or just probe all types for real.

Speaking of which, we agreed yesterday on probing for all map types. But
I think my suggestion was wrong (apologies!), because the simplified
probes that you're adding back does not contain the necessary
adjustments to work with all map types (the switch(map_type) in libbpf's
probe_map_create()). So we should probably probe just hash/array maps,
but move the switch/case above to probe_map_type(), like we do for prog
types, to avoid printing any output for other map types. This will
prevent other drivers to probe for additional map types, but a large
portion of those probes would be broken, so it's for the best. We can
always extend probe_map_type_ifindex() in the future to support more
types if necessary.

> +
> +	fd = bpf_map_create(map_type, NULL, key_size, value_size, max_entries,
> +			    &opts);
> +
> +	if (fd >= 0)
> +		close(fd);
> +
> +	return fd >= 0;
> +}
> +
>  static void
>  probe_map_type(enum bpf_map_type map_type, const char *define_prefix,
>  	       __u32 ifindex)
