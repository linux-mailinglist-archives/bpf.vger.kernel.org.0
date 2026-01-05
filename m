Return-Path: <bpf+bounces-77886-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E27AACF5B5A
	for <lists+bpf@lfdr.de>; Mon, 05 Jan 2026 22:47:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0B5EE300EDB4
	for <lists+bpf@lfdr.de>; Mon,  5 Jan 2026 21:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89A5311946;
	Mon,  5 Jan 2026 21:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XROA+U9K"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E41A3101C6
	for <bpf@vger.kernel.org>; Mon,  5 Jan 2026 21:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767649651; cv=none; b=F6mx/E3cd9PGVvEQvpV5Ph0SA0/tyjmpeyvR40MwAZCR/dZs1zDlAZlL6TBXs05ENw9yG0hQ8WF5HcYRa3Tu1DWifv7lDpJo+8AFP8AbDhYnDyksO+BGXr58qS2dpXf7oY0ICPpBwAXZFcfNXdHOBdxcJMN95NPa7GVVjE0gXmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767649651; c=relaxed/simple;
	bh=qM1B9p/5IU0Ae7tEVMl3F0TO7zTjn4dRquCSdiD9Eoo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fPGMNUTZAjd6pPDekO353+GqS5CgPocR0ruOo46ODPUwU91EYGmPxZc1d7rZpCkn3I4aSIYnSBFwkgaONagvOO2AlmwGxokn0rc6wH9Ne35kEyT21LYyIFNkA3RPDzOZN8+XMCVa7YjkNJ7XpF2XtYuKgl7QaNFVcHoQSrerMQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XROA+U9K; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43260a5a096so194729f8f.0
        for <bpf@vger.kernel.org>; Mon, 05 Jan 2026 13:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767649648; x=1768254448; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cTTD7iyccpWiIa9PfLHfnFVUKadxKYnWZzPs73FN+wc=;
        b=XROA+U9KjY+MODHLCpXFdnZHLAtdz236eTHNPld4HrgeCgXOHYiouRS+S4qqdcvCx4
         4z5Q7skq/glomBVsH0bEIH3RBwDuf3HtVEHnEp7vOVM+f0O23N36vE6GGH89noMdp/zX
         bBBtZquppx517g1coeq76PEGd1SukCqxUYnJfCamA9CPSd1htFhsqQnqraYzbIx4K5h9
         Gr9y7a0XKOiKAc+frPX2DuLzDqtgTl5KYfas1OrQY0gmP1avPoSbKxoCtF83W3YoeEal
         683zE08CY0LGhqM8+ocsQ36QAgSyBnVkAHCbwHn2ZqUebJ/z1/bpyYdbkEfUT3A6P6Cz
         pXcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767649648; x=1768254448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cTTD7iyccpWiIa9PfLHfnFVUKadxKYnWZzPs73FN+wc=;
        b=HDEuiLnqokp9zzIGmOCXzi9va3Nd8H7XRuLs17rLvKZY0XamqMQFEVpCBHweO0L6Ue
         vk/zvvdOBhlsi8QcD/DXy5JiOeNLmfV8dzvPctdC46pb9C5v18Y/5yvK8Biz5WeTKZDF
         uE8DzeMcL0sU46Z8FkKMJaP+0tYVQRIASLWz5jL/Pgmozh53E3mzBxHxEF7vBIhZG/c2
         hJUGPcVhsu0T7fZlnEX8spG5N9hz/7jttaCp86SD9SRH1hQUlvITzJzuT43ATUSQhvAt
         PBZNlReqPwqYpT5nyHHSvendE0u1Z9HInSp5DBlUtwU8J5yURHSOLGnlPLwD4pw2XHpl
         JbsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBpH+vee+WQHo09tDjCXzxaxFGMZ4b3PtqKSh3pqT26b9GRA3NIHyhYuxutQu5Fgl6j34=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkeU8kxOdfdGdytg2x4pvwcVsGJk7laYLXSzQNJJndaqpqxfHr
	Em3127IrZzKt2zPhbtajhhczZuzxEnHxTyMqoZeLn/rErhrubdq9MnIOt0qwnsA77aW6GT+vyHY
	74TX6AyCYlQS+yem75PY1iyaO6zoatxs=
