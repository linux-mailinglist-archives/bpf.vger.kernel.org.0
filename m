Return-Path: <bpf+bounces-38333-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1009636ED
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 02:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB5CBB2363E
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 00:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16451D520;
	Thu, 29 Aug 2024 00:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eSS0rV0X"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8C6D29E;
	Thu, 29 Aug 2024 00:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724891953; cv=none; b=EamIfUELxeLIgpqZvTtZPqw5Y/WIEKoZU9NdbdZv0dkm2wRBppA0cOpshY6wMvZ8oK/dWsxr3oBB26FMOhbB4ImrBL2Y8fVFU8GOUS5kSbXzJJi4Jh+ek5urVDzfhreXj/aNZQFgq0qn0ylufAbdPDkkwGhO9pGJuxV97c+aUw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724891953; c=relaxed/simple;
	bh=J2YLgGYjd/b/kV9CeRRzCPpfAbhb2Ce+KbAMu2Y03ZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tvhmyDSVFktPI5mKSx2yaGHryAuFhdHG1HQ2wM29KLUGn58WA6k88TnuxJHpflUdq5ZD0is6MUC6uNYwsjzqxbL9CWD0RNfKRjraj9hAIlq62TX22JQWjdfGXLY78d3H61QOPuFzSUIlq83ThpnII/6DAlWD+lCh+y1HqsQsevw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eSS0rV0X; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4280ee5f1e3so828025e9.0;
        Wed, 28 Aug 2024 17:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724891950; x=1725496750; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fjJnLtLWNstwTkHqs3LEBcg+uL2ZjXsIciAHNDmGzio=;
        b=eSS0rV0XoiYGJ0y4N57T8lEiUEC0cUbSunktFoQ067+wAcXYqX4WaHqYQWmsmn7uKw
         GrfrRpzo4ohloQBl2q8lEMkOJwugqVVhNi8hWqRSQzpa/tc1NJC/SgE3RIocIF6i2+26
         MOKmAHMWOTKCM69qnR5lCi1Db+QL/FjXJDVhuc4o8WZnCRSskaESo3KoxUlIHKsYNjEn
         /ed9GHOs6fCExOKCVIkSKCpQ0fr0VR0X/kuWs/uCHcAd3yTKYJg26oXrBaJG0v5odSQu
         GkhA/K1EMdcBT4FTASD4VdF/Jc5ta0TiMqBQMGyBvS6X9XwM5XRYMdJ8wFvZpJVPUtd3
         dXrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724891950; x=1725496750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fjJnLtLWNstwTkHqs3LEBcg+uL2ZjXsIciAHNDmGzio=;
        b=ZIJAapCjIRv/pZHDcE4AuAid3XkOpKDJWjMAtM/rY+4i1n4oqq7uaZTl4CMQ5bc9Ij
         NcjJilsAj1oQpA663aLWQ5HkOej4XvH4fqVo2vMRoPLLb6gQBD5WlfRSrvt5zQqYaqnA
         0ZSI4WHtMoLw8Zri241OStN/J3+SvrgLIefq8V7Y0QDL1WZr4euJaWAiYWY8u/H4Sk7e
         VvYjHFEMEqcD97HAn/uIcNV9nKNPQ6CJl7c9YaWA7IWaTRqvMxICXd7yHjaqQHrBYK7W
         FAQxCnOXRp+bWoLV7AmxTpI9cl5PQnkprTQNaKpDIvnFBw9znTFCgy+7G8JeAuVBwfNU
         hqtw==
X-Forwarded-Encrypted: i=1; AJvYcCV8ET1kE8m1bYtof+vl/I54MGLw1M4R2erwfC725GKQmuO8qt/uwSVQH34HFkw0NCOuVwfstnXsYcoKVL3r@vger.kernel.org, AJvYcCVB1okW+dtzpTYLqdxt2IyQtq5m8HAbjsGsoUo5UkfXe3UfNyjSyIxkZwOklt7e/mmqFJE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVh8KrCWGFJpp9BQkAZbQyY0u1g0uyAI2zNEyzwZTT+07ilUC+
	z/l3l8WzzRGWQfPG+i+4JWKSm+Tyywx5U3nfZGHaKZs3g0ZzvA0IkeYizmcWzb8OjJwVqzNyLuS
	qyFfHeoHJMd0x1FQbhTwI/hwO7G0=
X-Google-Smtp-Source: AGHT+IFRB2hDOzUeHu3DxIIFBiTamW0y60MeePZMZ55td5yiJ2trZjJfXhyR7XmoRLvkP6HSAydbu+YSnhVS/YGwMfI=
X-Received: by 2002:a05:600c:1f90:b0:429:dc88:7e65 with SMTP id
 5b1f17b1804b1-42bb02ecb7emr8749245e9.12.1724891950133; Wed, 28 Aug 2024
 17:39:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AM6PR03MB5848874457E6E3E21635B18999952@AM6PR03MB5848.eurprd03.prod.outlook.com>
In-Reply-To: <AM6PR03MB5848874457E6E3E21635B18999952@AM6PR03MB5848.eurprd03.prod.outlook.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 28 Aug 2024 17:38:59 -0700
Message-ID: <CAADnVQJgHWXs-FiOtEX4qyyuAvXfXmbhrQ0c=Yn0NSH2oTGqXA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Add KF_OBTAIN for obtaining objects
 without reference count
To: Juntong Deng <juntong.deng@outlook.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, snorcht@gmail.com, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 1:05=E2=80=AFPM Juntong Deng <juntong.deng@outlook.=
com> wrote:
>
>  static bool is_kfunc_sleepable(struct bpf_kfunc_call_arg_meta *meta)
> @@ -12845,6 +12851,12 @@ static int check_kfunc_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn,
>                         /* For mark_ptr_or_null_reg, see 93c230e3f5bd6 */
>                         regs[BPF_REG_0].id =3D ++env->id_gen;
>                 }
> +
> +               if (is_kfunc_obtain(&meta)) {
> +                       regs[BPF_REG_0].type |=3D PTR_TRUSTED;
> +                       regs[BPF_REG_0].ref_obj_id =3D meta.ref_obj_id;
> +               }

The long term plan for the verifier is to do KF_TRUSTED_ARGS
by default in all kfuncs.
In that sense a PTR_TO_BTF_ID returned from a kfunc
has to be either trusted/rcu or acquired.
Currently we have only one odd set of kfuncs iter_next() that
return old/deprecated style PTR_TO_BTF_ID without either TRUSTED
or UNTRUSTED flag.
That is being fixed. They will become TRUSTED | RCU.
After that all new kfuncs should be reviewed from point of view
whether structs that they return either trusted|rcu.
So KF_OBTAIN is partially unnecessary.

But what you want to achieve with KF_OBTAIN is more than just TRUSTED.
You want to propagate ref_obj_id and we cannot do that.
When types change they cannot have the same ref_obj_id.
Think of sock_from_file(). If we add such a wrapper as a kfunc
it will be returning a different object.
(struct *)file !=3D (struct sock *)file->private_data
They has to have different ids.

The patch 2 is just buggy:
+struct mm_struct *bpf_kfunc_obtain_test(struct task_struct *task)
+{
+       return task->mm;
+}

This is wrong:
- mm has to be refcnted. Acquiring a task doesn't mean that task->mm
stays valid.
- ref_obj_id cannot be copied. It's incorrect from verifier ref tracking po=
v.

pw-bot: cr

