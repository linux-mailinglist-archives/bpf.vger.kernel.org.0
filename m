Return-Path: <bpf+bounces-7478-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A6B77803D
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 20:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 019911C21046
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 18:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2316222EFD;
	Thu, 10 Aug 2023 18:27:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A2521D35
	for <bpf@vger.kernel.org>; Thu, 10 Aug 2023 18:27:52 +0000 (UTC)
Received: from out-69.mta0.migadu.com (out-69.mta0.migadu.com [91.218.175.69])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE8652690
	for <bpf@vger.kernel.org>; Thu, 10 Aug 2023 11:27:50 -0700 (PDT)
Message-ID: <0e342304-7e2f-fc84-c16b-8b1bdfd5487f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1691692068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gqWBZEGhKaYIZGs3Z6wEFEIWRxJwfa7R+s7BCzot500=;
	b=YlZrlI59UgaQIAFcTOrPfl8ghAugciQ7+OmcGPAjAM2bxNodMJ/D9gzomE+HY9u3UbVweM
	5LPKVYwIMVisO4/BGrvixFGw7zSW9AdcO0HEFyFHg4IhF4LU6S9veRrU+JnNwRmcY9+K6a
	xATRHdg6036Gs/1h7WSWp7rUTeA5jgI=
Date: Thu, 10 Aug 2023 11:27:35 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/2] bpf: Update h_proto of ethhdr when the outer
 protocol changed
Content-Language: en-US
To: Ziyang Xuan <william.xuanziyang@huawei.com>
References: <cover.1691639830.git.william.xuanziyang@huawei.com>
 <70fc4e7bf2c760b045898b3d004a0838902f7e08.1691639830.git.william.xuanziyang@huawei.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Cc: daniel@iogearbox.net, john.fastabend@gmail.com, ast@kernel.org,
 andrii@kernel.org, song@kernel.org, yonghong.song@linux.dev,
 kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org,
 bpf@vger.kernel.org
In-Reply-To: <70fc4e7bf2c760b045898b3d004a0838902f7e08.1691639830.git.william.xuanziyang@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/9/23 11:25 PM, Ziyang Xuan wrote:
> When use bpf_skb_adjust_room() to encapsulate or decapsulate packet,
> and outer protocol changed, we can update h_proto of ethhdr directly.

This could break some existing bpf programs. e.g what if the existing prog is 
testing the h_proto after bpf_skb_adjust_room() and expect it hasn't changed yet?


