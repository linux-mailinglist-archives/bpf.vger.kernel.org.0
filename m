Return-Path: <bpf+bounces-78411-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCEFD0C710
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 23:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9390D300E4CD
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 22:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55CD2345724;
	Fri,  9 Jan 2026 22:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ja1EtMaa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB95345722
	for <bpf@vger.kernel.org>; Fri,  9 Jan 2026 22:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767997144; cv=none; b=GgDH9tfv2KauORTsxJf60bGyp3LsvwB3l2cpohxN5YmozO+cZoYUqhdNhM6aYOozha+u5CmRlXYU7WI9gbdFMSzpcMapv/2+XWi9vifjF2incQlgjOj+oW7SsExvWEYft7gqdDPs9tEvpHT4QRA5AtevPCRMQ1yRNKz67TIKcvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767997144; c=relaxed/simple;
	bh=tqjP6xEURAgESioz9W8Ur3cBXrkpJmnDUPqP5kJ7epY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pil8yWqr925GUqpR+uZJxHVYbQpNBZpJWSC/Y2SXO+syP3RqW4+shG5PsyF5Hb6yhCmqW+SYjio5WdRjv7DtoN+tqgG7Deug5RyOP38Uzu6v6s2nJ5PnUFdX1gp2xu/28G7L2a/O5rjawbgA3p2oSwr7S5W6MVZLYJSOx31KQIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ja1EtMaa; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-81dbc0a99d2so711599b3a.1
        for <bpf@vger.kernel.org>; Fri, 09 Jan 2026 14:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767997143; x=1768601943; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VWQb7yCclPKZIE/T/T9XiinDfWQG0ZIHBCllG5A2TPs=;
        b=Ja1EtMaaXHa+JxWcz2l1fvDfpMRdbwUtNHRbDP2R/gOi+UxFkSBSbS6N5NHRAdeOQd
         Zp8vbPwisYYxUuTf51wiO5GRhfbfTvu9PHB4vA16LepUbozJG7VbgJuorLDqp39KR9YQ
         jn8NY/10SHmpcyHjd/o7DmYYJhnICUV7e7Fiqh+xhTdMVD2pmIOpZqB/j05NcVt1FhxK
         +cw+EWQ3MMgJglDhf3UGhDKRbIbbNFO3WHbHSOTgRpB7xy8zuRN8xmh652nMa+ToONse
         uQGdI/K0G10s2/bZUe3pVNYtIp+PhB0hwamP2TrFAd9Nl9hnxwtT9f2TnTOvaJ09/XEs
         eRHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767997143; x=1768601943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VWQb7yCclPKZIE/T/T9XiinDfWQG0ZIHBCllG5A2TPs=;
        b=YqXgG132RwsZ3XKAxyt9yN8/zGWeXIvctiu7r6RNyTWSs3r3pkhIx8ImiNwEdzizan
         fdZtEhsLzargvG3RB211rv3Y+t5mPfd2VZfFqnnYgeqSbCQc9Nr8PNAW/Bom99XXb4pZ
         zNRNWWz7oY2FGTI2sQACmnHy5z0hVKNV/WysS42YmZdKrO4Ot71RSBgtU46VrL25gUmA
         zYiTYcoKauyGxJ2L9a3dwBMUnCDhhJ+6Yp7Y5sBKe2EEj6EJO5j5quZu1+6OPy7ymvDz
         UaBqTo7WeXAr+RRrSGKZSpd62uUX+UandnqoPavEMrTkV/BND1vnkx+SNxeB4NcSfmvX
         5gaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWtAROVTIUJiMBJPpPQ04tKGmBKpqBE2AZw1vFAutp93519/ICNCL0CK1SaiV9b9zhv8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEhdDl7Fm0DxbROamH8CWRZzVrRyCqg2JHgiVZvToxrnDkUKxn
	TDPTDh6QdVppVrB2GubqWGn5fcbXSlJMRLQKULJ7nbY48GbtC4UDS05VOOluy3MVrl6EonLCsOw
	Qxkt7jnTDyu34B1Tne0uXd5Ab9XTc4fY=
