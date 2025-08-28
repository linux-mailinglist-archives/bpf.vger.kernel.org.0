Return-Path: <bpf+bounces-66882-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C91BAB3ABA3
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 22:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E04301C8669F
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 20:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F325285CAC;
	Thu, 28 Aug 2025 20:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+otQ22Z"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4DE278E7E;
	Thu, 28 Aug 2025 20:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756412865; cv=none; b=ZKXyVNPCMegYCWQrXpejnMQqark10AR9VX7hiDI23RRo/9OLrYGlAm0tpBpx3KH/5XR91gADSCKpCTm/wPuy882YGpHfE6CErb9GhPHJETMASW/E0N7HgFTheqtOgU71oEJ/96xYYPPswHlI691v/qWygHwtbqc0Jsptt2Q6q0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756412865; c=relaxed/simple;
	bh=SL90HD+aWfCyOSo7uoqQOUj85rjMTlnkK6iQspvq6sg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=WcnGRfE9GZKaccl+nncIBqNhLDSIF4NPoxBjb+Uhawk1N7lIibh5rRci2AvpO7m9/jqaGXbG0wVU9NLR70960rfCbAhbhJIKL5cz9FDXRDrj5HDW3EC4rOP24WIYV3dba26w2n0a4A9GIgv+8PWec6X8Gk7evaAGRb/fRg8XZQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F+otQ22Z; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45b7c01a8c1so8428205e9.2;
        Thu, 28 Aug 2025 13:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756412862; x=1757017662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OxcSmfLoY9myt913OAmBfbHp0rEGIx+Y4/OgqeeMks4=;
        b=F+otQ22Z7YF+6wIMgEdpxSQW06OOf1dYxYMDcdrmC9Y8w8Virs0FZyaDrJC/TOqyYn
         y9qYGWlBTw87OnuXp6KAKlUB6VO7RDyq/PoXPQwRCxxP8KjsscE0Pj80MP4DgduNNgGO
         D8hpdh3MEjvy75wHX5pODHwGna6cUwNoLN6UrB13saKdN7syz4C2PyludQhatzKclFhx
         Ve+s1QCoyh19X4RPzdRqPXoym+xOax+uwe+LKq+dZBQPH75ahOQvmrJ1FC1+VGqs2NF5
         C97fD7KXWNf+lqNzhvBixnHOZO8px7OMAGUmG0movc5MV5/1Qgtu82LW5RTjG1yibjmD
         b/Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756412862; x=1757017662;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OxcSmfLoY9myt913OAmBfbHp0rEGIx+Y4/OgqeeMks4=;
        b=kNDH7PQsk6i8CwE7Fn7n1F+/SZ/ifg+omKTX0Dm/VzNud/pJrswZJLyD8aEiD0HEDe
         kGYI7OZ2jUOvmLmEwD4iCuWMANDX5TThh2oTwiUqPA57Fjd5nhP3EZphVCqwxghRCOJo
         nGT9M6CfUF7OBn2kSfHDLKkeJYaMxG4iwMuSNpo7stCSTLgpZFt5+mSu0b5BeuwphLCq
         XdRXQcxBLUsmAgJu9Em3SS0enzXqH9lWDgUgToDfu32kr2etYTCtak5StOJ0HUYLl0m8
         8pg9b6PtS21JiIOl5Df9KN0aPYs9GECWwhBy8359vuZBeav6MwjZKbAEyrLyKpseC5BD
         21Mg==
X-Forwarded-Encrypted: i=1; AJvYcCW0mMOqV7YhTL3Mp/SCVrf0QFh0JN7Jdoc9DBMoYv3prcJBN7RnOtXU7vy95zQcBq4BP+c=@vger.kernel.org, AJvYcCX20ze6XwinKYJRew4xBMIPSV1qiLtTWasLhmZjgT6rxGP+B/2PQQF8nb/TJPpD7L1qlJXuXR3YtmdFYtATvHs7xbrM@vger.kernel.org
X-Gm-Message-State: AOJu0YwqIBaD/0JLacsTQCBYqjD/gUKjibJ6kwVGB/JRHxVCvhkpB4pn
	5PVoKD/v/7umvoFaivhTBLTq9FUE2L455w9Z2WkxDlF+vzJX+5O4u2gK
X-Gm-Gg: ASbGncuMHOq1Go5W9ynW65pXJqzoJq1v6/8luSU1e/2Ckewo8B7/IrviIwzdZAhcoCl
	mediDpHbfxSYEYnxivzBAniSrReWCMH+IfMY6Ct9FyMDefAW43FkSXYmVhWmYsY/dladU5h9uzv
	pOItW9oi84QkglTpCq2T/nkliHLrbzQZRwWmwnx86/BELWabfzSnSRJWdXw3xhLkxd531Jqb2r0
	lSB3MkZKZh+QlqtJ6IZnqptyTSoitSkOTbjM6M2Ff3Np61mtYrau6/9jb1HO3jYS/KLqZWf+GhX
	d76MZM91Z5iEVE0nX3mYwKile1cl2wJPchwZeM2UJX4NUxB/P3mK9ePFPC6MD85IFvnkeZ3beJF
	8UTD4rmuDgjom6hIzw16Yv+JPJkRXhbQtLfU4Bn+2FZZLWPp/
