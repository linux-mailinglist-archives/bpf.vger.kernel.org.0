Return-Path: <bpf+bounces-20837-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E681844400
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 17:23:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2550528E27D
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 16:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E86F12AAFE;
	Wed, 31 Jan 2024 16:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kJb1gZEk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA3512A146;
	Wed, 31 Jan 2024 16:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706718218; cv=none; b=h1mkZsVlMoCE6yPIm8xDlThjlR29p+JGAkrcTxbz9yWPYRuSwTsaR9e+RKasfEmTlsd3P4n82SNMjv+6Q9924K8g314szDA7wvp2N5gxeBqUmh6QA8rccZbrVFxsAg+D1ae+OlNwQ4HH1a5S49tm7+JW6Aeax/TQ+TtoQNsiZAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706718218; c=relaxed/simple;
	bh=b7fdFIuVQYzv6yCPxdFbGb/aldkYX+2PSbCXJiqEdwA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N9HBqkjUVARp3C4dEi1esttbkTchbxc8ZWgyRNRZmRJcVTHPa8DXLqh0DWmVkuPwV4ccYOZmZQIgxLyE5NuXJSFpzXLtNXyHxe8k/DBYzdRSadJRTuTpRCC56jPrdxdNxpk+UEf6dgFXhwxr23v4Ur8xZR7rZxiAAmdxqURmtMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kJb1gZEk; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dc6d24737d7so7949276.0;
        Wed, 31 Jan 2024 08:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706718215; x=1707323015; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2wurHhhs58z6TGUqPSkzYSiqQNZYYnoRaq9Uggq6ROA=;
        b=kJb1gZEkVUztVs85PMqtM2cdZqpFGiFc5hoP+IHMUp5jcK+xN594KI98jT4+FFSnsI
         oz4c3E4JblhVPhQCMiUo0x3VN28SOLw2uR/s/gsKrGJC7HJf7x+nSFe4euo5Ha/ErBZF
         jeKN5eOgcuW94krKOdHolmS9n6eZOcJiqgPBZg1QrG85c4HyVFFmbxdIlklO97QPyF4Q
         5nJA9qqv3nMuZIm6EHMeDsOxvgmDzu8V4ynlBf3ZBmqyK9ZDNMmxGAG7ZR6y2cPV6y1T
         T+tsq3PmMFpyhlauBMP3tG5FF2fPHTxBFCH8HMeh6MDGcXEoLLzqVAnqcC++rtxC6zgW
         2xUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706718215; x=1707323015;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2wurHhhs58z6TGUqPSkzYSiqQNZYYnoRaq9Uggq6ROA=;
        b=IJlZ5HG9VmklTQtej7ZNZM9E/OrqmqOeYNkxCUy5Rzw6ssmriD+dLrGjMZ/qkahxBM
         TJM/HkrZ+Nwq7cSNfho6L6pQ5cxAlLOBvjEMo7d8WcmTlv8tENShqR7mq+xJDiwb6JwZ
         B6tbnKmbZKtvlJJFNVjQTT21KcDyxfeYNd0IsLKZzs766lmcyv51l4Wrlhf2F9lcbOgy
         YZVXlZFPNswrrq3ftQjXoeDuxPJJ6luFsqDbKVdRBVIU2nmpOqBvB3d/u1xTrnJNRHs7
         I1FkkJQFn6QDc2ISR4jKHo32IN68ehr8OaCMX9J2PXi1v739S0y9G7XUlV0S8pbsnWHh
         vwsg==
X-Gm-Message-State: AOJu0YxtV97NJc74B8vDmYmB3BmhRAUGCaz2srP3OMbji1V5v2Mw8nhF
	X3FkI5lpoe3LBg432JS9ZOOC8VPCFBH4cFxlc5V+rlQhThpsvBHgwzzWKypXR7Z6KVnYjBbq1Rm
	z0CH5stTHVZGWqXkXduUzdRjjIII=
X-Google-Smtp-Source: AGHT+IHMiW50+/7Zhsg6ixRud2a0A4kr+RuEprpT/xLEefAO+OQ4hsO1DpWxbcLs1bfVjoEbBGuE6BsugDKUCuF52bU=
X-Received: by 2002:a25:db91:0:b0:dc6:17d2:3b89 with SMTP id
 g139-20020a25db91000000b00dc617d23b89mr1826558ybf.61.1706718215050; Wed, 31
 Jan 2024 08:23:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1705432850.git.amery.hung@bytedance.com>
 <232881645a5c4c05a35df4ff1f08a19ef9a02662.1705432850.git.amery.hung@bytedance.com>
 <0484f7f7-715f-4084-b42d-6d43ebb5180f@linux.dev> <CAMB2axM1TVw05jZsFe7TsKKRN8jw=YOwu-+rA9bOAkOiCPyFqQ@mail.gmail.com>
 <01fdb720-c0dc-495d-a42d-756aa2bf4455@linux.dev> <CAMB2axOZqwgksukO5d4OiXeEgo2jFrgnzO5PQwABi_WxYFycGg@mail.gmail.com>
 <8c00bd63-2d00-401e-af6d-1b6aebac4701@linux.dev>
