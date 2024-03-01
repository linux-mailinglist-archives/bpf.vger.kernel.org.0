Return-Path: <bpf+bounces-23205-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9117D86EB99
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 23:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22AFD1F21685
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 22:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A7759158;
	Fri,  1 Mar 2024 22:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZzsJdWyB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843AF14295
	for <bpf@vger.kernel.org>; Fri,  1 Mar 2024 22:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709331174; cv=none; b=MeJJOcWEkVRgyL1eWJc6qoerQOpLhr08kHlYgAauTJlRhVh7pH8EzlCgjUeYOJ2i1NveI29vkwSMk10YIwhNhEzc6n4ZznqTwWKXBMIbSICAYZ1wx9Fctym9e4guF6+a8QOi5wTvxryn02rEgZdofCNTb4Nc1qxl2c76ZwcRKls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709331174; c=relaxed/simple;
	bh=22IqT8bI7ObsjvFHT3JNWEowvFmXz7u7zT981SN1QJ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g9J3wlQTwSqz/eD1B7VmRDNG/zCl0aYBy7liHVE2GyY0hPpfSKDMnigQ/qpW1ZO1j70KKSWhUwFTBmosSxD5F06dSmZbkxxHY2/sG+MMEFi2BDVCYrjZQ0h/+dlJpQDCJZNwhTTTWhPgJIyf31B5B3lPADsx0AYzoiZneHpx5PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZzsJdWyB; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-33d754746c3so1329715f8f.1
        for <bpf@vger.kernel.org>; Fri, 01 Mar 2024 14:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709331171; x=1709935971; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DDmqj7usMko0OnVLg2i5TEwtt1k9Y6DYkNPycDPEw0Y=;
        b=ZzsJdWyBim2Zkm7CebYu9U9WougrbTV+Hl4+I/IIPtO6vZa6iJpnmoLOG+1GI4R7nT
         Q5PGhrFdTubZKlhTWZYuqmTZ1QE/rsg0d2n0TvCMl0a5spxfCXrDwCHzpqKy3Gm/4Kc6
         k63RcNrFDLTlVj6842zVjAO+NFT6Cx7h33oBdxushbbWG84vBtwlUgvnS297QcEe+93s
         ebmPm8K990XFAoCUDos9uZPDuYw8ZUmPXxi4BsD8IGh6YZmEuPAQrsWBA4sTEFDHbhRn
         LMkeJctGJHKgE6efgz+P1qbjlmbIoWbNjrUHUnRZ4T7ilYDNyUElE3jiD1o2pw97102P
         P/PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709331171; x=1709935971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DDmqj7usMko0OnVLg2i5TEwtt1k9Y6DYkNPycDPEw0Y=;
        b=I2wtw8fWEP1X3wg4XE0pBrD9quNzj+IoSpjQgKZZfAzG3nn4A5S2NyCa8j1kBw99LL
         9z+YyXUiLtIEclfxgabPxH1ImiWNPsjSFKzv4haow5zexY8apTNOcbN5IYD4maWHM4L2
         rbfHKIJmXr1IPuh6HEni0k4oRsNTXkSVGyu5eMWZGGoIlaybnpqZCtwW0TZgzXA+UvNF
         JAb2/vXO9cocunz0j+31eLheP7pXWOcAeZGE2lFMSkxWTigJXIQc3vPbTxUggDnacZWm
         WmMe/XJB354h/NCKivG1A9ZFYHDM406Eqd2zGLyk8p3ArI1GzfVOcNKoW/PeHWOKX5DM
         /ioQ==
X-Gm-Message-State: AOJu0Yz1Tr4YJ40VWpiw1lpnACxD35EhMtF6SU1F4JJ47yQ/bwgFnzqd
	FoED+U7IvGtHB+FMj27dU7UuSSh4rEi28RqVKivdQjOYLqd/ihN0ESTer7QABaXl2F+ZuPYDgIr
	eFs2Y5TFLCmG3fxRilkVkNJ4fxew=
