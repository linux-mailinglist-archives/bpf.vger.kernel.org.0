Return-Path: <bpf+bounces-78166-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 20025D00445
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 23:03:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A64C301A1F3
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 22:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384912FE060;
	Wed,  7 Jan 2026 22:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="To8+gMxo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6932F361B
	for <bpf@vger.kernel.org>; Wed,  7 Jan 2026 22:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767823286; cv=none; b=rZL3jqkHd/xQACmkqcUT9h39hZVWmQowPtvTymsMr90ERPBgUBfhB4+a8jVDDPGL5S/yX92wVWeeJyiDnwA8tDAktcJ7esZiItRIm2T54ZeFEF4a6esW5fZdHWPmm19pgRQWZRcYSJo7Yvy7RL4wZdwcrmUMc6QLccUEq0yYP8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767823286; c=relaxed/simple;
	bh=YYrgN1/4b3uYrEh9czfhj31efOuWQwyB0QIyz0KcNhQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MgZxXFeeqIpz8VE5WfkbfQZYPjCRJzjkIzpatLLSKGCwgwcZNUUZJPVXz+0F17W+Ld3SLgAHboYJDKhJQGTIeDDgTKykWG89lTKmEAVRW+94bRX09yUxVX9MIi9tOSLU2Tre+vfNMpLSL9ruvQoDOfUAQkhvpeUnRjEc1rH1qe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=To8+gMxo; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-42fbad1fa90so2091697f8f.0
        for <bpf@vger.kernel.org>; Wed, 07 Jan 2026 14:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767823283; x=1768428083; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PbVOCVA3+xNf5U98se1N6HGmg+GeYqwwN9lCOLrIIo0=;
        b=To8+gMxobzuLscpw/eDYAGxxjrtwz9Oun/PI7aSPVNNC/FBK1deLZNK9+CveqpBgGr
         7g2+ydAjL+Xr6Lmn6n2PF+uLK8fB2/6TJem/pNY+H+5TVd7EqAgdTrKMZ/gL8EtI0T63
         St2tLgSQEyGX8dxi8FxvWWivZpJRSy0imDcO3aPMTzvXoyGWEDVYkY7/0+2VmNc3ymUV
         l5JEUiD+AZnm891H6nd+q2h05xPOglt0BgTh+ZR0ozID4qg/XI0mdGUIZZzKIhA7t7d0
         bzt5RrsxvbanZWWE5R2WImDhoY11IPOyspsbF77Ok6DoPy5PhTUA29srTIxLvlFk0MgA
         253g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767823283; x=1768428083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PbVOCVA3+xNf5U98se1N6HGmg+GeYqwwN9lCOLrIIo0=;
        b=BdCPRiS3xNyQTzC++tiMV9COkkp4J0hT3qWqwvNeCN0PMBCndWw1TJ6j/RlLkaP5U4
         3K/GKRN3nsAsTGt6B8O065DxCRaeNlivlqiYeMIrd5ZupvZtzOf9Vas14P1PxGUOpY43
         Wvj22OOt+4/LIkYVrOn+xGtlpE9FkJwSPL+cOSN1Z8/xqFKsxZa/2psLU50Y0InRTNcV
         G9eoAR8jcIqVCdiU1eLqKgmmHGdaqIgnGX/ys8SVkNj5eT0wEFbjHkOrENBL0PrN4GHa
         UWH0iCEG/CFqSYyz2DLeYz7G/5uRfgG6kZmI8OiNeykayIrosKJMGoUU4KokBa0MsoLo
         l81A==
X-Gm-Message-State: AOJu0YzKhj4dsX1oGQEVcx2smZAwMdmf7OYzXfpIIdzWMyzWFu4tL4g5
	gQ+b/hEglKKMw1eOW8pR4l5NaDvM5JAHzyzYauTPRkEqgG+W61x8SSaOnCBFiAxXKu9qb6ofO37
	U+KWXsItJHO+4tWTWscUJEY1phP7nepc=
