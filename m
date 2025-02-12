Return-Path: <bpf+bounces-51271-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3B7A32AF1
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 16:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40A28188C2F3
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 15:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B91525C709;
	Wed, 12 Feb 2025 15:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F5UAoIqQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C180F259483
	for <bpf@vger.kernel.org>; Wed, 12 Feb 2025 15:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739375548; cv=none; b=OU/0Y3smsGgaxiStClyFCcEumxQtE/jOqDM5RjUuLEKFDj92G2AvyLI64uP7x1OTblLk8WnYSDj1NjfQzud9+oi0ekumIC7MuPn2nel6YehS0x6FpMep5PLcAlRtVdjxsuYEA8V0irHsUZlnUvsatuEC79pEPkuMf654F7WIsOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739375548; c=relaxed/simple;
	bh=D0xDf+qF1x5zmKUxWCEEBkJpViXMFoqrgdATpzwe99g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jgM+vPbYAGo+6C0GqedEgSpO1GD47PAJpFHQ/v2OnMHzmP4hmsQThm8Opudq5In+9TJ+JzDmEq08GX6sdh2YI5/CT0tbMqsnzf8Qmn9TJOOw2Eg5fMXjLQAz/3pZn5dgJYb9Q9ANlJUU8OgGfJYpGLtShv1bzDjZOBmDUcLCS/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F5UAoIqQ; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-438a39e659cso48965365e9.2
        for <bpf@vger.kernel.org>; Wed, 12 Feb 2025 07:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739375545; x=1739980345; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F+uWxK0H+HP7yNGmxu0dfKOULijh/3t2QJFTiU6jBf0=;
        b=F5UAoIqQiHiofd3A/vn1Qhm7s8cCVVpAm562Xlj+bMRC0Q4uix9Fu+cYzZ7Pd8IcNU
         +MTTVqDTZUFMQu46JgIdKJVpITyhc4nlj5yFzSLZI8vXHmFLsDQjljpz+CO154zNdNFc
         Q5RkI5617pJguMUNFnD5XP14HZEz+3PTwRWjgToIgk/kQfde/47OVHrkNfqC/+Ac2Qve
         HCEXjh/6rgsoZrwNQPDGT+/zZh+gBZE20EEL9Jzg7TnNDaE86xpWnmYG+aqpLa6Y5ihl
         sxtGWGxHlmlzmHh8BNWs9Sjz5QrckMpV9nQsJD9TOOg9KvLik2h2HWp6eLmp81KW/ZjA
         JBsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739375545; x=1739980345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F+uWxK0H+HP7yNGmxu0dfKOULijh/3t2QJFTiU6jBf0=;
        b=tWlhyW8ZeRnICffgeAzWiVkVKdHiEhVl9JULy8474s5NRXwzefkNDxeNM8mARlxKih
         h1Momo5sqwfiMwJuh1ifwZg7wYusWvf8yKEZ8wB3HB6Fo2MUu/Vvdq+FScK9icDNLch/
         vM46bjlvZfGVaSpCR0UchBxDdbbnB6ilReSW06nWP63BiKaAgIwqhXEFVuD6ZoyT3enA
         67cDDUmUXNynTnokKQdzbSfTrZjLyDkSr31QWZM2ZNsRamWiZptwGslZI5udrE0IPkAF
         HyOVzPCO7aQCW8PIyTd50H8YjK43XIXDtinxhfggbizDgOj73wbMOOQnqR7JBIwz7Udg
         e1Ew==
X-Gm-Message-State: AOJu0YwJwz65HRUY0hMeftKueqd1KwBF1UImZX8JZbzvAoJd3KzKwgQr
	ReYc1q+XMr8SuvFScdIosNuwYJ7ZvIR63xlKnUhGqbPPx2KTuGrOz6dgS5ZAJOZA/Qu3tj7XepY
	Kszxxfqd+gfzdQr21/qT0YU2K9G0=
