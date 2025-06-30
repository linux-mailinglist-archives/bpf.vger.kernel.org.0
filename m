Return-Path: <bpf+bounces-61905-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EAC2AEEA06
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 00:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3354F3AED61
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 22:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1CFB242D93;
	Mon, 30 Jun 2025 22:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JOAqYe2q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A5021A453
	for <bpf@vger.kernel.org>; Mon, 30 Jun 2025 22:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751321506; cv=none; b=itNESHoUQcB6pcr6Kc7Git9zU0NSmR1cpMlrtNPOmo5u31QN0SYt7FpVX/JtMYSx2VqeQYgnom4wIgtjHiNAkX1n/IP9JqdLLJLdzkZHJCHMHAD5Fspdqa6+NbJ94LRR1Vvn6/oW6q5smPev3ArWUzBdQZDpCm2UPP91xmpF214=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751321506; c=relaxed/simple;
	bh=m91y99Z05F81tb0OiufZRVTgAEMtwFUetYth8nhHn1M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZFPzy0CYzD7UdyazWZMBopGEv2wmiPuA5VZRhML0YpHmX1qOn31WdFqr/hplP/+KY0+fgeTF3su4TsKy4l76f7S77yezxu4A1pshHJPki+rr2T8xt5HkdDX6HWLngobP5G0j3/0cGRxIGPKjaYt63b21+MOgoJqR9K6/t76dHk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JOAqYe2q; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-453426170b6so31783285e9.1
        for <bpf@vger.kernel.org>; Mon, 30 Jun 2025 15:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751321503; x=1751926303; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jPKPbvR1WuwzKlJ4cYJFtdJtxzZTeFbiGDD2gePmhBI=;
        b=JOAqYe2q9NDUZ3dE4Dy0dMaOgMGzwN2AVjO+j4tAav0ihbjnlTLYVphT6gDfSb6ci+
         bdA2KfFcLM82iq0gG+5Mao9nLh8HomvIhuUD9EwG6AS//wkUGgPvS9xmoKk5K2A/bKLB
         CznwKO6FcXKQxu1IROdgKBlksTak1Kx8KVlN+B+QtpCXSaIAytqNb3O9ixKsQzdMM97V
         5CXgzPKqtOpNDDUq9QxCv8V0Y/OnekDlA8Wp0/wk7SU2GCn6HWPNvObl3BFS7sfqxl8+
         3CBTyNYmrVBJ1F57vPH4xaK1YBbp1n8WJCsoQkjnopcR1mUk2uNOZ806EZuXTJ0JSPCU
         Z36w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751321503; x=1751926303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jPKPbvR1WuwzKlJ4cYJFtdJtxzZTeFbiGDD2gePmhBI=;
        b=GvZkiEBLJSWYU2EQTcsvB0PTFVhgSNIJ9bu7XlVU7X3Avjq9Eo+Romh7l7uFYZhugA
         l5FNSqhBMc5RnmldoFoxs+0Q7N1/n1Nu8+IxB+l48MgwBrMx5vNQZubkSfDTzDJJDHEM
         VAcJ+3nzLsK44F/ETXXZ9v5x1/sPI+MyuvKrxpA7wE/vC3KpoI2UyF0lTrFWKWJXp083
         9RepV/HwAH8y1qwJd/nTkdYd7OYHd/aQX5JEuk5AdjJnBHiowsoEfIKAkrgxZpfWeOSC
         5f5OmILoGrrt+lQMxk1usiW4yFtLqWYTRgj59f5nfult+TutWzTT9WGlj5sC9ggj+DZ8
         aLwA==
X-Forwarded-Encrypted: i=1; AJvYcCX8XCXLmcTGLskb+m5GDkPCAERUeNvNcRfiU/7E/7lR9uUdifUE7YzPuzZcltKbzlNJ7e0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgD7/r7JsSxWmtI20oGkcYzmrdxx6fjsig/1g1BmNQMNkJa2+T
	/oMQ3PMs932Sr3pAtnxFzojbvk9/jsLoo1eWx4UbPY4hwOrkOQi+X7EZthUBeIv+xMQKzPnLS4q
	ynGr9QS99IfRuxLHtnrvoseWwr9A27BM=
X-Gm-Gg: ASbGnctt7SNtqYfT7G9eK+Rp6J5zvExxSR/m+o3TYbjAi8WGayta2GcUQRiSrwKyiXw
	rgcgw3FCXdQhbem/0v/kbw7co1pH//8TP6Ed+sdIZkLtq4s5MyVpfeBdQBfo7BywPxPX3sJDz1V
	ZGcTzAZjTZG324qc69BOulpUeyUm5FhTFWqjOnNA2VahNasksdkH5ZfqsdareRHrw49X+FKsFR
