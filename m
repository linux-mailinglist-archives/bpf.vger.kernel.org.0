Return-Path: <bpf+bounces-58208-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4973BAB7156
	for <lists+bpf@lfdr.de>; Wed, 14 May 2025 18:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41B677AD72D
	for <lists+bpf@lfdr.de>; Wed, 14 May 2025 16:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1E7275853;
	Wed, 14 May 2025 16:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gHRcuTIp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4285269826
	for <bpf@vger.kernel.org>; Wed, 14 May 2025 16:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747240107; cv=none; b=YXaQYWSIk4+JDOkfndHDKI6/OE/19LP362KCEsMaBrhIkzjhwC4gS//znnyvQrjjPf8ToE2nTvAmHxykXxwM1gvlWP/2L38aPo1JYgwEOhuL0O8elwDaTfwhXJ6JUPCd8fnt2Ny/bx0XDv1wl/ZlhipmZBAS2BK8HMm9jvqBRn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747240107; c=relaxed/simple;
	bh=delaTcaXeBa8qFSY77GbyNzRzzPyPfYB6qYIuZjcZjI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tWq4SqafU2cxLbo/hYMi9fX9O+1XtnCPvOKEsikIp2AK0hy3pF56s7PI16edc3hZQ9zsmt37Ts5cCaRZC2nYtTflELz0y/zJR3zbGQwPFNM9Ibik/2wbAPaNka2YjNzrS5yzUOsNhQKW2WlI1opiJDcGMO2ydvVY5cdVaOFkmYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gHRcuTIp; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-30ac24ede15so56595a91.2
        for <bpf@vger.kernel.org>; Wed, 14 May 2025 09:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747240105; x=1747844905; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=liFD5MHN8GB/DsNHBx5oH/2MjdBeFd+BSAhsuvAcr+M=;
        b=gHRcuTIpmkpsERArR6mYkSmLWoGlNTCUa1oW6jzMmECs73PikQkVw6p+1Hp5Ybrq+R
         T6QmcoWDkbOC5EAIKs1sGBUIbMcHXzv0rHqOEP2dvTpn+5owf46cytTHaIZdcLwp7Jbt
         rLcQvP99J1KsavvzNxeBi+NecNQ5vmrpumJEx8USIRBbFFSfcgGxcXsLJs7LqLd0I1HY
         AT89hRj/IHkMPRRWNWslPCy56vkgRT5KyNxKcSWjQZ3PpRDZV5jaPml1gjaDSvVPtD/E
         5HMr8VgKxMfzpjovbX1vyDWntsj2KruLb8HnumNs1vuMNaqY1M8CAbLkbO63YMsNkCoZ
         /abw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747240105; x=1747844905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=liFD5MHN8GB/DsNHBx5oH/2MjdBeFd+BSAhsuvAcr+M=;
        b=JycpXR7Yog+szo9WaYbNPAAmUa7l56/4Z8XsblTLH9WaWbBPRt3ornZd1H4A9wqtKG
         trN2AhS+XuShtNvAyhWmDRNCj8JFMH6aHUVVQcQskdw9Utjq8mmaYj1Up4E1x9GcydM1
         0FVonJWg3dr4JVWwe1RVwQi/oE4JQiZ+AxaVr2eE/r8kyMRki5POpL8BFWW+6HdPSjud
         wH9aH0Es1gXjaDPcaNlkgOqbGHhaPFzZ2rqSyKRmPnzNYfIXVkaSA9VLt0L98WvKnmWJ
         il2wx2YKWQ4MRddBtqmkX73OevQENjfQwT2OoY3lOszp4GWq2OEff0KsYrNiG3425aLU
         Z2ww==
X-Gm-Message-State: AOJu0YyZAucqDg3Bs0yWpfHBFBC0krGnCdeMGXRTBgF/6/odmYHA/khN
	bcZvMbhpg33z1L+0VQR6mibBvJnVf57MIF+pEekZioS1ouR9ptHjFQvCOYxN4eDzXtrtjCp6tus
	ZI6X75vZCgmmuJOyU3KtvEMicNM2MENcl
X-Gm-Gg: ASbGncu2aNuTUW25rM00MiFbgEcbDccWFrlyBxnv31TVl/BN/rbVgjmy+kR2asfsXR9
	IzZX0FNWjS2r72+gPNXPboTkn0oJpIo3k8Q1jEQYMm7+VsrPUWl3bYrvSgxK/4c8jrLUo3SzC36
	ROOev6VYoVI5VvrHtd4fy+Js5YL+IPsEH6gNVfsu5OhAknHN8o
