Return-Path: <bpf+bounces-8252-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95888784352
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 16:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50A5E281152
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 14:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27851CA19;
	Tue, 22 Aug 2023 14:07:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235507F
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 14:07:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 644F7C433C7;
	Tue, 22 Aug 2023 14:07:31 +0000 (UTC)
Date: Tue, 22 Aug 2023 10:07:16 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, Martin
 KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org, Sven Schnelle
 <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH v5 0/9] tracing: Improbe BTF support on probe events
Message-ID: <20230822100716.2dd867e0@rorschach.local.home>
In-Reply-To: <20230822000939.81897c0c904934bfb9156a59@kernel.org>
References: <169137686814.271367.11218568219311636206.stgit@devnote2>
	<20230822000939.81897c0c904934bfb9156a59@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Aug 2023 00:09:39 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> Hi Steve,
> 
> Can you review this series?
> I would like to push this to for-next.
> 

I skimmed the patches and played a little with it, but as I've just
started my vacation I will not be able to do a full review before the
next merge window. But I don't want me to be the cause of you not
getting it in.

Feel free to add:

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

to the entire series. I'm sure I'll be playing with it after it gets
in, and we can fix any bugs that come up then.

-- Steve

