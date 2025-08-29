Return-Path: <bpf+bounces-66993-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4821B3C055
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 18:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D442A005CF
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 16:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E54A3043B7;
	Fri, 29 Aug 2025 16:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hkOBmgmu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB8D35961
	for <bpf@vger.kernel.org>; Fri, 29 Aug 2025 16:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756483700; cv=none; b=teXC8Rcwk406FqdNl12KJJu3+Oa2JY/xV1g6nMrVjVibw2fz33gWF/OFmHPxUKYeyEAZ4pURRcKWUYAZjRxu4i9jq/5TYCF6Hzfi/1i2zHwhkChb94bHQZYIPQoybI1GwOKk2nKbn/uRxoXXLtWNbBin2VrrjLwL98bD2dbiuks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756483700; c=relaxed/simple;
	bh=GGju3T7I+qI0JvmY68eODhYLvUvdUW9PaGUnZEXvJUE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hcZA9MeY4Hb7ewsBVwG/I90fxT2tqY/iKFROdKIiISEUmWeHJ3u/PtTxSdz0sCbeHzqhcKe/UWnSjqHbKhJXEpByVF4Z+xo6Yb4qNhwiCx+DPBDfLP57+nXrBSlCj+R1dIrs6W3n0bffRTznN2gIEx3mvLfPoJMbNtJk1trgjSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=hkOBmgmu; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-afcb78f5df4so388759066b.1
        for <bpf@vger.kernel.org>; Fri, 29 Aug 2025 09:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1756483695; x=1757088495; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TadHi9XEzabupVoGJRB+7wCRy98sUdfJOAZ174vFHr4=;
        b=hkOBmgmu1gSuWvccznJtMoD3J7mNQOhXeNb46IZhe7esBQr9z2T2qCgN9ZS46UprtV
         XLHwy8ZKUjPYNA//5wV6Sq9aFco+am9qkQByReoaeJXOiI6Zh6Czfb1wGBC5mwsxuxRZ
         Kr56CW5MM1YmmpOtpjTohvkjH9KQ6lHsj2YP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756483695; x=1757088495;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TadHi9XEzabupVoGJRB+7wCRy98sUdfJOAZ174vFHr4=;
        b=kbKmk6I0JmUcTgziG1cF8KK8t4C80ZiiMFXZ+IPM+ke37GIYBKPBN/F8p5hNuYunQd
         rkfBfXhKtareGvQG0eBlOQsmAbXfMfX6pn1W+be4xY3Np0naO7gjLaUmH8ZwD02FOLbD
         YPPfOzbL1ZCM8n1d7F789fjOiJaULI95ENSiaARJXISo65OEXGVvGvGq5jrVV9fguruM
         T0QoARMDdlfhBnU7IhuE/G3YI2qyI5YjdDSrQe4moboraT5NzrPlOLZL7x3d0D6+c6GX
         iv4xEY1zIeKhRoN0XR0WWQGFsOiioLRXx4SkbIsr0Ws+AQHW689cZo7Jq6S6d38mBGNR
         3Rvg==
X-Forwarded-Encrypted: i=1; AJvYcCV8+RoSXdLALq9DIZp0Ul6lq3p2DMJr83KbUU5LmuDIiknhUVzBImu56clM4z/oefQXBSo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmsBMq+/+vWgBONZo1JMzbuAWHWwkRmiSLrbdwTDx04QWbGUox
	RzBMO+8TUCt2I6I8+zWBtu8Kgqk9yEAXwDFM20+ONM4k9+YCD+24j5fkC0fFMMiEfDUrDqewxH8
	tKI1nCASVyA==
X-Gm-Gg: ASbGncv+sjrHJ7YlXKzMNoEirt9RaU1aGGrkYI7GSrUPXPr2CYnOSAzpWqq2pBvm1hX
	sa3SFbYQ5BfAV2VE0h4lcZc55zhcd9NtFltjS7IkbSZdNseFW+1faixZMY8jkK+RiADCTbAoMTP
	cMMe+r/riO/AoY61o5G0MESQuXlIai7IhNaBLv3hVDqGAL/jy+FXL6Qieyxxpi6BhI4JL3K+Dmn
	iRE2MNkXZre18JTOxy3GSnYlXunoAEUWzzxBP8Pxw3XO9KKP+n7EybLuQmB96ZnkEY/Jx09pP2Y
	Egb+89I1hFJcsA33XK4KrPYMtNXDVNox47erlUpJ/j/xeod+CSstcL9ba6/QwhsYm90YJI6BT+d
	AzSERLTzcUZGuvltaAtgpocKwvhVxAtt5qudYT56D1ncF4cDXLwQtBF2uaoH/MANeZk32iN+Pie
	GJLWk3acg=
