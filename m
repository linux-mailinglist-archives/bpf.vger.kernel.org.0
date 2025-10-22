Return-Path: <bpf+bounces-71845-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E70BBFE213
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 22:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02AF43A7BB0
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 20:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85DDC2F99A8;
	Wed, 22 Oct 2025 20:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lFf/IEyJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D4C2F7AD0
	for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 20:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761163962; cv=none; b=lGk+kUOXGvAY0wWy5RWe2G8f5kRiuyjq4q3Hq4yjgLKpKDbgcI6DmJuQEuLRLZloe9RG9arv8YKEvE+q35H0/BDhQe3JbKCbeddKmWruW4veK+l/hNkn7ANvB4lvSJQnpnA62n+9fT7DIxggweKM5EurMf71Vd4yyf2GTqcf2g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761163962; c=relaxed/simple;
	bh=MrWXo/oLbgS2qAu13/3zNn+8FTGKcN62GCJWKCwRbTE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kqxC3Ef9BaDu6Z2+0wzUKNhjwevyX6Tf1lg6yHF9aMaGelV/Sva/Ihpio6GnP2ZZzEzh+/Ni1y+4xKodcbbDKP61x7dUDReEbUMzVWHPi9vpRpl5bLcq3KUj6VUy1Yb36ECQieW9Mki4GUxCeoxxr4EF0ZDnfQdS6mMVQcYJVBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lFf/IEyJ; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-471193a9d9eso78985e9.2
        for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 13:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761163958; x=1761768758; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uimIWSCNOUTt2zhNzo5AJd1qUy6+31S1+/QwnAMbts4=;
        b=lFf/IEyJd/V0nXjuNc4zcl0mh4bgY0EZxlnWETa850BSjucg/+vo+noBzSGWX3jjp5
         xVkcbs/2qle4QOT00w3eVAXMH22s1yb3OdUOh2J4oGg2MxBSPAPb0ahc+ublTPnOReYW
         dPnj/fBymOdQBHlLxX1VdgufYahrAhbMx8Rq6TLFF/t1USROwdI7MzLfAT2t5T1w1Vj9
         25jaDK3w/zZ9rSzPnQEqhPXsayUL9Fg2Uo5TSCtokz3qw1IBzBvGV8oK2r643Ydn+Zje
         lx00C20OdqInrckFId6y4zFb2LkGOOPpYOlFZ1uZI9sgz9SyiMbEbCenlIAKxNGyMZAk
         Vaow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761163958; x=1761768758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uimIWSCNOUTt2zhNzo5AJd1qUy6+31S1+/QwnAMbts4=;
        b=uw+4rSWN4WuO/o73YDjwO5/AVNAtGFIscHdFUqbgrt/srPWW0TC7Gqy/Dq9T1w0SVu
         e31I7indDl1LIjAk2Aty1VNlfuKwzaLyKAWJaltylRX9gZWhWqTY/Q7zdFI4HCf3msgb
         Ia0WLblKnJ7i1yDKfzwNhW9Kl5SS1DOSItSN6t8DzA8watevcoDE0fcicyIueM2B9d3y
         8pirjKIrDrUd28kHKYbNeXOtEAVxwDQRILYYJQMUgsp6lotV+scx0LIu5gRoe4Qiq5XE
         hfbMyOfKUAnLwYMfpr7R3pZ9y0PCxYMSDw7WzP1mP3xzEnlMWFJNXZT7Pp3TBETvucSH
         zFdw==
X-Forwarded-Encrypted: i=1; AJvYcCWug/9nZKxdHeNV3zGzpbW0x/wOpS7+NTdm4476Jy5hUBYQ+lRCN77SXlxZNbmviY0UdC8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8Sx5+XALNj7KwC9lbNFckW6XsP9Ojzd6Exkq0TiNRPKRLC4lz
	pOXeFtcslBnpg2Zy1wRWzwXR95+htJdj7MEqU6ld5S4O+I2wF1D9DB91IWxVPKkPDUVOjqigkCZ
	+DIA/KRKWJ80XLf6ug39xYrVlhHWq4A0=
