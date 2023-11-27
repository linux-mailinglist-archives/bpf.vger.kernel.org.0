Return-Path: <bpf+bounces-15950-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C687FA7B9
	for <lists+bpf@lfdr.de>; Mon, 27 Nov 2023 18:11:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 224052819EF
	for <lists+bpf@lfdr.de>; Mon, 27 Nov 2023 17:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F9737156;
	Mon, 27 Nov 2023 17:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PcsInHh5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EAAF19BE
	for <bpf@vger.kernel.org>; Mon, 27 Nov 2023 09:11:14 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-a03a9009572so614017866b.3
        for <bpf@vger.kernel.org>; Mon, 27 Nov 2023 09:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1701105073; x=1701709873; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X8veV/N8u0KLOX8kp8+RpeOybN7ghMV50gJ3VwXOlp8=;
        b=PcsInHh5HXkbieFV2FX4t1zPdN1+/iP8d7BWrpr6i3br4LFffPLYqVhO4o81qXs/pt
         557sTkZthTNX+awOWpakw2gLe5Ili83IAPKFflhwykqPf5xDmFiVBt+DgUElyMcXcCUD
         RhA+9WOZd7rMdF1uZkilHuMAXGtIfQ3tTa5bY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701105073; x=1701709873;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X8veV/N8u0KLOX8kp8+RpeOybN7ghMV50gJ3VwXOlp8=;
        b=gAvfPgCBiRgBRudB9GIPm0i34JlH/HKM/f9pbKPfh3F9h/iCa222SIRbAGd9OQ9eXX
         0l6kkMRVjYu9AM/LIidaQs2gXAsWUqM6oLpt8tj7TitrUxBAbAIaNWuglRS8j2aeRHOD
         F/eg3jeIfC3AO51NturHJYPTOAdyEH5VUnJHlNqzy11chkKszhaNPrDbKESutq3o8dsc
         obKYALxYEfMNIR08OEeTCb+FHj+6skfUGYV3FioVuAvCDLk2C4Pef1dt4bIaGlIJ6aR6
         EBwsr3LRHq+ptcDUwlZKcC9kdLuXRE52bxqFlbRD2GIxZZ0g7C5I6BOwrkteA/sAP1d9
         wFdA==
X-Gm-Message-State: AOJu0Yykiuvzj2rzYil4AFyDXQN0xlyvxRozvl/YLjv+i+wTtOo/Fi3K
	sPkUAF40R9JfCjLIyGmLYfks8riFNQ/Z0k3nVADaag==
X-Google-Smtp-Source: AGHT+IHFmJZS9XUQ+T9bhHvaMfmwc2JbaS1cI8rXDLwYhtwWR+rKipIICcwpMh41s6XCGQII6Ubbvg==
X-Received: by 2002:a17:907:1a45:b0:a04:995b:6a96 with SMTP id mf5-20020a1709071a4500b00a04995b6a96mr7240951ejc.26.1701105072819;
        Mon, 27 Nov 2023 09:11:12 -0800 (PST)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id m3-20020a170906160300b00a00b4d9df54sm5852536ejd.5.2023.11.27.09.11.11
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Nov 2023 09:11:11 -0800 (PST)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-54b0c7987easo3638903a12.3
        for <bpf@vger.kernel.org>; Mon, 27 Nov 2023 09:11:11 -0800 (PST)
X-Received: by 2002:a50:d4c5:0:b0:53e:1b:15f5 with SMTP id e5-20020a50d4c5000000b0053e001b15f5mr7964361edj.39.1701105070828;
 Mon, 27 Nov 2023 09:11:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202311201406.2022ca3f-oliver.sang@intel.com> <CAHk-=wjMKONPsXAJ=yJuPBEAx6HdYRkYE8TdYVBvpm3=x_EnCw@mail.gmail.com>
 <CAHk-=wiCJtLbFWNURB34b9a_R_unaH3CiMRXfkR0-iihB_z68A@mail.gmail.com> <20231127-kirschen-dissens-b511900fa85a@brauner>
In-Reply-To: <20231127-kirschen-dissens-b511900fa85a@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 27 Nov 2023 09:10:54 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgwpzgoSYU9Ob+MRyFuHRow4s5J099=DsCo1hGT=bkCtw@mail.gmail.com>
Message-ID: <CAHk-=wgwpzgoSYU9Ob+MRyFuHRow4s5J099=DsCo1hGT=bkCtw@mail.gmail.com>
Subject: Re: [linus:master] [file] 0ede61d858: will-it-scale.per_thread_ops
 -2.9% regression
To: Christian Brauner <brauner@kernel.org>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>, linux-doc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, intel-gfx@lists.freedesktop.org, 
	linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev, bpf@vger.kernel.org, 
	ying.huang@intel.com, feng.tang@intel.com, fengwei.yin@intel.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Nov 2023 at 02:27, Christian Brauner <brauner@kernel.org> wrote:
>
> So I've picked up your patch (vfs.misc). It's clever alright so thanks
> for the comments in there otherwise I would've stared at this for far
> too long.

Note that I should probably have commented on one other thing: that
whole "just load from fd[0] is always safe, because the fd[] array
always exists".

IOW, that whole "load and mask" thing only works when you know the
array exists at all.

Doing that "just mask the index" wouldn't be valid if "size = 0" is an
option and might mean that we don't have an array at all (ie if "->fd"
itself could be NULL.

But we never have a completely empty file descriptor array, and
fdp->fd is never NULL.  At a minimum 'max_fds' is NR_OPEN_DEFAULT.

(The whole 'tsk->files' could be NULL, but only for kernel threads or
when exiting, so fget_task() will check for *that*, but it's a
separate thing)

So that's why it's safe to *entirely* remove the whole

                if (unlikely(fd >= fdt->max_fds))

test, and do it *all* with just "mask the index, and mask the resulting load".

Because we can *always* do that load at "fdt->fd[0]", and we want to
check the result for NULL anyway, so the "mask at the end and check
for NULL" is both natural and generates very good code.

Anyway, not a big deal, bit it might be worth noting before somebody
tries the same trick on some other array that *could* be zero-sized
and with a NULL base pointer, and where that 'array[0]' access isn't
necessarily guaranteed to be ok.

> It's a little unpleasant because of the cast-orama going on before we
> check the file pointer but I don't see that it's in any way wrong.

In my cleanup phase - which was a bit messy - I did wonder if I should
have some helper for it, since it shows up in both __fget_files_rcu()
and in files_lookup_fd_raw().

So I *could* have tried to add something like a
"masked_rcu_dereference()" that took the base pointer, the index, and
the mask, and did that whole dance.

Or I could have had just a "mask_pointer()" function, which we do
occasionally do in other places too (ie we hide data in low bits, and
then we mask them away when the pointer is used as a pointer).

But with only two users, it seemed to add more conceptual complexity
than it's worth, and I was not convinced that we'd want to expose that
pattern and have others use it.

So having a helper might clarify things, but it might also encourage
wrong users. I dunno.

I suspect the only real use for this ends up being this very special
"access the fdt->fd[] array using a file descriptor".

Anyway, that's why I largely just did it with comments, and commented
both places - and just kept the cast there in the open.

             Linus

