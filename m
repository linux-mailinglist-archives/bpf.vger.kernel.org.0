Return-Path: <bpf+bounces-66875-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46524B3AA22
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 20:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CF9617BE25
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 18:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0022773C6;
	Thu, 28 Aug 2025 18:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="W2u4nBP7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CABC277008
	for <bpf@vger.kernel.org>; Thu, 28 Aug 2025 18:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756406398; cv=none; b=W3xT+k6HV1JQ8jPKsVmD8pdZ6JhW0oQtvQTUhqQn0daUfW5BpZKicQffSYiTeJxcdWsz3bsC3ocPZ9l26pifRIIRT9Zi1UznZmbSHX33sNh0YK0F5oLonoJ1LYcGCXdz01e+9LjQ3CKxp8blbfVrGw0IwcbFqibOSuiO4A2al4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756406398; c=relaxed/simple;
	bh=KHlidwqQkhRRqz68j9Qh09NEV+gPpDi3h+EEr17Y4rQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qO0hc2wMVBU6yjsOhHJIxT/2T/dK0nYmdWcuo14R+cXwwYMHciqIxJKNCd42NOHt8D+pd9mV2XPTvH+S9sYTNAZgdTR2bMYIwsnV4GmnBh/1RjXQqLKmWI+Em6LcHp6qWBl5qx0Kbiu5NbfrtGjI3Ojsge+EVhl7yQeAS4++HgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=W2u4nBP7; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-afebe21a1c0so199534866b.1
        for <bpf@vger.kernel.org>; Thu, 28 Aug 2025 11:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1756406394; x=1757011194; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zk4/XHzh8fN7NJt1U1cc1xXgNC+2AfvluqXsOt7pkrs=;
        b=W2u4nBP7hIh6uVKpD0C1cNGY+xMYhIBmzmafM/lfStC2ppooY1cT+Ufe0osk9XEOuj
         jcAPPDZCuOvSyAZTw54b8WXuav/Viwet62zntQiT1Rrxh6IiSu16RiosYr7LtCJdiNk3
         XsoG0KAi4TqddkPoeEciQYuJ8m972C7tg8sl8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756406394; x=1757011194;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zk4/XHzh8fN7NJt1U1cc1xXgNC+2AfvluqXsOt7pkrs=;
        b=nuQARQQdFJRUYNeDnNmXL+FIQe7xfEnZ7K3bPnkTIt3eC4kQj3f0sevMW0WFYiJUYB
         eYpfq7apbT2L+0XijWB4s/3EfoqJReUBSyZBUdAaHSUS0A3G+cozOB9fo05TC5/k7UtJ
         rsoRoEQYc3N2+s7ub+Z2MSFgBiNHdKNCsMqk15HhJDLiUGyM2RdlPKO+Vfnl36QiRAT3
         rka+xkyJdpNmFVNy/Uvkj0wWrVhYd7Ybrb9PkpKrH4paV13IIo/UbfV9B5h1+z9jeoJw
         NYkUW7nMjd0BNTIPSoF6d9SWW0I2wdG6gIaZMgGoflCKCd0dLrO4Hf2DTBrlXHvJ2+gP
         uqWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUd1bQQ7FAssQB1dFQqT3dUKKelAmhJyczFfVLIQZq+R8/SjZLyMRSW7AG6S3VF3DKS/5c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO2WxcOnj8+QL51A42fqKKmpCNU5sab2bxadJ75CyVMYIQCdee
	twgyCd8m56JpyZHqVCjtSonuqTd37z57k7uBhkPz3LVKcV/0l7SKIKEDdUaQbZJSfRBzTQLdfaD
	QUasiAms=