X-Gm-Gg: ASbGncuIdzwVn2qpkea6lFHq97f1BhzubI8F3tBC5ZKjDp9oc8XWx6rrTBaLTychuEf
	Kf09guCM9sM90FXwOAh8fTpADi0GTe4+e4lZ44pf1HD0GSXgpvWJjoo3/sFXJ1T93b1Ke33/M64
	O7lUU1xpCufYJ/LhEDP1ER1gipm8Hu+HtEA/7hN/52Riq2odsgFwGxq7x9LJ8pHYNxOoOHVw81v
	2CEDYhzQlA/IkbnGDp/NoeqSHOEKThiKaFowyKr1xWwXzHmxrc6zhaeeQCuYgZbdfbi0yqsSseP
	Nb3Z0OMNfNu7tj2JvHmPnRSfL0iO
X-Google-Smtp-Source: AGHT+IHailG3wn+qxyeo1hq00dJetf6nEsAebGE6LvCSSYbpG+jVkKCra1v4ENMBfRr/2am5zenhKGEwvNuw5DUaxw0=
X-Received: by 2002:a05:6000:2911:b0:3d2:9cbf:5b73 with SMTP id
 ffacd0b85a97d-42704d7ea6cmr12973901f8f.6.1761163958314; Wed, 22 Oct 2025
 13:12:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022164457.1203756-1-kafai.wan@linux.dev> <20251022164457.1203756-2-kafai.wan@linux.dev>
 <39af9321-fb9b-4cee-84f1-77248a375e85@linux.dev> <1d03174dfe2a7eab1166596c85a6b586a660dffc.camel@gmail.com>
In-Reply-To: <1d03174dfe2a7eab1166596c85a6b586a660dffc.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 22 Oct 2025 13:12:26 -0700
X-Gm-Features: AS18NWA2NaacmcwC62SmVtcNwC7UfHvr48VO3Rwz_BF3omM6GlV8vXoOuYBnblA
Message-ID: <CAADnVQKdMcOkkqNa3LbGWqsz9iHAODFSinokj6htbGi0N66h_Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Skip bounds adjustment for conditional
 jumps on same register
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, KaFai Wan <kafai.wan@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Paul Chaignon <paul.chaignon@gmail.com>, 
	Matan Shachnai <m.shachnai@gmail.com>, Luis Gerhorst <luis.gerhorst@fau.de>, colin.i.king@gmail.com, 
	Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Kaiyan Mei <M202472210@hust.edu.cn>, 
	Yinhao Hu <dddddd@hust.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 12:46=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Wed, 2025-10-22 at 11:14 -0700, Yonghong Song wrote:
> >
> > On 10/22/25 9:44 AM, KaFai Wan wrote:
> > > When conditional jumps are performed on the same register (e.g., r0 <=
=3D r0,
> > > r0 > r0, r0 < r0) where the register holds a scalar with range, the v=
erifier
> > > incorrectly attempts to adjust the register's min/max bounds. This le=
ads to
> > > invalid range bounds and triggers a BUG warning:
> > >
> > > verifier bug: REG INVARIANTS VIOLATION (true_reg1): range bounds viol=
ation u64=3D[0x1, 0x0] s64=3D[0x1, 0x0] u32=3D[0x1, 0x0] s32=3D[0x1, 0x0] v=
ar_off=3D(0x0, 0x0)
> > > WARNING: CPU: 0 PID: 93 at kernel/bpf/verifier.c:2731 reg_bounds_sani=
ty_check+0x163/0x220
> > > Modules linked in:
> > > CPU: 0 UID: 0 PID: 93 Comm: repro-x-3 Tainted: G        W           6=
.18.0-rc1-ge7586577b75f-dirty #218 PREEMPT(full)
> > > Tainted: [W]=3DWARN
> > > Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1.16.=
3-debian-1.16.3-2 04/01/2014
> > > RIP: 0010:reg_bounds_sanity_check+0x163/0x220
> > > Call Trace:
> > >   <TASK>
> > >   reg_set_min_max.part.0+0x1b1/0x360
> > >   check_cond_jmp_op+0x1195/0x1a60
> > >   do_check_common+0x33ac/0x33c0
> > >   ...
> > >
> > > The issue occurs in reg_set_min_max() function where bounds adjustmen=
t logic
> > > is applied even when both registers being compared are the same. Comp=
aring a
> > > register with itself should not change its bounds since the compariso=
n result
> > > is always known (e.g., r0 =3D=3D r0 is always true, r0 < r0 is always=
 false).
