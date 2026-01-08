Return-Path: <bpf+bounces-78248-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D1930D05F11
	for <lists+bpf@lfdr.de>; Thu, 08 Jan 2026 20:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34632303D8A7
	for <lists+bpf@lfdr.de>; Thu,  8 Jan 2026 19:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8F22D131D;
	Thu,  8 Jan 2026 19:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="ZQRqA9uG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06D92E9729
	for <bpf@vger.kernel.org>; Thu,  8 Jan 2026 19:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767902104; cv=none; b=F1U5WDSp4JRtDUoPcY9zLix8GMWMgRBRZ31DPyBc4/LKvry8gpQjemOk7AxUt/orEwPM5hrquZ4NRlEjD3JzdW/we3LrsZrPZpm/1c41qJ/XR0JX3k7C8XAOm9wu49D+qeSF+0vguaV9JCXd9A/TnGlJgKT6bKgH0E5u6YDkq2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767902104; c=relaxed/simple;
	bh=Ueg/uK/VwM5WDV0ZDNriuLOQACaUCKN531srjWgt3zE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nMWqmbSStwyq13QqqFYdM06Rcp2kYRJK/5c7gFrCkHx03Xzc3+wN45xp2V6AhnaG8qhZmDYvGPENZDYYGe2BbhAm2abQeZZKwG+QmO2nzKWjlUVVCw+7lsXCz/KLNubBZ2NM0BjXLooYmkh+Sm2FJE+f1P4CZQ9DT0TajjiP7o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=ZQRqA9uG; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b8018eba13cso589950766b.1
        for <bpf@vger.kernel.org>; Thu, 08 Jan 2026 11:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1767902101; x=1768506901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2qTtzY0pedb8FPcFYKSts+tG++byprdDKwKSqO61Ikk=;
        b=ZQRqA9uGARNYXSClLL17q6bUBAra/UGrsZdUMr4DNG1ITAjWFQQWmXcsFaZMVUNzKT
         auuC5ZqbVEWugktW3P5Wwd2Wevqx2yr3wDLqrXGBs2CiKf1BVl3f4iM0+U943tXWmT1h
         xW6olu5tq7fS9iplfpp6tcBkBDzy+naR14DZTZhRRL0+qI80EMU2K8CMWtdJ22J1TSIs
         7d+62GlY4zIp6lCXwiAkVhcEmsGwIUOmmp4aVS9RopL1ATrCoIssmpfwQ9jei5vx/p2A
         SgtNGe1+Nnyy8WM7aHb5WCAUNaoppc+ihpLy6q8olF4gYZlH4kc/FGeYyvn/JDKVohfp
         koVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767902101; x=1768506901;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2qTtzY0pedb8FPcFYKSts+tG++byprdDKwKSqO61Ikk=;
        b=EvZkO7FiJk4ijIb/ZJefAsimqF+ltXF+DSjnaR6qyQ5Q/ErC8umLVfpKFcA29lmEix
         dGN1Fbri+yPmVGkveZS0lPkRmIx5SO9G2IvrlduDyiUp1x6zakLcQLItqKn3zhuDOkF7
         GEOa1dxvAk+TP3xYTRH6GoydCZTLkouPDqIJRc+oWszXEh/CN0NlsVCnIpGlTlsrAgcA
         VJaic9sWl9EIYelc+B7vg3Bf5SzWPAIO1vqkzTPSEqyIO0WbwKpNZKXpW33hrkxWkraD
         eHWy46B0vdIzP8s1JaHYE0p7LK02vkyT9L3MFI3vpfK5WTGKfswfJ9fg/G5fCnWqzomm
         nWgA==
X-Gm-Message-State: AOJu0YyaLzVZadtXiGyIZDBjqOX03wqdbcgPd+t3qPvdgVDQP744h9jM
	5J8Bt4JcNM2zX7Pfz9ACSGXCsZGWXNGpAtKxjr6pCAmbXUjuy6YHSer9BTHuO6Dctwk=
X-Gm-Gg: AY/fxX7KsqutWHSQipZ05CUaK8cC3MVCgb0ZVb8q2MN0egUP0PnwX+U6ZOa3y8vtRgI
	KJwuOAwdJNGmdsSjbf4/ZuXFk82TV2tEGPEgYd/pILXHkZ72Tq75SkgWwubWzEuyVsuUZ0zTiAj
	YF4nNB+bJIrCQM2WhCe8whorg677u9LcRUkmJ13uI/XoBoPwAW6JJjbjSAntc5m3wjnJBSvqLeZ
	td6bFq3aDPwztfc7xju9/BYWm9yfMgMcnS/rZlct4EGT8pH1OhutBMJDY76c/s2ryU7rCEbygQE
	SpXdPP4MkV4vqFb57tSIS45X4TucOF7ADFN1++G3nEeglNJAzvfJuAE/LjLRdyONE8IR/60STMS
	SqXB4u9bswOCAAgJJOM/peOea3kve4enBhXHRgo9CxsY4P8o142DLVQnYIqJWD8WYvqNBAF+rQh
	BepsY=
