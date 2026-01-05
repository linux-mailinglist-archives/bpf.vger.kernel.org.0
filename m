Return-Path: <bpf+bounces-77876-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 54252CF574A
	for <lists+bpf@lfdr.de>; Mon, 05 Jan 2026 21:03:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA6D93092825
	for <lists+bpf@lfdr.de>; Mon,  5 Jan 2026 20:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A433531AA92;
	Mon,  5 Jan 2026 20:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E5KOezfG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C612256C84
	for <bpf@vger.kernel.org>; Mon,  5 Jan 2026 20:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767643349; cv=none; b=Unjtk5ieA4th5EGTgxlwQw95+L9ke9iiy4nm7RwKZ4L+v1RC24f0RPIysoMiarc+92YvmxVIxqb31OqfuvuDIkLkK0VPOJHG9Gs7TlyXVvaWnYMpooWbUqy2VdYNXEy82eX9XkKMGyezvce5L+slCxUUNNVQ8XNiDHbbSjdeHS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767643349; c=relaxed/simple;
	bh=YQegPKcrMegEgLOVkMKugSgpWYEmPKvwTHFMUlsTBjc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J23mgDVQ/bIhKM4oRbxJyEdciu5UhOiaegsUO+ziBQU22ezhzbuiJGQddCROV176zT0J9WeM8HHr8uVNvk+WVPAP/2bVTaIAy+A/nbJ8kXkg/EpIRkuk/jNxgFA8cm0gvTJFVZ+uGxdJqEaqm2G7tduMoIMcUxx1KMWHitzcLtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E5KOezfG; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47775fb6c56so2627935e9.1
        for <bpf@vger.kernel.org>; Mon, 05 Jan 2026 12:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767643346; x=1768248146; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nDlwYF2Xh46taUcCYeQ6K3i+m7OgRE8a63amvp2cLqM=;
        b=E5KOezfGj3gP2oWNLagJavAea6J6hk54Kd6YXFrzfqK0NcrdKvDVAIn53MH75lRNJ1
         g7+/VepC9SR3zAaCTZF3ZF4m8OirYnBLFt8w712C0RSoXJkQzH+ciRlclweTTFnitOfq
         NT+13tGziITLENv5dEkjbWZkbizHoM9Rj4NBn6cqSbAaWTF9rq/mgKi6Vt6jZAP2sdAo
         0zqNyXV9TVKIA8kpGvFiF6o7fz0ae0bC5aqUQhDJGMOMp1wctZMVps+vYS1yu0DIB745
         X2nfRAZrtqPpMRZliJpWmaSjNLGE0Sm1Kdb7x95W4TSA5rgnWV2q3DC2eP/V/MQidmWk
         FcYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767643346; x=1768248146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nDlwYF2Xh46taUcCYeQ6K3i+m7OgRE8a63amvp2cLqM=;
        b=UG09VP2PXxrkQPuoAYxY2KB6S9T9BjMCMbBYOswoadhbqo2BZuB8CbLLwW8ehkj8yA
         PGO8hBhOQd/na1UDSvytcfS+iINxDwF9Nm3Ukal0CuBtF9Vd4ovsEhvQhMeagytLa6vO
         mJVYTZ4pX47GCbnOfkwukdKqdNmgF757CeNC/Q/KxsNK6q++cYW+u7O8FHn5Hh/t1mnx
         KDUBoPyTsGFVLv5c9PE2tgahRZ+sn3N76NSYgOgwNkm5mkcyqIS/WRz28e8lFWxY5ojc
         GgsNU8kIA3RidcYLoaBRqpsTidRarW6n1LkSmxrTGCcSdUpUZyEEL4s9LRKQs7xHvnNY
         21Sg==
X-Forwarded-Encrypted: i=1; AJvYcCWD77/4xxx9ia7w3ITzSqhPyBt6eR7+OmJ7bjnKwMsCSUHxAgLlGRe/KRZ5v1r2cUpveXM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYmUds3kN+gUHNbu/m79cIYRTaT+7vTqbt259ch7xHmz3KU8op
	axanOqDIMCMXwyBGzTofCf9puP7wd3lzSDm2+CgwUqXQE2OHfO8YTfgqjtOgKTSdZNmtQLcFPJl
	3lt3ufWE78Yy5zP1TIzMeu0FMKjtRFww=
X-Gm-Gg: AY/fxX4ryQEJlEDVVhfaFMTr7ZiBd7scf4uRnc54VmA9An7h0j0gCTBhKsJGLpFVo9J
	hAo7WfGrY50C/cwDbAfbM3LPm0qCGKfSDX1oHMUc03tSV3mU4iJWTB3usB/UlR5peDVpLlxKlk9
	A4rrf4uL6d8Rjepk/q08bwm4MIL4dj+pJCcTvFeCudjiiHwWan4PWvIe4K+Eor0FaYDJ4YdmMqv
	aw9GPtSGbx+ZmGywxLDNOegkhLWfPzkf4Bv4OhkfCAnh0jZTA3G+Juv2tU15S+oZy1wZ67R2XTV
	4/8IG2Wr3vdgjjRCulpHxkBJ73kS
X-Google-Smtp-Source: AGHT+IHOnAg/ShTG5AnQyQZ1FnOjL633CK7YbUZ/C/RRFmc6h8tN7ObCBxJ3Km5eFhRyY44j7FfPae+CWlYu2VzgYIY=
X-Received: by 2002:a05:6000:178f:b0:42f:bc61:d1bd with SMTP id
 ffacd0b85a97d-432bca525d4mr1214985f8f.45.1767643345605; Mon, 05 Jan 2026
 12:02:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260105-skb-meta-safeproof-netdevs-rx-only-v2-0-a21e679b5afa@cloudflare.com>
 <20260105-skb-meta-safeproof-netdevs-rx-only-v2-15-a21e679b5afa@cloudflare.com>
 <CAADnVQJbGosoXOCdyi=NZar966FVibKYobBgQ9BiyEH3=-HOsw@mail.gmail.com> <CAMB2axPivi+mZOXie=VnJM8nscqkHDjSrKT=Dhp5z_copEwxLQ@mail.gmail.com>
