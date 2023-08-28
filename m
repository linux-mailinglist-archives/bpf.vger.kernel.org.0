Return-Path: <bpf+bounces-8866-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F16AD78B8A5
	for <lists+bpf@lfdr.de>; Mon, 28 Aug 2023 21:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CE071C209A2
	for <lists+bpf@lfdr.de>; Mon, 28 Aug 2023 19:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5561426A;
	Mon, 28 Aug 2023 19:46:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA0A29AB;
	Mon, 28 Aug 2023 19:45:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1C5BC433C8;
	Mon, 28 Aug 2023 19:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693251959;
	bh=yhDfpHHMTwoKf6lQHxj/LI3JfvoIJGkL3VYzwzQSSPo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ntOoDqAO4HSTdUm/9O+IxWZMHgoAovKePv+l/8lN/W/C43VzX+fklx87Jnc/Ky7/f
	 eVMNzplEf+Lo2ztDOvYdjJPp/pmyrbENd81do8XnQ6WK6VOPexIDW95Tccb317hl8q
	 LGzwXdISp5hQIIg0+LEqFW44L9eOunA5oYo4Gq80VlpMHzHlDNME/HiVZbrAxgLMz9
	 xsRgwJ9gmqq5Dfh+nvpCcYH0wbWl3L3py4QKE1o3c5TayOGg9s7B6MxTaSWFz5a0g/
	 WcciuDb3toaDbjKQQfEtSWrv6E9/MCUgmnMn25Yao6O4AW87OdWTAmDNxdD9g9QNNC
	 RxZUL8ri1U5vw==
Date: Mon, 28 Aug 2023 12:45:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Zheao Li <me@manjusaka.me>
Cc: edumazet@google.com, mhiramat@kernel.org, rostedt@goodmis.org,
 davem@davemloft.net, dsahern@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v4] tracepoint: add new `tcp:tcp_ca_event` trace event
Message-ID: <20230828124557.0cc70e58@kernel.org>
In-Reply-To: <20230825133246.344364-1-me@manjusaka.me>
References: <20230825133246.344364-1-me@manjusaka.me>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Aug 2023 13:32:47 +0000 Zheao Li wrote:
> This the 4th version of the patch, the previous discusstion is here
> 
> https://lore.kernel.org/linux-trace-kernel/20230807183308.9015-1-me@manjusaka.me/
> 
> In this version of the code, here's some different:
> 
> 1. The event name has been changed from `tcp_ca_event_set` to
> `tcp_ca_event`
> 
> 2. Output the current protocol family in TP_printk
> 
> 3. Show the ca_event symbol instead of the original number
> 
> But the `./scripts/checkpatch.pl` has been failed to check this patch,
> because we sill have some code error in ./scripts/checkpatch.pl(in
> another world, the test would be failed when we use the 
> scripts/checkpatch.pl to check the events/tcp.h
> 
> Feel free to ask me if you have have any issues and ideas.

## Form letter - net-next-closed

The merge window for v6.6 has begun and therefore net-next is closed
for new drivers, features, code refactoring and optimizations.
We are currently accepting bug fixes only.

Please repost when net-next reopens after Sept 11th.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer


