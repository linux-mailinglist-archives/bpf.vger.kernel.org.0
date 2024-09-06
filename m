Return-Path: <bpf+bounces-39177-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF9ED96FDC9
	for <lists+bpf@lfdr.de>; Sat,  7 Sep 2024 00:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63BD91F23BF3
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 22:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A411B15A87F;
	Fri,  6 Sep 2024 22:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="RlKa7HpV"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E0A1B85DB;
	Fri,  6 Sep 2024 22:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725660361; cv=none; b=e+i4kePnkOXLh20crOOZvFSafxCaOS175bytb2Hj9Ixj2OqG3GQI+Bcly4triZq1cnrBspobZL3/+6L/+PXmPAiR3mgE6Zl53nba1402lAXmGchcuVOKNMtHFQ0tHdYCt1TTDpKoIbk1EHoDc61yR3kMtohMzggWcrgtdFUrR2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725660361; c=relaxed/simple;
	bh=qOTggMLVM1XkQ6wuFFFV0cLLjOlArYw3gfTGLBxuntc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O1LsBAvhY3TCL7aMOg0Oz1S4pNPsq1uZi8u2S4Nw6kC+1f9GHUD6LwpvDdoDfvL4eVC9/Jy7IDpPLruAG6HhhW6JZOZhA+GqMkDZ/S5z+Whx6DMVTIs7l4smOhUYb27GGWKoUJNNRIkf0bvPET7RVfn48QRK6U7JII18CLiAYK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=RlKa7HpV; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1725660343;
	bh=qOTggMLVM1XkQ6wuFFFV0cLLjOlArYw3gfTGLBxuntc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RlKa7HpVm1r7fyOvYCrm0I2+xNZDMj74xTW9w0lY/xKpv7MOqcc1NLbbQzih68Gv+
	 p9F0YD2mMa2J6lCfTtXrhJ6hPWIm9N/ZKJqDNVHNYZc6frnNsmvqAlfMD+kCWUevnG
	 AO2dqmibgCoSxLJM2XXAwO09wtpIHXLNQi98AUgSfvzrm/ipXW+sGT8OPQHOXkGqtQ
	 //KgiVC27GR5I/uV05FHJbraqAlDht+p8cztOdT2VphtVOSQjTRfZzGbiEIr0SRYAm
	 Sl3wD+lofv8mjsrvFq1hqPrh6ij7xFPXyACfgM38gNXnpTUcIXJ9t+jp7bW9O/FQmQ
	 T07Ok0OXBPQsg==
Received: from [172.16.0.134] (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4X0qzq2sdpz1Kgr;
	Fri,  6 Sep 2024 18:05:43 -0400 (EDT)
Message-ID: <3ad93892-6400-4865-a72e-f285dba392ce@efficios.com>
Date: Fri, 6 Sep 2024 18:05:26 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] cleanup.h: Introduce DEFINE_INACTIVE_GUARD and
 activate_guard
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
 Greg KH <gregkh@linuxfoundation.org>, Sean Christopherson
 <seanjc@google.com>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Yonghong Song <yhs@fb.com>, "Paul E . McKenney" <paulmck@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Namhyung Kim <namhyung@kernel.org>, bpf@vger.kernel.org,
 Joel Fernandes <joel@joelfernandes.org>, linux-trace-kernel@vger.kernel.org,
 Ingo Molnar <mingo@kernel.org>
References: <20240828143719.828968-1-mathieu.desnoyers@efficios.com>
 <20240828143719.828968-3-mathieu.desnoyers@efficios.com>
 <20240902154334.GH4723@noisy.programming.kicks-ass.net>
 <9de6ca8f-b3f1-4ebc-a5eb-185532e164e7@efficios.com>
 <CAHk-=wgRefOSUy88-rcackyb4Ss3yYjuqS_TJRJwY_p7E3r0SA@mail.gmail.com>
 <60d293cb-3863-41c8-868d-59c7468e270e@efficios.com>
 <CAHk-=wggDLDeTKbhb5hh--x=-DQd69v41137M72m6NOTmbD-cw@mail.gmail.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <CAHk-=wggDLDeTKbhb5hh--x=-DQd69v41137M72m6NOTmbD-cw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-09-03 15:00, Linus Torvalds wrote:
[...]
> 
> IOW - why not get rid of the stupid TRACE_EVENT_FN_MAY_FAULT thing
> entirely, and do this trivial wrapping in the *one* place that wants
> it, instead of making it look like some generic thing with an
> allegedly generic test, when it is anything but generic, and is in
> fact just a single special case for system call.
> 
> Yes, I know. Computer Science classes say that "generic programming is
> good". Those CS classes are garbage. You want to make your code as
> specialized as humanly possible, and *not* make some complicated "this
> handles all cases" code that is complicated and fragile.

Thank you for looking into this. I'm redoing the series based on your
feedback, and it is indeed much cleaner. Let me know if you are
interested to be CC'd on the next version of the series changing
syscall tracepoints.

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