X-Gm-Gg: AY/fxX5f96KyDWxD8dWaqkgSN+AP23uJKUKnVgQn2WprcQb34etCVTpDz2agCAM3lNE
	xMftKsspIxXIXUqOCk1yQyVvUAyPwS5NARK0qfItpaDcsmOpDGiAO1A/y+vbFX6w1vVgA16nd48
	Vq0dxdh0OmHh4d1AjI0qyGqPNxo2pcXlDTI4BH9XYhwjF32by6mTQk+NfMjL4MhLNH8P8aVabyK
	WA6YMXAzI6pQVyHjQN4eQ9r8xRtmaStPaWhusCRmJPZpnW2fzLMjrPE8cWhyc6UiTDToYTCdJbP
	N3LRzButAmDkuf7wDXkv++ObbcRN
X-Google-Smtp-Source: AGHT+IHRNLXcqHWBcMprz3rQXt49jSbfW+beSjoy1/f6KZrC9ix/HWRrPMAuLI1g7BTof2V3aX2XakzPU/cFLgS7Xe0=
X-Received: by 2002:a05:6000:3108:b0:42b:3b62:cd86 with SMTP id
 ffacd0b85a97d-432bca18987mr1309690f8f.6.1767649647539; Mon, 05 Jan 2026
 13:47:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260105-skb-meta-safeproof-netdevs-rx-only-v2-0-a21e679b5afa@cloudflare.com>
 <20260105-skb-meta-safeproof-netdevs-rx-only-v2-15-a21e679b5afa@cloudflare.com>
 <CAADnVQJbGosoXOCdyi=NZar966FVibKYobBgQ9BiyEH3=-HOsw@mail.gmail.com>
 <CAMB2axPivi+mZOXie=VnJM8nscqkHDjSrKT=Dhp5z_copEwxLQ@mail.gmail.com> <e969a85c-94eb-4cb5-a7ac-524a16ccce01@linux.dev>
