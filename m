Return-Path: <bpf+bounces-7669-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA4377A48F
	for <lists+bpf@lfdr.de>; Sun, 13 Aug 2023 03:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96059280F63
	for <lists+bpf@lfdr.de>; Sun, 13 Aug 2023 01:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA905110F;
	Sun, 13 Aug 2023 01:53:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E08D7E;
	Sun, 13 Aug 2023 01:53:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD7C6C433C7;
	Sun, 13 Aug 2023 01:53:28 +0000 (UTC)
Date: Sat, 12 Aug 2023 21:53:27 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Joe Perches <joe@perches.com>
Cc: Zheao Li <me@manjusaka.me>, edumazet@google.com, bpf@vger.kernel.org,
 davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 mhiramat@kernel.org, ncardwell@google.com, netdev@vger.kernel.org,
 pabeni@redhat.com
Subject: Re: [PATCH v3] tracepoint: add new `tcp:tcp_ca_event` trace event
Message-ID: <20230812215327.1dbd30f3@rorschach.local.home>
In-Reply-To: <6bfa88099fe13b3fd4077bb3a3e55e3ae04c3b5d.camel@perches.com>
References: <CANn89iKQXhqgOTkSchH6Bz-xH--pAoSyEORBtawqBTvgG+dFig@mail.gmail.com>
	<20230812201249.62237-1-me@manjusaka.me>
	<20230812205905.016106c0@rorschach.local.home>
	<20230812210140.117da558@rorschach.local.home>
	<20230812210450.53464a78@rorschach.local.home>
	<6bfa88099fe13b3fd4077bb3a3e55e3ae04c3b5d.camel@perches.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 12 Aug 2023 18:17:17 -0700
Joe Perches <joe@perches.com> wrote:

> > I forgot to say "for TRACE_EVENT() macros". This is not about what
> > checkpatch says about other code.  
> 
> trace has its own code style and checkpatch needs another
> parsing mechanism just for it, including the alignment to
> open parenthesis test.

If you have a template patch to add the parsing mechanism, I'd be happy
to try to fill in the style.

-- Steve