X-Google-Smtp-Source: AGHT+IGdX8s92htXfad5ma4mK5wA3ZG6V2XcffiPO3zUSzbZ7R1Ju5bNPUutyTKZTW7ZmoYVrW873ppjHgN4sNvV8ZA=
X-Received: by 2002:a05:600c:64c5:b0:43c:f509:2bbf with SMTP id
 5b1f17b1804b1-453a79a70ddmr9976785e9.15.1751321502455; Mon, 30 Jun 2025
 15:11:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250627191221.765921-1-song@kernel.org> <839d4696-fad6-499b-a156-994951ea75c7@linux.dev>
 <CAADnVQL5vQ9e5TMYfUafkzEUU+akgVME=OFtbATeTkL-G8aKLQ@mail.gmail.com>
 <11bd7899-9ffe-48fc-8d0b-94ed3b9532ab@linux.dev> <CAADnVQ++H6qOvU7tYvcxh8NW-kshUPhTCuc=4w4JCZCeu_zcdA@mail.gmail.com>
 <9583e9fd-72aa-4d83-ac1b-6aaf018c418a@linux.dev>
In-Reply-To: <9583e9fd-72aa-4d83-ac1b-6aaf018c418a@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 30 Jun 2025 15:11:31 -0700
X-Gm-Features: Ac12FXxIs7StxNuUwVLJFNboogdhlnmBWoj0_kSwdlElTA6nADsbpsn_3yPC5jo
Message-ID: <CAADnVQLcYZWjBVqAXR4QgpzubZ1R_5sWi0TmGs8dFDu+FNc3xg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] selftests/bpf: Fix cgroup_xattr/read_cgroupfs_xattr
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Kernel Team <kernel-team@meta.com>, Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 30, 2025 at 2:49=E2=80=AFPM Ihor Solodrai <ihor.solodrai@linux.=
dev> wrote:
>
> On 6/27/25 2:38 PM, Alexei Starovoitov wrote:
> > On Fri, Jun 27, 2025 at 2:36=E2=80=AFPM Ihor Solodrai <ihor.solodrai@li=
nux.dev> wrote:
> >>
> >> On 6/27/25 2:34 PM, Alexei Starovoitov wrote:
> >>> On Fri, Jun 27, 2025 at 2:19=E2=80=AFPM Ihor Solodrai <ihor.solodrai@=
linux.dev> wrote:
> >>>>
> >>>> On 6/27/25 12:12 PM, Song Liu wrote:
> >>>>> cgroup_xattr/read_cgroupfs_xattr has two issues:
> >>>>>
> >>>>> 1. cgroup_xattr/read_cgroupfs_xattr messes up lo without creating a=
 netns
> >>>>>       first. This causes issue with other tests.
> >>>>>
> >>>>>       Fix this by using a different hook (lsm.s/file_open) and not =
messing
> >>>>>       with lo.
> >>>>>
> >>>>> 2. cgroup_xattr/read_cgroupfs_xattr sets up cgroups without proper
> >>>>>       mount namespaces.
> >>>>>
> >>>>>       Fix this by using the existing cgroup helpers. A new helper
> >>>>>       set_cgroup_xattr() is added to set xattr on cgroup files.
> >>>>>
> >>>>> Fixes: f4fba2d6d282 ("selftests/bpf: Add tests for bpf_cgroup_read_=
xattr")
> >>>>> Reported-by: Alexei Starovoitov <ast@kernel.org>
> >>>>> Closes: https://lore.kernel.org/bpf/CAADnVQ+iqMi2HEj_iH7hsx+XJAsqaM=
WqSDe4tzcGAnehFWA9Sw@mail.gmail.com/
> >>>>> Signed-off-by: Song Liu <song@kernel.org>
> >>>>>
> >>>>> ---
> >>>>> Changes v1 =3D> v2:
> >>>>> 1. Add the second fix above.
> >>>>>
> >>>>> v1: https://lore.kernel.org/bpf/20250627165831.2979022-1-song@kerne=
l.org/
> >>>>> ---
> >>>>>     tools/testing/selftests/bpf/cgroup_helpers.c  |  21 ++++
> >>>>>     tools/testing/selftests/bpf/cgroup_helpers.h  |   4 +
> >>>>>     .../selftests/bpf/prog_tests/cgroup_xattr.c   | 117 ++++-------=
-------
> >>>>>     .../selftests/bpf/progs/read_cgroupfs_xattr.c |   4 +-
> >>>>>     4 files changed, 49 insertions(+), 97 deletions(-)
> >>>>
> >>>> Hi Song.
> >>>>
> >>>> I tried this patch on BPF CI, and it appears it fixes the hanging
> >>>> failure we've been seeing today on bpf-next and netdev.
> >>>> I am going to add it to ci/diffs.
> >>>
> >>> Applied to bpf-next already.
> >>
> >> CI patches apply to all base branches. My understanding is, it's neede=
d
> >> at least for netdev too.
> >
> > How is that possible?
> >
> > The offending commit is only in /master and in /for-next branches,
> > while /for-next is there for linux-next only.
>
> Alexei, for-next contains offending commit, but does not have Song's
> fix. Right now it's the only base branch on BPF CI that uses the temp
> patch.

ok. updated /for-next

> We do run tests on for-next, so I suppose the patch should remain in
> ci/diffs until it's committed into for-next?

It's news to me that we run BPF CI on /for-next.
I thought we only do it on /master and /net.

