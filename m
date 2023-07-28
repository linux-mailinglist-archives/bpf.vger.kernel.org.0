Return-Path: <bpf+bounces-6218-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2EA37671B8
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 18:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B3EE2827F1
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 16:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49AA814AB4;
	Fri, 28 Jul 2023 16:18:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C06114014
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 16:18:51 +0000 (UTC)
Received: from out-89.mta1.migadu.com (out-89.mta1.migadu.com [IPv6:2001:41d0:203:375::59])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E761BF2
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 09:18:50 -0700 (PDT)
Message-ID: <7e8bb4a9-5f42-70ba-5149-d7c453b216f6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1690561128; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zTvfN+q7+xEamIkOoHJ8TsPBm2GTUtqPLbopuWTrP8g=;
	b=iX5YjVLgakpm8Rjku8moy68BDYqqw2icYaHUVo2e1YKDmtcSoDGl3Q1t53jJO3osEI4VSV
	qbe2Z/iN8txf6HaYIDhotMEfr60/1gqkDoFr+Rj0cZVLF6MnHw8URoWYnSLXQo4YZov8hW
	SYhcFlSkFA83QQ1bI4G1TlavhrfR+kY=
Date: Fri, 28 Jul 2023 09:18:41 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next v5 17/17] docs/bpf: Add documentation for new
 instructions
Content-Language: en-US
To: David Vernet <void@manifault.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@kernel.org>,
 David Faust <david.faust@oracle.com>, Fangrui Song <maskray@google.com>,
 "Jose E . Marchesi" <jose.marchesi@oracle.com>, kernel-team@fb.com,
 bpf@ietf.org
References: <20230728011143.3710005-1-yonghong.song@linux.dev>
 <20230728011342.3724411-1-yonghong.song@linux.dev>
 <20230728132531.GA7328@maniforge>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20230728132531.GA7328@maniforge>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/28/23 6:25 AM, David Vernet wrote:
> On Thu, Jul 27, 2023 at 06:13:42PM -0700, Yonghong Song wrote:
>> Add documentation in instruction-set.rst for new instruction encoding
>> and their corresponding operations. Also removed the question
>> related to 'no BPF_SDIV' in bpf_design_QA.rst since we have
>> BPF_SDIV insn now.
> 
> Sorry for reviewing this after it was merged. Leaving some thoughts
> which can be addressed in a subsequent patch.

Thanks David. Ack to your below suggestions.
Will send a patch later on to address your below comments.

> 
>>
>> Cc: bpf@ietf.org
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   Documentation/bpf/bpf_design_QA.rst           |   5 -
>>   .../bpf/standardization/instruction-set.rst   | 115 ++++++++++++------
>>   2 files changed, 79 insertions(+), 41 deletions(-)
>>
[...]

