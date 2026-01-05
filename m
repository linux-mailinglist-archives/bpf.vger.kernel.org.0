Return-Path: <bpf+bounces-77875-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D943CF569F
	for <lists+bpf@lfdr.de>; Mon, 05 Jan 2026 20:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8D5B30C9E50
	for <lists+bpf@lfdr.de>; Mon,  5 Jan 2026 19:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9222730F958;
	Mon,  5 Jan 2026 19:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iYxeF15x"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983FB316910
	for <bpf@vger.kernel.org>; Mon,  5 Jan 2026 19:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767642182; cv=none; b=KnyOpT8vf7PSIxv1f52+Iy2pAgB/qCV8Ha4SPmnamEHZrwniNPvZULIoR58bVERMm3OYVMDydZhpZL6pttm9gS/EfU0b/r0WjbptKXUapURxUdNyOoH0r6LXqZioP0NheYCmyF04cswFtcnPDLxCFz1bhH3N1BNJobHJUuqSEeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767642182; c=relaxed/simple;
	bh=tl4yQffvgxGdZmRSpUbHXbJ/dmu7OJcv/QnxToqdlGM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uVwTj1ZlbEJgNd206mNtyaijUduWcLhKY4cDIVZakujkDLHUJkHY0vZ2DpsokuxIdwrhE91ZPiBUd9L83CFeoaWiZssO0TvGi90U2KXp4i0KyvC7fmrebffY+pClAEQOGjLcBJXCVVlOySIvwOHIQFxN1euzSaDvnNco85M3iyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iYxeF15x; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-78e7ba9fc29so3489127b3.2
        for <bpf@vger.kernel.org>; Mon, 05 Jan 2026 11:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767642179; x=1768246979; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+mrkxe7BYJrbUG9VL9usF0IG+8MmlOIkDUFETZfczR4=;
        b=iYxeF15xubeXX47QQvdGG04tkq8suzWtiTyWnTjYkRr+m/qw0TBLMqQlgwqG6ULmiE
         h4+8Zg3qNClXIDVlspP5GiwOr1YodgYUGT5NcT+ckBernWyP7dj1GXJBcVxt+4UMbFDK
         dG2gTeuWizPfzEA2D5L/UfF9b7Z+GEj87NZ6qIPafIiDvajLabEcxDkRby0D1YLWh8XQ
         TZMzL88V+HIb+QcLxaIYH9UdIlnJt8wwprr0f7H469jJh3QhhIKqn8+9zUChdDDBkjwa
         6gsThbFDxV23fMna4O9Cp9qsfgwkBnpnun6mqmBJUfnQv0ERzXm00+WOVjG7B/9nG3Wc
         ww1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767642179; x=1768246979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+mrkxe7BYJrbUG9VL9usF0IG+8MmlOIkDUFETZfczR4=;
        b=ChhTpMN7WPo4vl5aefZbsaUOtfcrWK9J1p6Lh0C1QcyilHrAy1mppMvpPHjIottFmZ
         9MSUV1j0nBjqEnQouDKV5dT6DhlbyBdmV3dz/26vygCcbKFnJvpHqotTmAD7c/BeEmlO
         dTBHWzG12DgeZhizArTUt9HMmLLPuR/R9hQrbDUZRfqCab7HvqU+cO4froPTAZN6Tm78
         wlPOStyFRPAYwOcuAmeB5x5THPfHT4q9Jf9QQtJ9g4+49ejginlE6i/TmLJ4ls6CG4t9
         onJsVDQXmaYH1eKhFLn11kH+CbWn7YM5pQtgBXN5u2i+sD0b/3l4zF3SVqlcgNtQnuj0
         TAIw==
X-Forwarded-Encrypted: i=1; AJvYcCWWXxMv2PywLVDMyBA6th3JUJvNolsnfO8sXoC8jMfgeDAnZWeWfYN3OW4Z/4tXC0iAt5o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaFZVhSCEpO6d1ZtY4Tde7n4wjPrCuDVOksyAcD7T7yDxlsSUP
	Tv1pFtMZgD+5KjpzCsDjq15Wn1mEVVyKWEd1KREA3TnZkmUAy30ifxfAl5chCVv1fETn3FJwZ0x
	tc7JUQT8l/zkWwYqhnU06cHZhLellc/4=
X-Gm-Gg: AY/fxX4GYfdHDvehyWyrSNg4G4W8Jy7iONVSXp4VdDH5M1Oy+4GdhGfjq+h26wISxaq
	KKId8/AAqZGXb5wei2iyL+h+ZbMEpMYm/614i3i+AfFWMq2TL2z3putpdLpVNnYQCGEHxx1MBKB
	rGy6FJUqXS2avZjroyueKOExFLKPHn62INyNAArRhOvE0yTY2gP+cgap546QzBJMZzW2DOiRP91
	9zmpAIKoPK6Fe4nkROWHx0F4SWwc1FM725VaiQTBWE+3bT2tWwY31DKCFhnsIFRobFjXLU8AMiH
	M15vWjxlGkY=
