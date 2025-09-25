Return-Path: <bpf+bounces-69645-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11730B9CC61
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 02:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A66F64A0CE2
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 00:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C331D555;
	Thu, 25 Sep 2025 00:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ljVM/hCJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EEF3D81
	for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 00:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758758549; cv=none; b=TiYhY088CMfViSr9wElhrWqVC+iCJxXlL0naZZRcnJkD6CcjDz46y0Vv0/GrAdKOyrD9MWZNdRv18xtq1tSsThWoYrkYV1NkmADPUgq7IsG9MSk6FJHYtuJ88UpVtbEd+KSALKBJE9VgA8xCb7lZNzMcYiIlwhEj7leApCBNkuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758758549; c=relaxed/simple;
	bh=3bSWejdzliNRKfpUltbhOkq/V6Lr5/KrINiAl42tWK0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S91rC8r8HYL7+JVtOncuOOLRoBafnkmVDnKu+6w7TYXNSMJqbmhv0pO5dtra9/4DDP640LdhuIHMj6IKd8lyaWdHprHDXJ7IFszOqou//yn2Sq/616IkkD9EtmJY/QJGZ7hjaYVRl2zFOA/BqIoTh4Ip3h0i8W4cI1nxv9ugicE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ljVM/hCJ; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-329e1c8e079so348001a91.2
        for <bpf@vger.kernel.org>; Wed, 24 Sep 2025 17:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758758547; x=1759363347; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8p8Pcpsa79tWydfQdcG1gA4lhqNasQtUIaAh5CVqkdI=;
        b=ljVM/hCJsXoCWD5wC23zyKLZ9nZSpHUrEcLkLboFpACNuwQ7O1Zn4iHWNmuCNvEIqP
         pCWoreJem3KeH07BR9NKI073hQ0xFxOVi8J0RnPN0DJmRiXqiNdEw+OxyHsPCW3PxqT8
         1VNsV26FyyCvTuTsuLSdu2LQrdIpGZT0umUFx3Cp0b496kfvh56xW7g+3mByyNZn0KgH
         yrJBJFevUz+7POpNsKSTgQPefS+PbCI8pQdDkE3wxYL4C5h363ECgxD7hp+QmBafeLpn
         GdGO5WuXfy1zGvZm78zcPkWqoTHzh3c5XfPntTNcw/N6a5HiYE46/U7ra4IDeiUsnhsx
         Ef5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758758547; x=1759363347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8p8Pcpsa79tWydfQdcG1gA4lhqNasQtUIaAh5CVqkdI=;
        b=eN0McSDmETJ0SnY3yAk/79372CtgaLI6bxoUIRPDH7Kxb4q+ZcND24JuUNwHchKq5M
         ftgm6ZJd99uNys5levHTUPwIKf+ozBhD6LAbJq1dOAn3TrSNvivilFCxBIM0SSHeJCBe
         6sYJ8J0sf9uPEm3C6uLk1TgPjkrEsB8tt1WTrFOG3wgjl7RmQToJjy9OR8n0a3hDWOM6
         6sqGVhczSNy8X1t2OayYSA2WfZMMCvLYiq+Dxe0zry3mkINYAwdQmx1N6KutPFS9+lxs
         Jywe6+cY1DLJI7kSinbNvvVAMUyK1Ng/IfNStBGfPfU8oXrb1HY6fk6h1SbtiVi8oBQu
         byfA==
X-Gm-Message-State: AOJu0Ywk5xCpcf4HkFkYhpOIvmefFWnSc+nqhQUwVXvt6eC8FpgkuXya
	CuX2rCmQOjadTL2CnaRX63A8Fyabw0Dzjg3wPq82wYaM7x8qxJndtWBxKcgf553o6dDsUsrgPcX
	QUWk3rsIoIVL96ACHcePzschtKaikQmc=
X-Gm-Gg: ASbGncsQrjApeiSCewmiLfdcCy0aO9IVnciJ5A8PDBHvKPh3DqekeCYJN7stjjWNStx
	YjP4WuJSaHLzm1cYj4Q935kHnIIfGeRULQndNpSlv2mWYQLuOcqevNG/90TuBYd0SDYU1BerZnr
	rDsb4P2PIksPyinO7VZPbx3HpMw7xXHdXc8fpicZeXBrzfBUCl7UNVXCU/d7Id5Ay7crEtWKkix
	cXcBBMJjIQujVJ/PM1R2nTX4o5BOfJ71Q==
X-Google-Smtp-Source: AGHT+IH8eZINtRT2w1KuT0bXhGrN5wRjKbKI/xVF59zjbjGPfUc0eyUMVEADPrVizb3caRy8xbup5h5rLsI6cGWVl0A=
X-Received: by 2002:a17:90b:1e0a:b0:32e:d9db:7a86 with SMTP id
 98e67ed59e1d1-3342a249a01mr1282193a91.7.1758758547301; Wed, 24 Sep 2025
 17:02:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911163328.93490-1-leon.hwang@linux.dev> <20250911163328.93490-6-leon.hwang@linux.dev>
 <CAEf4BzZ5R-H+XL6TPftv6KGFnowA1yeCXii7OZ9uq_A-zFrjJg@mail.gmail.com>
 <CAEf4BzY233bt3NdVu8tp7VVmyNWVk-DQB+wQ-uchBJA4Ya3p-g@mail.gmail.com> <2e8a73a9-67b9-4d87-844a-c43571055605@linux.dev>
