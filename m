Return-Path: <bpf+bounces-46165-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F979E5CFE
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2024 18:23:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70B1616C9E2
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2024 17:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE88224AF7;
	Thu,  5 Dec 2024 17:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="GhguT3/G"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793A9165EFC
	for <bpf@vger.kernel.org>; Thu,  5 Dec 2024 17:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733419416; cv=none; b=k/RRVLfhJd4FSWOMuzHDioygc97kS44tHh+lnn1UOPM4jbE7/D8CwQvpp1XKnOjyOVJgYsyMj9dmftaZLGwEbuJGgwFaVp4/CvjcK7qdqfN78wEuiQkLS4Wu5StzW64hIUh7H6WvNs5/JdXa5SyLGfz3jfvBb67PDUHr+zbiZiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733419416; c=relaxed/simple;
	bh=wMI4/bb4SWjA5UtkdbTHZdk+exNwNh61CLRoHxPcYDU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KlTeCXObnCeZRP1NIhooJ8puws8tEH8PDaPsbZuB2L1oUq+ZrAibe0my8sW+GHqXOOXnobn10OfEQekgKxE7zHO4TkR1DjSPV8MWpKarLvGzX4i+JWzCHIyyU84aGLPeZ8232bNQ5z4/VeVEWuX3tkOvXvRV3VWvBiIBW1FVXws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=GhguT3/G; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B5GPRc9008384
	for <bpf@vger.kernel.org>; Thu, 5 Dec 2024 09:23:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=DWBl9mOCGNUrBhofVG1s+spOqPm7dMAUTE1itvh26sw=; b=GhguT3/GY7jg
	d+c2nNH9y72d8IiZhJl2/ooWvCZzwKHgFJkE9SxmOEKFav+szHVI04w+JV+FIXpd
	yLC8xzer40UJ4ZPG0Edyyq4C/DrHgCqQtUpviagYUxDIoizHoEUVygbJ0hMU9l4W
	8Fzz6M93QsSyq+6ilomUdYcB6YQoyIgexmWEovgGMW1iExAY8WxG1vUTtRJ8jaky
	2TU7WbyvkgcGv+FPN3qAFRoTfwLUj40ty2YIzcxw/7D9UKERvn+asLuUY3+4czdC
	S7zPUK9uCjSZGK/QnZxEkxndp9tuDphCrui75kUpxUOGN/zN1F/V6i90gF6omtQ+
	TM3eD2TX1g==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 43bc4g20du-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 05 Dec 2024 09:23:33 -0800 (PST)
Received: from twshared11145.37.frc1.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Thu, 5 Dec 2024 17:23:32 +0000
Received: by devbig020.cln3.facebook.com (Postfix, from userid 546475)
	id 15932D1263D0; Thu,  5 Dec 2024 09:23:26 -0800 (PST)
From: Alastair Robertson <ajor@meta.com>
To: <bpf@vger.kernel.org>, <andrii@kernel.org>
CC: Alastair Robertson <ajor@meta.com>
Subject: Re: [PATCH bpf-next v2 2/2] libbpf: Extend linker API to support in-memory ELF files
Date: Thu, 5 Dec 2024 09:23:18 -0800
Message-ID: <20241205172318.3481555-1-ajor@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <CAEf4BzbZoq1pwq1CZShVzWELC0=eJycFvqPuDXOFEcyu9zYUpA@mail.gmail.com>
References: <CAEf4BzbZoq1pwq1CZShVzWELC0=eJycFvqPuDXOFEcyu9zYUpA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: D2C_72UcEMqQ6k4aRAbVR8C1MyR7BPmw
X-Proofpoint-ORIG-GUID: D2C_72UcEMqQ6k4aRAbVR8C1MyR7BPmw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

> >  {
> > -       struct src_obj obj =3D3D {};
> > -       int err =3D3D 0, fd;
> > +       int fd, ret;
> >
> > -       if (!OPTS_VALID(opts, bpf_linker_file_opts))
> > -               return libbpf_err(-EINVAL);
> > +       LIBBPF_OPTS(bpf_linker_file_opts, opts);
>=20
> this is a variable declaration, no empty lines between variable declara=
tion=3D
> s

I'd originally written it without the extra empty line but got complaints=
 from
checkpatch.pl. Is it ok to just ignore its warnings?


> > +int bpf_linker__add_buf(struct bpf_linker *linker, const char *name,
>=20
> why is the buffer name passed as an argument instead of through
> opts.filename? let's keep it simple and consistent
>=20
> and if user didn't care to pass opts.filename, just do some
> "mem:%p+%zu", buf, buf_sz thing

Just because memfd_create() requires a filename so I was treating it as a
required argument for this function too. Happy to change it to this
suggestion though.

All other comments make sense and I'll address them in the next patch.