In-Reply-To: <e969a85c-94eb-4cb5-a7ac-524a16ccce01@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 5 Jan 2026 13:47:16 -0800
X-Gm-Features: AQt7F2rdjlSyN4qFfp63S5pz7wqdp9Ujg0XhM9kloQzz_9bsqHM6ukfRg475F2g
Message-ID: <CAADnVQKB5vRJM4kJC5515snR6KHweE-Ld_W1wWgPSWATgiUCwg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 15/16] bpf: Realign skb metadata for TC progs
 using data_meta
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Amery Hung <ameryhung@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Simon Horman <horms@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 5, 2026 at 12:55=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
>
>
> On 1/5/26 11:42 AM, Amery Hung wrote:
> > On Mon, Jan 5, 2026 at 11:14=E2=80=AFAM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> >>
> >> On Mon, Jan 5, 2026 at 4:15=E2=80=AFAM Jakub Sitnicki <jakub@cloudflar=
e.com> wrote:
> >>>
> >>>
> >>> +__bpf_kfunc_start_defs();
> >>> +
> >>> +__bpf_kfunc void bpf_skb_meta_realign(struct __sk_buff *skb_)
> >>> +{
> >>> +       struct sk_buff *skb =3D (typeof(skb))skb_;
> >>> +       u8 *meta_end =3D skb_metadata_end(skb);
> >>> +       u8 meta_len =3D skb_metadata_len(skb);
> >>> +       u8 *meta;
> >>> +       int gap;
> >>> +
> >>> +       gap =3D skb_mac_header(skb) - meta_end;
> >>> +       if (!meta_len || !gap)
> >>> +               return;
> >>> +
> >>> +       if (WARN_ONCE(gap < 0, "skb metadata end past mac header")) {
> >>> +               skb_metadata_clear(skb);
> >>> +               return;
> >>> +       }
> >>> +
> >>> +       meta =3D meta_end - meta_len;
> >>> +       memmove(meta + gap, meta, meta_len);
> >>> +       skb_shinfo(skb)->meta_end +=3D gap;
> >>> +
> >>> +       bpf_compute_data_pointers(skb);
> >>> +}
> >>> +
> >>> +__bpf_kfunc_end_defs();
> >>> +
> >>> +BTF_KFUNCS_START(tc_cls_act_hidden_ids)
> >>> +BTF_ID_FLAGS(func, bpf_skb_meta_realign)
> >>> +BTF_KFUNCS_END(tc_cls_act_hidden_ids)
> >>> +
> >>> +BTF_ID_LIST_SINGLE(bpf_skb_meta_realign_ids, func, bpf_skb_meta_real=
ign)
> >>> +
> >>>   static int tc_cls_act_prologue(struct bpf_insn *insn_buf, u32 pkt_a=
ccess_flags,
> >>>                                 const struct bpf_prog *prog)
> >>>   {
> >>> -       return bpf_unclone_prologue(insn_buf, pkt_access_flags, prog,
> >>> -                                   TC_ACT_SHOT);
> >>> +       struct bpf_insn *insn =3D insn_buf;
> >>> +       int cnt;
> >>> +
> >>> +       if (pkt_access_flags & PA_F_DATA_META_LOAD) {
> >>> +               /* Realign skb metadata for access through data_meta =
pointer.
> >>> +                *
> >>> +                * r6 =3D r1; // r6 will be "u64 *ctx"
> >>> +                * r0 =3D bpf_skb_meta_realign(r1); // r0 is undefine=
d
> >>> +                * r1 =3D r6;
> >>> +                */
> >>> +               *insn++ =3D BPF_MOV64_REG(BPF_REG_6, BPF_REG_1);
> >>> +               *insn++ =3D BPF_CALL_KFUNC(0, bpf_skb_meta_realign_id=
s[0]);
> >>> +               *insn++ =3D BPF_MOV64_REG(BPF_REG_1, BPF_REG_6);
> >>> +       }
> >>
> >> I see that we already did this hack with bpf_qdisc_init_prologue()
> >> and bpf_qdisc_reset_destroy_epilogue().
> >> Not sure why we went that route back then.
> >>
> >> imo much cleaner to do BPF_EMIT_CALL() and wrap
> >> BPF_CALL_1(bpf_skb_meta_realign, struct sk_buff *, skb)
> >>
> >> BPF_CALL_x doesn't make it an uapi helper.
> >> It's still a hidden kernel function,
> >> while this kfunc stuff looks wrong, since kfunc isn't really hidden.
> >>
> >> I suspect progs can call this bpf_skb_meta_realign() explicitly,
> >> just like they can call bpf_qdisc_init_prologue() ?
> >>
> >
> > qdisc prologue and epilogue qdisc kfuncs should be hidden from users.
> > The kfunc filter, bpf_qdisc_kfunc_filter(), determines what kfunc are
> > actually exposed.
>
> Similar to Amery's comment, I recalled I tried the BPF_CALL_1 in the
> qdisc but stopped at the "fn =3D env->ops->get_func_proto(insn->imm,
> env->prog);" in do_misc_fixups(). Potentially it could add new enum ( >
> __BPF_FUNC_MAX_ID) outside of the uapi and the user space tool should be
> able to handle unknown helper also but we went with the kfunc+filter
> approach without thinking too much about it.

hmm. BPF_EMIT_CALL() does:
#define BPF_CALL_IMM(x) ((void *)(x) - (void *)__bpf_call_base)
.imm   =3D BPF_CALL_IMM(FUNC)

the imm shouldn't be going through validation anymore.
none of the if (insn->imm =3D=3D BPF_FUNC_...) in do_misc_fixups()
will match, so I think I see the path where get_func_proto() is
called.
But how does it work then for all cases of BPF_EMIT_CALL?
All of them happen after do_misc_fixups() ?

I guess we can mark such emitted call in insn_aux_data as finalized
and get_func_proto() isn't needed.