In-Reply-To: <2e8a73a9-67b9-4d87-844a-c43571055605@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 24 Sep 2025 17:02:10 -0700
X-Gm-Features: AS18NWD2Si6cw9CmoWyWQ-VnMmIaZ2V-dZW7ktc_Q7MLTHJHsqxS1_JDFjsfipk
Message-ID: <CAEf4Bza+1nnkqRY7-LkOsuL62c5Jh+RusvWi8YH22GiLKHgvmA@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 5/6] libbpf: Add common attr support for map_create
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, menglong8.dong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 9:40=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
>
>
> On 2025/9/18 05:46, Andrii Nakryiko wrote:
> > On Wed, Sep 17, 2025 at 2:45=E2=80=AFPM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> >>
> >> On Thu, Sep 11, 2025 at 9:33=E2=80=AFAM Leon Hwang <leon.hwang@linux.d=
ev> wrote:
> >>>
> >>> With the previous patch adding common attribute support for
> >>> BPF_MAP_CREATE, it is now possible to retrieve detailed error message=
s
> >>> when map creation fails by using the 'log_buf' field from the common
> >>> attributes.
> >>>
> >>> This patch extends 'bpf_map_create_opts' with two new fields, 'log_bu=
f'
> >>> and 'log_size', allowing users to capture and inspect these log messa=
ges.
> >>>
> >>> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> >>> ---
> >>>  tools/lib/bpf/bpf.c | 16 +++++++++++++++-
> >>>  tools/lib/bpf/bpf.h |  5 ++++-
> >>>  2 files changed, 19 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> >>> index 27845e287dd5c..5b58e981a7669 100644
> >>> --- a/tools/lib/bpf/bpf.c
> >>> +++ b/tools/lib/bpf/bpf.c
> >>> @@ -218,7 +218,9 @@ int bpf_map_create(enum bpf_map_type map_type,
> >>>                    const struct bpf_map_create_opts *opts)
> >>>  {
> >>>         const size_t attr_sz =3D offsetofend(union bpf_attr, map_toke=
n_fd);
> >>> +       struct bpf_common_attr common_attrs;
> >>>         union bpf_attr attr;
> >>> +       __u64 log_buf;
> >>
> >>
> >> const char *
> >>
>
> Ack.
>
> >>>         int fd;
> >>>
> >>>         bump_rlimit_memlock();
> >>> @@ -249,7 +251,19 @@ int bpf_map_create(enum bpf_map_type map_type,
> >>>
> >>>         attr.map_token_fd =3D OPTS_GET(opts, token_fd, 0);
> >>>
> >>> -       fd =3D sys_bpf_fd(BPF_MAP_CREATE, &attr, attr_sz);
> >>> +       log_buf =3D (__u64) OPTS_GET(opts, log_buf, NULL);
> >>
> >> no u64 casting just yet
> >>
>
> Ack.
>
> >>> +       if (log_buf) {
> >>> +               if (!feat_supported(NULL, FEAT_EXTENDED_SYSCALL))
> >>> +                       return libbpf_err(-EOPNOTSUPP);
> >>
> >> um.. I'm thinking that it would be better usability for libbpf to
> >> ignore provided log if kernel doesn't support this feature just yet.
> >> Then users don't have to care, they will just opportunistically
> >> provide buffer and get extra error log, if kernel supports this
> >> feature. Otherwise, log won't be touched, instead of failing an API
> >> call.
> >>
>
> Agreed.
>
> These two 'if's will be merged into one:
>
> if (log_buf && feat_supported(NULL, FEAT_EXTENDED_SYSCALL)) {
>     ...
> }
>
> >>> +
> >>> +               memset(&common_attrs, 0, sizeof(common_attrs));
> >>> +               common_attrs.log_buf =3D log_buf;
> >>
> >> ptr_to_u64(log_buf) here
> >>
>
> Ack.
>
> >>> +               common_attrs.log_size =3D OPTS_GET(opts, log_size, 0)=
;
> >>> +               fd =3D sys_bpf_extended(BPF_MAP_CREATE, &attr, attr_s=
z, &common_attrs,
> >>> +                                     sizeof(common_attrs));
> >>> +       } else {
> >>> +               fd =3D sys_bpf_fd(BPF_MAP_CREATE, &attr, attr_sz);
> >>> +       }
> >>>         return libbpf_err_errno(fd);
> >>>  }
> >>>
> >>> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> >>> index 38819071ecbe7..3b54d6feb5842 100644
> >>> --- a/tools/lib/bpf/bpf.h
> >>> +++ b/tools/lib/bpf/bpf.h
> >>> @@ -55,9 +55,12 @@ struct bpf_map_create_opts {
> >>>         __s32 value_type_btf_obj_fd;
> >>>
> >>>         __u32 token_fd;
> >>> +
> >>> +       const char *log_buf;
> >>> +       __u32 log_size;
> >
> > also, what about that log_level ?
> >
>
> Should we really introduce log_level here?
>

yes, at the very least for API consistency. bpf() syscall's log is a)
buffer, b) size of that bufer, c) log_level / flags. Let's keep it
consistent.

> I don=E2=80=99t think it makes sense, because logging in map_create is to=
o
> simple for different log levels on the kernel side to have any
> meaningful effect.
>
> Thanks,
> Leon

