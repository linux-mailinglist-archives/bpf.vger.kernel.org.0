Return-Path: <bpf+bounces-7740-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4B677BEA3
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 19:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E5082810F4
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 17:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA67C8D6;
	Mon, 14 Aug 2023 17:07:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D99C2F44
	for <bpf@vger.kernel.org>; Mon, 14 Aug 2023 17:07:27 +0000 (UTC)
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87A4D1
	for <bpf@vger.kernel.org>; Mon, 14 Aug 2023 10:07:26 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-2685bc4f867so5045540a91.0
        for <bpf@vger.kernel.org>; Mon, 14 Aug 2023 10:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692032846; x=1692637646;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HOPcU1s6dOxKoHYRJZpqjdctLTPuo9TU9m/Z/GfnYEk=;
        b=hGbt68DNzLNeOnJPugmwC+ihD+ployxbX6ovpj3tusOy86so0gkCB2KNPD0UsvJj23
         yix9Gc0LqFj2pZ+W2vMRViOh63u0QG/pcmizv+JaC6ksfBfSzbMTHzwLxNfQTOkUVckX
         YoSIR9wbrFa7jTXKxKO9NhFIFSo8ufVbafVCAnYPkH5aIX+o6ERClvDmwY1G6Tsi8+NK
         BNerwMrf57LZiqkaaUXG2SgsqY/Z2MYB2iZPimSsOt0zBlkdjC+RO/zG7QuToncigiUq
         QgQfjWSKUEIt0KVKe5s2b/+lphK9bNgLRdLf86ZPYvn7Wbid77ftc6DhYSE00EHlVZ2S
         6M9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692032846; x=1692637646;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HOPcU1s6dOxKoHYRJZpqjdctLTPuo9TU9m/Z/GfnYEk=;
        b=XTyV0bql7JJ401eNUxSaOHobhPaXErvuhskxsXG6LvPUyfJaP3WinqEHv21GkxYJom
         +Ac8WqdVoLtQ8dK5WNFEs4qI68OGTnFnmRDjuAyMLys/qus/9SPKVQQNqUgnKORl260F
         fxS4+9BPy2PI6tX0rTTTH8evWWWK7EkcEE5LfBaLbm9Ex6cRZKPbXSF2IIGkPxX/NU2U
         QEc9ITGpsE4x/0foFwBcywz7pcpha9CZ0E3oEbjP1DG2Uzrfvto7GpxTZJ6SVcJ0+qUU
         x2TKteV1L11Smcolg7UJiTlJbubKvHg+R67du+O0oYCEZiCKQuTq2wWfMKZ8ZdnHFFyc
         goUw==
X-Gm-Message-State: AOJu0Yy0vzMyT5TjHvRTFt5KWO1fD+e7gcS/cnJecH6cjsx+VeaFxont
	bg1CtoJO1xbdtGnN5VqFLTeyT6w=
X-Google-Smtp-Source: AGHT+IEx9GXBwXDn87IkzTs4uRACno3/UEVJolEaNR+oMCCxIC0gbCOoCti7weqvgPfx4RBox+0pHr8=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:90a:e557:b0:26b:2001:54f8 with SMTP id
 ei23-20020a17090ae55700b0026b200154f8mr2139270pjb.9.1692032846422; Mon, 14
 Aug 2023 10:07:26 -0700 (PDT)
Date: Mon, 14 Aug 2023 10:07:24 -0700
In-Reply-To: <0164ca41-01bc-be14-2f99-b1c4400850b8@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230811043127.1318152-1-thinker.li@gmail.com>
 <20230811043127.1318152-5-thinker.li@gmail.com> <ZNa+vhzXxYYOzk96@google.com>
 <6a634e79-db63-df29-9d18-93387191f937@gmail.com> <0164ca41-01bc-be14-2f99-b1c4400850b8@gmail.com>