X-Google-Smtp-Source: AGHT+IGK59iFOUSt9+uktIVkYVoKaNPWoZ6tqFfBZy0IuQyBWeJZ7cOYTERvewmrPdIkVt2lknGACyxbeAgh74QmJsw=
X-Received: by 2002:adf:ebcb:0:b0:33e:12eb:7822 with SMTP id
 v11-20020adfebcb000000b0033e12eb7822mr2022620wrn.71.1709331170622; Fri, 01
 Mar 2024 14:12:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301033734.95939-1-alexei.starovoitov@gmail.com>
 <20240301033734.95939-5-alexei.starovoitov@gmail.com> <65e230d4670d9_5dcfe20885@john.notmuch>
 <CAADnVQKKFxioLAqLPNq7mvt4GOHpC0j80-SUYzYQkpno3d+49Q@mail.gmail.com>
 <65e24cff4c626_76bd22088e@john.notmuch> <65e251831582f_8e09c208a@john.notmuch>
In-Reply-To: <65e251831582f_8e09c208a@john.notmuch>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 1 Mar 2024 14:12:39 -0800
Message-ID: <CAADnVQKBaWq0=Mw07rfxv3WZMxd0ZGrNVaH-xNuNJxY-ZDWf0w@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 4/4] selftests/bpf: Test may_goto
To: John Fastabend <john.fastabend@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Eddy Z <eddyz87@gmail.com>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 2:07=E2=80=AFPM John Fastabend <john.fastabend@gmail=
.com> wrote:
> >
> >  SEC("socket")
> >  __success __retval(16777216)
> >  int cond_break5(const void *ctx)
> >  {
> >       int cnt =3D 0;
> >
> >       for (;;) {
> >               cond_break;
> >               cnt++;
> >       }
> >
> >       cnt +=3D full_loop();
> >
> >       for (;;) {
> >               cond_break;
> >               cnt++;
> >       }
> >       return cnt;
> >  }
> >
> > From verifier side story is slightly different. There are still
> > two subprogs, but for subprog[0] has stack_slots=3D=3D0? Debugging
> > now but maybe its obvious what that static is doing to you.
>
> That was a typo its subprog[1] with stack_slots =3D=3D 0. Also
> tracing insn it seems in nonstatic case we hit multiple
> insn->code (BPF_JMP| BPF_JMA) but in the static case only
> find the first one. Object file seems to have multiples
> though. I need to drop for the rest of the afternoon most
> likely, but will try to see what sort of silly thing I did
> later today or worse case Monday.

Thanks for the bug report.
For static case:

$ bpftool p dump xlated id 36

int cond_break5(const void * ctx):
; int cond_break5(const void *ctx)
   0: (7a) *(u64 *)(r10 -8) =3D 8388608
   1: (b4) w6 =3D 0
; cond_break;
   2: (79) r11 =3D *(u64 *)(r10 -8)
   3: (15) if r11 =3D=3D 0x0 goto pc+4
   4: (17) r11 -=3D 1
   5: (7b) *(u64 *)(r10 -8) =3D r11
; cnt++;
   6: (04) w6 +=3D 1
   7: (05) goto pc-6
; cnt +=3D full_loop();
   8: (85) call pc+2#bpf_prog_270866f75dae27c8_full_loop
; for (;;) {
   9: (0c) w0 +=3D w6
; return cnt;
  10: (95) exit
int full_loop():
; static __noinline int full_loop(void)
  11: (b4) w6 =3D 0
; bpf_printk("cnt=3D=3D%d\n", cnt);
  12: (18) r1 =3D map[id:35][0]+0
  14: (b4) w2 =3D 9
  15: (bc) w3 =3D w6
  16: (85) call bpf_trace_printk#-87376
; return cnt;
  17: (bc) w0 =3D w6
  18: (95) exit

Looks like I made a mistake in may_goto verification.
Only the first loop remains. Other loops were removed as dead code.
It's certainly a bug in the patch 1. Will fix in the next revision.

pw-bot: cr

