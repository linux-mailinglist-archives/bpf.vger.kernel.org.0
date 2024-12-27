Return-Path: <bpf+bounces-47650-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C409FCFB3
	for <lists+bpf@lfdr.de>; Fri, 27 Dec 2024 03:58:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A0BA188163B
	for <lists+bpf@lfdr.de>; Fri, 27 Dec 2024 02:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66B73596B;
	Fri, 27 Dec 2024 02:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SvmfUSVp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD3E3594A
	for <bpf@vger.kernel.org>; Fri, 27 Dec 2024 02:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735268328; cv=none; b=hPWMlulIuTgFeJb5ts/vjNi+xrvspT8xzSHi0dMV+mCH7opIyRA4NUF4gjItZtJSJyr36z0wIZ4G8dTd4bwIWrq+z4Fd1pOhVEAhvqsWb5hC7Tgw2ugPSlElL9VB9AB1i1SMirIdi187oyOFFk3VHlC6ExOikuYrzOdL1vp4kdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735268328; c=relaxed/simple;
	bh=FLl3QcbQ6gl5PtwWermYbCj21YqJX5D0JrVgwIktLPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EVxiVefpd05l9GPelYhyVLqQrhXq+JjImQqH6CybpNY2Bf76a5Mva5d5/OZ4+W0T0WczrAjIjPvzSIVoZHXOYYXs8dJ+9OB+VJ2e29hThjbKG634OSy+7ZxrOWYAiFO36f2SMjNvT9x8bZf9jrZhgv+iyvKd37VUkH1IR0IBrZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SvmfUSVp; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5d0ac27b412so9015346a12.1
        for <bpf@vger.kernel.org>; Thu, 26 Dec 2024 18:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1735268324; x=1735873124; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XvIAPNYP54LEnLyIp5Ezwqoks125tVudSg9dAYgT6rM=;
        b=SvmfUSVpXco1B8RWMLqlOpiTROXLnf7ZXF1Nu2LQnaRyMUlnc7wT2MhZDVT8w/rutu
         +ZaG0UH7Fc6YOMmivd0gCTix9qJmd355HMyRMIOXjNQxcLQ4Pb7xLnqbqWaXn08UydJq
         SlyHjmtIWT3NXGXKn+x0t04kTIW4XrOQKb//M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735268324; x=1735873124;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XvIAPNYP54LEnLyIp5Ezwqoks125tVudSg9dAYgT6rM=;
        b=R32a7U6w6N0jgDGJ55uPzmrX3BTC87xGkv37RP4q0AWNu0zlO7VCWercdBLRUdbZL5
         mor7w7vR6i5oRM5NmpurFe+r1gX0ymsOZpa7og9aG/8hsnJoA5ouShSO2CD9utlhWFpr
         keBokKk7NjYCPJwubLYV4S46ORwIrqevjDh+2xLUjjiaIr3id5txczqirYbKQgzf3LvL
         enNIcnUeA2sS60teUL3SWNoJ0Wfg3F0g0KRiPx7V6p5BSxmwhB5vDccT5kz1M+onzvj6
         4UaWQCLcXfvGzY514vR+QDrlKPzfb1pEm0HhKbax0cNV6afCVAvGdLbby49GJy0JHy85
         6ECg==
X-Forwarded-Encrypted: i=1; AJvYcCWPS0/jdGBXCGeq/s5Z8IfJvx/bUQ371OBvMix7ss7u4FhPHQIL6r5MyIc5gkOcLeSgrx4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/KKe0CgiU+P+nzHuTmM0o3182RtB0c6kKw+ftL5e+HVj4K8bb
	Z2zpqhHGVUSQqmXkqB0bt45ePfMHevMgIrYvhCfKXOy4Vv1nqyZ244crTShsKUzh7rrGalqBNcW
	tcLbVhw==
X-Gm-Gg: ASbGnct+zYTWgwyZ1uhyaXem90fVF6lu9w0RDFXe/Figrp29a+bU5SFB68nRtskkHj0
	CxaHJMW5vhjuES+eRrnJVYnwD7FAnksKXkIZhyblYx0RzIdm0wQxGunRZsr1HYGL8AxLYfnmQgE
	T8XcrEKZcXCnYua1mp7ARwnfkRAC6WFFF/Qym6+Lrz0oVFLJVAJT2ckmcwjdJ69GiCS+FC7iNYd
	psGmReva2suriONUOX08WQQlD3hJ0c49WH3I9wvTsT/diZ0jYqmeIBry9bYByi9jSbdkpv2kplu
	O/SqD0C4GqgsXs7Psk/GH7JmwklVg7s=
