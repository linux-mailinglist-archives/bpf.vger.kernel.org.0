Return-Path: <bpf+bounces-19197-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8716282754B
	for <lists+bpf@lfdr.de>; Mon,  8 Jan 2024 17:34:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E095EB22B44
	for <lists+bpf@lfdr.de>; Mon,  8 Jan 2024 16:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D65253E18;
	Mon,  8 Jan 2024 16:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="FJVNLQ65"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8230254662
	for <bpf@vger.kernel.org>; Mon,  8 Jan 2024 16:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dbeff495c16so574873276.3
        for <bpf@vger.kernel.org>; Mon, 08 Jan 2024 08:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1704731666; x=1705336466; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kMWWibImy+Q/qarsSyjsoWJg1cjdH7HjoRETI704KYs=;
        b=FJVNLQ65B3nnAG4gULP7tMOxDLMbPoHFOyCgweCSKtgRCqJihunfF7gQtDeJliFU81
         o77RIraDN4/W18iCyjTScXjuaRXf+DZPNDVN3BbFWQqXX/GcWjqScBkd8Gm5rzDKXpcc
         VDzrkTzW8LHXB0DjfK+grXLkSjjinvjBShYOd2ZIPtANIoHz0pFPqFd4lLv6Ep7yQ0t7
         ubvk3wDZ7CQRGofs3WESxWzWmOVv6V73m6DyM67BEF4ALmwTW16OisS18b5AFqb0r3Oe
         zqGGsxAGLGy02BtytbhGvNLakuV6y/VmABMchkDa/4wZ28d2C8SFLoL4XVr9nZNvRPTC
         wIbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704731666; x=1705336466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kMWWibImy+Q/qarsSyjsoWJg1cjdH7HjoRETI704KYs=;
        b=UwOKPrbdi4+Fh4OIydeFmctzMAZZaSiCmblArB7za0kU6NLL+N2a+IPPhs4iLZumPy
         7qc9mvjJDLPIdRY2udSXwc1iLeKsgCwbkwfP9NEWE3QxWeD1fqYXKZMEZ37Bg2QHIwse
         XPKPVre/tnyjF9NKiuXdV9Pekeb6a4HVPfdHftVfYvJqzhhXbTshgtR1Wj7WypRRddxf
         qOLw/wfzjvjk1HDLX1ekEtattgqV9Key5bFPDvym+iN47BLkmR9z0sOcVoYe/NzBJ4+/
         CpKhP/ElM4CjekV/zlapgIcnsQL6wdqjU5NVCER1eGcUshCytRiZNuRRRyYpKn0eRT50
         97XQ==
X-Gm-Message-State: AOJu0YyiHcfDs/lL3/kHyqYBDLh2gieSrpzwu9q1bj0huxnjhKyRcBej
	7LoMcpncG108wh6KI/prJySoNkOWSTSc1VXbox9O2oS49JPY
X-Google-Smtp-Source: AGHT+IGlY395brmv2wYoWYXJYNf17/winzvq96lagsm0hEeq374QG25W5HzI+NTTqj3YjZsBpB5T9zdgpxL80eHmBzs=
X-Received: by 2002:a5b:a09:0:b0:dbe:9c77:84ef with SMTP id
 k9-20020a5b0a09000000b00dbe9c7784efmr1338449ybq.19.1704731666364; Mon, 08 Jan
 2024 08:34:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213143813.6818-1-michael.weiss@aisec.fraunhofer.de>
 <20231213143813.6818-4-michael.weiss@aisec.fraunhofer.de> <20231215-golfanlage-beirren-f304f9dafaca@brauner>
 <61b39199-022d-4fd8-a7bf-158ee37b3c08@aisec.fraunhofer.de>
 <20231215-kubikmeter-aufsagen-62bf8d4e3d75@brauner> <CAADnVQKeUmV88OfQOfiX04HjKbXq7Wfcv+N3O=5kdL4vic6qrw@mail.gmail.com>
 <20231216-vorrecht-anrief-b096fa50b3f7@brauner> <CAADnVQK7MDUZTUxcqCH=unrrGExCjaagfJFqFPhVSLUisJVk_Q@mail.gmail.com>
 <20231218-chipsatz-abfangen-d62626dfb9e2@brauner> <CAHC9VhSZDMWJ_kh+RaB6dsPLQjkrjDY4bVkqsFDG3JtjinT_bQ@mail.gmail.com>
 <f38ceaaf-916a-4e44-9312-344ed1b4c9c4@aisec.fraunhofer.de>
 <CAHC9VhT3dbFc4DWc8WFRavWY1M+_+DzPbHuQ=PumROsx0rY2vA@mail.gmail.com> <6c2eb494-0cbf-4493-ae31-6dea519c4715@aisec.fraunhofer.de>
