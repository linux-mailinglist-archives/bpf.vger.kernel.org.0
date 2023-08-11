Return-Path: <bpf+bounces-7536-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0F3778A44
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 11:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05250281194
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 09:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2CA163AB;
	Fri, 11 Aug 2023 09:44:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95415690
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 09:44:42 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C5D2D4F
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 02:44:40 -0700 (PDT)
Received: from canpemm500006.china.huawei.com (unknown [172.30.72.56])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RMf1d2SW8zCrZP;
	Fri, 11 Aug 2023 17:41:09 +0800 (CST)
Received: from [10.174.179.200] (10.174.179.200) by
 canpemm500006.china.huawei.com (7.192.105.130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 11 Aug 2023 17:44:38 +0800
Subject: Re: [PATCH bpf-next 0/2] bpf: Update h_proto of ethhdr when the outer
 protocol changed
To: <yonghong.song@linux.dev>, <martin.lau@linux.dev>, <daniel@iogearbox.net>,
	<john.fastabend@gmail.com>, <ast@kernel.org>, <andrii@kernel.org>,
	<song@kernel.org>, <kpsingh@kernel.org>, <sdf@google.com>,
	<haoluo@google.com>, <jolsa@kernel.org>, <bpf@vger.kernel.org>
References: <cover.1691639830.git.william.xuanziyang@huawei.com>
 <148a0235-04c9-6983-4d2a-7030bd91fc4e@linux.dev>
From: "Ziyang Xuan (William)" <william.xuanziyang@huawei.com>
Message-ID: <7b5ec0f4-dff0-a2bf-a996-98cea7d8f843@huawei.com>
Date: Fri, 11 Aug 2023 17:44:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <148a0235-04c9-6983-4d2a-7030bd91fc4e@linux.dev>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.200]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500006.china.huawei.com (7.192.105.130)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> On 8/9/23 11:25 PM, Ziyang Xuan wrote:
>> When use bpf_skb_adjust_room() to encapsulate or decapsulate packet,
>> and outer protocol changed, we can update h_proto of ethhdr directly.
> 
> My mailbox somehow lost patch 1/2.
> 
> Looks like current bpf_skb_adjust_room() only changes skb meta data and
> tries not to modify the packet. Probably there is a reason for this.
> 
I found that this could reduce updating h_proto of ethhdr by bpf_skb_store_bytes()
in bpf program when I used bpf_skb_adjust_room(). I thought it should be a small
optimization. So I did it. No other problems.

Thank you!
William Xuan
>>
>> $./test_tc_tunnel.sh
>> ipip
>> encap 192.168.1.1 to 192.168.1.2, type ipip, mac none len 100
>> test basic connectivity
>> 0
>> test bpf encap without decap (expect failure)
>> Ncat: TIMEOUT.
>> 1
>> test bpf encap with tunnel device decap
>> 0
>> test bpf encap with bpf decap
>> 0
>> OK
>> ipip6
> [...]
> 
> .

