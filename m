Return-Path: <bpf+bounces-69776-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92463BA1358
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 21:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50C60178FDD
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 19:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119F531D721;
	Thu, 25 Sep 2025 19:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ku4TOjn9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E896831B816
	for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 19:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758828912; cv=none; b=bImF3ltYPNOI1OIlZI0o09LYH91euPBhlEq4uzJRypj7YDau2mLAI8f52lvsBjFqQuzSMJWmyneJfcfFELaNXyKwZu6y+95aBu5ZV/zxbB8xw+3empPHykKt7q3aqmPysx9VOr2mV1Z6gqrhDedX9FX68XEl9Ith+DumnckxErc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758828912; c=relaxed/simple;
	bh=QnRG682A4kA/LPWdSxvyk13q+U5Oj2UjRF3fKjiZm8k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qwEpUCr01JP/qPyJTAMEUERfuZreljygmpUoFHhZzFdh1kcgWcTeZWkrl13C8oExonUiV8YNjDRtdRmGqVD1UGFPFSk2Uhehz6CeOL9bJfnzeyJ4S6RDXVSKVMuGC+q07hjCOp33oqDesYwZQMArMwGKAkSFPxkjib32Kht1Ljo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ku4TOjn9; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b35f6f43351so182432266b.1
        for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 12:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758828909; x=1759433709; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QnRG682A4kA/LPWdSxvyk13q+U5Oj2UjRF3fKjiZm8k=;
        b=ku4TOjn9rU8lldngxboZTX1h1hpYiVGZ8KCU5cKwn7TshmRSklzi7I/+pO2RCBnRhi
         K31JI8y+go/MwuBzdw5V7GyD2ie+cZH/XnaLvJdDAQ1DSZgwMZ7bUSZoNw/Drq0KihLs
         vu/Kc6PQoY+hfKlN++G1+4OWLBKkUlo5Eiq6G2b9U7G9OjzSpIWF1QmbX1rzB0IGCdBF
         h+FOHQg/2qNfkwj3r8qcezvjStBP0bbgJ4NU3q2NNE6Yp3DT9yhB07vI4s2MmnmCZ/zG
         8c6ZFtdub6Olib7VFPkEB4XHszawhos1BxQWgCJV45JT18424mGxFl1IqytPtesg3k1I
         FrBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758828909; x=1759433709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QnRG682A4kA/LPWdSxvyk13q+U5Oj2UjRF3fKjiZm8k=;
        b=c7Z9EkwR7FjGqzPKh2DYoaMiySBBhoY7gBT2ILk5l+YxHG45nMm7hdayZjoj71qRIK
         sJ1YDP5S4YQlGEwd8+asnWYnbGksnp0OwNAe7ikCcai1c5eWMZ4b7EDSbWxrjleWMt56
         O2UJLZunWw8CUk/IzDMTu8iqfmVlN1Ayv1itJSxFyQ1XcfwDhHyWnavsxBeYXeymLJe7
         NaGPi7ediwC/sG8bZBJTFS0QVrqV42v8KYfdsMrjWHPOk3eFo81DNhtT2hO46LB+Zl5q
         aT07htast7Q5RYdnwM9Cgu8GYUa8GwiyG8MJuANDsvYt6YeDfL8e4SRn/RFOLbwmhUBq
         bmZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUC7SHqJC3PQ9Yr6STspU3if7d1E+7TveBA2G2twdQVJ03cHGzWVL+796PlUu+uga1bmhc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGHjL516sXcRIAftOv3JVdznWQbIIoYEZqp1rHJRsqvvo3MqsB
	3RcXJfC8zdCXmb2P68hyN9wScwRtICMBZDbWEt1NrxXIRuG75Txcg66h1E8IGQ7+uoZ/dgUyINN
	ZWiZdNRWv9tMDMxFT7UrZfHrb0E5869g=
