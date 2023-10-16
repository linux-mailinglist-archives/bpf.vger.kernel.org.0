Return-Path: <bpf+bounces-12309-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3689C7CAE74
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 18:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 667AE1C20AC4
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 16:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6D730CE7;
	Mon, 16 Oct 2023 16:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rodHOUas"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9C028E24;
	Mon, 16 Oct 2023 16:04:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 746ABC433C8;
	Mon, 16 Oct 2023 16:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697472268;
	bh=YZ4sGcFwTls02ydpSHlFcFPIfFvUcrnKlPq29AuSudo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rodHOUas0uw9FTgwqjcgW/yuKI8So7pJUfKIfnlaONlclGFImbrl0fUd43kc4hZBG
	 tKVfz7o4ago8W9ZFMGjZ4g8Si5fBxeCFass2/qgUwK0PTnVVwm63EporN0xRdmNLAY
	 PWGphe3ZbUqLhd90/aXmtryHcwy2nlBvsjYXRjzKTRV8L/DjDlG3TY8PQPrh7QrMo2
	 9UKpGENJ3QzZpEGHkXjDJb2lOggPtMCHNHJUbuKCUWwXzCcnRQcXcy3JtSZr78yW22
	 6Eh5B431MncsWLT6La1fXnxM+d/4a/NbRYIJrrKNR1yA8L+ygAPV9U7FjYMKeFsc5e
	 RhoAChj/ttAWQ==
Date: Mon, 16 Oct 2023 09:04:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Victor Nogueira <victor@mojatatu.com>
Cc: jhs@mojatatu.com, daniel@iogearbox.net, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, paulb@nvidia.com, bpf@vger.kernel.org,
 mleitner@redhat.com, martin.lau@linux.dev, dcaratti@redhat.com,
 netdev@vger.kernel.org, kernel@mojatatu.com
Subject: Re: [PATCH RFC net-next v2 1/1] net: sched: Disambiguate verdict
 from return code
Message-ID: <20231016090426.26c4baa8@kernel.org>
In-Reply-To: <20231014180921.833820-1-victor@mojatatu.com>
References: <20231014180921.833820-1-victor@mojatatu.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 14 Oct 2023 15:09:21 -0300 Victor Nogueira wrote:
> Currently there is no way to distinguish between an error and a
> classification verdict. Which has caused us a lot of pain with buggy qdiscs
> and syzkaller. This patch does 2 things - one is it disambiguates between
> an error and policy decisions. The reasons are added under the auspices of
> skb drop reason. We add the drop reason as a part of struct tcf_result.
> That way, tcf_classify can set a proper drop reason when it fails,
> and we keep the classification result as the tcf_classify's return value.
> 
> This patch also adds a variety of drop reasons which are more fine grained
> on why a packet was dropped by the TC classification action subsystem.

Looks like this mostly builds on top of Daniel's patches with some
not-described additions like zeroing out res and cleaning up ifdefs.
Let me apply Daniel's patches and you can refine the return codes
on top.

