Return-Path: <bpf+bounces-386-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB24700523
	for <lists+bpf@lfdr.de>; Fri, 12 May 2023 12:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C60ED1C20B6C
	for <lists+bpf@lfdr.de>; Fri, 12 May 2023 10:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D36DD30E;
	Fri, 12 May 2023 10:23:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BD48F6E
	for <bpf@vger.kernel.org>; Fri, 12 May 2023 10:23:08 +0000 (UTC)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EDDF1FDE
	for <bpf@vger.kernel.org>; Fri, 12 May 2023 03:23:03 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-30639daee76so6360290f8f.1
        for <bpf@vger.kernel.org>; Fri, 12 May 2023 03:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1683886981; x=1686478981;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2+Wf8mVZDbx31shCs97RQqyKh5s1MqwXoRc+dmnhzU4=;
        b=Ij9QKWpIoMZsXOQZ5zF+5uXiCfMBJ1ntLurb/gL5AOk3hPXrAjZOLK/aOnzYMkhpN0
         mkHUUoUPwadC8WJE+yBPzRFO1HynAAwLHK6+RkXi/KlsDXq8STd54YL89WXRUSOafSa0
         LbXzOe6Kj2bCrZRYNuj+gfFOsDl27rNLmIDAUTCIIL32qNe8aBu/CSVP0FffwVRXUk/n
         gXyXiq91G6P11C73oEp2Wz9X5vYuc+/zv0FFq23ah1VS928QgBnityP3Cl7gBEsEEFyN
         js7o3eNeAGRZOMMSyBGdiE5Y6PKoKKI9HTcZxgU7zz/KGa1pmzgJFWE9tZ4pXo/R2s2d
         9c2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683886981; x=1686478981;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2+Wf8mVZDbx31shCs97RQqyKh5s1MqwXoRc+dmnhzU4=;
        b=YR10XT+0dyoSQYP+MGjYadOfLvtd4PPq+TE/M6mwo4htqyN19M3nOZztqa49tktyIf
         vLlqFNXmqo2geXHE6Bw92DWFIPYgljhrSZR1QF6xwXKzOoj7GSoQ7WQ6qRSBe/FB7Sl6
         /NrNZ5xL/P917Mx24zd99Nzmzr8oEDT8mk9pt38EggTm7qvM2ggM7oGzYxzWyfIKwnvC
         QrJsXEUei2IyzbzfeFIFZy5kSdnxoLE03yJmYtjj0+p8AHe6SBexp4jVCPWvdMHTt/ma
         iqcgJ6IZwQ3FqL6SCKWRV38G6033dyewabUFCw7ORQgNIpuQ1uBn1l1oIalcwIG+opks
         eJXA==
X-Gm-Message-State: AC+VfDz5xGsoP/S5kleUz+y89hxIpoSRz1bj33UKPsBhGdjJO2pi3bYj
	cN+MT05DS3UlaopSPufc9QR96Q==
X-Google-Smtp-Source: ACHHUZ6eFgiIinI+xrrQTlKNRhpy1XQdvL75E0orbqUI1w21D4W374Pc4XROzGpwYNO1E9giUFs5vg==
X-Received: by 2002:adf:dbc8:0:b0:307:8b3e:2858 with SMTP id e8-20020adfdbc8000000b003078b3e2858mr13745375wrj.45.1683886981570;
        Fri, 12 May 2023 03:23:01 -0700 (PDT)
Received: from ?IPV6:2a02:8011:e80c:0:a162:20e4:626a:dd? ([2a02:8011:e80c:0:a162:20e4:626a:dd])
        by smtp.gmail.com with ESMTPSA id k9-20020a05600c1c8900b003f4283f5c1bsm16930478wms.2.2023.05.12.03.23.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 May 2023 03:23:01 -0700 (PDT)
Message-ID: <dd7a4bec-c0d0-4ffe-3bb8-e4d7ab4a01b8@isovalent.com>
Date: Fri, 12 May 2023 11:23:00 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH bpf-next] bpftool: specify XDP Hints ifname when loading
 program
Content-Language: en-GB
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: Stanislav Fomichev <sdf@google.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Niklas_S=c3=b6derlund?= <niklas.soderlund@corigine.com>
References: <20230511151345.7529-1-larysa.zaremba@intel.com>
From: Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20230511151345.7529-1-larysa.zaremba@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

2023-05-11 17:13 UTC+0200 ~ Larysa Zaremba <larysa.zaremba@intel.com>
> Add ability to specify a network interface used to resolve
> XDP Hints kfuncs when loading program through bpftool.
> 
> Usage:
> bpftool prog load <bpf_obj_path> <pin_path> dev xdpmeta <ifname>

