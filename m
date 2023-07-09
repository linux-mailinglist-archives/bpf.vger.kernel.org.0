Return-Path: <bpf+bounces-4551-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3235C74C699
	for <lists+bpf@lfdr.de>; Sun,  9 Jul 2023 19:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9FDD28113F
	for <lists+bpf@lfdr.de>; Sun,  9 Jul 2023 17:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB15DE57B;
	Sun,  9 Jul 2023 17:19:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E8E5C9B;
	Sun,  9 Jul 2023 17:19:39 +0000 (UTC)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B33E2132;
	Sun,  9 Jul 2023 10:19:37 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6686708c986so3261252b3a.0;
        Sun, 09 Jul 2023 10:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688923177; x=1691515177;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BI/NY7I9s9rjHr/HFtTZKvXJrhJwG5JCOK4TgbTeV8M=;
        b=UI3a+U5t8o8vLbiD0jY6V3HXf+RshiPZK6WLhXXrY80Gnf6QZDh8oWTh4y5/QyEGog
         VvaN+uf+RVUMgIUZdznHZs2a8fbSNBbt3QFhzZZ/jk2IHAkG5ZiK/YWDBNQ0uZfTa74F
         o+s3rbkTn+G1kOdk0jV58nBs1KpR96pBQly1NECgs4AXBP47MSN4TqRyRjdYBtElMKGi
         AqmcJvzi0EdlD14TWBWCuyocE/ki2mQEHkhAl9Bu6GSvR4Gq/TF9JfLpD7CyXIZEOEc6
         gPZFn1lm61JMeWdeB3Lz9fz+fkA/+F/bmap28V2ym1uEYnnGPB6aFztnaz+IIkUCV3xh
         LA5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688923177; x=1691515177;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BI/NY7I9s9rjHr/HFtTZKvXJrhJwG5JCOK4TgbTeV8M=;
        b=h8Y3JGBm3OIVLEikQ3OGloedkkR3R241cn+7GVnHFy7mVp2X8v5mNUBIPM3jg/rIY1
         jHpnlObZv/gi7avznMgUIj7ya15Ih+AKhiNgqgrS828TpWYptvnN/pfsBJHYxTzz9E2i
         PXO1tEglVeSoGlKtcJeLEC/igof7HGwWPMxN29NuyMtyU8NZyGYXJAjr8akAIuWdlN7o
         DNZ3ACh7ICZJC5+Iv7rn8AhnyZmu/Bi0GRmNSYTDtUanwCC3Tif076GjwKuIFzd68jdW
         nW5YKBzaDF7cZuZliKjBWQJOBbmoC7Fj9IKUzcT81G5h3l5gvGS38gssZf2BG13lXC1u
         rowg==
X-Gm-Message-State: ABy/qLYFUnb9mQuVRZqGfSHdqpveHIUk8t8R1OFcCPAr/oR/fJNn4dYO
	QnoPRNOgkS2o57kvslmjFA8=
X-Google-Smtp-Source: APBJJlGTPiQzxsFYWw5+gVXHiWf90UZz2wDBZOQ1WFOOYITnsH4yU0b1usYciuBoVcasQZUPjdpRIQ==
X-Received: by 2002:a05:6a20:38b:b0:12f:7002:c64f with SMTP id 11-20020a056a20038b00b0012f7002c64fmr10279938pzt.35.1688923176998;
        Sun, 09 Jul 2023 10:19:36 -0700 (PDT)
Received: from MacBook-Pro-8.local ([2620:10d:c090:400::5:9b44])
        by smtp.gmail.com with ESMTPSA id i4-20020a63e444000000b004fab4455748sm5947733pgk.75.2023.07.09.10.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jul 2023 10:19:36 -0700 (PDT)
Date: Sun, 9 Jul 2023 10:19:34 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
	razor@blackwall.org, sdf@google.com, john.fastabend@gmail.com,
	kuba@kernel.org, dxu@dxuuu.xyz, joe@cilium.io, toke@kernel.org,
	davem@davemloft.net, bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 2/8] bpf: Add fd-based tcx multi-prog infra
 with link support
Message-ID: <20230709171934.o2v4o5lc66qczygd@MacBook-Pro-8.local>
References: <20230707172455.7634-1-daniel@iogearbox.net>
 <20230707172455.7634-3-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230707172455.7634-3-daniel@iogearbox.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 07, 2023 at 07:24:49PM +0200, Daniel Borkmann wrote:
> diff --git a/net/Kconfig b/net/Kconfig
> index 2fb25b534df5..d532ec33f1fe 100644
> --- a/net/Kconfig
> +++ b/net/Kconfig
> @@ -52,6 +52,11 @@ config NET_INGRESS
>  config NET_EGRESS
>  	bool
>  
> +config NET_XGRESS
> +	select NET_INGRESS
> +	select NET_EGRESS
> +	bool

Since new kconfig is needed, can NET_INGRESS and NET_EGRESS be removed at the same time?

