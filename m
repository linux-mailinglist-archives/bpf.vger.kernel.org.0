Return-Path: <bpf+bounces-42268-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35AFF9A187A
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 04:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 638131C214C7
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 02:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B39440858;
	Thu, 17 Oct 2024 02:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HpTBtomF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1837F381B1;
	Thu, 17 Oct 2024 02:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729131158; cv=none; b=hzJTbFYd5LjYofIoBcDoQStoQkR0Kxsx41/9zUeTVDWODsES7ALx4tX2RB2KxcpTZb3c64I6XU+aARwXRpntf+TJVibM2HNRkISI0Q0k4axdnRHIkqGdWKo8xA2PdPMguRrmvFo8F0j75Pqcp3A1rOd9CvGNbvyghxA5kKUJ0pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729131158; c=relaxed/simple;
	bh=3X/aa+utz5jDH73a9fDRq+CP3qSDZJghbwhbUwbRHqE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T8upPin1iHZ7065gYElA+7dz7HX62bGeN69r96lGnKf6Wg10s0U+duFQ07uZYytoiepFOkMf1PuDxFfKWfpbEXN+Rz5c4kJ6g8jaVMDSVh8R33sTXNOVfxba8FWsJc6uFcjCU9RKDl9nPIhcc3pBfXO7UB0CkZTAp98ochV08qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HpTBtomF; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-37d4b0943c7so263241f8f.1;
        Wed, 16 Oct 2024 19:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729131155; x=1729735955; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OmTG6YdjisKFMJ0yanxwuN5G0cVEGjbrhGRYGTlh2gw=;
        b=HpTBtomFppbTuMMEmXJLeRn0Ftjl+b8yNEuBA5wVd6Eq6dVW5ybe66XcnFemD1yb57
         dEiaPOzEup+qhts8QGl0YaYPs0g3z/mJiZTruLLgr0SuPFvheDuD+JKPtBc/Pwg90hlq
         532jdm945Lp9plNXAiHQDNvFSSva4iyuIE9SHJpjVDFLzrqWApXHTN9dPC8Pxh1nEYfk
         q0XUJNrQ3aL0BRG/YrGso+c8jOjWMX4sCtK8cRgRrau/XC5zqNHzGdWneAPRyDXMFXBZ
         ipVR7hPrk0ecLo9nr8EdvJvq7ZryMZexEK5KnvwcIflc0Pi5IRY1v08Otsk8msQcb4PY
         cFcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729131155; x=1729735955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OmTG6YdjisKFMJ0yanxwuN5G0cVEGjbrhGRYGTlh2gw=;
        b=WsKUnuV+lGKEE/nS0NyJyon9jqpLBdSEPFZw7PTaq04Q9HhaEV6b6eJfPo+zQ3DCqa
         1OmQ2dNB6ts2LpksU/2fnyyn/m9RUvaPyiiEvMx5emaNHHXXp8AJLbVIt12QSK/laqK7
         s127AskssH+bJiPEbAtLkJ1jBlqTBR4Ed3ttZRO9d9ZRu7qc4LBdy6Ru7wuTZVPGTNTm
         nQBmuPzVdHvaFtW6QIZXXMhYD9GqujHdlwuLITqZzDrKKkQfxYepKOz+ePt/+VUDGQL1
         klCXETFz1GqhY8/UmN2Jw0rvO+gTfMssYQoMH/30s+JBTrlyHEB2YQbhsuKso2CCyK0X
         A4HA==
X-Forwarded-Encrypted: i=1; AJvYcCW26LBFUbl9orKvelMo0MceJ+08Igw8QNuDJxTTUiv5LN1iW5l++mD+sMntE6tDjHV4P7k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuAe2GROAKF2GhpPKZwLu4q6pM/KnKqpQ0ID2MY5i0P8XLgjqz
	I41teY5kZX2fb41KdY5nbjA8Z1HuwiTuKB0Z7b+zcuyAVAFGIJRDKT4T56VAmBM0jbc12yBca7B
	HKmQIwsHuNAdphWBaxPf3Aqt3fHs=
