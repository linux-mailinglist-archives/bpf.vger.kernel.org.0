Return-Path: <bpf+bounces-36116-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D453942540
	for <lists+bpf@lfdr.de>; Wed, 31 Jul 2024 06:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F11381F23D01
	for <lists+bpf@lfdr.de>; Wed, 31 Jul 2024 04:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89FE91B964;
	Wed, 31 Jul 2024 04:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AMoaPYfZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9522B17C8D;
	Wed, 31 Jul 2024 04:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722398975; cv=none; b=rbF4sXtKtQJjFHUOiziNPFwB1DorZn7GvqyAe1BMwdzrf5Mi1EES8BlNTMs+xmIVzJRaXfZnmR15gYpfIDjPsB4nompbwFNqTSVwnSBVFpmbRi70xGIJio9fptRD20EuTvorPtFdIX/Tq4DI5CU7csuWqDgm3VF45A/pUkDtMrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722398975; c=relaxed/simple;
	bh=kMuQ3iHdXMxkxLRQ58/DclUnFxAep8lH35QP+zSJ/LQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YJIlddA3nTGq6eCopbtObFT1JmXKYuMDnAICOpj9S2uH06Plb/dMFpKiS/MaO5/WKG2yj/TroDU0KKgp/ip6UiAdxZKe1Xj655qpfAZeo+GY1acNBF10Q1IrGHw0y17xmcMEp9t89L9K8OMBxF/9w0XoNchGk0XGhJqJy3NDQ48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AMoaPYfZ; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-65fdfd7b3deso39219897b3.0;
        Tue, 30 Jul 2024 21:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722398972; x=1723003772; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jm02drLrgXUZ/C+xMEPMKvlmJRoAkQTPjVdA5f0QygI=;
        b=AMoaPYfZufp5+zKi/jlBpeiqAHShsrhWJ3tysw24mNtJ9gBU+QsLoPYwteG1mC51en
         VGhEnE+BRJir4mXaTyZ+nwIPC2mo2lLJhN7gjnyRQ8Qhn55GKlthXErha5Z3IP7NXOEY
         6mEkxLSobmpouCM4h4H4eIthCGz4kurOx4RWOvkPTsPy/pSifEKw2T98uzSRpxkhDal3
         7VrJRWWKEGSHU58mau1fGOqznhtp5tLiezxjgLCYG24EC76ilNUlfPWQYLF36PT+IDPb
         0iBqzH5jCu7smdrGXf13wghbERXXdX7dMS5mLseq66dAiJsSjMwzYmmI6LVQt7EMGphZ
         viKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722398972; x=1723003772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jm02drLrgXUZ/C+xMEPMKvlmJRoAkQTPjVdA5f0QygI=;
        b=EAhAHGAuVC6DvFOds+pVhG2DNkwUtzc2eygKZfbdaN/z3qOrJ6gp3eiwbNLWMdVNUJ
         wiH9W5r/XYjoboxxkPLb6IULJsfE+LxvFsZqCtnadnplVCUz2WAcyhAbEQf/fZbIFhFU
         uMyxTnL8PWWyTM8h3BOvQrz+X1ycWQLElXLLjbdUjlP6XRiJ9F6VcGwGFnLE2JRZQyWP
         VeYs59/YXhGpl+jpQQFwUWY02QrF0NQycTawIM838Aukwg/XF5KKtOF+KTuijl6N5wTQ
         9nR4+xo+0ZwJ4PjElJlEbvfpdAmZq7LvZ4413fH3D7Y4ihzekl4ifpVi53aybHqngDaF
         Qhpw==
X-Forwarded-Encrypted: i=1; AJvYcCVuMn8QxnVr0ebBqNeisSsr1RUQGSH2r5B/tFqq+ByUTMyzOqc+AzmXxlX6aAYxPFJQ45PWKO6yMMA9EDqzJfGQDyETJ/PX
X-Gm-Message-State: AOJu0Yx3onhUvihYJIyFakeokiGXy+kp+SWvcCF6htRzagQwU9vI4GEl
	4xa/k5vEQjUXrsB8No8XJnSLNXOCLfR0F5wEmn8jn+/RinFLPPicwXMHJvSZqI+8U+zKz4GuRrv
	ndUp6pJCt5zGJcz2i0TW21VXkKyQ=
X-Google-Smtp-Source: AGHT+IHhSq9dq2eeGB9Xi2+PnpeYroV5ukCGq3iMH7jBGYRtqnNVr5OuABtGS43DFsDxG4342RDXpMFWg/FsvBzKcUM=
X-Received: by 2002:a05:6902:1501:b0:e0b:286b:1399 with SMTP id
 3f1490d57ef6-e0b544b6080mr13254679276.29.1722398972588; Tue, 30 Jul 2024
 21:09:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240714175130.4051012-1-amery.hung@bytedance.com>
 <20240714175130.4051012-6-amery.hung@bytedance.com> <d0ff81d2-3297-4b13-855b-810c11390dc9@linux.dev>
In-Reply-To: <d0ff81d2-3297-4b13-855b-810c11390dc9@linux.dev>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 30 Jul 2024 21:09:21 -0700
Message-ID: <CAMB2axOSLmnrdDDfjzToBd+st2M5Ri8GpUmy-WgmCwG_pCEiRg@mail.gmail.com>
Subject: Re: [RFC PATCH v9 05/11] bpf: net_sched: Support implementation of
 Qdisc_ops in bpf
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, yangpeihao@sjtu.edu.cn, 
	daniel@iogearbox.net, andrii@kernel.org, alexei.starovoitov@gmail.com, 
	martin.lau@kernel.org, sinquersw@gmail.com, toke@redhat.com, jhs@mojatatu.com, 
	jiri@resnulli.us, sdf@google.com, xiyou.wangcong@gmail.com, 
	yepeilin.cs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 2:25=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 7/14/24 10:51 AM, Amery Hung wrote:
