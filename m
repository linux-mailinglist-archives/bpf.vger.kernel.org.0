Return-Path: <bpf+bounces-8262-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6CE7844A5
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 16:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05A4A1C20A9E
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 14:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD65A1CA18;
	Tue, 22 Aug 2023 14:46:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461C71C2BE
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 14:46:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDB3EC433C8;
	Tue, 22 Aug 2023 14:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692715582;
	bh=QU4HT9SfxsSAFUZSD9YpVgGZx2ZNnyPRcH1B1xpNY1U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uwGXrVnJeK0jNwUUVOtx8MDgGx82+boI8zIKr6CRFKju7xXFm56PNlbKriJ2awUeQ
	 whK2lnLpzrFtm2hByGAQpfg4/x8QYHBy/zjhW+WAPj24bXeu3kIArCIoD4lbL8JpCv
	 RF3G90dW/NZJZQ+DfjbnDrMSwcfOJXuFvG0V6TV3GjW1Qv4BSlTCXpULH+SNSQI8Xh
	 xJtdvNtqcsMmPd7xHjTVowwqvIPDg/lRFqBBHIg46LzSUt71jbB50zOjulUb5XdtkJ
	 HWFT81DMxHAZmGCoM84KEGYPBrvh1RhvkgdLkLWUm3eDyaVR7FTtOxut4EH1mQz5/L
	 HOMfBritfmfaA==
Date: Tue, 22 Aug 2023 23:46:18 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, Martin
 KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org, Sven Schnelle
 <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH v5 0/9] tracing: Improbe BTF support on probe events
Message-Id: <20230822234618.0973563d91db6702f118254f@kernel.org>
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

Thank you for your Ack and have a good vacation!
I will continue to test it and fix bugs if there is.

Thanks!

> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