X-Gm-Gg: ASbGncs+SGsDjwatdVXr/5iQhDCxARhAlsX+Yx5f5bG1B6Nwl5Rl3C/pWvqLzLC6arV
	ZrQ6xarlHWqhph27Wo9k8Wdjc9OQST1DefltcQOJTNzNO1l8BsbG06E6a4h0RDM7j+S8AKaRYkR
	wqzpS0Wuvvop+fvp7DPgcj8bfgAQJt2EOR/L1O9ZK136/Uq+PlX1QTixhSMsYARo0hEcQUqUYu2
	8gd3+GeGNUI+6XHJnfQTXkgb3lO4uiCiRHUhaWCEiG/mXGujv8f0UQPjpDBQk1Ub9rc6wvawtQn
	EzVnXJ5V4q61+ikzIxihdh/Htpt3C4GmhOSY1F3iTWweXdHXLsORk4Ktx1798AhOvLXzHF20KSF
	FIvT9sN/FX+UbBOg8jClWiP2f2xl2xtgZcd7VcOQenSLoY1cOtHZ3RRvQULMcKeeRnYa3GfDS
X-Google-Smtp-Source: AGHT+IFXzCC9qHGjBFzugyaFSFHTwg9qHFAzoNRxvdjUEAKdoLMNlztkoUX2gy3xgm4lcNoH/AjV8A==
X-Received: by 2002:a17:907:9450:b0:afe:d5bb:f424 with SMTP id a640c23a62f3a-afed5cb5858mr435466466b.45.1756406394272;
        Thu, 28 Aug 2025 11:39:54 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afefcbd8708sm16445366b.71.2025.08.28.11.39.52
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 11:39:52 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-afcb7ace3baso222353966b.3
        for <bpf@vger.kernel.org>; Thu, 28 Aug 2025 11:39:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXQl843ajUTOiaxaU6GlNY/RoGN/x63uk6ld+Vjw4gZdoU+zNgNRWBePiJrsa0uvsRUUxk=@vger.kernel.org
X-Received: by 2002:a17:907:d8d:b0:afe:a121:c466 with SMTP id
 a640c23a62f3a-afea121c81dmr1115762266b.18.1756406392000; Thu, 28 Aug 2025
 11:39:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828180300.591225320@kernel.org> <20250828180357.223298134@kernel.org>
In-Reply-To: <20250828180357.223298134@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 28 Aug 2025 11:39:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi0EnrBacWYJoUesS0LXUprbLmSDY3ywDfGW94fuBDVJw@mail.gmail.com>
X-Gm-Features: Ac12FXwObny_n6wQ-ugpdD6HjGwdsHVCsiy2fjxZ8DxqXIznImh_eKBzj6tMsaI
Message-ID: <CAHk-=wi0EnrBacWYJoUesS0LXUprbLmSDY3ywDfGW94fuBDVJw@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] tracing: Show inode and device major:minor in
 deferred user space stacktrace
To: Steven Rostedt <rostedt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, 
	Indu Bhagat <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>, 
	Beau Belgrave <beaub@linux.microsoft.com>, Jens Remus <jremus@linux.ibm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Florian Weimer <fweimer@redhat.com>, 
	Sam James <sam@gentoo.org>, Kees Cook <kees@kernel.org>, "Carlos O'Donell" <codonell@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 28 Aug 2025 at 11:05, Steven Rostedt <rostedt@kernel.org> wrote:
>
> The deferred user space stacktrace event already does a lookup of the vma
> for each address in the trace to get the file offset for those addresses,
> it can also report the file itself.

That sounds like a good idea..

But the implementation absolutely sucks:

> Add two more arrays to the user space stacktrace event. One for the inode
> number, and the other to store the device major:minor number. Now the
> output looks like this:

WTF? Why are you back in the 1960's? What's next? The index into the
paper card deck?

Stop using inode numbers and device numbers already. It's the 21st
century. No, cars still don't fly, but dammit, inode numbers were a
great idea back in the days, but they are not acceptable any more.

They *particularly* aren't acceptable when you apparently think that
they are 'unsigned long'.  Yes, that's the internal representation we
use for inode indexing, but for example on nfs the inode is actually
bigger. It's exposed to user space as a u64 through

        stat->ino = nfs_compat_user_ino64(NFS_FILEID(inode));

so the inode that user space sees in 'struct stat' (a) doesn't
actually match inode->i_ino, and (b) isn't even the full file ID that
NFS actually uses.

Let's not let that 60's thinking be any part of a new interface.

Give the damn thing an actual filename or something *useful*, not a
number that user space can't even necessarily match up to anything.

              Linus

