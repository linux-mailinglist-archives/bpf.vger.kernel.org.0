Return-Path: <bpf+bounces-66374-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE334B331A2
	for <lists+bpf@lfdr.de>; Sun, 24 Aug 2025 19:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96263179111
	for <lists+bpf@lfdr.de>; Sun, 24 Aug 2025 17:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24DD1DB356;
	Sun, 24 Aug 2025 17:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rOiBxVzx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316121DE4CA
	for <bpf@vger.kernel.org>; Sun, 24 Aug 2025 17:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756056751; cv=none; b=h4jtkBiXJgga2DBpkeeyO75vaiqLr9mrhZFr4wYtUR0NgOKkB/4VezIlFVQ+h8n3PIOA9k5X48RQn97E9FqnZC8cLCfkEe7iEIq6tjPzeM6BVqYfLGICv91n5CFTXtpBFx5Z1DYGoP4IrR5+gSN6mnbByCsP0yK89/pRyqaroeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756056751; c=relaxed/simple;
	bh=nYIU4QN9D4tQYp5QjHljhvFLe8j2hcTGgrzyKqfm1m8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cw5p7lebrHRY9fNq3xKKWAdLEhvUZh3BbjzkdXZ2lRRPwtn78NJKFnwzk9HacZBzaSq26J6Oi7w9c8YrxSV1hkDwpanp6z7Cvyb78SKYuUoOdh5+nkpiv8/EbrwFSTEin9QvYNNWWhzjOE3s6ULVu+x2+j/RHAUFliCN8Gb6mrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rOiBxVzx; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-246257e49c8so198625ad.0
        for <bpf@vger.kernel.org>; Sun, 24 Aug 2025 10:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756056748; x=1756661548; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nYIU4QN9D4tQYp5QjHljhvFLe8j2hcTGgrzyKqfm1m8=;
        b=rOiBxVzx8q/3AwMPMcYeVUCULDL2zsxYw/gUQW9WWgWoqrTrkvxvQvA1+wug02Mf0P
         Or4Sf8PQehCiL0yGwH7ZWQ0VU0dIX7iCI3Lst/+LpqqjCnrav9DCcz/kADLqiCurTpi0
         hk4TE/FBG88Ax8EaTYvcGolgtfVS8nQLw6ZPEc4+YtYBFyT9VmmvfIQXKQ3KwnZrYLJo
         UGoIPNCGaT3BaKdyQ9YyojDV+93Z5yhROLpRRQKxGKyL1tW8AFoJUhNyVqjxQo3UkM4Y
         A3EDUAJEIWRoo0bHH861nkxYkOKGTKnPdsIYYCa176ClVAblVpgUkMSEXcBV+2lYWiSh
         0oXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756056748; x=1756661548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nYIU4QN9D4tQYp5QjHljhvFLe8j2hcTGgrzyKqfm1m8=;
        b=WW+Fkhfu9VDOX1d+65pqrHedptcxptA7WKnGdB29EnOkTpJeeSBgvHScQWXobmQR6n
         VKZo/f4XrNgCTgSN4sPyDGrI7b13RQyQM0b/MpaOuCMGVrwoOoSR2bv6yE/R+0ZIjZA3
         /460H+MILn9pTp4e1cTecUEByrnFgpqgdozhOMmtDQ6Ztz8u4sxaBm/yxVUXS5a7H/VI
         z0fB4RoZqkRkRZvh0qEOfRsAi0HnBavF64Wt1m/Ih5c9LRghxjQ1sV2+FZsoLaW7eNk8
         b6orr3jGCjImwW0//Sp71hADaRrhmOALEVcrO/rz7R4D+OjN8ZJzANdU3UY4Ruzv6RjG
         kmGg==
X-Forwarded-Encrypted: i=1; AJvYcCWOAili7GjKQboIO16zTZehVybPuB12o+20rRZBIQVLZ1qHr9m3kS09ytFyIRQjFcMq5io=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV31nXEv9Fc6Zx5uCBblLzD9GDUT6PrLBthKu57HzV//lP//f0
	3Ocr3eNdsFvTYmRVGf1JTetfUdyMczjb5KzHKhJZHrO5+BN9gjzWct51UTmufk85H5Rm35fXiDr
	IZiW4I1Qmb2j0DmKPD1APFP1niQv4914XdHY9NAxa
