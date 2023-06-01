Return-Path: <bpf+bounces-1566-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 503D37194B7
	for <lists+bpf@lfdr.de>; Thu,  1 Jun 2023 09:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CA30281666
	for <lists+bpf@lfdr.de>; Thu,  1 Jun 2023 07:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD5DD2E3;
	Thu,  1 Jun 2023 07:49:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F20C12F
	for <bpf@vger.kernel.org>; Thu,  1 Jun 2023 07:49:04 +0000 (UTC)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F40E19D
	for <bpf@vger.kernel.org>; Thu,  1 Jun 2023 00:49:02 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f6e13940daso5941305e9.0
        for <bpf@vger.kernel.org>; Thu, 01 Jun 2023 00:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1685605741; x=1688197741;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IixDW4hFtKMF6IQay/0w4OvSqO+8DXedjJMSkTKUjc0=;
        b=WjUm7g3pyU60Dt4Hc9O7DdT2wbbdmlgpp1mSPNzvpoQzUdWuFZvS1wL2d60AOrseSr
         IlHjbn+EmMZ5eawu9ZrjbWfwrA7Rgex2Ap89WnY5+hOr1N8lHDW9OqS3AgpV5ESej95B
         1uw9Lvky7Lwk3gxZAN+7eMelewBbCnwudy3FWaiaoIYgDd875yLbgRj5ESZBZR0ZRZIE
         tSxTOtNlLymDY3Xum+puki34c2qs8YOY6JYTwAi/uqcXjSecy19l36gk/t38RS10m/87
         J6ahjkmx+Y/jxkM5IYxGneI0hGEnRbfZa04K/lnxlFPIOGy7unkRItQo+NMdFdny8aRV
         uMqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685605741; x=1688197741;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IixDW4hFtKMF6IQay/0w4OvSqO+8DXedjJMSkTKUjc0=;
        b=gyMHZ58XGxZotk2pZJmk2zIjwJPcRCNfxdG2Frhxt7ZfK7XqpzUp3OEqxk0eCkxOEz
         d9ETQVW5G5PUfSPkEp0g5iRxH/OCk/OQitI/nW4jjpMkxGRuzkWGUKMBTTzeQA5D1yLO
         rpz78+VF1UPQB1ovGa3bskiJSqAt+9KnxepXiJ10VALzZNcBMFwqrhG8zGQvAOWiN0e4
         cXlxDJ7VQcOZD4e1ubTEAP0I+pcPSrKdywxN1OISmeLU8T/ggFVaIdscPy+TQL6d45jy
         WpvdB0QOg5leS1tiF4FIj4RQQW9ui8QJlYfQTsil7GP9PvwG2C63PZ99dSc/EJdSwGdD
         Jzgw==
X-Gm-Message-State: AC+VfDyTAIF/ymqN6OA4gkAPbbYMAWzVxgO5zQElLuIjCDeh1iCojhDF
	6QYB1ABti0HTi6zApcAqMBd83PrpGJPZGJKrTYn58uVt
X-Google-Smtp-Source: ACHHUZ4u9EZl8Pd8vKLMeCSbWA2CcpZihnV/qHgS/CsZo50iWGqlUeaZQJWNaBFDlmJeugwDoqGJ/A==
X-Received: by 2002:a05:600c:3645:b0:3f4:ef34:fbc2 with SMTP id y5-20020a05600c364500b003f4ef34fbc2mr1652163wmq.24.1685605740996;
        Thu, 01 Jun 2023 00:49:00 -0700 (PDT)
Received: from zh-lab-node-5 ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id n16-20020a5d4850000000b0030632833e74sm9301244wrs.11.2023.06.01.00.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 00:49:00 -0700 (PDT)
Date: Thu, 1 Jun 2023 07:50:00 +0000
From: Anton Protopopov <aspsk@isovalent.com>
To: kernel test robot <lkp@intel.com>
Cc: bpf@vger.kernel.org, oe-kbuild-all@lists.linux.dev,
	Joe Stringer <joe@isovalent.com>,
	John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: add new map ops ->map_pressure
Message-ID: <ZHhNqDi7+k5VzofY@zh-lab-node-5>
References: <20230531110511.64612-2-aspsk@isovalent.com>
 <202306010837.mGhA199K-lkp@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202306010837.mGhA199K-lkp@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 01, 2023 at 08:44:24AM +0800, kernel test robot wrote:
> Hi Anton,
> 
> kernel test robot noticed the following build errors:
> 
> [...]
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202306010837.mGhA199K-lkp@intel.com/

How does this apply to patches? If I send a v2, should I include these tags
there? If this patch gets rejected, is there need to do anything to close the
robot's ticket?

> All errors (new ones prefixed by >>):
> 
>    kernel/bpf/hashtab.c: In function 'htab_map_pressure':
> >> kernel/bpf/hashtab.c:189:24: error: implicit declaration of function '__percpu_counter_sum'; did you mean 'percpu_counter_sum'? [-Werror=implicit-function-declaration]
>      189 |                 return __percpu_counter_sum(&htab->pcount);
>          |                        ^~~~~~~~~~~~~~~~~~~~
>          |                        percpu_counter_sum
>    cc1: some warnings being treated as errors
> 
> 
> vim +189 kernel/bpf/hashtab.c
> 
>    183	
>    184	static u32 htab_map_pressure(const struct bpf_map *map)
>    185	{
>    186		struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
>    187	
>    188		if (htab->use_percpu_counter)
>  > 189			return __percpu_counter_sum(&htab->pcount);
>    190		return atomic_read(&htab->count);
>    191	}
>    192	

(This bug happens for !SMP case.)

> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

