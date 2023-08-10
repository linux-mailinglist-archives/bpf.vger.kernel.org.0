Return-Path: <bpf+bounces-7466-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DEE777CD1
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 17:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CFA71C215D1
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 15:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A100C20CB8;
	Thu, 10 Aug 2023 15:54:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C5C200BC
	for <bpf@vger.kernel.org>; Thu, 10 Aug 2023 15:54:38 +0000 (UTC)
Received: from out-126.mta1.migadu.com (out-126.mta1.migadu.com [IPv6:2001:41d0:203:375::7e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA9DA2D5E
	for <bpf@vger.kernel.org>; Thu, 10 Aug 2023 08:54:34 -0700 (PDT)
Message-ID: <148a0235-04c9-6983-4d2a-7030bd91fc4e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1691682872; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jiK/ir92lWSsin+KBr0SDK7iSYqbqIvk+r3+9HFg5m4=;
	b=vZRgOCLvrcMDdsLhRudk90tSJ5+ybE6nnJjKEJFucbSYTrVyAzInjbx3ni8BoT/PqJqeF/
	J9sD1nfv3ezo3JHjKxZeEU1iRCp+/Q29Bl51at272no5De3UWVOqQxqFJYkUK53Crw26rG
	EXvjJu8LLZQcKKYGPcKpYZHzM9TNB2k=
Date: Thu, 10 Aug 2023 08:54:24 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next 0/2] bpf: Update h_proto of ethhdr when the outer
 protocol changed
To: Ziyang Xuan <william.xuanziyang@huawei.com>, martin.lau@linux.dev,
 daniel@iogearbox.net, john.fastabend@gmail.com, ast@kernel.org,
 andrii@kernel.org, song@kernel.org, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org
References: <cover.1691639830.git.william.xuanziyang@huawei.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <cover.1691639830.git.william.xuanziyang@huawei.com>
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

My mailbox somehow lost patch 1/2.

Looks like current bpf_skb_adjust_room() only changes skb meta data and
tries not to modify the packet. Probably there is a reason for this.

> 
> $./test_tc_tunnel.sh
> ipip
> encap 192.168.1.1 to 192.168.1.2, type ipip, mac none len 100
> test basic connectivity
> 0
> test bpf encap without decap (expect failure)
> Ncat: TIMEOUT.
> 1
> test bpf encap with tunnel device decap
> 0
> test bpf encap with bpf decap
> 0
> OK
> ipip6
[...]