> > +static const struct bpf_func_proto *
> > +bpf_qdisc_get_func_proto(enum bpf_func_id func_id,
> > +                      const struct bpf_prog *prog)
> > +{
> > +     switch (func_id) {
>
> Instead of an empty switch, it should be useful to provide the skb->data =
related
> helper. It can start with read only dynptr first, the BPF_FUNC_dynptr_rea=
d
> helper here.
>
> Also, the kfuncs: bpf_dynptr_slice and bpf_dynptr_from_skb_rdonly.
>

I will add the helper and kfuncs and try them out.

> > +     default:
> > +             return bpf_base_func_proto(func_id, prog);
>
> [ ... ]
>
> > +     }
> > +}
> > +
> > +BTF_ID_LIST_SINGLE(bpf_sk_buff_ids, struct, sk_buff)
> > +BTF_ID_LIST_SINGLE(bpf_sk_buff_ptr_ids, struct, bpf_sk_buff_ptr)
> > +
> > +static bool bpf_qdisc_is_valid_access(int off, int size,
> > +                                   enum bpf_access_type type,
> > +                                   const struct bpf_prog *prog,
> > +                                   struct bpf_insn_access_aux *info)
> > +{
> > +     struct btf *btf =3D prog->aux->attach_btf;
> > +     u32 arg;
> > +
> > +     arg =3D get_ctx_arg_idx(btf, prog->aux->attach_func_proto, off);
> > +     if (!strcmp(prog->aux->attach_func_name, "enqueue")) {
> > +             if (arg =3D=3D 2) {
> > +                     info->reg_type =3D PTR_TO_BTF_ID | PTR_TRUSTED;
> > +                     info->btf =3D btf;
> > +                     info->btf_id =3D bpf_sk_buff_ptr_ids[0];
> > +                     return true;
>
> This will allow type =3D=3D BPF_WRITE to ctx which should be rejected. Th=
e below
> bpf_tracing_btf_ctx_access() could have rejected it.
>

Right. I will check the access type of the "to_free" argument in .enqueue.

> > +             }
> > +     }
> > +
> > +     return bpf_tracing_btf_ctx_access(off, size, type, prog, info);
> > +}
> > +
>
> [ ... ]
>
> > +
> > +static bool is_unsupported(u32 member_offset)
> > +{
> > +     unsigned int i;
> > +
> > +     for (i =3D 0; i < ARRAY_SIZE(unsupported_ops); i++) {
> > +             if (member_offset =3D=3D unsupported_ops[i])
> > +                     return true;
> > +     }
> > +
> > +     return false;
> > +}
> > +
> > +static int bpf_qdisc_check_member(const struct btf_type *t,
> > +                               const struct btf_member *member,
> > +                               const struct bpf_prog *prog)
> > +{
> > +     if (is_unsupported(__btf_member_bit_offset(t, member) / 8))
>
> Note that the ".check_member" and the "is_unsupported" can be removed as =
you
> also noticed on the recent unsupported ops cleanup patches.

Thanks for looping me in. I removed them when testing the series.

>
> > +             return -ENOTSUPP;
> > +     return 0;
> > +}
>
> [ ... ]
>
> > +static struct Qdisc_ops __bpf_ops_qdisc_ops =3D {
> > +     .enqueue =3D Qdisc_ops__enqueue,
> > +     .dequeue =3D Qdisc_ops__dequeue,
> > +     .peek =3D Qdisc_ops__peek,
> > +     .init =3D Qdisc_ops__init,
> > +     .reset =3D Qdisc_ops__reset,
> > +     .destroy =3D Qdisc_ops__destroy,
> > +     .change =3D Qdisc_ops__change,
> > +     .attach =3D Qdisc_ops__attach,
> > +     .change_tx_queue_len =3D Qdisc_ops__change_tx_queue_len,
> > +     .change_real_num_tx =3D Qdisc_ops__change_real_num_tx,
> > +     .dump =3D Qdisc_ops__dump,
> > +     .dump_stats =3D Qdisc_ops__dump_stats,
>
> Similar to the above is_unsupported comment. The unsupported ops should b=
e
> removed from the cfi_stubs.
>
> > +     .ingress_block_set =3D Qdisc_ops__ingress_block_set,
> > +     .egress_block_set =3D Qdisc_ops__egress_block_set,
> > +     .ingress_block_get =3D Qdisc_ops__ingress_block_get,
> > +     .egress_block_get =3D Qdisc_ops__egress_block_get,
> > +};
> > +
> > +static struct bpf_struct_ops bpf_Qdisc_ops =3D {
> > +     .verifier_ops =3D &bpf_qdisc_verifier_ops,
> > +     .reg =3D bpf_qdisc_reg,
> > +     .unreg =3D bpf_qdisc_unreg,
> > +     .check_member =3D bpf_qdisc_check_member,
> > +     .init_member =3D bpf_qdisc_init_member,
> > +     .init =3D bpf_qdisc_init,
> > +     .validate =3D bpf_qdisc_validate,
>
> ".validate" is optional. The empty "bpf_qdisc_validate" can be removed.
>

Got it.


> > +     .name =3D "Qdisc_ops",
> > +     .cfi_stubs =3D &__bpf_ops_qdisc_ops,
> > +     .owner =3D THIS_MODULE,
> > +};
>
>

