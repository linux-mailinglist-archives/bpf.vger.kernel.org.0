Return-Path: <bpf+bounces-799-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 678B7706EE8
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 18:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C49CA28122C
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 16:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B482C742;
	Wed, 17 May 2023 16:59:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B19442F
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 16:59:14 +0000 (UTC)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E04E9033
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 09:59:12 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-510b154559fso1764284a12.3
        for <bpf@vger.kernel.org>; Wed, 17 May 2023 09:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684342751; x=1686934751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=90yXXchFd6F6AiWLJ4uGoDYFSlfGCfioZhUcDIY6elc=;
        b=c/2iVfMZS6dvLZARPuZhBxbNimhn7MLA2Bqb34R+ckoPCvId6AaYBPT0W/atO6HptQ
         zGpO5XZRldWtjKNkPVdpk4fvJWwa86Wazz2MbXiXNBKvpZeJFCJVmMrvIWHCpUVF7OUn
         Weebw4yRYuutW02PXeo0MHbLbSUzwhSuiYT/IlLpcKW1K7Ly0slxz48pAuLB3y3NMCo6
         7L7mhyFPvqjI2vE5b3E2ZU0vXzpujsvzmxStTKZ/1gaIzbpfOnLKljY8UA3MyxsLcseX
         cmmywB4ajGaEfKjzuhUSZlSEcqSRJUmvm3yTljOl+641/WmlHau14GeRvZeTA4f64DmB
         I17g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684342751; x=1686934751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=90yXXchFd6F6AiWLJ4uGoDYFSlfGCfioZhUcDIY6elc=;
        b=UKJqINc3LRqotN+f5rYFviDWP+ZZFMhoI9PLg1ZMIeZvUSFITZEe+1LeIh787fLy1n
         DXAxgbETBPbuWuFUZeUwIN0cqAS7j6Bo37ZcafavqTHWyYdGRHIZRnV0P/kIYKmhKMKQ
         DgUXFlfOm8J4zeTHCxQYk6KMqjuYX2xKb+E5U59Tup5gEI27piwF5+cmYAJhoyv4TpMT
         MBWxq9oDDfTKnzERqJbqVwgom0F5Uk/+oDSaQp7YAIbUQ+Z7mrFXemx3W1izOlwW8Z+u
         /2M2avvVOetu2asnCewAaRi+PEeUDuV8m0F/5TBgDKEAocpYBliDBDk82H2aeR+vwu/0
         I42Q==
X-Gm-Message-State: AC+VfDxHow+SL8+Ch+u/67X3foUQZTTXFI8EWJMKY9XV+lbzcxGAoZdf
	o/8AL57fj9FC9eeJwSSjo2V4dXvKxZtRtQSzVmg=
X-Google-Smtp-Source: ACHHUZ6JJea4We0Ai066bzR4xpdeMAxb35kedBUbrAWFDhryK4gXnOqUVaC5VJv7ju8g1sda5VfeU3XauQrTBcjov3A=
X-Received: by 2002:a17:906:974b:b0:957:943e:7416 with SMTP id
 o11-20020a170906974b00b00957943e7416mr43876578ejy.15.1684342750569; Wed, 17
 May 2023 09:59:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230512103354.48374-1-quentin@isovalent.com> <20230512103354.48374-5-quentin@isovalent.com>
 <CAEf4BzZ=wp81zdfTTWefiuq2O28aLiHc5Vq88D4hGeb=qy6zJg@mail.gmail.com> <06d1e47a-8ed2-6714-7d2b-da5deb55b1f2@isovalent.com>
In-Reply-To: <06d1e47a-8ed2-6714-7d2b-da5deb55b1f2@isovalent.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 17 May 2023 09:58:58 -0700
Message-ID: <CAEf4BzY0w5Ur-hXtXarxoHvWMa7iG=ZTi1wwXDJoqLCmKw9NkA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/4] bpftool: use a local bpf_perf_event_value to
 fix accessing its fields
To: Quentin Monnet <quentin@isovalent.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf@vger.kernel.org, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	=?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>, 
	Alexander Lobakin <alobakin@pm.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, May 17, 2023 at 8:02=E2=80=AFAM Quentin Monnet <quentin@isovalent.c=
