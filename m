Return-Path: <bpf+bounces-6219-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB807671BB
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 18:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45D1D1C218E9
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 16:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF1314ABB;
	Fri, 28 Jul 2023 16:19:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF8414A9F
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 16:19:02 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36E826B2
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 09:18:57 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id A6366C15155E
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 09:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1690561137; bh=nz0ifCwTiFdYrSE52UgceWoQeix7ZyO0b9kpOlDQ59s=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To;
	b=DsfCGOwQVJd4dqQn9mJajKZjFZoA84z4Y8vk9vLLOn1iryfm8AynAsFtWSZE14iXS
	 q3oFDYNAR+TzBDFYVClo2uSGGMvJJEOQZ5Iv9b+hMtGIc/F4tbEpLNsw/oUxWWdPTH
	 q10dyzg5EvsVR1eZHXK3qTnAu96T3UOuNUxbfEl0=
X-Mailbox-Line: From bpf-bounces@ietf.org  Fri Jul 28 09:18:57 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 75D29C15106E;
	Fri, 28 Jul 2023 09:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1690561137; bh=nz0ifCwTiFdYrSE52UgceWoQeix7ZyO0b9kpOlDQ59s=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To;
	b=DsfCGOwQVJd4dqQn9mJajKZjFZoA84z4Y8vk9vLLOn1iryfm8AynAsFtWSZE14iXS
	 q3oFDYNAR+TzBDFYVClo2uSGGMvJJEOQZ5Iv9b+hMtGIc/F4tbEpLNsw/oUxWWdPTH
	 q10dyzg5EvsVR1eZHXK3qTnAu96T3UOuNUxbfEl0=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 174C4C15106E
 for <bpf@ietfa.amsl.com>; Fri, 28 Jul 2023 09:18:56 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -2.106
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H4,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (1024-bit key)
 header.d=linux.dev
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ryGW2vUTWNDO for <bpf@ietfa.amsl.com>;
 Fri, 28 Jul 2023 09:18:51 -0700 (PDT)
Received: from out-83.mta1.migadu.com (out-83.mta1.migadu.com [95.215.58.83])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id A546CC15106B
 for <bpf@ietf.org>; Fri, 28 Jul 2023 09:18:51 -0700 (PDT)
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
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20230728132531.GA7328@maniforge>
X-Migadu-Flow: FLOW_OUT
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/XB_6WrBihuLXLhAesCFy-PasN5g>
Subject: Re: [Bpf] [PATCH bpf-next v5 17/17] docs/bpf: Add documentation for
 new instructions
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: Discussion of BPF/eBPF standardization efforts within the IETF
 <bpf.ietf.org>
List-Unsubscribe: <https://www.ietf.org/mailman/options/bpf>,
 <mailto:bpf-request@ietf.org?subject=unsubscribe>
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
List-Subscribe: <https://www.ietf.org/mailman/listinfo/bpf>,
 <mailto:bpf-request@ietf.org?subject=subscribe>
Reply-To: yonghong.song@linux.dev
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>
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

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

