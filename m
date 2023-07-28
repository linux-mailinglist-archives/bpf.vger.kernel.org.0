Return-Path: <bpf+bounces-6287-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2F3767935
	for <lists+bpf@lfdr.de>; Sat, 29 Jul 2023 01:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DCC91C218B1
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 23:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75BB525C;
	Fri, 28 Jul 2023 23:57:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCE1214E5
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 23:57:55 +0000 (UTC)
Received: from out-123.mta0.migadu.com (out-123.mta0.migadu.com [IPv6:2001:41d0:1004:224b::7b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52787E60
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 16:57:53 -0700 (PDT)
Message-ID: <e79da177-361a-07fb-710a-967a19d5c7a9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1690588670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vmm9PWjiIr44mtk0aK3RfwDQJ7qs4MHr/qIjINwktmM=;
	b=dYK3bR4jfVJXnzSRaMfZqtnW4gFU6mfQxSiBrWTH7pkmIsrNZe3P7OS3MRTRmLB2PV/QqV
	9N2vHep1i4010Eypia8/71Gglslv0Pb7EADYRUDwiM4izode8w4ZvoKo877JOqYSLuQQp5
	bC4NKn6bn4uBus7aXZze2rnixJxZLd4=
Date: Fri, 28 Jul 2023 16:57:43 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] bpf: Add length check for
 SK_DIAG_BPF_STORAGE_REQ_MAP_FD parsing
Content-Language: en-US
To: Paolo Abeni <pabeni@redhat.com>, Lin Ma <linma@zju.edu.cn>
References: <20230725023330.422856-1-linma@zju.edu.cn>
 <c4ca108f891718188ea2a9560324d23de2740565.camel@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 ast@kernel.org, martin.lau@kernel.org, yhs@fb.com, void@manifault.com,
 andrii@kernel.org, houtao1@huawei.com, inwardvessel@gmail.com,
 kuniyu@amazon.com, songliubraving@fb.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <c4ca108f891718188ea2a9560324d23de2740565.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/27/23 12:34 AM, Paolo Abeni wrote:
> On Tue, 2023-07-25 at 10:33 +0800, Lin Ma wrote:
>> The nla_for_each_nested parsing in function bpf_sk_storage_diag_alloc
>> does not check the length of the nested attribute. This can lead to an
>> out-of-attribute read and allow a malformed nlattr (e.g., length 0) to
>> be viewed as a 4 byte integer.
>>
>> This patch adds an additional check when the nlattr is getting counted.
>> This makes sure the latter nla_get_u32 can access the attributes with
>> the correct length.
>>
>> Fixes: 1ed4d92458a9 ("bpf: INET_DIAG support in bpf_sk_storage")
>> Suggested-by: Jakub Kicinski <kuba@kernel.org>
>> Signed-off-by: Lin Ma <linma@zju.edu.cn>
> 
> I guess this should go via the ebpf tree, right? Setting the delegate
> accordingly.

Already applied to the bpf tree. Thanks.
pw-bot seems not doing auto-reply for the bpf tree.



