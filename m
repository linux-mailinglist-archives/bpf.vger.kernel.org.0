Return-Path: <bpf+bounces-19277-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B335828C83
	for <lists+bpf@lfdr.de>; Tue,  9 Jan 2024 19:23:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B4A528ED31
	for <lists+bpf@lfdr.de>; Tue,  9 Jan 2024 18:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEFC33D0A0;
	Tue,  9 Jan 2024 18:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ljEl57Hw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A466B3D3A7
	for <bpf@vger.kernel.org>; Tue,  9 Jan 2024 18:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-555f581aed9so3827861a12.3
        for <bpf@vger.kernel.org>; Tue, 09 Jan 2024 10:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704824545; x=1705429345; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xqwiqWtujMyHyFCnNVlraRVFvZ9Cndfb7DCgotFfpII=;
        b=ljEl57HweyTh+JdE4Y9FBHUfkdEdJ3Hr2eMYSa4vl6CbwPkkh+sdFrRfpeBsVy44h4
         rZA6er0p14o8zQmCa/FhIsVr+7RN4s3v3HDbhN25BE+CrT9Vr9D6D8RG01nMJM32Ad9C
         BTTrwRXTfLPH9cm60ASeO+6b0569P3YNvM/TQTEpat97FEJqr+Dp3VPTe7ZoHIPaIPCA
         mGTqKO41d80a2cCDFtVJpDo3OLo+YXHi4QFgYlndnkmiZGE2SqjiHv+1KYykl+rbNC74
         nxsVljKyt3CM18R5OKIZZUZfyyjkNWyOcQlD3wcyPXQc4qGlVyZJW/fkrI5bW6NJzSts
         O8GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704824545; x=1705429345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xqwiqWtujMyHyFCnNVlraRVFvZ9Cndfb7DCgotFfpII=;
        b=DPJh6lL4qoyhYLece6FFfUL+u1omgVQovAUZ7DkzwbQgCMOB39U3jT+Bqkpl8PruCl
         SMqM+NW7acWGywkRt7wLLBxGOr6GtkAZM7fR4j6DWYDhEdJ9IKGCrkp3HXIX4m/uGNdw
         lFZKi2/ZbUMFo7ZkwTiot9M/9KnH9RE+MtDUN7KOTOwGPc+OeCoZFSAVeKVY/BLTxFAJ
         41xYmOtrtp3pLwOOW4H9u/JWwC/QDpH608C+oKRQ/PFYtjOcDMcZ2VHOPIGzJkyDzfqg
         C72f51S5NS9GMCFdXUuJ1QNqgotH198+cqOJiIBOQtgjNUqfjoXCl7Ng7N39FTkSqmUm
         wcCA==
X-Gm-Message-State: AOJu0YxHnt3tDA59hvQezNXlmoQuDJqKgqLAqdof7qdiyYaTDTjfWxun
	drZTw41k4s49gMVREoptFXXDiQCbXjYKSW5Q8D4r3Jgd
X-Google-Smtp-Source: AGHT+IFA8vrPn1f6n7Lkg+oJ8LjMb+AIdD1RPT+tMmj9/Q5Cb2PkkZ7AtWh5Mn765rQpxcUhXCjLxiTi29PKY3FUihM=
X-Received: by 2002:a17:907:8687:b0:a28:e00:bf67 with SMTP id
 qa7-20020a170907868700b00a280e00bf67mr889068ejc.148.1704824544694; Tue, 09
 Jan 2024 10:22:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108132802.6103-1-eddyz87@gmail.com> <20240108132802.6103-2-eddyz87@gmail.com>
 <CAEf4Bzb5NNWRroWtg5cRy4FUV8-AhrRbsd7_D12F3SJu7hTcqw@mail.gmail.com> <30a5c5b913af04d645f1b8d504892704e6be920b.camel@gmail.com>
