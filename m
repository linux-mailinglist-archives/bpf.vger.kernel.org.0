Return-Path: <bpf+bounces-43067-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE20E9AED6D
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 19:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82DBF28760F
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 17:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A34B1FF7C6;
	Thu, 24 Oct 2024 17:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XUloXZPc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008A21EC01B
	for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 17:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729789941; cv=none; b=sKpq6Y4IRYy2qBNUl5/ov4Ol8Dgphga3e7G01cVDCVegokYvKheB5UeaWPhJwIskXxZbMlqS2Cv/2pnFdpM0usyh7HhsdQHlc9mbH5nw7QueOqLouZ8FfydXgZly/0h5bKy/ip8hT8hT5ozAe5XcF/DEUZXD/ZB/tlXNuIgFxdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729789941; c=relaxed/simple;
	bh=td7XvtbtWk36PY6SEBFDIlmGfsBqu6OnjWxI3uGWUUg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iFW1DCXK3MUXYki4FbOBSF9/YHodpNyYdO/yNZ0SZIHxMuBLnBvNoWJIxYOpvqvQfgYBUdf80yScI4IDcTaY5Cm9DieR/0HwYXNcEWh4qIANiiRylZPdde8GjLCl9rl4XNL7xV+JUk8W60PQuL7auZSPQ+QdnVFhKZJrj+y73pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XUloXZPc; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20c87b0332cso6755ad.1
        for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 10:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729789938; x=1730394738; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wgWs0BguBzAE0NRNbqC/tl2ov/2m+YFP+64yzNj38Kc=;
        b=XUloXZPcYzmRmrYBkgewRwBRLjoeP6fd/rTJ75glmQ0azCsd2rYYoXlRZjD96KxGuU
         8l+CeHGutI2IBRUiB3E2QAMCz38MLVtFgoBjEMCYtN3D/UEs8Hr4BgjBguBSe+ZyXHVk
         UOQnjzlq2jtPOAJIeksVsSAXfME/9KZd4Fx6ZyGMkxAdzXtXGSJoebSvsviNHpvY1n/i
         9z/fSZ5DHkhBPzoiHohHqhmiusgLlXe/VguF4zJJ8CMPQV+La79jz0a3R7eDZro4qNdn
         dhjlPOpRuVkL+03eY/D/GbHsjd7ayKSZdXAMRB6NrCCr3r/OY1lFrah9s7pe9rJbdbFG
         wUTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729789938; x=1730394738;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wgWs0BguBzAE0NRNbqC/tl2ov/2m+YFP+64yzNj38Kc=;
        b=KAPDvsTb0CEouxTAyvmMn/1Hp9f8mNCacZl44n/Tf7n4sgXu5w0Ha0WmwD1JILeNq4
         Y0remSV8HRV+LW3cyviZdEPPHH/vC8n1hud5SAYfi/1qsmZBIt8S5vTs9KFPlQ06M/ra
         Bk7G3hHEqBidzM9MfAvDZPcbs2Z2Xdx7mij95aVczHpDHl5vW/4psELbwwST3HjXsaAn
         FrEYi/HCR4zHF5vAsb4i92auyQFYe0kAQZsTUh7LceTdWLmCnEIeZ+EEtUVH5NlnJoNt
         zf/hKDYSlDplhmHmP1Du11sRrZkbl2i4TDiPOWAc7j/LLuZS5J/IeJTRFxW5K+EJ8rAs
         mVrg==
X-Forwarded-Encrypted: i=1; AJvYcCXI7k11fH5lA1i2kAi/Mm8KH2+fjBX5sptrMTm3cttYIbxbploz85sVNQ4pi+qJ38dOvp0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMxDcWazXavBs9uNFAPxiRvY6BJFhRu3QGcHWiqg59702jdr6k
	x0n9jTTysmw7WDt6wsEkWPoUDBCPFrFFL2YdUe6vRIm14qGaMY6E6y7aRi8w0PMOywGGwuswMrH
	t9pI5hC3DzGcG20Xzx53Rj129T8LfxfGlasm4
X-Google-Smtp-Source: AGHT+IFMIl/Sx+onw445B5Y/YCXUxn/VoLJH/Lce9OG85rngv9UK5S1mjq3ve8CBuF958Z33LgDkUC3v2NwgrwfdP/U=
X-Received: by 2002:a17:903:2310:b0:200:97b5:dc2b with SMTP id
 d9443c01a7336-20fb7734a13mr2729965ad.15.1729789937868; Thu, 24 Oct 2024
 10:12:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADKFtnTdWX9prHYMe62oNraaNm=Q3WC9wTfdDD35a=CYxaX2Gw@mail.gmail.com>
 <20241023145640.1499722-1-jrife@google.com> <CAADnVQJupBceq2DAeChBvdjSG4zOpYsMP7_o7gREVmVCA0PUYQ@mail.gmail.com>
 <7bcea009-b58c-4a00-b7cd-f2fc06b90a02@efficios.com> <20241023220552.74ca0c3e@rorschach.local.home>
In-Reply-To: <20241023220552.74ca0c3e@rorschach.local.home>
From: Jordan Rife <jrife@google.com>
Date: Thu, 24 Oct 2024 10:12:06 -0700
Message-ID: <CADKFtnREr5=XA5Y2c=LPnZcxaq+udtCqVOXcZtHBsKPqq6PQvA@mail.gmail.com>
Subject: Re: [RFC PATCH] tracing: Fix syscall tracepoint use-after-free
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Joel Fernandes <joel@joelfernandes.org>, LKML <linux-kernel@vger.kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Michael Jeanson <mjeanson@efficios.com>, 
	Namhyung Kim <namhyung@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, 
	syzbot+b390c8062d8387b6272a@syzkaller.appspotmail.com, 
	Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"

> I don't have patches in front of me, so I'm guessing a bit.
> So pls remind me where all these patches are?
> What tree/branch are we talking about?

I tested this in linux-next. Here is the patch series.
Link: https://lore.kernel.org/bpf/20241009010718.2050182-1-mathieu.desnoyers@efficios.com/T/#u

> and in addition all tracepoints (both sleepable and not)
> should deref __data under normal rcu_read_lock() before
> passing that pointer into __bpf_trace_##call.
> Because that's bpf link and prog are rcu protected.

I think this is the crux of the issue.

>  #define __DO_TRACE_CALL(name, args) \
>  do { \
>     struct tracepoint_func *it_func_ptr; \
>     void *__data; \
>     it_func_ptr = \
>       rcu_dereference_raw((&__tracepoint_##name)->funcs); \
>     if (it_func_ptr) { \
>       __data = (it_func_ptr)->data; \
>       static_call(tp_func_##name)(__data, args); \
>     } \
>   } while (0)
> #else

This code now executes under rcu_read_lock_trace for syscall
tracepoints where __data gets dereferenced but call_rcu is used to
free non-sleepable programs/links inside bpf_link_free. Is it viable
to just use rcu_read_lock()/rcu_read_unlock() here to denote an RCU
read-side critical section around where __data is used?

> We're not going to penalize all bpf progs for that.
> This patch is a non-starter.

Fair enough. This could probably be more targeted, using
call_rcu_tasks_trace only for raw tracepoint programs or those
attached to syscall tracepoints instead of doing this chaining for
everything. That is, assuming a change here is even needed at all and
that this issue can't be fixed outside of the BPF stuff. I'm not sure
whether or not that's the case.

-Jordan

