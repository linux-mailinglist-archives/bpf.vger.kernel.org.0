Return-Path: <bpf+bounces-48404-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEBF9A07A1A
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 16:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3DD5160F36
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 15:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C998E21C183;
	Thu,  9 Jan 2025 15:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qc+iGs2U"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE28D126C18;
	Thu,  9 Jan 2025 15:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736434910; cv=none; b=KVMqQT3AxgjE4FDGbseCRRZ4XiwaXlauKfM3e9yz5AM78rvNYxPy72U/kmJX6y0BijjPitTYLlrE+7UAKh1Dj05IUVUXR+VbTFksrmiY9+A1NYmUdeNzm5snVBONchKM6bmitV9TLujTBtzd3lbMsgsYc7t0SZJ+1qpnS6CiWic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736434910; c=relaxed/simple;
	bh=ff+4ID3IFefdrduc7sNMCBmj6ptNHLYZHEId6E8XSLY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WCWxPHZZICHs5PJw3oJOwHlxmpQBF+ETRbrI/oi3PFlz0bfwEiP37xJb4cMEdsDqXXnMM0h4sQLn4ZHeuwQpyAeJXdI/ZRwnkTp2O9NsE9nfh2+Ieo6CqzJfu5LfZgbFwXjvPm6wY3QJ7toYiukabG0nijdfNQLMRKhdUc+uiqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qc+iGs2U; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e54bd61e793so1594633276.2;
        Thu, 09 Jan 2025 07:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736434908; x=1737039708; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eWfuwOBUl6cOitwiEIHV5z9m+DKUUcfRYCOSfvut16o=;
        b=Qc+iGs2U2JR6r34jSimCJkJ3xw4Y22fVFxqVL+bmQ2cagPN2KkNrDdjDuaNaZDKEPt
         KHYRT1WfUiidlsmDoFA9RU+WKwM+9GAIBqyolRf0kOaHcJQELfxi5hhr83QfmP0DXgcj
         2fqy0bbIuF3ifPCUM0LSV2mHaoaukIMcNX176yuGKk/m3EhJkIlDps36hrBt+ZoylSiI
         7lCS4VIN0LftPbdL9B1gckyrmjtZP4o/Q9bMFWJp1iU3K87kuOLFkV2yVSmiwkDRQqhz
         s9BJTxMbVU+uU/uUhxj3Kr1TPknn7ub5j0GFFIFBIU4S16Cl47aqCZdrfLzLxnlGuiom
         GusA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736434908; x=1737039708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eWfuwOBUl6cOitwiEIHV5z9m+DKUUcfRYCOSfvut16o=;
        b=upTuv7pEaNltu0RoWk1kD5DlGimJok2C4zHM8Tf4wHocwPAmct1kr1NrkXCD851YOl
         Q7DRPd/pen0HJl1sq4OKhwVWE5tN2Gdu2jVSXcQgpZb+ld8nW+Re18HLq/uETsxnxnDv
         YpOTvl/R7q3eiFi7u4FxRP3gD49nytsFQ4glK+4h0V1IxwTfdtoX/xEdAMBj4PVk5R02
         p2Rt0WbHO1DAuW5r7fhNxTmWYA2veeo/szmFCTsqOfmXr2l3AVoA3htzPEYTBADetW2v
         gF6PIIvCkR1U5J6C46DjgdkWiJv2UlvzPpUpx0Fim42DiAKOdu2NlnjfZWaOOKxxSNi0
         q7qg==
X-Forwarded-Encrypted: i=1; AJvYcCUkibjfszEwKazou6hsuAs77NEcnJkkb0++RhCT1m9Np02zHXuiQ6MAheN6ybblkMm1oLuBUzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg+Jp5ofmOUKP6mv5r9e1ON6T0Ju1idBRvPU5Gn2gOmcvBLsLv
	GJMSkEir9UPKelY/PSlGQxRyCsCIixYZsNQ3Hq+WOqUamJ9bz7Kf/hYYJH2ZEW02K5g4qfNgsOk
	8Mjm4Ze93XPMYah8wkMpCf+/JRVI=
X-Gm-Gg: ASbGncvaIwP+FL+Mn+DENaRFZutnwnZ8yt/496dQu6Cthv0Adm7jc1vb7r6lHGCrOpY
	bWYtMpPg3mzNfV277FjYIfqjJi7F6mkgXAbxdRk6b9iLMwtCS3Je7AA==
X-Google-Smtp-Source: AGHT+IGzgAgSGrbI0Qqg8yvoVvqUWZvvrBrWK41N8uBkoAlROJp/T5EWUfV7SoQSgDv7sz86gdceZA8A3KmiM03WLoE=
X-Received: by 2002:a05:690c:f10:b0:6ef:6c57:ddae with SMTP id
 00721157ae682-6f5312a3301mr56923377b3.34.1736434907714; Thu, 09 Jan 2025
 07:01:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241220195619.2022866-1-amery.hung@gmail.com>
 <20241220195619.2022866-9-amery.hung@gmail.com> <3961c9ce-21d3-4a35-956c-5e1a6eb6031b@linux.dev>
