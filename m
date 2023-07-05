Return-Path: <bpf+bounces-4045-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7C3748313
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 13:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F743280C2B
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 11:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69F36FB3;
	Wed,  5 Jul 2023 11:41:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8CE6AB8
	for <bpf@vger.kernel.org>; Wed,  5 Jul 2023 11:41:59 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4F6E3
	for <bpf@vger.kernel.org>; Wed,  5 Jul 2023 04:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=FuDzqZpTIQGR3bDumqMxxjCtKmhdo38KMvCYUP3Fia4=; b=YOj78kiGp0XqczHIR62MgrGwgo
	SWvY083EbFpEK9bZjWvWRHzqJwHN+O3eTWtvxsVL6eAkXYiFMRVS78gMoS41ogUBoqoKB2/8VNVlU
	TBqkNaJzHNhoQ0DhchGWUVtoh/WvvYY/rCZuLLCppOiGuWaHyS4Ur8L1W8CPPCC875pmpOv//cil/
	ge3JE6YFNqyvghIZ0SGbTfvzJX6M23FIjeA4uQRlKUWgstso6n8RAI1sEmMUGoNruhB6QVBvQtvmJ
	O5/NVMgyKkZdCVv216g8IWcjvD+4lBMXLe1rotnc+N7GpTkB2KtevPQoQy9UFF6GDjTeE9OMeTFG8
	1hqcMGag==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qH0tP-000HDU-Dp; Wed, 05 Jul 2023 13:41:55 +0200
Received: from [178.197.249.31] (helo=linux.home)
	by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qH0tP-000Jak-8K; Wed, 05 Jul 2023 13:41:55 +0200
Subject: Re: [PATCH] bpf: make ringbuf available to modules
To: anton.ivanov@cambridgegreys.com, bpf@vger.kernel.org
References: <20230705091958.2949447-1-anton.ivanov@cambridgegreys.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <04e08645-d793-c32a-36d4-8335002f24ca@iogearbox.net>
Date: Wed, 5 Jul 2023 13:41:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230705091958.2949447-1-anton.ivanov@cambridgegreys.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26960/Wed Jul  5 09:29:05 2023)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/5/23 11:19 AM, anton.ivanov@cambridgegreys.com wrote:
> From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> 
> Ringbuf which was developed as a part of BPF infrastructure is
> a very nice, clean, simple and consise API to relay information
> from the kernel to userspace. It can be used in critical sections,
> interrupt handlers, etc.
> 
> This patch exports ringbuf functionality to make it available to
> kernel modules.
> 
> Demo: https://github.com/kot-begemot-uk/bpfnic-ng
> 
> The demo ships to userspace hardware offload notifications
> without any mallocs, any workqueue and/or delayed work which
> is normally needed to handle these. As a result it is ~ 150
> lines of code instead of the 500+ usually needed to achieve the
> same result.
> 
> Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>

Given this is only for out-of-tree code, we cannot merge this patch.

Thanks,
Daniel