Message-ID: <ZNpfTBh4cC1oW8Cf@google.com>
Subject: Re: [RFC bpf-next v2 4/6] bpf: Provide bpf_copy_from_user() and bpf_copy_to_user().
From: Stanislav Fomichev <sdf@google.com>
To: Kui-Feng Lee <sinquersw@gmail.com>
Cc: thinker.li@gmail.com, bpf@vger.kernel.org, ast@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, kernel-team@meta.com, 
	andrii@kernel.org, yonghong.song@linux.dev, kuifeng@meta.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 08/11, Kui-Feng Lee wrote:
>=20
>=20
> On 8/11/23 16:27, Kui-Feng Lee wrote:
> >=20
> >=20
> > On 8/11/23 16:05, Stanislav Fomichev wrote:
> > > On 08/10, thinker.li@gmail.com wrote:
> > > > From: Kui-Feng Lee <kuifeng@meta.com>
> > > >=20
> > > > Provide bpf_copy_from_user() and bpf_copy_to_user() to the BPF prog=
rams
> > > > attached to cgroup/{set,get}sockopt. bpf_copy_to_user() is a new
> > > > kfunc to
> > > > copy data from an kernel space buffer to a user space buffer.
> > > > They are only
> > > > available for sleepable BPF programs. bpf_copy_to_user() is only
> > > > available
> > > > to the BPF programs attached to cgroup/getsockopt.
> > > >=20
> > > > Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> > > > ---
> > > > =C2=A0 kernel/bpf/cgroup.c=C2=A0 |=C2=A0 6 ++++++
> > > > =C2=A0 kernel/bpf/helpers.c | 31 +++++++++++++++++++++++++++++++
> > > > =C2=A0 2 files changed, 37 insertions(+)
> > > >=20
> > > > diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> > > > index 5bf3115b265c..c15a72860d2a 100644
> > > > --- a/kernel/bpf/cgroup.c
> > > > +++ b/kernel/bpf/cgroup.c
> > > > @@ -2461,6 +2461,12 @@ cg_sockopt_func_proto(enum bpf_func_id
> > > > func_id, const struct bpf_prog *prog)
> > > > =C2=A0 #endif
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case BPF_FUNC_perf_event_output:
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return &bpf_=
event_output_data_proto;
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0 case BPF_FUNC_copy_from_user:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (prog->aux->sleepabl=
e)
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 return &bpf_copy_from_user_proto;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
> > >=20
> > > If we just allow copy to/from, I'm not sure I understand how the buff=
er
> > > sharing between sleepable/non-sleepable works.
> > >=20
> > > Let's assume I have two progs in the chain:
> > > 1. non-sleepable - copies the buffer, does some modifications; since
> > > =C2=A0=C2=A0=C2=A0 we don't copy the buffer back after every prog run=
, the modifications
> > > =C2=A0=C2=A0=C2=A0 stay in the kernel buffer
> > > 2. sleepable - runs and just gets the user pointer? does it mean this
> > > =C2=A0=C2=A0 sleepable program doesn't see the changes from (1)?
>=20
> It is still visible from sleepable programs.  Sleepable programs
> will receive a pointer to the buffer in the kernel.
> And, BPF_SOCKOPT_FLAG_OPTVAL_USER is clear.
>=20
> > >=20
> > > IOW, do we need some custom sockopt copy_to/from that handle this
> > > potential buffer location transparently or am I missing something?
> > >=20
> > > Assuming we want to support this at all. If we do, might deserve a
> > > selftest.
> >=20
> > It is why BPF_SOCKOPT_FLAG_OPTVAL_USER is there.
> > It helps programs to make a right decision.
> > However, I am going to remove bpf_copy_from_user()
> > since we have bpf_so_optval_copy_to() and bpf_so_optval_copy_to_r().
> > Does it make sense to you?

Ah, so that's where it's handled. I didn't read that far :-)
In this case yes, let's have only those helpers.

Btw, do we also really need bpf_so_optval_copy_to_r? If we are doing
dynptr, let's only have bpf_so_optval_copy_to version?

I'd also call them something like bpf_sockopt_copy_{to,from}. That
"_so_optval_" is not super intuitive imho.

