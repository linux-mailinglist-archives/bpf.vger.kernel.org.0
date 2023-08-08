Return-Path: <bpf+bounces-7266-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6BAD774A32
	for <lists+bpf@lfdr.de>; Tue,  8 Aug 2023 22:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A6AF281865
	for <lists+bpf@lfdr.de>; Tue,  8 Aug 2023 20:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329A9171C0;
	Tue,  8 Aug 2023 20:21:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FE1168A1;
	Tue,  8 Aug 2023 20:21:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08EB7C433C7;
	Tue,  8 Aug 2023 20:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691526085;
	bh=5eOhZHaNNqxroRtBDR8QfTDMQOAinstiaF9zVD3kTyQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ItCIZsdcel9XJb/oUqQWkpxczMxv0yNlzFPKURjy9kT/aiRl0oZhmOT+BCWwCNZCK
	 FB5DV/NRgWqJiTT0SMsuak8pjmgiShQM6sEdSHtMwr5MERdKj3EEoKn/tq15++NUy5
	 Yrz7SuYcDM+o1gE7ylG4AH5rQEal5AykbjCLPIl+ZKzFJOszap/Wh9DIdiLdd1MedA
	 cxp0NbGY7jGqNQ57P7dQzthamShmbSDrikmrVrSpKv2C5wypmM0doSR2Y2555DIbVz
	 f7MCgDZ4UCxENsctvxOeIQfId1QoMurwSqUBkpNdSIEtXBzzRyPXz9aNuCsk0XtcuU
	 YASDg7nsMa2Dw==
Date: Tue, 8 Aug 2023 13:21:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Manjusaka <me@manjusaka.me>
Cc: ncardwell@google.com, bpf@vger.kernel.org, davem@davemloft.net,
 dsahern@kernel.org, edumazet@google.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, rostedt@goodmis.org
Subject: Re: [PATCH v2] tracepoint: add new `tcp:tcp_ca_event` trace event
Message-ID: <20230808132124.1a17ea69@kernel.org>
In-Reply-To: <20230808055817.3979-1-me@manjusaka.me>
References: <CADVnQyn3UMa3Qx6cC1Rx97xLjQdG0eKsiF7oY9UR=b9vU4R-yA@mail.gmail.com>
	<20230808055817.3979-1-me@manjusaka.me>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  8 Aug 2023 05:58:18 +0000 Manjusaka wrote:
> Signed-off-by: Manjusaka <me@manjusaka.me>

Is that your name? For Developer's Certificate of Origin
https://en.wikipedia.org/wiki/Developer_Certificate_of_Origin
we need something that resembles a real name that'd stand up in court.

