Return-Path: <bpf+bounces-8261-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D101784481
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 16:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EB761C20AE5
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 14:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75761CA09;
	Tue, 22 Aug 2023 14:39:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8A08F64
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 14:38:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE79AC433C8;
	Tue, 22 Aug 2023 14:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692715139;
	bh=dF4eTB9fjoFe8tM897OnkRcDuHdGOZfJjqtM3RFKizw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=B+5T54p/ouIO7ecN2PZN2saHhTN5D5d3cdHy8lR3vieibv1sLLFFH8S7ZFp2zWknn
	 mDxru/WJXiJIPWgQzMP7/7uM4g4QH3exPMfM6NJ3Y3LVqFZQ8gpwzqr4Mign8IK4gv
	 uIZuQbhmb/f5ULT1K11hSodEGrcRgr+jqwXMknSvSc5q0leTO2orYgJ+2XTye3ed6K
	 /luMKpoH7C0GNc5ZQV9anN+nuOQ0WsV/aQPTcXW2RZrZK14VaWLTbpMcupa4OKs0eI
	 /+QQ8dZ+gOXj2GzopWazokSfsMwNPAVA0cwHEwmSh0IQU5VubR4YpiyKwapftD8RXm
	 7HJzI6c9hNDqg==
Date: Tue, 22 Aug 2023 23:38:55 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, Martin
 KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org, Sven Schnelle
 <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH v5 0/9] tracing: Improbe BTF support on probe events
Message-Id: <20230822233855.94b653a4bf37b2e93739daa6@kernel.org>
In-Reply-To: <20230822100716.2dd867e0@rorschach.local.home>
References: <169137686814.271367.11218568219311636206.stgit@devnote2>
	<20230822000939.81897c0c904934bfb9156a59@kernel.org>
	<20230822100716.2dd867e0@rorschach.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Aug 2023 10:07:16 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 22 Aug 2023 00:09:39 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > Hi Steve,
> > 
> > Can you review this series?
> > I would like to push this to for-next.
> > 
> 
> I skimmed the patches and played a little with it, but as I've just
> started my vacation I will not be able to do a full review before the
> next merge window. But I don't want me to be the cause of you not
> getting it in.
> 
> Feel free to add:
> 
> Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> 
> to the entire series. I'm sure I'll be playing with it after it gets
> in, and we can fix any bugs that come up then.

Thanks! I'll fix a bit about anon_stack thing and push it to probes/for-next.


> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