X-Gm-Gg: AY/fxX6vIclmnYQQd3gm/47pLEqnpJepl3ShLv0PLNLoFTUOJxtdoylGP9QRiMXmwxX
	HFkD0k1Q53tn7awVUH8VweVaQIbcNmBC9T5Sy9EMoDz78SpSD5kyFCUfmkllDXzHhgt5LGV+DaY
	06EUDn01GheKWUrKAz41N2WzWvhWj5vqSRD/1ukLq9B20TowuNGzlXFN2TWQB8HwJGSP3qtTP//
	+y4t99LO3q85JToh6sCL2aZT3Yj0l6ZcL4WFUSkwzD7+ZryUpQQGeYn7fwFshr6MuA8qStvVbLt
	poyGd6RzWWbHTBp103EIuB4DeZa1
X-Google-Smtp-Source: AGHT+IEdyOPZbDPif6fAIcsc+jEyvHVzWI1qQCxKOJRLKNXGewKU26ff6NB16EAqwPwYvPeC/wTX3Z8ltq/NDljKPKQ=
X-Received: by 2002:a05:6000:2287:b0:431:5ac:1fc with SMTP id
 ffacd0b85a97d-432c3790890mr5108810f8f.14.1767823283308; Wed, 07 Jan 2026
 14:01:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260107-skb-meta-safeproof-netdevs-rx-only-v3-0-0d461c5e4764@cloudflare.com>
 <20260107-skb-meta-safeproof-netdevs-rx-only-v3-16-0d461c5e4764@cloudflare.com>
In-Reply-To: <20260107-skb-meta-safeproof-netdevs-rx-only-v3-16-0d461c5e4764@cloudflare.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 7 Jan 2026 14:01:12 -0800
X-Gm-Features: AQt7F2rZVzSbDVPQ7QFEgQKdB5_5SNHGgDXI0efgoxcd0dCh3XETY7iDFndTT_M
Message-ID: <CAADnVQKR9Myx_ervEzNihoWm=6=_B4LebPhPezm9rOSReE1bjQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 16/17] bpf: Realign skb metadata for TC progs
 using data_meta
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, 
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

On Wed, Jan 7, 2026 at 6:28=E2=80=AFAM Jakub Sitnicki <jakub@cloudflare.com=
> wrote:
>
>
> +static void bpf_skb_meta_realign(struct sk_buff *skb)
> +{
> +       u8 *meta_end =3D skb_metadata_end(skb);
> +       u8 meta_len =3D skb_metadata_len(skb);
> +       u8 *meta;
> +       int gap;
> +
> +       gap =3D skb_mac_header(skb) - meta_end;
> +       if (!meta_len || !gap)
> +               return;
> +
> +       if (WARN_ONCE(gap < 0, "skb metadata end past mac header")) {
> +               skb_metadata_clear(skb);
> +               return;
> +       }
> +
> +       meta =3D meta_end - meta_len;
> +       memmove(meta + gap, meta, meta_len);
> +       skb_shinfo(skb)->meta_end +=3D gap;
> +
> +       bpf_compute_data_pointers(skb);
> +}
> +
>  static int tc_cls_act_prologue(struct bpf_insn *insn_buf, u32 pkt_access=
_flags,
>                                const struct bpf_prog *prog)
>  {
> -       return bpf_unclone_prologue(insn_buf, pkt_access_flags, prog,
> -                                   TC_ACT_SHOT);
> +       struct bpf_insn *insn =3D insn_buf;
> +       int cnt;
> +
> +       if (pkt_access_flags & PA_F_DATA_META_LOAD) {
> +               /* Realign skb metadata for access through data_meta poin=
ter.
> +                *
> +                * r6 =3D r1; // r6 will be "u64 *ctx"
> +                * r0 =3D bpf_skb_meta_realign(r1); // r0 is undefined
> +                * r1 =3D r6;
> +                */
> +               BUILD_BUG_ON(!__same_type(&bpf_skb_meta_realign,
> +                                         (void (*)(struct sk_buff *))NUL=
L));
> +               *insn++ =3D BPF_MOV64_REG(BPF_REG_6, BPF_REG_1);
> +               *insn++ =3D BPF_EMIT_CALL(bpf_skb_meta_realign);

Not quite. drop this BUILD_BUG_ON(), since it's pointless and misleading.
bpf_skb_meta_realign() has to be the one done with BPF_CALL_1(...).
Otherwise above will work only on x86.
In this case on arm64 too, but it's by accident.
BPF_CALL* has to do ABI conversion from BPF to native.

For kfuncs that's what JITs do via btf_func_model machinery.

pw-bot: cr

