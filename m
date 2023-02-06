Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E05AC68B396
	for <lists+bpf@lfdr.de>; Mon,  6 Feb 2023 02:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjBFBFv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Sun, 5 Feb 2023 20:05:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjBFBFv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 5 Feb 2023 20:05:51 -0500
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B62D1816F
        for <bpf@vger.kernel.org>; Sun,  5 Feb 2023 17:05:44 -0800 (PST)
X-QQ-mid: bizesmtp65t1675645527tvnoidrq
Received: from smtpclient.apple ( [1.202.165.115])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 06 Feb 2023 09:05:25 +0800 (CST)
X-QQ-SSF: 0100000000000090B000000A0000000
X-QQ-FEAT: +LhgrVJY36KhoUizxHp3wZrAec5LwClDWMLHUdFh+pSqI5S5eUbB1XyUHdqkL
        /RintEXlJSUVvrRYg1ijj937PpI8DIpGSnH3cVWeii6BXOmgSG/va6/cxndNoT4avhyRYIt
        elOkETO3FScIQnytJFwzh5sTX2TJYmG/+XnAZMS+SIe8fcI52iCNhRNP3kOJ8FFVYHI2DJx
        /PWC+K1QkPsxySYbysvgeKmSTTPjZY13EBsfHL7YsV3llFPZSUdDw/2qV8QLWrtQikjAOXX
        7WkrMSwyZZ2crnbb+UG7p/NzsbHLDF2luVzTwrtQ2jgudtfxl3XXcOqDUDgbyywriy671sq
        MLwsepqXgu28Dy8QJruIJ2LVsL0GA==
X-QQ-GoodBg: 0
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.20.0.1.32\))
Subject: Re: [bpf-next v1] bpf: introduce stats update helper
From:   Tonghao Zhang <tong@infragraf.org>
In-Reply-To: <4da7e8dc-25cf-1c4a-bac0-1965df74b645@linux.dev>
Date:   Mon, 6 Feb 2023 09:05:06 +0800
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Hou Tao <houtao1@huawei.com>, bpf@vger.kernel.org,
        John Fastabend <john.fastabend@gmail.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <A0CBEFBA-719B-4219-9500-489985873FEA@infragraf.org>
References: <20230203133220.48919-1-tong@infragraf.org>
 <63ddd56327756_6bb1520881@john.notmuch>
 <4da7e8dc-25cf-1c4a-bac0-1965df74b645@linux.dev>
To:     Martin KaFai Lau <martin.lau@linux.dev>
X-Mailer: Apple Mail (2.3693.20.0.1.32)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:infragraf.org:qybglogicsvr:qybglogicsvr5
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Feb 4, 2023, at 2:06 PM, Martin KaFai Lau <martin.lau@linux.dev> wrote:
> 
> On 2/3/23 7:47 PM, John Fastabend wrote:
>> tong@ wrote:
>>> From: Tonghao Zhang <tong@infragraf.org>
>>> 
>>> This patch introduce a stats update helper to simplify codes.
>>> 
>>> Signed-off-by: Tonghao Zhang <tong@infragraf.org>
>>> Cc: Alexei Starovoitov <ast@kernel.org>
>>> Cc: Daniel Borkmann <daniel@iogearbox.net>
>>> Cc: Andrii Nakryiko <andrii@kernel.org>
>>> Cc: Martin KaFai Lau <martin.lau@linux.dev>
>>> Cc: Song Liu <song@kernel.org>
>>> Cc: Yonghong Song <yhs@fb.com>
>>> Cc: John Fastabend <john.fastabend@gmail.com>
>>> Cc: KP Singh <kpsingh@kernel.org>
>>> Cc: Stanislav Fomichev <sdf@google.com>
>>> Cc: Hao Luo <haoluo@google.com>
>>> Cc: Jiri Olsa <jolsa@kernel.org>
>>> Cc: Hou Tao <houtao1@huawei.com>
>>> ---
>>>  include/linux/filter.h  | 22 +++++++++++++++-------
>>>  kernel/bpf/trampoline.c | 10 +---------
>>>  2 files changed, 16 insertions(+), 16 deletions(-)
>> Seems fine but I'm not sure it makes much difference.
> 
> I also don't think it is needed. There are only two places. Also, it is not encouraged to collect more stats. Refactoring it is not going to help in the future.
It only simply the codes, make the code more readable.
----
Best Regards, Tonghao <tong@infragraf.org>