X-Gm-Gg: AY/fxX71ZkHMQWVFpm3SQFbHrns0wdtLhvlGRzvprXkoZkepKkJvdmmC9bwlvY8GIbT
	0WyQZNk+ejLKUdo7JMsjBV6zD6S/jYx0p8Li5GHUbYZ42OENspJGK3eSWmThTD/n/4fSumEg9bm
	6izMRLyjfjrZnezxU0md3GJ4Gfl6oJ3TV+43HzrOLGeEZwVkDTmoh8vleGhgtL06SKEM7u6zDl+
	loRFh4SCk07s/j+sPvwkNAZDQHrhdnhH5evGXfnfxak14XFslWAKLdHuqNBDRayAezZFoc7KPph
	iB5gz9ob
X-Google-Smtp-Source: AGHT+IFoRnFVCtH5CGpWY8ZGaKUQwgQOeQYBSw+1TPPhfTtrdNPqk8d2aJ+WqOtGWnYaGxACoiCZSSd8qv3KaXCLLxk=
X-Received: by 2002:a05:6a21:6d89:b0:37e:8eab:c05f with SMTP id
 adf61e73a8af0-3898f9e43d8mr11683742637.59.1767997142787; Fri, 09 Jan 2026
 14:19:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260107-timer_nolock-v3-1-740d3ec3e5f9@meta.com> <b24f940a2d2e990dc39154bc606665b36e1630fde457032d64f2a2ee5c0f4b45@mail.kernel.org>