In-Reply-To: <CAMB2axPivi+mZOXie=VnJM8nscqkHDjSrKT=Dhp5z_copEwxLQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 5 Jan 2026 12:02:14 -0800
X-Gm-Features: AQt7F2qM8D-DQgNbBk6KF3eJYStgwWlZZnJYNEuUw080W31rVtOLsWe26-INukE
Message-ID: <CAADnVQJ_hwMM0F-Fm=ELbk0-5q_AojRAjs_CyWKEjv9NdfJsQw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 15/16] bpf: Realign skb metadata for TC progs
 using data_meta
To: Amery Hung <ameryhung@gmail.com>
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

On Mon, Jan 5, 2026 at 11:43=E2=80=AFAM Amery Hung <ameryhung@gmail.com> wr=
ote:
>
> On Mon, Jan 5, 2026 at 11:14=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon, Jan 5, 2026 at 4:15=E2=80=AFAM Jakub Sitnicki <jakub@cloudflare=
.com> wrote:
> > >
> > >
> > > +__bpf_kfunc_start_defs();
> > > +
> > > +__bpf_kfunc void bpf_skb_meta_realign(struct __sk_buff *skb_)
> > > +{
> > > +       struct sk_buff *skb =3D (typeof(skb))skb_;
> > > +       u8 *meta_end =3D skb_metadata_end(skb);
> > > +       u8 meta_len =3D skb_metadata_len(skb);
> > > +       u8 *meta;
> > > +       int gap;
> > > +
> > > +       gap =3D skb_mac_header(skb) - meta_end;
> > > +       if (!meta_len || !gap)
> > > +               return;
> > > +
> > > +       if (WARN_ONCE(gap < 0, "skb metadata end past mac header")) {
> > > +               skb_metadata_clear(skb);
> > > +               return;
> > > +       }
> > > +
> > > +       meta =3D meta_end - meta_len;
> > > +       memmove(meta + gap, meta, meta_len);
> > > +       skb_shinfo(skb)->meta_end +=3D gap;
> > > +
> > > +       bpf_compute_data_pointers(skb);
> > > +}
> > > +
> > > +__bpf_kfunc_end_defs();
> > > +
> > > +BTF_KFUNCS_START(tc_cls_act_hidden_ids)
> > > +BTF_ID_FLAGS(func, bpf_skb_meta_realign)
> > > +BTF_KFUNCS_END(tc_cls_act_hidden_ids)
> > > +
> > > +BTF_ID_LIST_SINGLE(bpf_skb_meta_realign_ids, func, bpf_skb_meta_real=
ign)
> > > +
> > >  static int tc_cls_act_prologue(struct bpf_insn *insn_buf, u32 pkt_ac=
cess_flags,
> > >                                const struct bpf_prog *prog)
> > >  {
> > > -       return bpf_unclone_prologue(insn_buf, pkt_access_flags, prog,
> > > -                                   TC_ACT_SHOT);
> > > +       struct bpf_insn *insn =3D insn_buf;
> > > +       int cnt;
> > > +
> > > +       if (pkt_access_flags & PA_F_DATA_META_LOAD) {
> > > +               /* Realign skb metadata for access through data_meta =
pointer.
> > > +                *
> > > +                * r6 =3D r1; // r6 will be "u64 *ctx"
> > > +                * r0 =3D bpf_skb_meta_realign(r1); // r0 is undefine=
d
> > > +                * r1 =3D r6;
> > > +                */
> > > +               *insn++ =3D BPF_MOV64_REG(BPF_REG_6, BPF_REG_1);
> > > +               *insn++ =3D BPF_CALL_KFUNC(0, bpf_skb_meta_realign_id=
s[0]);
> > > +               *insn++ =3D BPF_MOV64_REG(BPF_REG_1, BPF_REG_6);
> > > +       }
> >
> > I see that we already did this hack with bpf_qdisc_init_prologue()
> > and bpf_qdisc_reset_destroy_epilogue().
> > Not sure why we went that route back then.
> >
> > imo much cleaner to do BPF_EMIT_CALL() and wrap
> > BPF_CALL_1(bpf_skb_meta_realign, struct sk_buff *, skb)
> >
> > BPF_CALL_x doesn't make it an uapi helper.
> > It's still a hidden kernel function,
> > while this kfunc stuff looks wrong, since kfunc isn't really hidden.
> >
> > I suspect progs can call this bpf_skb_meta_realign() explicitly,
> > just like they can call bpf_qdisc_init_prologue() ?
> >
>
> qdisc prologue and epilogue qdisc kfuncs should be hidden from users.
> The kfunc filter, bpf_qdisc_kfunc_filter(), determines what kfunc are
> actually exposed.

I see.

> BPF_CALL_x is simpler as there is no need for a kfunc filter to hide
> it. However, IMO for qdisc they don't make too much difference since
> bpf qdisc already needs the filter to limit .enqueue and .dequeue
> specific kfunc.
>
> Am I missing anything?

Just weird to have kfuncs that are not really kfunc.
A special bpf_qdisc_init_prologue_ids[] just to call it, etc
BPF_EMIT_CALL() is lower cognitive load.