X-Google-Smtp-Source: AGHT+IEDzGtM4KpcRkev7lGdVJXH3cPQIkR5mbMkzWvo1lrPNjXrN9fy99XreATmg97eMBHycDjZpuzwG5Ph6HsHE7w=
X-Received: by 2002:a05:6000:e51:b0:37d:452b:478f with SMTP id
 ffacd0b85a97d-37d86bb6b99mr3953220f8f.4.1729131155089; Wed, 16 Oct 2024
 19:12:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016024100.7409-1-dtcccc@linux.alibaba.com>
 <CAADnVQ+gL48HGcs0JyLfq17D-qXyeZEoBJwGgGTO1JcJ3Ykqtw@mail.gmail.com> <fa9600d8-2a6c-4c74-8e42-31d669c06b59@linux.alibaba.com>
In-Reply-To: <fa9600d8-2a6c-4c74-8e42-31d669c06b59@linux.alibaba.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 16 Oct 2024 19:12:23 -0700
Message-ID: <CAADnVQJT-wWpMJH-CiNEKuUHLwO0dKvjOaUJbzw5GGG0EqgRAA@mail.gmail.com>
Subject: Re: [PATCH] sched_ext: Use BTF_ID to resolve task_struct
To: Tianchen Ding <dtcccc@linux.alibaba.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, 
	David Vernet <void@manifault.com>, Peter Zijlstra <peterz@infradead.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 6:57=E2=80=AFPM Tianchen Ding <dtcccc@linux.alibaba=
.com> wrote:
>
> On 2024/10/17 00:57, Alexei Starovoitov wrote:
> > On Tue, Oct 15, 2024 at 7:42=E2=80=AFPM Tianchen Ding <dtcccc@linux.ali=
baba.com> wrote:
> >>
> >> Save the searching time during bpf_scx_init.
> >>
> >> Signed-off-by: Tianchen Ding <dtcccc@linux.alibaba.com>
> >> ---
> >>   kernel/sched/ext.c | 12 +++---------
> >>   1 file changed, 3 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> >> index 609b9fb00d6f..1d11a96eefb8 100644
> >> --- a/kernel/sched/ext.c
> >> +++ b/kernel/sched/ext.c
> >> @@ -5343,7 +5343,7 @@ static int scx_ops_enable(struct sched_ext_ops *=
ops, struct bpf_link *link)
> >>
> >>   extern struct btf *btf_vmlinux;
> >>   static const struct btf_type *task_struct_type;
> >> -static u32 task_struct_type_id;
> >> +BTF_ID_LIST_SINGLE(task_struct_btf_ids, struct, task_struct);
> >>
> >>   static bool set_arg_maybe_null(const char *op, int arg_n, int off, i=
nt size,
> >>                                 enum bpf_access_type type,
> >> @@ -5395,7 +5395,7 @@ static bool set_arg_maybe_null(const char *op, i=
nt arg_n, int off, int size,
> >>                   */
> >>                  info->reg_type =3D PTR_MAYBE_NULL | PTR_TO_BTF_ID | P=
TR_TRUSTED;
> >>                  info->btf =3D btf_vmlinux;
> >> -               info->btf_id =3D task_struct_type_id;
> >> +               info->btf_id =3D task_struct_btf_ids[0];
> >>
> >>                  return true;
> >>          }
> >> @@ -5547,13 +5547,7 @@ static void bpf_scx_unreg(void *kdata, struct b=
pf_link *link)
> >>
> >>   static int bpf_scx_init(struct btf *btf)
> >>   {
> >> -       s32 type_id;
> >> -
> >> -       type_id =3D btf_find_by_name_kind(btf, "task_struct", BTF_KIND=
_STRUCT);
> >> -       if (type_id < 0)
> >> -               return -EINVAL;
> >> -       task_struct_type =3D btf_type_by_id(btf, type_id);
> >> -       task_struct_type_id =3D type_id;
> >> +       task_struct_type =3D btf_type_by_id(btf, task_struct_btf_ids[0=
]);
> >
> > Good optimization, but it's also unnecessary.
> >
> > btf_id is already in btf_tracing_ids[BTF_TRACING_TYPE_TASK].
>
> Get it. Thanks!
>
> BTW, do you think we should add a zero check for
> btf_tracing_ids[BTF_TRACING_TYPE_TASK] here?
> task_struct should always be valid. If something wrong, resolve_btfids wi=
ll also
> throw a warning. I'm not sure whether to add a sanity check here.

Definitely shouldn't add run-time checks.
Build check may work, but feels overkill at this point.

