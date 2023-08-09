Return-Path: <bpf+bounces-7407-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A9A776CD6
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 01:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C10D3281B3C
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 23:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1261E522;
	Wed,  9 Aug 2023 23:31:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBA51E514
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 23:31:20 +0000 (UTC)
Received: from out-66.mta0.migadu.com (out-66.mta0.migadu.com [91.218.175.66])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E56E74
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 16:31:18 -0700 (PDT)
Message-ID: <230ada70-82e4-5350-e3f1-48555670d775@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1691623876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vyI/+M3aclhO4SaI1jQVYSbyKpxFmKu64ie+uj3JSYg=;
	b=mZULxI1TCzzszwYB7huFZcwX2IjKJJPQk7k9fKO81c2OJ2JJ+PylLg/YsD3dnqsHauMYSi
	ieVzbqq65sdn+Q1C4KW39QLiGFbqYoOHgabQlIjsOL0fNJQ4tYi3bgDtYXv3NaeI0sWQLZ
	LJnVPi0fP+eUSbyOuVop0aWOLB3qXAw=
Date: Wed, 9 Aug 2023 16:31:10 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [linux-next:master] BUILD REGRESSION
 21ef7b1e17d039053edaeaf41142423810572741
Content-Language: en-US
To: Tirthendu Sarkar <tirthendu.sarkar@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 kernel test robot <lkp@intel.com>
References: <202308100207.to2feahW-lkp@intel.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <202308100207.to2feahW-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/9/23 11:29 AM, kernel test robot wrote:
> Unverified Error/Warning (likely false positive, please contact us if interested):
> 
> drivers/block/ublk_drv.c:445 ublk_setup_iod_zoned() warn: signedness bug returning '(-95)'
> drivers/gpu/drm/tests/drm_exec_test.c:166 test_prepare_array() error: uninitialized symbol 'ret'.
> drivers/input/touchscreen/iqs7211.c:1761 iqs7211_parse_cycles() error: buffer overflow 'cycle_alloc[0]' 2 <= 41
> drivers/regulator/max77857-regulator.c:430:28: sparse: sparse: symbol 'max77857_id' was not declared. Should it be static?
> drivers/soundwire/qcom.c:905:22-23: WARNING opportunity for min()
> drivers/video/fbdev/core/fb_chrdev.c:239 do_fscreeninfo_to_user() warn: ignoring unreachable code.
> kernel/workqueue.c:324:40: sparse: sparse: duplicate [noderef]
> kernel/workqueue.c:324:40: sparse: sparse: multiple address spaces given: __percpu & __rcu
> mm/khugepaged.c:2138 collapse_file() warn: variable dereferenced before check 'cc' (see line 1787)
> net/xdp/xsk.c:696 xsk_build_skb() error: 'skb' dereferencing possible ERR_PTR()

Maciej and Tirthendu, the report on xsk looks legit and may be related to commit 
cf24f5a5feea ("xsk: add support for AF_XDP multi-buffer on Tx path"). Please 
help to take a look. Thanks.

