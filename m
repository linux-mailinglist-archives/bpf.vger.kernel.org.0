Return-Path: <bpf+bounces-77166-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 341DECD1055
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 17:59:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 60FB130456E1
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 16:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCEA42DC32B;
	Fri, 19 Dec 2025 16:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jW76S7vd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E1923A9B3
	for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 16:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766163393; cv=none; b=QTAK55lBSK2qO10cC7FPrCjmznbucz3g2HLyObtvYsjja/UKIO1bHgzQNz9axjnbbU5uvncktvEE2f80sTWU4ffmspUhhrI2uhMfDqU+9TWuvvno3uqxi1EkUEDzV99+FDb2p5hNtWxL/tCFbytxVtPcLjmieQB3efE9dC0E/F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766163393; c=relaxed/simple;
	bh=XuHfV9ykuFgD2EP5kAfPzD+xEN0U7RIH8PVHOPBATvs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UfgnqB5suR+Ju6I0NJfPWkpWls7+UUWAZdkHYHy5jqZe8Ar9NhBBXOdo9wRucjgN8Ju+RoVE+ukSTdb0f/ILVcnRncQ71mu0/YZ/kpIxhsnv7M8QNW2uEhbd9o6F0txl6Lqhq5XJM2agFCH1aHQlZI7ABxu0Kp+nqEMtU0MSBac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jW76S7vd; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a0d0788adaso17899965ad.3
        for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 08:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766163391; x=1766768191; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mror4wyk3xXuWauP6wtmJZb+CWqKbOZLWZ2Ozch9bqM=;
        b=jW76S7vdLJ+Hx3ha6OXlG3FXYAs9y0mvlw+pGHLEyfKCiBlWtQYFTtCJb163uOhYGq
         fcq2kuVI9vf/rVgrHAgsV+tR9Dg9ZoyCfjj0nJ8BKh324YDvVBkqpnLUwEM31P7XIAhj
         J+zFXSc6iwSS8kM79Rrxyj/pMWsOoNkoCp/kWe9nsrPasgSmWBu9EnoTTbGOHNgaNAD+
         ar2qNazUxg8gjLTsmW3gWERLnQiK7GnMoU/5O1V0xABrue2OrNmFjLD1gsvCnTuZTFIi
         GRO0iwM7mSX64w2kbW3OL3rwrlVZ6imeHxAH/iuc2gIcacADNtkK3dA5PC15+R0CXBmh
         xeug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766163391; x=1766768191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mror4wyk3xXuWauP6wtmJZb+CWqKbOZLWZ2Ozch9bqM=;
        b=TubHlHEhKejwctubR9u7eE4d4GWro9ugYTh7OacOY5nSn01uVktGJGAWB9YN/qkntu
         aPrGSRotAXBBuAkz1MD2FQREVn+9wXN31RlbL45uZErx+j/ERpr8Ez1hWzFlE+AZRCmO
         9fcgfXYdmUFuxg6XrfC1ykBe99Wcs/l8d/mD2zZKTLq44bDby7S/xvQPs+AzDAB+RySD
         TuZkX7uK0HF4KBhzucncMSeqaVe2ze+f8QnO86UDY67ByFrwQ7yO1b6emWk6EKjSiQRm
         Wn4r7PKDsqOu8hW7wW83GWxXFe0YD5lCQd26H8AIIz7AhDWKP/WcBUBFqb6xzKo28hXQ
         0Zyw==
X-Forwarded-Encrypted: i=1; AJvYcCWFjKBtzwQQ4IMCZiyVgYqTmJUTSBVF1kiJLBv9mVJMitM6SVDkQP4ahx+pNVw6ZZOjGQc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj4aiYXDVhOk1l68uZw0Xv0ZBftXQA59gkyW/jvgDmttyZI2OD
	6bUzEeVE4lgRMWZdmGNP60oH0hubOUNk/bLVjiik1d0QxsknPRhuyYA9d/9EmC7aR2BUHtVHWcN
	bXltJ4bz11ROpH/47Jfxl2amTUqN7U4c=
