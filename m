Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 728395BEB0E
	for <lists+bpf@lfdr.de>; Tue, 20 Sep 2022 18:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbiITQXk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Sep 2022 12:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiITQXi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Sep 2022 12:23:38 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E5736DD5
        for <bpf@vger.kernel.org>; Tue, 20 Sep 2022 09:23:37 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id n8so2330984wmr.5
        for <bpf@vger.kernel.org>; Tue, 20 Sep 2022 09:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=GAZOtxAx2AhdzlcNuiqlroAdOwr2TkIU5pQzdhxevEU=;
        b=3iT1peDk1LnqFS9UczS27U/gG/YmUTmHMqxCGAKwmWGf4JkJkZsTzdSePrQ1deKLMF
         k5XGmHtjAVjY8U0QTIS9h6bvpm4E04W5zMzrJXUwe/aivK8ujfHIcBldnLjHFN05oNOR
         OH7lk2hvA6X9YLjWdmkaWXLufdKDx0dusDZE9OWpY7MwCGre8f2jfZmzUtJjeklX5s8J
         cPVwS4TY+LMhrmDZrbzLfaNXgPHw5fGRe+dP7SE5mBFfC7RK0Zg02OStMVMU6tW1ikSQ
         m2K4dxp9KqzauPk8iC3UlVz8CHF2MPuc7atD+2Il+fI/BVvr6jRDsB+hFdQjfeiM4ELC
         8/eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=GAZOtxAx2AhdzlcNuiqlroAdOwr2TkIU5pQzdhxevEU=;
        b=ogfffjLdM2V5OzPVpu9G/UNdRMkLi+nr08IshUCckS/xdBLcDVyZZSANgLWfUCH9aJ
         WKmTRFDWFqaD1VZr7QuY01llqlu2IlHKpjPIYq/gUQzn7v/L1ntzFcUbNMmAyy/5m/gG
         enh4uf2yrLhf8RTf+9Sp94FH3MY5JQUNcFPZfdP2NQojPfbMEQO04J4wUtYUjH67DE7g
         gGGCt/wKPQdVcpfJeS6ZudoHqM0a8jPipRgc+sr6cNhDXPxR+BFxJfYyXdSVSPYpAQVa
         5nRFmr4ZTo0AAoKG9bRjhUwGIo/bJEhcIbh37VnHc2WD/PJIRnZeqXZ+ZzjfQPvcEk+h
         LlYw==
X-Gm-Message-State: ACrzQf1CFT/HQxpdS688XBAsDJLi1X2rzbHax+RxTpoqOCkPBfH6qWK5
        Q1LpEAroGyXIFY8dIaIjqobTLtfBIvKxDQ==
X-Google-Smtp-Source: AMsMyM4BNsMSkCxEpN/mnzMFGp1P8OI6rYFXQH4275RlYpZHyBgvVNikGdRJkMHOV2fbjWNpDVjJBA==
X-Received: by 2002:a1c:4b05:0:b0:3b4:90c1:e249 with SMTP id y5-20020a1c4b05000000b003b490c1e249mr3116778wma.201.1663691015464;
        Tue, 20 Sep 2022 09:23:35 -0700 (PDT)
Received: from [192.168.178.32] ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id z18-20020adff752000000b0022860e8ae7csm154368wrp.77.2022.09.20.09.23.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 09:23:34 -0700 (PDT)
Message-ID: <b0215eb8-1c1b-5321-6c94-fefd214a7138@isovalent.com>
Date:   Tue, 20 Sep 2022 17:23:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH bpf-next 1/3] selftests/bpf: add CSV output mode for
 veristat
Content-Language: en-GB
To:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net
Cc:     kernel-team@fb.com
References: <20220920040736.342025-1-andrii@kernel.org>
 <20220920040736.342025-2-andrii@kernel.org>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20220920040736.342025-2-andrii@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Tue Sep 20 2022 05:07:34 GMT+0100 (British Summer Time) ~ Andrii
Nakryiko <andrii@kernel.org>
> Teach veristat to output results as CSV table for easier programmatic
> processing. Change what was --output/-o argument to now be --emit/-e.
> And then use --output-format/-o <fmt> to specify output format.
> Currently "table" and "csv" is supported, table being default.
> 
> For CSV output mode veristat is using spec identifiers as column names.
> E.g., instead of "Total states" veristat uses "total_states" as a CSV
> header name.
> 
> Internally veristat recognizes three formats, one of them
> (RESFMT_TABLE_CALCLEN) is a special format instructing veristat to
> calculate column widths for table output. This felt a bit cleaner and
> more uniform than either creating separate functions just for this.
> 
> Also fix double-free of bpf_object in process_prog, which didn't feel
> important enough to have a separate patch for.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  tools/testing/selftests/bpf/veristat.c | 114 ++++++++++++++++---------
>  1 file changed, 76 insertions(+), 38 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
> index 39e6dc41e504..317f7736dd59 100644
> --- a/tools/testing/selftests/bpf/veristat.c
> +++ b/tools/testing/selftests/bpf/veristat.c
> @@ -46,10 +46,17 @@ struct stat_specs {
>  	int lens[ALL_STATS_CNT];
>  };
>  
> +enum resfmt {
> +	RESFMT_TABLE,
> +	RESFMT_TABLE_CALCLEN, /* fake format to pre-calculate table's column widths */
> +	RESFMT_CSV,
> +};
> +
>  static struct env {
>  	char **filenames;
>  	int filename_cnt;
>  	bool verbose;
> +	enum resfmt out_fmt;
>  
>  	struct verif_stats *prog_stats;
>  	int prog_stat_cnt;
> @@ -77,9 +84,10 @@ const char argp_program_doc[] =
>  
>  static const struct argp_option opts[] = {
>  	{ NULL, 'h', NULL, OPTION_HIDDEN, "Show the full help" },
> -	{ "verbose", 'v', NULL, 0, "Verbose mode" },
> -	{ "output", 'o', "SPEC", 0, "Specify output stats" },
> +	{ "vereose", 'v', NULL, 0, "Verbose mode" },

"vereose" -> looks like this line was changed by mistake

