Return-Path: <bpf+bounces-9782-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E816879D93C
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 20:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A117428174D
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 18:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EFABAD24;
	Tue, 12 Sep 2023 18:55:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF778A930;
	Tue, 12 Sep 2023 18:55:37 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0ADB125;
	Tue, 12 Sep 2023 11:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:From:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=H3/XY/jv4icK4NgBoiigxpPa2AsF3Mqwv5r97vJFS/w=; b=RA/wx0tUm3Vp9scFBNIDz5aBad
	57SO6Le9cPhQkKGGqL0nuOWzThcfhm/53JrwETkK8H/mmRCQ0ZrhvuD7f+ydRQcrPNZH6SWygJGf3
	8STCqlopXi0x3/sePJEWe0YZiQ6luUOP89ZHecuzQQfMdlpdNHFCdtgv2F+XEw9hKwIvMnXiYUpal
	sQDaWolmVS4DnMULSTLViflt+VJXZKjtKQgA5++MOrXm4tfD4ids5GZQVvi41ZmaowzFaCjhGr09r
	9GYGDGgQ4R2OHXpmQT1XdfKzrDs1nWBMvk17ipTFo2pTenXGGcFs4UcPHC3n5bbBM0pyXPbrEQdo0
	34HuguIQ==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qg8Xp-000FQs-8e; Tue, 12 Sep 2023 20:55:29 +0200
Received: from [194.230.161.182] (helo=localhost.localdomain)
	by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qg8Xo-00041T-OO; Tue, 12 Sep 2023 20:55:29 +0200
Subject: LPC 2023 Networking and BPF Track CFP (Reminder)
From: Daniel Borkmann <daniel@iogearbox.net>
To: netdev@vger.kernel.org, bpf@vger.kernel.org
Cc: xdp-newbies@vger.kernel.org, linux-wireless@vger.kernel.org,
 netfilter-devel@vger.kernel.org
References: <1515db2c-f517-76da-8aad-127a67da802f@iogearbox.net>
 <db3003d6-733b-099f-ef73-abce750d66c6@iogearbox.net>
Message-ID: <5c9482c9-1f61-2886-4137-a2e2679b2662@iogearbox.net>
Date: Tue, 12 Sep 2023 20:55:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <db3003d6-733b-099f-ef73-abce750d66c6@iogearbox.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/27029/Tue Sep 12 09:38:51 2023)

This is a reminder for the Call for Proposals (CFP) for the Networking and
BPF track at the 2023 edition of the Linux Plumbers Conference (LPC) which is
taking place in Richmond, VA, United States, on November 13th - 15th, 2023.

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