X-Google-Smtp-Source: AGHT+IE70yUMqUmNfQFWZ6cdmtg8y9LGI7wCZJcRIaxAZ8lGkJfTWjld4nuvacD69PYsp4ZzSclnwA==
X-Received: by 2002:a17:907:1b1e:b0:aae:ec9d:5fdb with SMTP id a640c23a62f3a-aaeec9d6191mr1192081366b.28.1735268324505;
        Thu, 26 Dec 2024 18:58:44 -0800 (PST)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0efe4c49sm1057283966b.128.2024.12.26.18.58.40
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Dec 2024 18:58:41 -0800 (PST)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5d647d5df90so11541095a12.2
        for <bpf@vger.kernel.org>; Thu, 26 Dec 2024 18:58:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWnziRn+Ah66uDWDnI7qDwpbEzCrUFh/CdhX/vywSk/qUzcSkp0Ii7EZzySiDejBbfNvGE=@vger.kernel.org
X-Received: by 2002:a17:907:3e8d:b0:aa5:1a1c:d0a2 with SMTP id
 a640c23a62f3a-aac2d0478bemr2183880666b.34.1735268320564; Thu, 26 Dec 2024
 18:58:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241226164957.5cab9f2d@gandalf.local.home> <CAHk-=wgTFSqiMvbGYqFLQaERoeXR5nK1Y=-L3SN7rB3UtzG0PQ@mail.gmail.com>
 <20241226211935.02d34076@batman.local.home>
In-Reply-To: <20241226211935.02d34076@batman.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 26 Dec 2024 18:58:24 -0800
X-Gmail-Original-Message-ID: <CAHk-=wii_nN1X4O9=nztJy3rexKp9w5Gsp=J5kZ43Hekja+Omg@mail.gmail.com>
Message-ID: <CAHk-=wii_nN1X4O9=nztJy3rexKp9w5Gsp=J5kZ43Hekja+Omg@mail.gmail.com>
Subject: Re: [POC][RFC][PATCH] build: Make weak functions visible in kallsyms
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	linux-kbuild@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>, 
	Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Zheng Yejian <zhengyejian1@huawei.com>, 
	Martin Kelly <martin.kelly@crowdstrike.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Josh Poimboeuf <jpoimboe@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 26 Dec 2024 at 18:19, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> So basically the real solution is to fix kallsyms to know about the end
> of functions. Peter Zijlstra mentioned that before, but it would take a
> bit more work and understanding of kallsyms to fix it properly.

Yeah. The kallsyms code *used* to be pretty simple - really just a
list of symbols and addresses.

But it took up a lot of memory, so back in the day (two decades ago by
now) it started growing some name compression code, and then some
serious speedups for lookup.

See

    https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git/commit/?id=e10392112d315c45f054c22c862e3a7ae27d17d4

for when it went from basically a very simple array of names to be a
lot less obvious with that table lookup name compression (but it had
_some_ name compression even before that).

That said, I think it's really mainly just the name compression that
is a bit obscure and looks odd, and it's only used for the builtin
kernel symbols (module symbols are still just a per-module array of
"const Elf_Sym *").

And you can actually largely ignore the odd name compression - because
the *rest* is fairly straightforward.

For example, the actual offset of the symbol is simply a plain array
still: kallsyms_offsets[]. It's slightly oddly encoded (see
kallsyms_sym_address() if you care), but that's because it's an array
of 32-bit values used to encode kernel symbol offsets that can
obviously be 64-bit.

Encoding the size of the symbols should be trivial: just add another
array: "kallsyms_sizes[]", and it wouldn't even need that odd
encoding.

So I actually think it *should* be fairly straightforward to do for
anybnody who knows the kallsyms code at all.

The main pain-point would be *if* we want to actually expose the sizes
in /proc/kallsyms. That would be a file format change. Which we can't
do, so we'd have to do it as some kind of strange ioctl setting (or
just add a new file under a new name).

But maybe we don't even need that. If all the uses are in-kernel, just
adding the kallsyms_sizes[] (and accessor helper functions) should be
fairly straightforward.

Of course, I say that without having done it. I might be overlooking something.

           Linus

