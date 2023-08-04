Return-Path: <bpf+bounces-6914-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F335376F6FC
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 03:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A68F42823E8
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 01:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8793A10ED;
	Fri,  4 Aug 2023 01:32:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61597A4E
	for <bpf@vger.kernel.org>; Fri,  4 Aug 2023 01:32:40 +0000 (UTC)
Received: from out-67.mta0.migadu.com (out-67.mta0.migadu.com [91.218.175.67])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF39423E
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 18:32:39 -0700 (PDT)
Message-ID: <e1c0312b-636f-c1b1-fae4-76964afeca28@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1691112757; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zokh0BrVWom5I6SjRmOtl1wPptPAzP3AV4PHW2c513k=;
	b=W/Ynnl/oDMQA91MU0KAQlUFqf3jJeDaC9qbLsrFfhmh0+uIynFy43BVfl6mx7HzstT7E6M
	zwz4LxMTch6l8P7GTLdTfP1eD6QQKBrQH9kn8OSeMcu1S2bjtD4Cn75Ft4XcSm0+nxqyW9
	RE+loXpVphFqcf12BDzueUn+SFQ4ySk=
Date: Thu, 3 Aug 2023 18:32:31 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next] bpf: fix bpf_dynptr_slice() to stop return an
 ERR_PTR.
Content-Language: en-US
To: thinker.li@gmail.com, bpf@vger.kernel.org, ast@kernel.org,
 martin.lau@linux.dev, song@kernel.org, kernel-team@meta.com,
 andrii@kernel.org
Cc: sinquersw@gmail.com, kuifeng@meta.com,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
References: <20230803231206.1060485-1-thinker.li@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20230803231206.1060485-1-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/3/23 4:12 PM, thinker.li@gmail.com wrote:
> From: Kui-Feng Lee <thinker.li@gmail.com>
> 
> Verify if the pointer obtained from bpf_xdp_pointer() is either an error or
> NULL before returning it.
> 
> The function bpf_dynptr_slice() mistakenly returned an ERR_PTR. Instead of
> solely checking for NULL, it should also verify if the pointer returned by
> bpf_xdp_pointer() is an error or NULL.
> 
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/bpf/d1360219-85c3-4a03-9449-253ea905f9d1@moroto.mountain/
> Fixes: 66e3a13e7c2c ("bpf: Add bpf_dynptr_slice and bpf_dynptr_slice_rdwr")
> Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>

