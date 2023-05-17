Return-Path: <bpf+bounces-686-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A235E705C9A
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 03:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F9B82812EF
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 01:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C70317E3;
	Wed, 17 May 2023 01:46:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59C717C8
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 01:46:50 +0000 (UTC)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A2A2D73
	for <bpf@vger.kernel.org>; Tue, 16 May 2023 18:46:49 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-969f90d71d4so21017666b.3
        for <bpf@vger.kernel.org>; Tue, 16 May 2023 18:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1684288007; x=1686880007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wQUgUB35pEGeEzoSa+CRldRq4FG5rDCSn4467LnemCE=;
        b=XOVzAj8XiIHw+f06SLNIvJC7d04MHA3DZIJYmFMnEZSFNaCx4nEr+UKjTJn0OhUS52
         r2pbbLAF/e6U513uMvV1yNj3R1Zl0yC2EbzVpvkyp9C20N6hpev+0c+BWDbuCIBevXa/
         Z87y5VbTj1vsYdi502f+bigGqeeVXXVRyK5Ys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684288007; x=1686880007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wQUgUB35pEGeEzoSa+CRldRq4FG5rDCSn4467LnemCE=;
        b=fbc2fJsVuXA6gqiNTlSF8qsIh+GP87d3GCl+6OtauEswtVGGRiCtVSGEQBeIUWBcGz
         HpKhSqCT/a+i/vu7g6blDGwjTeJDltrhicOiLWOUdL80w0TdnTtig2MqugsfZJbGG/xR
         umOWW90i2xU5Gfd2BAUojUbrJMod+y0e5Q+iQlm2bRUW/I7ga3lxBjFLML92IimPZ41D
         ca5VKNbNjNAwhih0jF9JQKLnk8y1Mfp+3TaRrjnk9FvfHMjNQW+KtkLpIW52TOD9isfs
         zuZSs+4iGFK0vFVFBqgcBoZ0uN4LZGYzmmukg0jwlxLshiwBE/oPv/T4YoxN3+E/6kUT
         Lzpw==
X-Gm-Message-State: AC+VfDzWq4axzrPixfxva7iIh3PVkpTgz+bR7wDDTvTlbkNuDy5SCz7O
	LqTP/RfeuqgF4cMB8XJyeUmsfjKGFuOo/J5W6MVcRw==
X-Google-Smtp-Source: ACHHUZ4JbCclISocLl0gMwI/ZYYNlTDplVJ35Vjys5FzoxaKlt+bquOfUPB5teJy0F2cVg4hbYmvxw==
X-Received: by 2002:a17:906:4790:b0:969:acdc:c4df with SMTP id cw16-20020a170906479000b00969acdcc4dfmr31533559ejc.4.1684288007434;
        Tue, 16 May 2023 18:46:47 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id h22-20020a1709070b1600b0094f07545d40sm11621326ejl.220.2023.05.16.18.46.46
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 18:46:46 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-965cc5170bdso21594066b.2
        for <bpf@vger.kernel.org>; Tue, 16 May 2023 18:46:46 -0700 (PDT)
X-Received: by 2002:a17:907:1c9e:b0:96a:9c6:d75a with SMTP id
 nb30-20020a1709071c9e00b0096a09c6d75amr24685640ejc.24.1684288006002; Tue, 16
 May 2023 18:46:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230508163751.841-1-beaub@linux.microsoft.com>
 <CAADnVQLYL-ZaP_2vViaktw0G4UKkmpOK2q4ZXBa+f=M7cC25Rg@mail.gmail.com>
 <20230509130111.62d587f1@rorschach.local.home> <20230509163050.127d5123@rorschach.local.home>
 <20230515165707.hv65ekwp2djkjj5i@MacBook-Pro-8.local> <20230515192407.GA85@W11-BEAU-MD.localdomain>
 <20230517003628.aqqlvmzffj7fzzoj@MacBook-Pro-8.local> <CAHk-=whBKoovtifU2eCeyuBBee-QMcbxdXDLv0mu0k2DgxiaOw@mail.gmail.com>
In-Reply-To: <CAHk-=whBKoovtifU2eCeyuBBee-QMcbxdXDLv0mu0k2DgxiaOw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 16 May 2023 18:46:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj1hh=ZUriY9pVFvD1MjqbRuzHc4yz=S2PCW7u3W0-_BQ@mail.gmail.com>
Message-ID: <CAHk-=wj1hh=ZUriY9pVFvD1MjqbRuzHc4yz=S2PCW7u3W0-_BQ@mail.gmail.com>
Subject: Re: [PATCH] tracing/user_events: Run BPF program if attached
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Beau Belgrave <beaub@linux.microsoft.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	David Vernet <void@manifault.com>, dthaler@microsoft.com, brauner@kernel.org, 
	hch@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, May 16, 2023 at 5:56=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> That code depends on all the usual MM locking, and it does not work at
> all in the same way that "pagefault_disable()" does, for example.

Note that in interrupt context, the page table locking would also
deadlock, so even though it's using spinlocks and that _could_ be
atomic, it really isn't usable in interrupt (much less NMI) context.

And even if you're in process context, but atomic due to other reasons
(ie spinlocks or RCU), while the page table locking would be ok, the
mm locking isn't.

So FOLL_NOFAULT really is about avoiding faulting in any new pages,
and it's kind of like "GFP_NOIO" in that respect: it's meant for
filesystems etc that can not afford to fault, because they may hold
locks, and a page fault could then recurse back into the filesystem
and deadlock.

It's not about atomicity or anything like that.

Similarly, FOLL_NOWAIT is absolutely not about that - it will actually
start to fault things in, it just won't then wait for the IO to
complete (so think "don't wait for IO" rather than any "avoid
locking").

Anyway, the end result is the one I already mentioned: only
"get_user_page[s]_fast_only()" is about being usable in atomic
context, and that only works on the *current* process.

That one really is designed to be kind of like "pagefault_disable()",
except instead of fetching user data, it fetches the "reference" to
the user datat (ie the pointers to the underlying pages).

In fact, the very reason that *one* GUP function works in atomic
context is pretty much the exact same reason that you can try to fault
in user pages under pagefault_disable(): it doesn't actually use any
of the generic VM data structures, and accesses the page tables
directly. Exactly like the hardware does.

So don't even ask for other GUP functionality, much less the "remote"
kind. Not going to happen. If you think you need access to remote
process memory, you had better do it in process context, or you had
better just think again.

               Linus

