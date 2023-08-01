Return-Path: <bpf+bounces-6539-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15FAF76AAB4
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 10:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 389E61C20E13
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 08:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6EAA1ED31;
	Tue,  1 Aug 2023 08:17:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CB619BBC
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 08:17:14 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 879B319A4;
	Tue,  1 Aug 2023 01:17:11 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.54])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RFSbK6f0JzVjj9;
	Tue,  1 Aug 2023 16:15:25 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 1 Aug 2023 16:17:08 +0800
Message-ID: <2b987417-43e8-3f1d-3519-b853399805a5@huawei.com>
Date: Tue, 1 Aug 2023 16:17:07 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH -next v2] selftests/bpf: replace fall through comment by
 fallthrough pseudo-keyword
Content-Language: en-US
To: Artem Savkov <asavkov@redhat.com>
CC: <Ast@kernel.org>, <Daniel@iogearbox.net>, <Andrii@kernel.org>,
	<Martin.lau@linux.dev>, <Song@kernel.org>, <Yonghong.song@linux.dev>,
	<John.fastabend@gmail.com>, <Kpsingh@kernel.org>, <Sdf@google.com>,
	<Haoluo@google.com>, <Jolsa@kernel.org>, <Mykolal@fb.com>,
	<Shuah@kernel.org>, <Benjamin.tissoires@redhat.com>, <Memxor@gmail.com>,
	<Iii@linux.ibm.com>, <Colin.i.king@gmail.com>, <Awkrail01@gmail.com>,
	<Rdunlap@infradead.org>, <Joannelkoong@gmail.com>, <bpf@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
References: <20230801065447.3609130-1-ruanjinjie@huawei.com>
 <20230801074735.GA571679@alecto.usersys.redhat.com>
From: Ruan Jinjie <ruanjinjie@huawei.com>
In-Reply-To: <20230801074735.GA571679@alecto.usersys.redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 2023/8/1 15:47, Artem Savkov wrote:
> Hi,
> 
> On Tue, Aug 01, 2023 at 02:54:47PM +0800, Ruan Jinjie wrote:
>> Replace the existing /* fall through */ comments with the
>> new pseudo-keyword macro fallthrough[1].
>>
>> [1] https://www.kernel.org/doc/html/v5.7/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through
>>
>> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
>> ---
>> v2:
>> - Update the subject and commit message.
> 
> I think what Alexei meant was subject-prefix which needs to be
> 'PATCH bpf-next'. You can read more about patch submission rules
> in Documentation/bpf/bpf_devel_QA.rst.

Thank you very much! I will fix it in v3.
> 