X-Gm-Gg: AY/fxX6R1RccC3yTy+8m4pS0A4LGLMW9tZtSdIIRep39e8ID76riloSaNAD7ZC5K68u
	7G53Marm5IUuonPMH9d8OSt3NSM08MrbpNbt3N6IIOU8C/aEpQEUgXEjDH07SGeq9OhGhh4eSnf
	MlyRpaeEB3sJhW8DqyULELMIufiI6ZLr/6CZaTryo7MnUZn3eO4/P/mdn3ZFYnYI2/kSXgrSWKA
	u5h4hYoFTNCrVab/O/rHYwPVAGI9pv6vopcyktJTsm9AFLKN0ckjdrFJNqeULPKJHv+f9A=
X-Google-Smtp-Source: AGHT+IE4Q7Pc8+4KdKhZBQzVWxnD4+C6WUhxmqkYMtv8E3Ct/iiY8nEdp6LuQvDoIvxu5PAPrlpMa6n9SUihsDvTObw=
X-Received: by 2002:a17:90b:37c3:b0:340:be4d:a718 with SMTP id
 98e67ed59e1d1-34e92113213mr3182521a91.7.1766163390887; Fri, 19 Dec 2025
 08:56:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251217095445.218428-1-dongml2@chinatelecom.cn>
 <20251217095445.218428-7-dongml2@chinatelecom.cn> <CAEf4BzZOfB310d4_1eznUgkGwK5cwhZSEgc9SANJskCbctDoMQ@mail.gmail.com>
 <9551014.CDJkKcVGEf@7940hx>
In-Reply-To: <9551014.CDJkKcVGEf@7940hx>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 19 Dec 2025 08:56:18 -0800
X-Gm-Features: AQt7F2rRhqj0Z_iBRvWrA-q9JSt6vXwIt35I1R2RW-qObsGB0FEWENBOfCGkPiU
Message-ID: <CAEf4BzbivvVtDWywzAQY8txk6tTOw__NEzrMU-wH52oYMBQPaw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 6/9] bpf,x86: add tracing session supporting
 for x86_64
To: Menglong Dong <menglong.dong@linux.dev>
Cc: Menglong Dong <menglong8.dong@gmail.com>, ast@kernel.org, andrii@kernel.org, 
	davem@davemloft.net, dsahern@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 18, 2025 at 5:42=E2=80=AFPM Menglong Dong <menglong.dong@linux.=
dev> wrote:
>
> On 2025/12/19 08:55 Andrii Nakryiko <andrii.nakryiko@gmail.com> write:
> > On Wed, Dec 17, 2025 at 1:55=E2=80=AFAM Menglong Dong <menglong8.dong@g=
mail.com> wrote:
> > >
> > > Add BPF_TRACE_SESSION supporting to x86_64, including:
> > >
> > > 1. clear the return value in the stack before fentry to make the fent=
ry
> > >    of the fsession can only get 0 with bpf_get_func_ret(). If we can =
limit
> > >    that bpf_get_func_ret() can only be used in the
> > >    "bpf_fsession_is_return() =3D=3D true" code path, we don't need do=
 this
> > >    thing anymore.
> >
> > What does bpf_get_func_ret() return today for fentry? zero or just
> > random garbage? If the latter, we can keep the same semantics for
> > fsession on entry. Ultimately, result of bpf_get_func_ret() is
> > meaningless outside of fexit/session-exit
>
> For fentry, bpf_get_func_ret() is not allowed to be called. For fsession,
> I think the best way is that we allow to call bpf_get_func_ret() in the
> "bpf_fsession_is_return() =3D=3D true"  branch, and prohibit it in
> "bpf_fsession_is_return() =3D=3D false" branch. However, we need to track
> such condition in verifier, which will make things complicated. So
> I think we can allow the usage of bpf_get_func_ret() in fsession and
> make sure it will always get zero in the fsession-fentry for now.

yeah, that's fine. and assembly complication is not that big, just
zero out a slot on the stack, right? I think it's fine.