X-Gm-Gg: ASbGncs3EpTeT1wFR9ucvs8gRX/3Qc9z7HCghdeTnoGteh1dFCHlW9/ap4+JZGMZI5o
	gSqif7U0wWWl9BOY2iYK+MT3KzeXdg/YrPhrMNvMp4H/ioSUA5NbM+nGSxSDI4wDDKLDK0mL0Qu
	rh51vUv8aPN6zXBg1T5nazbxAT5RUG8zfRs8n96I4aElgxdG1EDASPOBPXjInH7xwnm7Ja4rWRF
	xW8M6d6gXrujKI=
X-Google-Smtp-Source: AGHT+IHLEkVxcc5/zzS+IhkSvZ/rK+FL/uVYfrBJH8gIcmuU88UlUdcvI77Q8n5pUVPRR23ZZrEirohrVVtXBJ20PbE=
X-Received: by 2002:a17:902:f543:b0:240:640a:c564 with SMTP id
 d9443c01a7336-2467a32609emr2727045ad.3.1756056747994; Sun, 24 Aug 2025
 10:32:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87ldnacz33.fsf@gentoo.org> <87cy8mcyy4.fsf@gentoo.org>
 <CAP-5=fV+-VZ+SsGL1SJGYMEv-gwkv1AKk_6MZJ4tLBrCXFnMQA@mail.gmail.com> <87zfbpae5l.fsf@gentoo.org>
In-Reply-To: <87zfbpae5l.fsf@gentoo.org>
From: Ian Rogers <irogers@google.com>
Date: Sun, 24 Aug 2025 10:32:16 -0700
X-Gm-Features: Ac12FXwADLm_Yk0rL6SmYI9wtXHwDEj8_chc6rm2r933nrXU_L0WtqSd8GDyxXM
Message-ID: <CAP-5=fWrxRvKRxSrYPyiBMZDCfBbb6142ww+er2_mmtkAaGW9A@mail.gmail.com>
Subject: Re: [PATCH v5 00/19] Support dynamic opening of capstone/llvm remove BUILD_NONDISTRO
To: Sam James <sam@gentoo.org>
Cc: Ingo Molnar <mingo@redhat.com>, acme@kernel.org, adityag@linux.ibm.com, 
	adrian.hunter@intel.com, ak@linux.intel.com, 
	alexander.shishkin@linux.intel.com, amadio@gentoo.org, 
	atrajeev@linux.vnet.ibm.com, bpf@vger.kernel.org, chaitanyas.prakash@arm.com, 
	changbin.du@huawei.com, charlie@rivosinc.com, dvyukov@google.com, 
	james.clark@linaro.org, jolsa@kernel.org, justinstitt@google.com, 
	kan.liang@linux.intel.com, kjain@linux.ibm.com, lihuafei1@huawei.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev, mark.rutland@arm.com, mhiramat@kernel.org, 
	morbo@google.com, namhyung@kernel.org, nathan@kernel.org, 
	nick.desaulniers+lkml@gmail.com, peterz@infradead.org, sesse@google.com, 
	song@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 23, 2025 at 3:04=E2=80=AFPM Sam James <sam@gentoo.org> wrote:
>
> Ian Rogers <irogers@google.com> writes:
>
> > On Fri, Aug 22, 2025 at 11:52=E2=80=AFPM Sam James <sam@gentoo.org> wro=
te:
> >>
> >> > A few months ago, objdump was the only way to get
> >> > source line support [0]. Is that still the case?
> >>
> >> ... or is this perhaps handled by "[PATCH v5 18/19] perf srcline:
> >> Fallback between addr2line implementations", in which case, shouldn't
> >> that really land first so people can try the LLVM impl and use the
> >> binutils one if it fails?
> >
> > So my opinion, BUILD_NON_DISTRO isn't supported and the code behind it
> > should go away. Please don't do anything to the contrary or enable it
> > for your distribution - this was supposed to be implied by the name.
>
> We're principally a source-based distribution, so it's not as much of an
> issue.

Agreed, but I don't think the perf tool should be made to be a source
only distribution :-)