In-Reply-To: <30a5c5b913af04d645f1b8d504892704e6be920b.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 9 Jan 2024 10:22:12 -0800
Message-ID: <CAEf4BzYM-1uZecLuX3v=S=+mV9E7oUPD04MSn8O3oUyQC2vrQw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/3] bpf: simplify try_match_pkt_pointers()
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, zenczykowski@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 8, 2024 at 4:52=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Mon, 2024-01-08 at 16:40 -0800, Andrii Nakryiko wrote:
> [...]
> > > @@ -14684,90 +14687,31 @@ static bool try_match_pkt_pointers(const st=
ruct bpf_insn *insn,
> > >         if (BPF_CLASS(insn->code) =3D=3D BPF_JMP32)
> > >                 return false;
> > >
> > > -       switch (BPF_OP(insn->code)) {
> > > +       if (dst_reg->type =3D=3D PTR_TO_PACKET_END ||
> > > +           src_reg->type =3D=3D PTR_TO_PACKET_META) {
> > > +               swap(src_reg, dst_reg);
> > > +               dst_regno =3D insn->src_reg;
> > > +               opcode =3D flip_opcode(opcode);
> > > +       }
> > > +
> > > +       if ((dst_reg->type !=3D PTR_TO_PACKET ||
> > > +            src_reg->type !=3D PTR_TO_PACKET_END) &&
> > > +           (dst_reg->type !=3D PTR_TO_PACKET_META ||
> > > +            !reg_is_init_pkt_pointer(src_reg, PTR_TO_PACKET)))
> > > +               return false;
> >
> > this inverted original condition just breaks my brain, I can't wrap my
> > head around it :) I think the original is easier to reason about
> > because it's two clear allowable patterns for which we do something. I
> > understand that this early exit reduces nestedness, but at least for
> > me it would be simpler to have the original non-inverted condition
> > with a nested switch.
>
> I'm not sure I understand what you mean by nested switch.
> If I write it down like below, would that be more clear?
>

Yes, much more clear. What I had in mind was something like:

if (pkt_data_vs_pkt_end || pkt_meta_vs_pkt_data) {
    switch (opcode) {
        ...
    }
}

But what you have below is easy to follow as well


>         bool pkt_data_vs_pkt_end;
>     bool pkt_meta_vs_pkt_data;
>     ...
>     pkt_data_vs_pkt_end =3D
>       dst_reg->type =3D=3D PTR_TO_PACKET && src_reg->type =3D=3D PTR_TO_P=
ACKET_END;
>     pkt_meta_vs_pkt_data =3D
>       dst_reg->type =3D=3D PTR_TO_PACKET_META && reg_is_init_pkt_pointer(=
src_reg, PTR_TO_PACKET);
>
>     if (!pkt_data_vs_pkt_end && !pkt_meta_vs_pkt_data)
>         return false;
>
> > > +
> > > +       switch (opcode) {
> > >         case BPF_JGT:
> > > -               if ((dst_reg->type =3D=3D PTR_TO_PACKET &&
> > > -                    src_reg->type =3D=3D PTR_TO_PACKET_END) ||
> > > -                   (dst_reg->type =3D=3D PTR_TO_PACKET_META &&
> > > -                    reg_is_init_pkt_pointer(src_reg, PTR_TO_PACKET))=
) {
> > > -                       /* pkt_data' > pkt_end, pkt_meta' > pkt_data =
*/
> > > -                       find_good_pkt_pointers(this_branch, dst_reg,
> > > -                                              dst_reg->type, false);
> > > -                       mark_pkt_end(other_branch, insn->dst_reg, tru=
e);
>
> > it seems like you can make a bit of simplification if mark_pkt_end
> > would just accept struct bpf_reg_state * instead of int regn (you
> > won't need to keep track of dst_regno at all, right?)
>
> mark_pkt_end() changes the register from either this_branch or other_bran=
ch.
> I can introduce local pointers dst_this/dst_other and swap those,
> but I'm not sure it's worth it.

Ah, I missed that it's other_branch register. Never mind then, it's
fine and it was minor anyways.

>
> [...]