X-Google-Smtp-Source: AGHT+IELE0kAnmlmxq1XAmt6e7C+zQ2cwFqK01ulznRQtsR2AdMdn1KSMk8FrokzT0fVEHIsB3+Ev2irLCI8se64tZk=
X-Received: by 2002:a17:90b:5403:b0:309:e351:2e3d with SMTP id
 98e67ed59e1d1-30e2e5bb679mr7239444a91.12.1747240104660; Wed, 14 May 2025
 09:28:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aCR_9Ahv4DpvK-Vy@mail.gmail.com>
In-Reply-To: <aCR_9Ahv4DpvK-Vy@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 14 May 2025 09:28:11 -0700
X-Gm-Features: AX0GCFtTjsFBnvmv7vuzbG2oUhU6FuGlvpZ0L5oEKtBx7g-Au_hLttdhottPyZI
Message-ID: <CAEf4BzZ2i8MMvS4=xGQv0YwoyuARaVP+v8YMeVR4SRcQcdMt+Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: WARN_ONCE on verifier bugs
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 14, 2025 at 4:35=E2=80=AFAM Paul Chaignon <paul.chaignon@gmail.=
com> wrote:
>
> Throughout the verifier's logic, there are multiple checks for
> inconsistent states that should never happen and would indicate a
> verifier bug. These bugs are typically logged in the verifier logs and
> sometimes preceded by a WARN_ONCE.
>
> This patch reworks these checks to consistently emit a verifier log AND
> a warning when CONFIG_DEBUG_KERNEL is enabled. The consistent use of
> WARN_ONCE should help fuzzers (ex. syzkaller) expose any situation
> where they are actually able to reach one of those buggy verifier
> states.
>
> Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
> ---
> Changes in v2:
>   - Introduce a new BPF_WARN_ONCE macro, with WARN_ONCE conditioned on
>     CONFIG_DEBUG_KERNEL, as per reviews.
>   - Use the new helper function for verifier bugs missed in v1,
>     particularly around backtracking.
>

[...]

> @@ -4277,14 +4274,15 @@ static int backtrack_insn(struct bpf_verifier_env=
 *env, int idx, int subseq_idx,
>                                  * should be literally next instruction i=
n
>                                  * caller program
>                                  */
> -                               WARN_ONCE(idx + 1 !=3D subseq_idx, "verif=
ier backtracking bug");
> +                               if (unlikely(idx + 1 !=3D subseq_idx))
> +                                       verifier_bug(env, "extra insn fro=
m subprog");


maybe let's add verifier_buf_if(cond, env, fmt, args...) that would do
if (unlikely(...)) inside? it can also return the result of cond if we
want to do something like

if (verifier_bug_if(<condition>, env, "we are doomed"))
    return -EFAULT;

>                                 /* r1-r5 are invalidated after subprog ca=
ll,
>                                  * so for global func call it shouldn't b=
e set
>                                  * anymore
>                                  */
>                                 if (bt_reg_mask(bt) & BPF_REGMASK_ARGS) {
> -                                       verbose(env, "BUG regs %x\n", bt_=
reg_mask(bt));
> -                                       WARN_ONCE(1, "verifier backtracki=
ng bug");
> +                                       verifier_bug(env, "scratch reg se=
t: regs %x\n",
> +                                                    bt_reg_mask(bt));
>                                         return -EFAULT;


but please don't go overboard with verifier_buf_if() for cases like
this, I think this should use plain verifier_bug() as you did, even if
it *can* be expressed with verifier_buf_if() check


>                                 }
>                                 /* global subprog always sets R0 */
> @@ -4298,16 +4296,16 @@ static int backtrack_insn(struct bpf_verifier_env=
 *env, int idx, int subseq_idx,
>                                  * the current frame should be zero by no=
w
>                                  */
>                                 if (bt_reg_mask(bt) & ~BPF_REGMASK_ARGS) =
{
> -                                       verbose(env, "BUG regs %x\n", bt_=
reg_mask(bt));
> -                                       WARN_ONCE(1, "verifier backtracki=
ng bug");
> +                                       verifier_bug(env, "unexpected pre=
cise regs %x\n",
> +                                                    bt_reg_mask(bt));
>                                         return -EFAULT;
>                                 }
>                                 /* we are now tracking register spills co=
rrectly,
>                                  * so any instance of leftover slots is a=
 bug
>                                  */
>                                 if (bt_stack_mask(bt) !=3D 0) {
> -                                       verbose(env, "BUG stack slots %ll=
x\n", bt_stack_mask(bt));
> -                                       WARN_ONCE(1, "verifier backtracki=
ng bug (subprog leftover stack slots)");
> +                                       verifier_bug(env, "subprog leftov=
er stack slots %llx\n",
> +                                                    bt_stack_mask(bt));
>                                         return -EFAULT;
>                                 }
>                                 /* propagate r1-r5 to the caller */

[...]

