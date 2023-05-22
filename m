Return-Path: <bpf+bounces-1014-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1425C70BF9C
	for <lists+bpf@lfdr.de>; Mon, 22 May 2023 15:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC5AD280F8B
	for <lists+bpf@lfdr.de>; Mon, 22 May 2023 13:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E88213AE3;
	Mon, 22 May 2023 13:24:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5A1134AF
	for <bpf@vger.kernel.org>; Mon, 22 May 2023 13:24:43 +0000 (UTC)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB3AB3
	for <bpf@vger.kernel.org>; Mon, 22 May 2023 06:24:40 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-30a8c4afa46so1089071f8f.1
        for <bpf@vger.kernel.org>; Mon, 22 May 2023 06:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1684761879; x=1687353879;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fbjva5UnX0GGH/ZxZ0X0CMHpFHlYx9oYRC6yISvpo2Q=;
        b=YYx3U7N+8aTfiQBFTVQpq0s9ZGFpDes1bkg36nW/w8Qd4sYjKHRTh8jT/J0XM0ieUJ
         ya5amTtiqAW9QUSZzvoN03/0FfLA/3KFlO+wgO8AyEmNr+iS3r7iZBsR/vp+1Y4++MYe
         jxEQwTEtrzumU5SqTzPJ8jeAL9BECFrz8k9im6AFxlyrR7VSPwNIXMNlJOnartYhm7/o
         SVd1dzOFODL4lf1UO0OmAfd2cQ6nTqlZkv9/NWZv0us94vRWttFRRtIuP64sRmWxweWZ
         eyWJg1FV2T71bBX2+90juqYq5gotgJIvz23zh7A0r3twe5BKhFZYigNPkMZnQrOUdVXm
         3gCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684761879; x=1687353879;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fbjva5UnX0GGH/ZxZ0X0CMHpFHlYx9oYRC6yISvpo2Q=;
        b=N2tW4T5NOuWQMw6WBeSVj75jNn4xLNgYwi9OLJMdZgpqQTOSKPBif3B5UQCwM/zlZk
         4o03r4Abk5LtNwwse92qiQZUr+3E4NonZE8FyKP4WB1JJfpSgz8Js2TdNpUoRQFHNIom
         Yi/jCuO+tNMxKsY6GW9qREExnhxEPHuFwYaDWAjATBer6gwIQ+wNBedzqlejvTUiV5en
         or03kRzGdGWuwaSSxxzElrnR6L7lV5tQ4H7Kl27+mNE5F8eyb0lGHucfGH4zTVDWjG4B
         +s3BEbF9HRMMX7OQOQMBGLY+WI7pTbOCY+SMvvvjMQ/dxsFibUsSYhBGQELGVwqoqnr2
         kgyQ==
X-Gm-Message-State: AC+VfDxvpUrep/YkcqLCd+6E3iKIDObsK+K2w+skg9rPYN74mLgjblah
	M+FE7IB66WwWjdACsWHzxuEE3g==
X-Google-Smtp-Source: ACHHUZ7Tk/zLFZzPkrqvwom0yBqVrA8bZqXxQltRy8JCMPO21bCCveMRBKd6DuEw1MHtrT63zer3Ew==
X-Received: by 2002:adf:dcc9:0:b0:30a:8e84:eaa8 with SMTP id x9-20020adfdcc9000000b0030a8e84eaa8mr2933871wrm.16.1684761879220;
        Mon, 22 May 2023 06:24:39 -0700 (PDT)
Received: from ?IPV6:2a02:8011:e80c:0:50b6:8eff:3df4:1ebe? ([2a02:8011:e80c:0:50b6:8eff:3df4:1ebe])
        by smtp.gmail.com with ESMTPSA id q2-20020a5d61c2000000b00309382eb047sm7716749wrv.112.2023.05.22.06.24.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 May 2023 06:24:38 -0700 (PDT)
Message-ID: <f118beb9-d683-4772-7fd1-5325e261bf26@isovalent.com>
Date: Mon, 22 May 2023 14:24:38 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH bpf-next v2] bpftool: specify XDP Hints ifname when
 loading program
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
References: <20230517160103.1088185-1-larysa.zaremba@intel.com>
From: Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20230517160103.1088185-1-larysa.zaremba@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

2023-05-17 18:01 UTC+0200 ~ Larysa Zaremba <larysa.zaremba@intel.com>
> Add ability to specify a network interface used to resolve
> XDP Hints kfuncs when loading program through bpftool.
> 
> Usage:
>   bpftool prog load [...] xdpmeta_dev <ifname>
> 
> Writing just 'dev <ifname>' instead of 'xdpmeta_dev' is a very probable
> mistake that results in not very descriptive errors,
> so 'bpftool prog load [...] dev <ifname>' syntax becomes deprecated,
> followed by 'bpftool map create [...] dev <ifname>' for consistency.
> 
> Now, to offload program, execute:
>   bpftool prog load [...] offload_dev <ifname>
> 
> To offload map:
>   bpftool map create [...] offload_dev <ifname>
> 
> 'dev <ifname>' still performs offloading in the commands above, but now
> triggers a warning and is excluded from bash completion.
> 
> 'xdpmeta_dev' and 'offload_dev' are mutually exclusive options, because
> 'xdpmeta_dev' basically makes a program device-bound without loading it
> onto the said device. For now, offloaded programs cannot use XDP hints [0],
> but if this changes, using 'offload_dev <ifname>' should cover this case.
> 
> [0] https://lore.kernel.org/bpf/a5a636cc-5b03-686f-4be0-000383b05cfc@linux.dev
> 
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
Reviewed-by: Quentin Monnet <quentin@isovalent.com>

Thanks!

