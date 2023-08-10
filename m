Return-Path: <bpf+bounces-7495-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 136FF7782AC
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 23:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDAF4281E40
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 21:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A700423BE0;
	Thu, 10 Aug 2023 21:26:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E4F20FB3;
	Thu, 10 Aug 2023 21:26:12 +0000 (UTC)
Received: from out-126.mta0.migadu.com (out-126.mta0.migadu.com [91.218.175.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD77AC5;
	Thu, 10 Aug 2023 14:26:10 -0700 (PDT)
Message-ID: <b3d4972e-2a08-d627-db2f-64dfd4e96bde@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1691702768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tNGz4pTuB85L+7AeCTX9+Lb6SU6Dt8W74vUFUR31k7s=;
	b=ahIr4g0vfgmO+EiSnTJG04ePulT0rb2NzL/xjoZunpbqRztizRCzlqZH8CU2YYSx41Wn/p
	kEn16mz4uzsuNC/0kZHl2ZXkIGp6LDgs8dUPtOT+d4UXrPipo3L17tZu7Ht0oLVa+5P2i5
	m9XAKA7sxowU/t2E54qYpWGXPaKxJmU=
Date: Thu, 10 Aug 2023 14:26:01 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: pull-request: bpf-next 2023-08-09
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 daniel@iogearbox.net, andrii@kernel.org, ast@kernel.org,
 netdev@vger.kernel.org, bpf@vger.kernel.org
References: <20230810055123.109578-1-martin.lau@linux.dev>
 <20230810141926.49f4c281@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230810141926.49f4c281@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/10/23 2:19 PM, Jakub Kicinski wrote:
> On Wed,  9 Aug 2023 22:51:23 -0700 Martin KaFai Lau wrote:
>>        bpf: fix bpf_dynptr_slice() to stop return an ERR_PTR.
> 
> This one looks like solid bpf material TBH, any reason it's here?

There is an earlier bpf_dynptr_check_off_len() call which should have caught 
that already, so ERR_PTR case should not happen.
https://lore.kernel.org/bpf/e0e8bf3b-70af-3827-2fa3-30f3d48bcf46@linux.dev/

