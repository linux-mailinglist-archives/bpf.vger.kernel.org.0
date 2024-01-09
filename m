Return-Path: <bpf+bounces-19243-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DF9827C47
	for <lists+bpf@lfdr.de>; Tue,  9 Jan 2024 01:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 665D51C2332E
	for <lists+bpf@lfdr.de>; Tue,  9 Jan 2024 00:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B738ECE;
	Tue,  9 Jan 2024 00:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mp6h5EtZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81610A49
	for <bpf@vger.kernel.org>; Tue,  9 Jan 2024 00:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-50e80d14404so3099022e87.1
        for <bpf@vger.kernel.org>; Mon, 08 Jan 2024 16:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704761532; x=1705366332; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IxcbsXqVzWvR1aamaPhJX2ckMz7XwOUQTUQKASRJUm0=;
        b=Mp6h5EtZKZgUdMG2GRfzBFhtu7TFq7ih8t87BgXFoXhfPx1mxgP9oz1wq8d+kXjvW/
         qwVRedxcmbEXxy9MHUN9DF3J67mhrrdXsJ4zvUyiJkfywGZBEFe/2uHTsW5OFvgDzH/9
         g9Q3DaJCDHpH6NMnFdFlDrDcRIwjsXoA2Jm5eIP3BpUMKOHuzsJSmNwDUqd3S9VMBYPv
         QmqB2LcXWmV1tqn3Jez07Fiz51DIp6t6XyXiP6Lh4Ou5IN4KblQX39ggz1ts/gfj99a5
         qAHVDd0EXnPE8Vo7DZVvNY6L6iQ90Oi1SSrA4LBkmZhY4eZk8xYviDya9IPoaJdqTRY/
         86dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704761532; x=1705366332;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IxcbsXqVzWvR1aamaPhJX2ckMz7XwOUQTUQKASRJUm0=;
        b=d6wGvCwDs2i3ywXhOQvKxL7y61udtql8DlaCZKrQZqb6aKdp+OFpd7YpZPNcepmFIV
         Y57IlWlGlobciEqehglW9Gwch6Rwwq9wEymBUXk/8/KJGrca3vL66sHcJ+5ipEKNEtMA
         yCikEDPfqsbSAWrvkTCQEv1rL/iC4F8jDBKIS7w1RjIrjXMXUtyJlcBV6ltnw/EEWp0Q
         EQf5WQD40YVxyOBP2Z6gCAadSVRwhlvZQDX+hd/PkaukmBg6H3BRKAoBHgDJPXgvTxlm
         Z7f/RyPcM2sVhuFrWDrQ+oJBv0BEOBoByU3Wd66G2xoK5VzVTupUeEJAcc/NM78MC9QO
         Y6sA==
X-Gm-Message-State: AOJu0YwYdCQXjBJklDfLO8JbH7Y53RJXIcGhaI7LAAofWue67jBWLWU6
	WUpIxFM+b3zgQl8Jn/yflSE=
X-Google-Smtp-Source: AGHT+IGv0F4SUYqKLh0lOAPeQbrDtToTSczgLZ9xjOtURptdXnLwh7HZlJymIbQWfLmwe54fRFtI8w==
X-Received: by 2002:ac2:5205:0:b0:50e:7fe1:1ae with SMTP id a5-20020ac25205000000b0050e7fe101aemr265444lfl.28.1704761532300;
        Mon, 08 Jan 2024 16:52:12 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id a11-20020a056512020b00b0050eae170e04sm127175lfo.81.2024.01.08.16.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 16:52:11 -0800 (PST)
Message-ID: <30a5c5b913af04d645f1b8d504892704e6be920b.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/3] bpf: simplify try_match_pkt_pointers()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev,  zenczykowski@gmail.com
Date: Tue, 09 Jan 2024 02:52:10 +0200
In-Reply-To: <CAEf4Bzb5NNWRroWtg5cRy4FUV8-AhrRbsd7_D12F3SJu7hTcqw@mail.gmail.com>
References: <20240108132802.6103-1-eddyz87@gmail.com>
	 <20240108132802.6103-2-eddyz87@gmail.com>
	 <CAEf4Bzb5NNWRroWtg5cRy4FUV8-AhrRbsd7_D12F3SJu7hTcqw@mail.gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-01-08 at 16:40 -0800, Andrii Nakryiko wrote:
[...]
> > @@ -14684,90 +14687,31 @@ static bool try_match_pkt_pointers(const stru=
ct bpf_insn *insn,
> >         if (BPF_CLASS(insn->code) =3D=3D BPF_JMP32)
> >                 return false;
> >=20
> > -       switch (BPF_OP(insn->code)) {
> > +       if (dst_reg->type =3D=3D PTR_TO_PACKET_END ||
> > +           src_reg->type =3D=3D PTR_TO_PACKET_META) {
> > +               swap(src_reg, dst_reg);
> > +               dst_regno =3D insn->src_reg;
> > +               opcode =3D flip_opcode(opcode);
> > +       }
> > +
> > +       if ((dst_reg->type !=3D PTR_TO_PACKET ||
> > +            src_reg->type !=3D PTR_TO_PACKET_END) &&
> > +           (dst_reg->type !=3D PTR_TO_PACKET_META ||
> > +            !reg_is_init_pkt_pointer(src_reg, PTR_TO_PACKET)))
> > +               return false;
>=20
> this inverted original condition just breaks my brain, I can't wrap my
> head around it :) I think the original is easier to reason about
> because it's two clear allowable patterns for which we do something. I
> understand that this early exit reduces nestedness, but at least for
> me it would be simpler to have the original non-inverted condition
> with a nested switch.

I'm not sure I understand what you mean by nested switch.
If I write it down like below, would that be more clear?

	bool pkt_data_vs_pkt_end;
    bool pkt_meta_vs_pkt_data;
    ...
    pkt_data_vs_pkt_end =3D
      dst_reg->type =3D=3D PTR_TO_PACKET && src_reg->type =3D=3D PTR_TO_PAC=
KET_END;
    pkt_meta_vs_pkt_data =3D
      dst_reg->type =3D=3D PTR_TO_PACKET_META && reg_is_init_pkt_pointer(sr=
c_reg, PTR_TO_PACKET);

    if (!pkt_data_vs_pkt_end && !pkt_meta_vs_pkt_data)
        return false;

> > +
> > +       switch (opcode) {
> >         case BPF_JGT:
> > -               if ((dst_reg->type =3D=3D PTR_TO_PACKET &&
> > -                    src_reg->type =3D=3D PTR_TO_PACKET_END) ||
> > -                   (dst_reg->type =3D=3D PTR_TO_PACKET_META &&
> > -                    reg_is_init_pkt_pointer(src_reg, PTR_TO_PACKET))) =
{
> > -                       /* pkt_data' > pkt_end, pkt_meta' > pkt_data */
> > -                       find_good_pkt_pointers(this_branch, dst_reg,
> > -                                              dst_reg->type, false);
> > -                       mark_pkt_end(other_branch, insn->dst_reg, true)=
;

> it seems like you can make a bit of simplification if mark_pkt_end
> would just accept struct bpf_reg_state * instead of int regn (you
> won't need to keep track of dst_regno at all, right?)

mark_pkt_end() changes the register from either this_branch or other_branch=
.
I can introduce local pointers dst_this/dst_other and swap those,
but I'm not sure it's worth it.

[...]

