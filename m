Return-Path: <bpf+bounces-3747-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8E6742938
	for <lists+bpf@lfdr.de>; Thu, 29 Jun 2023 17:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEC1E1C20A1A
	for <lists+bpf@lfdr.de>; Thu, 29 Jun 2023 15:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F76F12B72;
	Thu, 29 Jun 2023 15:15:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A867125A9
	for <bpf@vger.kernel.org>; Thu, 29 Jun 2023 15:15:35 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F3D1BD1;
	Thu, 29 Jun 2023 08:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=JyvFeXPxz6Be0T6oJyIK/ZexPeUDpqw2K2D+Uj5LllY=; b=adSAk2pGb6Y58ZgDJHKsT2CWo6
	T5sPGcWD4mS1Eo4v1PUR75FaTNp3KfqwZjlW0pGlwEKhEMwfhxnG8DTm2LGVHGkKxY6dLEIQ0jaDs
	KGleVj2s+DWJ5ObIU4okuZRatV99ybBntczEHuNeU9lrJwrQjfoeERFF5Y1r5xS/AZYDtDRs05FvQ
	fJRRuW3NwneBSwzEwvr8z8CkeqypzwyveZ5puc6oNtc0jW6fqda9O+BAtWRbb9s0haLIE2vlq/6G1
	dOkNIEvbsvDOF2qKtoz7JdF2E85QH10Zg0uVrANJYK+Tad7JpmGIpaCrKlEZHbqkw+uB+I7RQzUms
	NegOCIrQ==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qEtMp-0004dN-DH; Thu, 29 Jun 2023 17:15:31 +0200
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qEtMp-000Kbo-2g; Thu, 29 Jun 2023 17:15:31 +0200
Subject: Re: PSA: Ubuntu pahole creates buggy BTF
To: Lorenz Bauer <lmb@isovalent.com>, bpf <bpf@vger.kernel.org>,
 dwarves@vger.kernel.org, Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
 Dimitri John Ledkov <dimitri.ledkov@canonical.com>,
 Domenico Andreoli <cavok@debian.org>
References: <CAN+4W8junMrqMTQJ1cy-5fhd9FFsASWOndRPaprspKXMXShJYQ@mail.gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <aaf6220c-dddf-ee5f-37a2-e16bd580c0a7@iogearbox.net>
Date: Thu, 29 Jun 2023 17:15:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAN+4W8junMrqMTQJ1cy-5fhd9FFsASWOndRPaprspKXMXShJYQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26954/Thu Jun 29 09:29:58 2023)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

[ Also Cc'ing Dimitri / Domenico ]

On 6/29/23 4:41 PM, Lorenz Bauer wrote:
> Just a quick FYI for anyone else struggling with weird BTF on recent
> Ubuntu releases, it seems like their pahole is broken due to an
> incorrect backport.
> 
> The upstream issue is here:
> https://bugs.launchpad.net/ubuntu/+source/dwarves/+bug/2025370

(for ctx, original issue was here: https://github.com/cilium/ebpf/issues/1081)

Thanks,
Daniel