X-Google-Smtp-Source: AGHT+IG/NYDYd+ZOX6tyZHNVFBT0iR5qG4RB/CU93M6h+v42LY76jzVLfwh68OB6eRmaUzXDXKljVkp9E3a+lvJ3NLs=
X-Received: by 2002:a05:690c:6c08:b0:78c:5803:f68e with SMTP id
 00721157ae682-790a8b05445mr7136867b3.33.1767642179469; Mon, 05 Jan 2026
 11:42:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260105-skb-meta-safeproof-netdevs-rx-only-v2-0-a21e679b5afa@cloudflare.com>
 <20260105-skb-meta-safeproof-netdevs-rx-only-v2-15-a21e679b5afa@cloudflare.com>
 <CAADnVQJbGosoXOCdyi=NZar966FVibKYobBgQ9BiyEH3=-HOsw@mail.gmail.com>
In-Reply-To: <CAADnVQJbGosoXOCdyi=NZar966FVibKYobBgQ9BiyEH3=-HOsw@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Mon, 5 Jan 2026 11:42:48 -0800
X-Gm-Features: AQt7F2o2oyknP5HTulKJdQt1jIluI1P7SyHSg748rfubHpCmePZopyd7L_QvF30
Message-ID: <CAMB2axPivi+mZOXie=VnJM8nscqkHDjSrKT=Dhp5z_copEwxLQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 15/16] bpf: Realign skb metadata for TC progs
 using data_meta
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Jakub Sitnicki <jakub@cloudflare.com>, Martin KaFai Lau <martin.lau@kernel.org>, 
	bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Simon Horman <horms@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 5, 2026 at 11:14=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Jan 5, 2026 at 4:15=E2=80=AFAM Jakub Sitnicki <jakub@cloudflare.c=
om> wrote:
> >
> >
> > +__bpf_kfunc_start_defs();
> > +
> > +__bpf_kfunc void bpf_skb_meta_realign(struct __sk_buff *skb_)
> > +{
> > +       struct sk_buff *skb =3D (typeof(skb))skb_;
> > +       u8 *meta_end =3D skb_metadata_end(skb);
> > +       u8 meta_len =3D skb_metadata_len(skb);
> > +       u8 *meta;
> > +       int gap;
> > +
> > +       gap =3D skb_mac_header(skb) - meta_end;
> > +       if (!meta_len || !gap)
> > +               return;
> > +
> > +       if (WARN_ONCE(gap < 0, "skb metadata end past mac header")) {
> > +               skb_metadata_clear(skb);
> > +               return;
> > +       }
> > +
> > +       meta =3D meta_end - meta_len;
> > +       memmove(meta + gap, meta, meta_len);
> > +       skb_shinfo(skb)->meta_end +=3D gap;
> > +
> > +       bpf_compute_data_pointers(skb);
> > +}
> > +
> > +__bpf_kfunc_end_defs();
> > +
> > +BTF_KFUNCS_START(tc_cls_act_hidden_ids)
> > +BTF_ID_FLAGS(func, bpf_skb_meta_realign)
> > +BTF_KFUNCS_END(tc_cls_act_hidden_ids)
> > +
> > +BTF_ID_LIST_SINGLE(bpf_skb_meta_realign_ids, func, bpf_skb_meta_realig=
n)
> > +
> >  static int tc_cls_act_prologue(struct bpf_insn *insn_buf, u32 pkt_acce=
ss_flags,
> >                                const struct bpf_prog *prog)
> >  {
> > -       return bpf_unclone_prologue(insn_buf, pkt_access_flags, prog,
> > -                                   TC_ACT_SHOT);
> > +       struct bpf_insn *insn =3D insn_buf;
> > +       int cnt;
> > +
> > +       if (pkt_access_flags & PA_F_DATA_META_LOAD) {
> > +               /* Realign skb metadata for access through data_meta po=
inter.
> > +                *
> > +                * r6 =3D r1; // r6 will be "u64 *ctx"
> > +                * r0 =3D bpf_skb_meta_realign(r1); // r0 is undefined
> > +                * r1 =3D r6;
> > +                */
> > +               *insn++ =3D BPF_MOV64_REG(BPF_REG_6, BPF_REG_1);
> > +               *insn++ =3D BPF_CALL_KFUNC(0, bpf_skb_meta_realign_ids[=
0]);
> > +               *insn++ =3D BPF_MOV64_REG(BPF_REG_1, BPF_REG_6);
> > +       }
>
> I see that we already did this hack with bpf_qdisc_init_prologue()
> and bpf_qdisc_reset_destroy_epilogue().
> Not sure why we went that route back then.
>
> imo much cleaner to do BPF_EMIT_CALL() and wrap
> BPF_CALL_1(bpf_skb_meta_realign, struct sk_buff *, skb)
>
> BPF_CALL_x doesn't make it an uapi helper.
> It's still a hidden kernel function,
> while this kfunc stuff looks wrong, since kfunc isn't really hidden.
>
> I suspect progs can call this bpf_skb_meta_realign() explicitly,
> just like they can call bpf_qdisc_init_prologue() ?
>

qdisc prologue and epilogue qdisc kfuncs should be hidden from users.
The kfunc filter, bpf_qdisc_kfunc_filter(), determines what kfunc are
actually exposed.

BPF_CALL_x is simpler as there is no need for a kfunc filter to hide
it. However, IMO for qdisc they don't make too much difference since
bpf qdisc already needs the filter to limit .enqueue and .dequeue
specific kfunc.

Am I missing anything?

> cc Amery, Martin.
>

