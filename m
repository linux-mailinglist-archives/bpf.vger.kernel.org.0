Return-Path: <bpf+bounces-8111-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9362B781681
	for <lists+bpf@lfdr.de>; Sat, 19 Aug 2023 03:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C403C1C20C8F
	for <lists+bpf@lfdr.de>; Sat, 19 Aug 2023 01:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77CC809;
	Sat, 19 Aug 2023 01:51:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB7A634;
	Sat, 19 Aug 2023 01:51:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 310B2C433C7;
	Sat, 19 Aug 2023 01:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692409917;
	bh=5CvlsXgaTrAu5WqDJYsFlp67N9uRSI15oDB9762NZNk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tgvXmm3LhmErZLAS8tF1hCy6+SY5CR/b5tHRq8zK98pwCXCxSb/9MB+VoERVMPrho
	 gXA7kmZwvbC5Ua8GiU7DslDBleH+gsx1F7cgWKUEIhXSIPkMLljjtdUch2dNBesqdo
	 e9f9eU1rZtmUaL4jjEz2IuX7pzGcaiT5OG3J/pEvv8Z1A/v5gngm1ZLif3xz7KzN9E
	 7LIUdLx2shM79G7iKjqMtyY8GwcX5hTA54sAL0/LW6Hrc8EvqSwG3Bjs8KM94OrYCN
	 nOq+lMtZc1nvWkQd2VRSQpAOF7u6MGQCdj+kYFYBtFbGNUg4YYqRM8mDuMgneLL6cl
	 IfbiU9iNaYZ0w==
Date: Fri, 18 Aug 2023 18:51:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Zheao Li <me@manjusaka.me>
Cc: edumazet@google.com, bpf@vger.kernel.org, davem@davemloft.net,
 dsahern@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org,
 ncardwell@google.com, netdev@vger.kernel.org, pabeni@redhat.com,
 rostedt@goodmis.org
Subject: Re: [PATCH v3] tracepoint: add new `tcp:tcp_ca_event` trace event
Message-ID: <20230818185156.5bb662db@kernel.org>
In-Reply-To: <20230812201249.62237-1-me@manjusaka.me>
References: <CANn89iKQXhqgOTkSchH6Bz-xH--pAoSyEORBtawqBTvgG+dFig@mail.gmail.com>
	<20230812201249.62237-1-me@manjusaka.me>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 12 Aug 2023 20:12:50 +0000 Zheao Li wrote:
> In normal use case, the tcp_ca_event would be changed in high frequency.
> 
> The developer can monitor the network quality more easier by tracing
> TCP stack with this TP event.
> 
> So I propose to add a `tcp:tcp_ca_event` trace event
> like `tcp:tcp_cong_state_set` to help the people to
> trace the TCP connection status

Ah, I completely missed v3 somehow and we got no ack from Eric so maybe
he missed it, too. Could you please resend not as part of this thread
but as a new thread?

