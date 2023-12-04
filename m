Return-Path: <bpf+bounces-16558-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6167A8029B3
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 02:10:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B3291F20FD1
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 01:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F9881E;
	Mon,  4 Dec 2023 01:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGZa3EJK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 993CECB
	for <bpf@vger.kernel.org>; Sun,  3 Dec 2023 17:09:50 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2c9ee6fed3eso20433491fa.0
        for <bpf@vger.kernel.org>; Sun, 03 Dec 2023 17:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701652188; x=1702256988; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Lpwwc4gFh9KYPEA91cf7jbmA+TmyuTPtwA6cc0x8ck=;
        b=NGZa3EJKSfVS9vYFNam8skS4KiAidhm4nTGe5C2I13Am+a1nLhnNmdGudSw4j3jVle
         M9058Gb3W5Wil9ASrbNDSjAZ0stzh5Z05yKcthzHLQxoMEyR4grz3DAylV+Bvn3T2LNL
         4Q8yMiSP2vCG6MmWi5y3oSzyCwsuccxlgwY/IBVKVJhAy+wq5ph+kFQdHK9aFGWl2R/r
         keFXsSCuaopTveIyGGljwXWTIjIv0f2Wfh+atXZclphuO1AvCB2vpgThpUbTKF24SWm7
         TTVKs31+YgE8jCvpQpPZJFFbH+scSdoaltfFqTSkHYQ6lR+N8+O1XyEZl2ELrSyySCnE
         m5/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701652188; x=1702256988;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Lpwwc4gFh9KYPEA91cf7jbmA+TmyuTPtwA6cc0x8ck=;
        b=A+Odj+pbGcXnqVbERVYNgb6mt31qvm5Z2jZOx/K8Pg9UiWNFZANgzjk2ZLgWe3X0B/
         C/aAigMTWVICioYQ0NM8lJYYPjDP3A1XOhbk8tnocWWrBMTWjDh2nW5k+VZET+K/PFFc
         ywnQtDTYZGJP9Fr4W7JHLfL7DqaxmJMb+qTcX2COjNmRpaqBPYZvOcyv17cbIlN4hYw+
         2fmvNsh5jmBSBIZewMmZ4ryyqp8rJcXwOS1pvJM+Q/svQWWrGzlZDmJfScrggUd7QtzX
         S34uTINFLdMjkEjAHhTeVOYlDh3p6sAXycgrs61KczkHkuK+MNBAnk/HlUPkP6xJQ0Nf
         PtXA==
X-Gm-Message-State: AOJu0YwZ+UMoQlCpPxmZ+JQaUrUptwklLCcKLvAqcNwsNiANQ3HGz7Tm
	hNxZeLOY7XU1ScDk5glS60RJ7S+mIGiDpliSpvnYiaEbbbUDBw==
X-Google-Smtp-Source: AGHT+IG/DDK9E/xecQBba8nhFdmc/M4bIvoxYIw7Ynm6dDh5jRx4WKhNsTHUP/YZcufpFidiETvXc9iRL7yvAjFtzqQ=
X-Received: by 2002:a2e:7e05:0:b0:2c9:f931:67e4 with SMTP id
 z5-20020a2e7e05000000b002c9f93167e4mr560176ljc.19.1701652188161; Sun, 03 Dec
 2023 17:09:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231204010139.2038464-1-andreimatei1@gmail.com>
In-Reply-To: <20231204010139.2038464-1-andreimatei1@gmail.com>
From: Andrei Matei <andreimatei1@gmail.com>
Date: Sun, 3 Dec 2023 20:09:36 -0500
Message-ID: <CABWLsevk47Xa1a+h0UK--94zEuxScrmyt0-D8YShq1UgvVvf5g@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: fix verification of indirect var-off stack access
To: bpf@vger.kernel.org, andrii.nakryiko@gmail.com
Cc: sunhao.th@gmail.com, kernel-team@dataexmachina.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I'm fairly confused about the zero-access check done by check_mem_size_reg(=
)
iff the access size register's lower bound is zero ([1]). Can someone kindl=
y
explain what that's about; what does it add to the other
check_helper_mem_access() just below?
[1] https://github.com/torvalds/linux/blob/33cc938e65a98f1d29d0a18403dbbee0=
50dcad9a/kernel/bpf/verifier.c#L7486-L7489

---
FWIW, I have a test reproducing the crash, below. Although we had a bug, it
seems to me too random of a test to add. But I can add it if reviewers thin=
k
so.


SEC("socket")
__description("xxx")
__success
__log_level(4)
__naked void xxx(void)
{
asm volatile ("                     \
r0 =3D 0;                             \
*(u64*)(r10 - 16) =3D r0; \
*(u64*)(r10 - 8) =3D r0; \
/* Get an unknown value */ \
r1 =3D *(u32*)(r1 + 0); \
r1 &=3D 64;         \
r1 +=3D -16;         \
/* r1 is now anywhere in [-16,48)*/ \
r1 +=3D r10;                          \
r2 =3D 0;                             \
r3 =3D 0;         \
call %[bpf_probe_read_kernel];      \
exit;         \
" :
: __imm(bpf_probe_read_kernel)
: __clobber_all);
}

On Sun, Dec 3, 2023 at 8:02=E2=80=AFPM Andrei Matei <andreimatei1@gmail.com=
> wrote:
>
> This patch fixes a bug around the verification of possibly-zero-sized
> stack accesses. When the access was done through a var-offset stack
> pointer, check_stack_access_within_bounds was incorrectly computing the
> maximum-offset of a zero-sized read to be the same as the register's min
> offset. Instead, we have to take in account the register's maximum
> possible value.
>
> The bug was allowing accesses to erroneously pass the
> check_stack_access_within_bounds() checks, only to later crash in
> check_stack_range_initialized() when all the possibly-affected stack
> slots are iterated (this time with a correct max offset).
> check_stack_range_initialized() is relying on
> check_stack_access_within_bounds() for its accesses to the
> stack-tracking vector to be within bounds; in the case of zero-sized
> accesses, we were essentially only verifying that the lowest possible
> slot was within bounds. We would crash when the max-offset of the stack
> pointer was >=3D 0 (which shouldn't pass verification, and hopefully is
> not something anyone's code attempts to do in practice).
>
> Thanks Hao for reporting!
>
> Reported-by: Hao Sun <sunhao.th@gmail.com>
> Fixes: 01f810ace9ed3 ("bpf: Allow variable-offset stack access")
> Closes: https://lore.kernel.org/bpf/CACkBjsZGEUaRCHsmaX=3Dh-efVogsRfK1FPx=
mkgb0Os_frnHiNdw@mail.gmail.com/
> Signed-off-by: Andrei Matei <andreimatei1@gmail.com>
> ---
>  kernel/bpf/verifier.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index af2819d5c8ee..a428735d232e 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -6816,10 +6816,7 @@ static int check_stack_access_within_bounds(
>                         return -EACCES;
>                 }
>                 min_off =3D reg->smin_value + off;
> -               if (access_size > 0)
> -                       max_off =3D reg->smax_value + off + access_size -=
 1;
> -               else
> -                       max_off =3D min_off;
> +               max_off =3D reg->smax_value + off + access_size - 1;
>         }
>
>         err =3D check_stack_slot_within_bounds(min_off, state, type);
> --
> 2.40.1
>