X-Google-Smtp-Source: AGHT+IFRtMYAJjY0HlXM/7qOnK4uG8UdCYOkl9LS9Go2q212m9CQyvoUDx8ytkI+GoDKD0tI37aHKQ==
X-Received: by 2002:a05:600c:b95:b0:43d:fa59:af97 with SMTP id 5b1f17b1804b1-45b517d2f5cmr188836185e9.32.1756412862219;
        Thu, 28 Aug 2025 13:27:42 -0700 (PDT)
Received: from ehlo.thunderbird.net ([185.255.128.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf270fc0a8sm581946f8f.7.2025.08.28.13.27.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 13:27:41 -0700 (PDT)
Date: Thu, 28 Aug 2025 17:27:37 -0300
From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
To: Steven Rostedt <rostedt@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
CC: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Andrii Nakryiko <andrii@kernel.org>, Indu Bhagat <indu.bhagat@oracle.com>,
 "Jose E. Marchesi" <jemarch@gnu.org>,
 Beau Belgrave <beaub@linux.microsoft.com>, Jens Remus <jremus@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Florian Weimer <fweimer@redhat.com>, Sam James <sam@gentoo.org>,
 Kees Cook <kees@kernel.org>, Carlos O'Donell <codonell@redhat.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v6_5/6=5D_tracing=3A_Show_inode_and_devi?=
 =?US-ASCII?Q?ce_major=3Aminor_in_deferred_user_space_stacktrace?=
User-Agent: Thunderbird for Android
In-Reply-To: <20250828161718.77cb6e61@batman.local.home>
References: <20250828180300.591225320@kernel.org> <20250828180357.223298134@kernel.org> <CAHk-=wi0EnrBacWYJoUesS0LXUprbLmSDY3ywDfGW94fuBDVJw@mail.gmail.com> <D7C36F69-23D6-4AD5-AED1-028119EAEE3F@gmail.com> <CAHk-=wiBUdyV9UdNYEeEP-1Nx3VUHxUb0FQUYSfxN1LZTuGVyg@mail.gmail.com> <20250828161718.77cb6e61@batman.local.home>
Message-ID: <583E1D73-CED9-4526-A1DE-C65567EA779D@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On August 28, 2025 5:17:18 PM GMT-03:00, Steven Rostedt <rostedt@kernel=2E=
org> wrote:
>On Thu, 28 Aug 2025 12:18:39 -0700
>Linus Torvalds <torvalds@linux-foundation=2Eorg> wrote:
>
>> On Thu, 28 Aug 2025 at 11:58, Arnaldo Carvalho de Melo
>> <arnaldo=2Emelo@gmail=2Ecom> wrote:
>> > >
>> > >Give the damn thing an actual filename or something *useful*, not a
>> > >number that user space can't even necessarily match up to anything=
=2E =20
>> >
>> > A build ID? =20
>>=20
>> I think that's a better thing than the disgusting inode number, yes=2E
>
>I don't care what it is=2E I picked inode/device just because it was the
>only thing I saw available=2E I'm not sure build ID is appropriate either=
=2E
>
>>=20
>> That said, I think they are problematic too, in that I don't think
>> they are universally available, so if you want to trace some
>> executable without build ids - and there are good reasons to do that -
>> you might hate being limited that way=2E
>>=20
>> So I think you'd be much better off with just actual pathnames=2E
>
>As you mentioned below, the reason I avoided path names is that they
>take up too much of the ring buffer, and would be duplicated all over
>the place=2E I've run this for a while, and it only picked up a couple of
>hundred paths while the trace had several thousand stack traces=2E
>
>>=20
>> Are there no trace events for "mmap this path"? Create a good u64 hash
>> from the contents of a 'struct path' (which is just two pointers: the
>> dentry and the mnt) when mmap'ing the file, and then you can just
>> associate the stack trace entry with that hash=2E
>
>I would love to have a hash to use=2E The next patch does the mapping of
>the inode numbers to their path name=2E It can

The path name is a nice to have detail, but a content based hash is what w=
e want, no?

Tracing/profiling has to be about contents of files later used for analysi=
s, and filenames provide no guarantee about that=2E

- Arnaldo=20

 easily be switched over to
>do the same with a hash number=2E
>
>>=20
>> That should be simple and straightforward, and hashing two pointers
>> should be simple and straightforward=2E
>
>Would a hash of these pointers have any collisions? That would be bad=2E
>
>Hmm, I just tried using the pointer to vma->vm_file->f_inode, and that
>gives me a unique number=2E Then I just need to map that back to the path=
 name:
>
>       trace-cmd-1016    [002] =2E=2E=2E1=2E    34=2E675646: inode_cache:=
 inode=3Dffff8881007ed428 dev=3D[254:3] path=3D/usr/lib/x86_64-linux-gnu/li=
bc=2Eso=2E6
>       trace-cmd-1016    [002] =2E=2E=2E1=2E    34=2E675893: inode_cache:=
 inode=3Dffff88811970e648 dev=3D[254:3] path=3D/usr/local/lib64/libtracefs=
=2Eso=2E1=2E8=2E2
>       trace-cmd-1016    [002] =2E=2E=2E1=2E    34=2E675933: inode_cache:=
 inode=3Dffff88811970b8f8 dev=3D[254:3] path=3D/usr/local/lib64/libtraceeve=
nt=2Eso=2E1=2E8=2E4
>       trace-cmd-1016    [002] =2E=2E=2E1=2E    34=2E675981: inode_cache:=
 inode=3Dffff888110b78ba8 dev=3D[254:3] path=3D/usr/lib/x86_64-linux-gnu/li=
bzstd=2Eso=2E1=2E5=2E7
>            bash-1007    [003] =2E=2E=2E1=2E    34=2E677316: inode_cache:=
 inode=3Dffff888103f05d38 dev=3D[254:3] path=3D/usr/bin/bash
>            bash-1007    [003] =2E=2E=2E1=2E    35=2E432951: inode_cache:=
 inode=3Dffff888116be94b8 dev=3D[254:3] path=3D/usr/lib/x86_64-linux-gnu/li=
btinfo=2Eso=2E6=2E5
>            bash-1018    [005] =2E=2E=2E1=2E    36=2E104543: inode_cache:=
 inode=3Dffff8881007e9dc8 dev=3D[254:3] path=3D/usr/lib/x86_64-linux-gnu/ld=
-linux-x86-64=2Eso=2E2
>            bash-1018    [005] =2E=2E=2E1=2E    36=2E110407: inode_cache:=
 inode=3Dffff888110b78298 dev=3D[254:3] path=3D/usr/lib/x86_64-linux-gnu/li=
bz=2Eso=2E1=2E3=2E1
>            bash-1018    [005] =2E=2E=2E1=2E    36=2E110536: inode_cache:=
 inode=3Dffff888103d09dc8 dev=3D[254:3] path=3D/usr/local/bin/trace-cmd
>
>I just swapped out the inode with the above (unsigned long)vma->vm_file->=
f_inode,
>and it appears to be unique=2E
>
>Thus, I could use that as the "hash" value and then the above could be tu=
rned into:
>
>       trace-cmd-1016    [002] =2E=2E=2E1=2E    34=2E675646: inode_cache:=
 hash=3Dffff8881007ed428 path=3D/usr/lib/x86_64-linux-gnu/libc=2Eso=2E6
>       trace-cmd-1016    [002] =2E=2E=2E1=2E    34=2E675893: inode_cache:=
 hash=3Dffff88811970e648 path=3D/usr/local/lib64/libtracefs=2Eso=2E1=2E8=2E=
2
>       trace-cmd-1016    [002] =2E=2E=2E1=2E    34=2E675933: inode_cache:=
 hash=3Dffff88811970b8f8 path=3D/usr/local/lib64/libtraceevent=2Eso=2E1=2E8=
=2E4
>       trace-cmd-1016    [002] =2E=2E=2E1=2E    34=2E675981: inode_cache:=
 hash=3Dffff888110b78ba8 path=3D/usr/lib/x86_64-linux-gnu/libzstd=2Eso=2E1=
=2E5=2E7
>            bash-1007    [003] =2E=2E=2E1=2E    34=2E677316: inode_cache:=
 hash=3Dffff888103f05d38 path=3D/usr/bin/bash
>            bash-1007    [003] =2E=2E=2E1=2E    35=2E432951: inode_cache:=
 hash=3Dffff888116be94b8 path=3D/usr/lib/x86_64-linux-gnu/libtinfo=2Eso=2E6=
=2E5
>            bash-1018    [005] =2E=2E=2E1=2E    36=2E104543: inode_cache:=
 hash=3Dffff8881007e9dc8 path=3D/usr/lib/x86_64-linux-gnu/ld-linux-x86-64=
=2Eso=2E2
>            bash-1018    [005] =2E=2E=2E1=2E    36=2E110407: inode_cache:=
 hash=3Dffff888110b78298 path=3D/usr/lib/x86_64-linux-gnu/libz=2Eso=2E1=2E3=
=2E1
>            bash-1018    [005] =2E=2E=2E1=2E    36=2E110536: inode_cache:=
 hash=3Dffff888103d09dc8 path=3D/usr/local/bin/trace-cmd
>
>This would mean the readers of the userstacktrace_delay need to also
>have this event enabled to do the mappings=2E But that shouldn't be an
>issue=2E
>
>-- Steve
>

- Arnaldo 