In-Reply-To: <b24f940a2d2e990dc39154bc606665b36e1630fde457032d64f2a2ee5c0f4b45@mail.kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 9 Jan 2026 14:18:49 -0800
X-Gm-Features: AQt7F2q5M64MK3NQ-5jKcIXXYVs13mOfmI3t1W68617NPnZE-WFbJ1O2SWiQ1Ks
Message-ID: <CAEf4BzZxZbUjBS2v-SO8Z_g_hxbrZy9JTVYTdryE0OzZx7PSyg@mail.gmail.com>
Subject: Re: [PATCH RFC v3 01/10] bpf: Refactor __bpf_async_set_callback()
To: bot+bpf-ci@kernel.org
Cc: mykyta.yatsenko5@gmail.com, bpf@vger.kernel.org, ast@kernel.org, 
	andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
	memxor@gmail.com, eddyz87@gmail.com, yatsenko@meta.com, martin.lau@kernel.org, 
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026 at 10:22=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index 9eaa4185e0a7..954bd61310a6 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
> > @@ -1355,55 +1355,36 @@ static const struct bpf_func_proto bpf_timer_in=
it_proto =3D {
> >  };
> >
> >  static int __bpf_async_set_callback(struct bpf_async_kern *async, void=
 *callback_fn,
> > -                                 struct bpf_prog_aux *aux, unsigned in=
t flags,
> > -                                 enum bpf_async_type type)
> > +                                 struct bpf_prog *prog)
> >  {
> > -     struct bpf_prog *prev, *prog =3D aux->prog;
> > -     struct bpf_async_cb *cb;
> > -     int ret =3D 0;
> > +     struct bpf_prog *prev;
> > +     struct bpf_async_cb *cb =3D async->cb;
> >
> > -     if (in_nmi())
> > -             return -EOPNOTSUPP;
> > -     __bpf_spin_lock_irqsave(&async->lock);
> > -     cb =3D async->cb;
> > -     if (!cb) {
> > -             ret =3D -EINVAL;
> > -             goto out;
> > -     }
> > +     if (!cb)
> > +             return -EPERM;
>
> A small concern: the error code changed from -EINVAL to -EPERM. The verif=
ier
> comment at kernel/bpf/verifier.c mentions that non-initialized timers
> "will return -EINVAL". Is the error code change intentional, and should
> the verifier comment be updated?
>

good AI, I asked the same

> > -     if (!atomic64_read(&cb->map->usercnt)) {
> > -             /* maps with timers must be either held by user space
> > -              * or pinned in bpffs. Otherwise timer might still be
> > -              * running even when bpf prog is detached and user space
> > -              * is gone, since map_release_uref won't ever be called.
> > -              */
> > -             ret =3D -EPERM;
> > -             goto out;
> > -     }
>
> The usercnt check is removed here. The check still exists in
> __bpf_async_init(), so a timer cannot be initialized when usercnt is zero=
.
> But can there be issues if set_callback is called after usercnt drops to
> zero on an already-initialized timer? The old code would fail with -EPERM=
,
> while the new code proceeds.
>

Wasn't this discussed earlier, Mykyta? Do you remember the conclusion?

> > -     prev =3D cb->prog;
> > -     if (prev !=3D prog) {
> > -             /* Bump prog refcnt once. Every bpf_timer_set_callback()
> > -              * can pick different callback_fn-s within the same prog.
> > -              */
> > -             prog =3D bpf_prog_inc_not_zero(prog);
> > -             if (IS_ERR(prog)) {
> > -                     ret =3D PTR_ERR(prog);
> > -                     goto out;
> > +     do {
> > +             if (prog) {
> > +                     prog =3D bpf_prog_inc_not_zero(prog);
> > +                     if (IS_ERR(prog))
> > +                             return PTR_ERR(prog);
> >               }
> > +
> > +             prev =3D xchg(&cb->prog, prog);
> > +             rcu_assign_pointer(cb->callback_fn, callback_fn);
>
> Is there a potential race between these two operations? Consider two
> concurrent callers (with programs P and Q) racing:
>
> 1. Thread A: xchg stores P into cb->prog
> 2. Thread B: xchg stores Q into cb->prog, gets P back
> 3. Thread B: rcu_assign_pointer stores FB (Q's callback)
> 4. Thread B: bpf_prog_put(P), B's check passes, B exits
> 5. Thread A: rcu_assign_pointer stores FA (P's callback), overwrites FB
> 6. Thread A: check fails (cb->prog is Q, not P), retries
>
> After step 5, cb->prog holds Q (with Q's reference) but cb->callback_fn
> points to FA (from P). If P's refcount drops to zero elsewhere and P is
> freed, would the timer callback FA become a dangling pointer?

AI is not completely wrong here, IMO. No, there is no use-after-free
just yet because program is RCU protected, so we don't have dangling
pointer just yet.

But. That bpf_prog_inc_not_zero() on retry will fail if P's program
refcount dropped to zero already. And then once we exit, we'll have
Q+FA combo, which is not good.

So I think we need to do one bpf_prog_inc_not_zero() outside of the
loop once and keep that extra ref until we exit. And then instead of
bpf_prog_inc_not_zero(prog) inside the loop, we do unconditional
bpf_prog_inc(), which we *know* has to succeed. Less error handling
inside the loop as well.

Thoughts?


>
> The bpf_timer_cb() function reads cb->callback_fn and calls it directly
> without verifying it corresponds to cb->prog. The cb->prog field holds
> the reference keeping the program alive, but if the callback pointer is
> from a different program that may have been freed, this could be a proble=
m.
>
> > +
> >               if (prev)
> > -                     /* Drop prev prog refcnt when swapping with new p=
rog */
> >                       bpf_prog_put(prev);
> > -             cb->prog =3D prog;
> > -     }
> > -     rcu_assign_pointer(cb->callback_fn, callback_fn);
> > -out:
> > -     __bpf_spin_unlock_irqrestore(&async->lock);
> > -     return ret;
> > +
> > +     } while (READ_ONCE(cb->prog) !=3D prog || READ_ONCE(cb->callback_=
fn) !=3D callback_fn);
> > +
> > +     return 0;
> >  }
>
> [ ... ]
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/207913=
45842

