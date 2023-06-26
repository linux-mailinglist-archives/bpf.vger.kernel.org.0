Return-Path: <bpf+bounces-3492-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E614773ECDE
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 23:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BE371C209CB
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 21:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8720A1548D;
	Mon, 26 Jun 2023 21:27:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBE914A82;
	Mon, 26 Jun 2023 21:27:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57EAFC433C0;
	Mon, 26 Jun 2023 21:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687814856;
	bh=cD+DlgssDHp9bWUfoAqdwHPtpJlWEj+4Ut4kvVblUg0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ljNIZ97KtuHOBzk+gfTMQAonQtKrXqmArEvp6gf6th8U9snAirn5HZDr1pg39P5AM
	 38gQsvUyYJlV3jRaJ6kdS4HMZqqEbbjpqCwKDqWHdOiJQ00c6CDF3KnUyl1a+uCfIT
	 +xjUvT7wagBbCIUxOr1Ysw1TFcb4kRMdstAYOVJmeh1c2aJ1ajmTMXLray5ohrZA1k
	 TGJKSOFKLXOkfZHHSsu2DT8/xHwyfZDfAaRIj4k7jAwNPPrkoK47wsuRy8FgpA5QG0
	 MiMilxWpzVqMxN+muUL8m1ErVMR7jUvIEziUej63OU+jBJM+NfvkJEhv2s1qez5gY8
	 SzPCGc2kupEtQ==
Date: Mon, 26 Jun 2023 14:27:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>, dhowells@redhat.com,
 acme@kernel.org, adrian.hunter@intel.com,
 alexander.shishkin@linux.intel.com, bpf@vger.kernel.org,
 davem@davemloft.net, irogers@google.com, jolsa@kernel.org,
 linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
 linux-perf-users@vger.kernel.org, mark.rutland@arm.com, mingo@redhat.com,
 namhyung@kernel.org, netdev@vger.kernel.org, peterz@infradead.org,
 sfr@canb.auug.org.au
Subject: Re: [PATCH net-next] perf trace: fix MSG_SPLICE_PAGES build error
Message-ID: <20230626142734.0fa4fa68@kernel.org>
In-Reply-To: <20230626090239.899672-1-matthieu.baerts@tessares.net>
References: <2947430.1687765706@warthog.procyon.org.uk>
	<20230626090239.899672-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 Jun 2023 11:02:39 +0200 Matthieu Baerts wrote:
> Our MPTCP CI and Stephen got this error:
> 
>     In file included from builtin-trace.c:907:
>     trace/beauty/msg_flags.c: In function 'syscall_arg__scnprintf_msg_flags':
>     trace/beauty/msg_flags.c:28:21: error: 'MSG_SPLICE_PAGES' undeclared (first use in this function)
>        28 |         if (flags & MSG_##n) {           |                     ^~~~
>     trace/beauty/msg_flags.c:50:9: note: in expansion of macro 'P_MSG_FLAG'
>        50 |         P_MSG_FLAG(SPLICE_PAGES);
>           |         ^~~~~~~~~~
>     trace/beauty/msg_flags.c:28:21: note: each undeclared identifier is reported only once for each function it appears in
>        28 |         if (flags & MSG_##n) {           |                     ^~~~
>     trace/beauty/msg_flags.c:50:9: note: in expansion of macro 'P_MSG_FLAG'
>        50 |         P_MSG_FLAG(SPLICE_PAGES);
>           |         ^~~~~~~~~~
> 
> The fix is similar to what was done with MSG_FASTOPEN: the new macro is
> defined if it is not defined in the system headers.
> 
> Fixes: b848b26c6672 ("net: Kill MSG_SENDPAGE_NOTLAST")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Closes: https://lore.kernel.org/r/20230626112847.2ef3d422@canb.auug.org.au/
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> ---
> 
> Notes:
>     @David: I solved it like that in MPTCP tree. Does it work for you too?
> 
>     I guess tools/perf/trace/beauty/include/linux/socket.h file still needs
>     to be updated, not just to add MSG_SPLICE_PAGES but also other
>     modifications done in this file. Maybe best to sync with Arnaldo because
>     he might do it soon during the coming merge window I guess.
> 
> Cc: David Howells <dhowells@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>

Hi Arnaldo, are you okay with us taking this into the networking tree?
Or do you prefer to sync the header after everything lands in Linus's
tree?

