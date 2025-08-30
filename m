Return-Path: <bpf+bounces-67051-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 035E8B3C650
	for <lists+bpf@lfdr.de>; Sat, 30 Aug 2025 02:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 520961CC1374
	for <lists+bpf@lfdr.de>; Sat, 30 Aug 2025 00:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08BD845945;
	Sat, 30 Aug 2025 00:36:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725BA1388;
	Sat, 30 Aug 2025 00:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756514174; cv=none; b=c0EjD/A32APWeXwK7yyiYgSoPdobKK3eLZ4JA5bz+X6HR3CR52qTyWXavZnP7UKTcIImI7dYvJoO/QIfn1jJyVn8LDhYSyIh3AxShJx10XZFmAB7yOSqBUneXM11itPrMzY4ork/+BxlzIn+Nja5bhPV4OCRFdODN3fcInaUTIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756514174; c=relaxed/simple;
	bh=qsMti+LWhYucHDA3xzzk7LXoXUO9jYvItet2jyL2qNI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZqY7bCD47aexzr4KwRVPptmzR6//nSZndagbsv2Ri+FA75izKgfnRiNixANZOt3pkuofTucKmJ748pSDcfArGHEoV845bE4wEq8muOwGp/L7DHJ3uemnNxftNWAbmpb4RGkCq4m3v0lFu5DD9ktmDGtc+nVh8hJW5RVemP2N/jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 6A1E21606F0;
	Sat, 30 Aug 2025 00:36:09 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf03.hostedemail.com (Postfix) with ESMTPA id 0A5D56000B;
	Sat, 30 Aug 2025 00:36:03 +0000 (UTC)
Date: Fri, 29 Aug 2025 20:36:27 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, Steven Rostedt
 <rostedt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri
 Olsa <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Andrii Nakryiko <andrii@kernel.org>, Indu Bhagat <indu.bhagat@oracle.com>,
 "Jose E. Marchesi" <jemarch@gnu.org>, Beau Belgrave
 <beaub@linux.microsoft.com>, Jens Remus <jremus@linux.ibm.com>, Andrew
 Morton <akpm@linux-foundation.org>, Florian Weimer <fweimer@redhat.com>,
 Sam James <sam@gentoo.org>, Kees Cook <kees@kernel.org>, "Carlos O'Donell"
 <codonell@redhat.com>
Subject: Re: [PATCH v6 5/6] tracing: Show inode and device major:minor in
 deferred user space stacktrace
Message-ID: <20250829203627.3bbb9c24@gandalf.local.home>
In-Reply-To: <20250829194246.744c760b@gandalf.local.home>
References: <20250828180300.591225320@kernel.org>
	<20250828171748.07681a63@batman.local.home>
	<CAHk-=wh0LjoJmRPHF41eQ1ZRf085urz+rvQQ-rwp8dLQCdqohw@mail.gmail.com>
	<20250829110639.1cfc5dcc@gandalf.local.home>
	<CAHk-=wjeT3RKCTMDCcZzXznuvG2qf0fpKbHKCZuoPzxFYxVcQw@mail.gmail.com>
	<20250829121900.0e79673c@gandalf.local.home>
	<CAHk-=wj6+8vXfBQKoU4=8CSvgSEe1A++1KuQhXRZBHVvgFzzJg@mail.gmail.com>
	<20250829124922.6826cfe6@gandalf.local.home>
	<CAHk-=wid_71e2FQ-kZ-=aGTkBxDjLwtWqcsuNSxrarnU4ewFCg@mail.gmail.com>
	<6B146FF6-B84E-40A2-A4FA-ABD5576BF463@gmail.com>
	<CAHk-=wjgdKtBAAu10W04VTktRcgEMZu+92sf1PW-TV-cfZO3OQ@mail.gmail.com>
	<20250829141142.3ffc8111@gandalf.local.home>
	<CAHk-=wh8QVL4rb_17+6NfxW=AF-HS0WarMmq-nYm42akG0-Gbg@mail.gmail.com>
	<20250829171855.64f2cbfc@gandalf.local.home>
	<CAHk-=wj7rL47QetC+e70y7pgyH4v7Q2vcSZatRsCk+Z6urA3hw@mail.gmail.com>
	<20250829190935.7e014820@gandalf.local.home>
	<20250829194246.744c760b@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: qeeg9p3gxtqwn1yhdotjp5fxoqtn4meg
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 0A5D56000B
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+xcImp8TxVi+CCl2dnC6hREgbekVcnl3c=
X-HE-Tag: 1756514163-476374
X-HE-Meta: U2FsdGVkX19n43wdPBIbkHhrdzMH6DataEPRK47xCyyx1UXXit2BgIP9Tq1W3JoMSrSuGFn1io2mRJDoO18d47VGNrFj3omXyhXloMxMIfcc/q9/QiwewOeQ1aXjc4T2l9U/kIpfL7LFyxVHQBV1LWDeVdTZUGESVVd8rKbliev4HcwhwSDRdIo9oif2LQaZ8R49/uH+9G5EGc94vRPBKjMhy3yrZWExB32gT6jqcNqKoHVVz4TKFrnBAGtqUWDF8VlQpQCGVbVJfru2N3s5ii+gLV2v8oxdl+oHdJylWEaBxrU/JriyRwUswYUpGqWLnKV9nb1mjSkCv0DBBW/M42f3Jevw78+w84AfHcdCCoaqLMnkvETo/0F1MgzcHhJAtAwkhQvGo5HC823tnUsnMfjuXSxF5ACI