X-Google-Smtp-Source: AGHT+IGhZGXqwlpY9isjdOemIgVTeM/DYdQfqUAtffSLUH2xxZWs2oDNQhiU+XuXBvoM7kC4/ooa4w==
X-Received: by 2002:a17:907:9483:b0:b80:3101:cd13 with SMTP id a640c23a62f3a-b8444d4eb13mr844347166b.10.1767902096178;
        Thu, 08 Jan 2026 11:54:56 -0800 (PST)
Received: from cloudflare.com ([2a09:bac5:5063:2969::420:14])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a511829sm883889566b.51.2026.01.08.11.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 11:54:55 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>,  Network Development
 <netdev@vger.kernel.org>,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo
 Abeni <pabeni@redhat.com>,  Alexei Starovoitov <ast@kernel.org>,  Daniel
 Borkmann <daniel@iogearbox.net>,  Jesper Dangaard Brouer
 <hawk@kernel.org>,  John Fastabend <john.fastabend@gmail.com>,  Stanislav
 Fomichev <sdf@fomichev.me>,  Simon Horman <horms@kernel.org>,  Andrii
 Nakryiko <andrii@kernel.org>,  Martin KaFai Lau <martin.lau@linux.dev>,
  Eduard Zingerman <eddyz87@gmail.com>,  Song Liu <song@kernel.org>,
  Yonghong Song <yonghong.song@linux.dev>,  KP Singh <kpsingh@kernel.org>,
  Hao Luo <haoluo@google.com>,  Jiri Olsa <jolsa@kernel.org>,  kernel-team
 <kernel-team@cloudflare.com>
Subject: Re: [PATCH bpf-next v3 16/17] bpf: Realign skb metadata for TC
 progs using data_meta
In-Reply-To: <CAADnVQKR9Myx_ervEzNihoWm=6=_B4LebPhPezm9rOSReE1bjQ@mail.gmail.com>
	(Alexei Starovoitov's message of "Wed, 7 Jan 2026 14:01:12 -0800")
References: <20260107-skb-meta-safeproof-netdevs-rx-only-v3-0-0d461c5e4764@cloudflare.com>
	<20260107-skb-meta-safeproof-netdevs-rx-only-v3-16-0d461c5e4764@cloudflare.com>
	<CAADnVQKR9Myx_ervEzNihoWm=6=_B4LebPhPezm9rOSReE1bjQ@mail.gmail.com>
Date: Thu, 08 Jan 2026 20:54:54 +0100
Message-ID: <87a4ynj2wh.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 07, 2026 at 02:01 PM -08, Alexei Starovoitov wrote:
> On Wed, Jan 7, 2026 at 6:28=E2=80=AFAM Jakub Sitnicki <jakub@cloudflare.c=
om> wrote:
>>
>>
>> +static void bpf_skb_meta_realign(struct sk_buff *skb)
>> +{
>> +       u8 *meta_end =3D skb_metadata_end(skb);
>> +       u8 meta_len =3D skb_metadata_len(skb);
>> +       u8 *meta;
>> +       int gap;
>> +
>> +       gap =3D skb_mac_header(skb) - meta_end;
>> +       if (!meta_len || !gap)
>> +               return;
>> +
>> +       if (WARN_ONCE(gap < 0, "skb metadata end past mac header")) {
>> +               skb_metadata_clear(skb);
>> +               return;
>> +       }
>> +
>> +       meta =3D meta_end - meta_len;
>> +       memmove(meta + gap, meta, meta_len);
>> +       skb_shinfo(skb)->meta_end +=3D gap;
>> +
>> +       bpf_compute_data_pointers(skb);
>> +}
>> +
>>  static int tc_cls_act_prologue(struct bpf_insn *insn_buf, u32 pkt_acces=
s_flags,
>>                                const struct bpf_prog *prog)
>>  {
>> -       return bpf_unclone_prologue(insn_buf, pkt_access_flags, prog,
>> -                                   TC_ACT_SHOT);
>> +       struct bpf_insn *insn =3D insn_buf;
>> +       int cnt;
>> +
>> +       if (pkt_access_flags & PA_F_DATA_META_LOAD) {
>> +               /* Realign skb metadata for access through data_meta poi=
nter.
>> +                *
>> +                * r6 =3D r1; // r6 will be "u64 *ctx"
>> +                * r0 =3D bpf_skb_meta_realign(r1); // r0 is undefined
>> +                * r1 =3D r6;
>> +                */
>> +               BUILD_BUG_ON(!__same_type(&bpf_skb_meta_realign,
>> +                                         (void (*)(struct sk_buff *))NU=
LL));
>> +               *insn++ =3D BPF_MOV64_REG(BPF_REG_6, BPF_REG_1);
>> +               *insn++ =3D BPF_EMIT_CALL(bpf_skb_meta_realign);
>
> Not quite. drop this BUILD_BUG_ON(), since it's pointless and misleading.

Will do.

> bpf_skb_meta_realign() has to be the one done with BPF_CALL_1(...).
> Otherwise above will work only on x86.
> In this case on arm64 too, but it's by accident.
> BPF_CALL* has to do ABI conversion from BPF to native.
>
> For kfuncs that's what JITs do via btf_func_model machinery.

Oh, 32-bit ARM has different register mapping. TIL. Thanks.