In-Reply-To: <6c2eb494-0cbf-4493-ae31-6dea519c4715@aisec.fraunhofer.de>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 8 Jan 2024 11:34:15 -0500
Message-ID: <CAHC9VhRcRT9DKtxmtamBCRvNF+dWW4MGx2KtS3CA3xcCGZf+ww@mail.gmail.com>
Subject: Re: [RFC PATCH v3 3/3] devguard: added device guard for mknod in
 non-initial userns
To: =?UTF-8?Q?Michael_Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>
Cc: Christian Brauner <brauner@kernel.org>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Quentin Monnet <quentin@isovalent.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
	"Serge E. Hallyn" <serge@hallyn.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>, gyroidos@aisec.fraunhofer.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 8, 2024 at 8:45=E2=80=AFAM Michael Wei=C3=9F
<michael.weiss@aisec.fraunhofer.de> wrote:
> On 29.12.23 23:31, Paul Moore wrote:
> > On Wed, Dec 27, 2023 at 9:31=E2=80=AFAM Michael Wei=C3=9F
> > <michael.weiss@aisec.fraunhofer.de> wrote:
> >> Hi Paul, what would you think about if we do it as shown in the
> >> patch below (untested)?
> >>
> >> I have adapted Christians patch slightly in a way that we do let
> >> all LSMs agree on if device access management should be done or not.
> >> Similar to the security_task_prctl() hook.
> >
> > I think it's worth taking a minute to talk about this proposed change
> > and the existing security_task_prctl() hook, as there is an important
> > difference between the two which is the source of my concern.
> >
> > If you look at the prctl() syscall implementation, right at the top of
> > the function you see the LSM hook:
> >
> >   SYSCALL_DEFINE(prctl, ...)
> >   {
> >     ...
> >
> >     error =3D security_task_prctl(...);
> >     if (error !=3D -ENOSYS)
> >       return error;
> >
> >     error =3D 0;
> >
> >     ....
> >   }
> >
> > While it is true that the LSM hook returns a "special" value, -ENOSYS,
> > from a practical perspective this is not significantly different from
> > the much more common zero value used to indicate no restriction from
> > the LSM layer.  However, the more important thing to note is that the
> > return value from security_task_prctl() does not influence any other
> > access controls in the caller outside of those implemented inside the
> > LSM; in fact the error code is reset to zero immediately after the LSM
> > hook.
> >
> > More on this below ...
> >
> >> diff --git a/fs/super.c b/fs/super.c
> >> index 076392396e72..6510168d51ce 100644
> >> --- a/fs/super.c
> >> +++ b/fs/super.c
> >> @@ -325,7 +325,7 @@ static struct super_block *alloc_super(struct file=
_system_type *type, int flags,
> >>  {
> >>         struct super_block *s =3D kzalloc(sizeof(struct super_block), =
 GFP_USER);
> >>         static const struct super_operations default_op;
> >> -       int i;
> >> +       int i, err;
> >>
> >>         if (!s)
> >>                 return NULL;
> >> @@ -362,8 +362,16 @@ static struct super_block *alloc_super(struct fil=
e_system_type *type, int flags,
> >>         }
> >>         s->s_bdi =3D &noop_backing_dev_info;
> >>         s->s_flags =3D flags;
> >> -       if (s->s_user_ns !=3D &init_user_ns)
> >> +
> >> +       err =3D security_sb_device_access(s);
> >> +       if (err < 0 && err !=3D -EOPNOTSUPP)
> >> +               goto fail;
> >> +
> >> +       if (err && s->s_user_ns !=3D &init_user_ns)
> >>                 s->s_iflags |=3D SB_I_NODEV;
> >> +       else
> >> +               s->s_iflags |=3D SB_I_MANAGED_DEVICES;
> >
> > This is my concern, depending on what the LSM hook returns, the
> > superblock's flags are set differently, affecting much more than just
> > a LSM-based security mechanism.
> >
> > LSMs should not be able to undermine, shortcut, or otherwise bypass
> > access controls built into other parts of the kernel.  In other words,
> > a LSM should only ever be able to deny an operation, it should not be
> > able to permit an operation that otherwise would have been denied.
>
> Hmm, OK. Then I can't see to come here any further as we would directly
> or indirectly set the superblock flags based on if a security hook is
> implemented or not, which I understand now is against LSM architecture.
> Thanks Paul for clarification.

No worries, thank you for posting to the LSM list for review and
consideration.  While it may take me a while to review something
(there always appears to be a backlog), I'm always happy to review
patches in this area and work with folks to find a solution.

--=20
paul-moore.com

