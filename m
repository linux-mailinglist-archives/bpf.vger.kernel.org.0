Return-Path: <bpf+bounces-19614-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C90482F274
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 17:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 321BE1C22935
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 16:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E587469;
	Tue, 16 Jan 2024 16:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="SBgXSU1i"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEAF41C698;
	Tue, 16 Jan 2024 16:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=koP0W+CZNZR7MUqDikSTc30SoJIawy0LoQzZcq5Zun8=; b=SBgXSU1iweN0BNqiISJnZZvXVk
	8vLKuTACx1Cy+AEk985t1Hmscy+SDMEXIo6M2GeNnU4X57bnnn1wT+FHPoJ+MkSVwUPy6AafbH5c4
	uDFAAjYLZmIuQagqrTvDYfwNoqhiDATRgeRjbTnqv7l7ZcfZ/zzq6uuC057APGjfACXkrivLE28je
	6ugEOcmGvzGjtPqERCYZtNUM0Jvi0YNzVRWnbjvDEJCZvjNhCorziRnGg/UICdUQtcqwg/nQJ8tN7
	KPFYSIvKLOxvCmt/8VrL7uHS9iZxI0uannOJRx+Mk30yG5/VQRCL8Wms7z21YDC+2wrIDu8rZMAOJ
	G+oG7FBA==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1rPmAX-0002xU-Ev; Tue, 16 Jan 2024 17:20:05 +0100
Received: from [178.197.248.14] (helo=linux.home)
	by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1rPmAW-000PvQ-Tf; Tue, 16 Jan 2024 17:20:04 +0100
Subject: Re: [PATCH v4 2/2] selftests/bpf: Add test for alu on
 PTR_TO_FLOW_KEYS
To: Hao Sun <sunhao.th@gmail.com>, bpf@vger.kernel.org
Cc: willemb@google.com, ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com,
 yonghong.song@linux.dev, linux-kernel@vger.kernel.org
References: <20240115082028.9992-1-sunhao.th@gmail.com>
 <20240115082028.9992-2-sunhao.th@gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <3c69823d-1e46-60f4-5a41-d6a2983af532@iogearbox.net>
Date: Tue, 16 Jan 2024 17:20:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240115082028.9992-2-sunhao.th@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27156/Tue Jan 16 10:38:07 2024)

On 1/15/24 9:20 AM, Hao Sun wrote:
> Add a test case for PTR_TO_FLOW_KEYS alu. Testing if alu with
> variable offset on flow_keys is rejected.
> 
> Signed-off-by: Hao Sun <sunhao.th@gmail.com>

Thanks applied, I've also added a note that we already have coverage
on the success case. Do you plan to follow up with checking the
remaining pointer types as Eduard suggested earlier?

Thanks,
Daniel