> > The forking and running addr2line gets around the license issue that
> > is GPLv3* but comes with a performance overhead. It also has a
> > maintenance overhead supporting llvm and binutil addr2line, when the
> > addr2line output changes things break, etc. (LLVM has been evolving
> > their output but I'm not aware of it breaking things yet). We should
> > (imo) delete the forking and running addr2line support, it fits the
> > billing of something we can do when capstone and libLLVM support
> > aren't there but the code is a hot mess and we don't do exhaustive
> > testing against the many addr2line flavors, the best case is buyer
> > beware. Capstone is derived from libLLVM, I'm not sure it makes sense
> > having 2 libraries for this stuff. There's libLLVM but what it
> > provides through a C API is a mess requiring the C++ shimming. Tbh, I
> > think most of what these libraries provide we should just get over
> > ourselves and provide in perf itself. For example, does it make sense
> > to be trying to add type annotations to objdump output, to just update
> > objdump or have a disassembler library where we can annotate things as
> > we see fit? Library bindings don't break when text output formats get
> > tweaked. Given we're doing so much dwarf processing, do we need a
> > library for that or should that just be in-house? We can side step
> > most of this mess by starting again in python as is being shown in the
> > textual changes that bring with it stuff like console flame graphs:
> > https://lore.kernel.org/lkml/CAP-5=3DfU=3Dz8kcY4zjezoxSwYf9vczYzHztiMSB=
vJxdwwBPVWv2Q@mail.gmail.com/
> > So I think long term we make the perf tool minimal with minimal
> > dependencies (ie no addr2line, libLLVM, etc.), we work on having nice
> > stuff in the python stuff where we can reuse or build new libraries
> > for addr2line, objdump-ing, etc. Use >1 thread, use asyncio, etc.
>
> Yeah, this absolutely sounds like the right direction indeed. I'm glad
> to hear it.

Well it takes effort and what drags against that is supporting things
that can't be distributed.

> >
> > For where we are now, ie no python stuff, BUILD_NON_DISTRO should go
> > away as nobody is maintaining it and hasn't for 2 years (what happens
> > when libbfd and libiberty change?)
>
> They don't change often, though. The fixes are usually trivial when they
> do arise.

So just taking the feature tests as an example of the burden, we have:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/build/feature/test-disassembler-four-args.c?h=3Dperf-tools-nex=
t
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/build/feature/test-disassembler-init-styled.c?h=3Dperf-tools-n=
ext
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/build/feature/test-libbfd-buildid.c?h=3Dperf-tools-next
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/build/feature/test-libbfd.c?h=3Dperf-tools-next
so it isn't just supporting a small libbfd wrapper, it is maintaining
addr2line, objdump, etc. functionality for all these configurations.
As it doesn't get tested, or tested with these features both true and
false, it is liable to bitrot. However, the biggest issue/drag is in
improving/refactoring the tool and having to make sure these new
things work for a situation that in most distributions really, really
doesn't matter.

> > We should focus on making the best
> > of what we have via libraries/tools that are supported - while not
> > forcing the libraries to be there or making the perf binary massive by
> > dragging in say libLLVM. The patch series pushes in that direction and
> > I commend it to the reader.
> >
> > No, reordering the patches to compare performance of binutils doesn't
> > make sense, just build with and without the patch series if you want
> > to do this, but also don't do this as BUILD_NON_DISTRO should go away.
>
> I was asking purely because of the *functionality loss*, though, not
> performance. In the thread I linked from just a few months ago with Ingo
> Molnar, there was a real issue with llvm or capstone-based disassembly
> not showing source information. I'd hit the same problem. Is that fixed n=
ow?

Can you link to the issue? Capstone and LLVM don't replace objdump, in
perf there is a list of disassemblers and in your ~/.perfconfig and
you can always set LLVM and capstone to be your least preferred if
they lack a feature you need:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/Documentation/perf-config.txt?h=3Dperf-tools-next#n250

> This is my principal concern rather than the LLVM dependency (even if
> I'd love to avoid that, I understand and appreciate the arguments you're
> making above and intent on future direction).

I think adding a missing feature to the LLVM disassembler is forward
progress, like fixing the BPF disassembly for LLVM done in this
series. I need to know more about the issue but it sounds less of a
libbfd thing and more an objdump -S thing.

This patch series was reposted as I carry it in:
https://github.com/googleprodkernel/linux-perf
to avoid the cost of linking in libLLVM/libcapstone in contexts (data
centers) where that functionality isn't used.

Thanks,
Ian

