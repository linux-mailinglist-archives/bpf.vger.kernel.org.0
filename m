Return-Path: <bpf+bounces-7771-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D505177C0E3
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 21:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 112251C20B14
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 19:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8ABD2E8;
	Mon, 14 Aug 2023 19:38:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9905687;
	Mon, 14 Aug 2023 19:37:59 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D7F8BB;
	Mon, 14 Aug 2023 12:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:From:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=H3/XY/jv4icK4NgBoiigxpPa2AsF3Mqwv5r97vJFS/w=; b=pOr8bcG6l/kfke8Nee4BbrwhDN
	A2s7rzPErfg+NVwgfSWisFIPVQH8cUmi9poBS1F1nB4w0UNXGjbNEK6bNA/ENONh546s78g4R1edz
	WAuBCj2wUx0j5lG1e9keu4qCMaxo35Zlae00gOpVVmuNUq5yHF6GbNIAizv/Ly7lH+ud3UzJKq/iE
	9PPEPCWlZ40lnWip20o8IyQj3PlXFdkIZziRyF1CKarFaKT2LOy1L195COrXoJbtVWRluBGdKwI2x
	yX8yOtm+eAo3yEBl/j9XgHpxa8a++yujMymBpgH1ERG+rbzqQZR4Wj7/rfbvbPsUZA4i5FRL1cJ0L
	zm2L6yhw==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qVdNw-000Kkk-B7; Mon, 14 Aug 2023 21:37:52 +0200
Received: from [85.1.206.226] (helo=pc-102.home)
	by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qVdNw-0002wv-35; Mon, 14 Aug 2023 21:37:52 +0200
Subject: LPC 2023 Networking and BPF Track CFP (Reminder)
From: Daniel Borkmann <daniel@iogearbox.net>
To: netdev@vger.kernel.org, bpf@vger.kernel.org
Cc: xdp-newbies@vger.kernel.org, linux-wireless@vger.kernel.org,
 netfilter-devel@vger.kernel.org
References: <1515db2c-f517-76da-8aad-127a67da802f@iogearbox.net>
Message-ID: <db3003d6-733b-099f-ef73-abce750d66c6@iogearbox.net>
Date: Mon, 14 Aug 2023 21:37:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1515db2c-f517-76da-8aad-127a67da802f@iogearbox.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/27000/Mon Aug 14 09:37:02 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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