X-Gm-Gg: ASbGncv1dBufvj7Yt/IVAYSwbyY125kqKguBnnBBjkrLtG8fbRD3uylpzD7D741bqny
	sBDjn1GySyhaFGkgdFJm255rMtRHFOKCjg+1FoLoVjDj1iSWLb5w+4MTSU/F4aS3ONwKrGbah31
	A4n9qzJRsQ3vEMLBvXcBmgiCKdAXaF6Ss6DJgS2X6UVNlpJz/vkP4rA1tSnKs9vOAvKP8Vmt2bO
	Au1OA==
X-Google-Smtp-Source: AGHT+IFc0CIZpFjAF3DTy6qb/xhOnpmAzDyWjQAVM+jv0r/V/nSSMRPe9emJtXzeTyPjJUA/xSwFUapr5KWsDi28/cI=
X-Received: by 2002:a17:907:6093:b0:b28:f64f:2fd3 with SMTP id
 a640c23a62f3a-b34ba639a5bmr452557766b.35.1758828907994; Thu, 25 Sep 2025
 12:35:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924211716.1287715-1-ihor.solodrai@linux.dev>
 <20250924211716.1287715-2-ihor.solodrai@linux.dev> <CAADnVQLvuubey0A0Fk=bzN-=JG2UUQHRqBijZpuvqMQ+xy4W4g@mail.gmail.com>
 <6a6403ec-166a-4d48-8bf5-f43ae1759e5f@linux.dev> <CAEf4BzbYXADoUge5C7zhzZAEDESE7YJFwW_jO4-F5L3j-bwPMw@mail.gmail.com>
In-Reply-To: <CAEf4BzbYXADoUge5C7zhzZAEDESE7YJFwW_jO4-F5L3j-bwPMw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 25 Sep 2025 20:34:56 +0100
X-Gm-Features: AS18NWDZKKqxw3yu_dCVfo31fiofhrysGJgq2X0xvlERiaqjb9uGQOJHFbaHPR0
Message-ID: <CAADnVQL+28vPquMgw+hZMT1P6NkE5jLUXf=HDNj65N9np1rgfw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/6] bpf: implement KF_IMPLICIT_PROG_AUX_ARG flag
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Ihor Solodrai <ihor.solodrai@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	dwarves <dwarves@vger.kernel.org>, Alan Maguire <alan.maguire@oracle.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Tejun Heo <tj@kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 6:23=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> I do see the benefit of having the generic "KF_MAGIC_ARG(s)" flag on
> the kernel side of things and having access to full BTF information
> for parameters to let verifier know what specific kind of magic
> argument that kfunc has, though. So as an alternative, maybe we can
> create both a kfunc definition *meant for BPF programs* (i.e., without
> magic argument(s)), and then have a full original definition (produced
> by pahole, it will need to understand KF_MAGIC_ARGS anyways) with full
> type information *for internal BPF verifier needs*. I don't know
> what's the best way to do that, maybe just a special ".magic" suffix,
> just to let the verifier easily find that? On the kernel side, if
> kfunc has BPF_MAGIC_ARGS kflag we just look up "my_fancy_kfunc.magic"
> FUNC definition?

Interesting idea. Maybe to simplify backward compat the pahole can
emit two BTFs: kfunc_foo(args), kfunc_foo_impl(args, void *aux)
into vmlinux BTF.
bpftool will emit both in vmlinux.h and bpf side doesn't need to change.
libbpf doesn't need to change either.
The verifier would need a special check to resolve two kfunc BTFs
name into one kallsym name, since both kfuncs is one actual function
on the kernel.
bpf_wq_set_callback_impl() definition doesn't change. Only:
-BTF_ID_FLAGS(func, bpf_wq_set_callback_impl)
+BTF_ID_FLAGS(func, bpf_wq_set_callback_impl, KF_PROG_ARG)

and the verifier can check that the last arg is aux__prog when
KF_PROG_ARG is specified.

The runtime performance will be slightly better too, since
no need for wrappers like:

+__bpf_kfunc int bpf_wq_set_callback_impl(struct bpf_wq *wq,
+ int (callback_fn)(void *map, int *key, void *value),
+ unsigned int flags,
+ void *aux__prog)
+{
+ return bpf_wq_set_callback(wq, callback_fn, flags, aux__prog);
+}

It's just one jmpl insn, but still.

