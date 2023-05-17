Return-Path: <bpf+bounces-703-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20964705E5F
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 05:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CEA728137A
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 03:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFAFD2116;
	Wed, 17 May 2023 03:51:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F82C17E0
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 03:51:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EA41C433EF;
	Wed, 17 May 2023 03:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684295511;
	bh=ujQm08tAstsBcSTC4djTVJKYZbnMD4JeakcC0SNda2Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TSkAnW3Tw7IFtikLGLu+GPWBvxuXEM5m65QAoEvCrtsO/iSmOETdJEiAUqaMrleII
	 zeTeMmaEQTm6FpcM/KIk9TO4oKxg96lYeHLh/rTFzJCKCtFjXf8P/ve8+aqQcFw0py
	 ZxJnT7Oyek0HGYBY8ZtQYTSc9qzOPYbYtNts8W2SDG9L0QEeOjsPJDT4KRtBegTYNN
	 IAKH0xnEKfpnt0cSPV5GYah+YvOlSxSSPIY0fYMj2Zs7P7v/pdLWr/zyIvf+reeAGH
	 uJ0yTaME660KgFSlPIjx8QlAJbysaP2KvTzEtkhMRuSYEQxxgZfoOsEuXjtxTJu4iT
	 nu6ZMWm+E+gDA==
Date: Wed, 17 May 2023 12:51:42 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ze Gao <zegao2021@gmail.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexander Gordeev <agordeev@linux.ibm.com>, Alexei Starovoitov
 <ast@kernel.org>, Borislav Petkov <bp@alien8.de>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Heiko Carstens <hca@linux.ibm.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo
 Molnar <mingo@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul
 Walmsley <paul.walmsley@sifive.com>, Sven Schnelle <svens@linux.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Vasily Gorbik <gor@linux.ibm.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, Conor Dooley
 <conor@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Yonghong Song
 <yhs@fb.com>, Ze Gao <zegao@tencent.com>
Subject: Re: [PATCH v2 2/4] fprobe: make fprobe_kprobe_handler recursion
 free
Message-Id: <20230517125142.b5fa0d958ccfa5c309c650af@kernel.org>
In-Reply-To: <20230516232545.4f6c7805@rorschach.local.home>
References: <20230516071830.8190-1-zegao@tencent.com>
	<20230516071830.8190-3-zegao@tencent.com>
	<20230516091820.GB2587705@hirez.programming.kicks-ass.net>
	<CAD8CoPDFp2_+D6nykj6mu_Pr57iN+8jO-kgA_FRrcxD8C7YU+Q@mail.gmail.com>
	<20230517010311.f46db3f78b11cf9d92193527@kernel.org>
	<CAD8CoPAw_nKsm4vUJ_=aSwzLc5zo8D5pY6A7-grXENxpMYz9og@mail.gmail.com>
	<20230517115432.94a65364e53cbd5b40c54e82@kernel.org>
	<CAD8CoPC0BXB2ER_Oaixm5XgMk8TTqKVVF7Po0t4gBPOLhw_xwQ@mail.gmail.com>
	<20230516232545.4f6c7805@rorschach.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 May 2023 23:25:45 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 17 May 2023 11:10:21 +0800
> Ze Gao <zegao2021@gmail.com> wrote:
> 
> > Got it! :)
> > 
> > I will improve the commit message and send v3 ASAP.
> > 
> > BTW, which tree should I rebase those patches onto? Is that the
> > for-next branch of
> > git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git. I saw
> > Jiri had troubles
> > applying those since these works are based on v6.4.0.
> > 
> 
> You can submit against 6.4-rc1. We haven't updated the for-next branch
> yet. Which will be rebased off of one of the 6.4 rc's.

Yeah, I would like to pick it to probes/fixes for 6.4 and stable branches.

Thank you,


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