>
> Thanks!
> Menglong Dong
>
> >
> > >
> > > 2. clear all the session cookies' value in the stack. If we can make =
sure
> > >    that the reading to session cookie can only be done after initiali=
ze in
> > >    the verifier, we don't need this anymore.
> > >
> > > 2. store the index of the cookie to ctx[-1] before the calling to fse=
ssion
> > >
> > > 3. store the "is_return" flag to ctx[-1] before the calling to fexit =
of
> > >    the fsession.
> > >
> > > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > > Co-developed-by: Leon Hwang <leon.hwang@linux.dev>
> > > Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> > > ---
> > > v4:
> > > - some adjustment to the 1st patch, such as we get the fsession prog =
from
> > >   fentry and fexit hlist
> > > - remove the supporting of skipping fexit with fentry return non-zero
> > >
> > > v2:
> > > - add session cookie support
> > > - add the session stuff after return value, instead of before nr_args
> > > ---
> > >  arch/x86/net/bpf_jit_comp.c | 36 +++++++++++++++++++++++++++++++----=
-
> > >  1 file changed, 31 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.=
c
> > > index 8cbeefb26192..99b0223374bd 100644
> > > --- a/arch/x86/net/bpf_jit_comp.c
> > > +++ b/arch/x86/net/bpf_jit_comp.c
> > > @@ -3086,12 +3086,17 @@ static int emit_cond_near_jump(u8 **pprog, vo=
id *func, void *ip, u8 jmp_cond)
> > >  static int invoke_bpf(const struct btf_func_model *m, u8 **pprog,
> > >                       struct bpf_tramp_links *tl, int stack_size,
> > >                       int run_ctx_off, bool save_ret,
> > > -                     void *image, void *rw_image)
> > > +                     void *image, void *rw_image, u64 nr_regs)
> > >  {
> > >         int i;
> > >         u8 *prog =3D *pprog;
> > >
> > >         for (i =3D 0; i < tl->nr_links; i++) {
> > > +               if (tl->links[i]->link.prog->call_session_cookie) {
> > > +                       /* 'stack_size + 8' is the offset of nr_regs =
in stack */
> > > +                       emit_st_r0_imm64(&prog, nr_regs, stack_size +=
 8);
> > > +                       nr_regs -=3D (1 << BPF_TRAMP_M_COOKIE);
> >
> > you have to rename nr_regs to something more meaningful because it's
> > so weird to see some bit manipulations with *number of arguments*
> >
> > > +               }
> > >                 if (invoke_bpf_prog(m, &prog, tl->links[i], stack_siz=
e,
> > >                                     run_ctx_off, save_ret, image, rw_=
image))
> > >                         return -EINVAL;
> > > @@ -3208,8 +3213,9 @@ static int __arch_prepare_bpf_trampoline(struct=
 bpf_tramp_image *im, void *rw_im
> > >                                          struct bpf_tramp_links *tlin=
ks,
> > >                                          void *func_addr)
> > >  {
> > > -       int i, ret, nr_regs =3D m->nr_args, stack_size =3D 0;
> > > -       int regs_off, nregs_off, ip_off, run_ctx_off, arg_stack_off, =
rbx_off;
> > > +       int i, ret, nr_regs =3D m->nr_args, cookie_cnt, stack_size =
=3D 0;
> > > +       int regs_off, nregs_off, ip_off, run_ctx_off, arg_stack_off, =
rbx_off,
> > > +           cookie_off;
> >
> > if it doesn't fit on a single line, just `int cookie_off;` on a
> > separate line, why wrap the line?
> >
> > >         struct bpf_tramp_links *fentry =3D &tlinks[BPF_TRAMP_FENTRY];
> > >         struct bpf_tramp_links *fexit =3D &tlinks[BPF_TRAMP_FEXIT];
> > >         struct bpf_tramp_links *fmod_ret =3D &tlinks[BPF_TRAMP_MODIFY=
_RETURN];
> >
> > [...]
> >
>
>
>
>