om> wrote:
>
> 2023-05-16 14:30 UTC-0700 ~ Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > On Fri, May 12, 2023 at 3:34=E2=80=AFAM Quentin Monnet <quentin@isovale=
nt.com> wrote:
> >>
> >> From: Alexander Lobakin <alobakin@pm.me>
> >>
> >> Fix the following error when building bpftool:
> >>
> >>   CLANG   profiler.bpf.o
> >>   CLANG   pid_iter.bpf.o
> >> skeleton/profiler.bpf.c:18:21: error: invalid application of 'sizeof' =
to an incomplete type 'struct bpf_perf_event_value'
> >>         __uint(value_size, sizeof(struct bpf_perf_event_value));
> >>                            ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >> tools/bpf/bpftool/bootstrap/libbpf/include/bpf/bpf_helpers.h:13:39: no=
te: expanded from macro '__uint'
> >> tools/bpf/bpftool/bootstrap/libbpf/include/bpf/bpf_helper_defs.h:7:8: =
note: forward declaration of 'struct bpf_perf_event_value'
> >> struct bpf_perf_event_value;
> >>        ^
> >>
> >> struct bpf_perf_event_value is being used in the kernel only when
> >> CONFIG_BPF_EVENTS is enabled, so it misses a BTF entry then.
> >> Define struct bpf_perf_event_value___local with the
> >> `preserve_access_index` attribute inside the pid_iter BPF prog to
> >> allow compiling on any configs. It is a full mirror of a UAPI
> >> structure, so is compatible both with and w/o CO-RE.
> >> bpf_perf_event_read_value() requires a pointer of the original type,
> >> so a cast is needed.
> >>
> >> Fixes: 47c09d6a9f67 ("bpftool: Introduce "prog profile" command")
> >> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> >> Signed-off-by: Alexander Lobakin <alobakin@pm.me>
> >> Signed-off-by: Quentin Monnet <quentin@isovalent.com>
> >> ---
> >
> > What's the point of using vmlinux.h at all if we redefine every single
> > type? bpf_perf_event_value is part of BPF UAPI, so if we included
> > linux/bpf.h header we'd get it.
>
> I gave a quick try at the UAPI header before posting this patch, but it
> was an Ubuntu box and I got the "asm/types.h not found" error. If I
> remember correctly, one way to fix this is to have the gcc-multilib,
> which I'd rather avoid to add as a dependency; or adding the correct
> include path for x86_64 at least, which I haven't tried for bpftool yet.
>
> >
> > This feels a bit split-brained. We either drop vmlinux.h completely
> > and use UAPI headers + CO-RE-relocatable definitions of internal
> > types, or we make sure that vmlinux.h does work (e.g., by pre-checking
> > in a very small version of it). Both using vmlinux.h and not relying
> > on it having necessary types seems like the worst of both worlds?...
>
> Yeah I do feel like I'm missing something in this set and the approach
> is not optimal. What do you mean exactly by "pre-checking in a very
> small version of it"? Checking for the availability of a few types and
> exit early from the functions if they're missing, because we're assuming
> we won't have support for the feature?

So I was thinking that we'll keep relying on vmlinux BTF and proper
Kconfig for bpftool build inside kernel repo, no changes there. But
then we can use `bpftool gen min_core_btf` on resulting .bpf.o files
to dump only types that are actually used/referenced by bpftool's BPF
object files, and then we can generate vmlinux.h from that minimized
BTF.

I haven't tried it, and I'm sure there will be some hiccups along the
way, but that was the idea.

>
> > Quentin, can you see if you can come up with some simple way to use
> > vmlinux.h if building from inside kernel repo, but using a minimized
> > vmlinux.h generated using `bpftool gen min_core_btf` when building
> > from Github mirror? Sync script could also generate this minimal
> > vmlinux.h automatically, presumably?
>
> Sure, I can look into it. But not right now - I'd like to get the
> current issue, and the (unrelated) LLVM feature detection, sorted before
> starting on this.

Sounds good. In general, your patches look good to me, I was hoping we
can avoid unnecessary definitions of UAPI types, but if that doesn't
work out of the box, then I'm fine with it.

>
> Thanks for your feedback!
> Quentin

