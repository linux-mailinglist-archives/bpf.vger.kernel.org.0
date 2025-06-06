Return-Path: <bpf+bounces-59824-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8541ACFB45
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 04:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E67F18944C1
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 02:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69EC58210;
	Fri,  6 Jun 2025 02:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R5caiqP1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB42F7FD
	for <bpf@vger.kernel.org>; Fri,  6 Jun 2025 02:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749177231; cv=none; b=BhYmAr1LliLxirsPfM5GBIkAgkQaxwTuBp1RzakuSEVJ3k8ujjKIUHxFv4ZJ+hvUM/x6G5EPbWUMvfFkDQmvCviFPs5W7ryqQUVN1dT1qTAG67WOq7If+uQSlkGF+cjjbzkElVAWd4x/jggF63cujZ9AAdL0TmElgDcHVCkvOq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749177231; c=relaxed/simple;
	bh=JxhybQXcTh+2RMCmQZf5Vodl6G1Gwxx6Hg6gwCVoWVk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dyriVuncFAufY2FsomGECg6/ro5VXt8UwVmvbwzWdyghEhONJ0PP1nVQWjcBYOyWAalpBFRN55hOzQJAFwXHkDtDTsZxksGS1m5nB2zonva00MDTccTfJQaK5yBVquMJcnULTsV3nMGp/afUOPj2A7JUI2z8t9gYik7qdCvjL6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R5caiqP1; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-742c5eb7d1cso1978146b3a.3
        for <bpf@vger.kernel.org>; Thu, 05 Jun 2025 19:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749177229; x=1749782029; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aIL2VFkhVTZDn2UHcKYfJx4Vw1Q4izxeGIoc5lwfaEA=;
        b=R5caiqP1yrJNVKhK34+kG+0Rf1MAceGBj83UikN4YjT8NA25/Wyj5n7edrfpnSwd6i
         RrqBx4ynIh4VDfhlh5EHNgw7xx7LZMbkkrm58Fj6akOzL2xwpO+tkOUJJpNVrNPy7S+4
         0jYTXfD2O7mpOfhjXLa2jq6qXVqZQnha0FjX21mq6aX6rtPE8qBOOyEmKHf3zjmI3Dh8
         SI1AHfZSrQT5WJh/dCdGsQ3xArwhoZVld5ylLmZQfvEI2hK3ZqK/Nig5twLqCFQqmACu
         LUwFpdDZNk1PQU7SdtM84vLQXQGhZH2tU6SUk+BK6CasU2bgO3kFJI3aw9eoSVowVEyG
         +UVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749177229; x=1749782029;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aIL2VFkhVTZDn2UHcKYfJx4Vw1Q4izxeGIoc5lwfaEA=;
        b=pAZfBtWVqwKNjMh6zAvGmAmRyjhluD5DWtV6S+1FHr7r8z0o2RymNfIx+8DwLtCKrk
         70its/8bGBLb2Lb5hrXi1ruOm6ZD5AAmLs94PrkRmall/ZFsR40ukGRJnKWvpWx2FT6Y
         d8/g9p0g0mBOYdVQNWu9TT3Lo4+Wi2rWcJTVCAXJeJbCNMP6lAZAN+JtzaREPzYt2hZc
         YM6VTCamutipivONWEFNh6Oh7dZoHs+txbCaUMtVgs6POlhOmxRpURNgVuAlJMh1SgM8
         dppROSpnAyJLfmg9r54JrrVBBvkFxOpw174szXpm/zN0yOimUKQRo/QZbiqRUj/wE5fD
         YtWA==
X-Gm-Message-State: AOJu0YzALAWjpAEwhTm1lH1INOjhfJ1zOVuVqjCU0ppxLq7Z7BqN9mhf
	KwPhBmJCkygp4sTdZKS9gv/ajdjvKP/4Em95tDIa36hNlA0ttdvIqTc2itSFTLGK
