Return-Path: <bpf+bounces-1200-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C8771033E
	for <lists+bpf@lfdr.de>; Thu, 25 May 2023 05:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20A851C20E08
	for <lists+bpf@lfdr.de>; Thu, 25 May 2023 03:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1462C1FB0;
	Thu, 25 May 2023 03:18:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D891919C
	for <bpf@vger.kernel.org>; Thu, 25 May 2023 03:18:15 +0000 (UTC)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006E0C5
	for <bpf@vger.kernel.org>; Wed, 24 May 2023 20:18:13 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-64d24136663so1275209b3a.0
        for <bpf@vger.kernel.org>; Wed, 24 May 2023 20:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684984693; x=1687576693;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8i/L2plNGqKzLPCB7246ZOodsQlBeXR5/BDwe2IBKqY=;
        b=MN680M9688kK0sWplgkfszPccCws0Q6UZ5hNkqMHJNAJpZtdyeYzLG/Rhnsv0T8n8l
         Xn+gNRUEptwB3m/6t6VdwHTBx94gPpjpPDbZTX1QGAX5KsvyqNtilT2xBX4Y7ZpaBbsD
         TyvKeR3CrfWtLsYhipMdIkuRGq9BV6XI3xLmhtSzJ4gkAEhGp/frvBWGP16EnFjH/YPi
         tRbjH8wS+SKoZF3cOLYsg0X1jTkzJjoz7I5IfRvtzK1bwfHnptkYgz976hV3v97Hre1m
         lsc5V0kTNJxi+MvFs37vMOt8ebUYyDbGNJ5CzZpp1iKV5Tf0Hh9WtOfm3tGevkdsXDNE
         wSOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684984693; x=1687576693;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8i/L2plNGqKzLPCB7246ZOodsQlBeXR5/BDwe2IBKqY=;
        b=XUnsrjtjoXAx2c4qyNFBebu/S/+VowAZw/GbQ+sLcpvUzjC+edEAl0eLlVq1niJ37s
         4j1xK4O7nJxWqHYp4ONXZDH9kuxBYgl83YCNhgE5Pjxyvxc9HRWg1zHKN7poPTU7UGs3
         16j7cWHXND4r/eMk8KUxx+fzVRMyRJZ7Gg1rrxoMYqbAJ7bVWJVreZUw/oHDH/UncQgH
         0qOwfd71Etj56LbVBcUDdOWftRE6p20nthI/OgnEiAr6uRjjHwJsnGgNP3/WRloDw+0Y
         bpHo77ECPRVLBTV3CICOTsaDCGEIFq01vSQdKnoCdXC/En7cpsWHj8id6TxN4wQOgwq1
         48iw==
X-Gm-Message-State: AC+VfDwGjBZus0Zab0LWKonPQUDr5X6L/Rx8RSFXeM4ujNRAag+mPz3q
	P+i76v9y5ZlPcJHXTUakx55oP38FOJo=
X-Google-Smtp-Source: ACHHUZ6FV2Tl5p8c4WNFaYAA7j29WqZtSM3MOFCrPVH7fbJ1kYMMJA/r/b/tLhXXf9aVwWHIWFEkIw==
X-Received: by 2002:a05:6a00:1349:b0:644:d220:64ac with SMTP id k9-20020a056a00134900b00644d22064acmr7455403pfu.2.1684984693091;
        Wed, 24 May 2023 20:18:13 -0700 (PDT)
Received: from MacBook-Pro-8.local ([2620:10d:c090:400::5:688d])
        by smtp.gmail.com with ESMTPSA id j15-20020a62b60f000000b0063b6451cd01sm157302pff.121.2023.05.24.20.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 20:18:12 -0700 (PDT)
Date: Wed, 24 May 2023 20:18:10 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	martin.lau@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH RFC bpf-next 1/3] bpf: revamp bpf_attr and name each
 command's field and substruct
Message-ID: <20230525031810.g42tmdk7ykjrkrcr@MacBook-Pro-8.local>
References: <20230524210243.605832-1-andrii@kernel.org>
 <20230524210243.605832-2-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230524210243.605832-2-andrii@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, May 24, 2023 at 02:02:41PM -0700, Andrii Nakryiko wrote:
> 
> And there were a bunch of other similar changes. Please take a thorough
> look and suggest more changes or which changes to drop. I'm not married
> to any of them, it just felt like a good improvement.

Agree that current layout sucks, but ...

>  include/uapi/linux/bpf.h       | 235 +++++++++++++++++++++++++++------
>  kernel/bpf/syscall.c           |  40 +++---
>  tools/include/uapi/linux/bpf.h | 235 +++++++++++++++++++++++++++------
>  3 files changed, 405 insertions(+), 105 deletions(-)

... the diff makes it worse. The diffstat for "nop" change is a red flag.

> +	/*
> +	 * LEGACY anonymous substructs, for backwards compatibility.
> +	 * Each of the below anonymous substructs are ABI compatible with one
> +	 * of the above named substructs. Please use named substructs.
> +	 */
> +

All of them cannot be removed. This bagage will be a forever eyesore.
Currently it's not pretty. The diffs make uapi file just ugly.
Especially considering how 'named' and 'legacy' will start diverging.
New commands are thankfully named. We've learned the lesson,
but prior mistake is unfixable. We have to live with it.

