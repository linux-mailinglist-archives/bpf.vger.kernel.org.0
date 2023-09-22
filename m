Return-Path: <bpf+bounces-10615-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 074AA7AACAF
	for <lists+bpf@lfdr.de>; Fri, 22 Sep 2023 10:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id 7CA4E1F225F1
	for <lists+bpf@lfdr.de>; Fri, 22 Sep 2023 08:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6CDA1DDF1;
	Fri, 22 Sep 2023 08:31:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359EF1DDE9;
	Fri, 22 Sep 2023 08:31:22 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A686E83;
	Fri, 22 Sep 2023 01:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:Cc:To:References:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=O6U42eOE2ldK54dJpZcJGeTJkJVss+9hSeHi3irefeI=; b=HiCSWfTcg+iIBgtsk1jYShiEHQ
	POSA2MirU470UqUCpTA9DeWFAWYEhTWWggCYnj8OuzxRFDWRWC/lAfScpTrxEx0zl3ixMW+2pmHhK
	xhKEHElrBU1ROrUuh9zzkudoR+WkA0B0fEvWHknIEXE3ncFqhf1uHw0wTPItkKTAAGJQDMX8Fqkfh
	cmRmyBzcrU1ikxPERV94lddOhYuDNfHvjD8EGxY1026O53GO3wb6I7JsvRbVirr3StunrYSbcsToN
	CC9cLxDS6zDg7+dTXqJj8lu018165X53+DfQgUqougF2i1ZMOCyzuGFcy4q4wowVkU1INe1UxZoR0
	YFHnm5OA==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qjbZG-0008eK-0n; Fri, 22 Sep 2023 10:31:18 +0200
Received: from [109.164.249.201] (helo=localhost.localdomain)
	by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qjbZF-000CbV-QO; Fri, 22 Sep 2023 10:31:17 +0200
Subject: LPC 2023 Networking and BPF Track CFP (Final Reminder)
References: <5c9482c9-1f61-2886-4137-a2e2679b2662@iogearbox.net>
To: netdev@vger.kernel.org, bpf@vger.kernel.org
Cc: xdp-newbies@vger.kernel.org, linux-wireless@vger.kernel.org,
 netfilter-devel@vger.kernel.org
From: Daniel Borkmann <daniel@iogearbox.net>
X-Forwarded-Message-Id: <5c9482c9-1f61-2886-4137-a2e2679b2662@iogearbox.net>
Message-ID: <96d6e492-5e00-3bc7-ce5b-83347e8628a7@iogearbox.net>
Date: Fri, 22 Sep 2023 10:31:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <5c9482c9-1f61-2886-4137-a2e2679b2662@iogearbox.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27038/Thu Sep 21 09:39:42 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This is the final reminder for the Call for Proposals (CFP) for the Networking
and BPF track at the 2023 edition of the Linux Plumbers Conference (LPC) which
is taking place in Richmond, VA, United States, on November 13th - 15th, 2023.

Note that the conference is planned to be both in person and remote (hybrid).
CFP submitters should ideally be able to give their presentation in person to
minimize technical issues, although presenting remotely will also be possible.

The Networking and BPF track technical committee consists of:

     David S. Miller <davem@davemloft.net>
     Jakub Kicinski <kuba@kernel.org>
     Paolo Abeni <pabeni@redhat.com>
     Eric Dumazet <edumazet@google.com>
     Alexei Starovoitov <ast@kernel.org>
     Daniel Borkmann <daniel@iogearbox.net>
     Andrii Nakryiko <andrii@kernel.org>
     Martin Lau <martin.lau@linux.dev>

We are seeking proposals of 30 minutes in length (including Q&A discussion). Any
kind of advanced Linux networking and/or BPF related topic will be considered.

Please submit your proposals through the official LPC website at:

     https://lpc.events/event/17/abstracts/

Make sure to select "eBPF & Networking Track" in the track pull-down menu.

Proposals must be submitted by September 27th, and submitters will be notified
of acceptance by October 2nd. Final slides (as PDF) are due on the first day of
the conference.

We are very much looking forward to a great conference and seeing you all!