> > >
> > > Fix this by adding an early return in reg_set_min_max() when false_re=
g1 and
> > > false_reg2 point to the same register, skipping the unnecessary bound=
s
> > > adjustment that leads to the verifier bug.
> > >
> > > Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
> > > Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
> > > Closes: https://lore.kernel.org/all/1881f0f5.300df.199f2576a01.Corema=
il.kaiyanm@hust.edu.cn/
> > > Fixes: 0df1a55afa83 ("bpf: Warn on internal verifier errors")
> > > Signed-off-by: KaFai Wan <kafai.wan@linux.dev>
> > > ---
> > >   kernel/bpf/verifier.c | 4 ++++
> > >   1 file changed, 4 insertions(+)
> > >
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index 6d175849e57a..420ad512d1af 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -16429,6 +16429,10 @@ static int reg_set_min_max(struct bpf_verifi=
er_env *env,
> > >     if (false_reg1->type !=3D SCALAR_VALUE || false_reg2->type !=3D S=
CALAR_VALUE)
> > >             return 0;
> > >
> > > +   /* If conditional jumps on the same register, skip the adjustment=
 */
> > > +   if (false_reg1 =3D=3D false_reg2)
> > > +           return 0;
> >
> > Your change looks good. But this is a special case and it should not
> > happen for any compiler generated code. So could you investigate
> > why regs_refine_cond_op() does not work? Since false_reg1 and false_reg=
2
> > is the same, so register refinement should keep the same. Probably
> > some minor change in regs_refine_cond_op(...) should work?
> >
> > > +
> > >     /* fallthrough (FALSE) branch */
> > >     regs_refine_cond_op(false_reg1, false_reg2, rev_opcode(opcode), i=
s_jmp32);
> > >     reg_bounds_sync(false_reg1);
>
> I think regs_refine_cond_op() is not written in a way to handle same
> registers passed as reg1 and reg2. E.g. in this particular case the
> condition is reformulated as "r0 < r0", and then the following branch
> is taken:
>
>    static void regs_refine_cond_op(struct bpf_reg_state *reg1, struct bpf=
_reg_state *reg2,
>                                  u8 opcode, bool is_jmp32)
>    {
>         ...
>          case BPF_JLT: // condition is rephrased as r0 < r0
>                  if (is_jmp32) {
>                          ...
>                  } else {
>                          reg1->umax_value =3D min(reg1->umax_value, reg2-=
>umax_value - 1);
>                          reg2->umin_value =3D max(reg1->umin_value + 1, r=
eg2->umin_value);
>                  }
>                  break;
>         ...
>    }
>
> Note that intent is to adjust umax of the LHS (reg1) register and umin
> of the RHS (reg2) register. But here it ends up adjusting the same regist=
er.
>
> (a) before refinement: u64=3D[0x0, 0x80000000] s64=3D[0x0, 0x80000000] u3=
2=3D[0x0, 0x80000000] s32=3D[0x80000000, 0x0]
> (b) after  refinement: u64=3D[0x1, 0x7fffffff] s64=3D[0x0, 0x80000000] u3=
2=3D[0x0, 0x80000000] s32=3D[0x80000000, 0x0]
> (c) after  sync      : u64=3D[0x1, 0x0] s64=3D[0x1, 0x0] u32=3D[0x1, 0x0]=
 s32=3D[0x1, 0x0]
>
> At (b) the u64 range translated to s32 is > 0, while s32 range is <=3D 0,
> hence the invariant violation.
>
> I think it's better to move the reg1 =3D=3D reg2 check inside
> regs_refine_cond_op(), or to handle this case in is_branch_taken().

hmm. bu then regs_refine_cond_op() will skip it, yet reg_set_min_max()
will still be doing pointless work with reg_bounds_sync() and sanity check.
The current patch makes more sense to me.

