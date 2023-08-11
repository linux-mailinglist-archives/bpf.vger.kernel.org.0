Return-Path: <bpf+bounces-7538-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34194778BEB
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 12:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65D3E1C20BA4
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 10:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5912A7475;
	Fri, 11 Aug 2023 10:22:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3275B7472
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 10:22:32 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60B21FE1
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 03:22:31 -0700 (PDT)
Received: from canpemm500006.china.huawei.com (unknown [172.30.72.53])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RMfsJ2bpGzCrq1;
	Fri, 11 Aug 2023 18:19:00 +0800 (CST)
Received: from [10.174.179.200] (10.174.179.200) by
 canpemm500006.china.huawei.com (7.192.105.130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 11 Aug 2023 18:22:29 +0800
Subject: Re: [PATCH bpf-next 1/2] bpf: Update h_proto of ethhdr when the outer
 protocol changed
To: Martin KaFai Lau <martin.lau@linux.dev>
CC: <daniel@iogearbox.net>, <john.fastabend@gmail.com>, <ast@kernel.org>,
	<andrii@kernel.org>, <song@kernel.org>, <yonghong.song@linux.dev>,
	<kpsingh@kernel.org>, <sdf@google.com>, <haoluo@google.com>,
	<jolsa@kernel.org>, <bpf@vger.kernel.org>
References: <cover.1691639830.git.william.xuanziyang@huawei.com>
 <70fc4e7bf2c760b045898b3d004a0838902f7e08.1691639830.git.william.xuanziyang@huawei.com>
 <0e342304-7e2f-fc84-c16b-8b1bdfd5487f@linux.dev>
From: "Ziyang Xuan (William)" <william.xuanziyang@huawei.com>
Message-ID: <ec0b5707-d409-daa7-7700-dc620263967f@huawei.com>
Date: Fri, 11 Aug 2023 18:22:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <0e342304-7e2f-fc84-c16b-8b1bdfd5487f@linux.dev>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.200]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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
> This could break some existing bpf programs. e.g what if the existing prog is testing the h_proto after bpf_skb_adjust_room() and expect it hasn't changed yet?
> 
I think some new modifications break some existing things are not unacceptable.
Maybe my modification is inappropriate because its benefits are small and
some kind of principle is broken, such as Yonghong Song pointed:
"bpf_skb_adjust_room() only changes skb meta data and tries not to modify the packet."
If it is, the modification should be rejected.

Thank you!
William Xuan
> 
> .

