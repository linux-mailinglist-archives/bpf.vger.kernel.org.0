Return-Path: <bpf+bounces-48243-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EEB5A05C34
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 13:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B359E166237
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 12:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27281FBEBE;
	Wed,  8 Jan 2025 12:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eFE2ZSta"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015381FAC55;
	Wed,  8 Jan 2025 12:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736340974; cv=none; b=ga7MBRil/tJkVKnapPL89Vyi/a7U4dYPA4uG19jgkEbpZkwST60SgGqQ1XIsizysB0B2XwFM2QzqA3bV5P9GFvWlH5IU92m+q3l6DCeuqFR/5aKuxzzf9MVy/1d9zSJbN55eOwcHocpn1brog43MCspueaGTyEUVV2Jj3x1gQHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736340974; c=relaxed/simple;
	bh=+1j5w+JfGT72QlMnSnMY5Oj3UpNFXN8sM+qcSVL7a+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r6lsD/k/hSfI1Fn2tQpBqFvQtvg6Kv5bJ/euSHZDfeN/dfRvZkJEuLXrpWWlGH9g1tuU6izGOJbOa15CNuwuh0InyttzCd3R1hYKnTnCeDVJdtMZ1LQHrrYoHzVTVexdF1NADC7UgW3EXMRa0+HUTjz4euRI6h8+V5Jt3M0Ac4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eFE2ZSta; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3ce34c6872aso12956835ab.0;
        Wed, 08 Jan 2025 04:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736340972; x=1736945772; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OOE9h383brC/b0A3meevzuXiFDFz9fGXg4qk3JWFePM=;
        b=eFE2ZStatsjnKXef0U+CwXFqgd7xncfoYpQknbZXGZIBF+3Ap2jOoDN+BaD353DJKR
         CfmMbGEbm+uV4lpJhNrq3lX1ndQWUJzOUrBDB3EFgvq1utzeP8IQo+kWGOxFOGnc8EWZ
         ftHLjd3eMNT9CHGrrlTN6cKcf59PTHLrrAigSsl91BnEV4fVv0TDsQFtgl7hc9/7eqyp
         C/41v4g+EMAtMyus8uluw542la7h5eRvTwroQp/UtZT7HDhHajFqaz04/fVuMzvdEk6E
         CCAaagoVnAP92oK4G73gcjbDKXTAZSgisQMQ1azhHjQ21/L4SKgzhhz56M/XxHwJvMI9
         BwEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736340972; x=1736945772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OOE9h383brC/b0A3meevzuXiFDFz9fGXg4qk3JWFePM=;
        b=nGudDI/adhJCpAh93ZyPaaPSAqfps3QpBkOEPsCvlVFX4NN2YGUqS9ktcCx/3MQGBq
         uAJUrD4m80dkucyRGCeKtOeeQ7EWeTrufsuIiTAHljCGbMe8RMkcTZkMpcMoXVeURjdH
         6/YoOez6Fde0dumwuM5jdeBevGMUCOvjiBtbyA2P4fniIsVjhGSXXf6mTBHFBxrkrvkz
         UyFN2j+G2taktX8aA+iWEiNJW346KxcZoWkVthcypDpt58AYUBvtEn4j264BOEAtJawp
         juSDUZQM/7iXbxBQi0+jE+IrVdbyIjBLzxMnDytEwI2IN1a6IAHLEjRUJGh8cWt4tZPs
         MwsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPpLXz4APjMCTSmIKs27lrXy3acwzR4F3yI9rjFm3NSPkWEfqcXzkwhkbgOEAJP2HVciK9oRrf@vger.kernel.org, AJvYcCXrJCzO0tAqAJCom0e+J56f/Ga7xvRAUEqjVzfFZkC7fO/ZflLE72o/zkFUY1UxGGISJZs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3uHsEuA7VEWXYbsRrx+nFjRGOANLIuKwL2dFJCtDPnadqSVQy
	2JCdATy2o3QzUKWxUg6cROUN3DT2tUla6Gs9+CDeTkkqqeBv8u7yd/hywRjuyFSoFXR5dfogz+2
	HTBsqXIqtF0VOcdH8WgqVAkxZkaE=
X-Gm-Gg: ASbGnctc3CogSUd7kBKqW+gw0zSVU+7rpWI+kWA9Glm3e27WH6KpnqwxiCKXTuwA+xa
	sf+MAbz0lTpMNBW0eK9ZxNHvliStiMrq0Q9wvkA==