Thanks for this patch!

Regarding the command-line syntax, I'm not a big fan of the optional
sub-keyword for the device for XDP hints. I must admit I had not
anticipated other another use for the "dev" keyword. Instead, have you
considered one of the following:

1) Adding a different keyword ("xdpmeta_dev"?) and making it
incompatible with "dev"

2) Another alternative would be adding a sub-keyword for offload too:

    bpftool p l [...] dev <[offload <ifname> | xdpmeta <ifname>]>

If the ifname is provided with no sub-keyword, we would consider it for
offload for legacy support, possibly warn that the syntax is deprecated.

What do you think?

> 
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> ---
>  tools/bpf/bpftool/prog.c | 28 +++++++++++++++++++++-------
>  1 file changed, 21 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
> index 91b6075b2db3..a9cb96d99277 100644
> --- a/tools/bpf/bpftool/prog.c
> +++ b/tools/bpf/bpftool/prog.c
> @@ -1517,12 +1517,13 @@ static int load_with_options(int argc, char **argv, bool first_prog_only)
>  	struct bpf_program *prog = NULL, *pos;
>  	unsigned int old_map_fds = 0;
>  	const char *pinmaps = NULL;
> +	__u32 offload_ifindex = 0;
>  	bool auto_attach = false;
> +	__u32 meta_ifindex = 0;
>  	struct bpf_object *obj;
>  	struct bpf_map *map;
>  	const char *pinfile;
>  	unsigned int i, j;
> -	__u32 ifindex = 0;
>  	const char *file;
>  	int idx, err;
>  
> @@ -1614,17 +1615,25 @@ static int load_with_options(int argc, char **argv, bool first_prog_only)
>  			map_replace[old_map_fds].fd = fd;
>  			old_map_fds++;
>  		} else if (is_prefix(*argv, "dev")) {
> +			__u32 *cur_ifindex;
> +
>  			NEXT_ARG();
>  
> -			if (ifindex) {
> -				p_err("offload device already specified");
> +			if (offload_ifindex || meta_ifindex) {
> +				p_err("device already specified");

I'd add a note to tell somehow that offload and XDP hints are mutually
exclusive. I suspect not all users understand these well.

>  				goto err_free_reuse_maps;
>  			}
> +			if (is_prefix(*argv, "xdpmeta")) {
> +				cur_ifindex = &meta_ifindex;
> +				NEXT_ARG();
> +			} else {
> +				cur_ifindex = &offload_ifindex;
> +			}
>  			if (!REQ_ARGS(1))
>  				goto err_free_reuse_maps;
>  
> -			ifindex = if_nametoindex(*argv);
> -			if (!ifindex) {
> +			*cur_ifindex = if_nametoindex(*argv);
> +			if (!(*cur_ifindex)) {
>  				p_err("unrecognized netdevice '%s': %s",
>  				      *argv, strerror(errno));
>  				goto err_free_reuse_maps;
> @@ -1671,7 +1680,12 @@ static int load_with_options(int argc, char **argv, bool first_prog_only)
>  				goto err_close_obj;
>  		}
>  
> -		bpf_program__set_ifindex(pos, ifindex);
> +		if (prog_type == BPF_PROG_TYPE_XDP && meta_ifindex) {
> +			bpf_program__set_flags(pos, BPF_F_XDP_DEV_BOUND_ONLY);
> +			bpf_program__set_ifindex(pos, meta_ifindex);
> +		} else {
> +			bpf_program__set_ifindex(pos, offload_ifindex);
> +		}
>  		if (bpf_program__type(pos) != prog_type)
>  			bpf_program__set_type(pos, prog_type);
>  		bpf_program__set_expected_attach_type(pos, expected_attach_type);
> @@ -1709,7 +1723,7 @@ static int load_with_options(int argc, char **argv, bool first_prog_only)
>  	idx = 0;
>  	bpf_object__for_each_map(map, obj) {
>  		if (bpf_map__type(map) != BPF_MAP_TYPE_PERF_EVENT_ARRAY)
> -			bpf_map__set_ifindex(map, ifindex);
> +			bpf_map__set_ifindex(map, offload_ifindex);
>  
>  		if (j < old_map_fds && idx == map_replace[j].idx) {
>  			err = bpf_map__reuse_fd(map, map_replace[j++].fd);

Could you please also update the following items:

- The usage message for "bpftool prog load" near the end of prog.c

- The related doc in Documentation/bpftool-prog.rst (command summary
near the top, and detailed description later in the doc)

- Bash completion (for keyword "dev", look for "_sysfs_get_netdevs" in
bash-completion/bpftool). I'm happy to help with this one if necessary.

Thanks,
Quentin