X-Gm-Gg: ASbGnct+2WV/2EcQJO604XvRwQYI53hrVjJoKqcwugemVhOLJeOqc9FdxOebsUYTCm5
	Ft+5E+uxPH4EGtxEE3OYid2XfNVwiwyp8ZFsu3r2sRLlQvCI0WAORfSQXE9N37Qqqeb2I0nOFcS
	l1wdBwywS0VQh/iJlYud+Ujj/kEdTETlDEQ4QALCuB5044erIRiSSiE3XwqC1HtDJzD5E8aFQ+u
	HAN9topYwggsCdx4PsMtna89wnPWMGJj+S5IkqFHE/qYRK9q8zLPW4ZQDyEetekIXP/NzqiR9q7
	C+HutqI2yOHF/pkC2u+SPQrHVYmDYL1zBCJJvImwT/Gd+HY=
X-Google-Smtp-Source: AGHT+IGGZ1tMw3XJx3xm+tgtvXK8kvVRSuLR5PT9A+OT/qB9K6MItwo63WhnUHO2zkJ58w31zneOXA==
X-Received: by 2002:a05:6a21:68a:b0:21a:ede2:2ea3 with SMTP id adf61e73a8af0-21ee250ce0dmr2093438637.17.1749177229065;
        Thu, 05 Jun 2025 19:33:49 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7482b0c6649sm327192b3a.113.2025.06.05.19.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 19:33:48 -0700 (PDT)
Message-ID: <d4bc026d37fc75f986abe276f2650feff0d4ad70.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 2/2] veristat: memory accounting for bpf
 programs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau	 <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>,
 Yonghong Song	 <yonghong.song@linux.dev>
Date: Thu, 05 Jun 2025 19:33:46 -0700
In-Reply-To: <CAADnVQKsfQSM76q88o38GboUrSuts9xEYAMZ=36AUCcrwG34Jg@mail.gmail.com>
References: <20250605230609.1444980-1-eddyz87@gmail.com>
	 <20250605230609.1444980-3-eddyz87@gmail.com>
	 <8bf346133b103ee586f7ffd1a47572f9ee000704.camel@gmail.com>
	 <CAADnVQKsfQSM76q88o38GboUrSuts9xEYAMZ=36AUCcrwG34Jg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-06-05 at 19:17 -0700, Alexei Starovoitov wrote:
> On Thu, Jun 5, 2025 at 6:04=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
> >=20
> > On Thu, 2025-06-05 at 16:06 -0700, Eduard Zingerman wrote:
> >=20
> > [...]
> >=20
> > > +/*
> > > + * Enters new cgroup namespace and mounts cgroupfs at /tmp/veristat-=
cgroup-mount-XXXXXX,
> > > + * enables "memory" controller for the root cgroup.
> > > + */
> > > +static int mount_cgroupfs(void)
> > > +{
> > > +     char buf[PATH_MAX + 1];
> > > +     int err;
> > > +
> > > +     env.memory_peak_fd =3D -1;
> > > +
> > > +     err =3D unshare(CLONE_NEWCGROUP);
> > > +     if (err < 0) {
> > > +             err =3D log_errno("unshare(CLONE_NEWCGROUP)");
> > > +             goto err_out;
> > > +     }
> >=20
> > The `unshare` call is useless. I thought it would grant me a new
> > hierarchy with separate cgroup.subtree_control in the root.
> > But that's now how things work, hierarchy is shared across namespaces.
> > I'll drop this call and just complain if "memory" controller is not ena=
bled.
> >=20
> > The "mount" part can remain, I use it to avoid searching for cgroupfs
> > mount point. Alternatively I can inspect /proc/self/mountinfo and
> > complain if cgroupfs is not found. Please let me know which way is
> > preferred.
>=20
> I would keep unshare and mount,

But what would be the purpose of the unshare?
I thought that it provides a new isolated new independent
cgroup.subtree_control, but that is not the case.
Outside from that the feature gains nothing from entering new namespace.

> and if possible share the code with setup_cgroup_environment()
> from cgroup_helpers.c

setup_cgroup_environment() does the following:
 a. creates a directory for cgroupfs mount
 b. creates a new mount namespace
 c. mounts a new empty root
 d. mounts cgroupfs inside new root
 e. creates a cgroup
 f. enables controllers

Of these only (a) and (d) are needed for veristat (and (f) is deligated to =
init).
Also my current version does unshare for cgroup namespace, while
setup_cgroup_environment() does not do that.

Things that might be reusable:
- get_root_cgroup
- remove_cgroup
- join_root_cgroup
- join_cgroup

These rely on CGROUP_MOUNT_PATH and CGROUP_WORK_DIR being constants,
I'll need to modify these helpers to parameterize this.