On Fri, 29 Aug 2025 19:42:46 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

>    vma = NULL;
>    hash = 0;
>    foreach addr in callchain
>      if (!vma || addr not in range of vma) {
>        vma = vma_lookup(addr);
>        hash = get_hash(vma);
>      }
>      callchain[i] = addr - offset;
>      hash[i] = hash;
> 
> 
> I had that get_hash(vma) have something like:
> 
> 
>   u32 get_hash(vma) {
>      unsigned long ptr = (unsigned long)vma->vm_file;
>      u32 hash;
> 
>      /* Remove alignment */
>      ptr >>= 3;
>      hash = siphash_1u32((u32)ptr, &key);

Oh, this hash isn't that great, as it did appear to have collisions. But I
saw in vsprintf() it has something like:

#ifdef CONFIG_64BIT
	return (u32)(unsigned long)siphash_1u64((u64)ptr, &key);
#else
	return (u32)siphash_1u32((u32)ptr, &key);
#endif

Which for the 64 bit version, it uses all the bits to calculate the hash,
and the resulting bottom 32 is rather a good spread.

> 
>      if (lookup_hash(hash))
>         return hash; // already saved
> 
>      // The above is the most common case and is quick.
>      // Especially compared to vma_lookup() and the hash algorithm
> 
>      /* Slow but only happens when a new vma is discovered */
>      trigger_event_that_maps_hash_to_file_data(hash, vma);
> 
>      /* Doesn't happen again for this hash value */
>      save_hash(hash);

So this basically creates the output of:

       trace-cmd-1034    [003] .....   142.197674: <user stack unwind>
cookie=300000004
 =>  <000000000008f687> : 0x666220af
 =>  <0000000000014560> : 0x88512fee
 =>  <000000000001f94a> : 0x88512fee
 =>  <000000000001fc9e> : 0x88512fee
 =>  <000000000001fcfa> : 0x88512fee
 =>  <000000000000ebae> : 0x88512fee
 =>  <0000000000029ca8> : 0x666220af
       trace-cmd-1034    [003] ...1.   142.198063: file_cache: hash=0x666220af path=/usr/lib/x86_64-linux-gnu/libc.so.6 build_id={0x10bddb6d,0xf5234181,0xc2f72e26,0x1aa4f797,0x6aa19eda}
       trace-cmd-1034    [003] ...1.   142.198093: file_cache: hash=0x88512fee path=/usr/local/bin/trace-cmd build_id={0x3f399e26,0xf9eb2d4d,0x475fa369,0xf5bb7eeb,0x6244ae85}


Where the first instances of the vma with the values of 0x666220af and
0x88512fee get printed, but from then on, they are not. That is, from then
on, the lookup will return true, and no processing will take place.

And periodically, I could clear the hash cache, so that all vmas get
printed again. But this would be rate limited to not cause performance
issues.


-- Steve

