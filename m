Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD808618E62
	for <lists+bpf@lfdr.de>; Fri,  4 Nov 2022 03:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbiKDCpA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Nov 2022 22:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiKDCpA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Nov 2022 22:45:00 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668E21D32C
        for <bpf@vger.kernel.org>; Thu,  3 Nov 2022 19:44:59 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d24so3696503pls.4
        for <bpf@vger.kernel.org>; Thu, 03 Nov 2022 19:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4Hm4VshWNFpiVsTiNkXfXG0DOLhWm6P1yjY0si75hks=;
        b=GbuHbvghteGAyMfLja+I5rHbHfHAemd14aTxV8M87go0zvnskuhlJTESSE72P+Kykg
         ZbTFYeqwJmMhVWg+SrCNSAE7lO+E51EXfzSMc4NNSynqiDWXFLDOmncngYyvTVoMwJGg
         ieCUTKilSpfReiqtI8dVG7Q9tMRVrc7cimcfUutr0lgVWn0lL2jWU2r7oonBp9k2opTX
         sJ/dRq1Of/Po/THF9qy17Wmkwy8WIf+GEwzB+RQWBsAzU0bwOwalC/FbdmTIbwA3jwCu
         uffo7Ii8r2/tj/oBJhkZYg1Gc3U4ZrtgfbYznxq0UHIiqO5abG1VIqqx+eWuTQK0v8M0
         zMpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Hm4VshWNFpiVsTiNkXfXG0DOLhWm6P1yjY0si75hks=;
        b=IAkMD0o37LDAq/vfpKM6ZFYXGDuTCHfGczsX4prC23SpU2/W8ve2SZHp4/OKETDpxb
         Ee8Wf5vqcN2UzMWUEKYjbTjrxxUNR/l9eHDvxcDG17IafJtRNJaQM1K2xmNCttWcTPfk
         XLbFQ6c+qY17RJMvqp22TayKsedogdbcaze/7luJBWdjb2g/9yqukVvvbjaXBU9AALOY
         SI7TTJb29+agLOUlRwaHGqrc5crTwwGoCYg7YVP70Gf27o27wTVwvaOIwQc9rqXU0DIx
         9ORa8RKJjT46jM+RKbMbIvgqJSWhQ5UpqTZ3p3JiMuiwr7EamzZlVB0VGEX5H19V9Xvg
         LYsg==
X-Gm-Message-State: ACrzQf2o2+wVRAwJx9+Jgu7HDu4rK6MzQuPiRTsNsfqftsQnfeIdrXTP
        8qNa6fzSok2qi/soltCyKGeayg4JBFc=
X-Google-Smtp-Source: AMsMyM7C6fQH9EuNAPWyvfLc2ZlST/jCTpCV1n/xMeF+qCgZxCZ9ZILqH6yrhzQjOSoTlaBPzzgM4g==
X-Received: by 2002:a17:902:ef52:b0:17c:f072:95bc with SMTP id e18-20020a170902ef5200b0017cf07295bcmr32602898plx.28.1667529898789;
        Thu, 03 Nov 2022 19:44:58 -0700 (PDT)
Received: from macbook-pro-5.dhcp.thefacebook.com ([2620:10d:c090:400::5:2035])
        by smtp.gmail.com with ESMTPSA id q8-20020a170902dac800b00186a2274382sm1414301plx.76.2022.11.03.19.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 19:44:58 -0700 (PDT)
Date:   Thu, 3 Nov 2022 19:44:55 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: Re: [PATCH bpf-next v4 06/24] bpf: Refactor kptr_off_tab into
 btf_record
Message-ID: <20221104024455.zgbio2ly4jj6x5ph@macbook-pro-5.dhcp.thefacebook.com>
References: <20221103191013.1236066-1-memxor@gmail.com>
 <20221103191013.1236066-7-memxor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103191013.1236066-7-memxor@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 04, 2022 at 12:39:55AM +0530, Kumar Kartikeya Dwivedi wrote:
> @@ -936,51 +956,51 @@ static int bpf_map_alloc_off_arr(struct bpf_map *map)
>  {
>  	bool has_spin_lock = map_value_has_spin_lock(map);
>  	bool has_timer = map_value_has_timer(map);
> -	bool has_kptrs = map_value_has_kptrs(map);
> -	struct bpf_map_off_arr *off_arr;
> +	bool has_fields = !IS_ERR_OR_NULL(map);

should have been map->record.

> -	if (!map_value_has_kptrs(map_ptr)) {
> -		ret = PTR_ERR_OR_ZERO(map_ptr->kptr_off_tab);
> -		if (ret == -E2BIG)
> -			verbose(env, "map '%s' has more than %d kptr\n", map_ptr->name,
> -				BPF_MAP_VALUE_OFF_MAX);
> -		else if (ret == -EEXIST)
> -			verbose(env, "map '%s' has repeating kptr BTF tags\n", map_ptr->name);
> -		else
> -			verbose(env, "map '%s' has no valid kptr\n", map_ptr->name);
> +	if (!btf_record_has_field(map_ptr->record, BPF_KPTR)) {
> +		verbose(env, "map '%s' has no valid kptr\n", map_ptr->name);
>  		return -EINVAL;
>  	}

The loss of verbosity is annoying, but I see why you're doing it.