X-Gm-Gg: ASbGncs33RDejc6QaT6ygIRei9vt+F6nj0xmlDwrI+NWWML9fT8RVjkJWSAQyiKhaw/
	GoDfF4vOE6+dRto9SEi6dNjb0OKWhekxctxMIQECqMpTkw2CUFQrzogF3WPT+gBIw/R9ZvnSwRV
	xfVEXgq7RlUOQD
X-Google-Smtp-Source: AGHT+IEbg5b+Ol3NQ1qTSQU5mvluDCBl6IggNEveCPEsWISWBZG8NZVtX1Pg0/LorVh0QC2VXrDKtR5UGBTRxBN103w=
X-Received: by 2002:a05:600c:4fd3:b0:439:5506:7197 with SMTP id
 5b1f17b1804b1-43958173f95mr38750695e9.10.1739375544535; Wed, 12 Feb 2025
 07:52:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212135251.85487-1-mrpre@163.com> <20250212135251.85487-2-mrpre@163.com>
In-Reply-To: <20250212135251.85487-2-mrpre@163.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 12 Feb 2025 07:52:12 -0800
X-Gm-Features: AWEUYZkDa0fCpEUxfN9RC8yBK3DG0as-etZt5adQHx7ZTh4cV3coVaq4R0CNWnY
Message-ID: <CAADnVQ+pPAutQo8G25QZwVMXa0NaQoeEJP26xKcLLALbQEWdpg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/2] bpf: Fix array bounds error with may_goto
To: Jiayuan Chen <mrpre@163.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	syzbot+d2a2c639d03ac200a4f1@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 5:53=E2=80=AFAM Jiayuan Chen <mrpre@163.com> wrote:
>
> may_goto uses an additional 8 bytes on the stack, which causes the
> interpreters[] array to go out of bounds when calculating index by
> stack_size.
>
> Reported-by: syzbot+d2a2c639d03ac200a4f1@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/bpf/0000000000000f823606139faa5d@google.c=
om/
> Fixes: 011832b97b311 ("bpf: Introduce may_goto instruction")
> Signed-off-by: Jiayuan Chen <mrpre@163.com>
> ---
>  kernel/bpf/core.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index da729cbbaeb9..498b35284f81 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -2255,7 +2255,7 @@ static u64 PROG_NAME_ARGS(stack_size)(u64 r1, u64 r=
2, u64 r3, u64 r4, u64 r5, \
>
>  EVAL6(DEFINE_BPF_PROG_RUN, 32, 64, 96, 128, 160, 192);
>  EVAL6(DEFINE_BPF_PROG_RUN, 224, 256, 288, 320, 352, 384);
> -EVAL4(DEFINE_BPF_PROG_RUN, 416, 448, 480, 512);
> +EVAL5(DEFINE_BPF_PROG_RUN, 416, 448, 480, 512, 544);
>
>  EVAL6(DEFINE_BPF_PROG_RUN_ARGS, 32, 64, 96, 128, 160, 192);
>  EVAL6(DEFINE_BPF_PROG_RUN_ARGS, 224, 256, 288, 320, 352, 384);
> @@ -2267,8 +2267,11 @@ static unsigned int (*interpreters[])(const void *=
ctx,
>                                       const struct bpf_insn *insn) =3D {
>  EVAL6(PROG_NAME_LIST, 32, 64, 96, 128, 160, 192)
>  EVAL6(PROG_NAME_LIST, 224, 256, 288, 320, 352, 384)
> -EVAL4(PROG_NAME_LIST, 416, 448, 480, 512)
> +EVAL5(PROG_NAME_LIST, 416, 448, 480, 512, 544)
>  };

That's two extra functions for a rare corner case.
Let's do something like the following instead:
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9971c03adfd5..028de7a6edfc 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21884,6 +21884,10 @@ static int do_misc_fixups(struct bpf_verifier_env =
*env)
                        subprogs[cur_subprog].stack_extra =3D stack_depth_e=
xtra;
                        cur_subprog++;
                        stack_depth =3D subprogs[cur_subprog].stack_depth;
+                       if (stack_depth > MAX_BPF_STACK &&
!prog->jit_requested) {
+                               verbose(...);
+                               return -EINVAL;
+                       }


pw-bot: cr

