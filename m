Return-Path: <bpf+bounces-972-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4103D709F81
	for <lists+bpf@lfdr.de>; Fri, 19 May 2023 21:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFCD21C21363
	for <lists+bpf@lfdr.de>; Fri, 19 May 2023 19:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC8012B9B;
	Fri, 19 May 2023 19:01:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1A312B95
	for <bpf@vger.kernel.org>; Fri, 19 May 2023 19:01:16 +0000 (UTC)
Received: from out-23.mta0.migadu.com (out-23.mta0.migadu.com [IPv6:2001:41d0:1004:224b::17])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 862B7F3
	for <bpf@vger.kernel.org>; Fri, 19 May 2023 12:01:14 -0700 (PDT)
Message-ID: <073cf884-e191-e323-1445-b79c86759557@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1684522872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nmyd7ev1kC4N1SPCSUefexlvGt6H+78x/hkY+aW/KbQ=;
	b=nMrIGWBUuBrYwb8WMXJDdRGeymsJlSPg+G2FjG+pCNRkP3gFcTl6dkgvY0saj70bprml22
	h7wyNaZRx0c8Vi5MQT7IkI4ZVLdDAni2uaNGgdWMuo3/DKIgM6I1gfXyZKFue5MeP8RPTL
	uML/nDfyMhAyBPSGzuncxyJqGPKUnDM=
Date: Fri, 19 May 2023 12:01:09 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: a small question about bpftool struct_ops
Content-Language: en-US
To: Zhouyi Zhou <zhouzhouyi@gmail.com>, bpf@vger.kernel.org,
 linux-kernel <linux-kernel@vger.kernel.org>
References: <CAABZP2wiPdij+q_Nms08e8KbT9+CgXuoU+MO3dyoujG_1PPHAQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAABZP2wiPdij+q_Nms08e8KbT9+CgXuoU+MO3dyoujG_1PPHAQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 5/19/23 5:07 AM, Zhouyi Zhou wrote:
> Dear developers:
> I compiled bpftool and bpf tests in mainline (2d1bcbc6cd70),
> but when I invoke:
> bpftool struct_ops register bpf_cubic.bpf.o
> 
> the command line fail with:
> libbpf: struct_ops init_kern: struct tcp_congestion_ops data is not
> found in struct bpf_struct_ops_tcp_congestion_ops

At the machine trying to register the bpf_cubic, please dump the vmlinux btf and 
search for bpf_struct_ops_tcp_congestion_ops and paste it here:

For example:
#> bpftool btf dump file /sys/kernel/btf/vmlinux

...

[74578] STRUCT 'bpf_struct_ops_tcp_congestion_ops' size=256 vlen=3
         'refcnt' type_id=145 bits_offset=0
         'state' type_id=74569 bits_offset=32
         'data' type_id=6241 bits_offset=512


