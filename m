Return-Path: <bpf+bounces-11835-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97DB47C40D6
	for <lists+bpf@lfdr.de>; Tue, 10 Oct 2023 22:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5022C282131
	for <lists+bpf@lfdr.de>; Tue, 10 Oct 2023 20:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8679D29D0B;
	Tue, 10 Oct 2023 20:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VT+qGZV0"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8599321AB
	for <bpf@vger.kernel.org>; Tue, 10 Oct 2023 20:08:09 +0000 (UTC)
Received: from out-206.mta1.migadu.com (out-206.mta1.migadu.com [95.215.58.206])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A44173C
	for <bpf@vger.kernel.org>; Tue, 10 Oct 2023 13:08:02 -0700 (PDT)
Message-ID: <bdffefed-8945-e5ac-052d-0f0b49a30d39@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1696968480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=48GnxUJ3JdEqliNp9G7adxZBHIHNpZhS/fW1boEK60M=;
	b=VT+qGZV0FDeNh7qu7r7D/avhtOK5+1/SxhoJIIr4bJDxTIghGa6L+Vb+9nt5KQyil3UU71
	JYBA09jpgfXTOIdj0T5BdQq+Jy7N1u5IWZ6WpRFWjHkBC5/J8x2GyQrF8jkyGZPosbrXaw
	NlVMVOadPNDvwy1g3Ri/J7J0lETTe+Q=
Date: Tue, 10 Oct 2023 13:07:54 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v9 3/9] bpf: Add bpf_sock_addr_set_unix_addr() to
 allow writing unix sockaddr from bpf
Content-Language: en-US
To: Kuniyuki Iwashima <kuniyu@amazon.com>, daan.j.demeyer@gmail.com
Cc: bpf@vger.kernel.org, kernel-team@meta.com, netdev@vger.kernel.org
References: <20231006074530.892825-4-daan.j.demeyer@gmail.com>
 <20231010170019.4924-1-kuniyu@amazon.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20231010170019.4924-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/10/23 10:00 AM, Kuniyuki Iwashima wrote:
>> +__bpf_kfunc int bpf_sock_addr_set_unix_addr(struct bpf_sock_addr_kern *sa_kern,
>> +					    const u8 *addr, u32 addrlen__sz)
> I'd rename addrlen__sz to sun_path_len or something else because the
> conventional addrlen for AF_UNIX contains offsetof(struct sockaddr_un,
> sun_path).

The "__sz" suffix is required by the verifier. It is the size of the preceding 
argument "addr". While at it, addrlen__sz should be just "addr__sz" (or 
sun_path__sz, depending on what name is decided here) for consistency with other 
kfunc.

I don't have strong preference on the argument name. However, if it is 
sun_path__sz, then the preceding argument should be renamed to "sun_path" also 
for consistency reason and then the kfunc should probably be renamed to 
bpf_sock_addr_set_sun_path.