X-Google-Smtp-Source: AGHT+IG/gzhFL2d8645HO78lylz7xoWw5FtLGiU0euCrLQyOl97Ha88qzSBgFPFEm0+zHVBOBaRThw==
X-Received: by 2002:a17:907:7eaa:b0:afe:ca13:a1e1 with SMTP id a640c23a62f3a-afeca13a8abmr929944466b.0.1756483695277;
        Fri, 29 Aug 2025 09:08:15 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afefcc1c52fsm231069266b.73.2025.08.29.09.08.14
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 09:08:15 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-afeba8e759eso346637366b.3
        for <bpf@vger.kernel.org>; Fri, 29 Aug 2025 09:08:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW3MY7Y+Tpj0Lh8TQ6AkHs1tVJfjrMu1xh37ixkMlQw59zxxmM0h4p0tSrsyqv0d4cZHuo=@vger.kernel.org
X-Received: by 2002:a17:907:dac:b0:af9:8064:21df with SMTP id
 a640c23a62f3a-afe29622961mr2710655466b.53.1756483694425; Fri, 29 Aug 2025
 09:08:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828180300.591225320@kernel.org> <20250828180357.223298134@kernel.org>
 <CAHk-=wi0EnrBacWYJoUesS0LXUprbLmSDY3ywDfGW94fuBDVJw@mail.gmail.com>
 <D7C36F69-23D6-4AD5-AED1-028119EAEE3F@gmail.com> <CAHk-=wiBUdyV9UdNYEeEP-1Nx3VUHxUb0FQUYSfxN1LZTuGVyg@mail.gmail.com>
 <20250828161718.77cb6e61@batman.local.home> <CAHk-=wiujYBqcZGyBgLOT+OWdY3cz7EhbZE0GidhJmLNd9VPOQ@mail.gmail.com>
 <20250828164819.51e300ec@batman.local.home> <CAHk-=wjRC0sRZio4TkqP8_S+Fr8LUypVucPDnmERrHVjWOABXw@mail.gmail.com>
 <20250828171748.07681a63@batman.local.home> <CAHk-=wh0LjoJmRPHF41eQ1ZRf085urz+rvQQ-rwp8dLQCdqohw@mail.gmail.com>
 <20250829110639.1cfc5dcc@gandalf.local.home> <CAHk-=wjeT3RKCTMDCcZzXznuvG2qf0fpKbHKCZuoPzxFYxVcQw@mail.gmail.com>
In-Reply-To: <CAHk-=wjeT3RKCTMDCcZzXznuvG2qf0fpKbHKCZuoPzxFYxVcQw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 29 Aug 2025 09:07:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjCOWCzXG7Z=wkbLYOOcqFbuZTXSdX2yqCCWWOvanugUg@mail.gmail.com>
X-Gm-Features: Ac12FXxmFqdib0IcSRzLnio3atIA7a6LSMhw2mK1t4gBHn8rvbJ5NNQPj8I4ad4
Message-ID: <CAHk-=wjCOWCzXG7Z=wkbLYOOcqFbuZTXSdX2yqCCWWOvanugUg@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] tracing: Show inode and device major:minor in
 deferred user space stacktrace
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Steven Rostedt <rostedt@kernel.org>, Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
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

On Fri, 29 Aug 2025 at 08:47, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Anyway, the way to fix this is to not care about lifetimes at all:
> just treat the hash as the random number it is, and just accept the
> fact that the number gets actively reused and has no meaning.

Side note: the actual re-use of various pointers and/or inode numbers
is going to be very very random.

Classic old filesystems that live by inode numbers will use
'iget5_locked()' and will basically have the same 'struct inode *'
pointer too when they re-use an inode number.

And they likely also have a very simplistic inode allocation model and
a unlink followed by a file creation probably *will* re-use that same
inode number. So you can probably see 'struct inode *' get reused
quite quickly and reliably for entirely unrelated files just based on
file deletion/creation patterns.

The dentry pointer will typically stick around rather aggressively,
and will likely remain the same when you delete a file and create
another one with the same name, and the mnt pointer will stick around
too, so the contents of 'struct path' will be the exact same for two
completely different files across a delete/create event.

So hashing the path is very likely to stay the same as long as the
actual path stays the same, but would be fairly insensitive to the
underlying data changing. People might not care, particularly with
executables and libraries that simply don't get switched around much.

And, 'struct file *' will get reused randomly just based on memory
allocation issues, but I wouldn't be surprised if a close/open
sequence would get the same 'struct file *' pointer.

So these will all have various different 'value stays the same, but
the underlying data changed' patterns. I really think that you should
just treat the hash as a very random number, not assign it *any*
meaning at trace collection time, and the more random the better.

And then do all the "figure it out" work in user space when *looking*
at the traces. It might be a bit more work, and involve a bit more
data, but I _think_ it should be very straightforward to just do a
"what was the last mmap that had this hash"

               Linus

