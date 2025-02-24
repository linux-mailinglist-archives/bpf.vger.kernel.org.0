Return-Path: <bpf+bounces-52291-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB35CA4131C
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 03:01:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 890D1162C6B
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 02:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5901919ABC6;
	Mon, 24 Feb 2025 02:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VHrebsVX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486FED530;
	Mon, 24 Feb 2025 02:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740362448; cv=none; b=erNgNTfkxHYWepf5sRr8Zfmm3mXLyTOMBhA3RMQ8WOomLdxtpxaFo6gGlskzwobieNBGL9oJs9u0u++uu9Hs0kjhverq6LJjwgtQhxKypT4ozfkOKbNd1ZeLgvs8+9Y30CQbWC5Qikc5NJt39MBJmZeDqaKaGiXpfjDRTRAdzlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740362448; c=relaxed/simple;
	bh=4YaY9q0EJkK2mUF5qAs7EEnE6on3MPwGZF1ixcRuqWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lovQNRBia1TtuOHTSUSQznvA9l3xYk1GsHjmUdq86S/67CKd8RXBrIbEkYjzh6qGm0MF20CcE0q67qvxQoNKqTrfkCuRaXvrJfj0fpVeaC8IOFZi3+LTJ/IF4VFTk6t5tEokPnbml727qqWWjw6tK5sFOxYw90fb8l4X5lIv6A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VHrebsVX; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4720fb0229fso38584911cf.0;
        Sun, 23 Feb 2025 18:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740362446; x=1740967246; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yA9nk/wpJFfsEqZszO8XisM4k7QXhq3KJDWfVlGLF7A=;
        b=VHrebsVXQAsWTQI0fEBBew3IOF25ecWSn3ccz5l2Sfk7jc857Mb9IwIqETQj2P4W9f
         EfFn1bCFrpTGCfunXVuKTLb7+f8OnZZpTKltQTUuJ9COGr8sMXMOYUb7aEO8W9RjCj38
         wXeMbVjRSXvBscauwmpdTwKz4+28iUuJ/90BCUat5aqRe319eO+hEU1mFsy38B8oFFVD
         teWBUnFcYim3C5xwgx0xbslhZi3ThZYJ9daqtCMYebdRL9YkFoQSp8CPzRBz4T7Y5FIl
         ot0njs853CxxasY6Dp8evHj+4KT7eXWlr8k0HcLMUtfCOtZnDmL8/j9yPF8+Gt+nvMTa
         aKYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740362446; x=1740967246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yA9nk/wpJFfsEqZszO8XisM4k7QXhq3KJDWfVlGLF7A=;
        b=OHVeS8XDTFYeflap/xWD9XPYWhri7esIUlzmj2off8vudWtLpWb5khQr2lMh0JTxSm
         nHnr/GIWm/w509hYmTsjNuxvwqEstNQgT0cBDRJehogQrLeB8RNiXqmkdLC+HhU/uY20
         fKyE4/hiS3OxkguSQwOypxaA9Oly8edgpywmi/cV3034UPKm0l1nzPogdXtvI6ygFC/i
         +lKtFR8Kvx6ZGWMQofiTRruQNaG92x2DLudrSk42CZql6jOZzkwgW9dkdzSA1sVzCZvq
         lW4t/bIWJLCCL90PWMAGRp9szplFcsujCcquOm2BZo8MmrX94Ll9FNRmTjGjtE2c5R3V
         daAA==
X-Forwarded-Encrypted: i=1; AJvYcCUS2qfoRXdHEnWG6Y72q7w53772AGL0EnUnylYD5qAHbHRpfn6jo61Qige4oWLCwjkrF2Q=@vger.kernel.org, AJvYcCUXYhbRFH2qQNGkwknSC1DOvePrWbhqRm1a5pYdqkRGEgQpSIZ+LjFN7VkpO99zT930bmuRBqcCZ5EzMhUy@vger.kernel.org
X-Gm-Message-State: AOJu0YzykSofuOYPi6E/owrIKm0MGO0pALe7IymvQOmUpMKwlb9mVLgS
	4ujf8WDpIl5qSceVEZZ19q5B69g5v45+tD/W/d34QXOn66dY56zi7dTF69RyjbN2H07OfKLoSlQ
	lZyV4JgQPw05rLFk/j0MX3GSTD5s=
X-Gm-Gg: ASbGncuZBVCNZeOtthvakDTTuib/Uu7z/ZhSEaQtbsToZee0qo3KFPokBiRcg8B4ocw
	vXsDpHbtrxkXpkBS4ctIeDu4Ji2GMWvizw91+kZzczYvJvZeDf52dfbq6gkiQDYZNGXf1h9MAwm
	SupDhRtG05
X-Google-Smtp-Source: AGHT+IFKQj2+DTts1D7vUBYjEIEZ3cXjGE1z2jOqS9FWlPa5R0x+SaBjAsZMVmTBO4G3bFLAokci9BnkMyFnU7hHHTg=
X-Received: by 2002:a05:6214:194c:b0:6e6:5d9a:9171 with SMTP id
 6a1803df08f44-6e6b00fc43bmr179852756d6.23.1740362446063; Sun, 23 Feb 2025
 18:00:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250223062735.3341-1-laoar.shao@gmail.com> <20250223062735.3341-2-laoar.shao@gmail.com>
 <CAADnVQ+zLZKyrNGnGQDThasdS6cvM-FheN5Ttz23pF5ttbGasw@mail.gmail.com>