In-Reply-To: <8c00bd63-2d00-401e-af6d-1b6aebac4701@linux.dev>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 31 Jan 2024 08:23:23 -0800
Message-ID: <CAMB2axOdeE5dPeFGvgM5QVd9a47srtvDFZd1VUYjSarNJC=T_w@mail.gmail.com>
Subject: Re: [RFC PATCH v7 1/8] net_sched: Introduce eBPF based Qdisc
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, yangpeihao@sjtu.edu.cn, toke@redhat.com, 
	jhs@mojatatu.com, jiri@resnulli.us, sdf@google.com, xiyou.wangcong@gmail.com, 
	yepeilin.cs@gmail.com, netdev@vger.kernel.org, 
	Kui-Feng Lee <thinker.li@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 10:39=E2=80=AFPM Martin KaFai Lau <martin.lau@linux=
.dev> wrote:
> >> We can see how those limitations (calling sch_tree_lock() and returnin=
g a ptr)
> >> can be addressed in bpf. This will also help other similar use cases.
> >>
> >
> > For kptr, I wonder if we can support the following semantics in bpf if
> > they make sense:
>
> I think they are useful but they are not fully supported now.
>
> Some thoughts below.
>
> > 1. Passing a referenced kptr into a bpf program, which will also need
> > to be released, or exchanged into maps or allocated objects.
>
> "enqueue" should be the one considering here:
>
> struct Qdisc_ops {
>         /* ... */
>         int                     (*enqueue)(struct sk_buff *skb,
>                                            struct Qdisc *sch,
>                                            struct sk_buff **to_free);
>
> };
>
> The verifier only marks the skb as a trusted kptr but does not mark its
> reg->ref_obj_id. Take a look at btf_ctx_access(). In particular:
>
>         if (prog_args_trusted(prog))
>                 info->reg_type |=3D PTR_TRUSTED;
>
> The verifier does not know the skb ownership is passed into the ".enqueue=
" ops
> and does not know the bpf prog needs to release it or store it in a map.
>
> The verifier tracks the reference state when a KF_ACQUIRE kfunc is called=
 (just
> an example, not saying we need to use KF_ACQUIRE kfunc). Take a look at
> acquire_reference_state() which is the useful one here.
>
> Whenever the verifier is loading the ".enqueue" bpf_prog, the verifier ca=
n
> always acquire_reference_state() for the "struct sk_buff *skb" argument.
>
> Take a look at a recent RFC:
> https://lore.kernel.org/bpf/20240122212217.1391878-1-thinker.li@gmail.com=
/
> which is tagging the argument of an ops (e.g. ".enqueue" here). That RFC =
patch
> is tagging the argument could be NULL by appending "__nullable" to the ar=
gument
> name. The verifier will enforce that the bpf prog must check for NULL fir=
st.
>
> The similar idea can be used here but with a different tagging (for examp=
le,
> "__must_release", admittedly not a good name). While the RFC patch is
> in-progress, for now, may be hardcode for the ".enqueue" ops in
> check_struct_ops_btf_id() and always acquire_reference_state() for the sk=
b. This
> part can be adjusted later once the RFC patch will be in shape.
>

Make sense. One more thing to consider here is that .enqueue is
actually a reference acquiring and releasing function at the same
time. Assuming ctx written to by a struct_ops program can be seen by
the kernel, another new tag for the "to_free" argument will still be
needed so that the verifier can recognize when writing skb to
"to_free".

>
> Then one more thing is to track when the struct_ops bpf prog is actually =
reading
> the value of the skb pointer. One thing is worth to mention here, e.g. a
> struct_ops prog for enqueue:
>
> SEC("struct_ops")
> int BPF_PROG(bpf_dropall_enqueue, struct sk_buff *skb, struct Qdisc *sch,
>              struct sk_buff **to_free)
> {
>         return bpf_qdisc_drop(skb, sch, to_free);
> }
>
> Take a look at the BPF_PROG macro, the bpf prog is getting a pointer to a=
n array
> of __u64 as the only argument. The skb is actually in ctx[0], sch is in
> ctx[1]...etc. When ctx[0] is read to get the skb pointer (e.g. r1 =3D ctx=
[0]),
> btf_ctx_access() marks the reg_type to PTR_TRUSTED. It needs to also init=
ialize
> the reg->ref_obj_id by the id obtained earlier from acquire_reference_sta=
te()
> during check_struct_ops_btf_id() somehow.
>
>
> > 2. Returning a kptr from a program and treating it as releasing the ref=
erence.
>
> e.g. for dequeue:
>
> struct Qdisc_ops {
>         /* ... */
>         struct sk_buff *        (*dequeue)(struct Qdisc *);
> };
>
>
> Right now the verifier should complain on check_reference_leak() if the
> struct_ops bpf prog is returning a referenced kptr.
>
> Unlike an argument, the return type of a function does not have a name to=
 tag.
> It is the first case that a struct_ops bpf_prog returning a pointer. One =
idea is
> to assume it must be a trusted pointer (PTR_TRUSTED) and the verifier sho=
uld
> check it is indeed with PTR_TRUSTED flag.
>
> May be release_reference_state() can be called to assume the kernel will =
release
> it as long as the return pointer type is PTR_TRUSTED and the type matches=
 the
> return type of the ops. Take a look at check_return_code().