In-Reply-To: <3961c9ce-21d3-4a35-956c-5e1a6eb6031b@linux.dev>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 9 Jan 2025 07:00:00 -0800
X-Gm-Features: AbW1kvazz7DxogB4aWKus50XwQWS6BOfbyqO1fk83gOIYsQR7b817fFBnIX5FRs
Message-ID: <CAMB2axNoh1uDLC4KubHjKSfRBfNWnG_tbuPK6BWzx4VA6Hx0tQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 08/14] bpf: net_sched: Add a qdisc watchdog timer
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, alexei.starovoitov@gmail.com, martin.lau@kernel.org, 
	sinquersw@gmail.com, toke@redhat.com, jhs@mojatatu.com, jiri@resnulli.us, 
	stfomichev@gmail.com, ekarani.silvestre@ccc.ufcg.edu.br, 
	yangpeihao@sjtu.edu.cn, xiyou.wangcong@gmail.com, yepeilin.cs@gmail.com, 
	amery.hung@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 8, 2025 at 4:20=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.d=
ev> wrote:
>
> On 12/20/24 11:55 AM, Amery Hung wrote:
> > diff --git a/net/sched/bpf_qdisc.c b/net/sched/bpf_qdisc.c
> > index 1c92bfcc3847..bbe7aded6f24 100644
> > --- a/net/sched/bpf_qdisc.c
> > +++ b/net/sched/bpf_qdisc.c
> > @@ -8,6 +8,10 @@
> >
> >   static struct bpf_struct_ops bpf_Qdisc_ops;
> >
> > +struct bpf_sched_data {
> > +     struct qdisc_watchdog watchdog;
> > +};
> > +
> >   struct bpf_sk_buff_ptr {
> >       struct sk_buff *skb;
> >   };
> > @@ -108,6 +112,46 @@ static int bpf_qdisc_btf_struct_access(struct bpf_=
verifier_log *log,
> >       return 0;
> >   }
> >
> > +BTF_ID_LIST(bpf_qdisc_init_prologue_ids)
> > +BTF_ID(func, bpf_qdisc_init_prologue)
> > +
> > +static int bpf_qdisc_gen_prologue(struct bpf_insn *insn_buf, bool dire=
ct_write,
> > +                               const struct bpf_prog *prog)
> > +{
> > +     struct bpf_insn *insn =3D insn_buf;
> > +
> > +     if (strcmp(prog->aux->attach_func_name, "init"))
> > +             return 0;
> > +
> > +     *insn++ =3D BPF_MOV64_REG(BPF_REG_6, BPF_REG_1);
> > +     *insn++ =3D BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, 0);
> > +     *insn++ =3D BPF_CALL_KFUNC(0, bpf_qdisc_init_prologue_ids[0]);
>
> I was wondering if patch 7 is needed if BPF_EMIT_CALL() and BPF_CALL_1() =
were
> used, so it looks more like a bpf helper instead of kfunc. I tried but fa=
iled at
> the "fn =3D env->ops->get_func_proto(insn->imm, env->prog);" in do_misc_f=
ixups().
> I think the change in patch 7 is simple enough instead of getting
> get_func_proto() works for this case.
>

Yeah. Making BPF_EMIT_CALL + BPF_CALL_xxx work in
gen_prologue/epilogue doesn't seem trivial to me at least when
compared with BPF_CALL_KFUNC.

> > +     *insn++ =3D BPF_MOV64_REG(BPF_REG_1, BPF_REG_6);
> > +     *insn++ =3D prog->insnsi[0];
> > +
> > +     return insn - insn_buf;
> > +}
> > +
> > +BTF_ID_LIST(bpf_qdisc_reset_destroy_epilogue_ids)
> > +BTF_ID(func, bpf_qdisc_reset_destroy_epilogue)
> > +
> > +static int bpf_qdisc_gen_epilogue(struct bpf_insn *insn_buf, const str=
uct bpf_prog *prog,
> > +                               s16 ctx_stack_off)
> > +{
> > +     struct bpf_insn *insn =3D insn_buf;
> > +
> > +     if (strcmp(prog->aux->attach_func_name, "reset") &&
> > +         strcmp(prog->aux->attach_func_name, "destroy"))
> > +             return 0;
> > +
> > +     *insn++ =3D BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_FP, ctx_stack_=
off);
> > +     *insn++ =3D BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, 0);
> > +     *insn++ =3D BPF_CALL_KFUNC(0, bpf_qdisc_reset_destroy_epilogue_id=
s[0]);
> > +     *insn++ =3D BPF_EXIT_INSN();
> > +
> > +     return insn - insn_buf;
> > +}
> > +