In-Reply-To: <CAADnVQ+zLZKyrNGnGQDThasdS6cvM-FheN5Ttz23pF5ttbGasw@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Mon, 24 Feb 2025 10:00:10 +0800
X-Gm-Features: AWEUYZkj5sPFEfbqE6phMUV8wjr5S0EKpAU92N1rTgrU3h1cnug49vJP-W20Zqo
Message-ID: <CALOAHbACTQYoJ6bJom4ePkXEhvPcMQbUNZJPSC-2mteGuWhanw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/3] objtool: Copy noreturns.h to include/linux
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 4:12=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sat, Feb 22, 2025 at 10:28=E2=80=AFPM Yafang Shao <laoar.shao@gmail.co=
m> wrote:
> >
> > It will used by bpf to reject attaching fexit prog to functions
> > annotated with __noreturn.
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >  include/linux/noreturns.h               | 52 +++++++++++++++++++++++++
> >  tools/objtool/Documentation/objtool.txt |  3 +-
> >  tools/objtool/sync-check.sh             |  2 +
> >  3 files changed, 56 insertions(+), 1 deletion(-)
> >  create mode 100644 include/linux/noreturns.h
> >
> > diff --git a/include/linux/noreturns.h b/include/linux/noreturns.h
> > new file mode 100644
> > index 000000000000..b2174894f9f7
> > --- /dev/null
> > +++ b/include/linux/noreturns.h
> > @@ -0,0 +1,52 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +
> > +/*
> > + * This is a (sorted!) list of all known __noreturn functions in the k=
ernel.
> > + * It's needed for objtool to properly reverse-engineer the control fl=
ow graph.
> > + *
> > + * Yes, this is unfortunate.  A better solution is in the works.
> > + */
> > +NORETURN(__fortify_panic)
> > +NORETURN(__ia32_sys_exit)
> > +NORETURN(__ia32_sys_exit_group)
> > +NORETURN(__kunit_abort)
> > +NORETURN(__module_put_and_kthread_exit)
> > +NORETURN(__stack_chk_fail)
> > +NORETURN(__tdx_hypercall_failed)
> > +NORETURN(__ubsan_handle_builtin_unreachable)
> > +NORETURN(__x64_sys_exit)
> > +NORETURN(__x64_sys_exit_group)
> > +NORETURN(arch_cpu_idle_dead)
> > +NORETURN(bch2_trans_in_restart_error)
> > +NORETURN(bch2_trans_restart_error)
> > +NORETURN(bch2_trans_unlocked_error)
> > +NORETURN(cpu_bringup_and_idle)
> > +NORETURN(cpu_startup_entry)
> > +NORETURN(do_exit)
> > +NORETURN(do_group_exit)
> > +NORETURN(do_task_dead)
> > +NORETURN(ex_handler_msr_mce)
> > +NORETURN(hlt_play_dead)
> > +NORETURN(hv_ghcb_terminate)
> > +NORETURN(kthread_complete_and_exit)
> > +NORETURN(kthread_exit)
> > +NORETURN(kunit_try_catch_throw)
> > +NORETURN(machine_real_restart)
> > +NORETURN(make_task_dead)
> > +NORETURN(mpt_halt_firmware)
> > +NORETURN(nmi_panic_self_stop)
> > +NORETURN(panic)
> > +NORETURN(panic_smp_self_stop)
> > +NORETURN(rest_init)
> > +NORETURN(rewind_stack_and_make_dead)
> > +NORETURN(rust_begin_unwind)
> > +NORETURN(rust_helper_BUG)
> > +NORETURN(sev_es_terminate)
> > +NORETURN(snp_abort)
> > +NORETURN(start_kernel)
> > +NORETURN(stop_this_cpu)
> > +NORETURN(usercopy_abort)
> > +NORETURN(x86_64_start_kernel)
> > +NORETURN(x86_64_start_reservations)
> > +NORETURN(xen_cpu_bringup_again)
> > +NORETURN(xen_start_kernel)
> > diff --git a/tools/objtool/Documentation/objtool.txt b/tools/objtool/Do=
cumentation/objtool.txt
> > index 7c3ee959b63c..70a878e4dc36 100644
> > --- a/tools/objtool/Documentation/objtool.txt
> > +++ b/tools/objtool/Documentation/objtool.txt
> > @@ -326,7 +326,8 @@ the objtool maintainers.
> >
> >     The call from foo() to bar() doesn't return, but bar() is missing t=
he
> >     __noreturn annotation.  NOTE: In addition to annotating the functio=
n
> > -   with __noreturn, please also add it to tools/objtool/noreturns.h.
> > +   with __noreturn, please also add it to tools/objtool/noreturns.h an=
d
> > +   include/linux/noreturns.h.
> >
> >  4. file.o: warning: objtool: func(): can't find starting instruction
> >     or
> > diff --git a/tools/objtool/sync-check.sh b/tools/objtool/sync-check.sh
> > index 81d120d05442..23b9813cd5e9 100755
> > --- a/tools/objtool/sync-check.sh
> > +++ b/tools/objtool/sync-check.sh
> > @@ -17,6 +17,7 @@ arch/x86/include/asm/emulate_prefix.h
> >  arch/x86/lib/x86-opcode-map.txt
> >  arch/x86/tools/gen-insn-attr-x86.awk
> >  include/linux/static_call_types.h
> > +tools/objtool/noreturns.h
> >  "
> >
> >  SYNC_CHECK_FILES=3D'
> > @@ -24,6 +25,7 @@ arch/x86/include/asm/inat.h
> >  arch/x86/include/asm/insn.h
> >  arch/x86/lib/inat.c
> >  arch/x86/lib/insn.c
> > +include/linux/noreturns.h
>
> The copy looks pointless.
> Since we cannot rely on objtool let's just list all noreturn funcs
> directly in BTF_SET_START(fexit_deny) in a single patch.
> So all changes will be under kernel/bpf directory.

OK
I will send a new version.

--=20
Regards
Yafang

