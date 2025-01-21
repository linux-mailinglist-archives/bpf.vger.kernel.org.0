Return-Path: <bpf+bounces-49407-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37868A18334
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 18:49:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78ADA168976
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 17:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8996D1F55F3;
	Tue, 21 Jan 2025 17:48:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F6D1E9B38;
	Tue, 21 Jan 2025 17:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737481733; cv=none; b=mVjdLnTz0jpjDb328ykOsFNoedvvnmFisgTmG4Z8QhQDRpDJbkcrFlH+SPNF52ZFda/UnYw6uCx7yOmERJGPhBrA6vzi8LKaObezbqe6ngUifs4d2/eZArfXP1RufxGzwqAuQJjBmFmeXZZw5cWZpaw54DfAVs3vVRIvheMmHQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737481733; c=relaxed/simple;
	bh=ztUEr/unB+JeIwDrhsWA/ZFfS2Wgl+f2h9EGKMuuKbU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ds/AqsxyrXo4f/2Iov13XEtVXxn3LjCodEm6Z57+UB/4y5tfe98QwD7ytSqZwV4D1D+V4hn5H5/I3M964DZBH9kNNzgIn1yhdv7SfIWejfJb56twkHcyWDrwSbfg6RcY2XD/jwqYXyhefDzAB1aU/zrGhl9RD/IpHgd+iVEIDyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2403C4CEDF;
	Tue, 21 Jan 2025 17:48:48 +0000 (UTC)
Date: Tue, 21 Jan 2025 12:48:51 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Zheng Yejian <zhengyejian1@huawei.com>
Cc: Martin Kelly <martin.kelly@crowdstrike.com>, "masahiroy@kernel.org"
 <masahiroy@kernel.org>, "ojeda@kernel.org" <ojeda@kernel.org>,
 "jpoimboe@kernel.org" <jpoimboe@kernel.org>, "pasha.tatashin@soleen.com"
 <pasha.tatashin@soleen.com>, "mhiramat@kernel.org" <mhiramat@kernel.org>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "james.clark@arm.com" <james.clark@arm.com>, "mpe@ellerman.id.au"
 <mpe@ellerman.id.au>, "akpm@linux-foundation.org"
 <akpm@linux-foundation.org>, "mingo@redhat.com" <mingo@redhat.com>,
 "nicolas@fjasle.eu" <nicolas@fjasle.eu>, "tglx@linutronix.de"
 <tglx@linutronix.de>, "christophe.leroy@csgroup.eu"
 <christophe.leroy@csgroup.eu>, "nathan@kernel.org" <nathan@kernel.org>,
 "npiggin@gmail.com" <npiggin@gmail.com>, "mark.rutland@arm.com"
 <mark.rutland@arm.com>, "hpa@zytor.com" <hpa@zytor.com>,
 "surenb@google.com" <surenb@google.com>, "peterz@infradead.org"
 <peterz@infradead.org>, "naveen.n.rao@linux.ibm.com"
 <naveen.n.rao@linux.ibm.com>, "kent.overstreet@linux.dev"
 <kent.overstreet@linux.dev>, "bp@alien8.de" <bp@alien8.de>,
 "yeweihua4@huawei.com" <yeweihua4@huawei.com>,
 "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
 "mcgrof@kernel.org" <mcgrof@kernel.org>, Amit Dang
 <amit.dang@crowdstrike.com>, "linux-modules@vger.kernel.org"
 <linux-modules@vger.kernel.org>, "linux-kbuild@vger.kernel.org"
 <linux-kbuild@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH v2 0/5] kallsyms: Emit symbol for holes in text and fix
 weak function issue
Message-ID: <20250121124851.2205a8b2@gandalf.local.home>
In-Reply-To: <7266ee61-3085-74fc-2560-c62fc34c2148@huawei.com>
References: <20240723063258.2240610-1-zhengyejian@huaweicloud.com>
	<44353f4cd4d1cc7170d006031819550b37039dd2.camel@crowdstrike.com>
	<364aaf7c-cdc4-4e57-bb4c-f62e57c23279@csgroup.eu>
	<d25741d8a6f88d5a6c219fb53e8aa0bcc1fea982.camel@crowdstrike.com>
	<1f11e3c4-e8fd-d4ac-23cd-0ab2de9c1799@huaweicloud.com>
	<30ee9989044dad1a7083a85316d77b35f838e622.camel@crowdstrike.com>
	<7266ee61-3085-74fc-2560-c62fc34c2148@huawei.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Sorry for the late reply. Forgot about this as I was focused on other end-of-year issues.

On Sat, 14 Dec 2024 16:37:59 +0800
Zheng Yejian <zhengyejian1@huawei.com> wrote:

> The direct cause of this issue is the wrong fentry being founded by ftrace_location(),
> following the approach of "FTRACE_MCOUNT_MAX_OFFSET", narrowing down the search range
> and re-finding may also solve this problem, demo patch like below (not
> fully tested):
> 
>      diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
>      index 9b17efb1a87d..7d34320ca9d1 100644
>      --- a/kernel/trace/ftrace.c
>      +++ b/kernel/trace/ftrace.c
>      @@ -1678,8 +1678,11 @@ unsigned long ftrace_location(unsigned long ip)
>                              goto out;
>      
>                      /* map sym+0 to __fentry__ */
>      -               if (!offset)
>      +               if (!offset) {
>                              loc = ftrace_location_range(ip, ip + size - 1);
>      +                       while (loc > ip && loc - ip > FTRACE_MCOUNT_MAX_OFFSET)
>      +                               loc = ftrace_location_range(ip, loc - 1);
>      +               }
>              }
> 
> Steve, Peter, what do you think?

Hmm, removing the weak functions from the __mcount_loc location should also
solve this, as the ftrace_location_range() will not return a weak function
if it's not part of the __mcount_loc table.

That is, would this patchset work?

  https://lore.kernel.org/all/20250102232609.529842248@goodmis.org/

-- Steve