X-Google-Smtp-Source: AGHT+IGG2gRUuzH9rGrzuYgrxE/qM+xeXkVOEjQ8p4fQWSOXgTFZKiSbISLanw1IWkdo8DyxHcMwJXb9c9EcPW6MS1k=
X-Received: by 2002:a05:6e02:87:b0:3a6:c98d:86bc with SMTP id
 e9e14a558f8ab-3ce3a86a258mr25970525ab.1.1736340972098; Wed, 08 Jan 2025
 04:56:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241207173803.90744-1-kerneljasonxing@gmail.com>
 <20241207173803.90744-11-kerneljasonxing@gmail.com> <9f5081bb-ed66-4171-acef-786ae02cf69c@linux.dev>
 <CAL+tcoCSrBBaW3Rg1hD0mBAGu_ZTCTfjVBGe_7B=_JB+uJTuYA@mail.gmail.com>
In-Reply-To: <CAL+tcoCSrBBaW3Rg1hD0mBAGu_ZTCTfjVBGe_7B=_JB+uJTuYA@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 8 Jan 2025 20:55:35 +0800
X-Gm-Features: AbW1kvYhVYhZ8EU6wthVz9LPDRg5NV1LSEpGlvLf7LFhPMKFsbyTRF2f5zmvZGM
Message-ID: <CAL+tcoB7bxkXoUdZiVr2kXkZO0DHV3uZe2=JP2mHjGGy+T5WGQ@mail.gmail.com>
Subject: Re: [PATCH net-next v4 10/11] net-timestamp: export the tskey for TCP
 bpf extension
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com, 
	willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 8, 2025 at 12:21=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> Hi Martin,
>
> > > -     bpf_skops_tx_timestamping(sk, skb, op, 2, args);
> > > +     if (sk_is_tcp(sk))
> > > +             args[2] =3D skb_shinfo(skb)->tskey;
> >
> > Instead of only passing one info "skb_shinfo(skb)->tskey" of a skb, pas=
s the
> > whole skb ptr to the bpf prog. Take a look at bpf_skops_init_skb. Lets =
start
> > with end_offset =3D 0 for now so that the bpf prog won't use it to read=
 the
> > skb->data. It can be revisited later.
> >
> >         bpf_skops_init_skb(&sock_ops, skb, 0);
> >
> > The bpf prog can use bpf_cast_to_kern_ctx() and bpf_core_cast() to get =
to the
> > skb_shinfo(skb). Take a look at the md_skb example in type_cast.c.
>
> In recent days, I've been working on this part. It turns out to be
> infeasible to pass "struct __sk_buff *skb" as the second parameter in
> skops_sockopt() in patch [11/11]. I cannot find a way to acquire the
> skb itself, sorry for that :(
>
> IIUC, there are three approaches to fetch the tskey:
> 1. Like what I wrote in this patchset, passing the tskey to bpf prog
> through calling __cgroup_bpf_run_filter_sock_ops() is simple and
> enough.
> 2. Considering future usability, I feel I can add skb_head, skb_end
> fields in sock_ops_convert_ctx_access().
> 3. Only adding a new field tskey like skb_hwtstamp in
> sock_ops_convert_ctx_access()

After considering those approaches over and over again, I think this
#3 is more suitable [1]. It can be aligned with other usages, say,
skb_hwtstamp. Normally, only temporary variables are passed through
calling __cgroup_bpf_run_filter_sock_ops(). Then we don't need to
worry about breakages on skb because of safety issues. Well, how about
this draft as below?

[1] diff patch
+       case offsetof(struct bpf_sock_ops, tskey): {
+               struct bpf_insn *jmp_on_null_skb;
+
+               *insn++ =3D BPF_LDX_MEM(BPF_FIELD_SIZEOF(struct bpf_sock_op=
s_kern,
+                                                      skb),
+                                     si->dst_reg, si->src_reg,
+                                     offsetof(struct bpf_sock_ops_kern,
+                                              skb));
+               /* Reserve one insn to test skb =3D=3D NULL */
+               jmp_on_null_skb =3D insn++;
+               insn =3D bpf_convert_shinfo_access(si->dst_reg,
si->dst_reg, insn);
+               *insn++ =3D BPF_LDX_MEM(BPF_DW, si->dst_reg, si->dst_reg,
+                                     bpf_target_off(struct skb_shared_info=
,
+                                                    tskey, 4,
+                                                    target_size));
+               *jmp_on_null_skb =3D BPF_JMP_IMM(BPF_JEQ, si->dst_reg, 0,
+                                              insn - jmp_on_null_skb - 1);
+               break;
+       }

