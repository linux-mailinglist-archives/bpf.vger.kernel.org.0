Return-Path: <bpf+bounces-30152-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 468C08CB3E7
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 20:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABC611F2234F
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 18:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9D3147C95;
	Tue, 21 May 2024 18:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TNoxeFT/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B097F26AF5
	for <bpf@vger.kernel.org>; Tue, 21 May 2024 18:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716317669; cv=none; b=p4xCoHmj4BDn7W9zQAP6FA88N9ONG0YH/qyhR51J+F9Fm9YeR++F6I6lRPj+CcXlP1jNEIUNlutMd3O5y1mQSOa8hQgGU9jqY2Gk5lLbtzs1EpEKIcSF2vJRSM3c/1zK3ZrOoECBjareA1w/LVFyhxTRvgCSdS6P4Cpid1dAlhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716317669; c=relaxed/simple;
	bh=0agBoaXAjgbEvq66q9+uFQtr4XJIdYCHOH9KYlcYJ14=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hfYtZRJv+575cHmu5EDP/GYzt6zNa1oEZI6AJdRGsXcVbDQokN+DWrKt8w9gBXmBsFRdabLvhv162o2QPRHunY6aWou2sX+1vL2uOE9huIPFXqkaeMASRJmYbrgcejzmT11PxYIKP5QDYkWXaTYQxlu39o+fXLxWtQhUlZE95SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TNoxeFT/; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1ec486198b6so4276175ad.1
        for <bpf@vger.kernel.org>; Tue, 21 May 2024 11:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716317667; x=1716922467; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rpQZAYR099QaGhv2TUeiWWNC9V5at2Qqsa/7/icTdVo=;
        b=TNoxeFT/mar5/52XqL1GmtN+dv26BmPxIau/nCpcn+37wvbdD7pb+4iHRJcaLlV+Ni
         YbCUU6YEbpHLOA05Ge0HT4tSA75RaOs9sM6PLdhMq9UiHhIZHLoUvx9Ax5xNe2HvJd0o
         w+eRuTeWktX8ZTK+ZERopSfZmiHY3cytz9mDoQPgXslThpSdqfm9Varveeydznx4pfyt
         eZPLwpxwMRjUiCMLFdyXhd4jk/yHyxZnNmSUvw68u9xFDKJvZDSGOzMPDHjYEnLffQ3x
         1SDh/HzzzJAmwMbTMxeIRGu/XH5KNlvdhWsAoKbAIBtzE12cPXuxk9aSmFpzgBs0a2EU
         Galg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716317667; x=1716922467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rpQZAYR099QaGhv2TUeiWWNC9V5at2Qqsa/7/icTdVo=;
        b=dxkkvqO7hf82NfATo2KsbBUMQ6o9LXXf75O8ubtJVr9g6vuXeY8xg/WFOfpoyrICHf
         w563tFBTHq3P5Fcn91bn80T6vOOEgIBNBPNDaYYH9chHxlMDomyYaAuJbnmqMUJwDTcp
         dOwjLOBBM9n6yYT7O/1UyDC09OobOxU+keTUQsVGIG7MZwM/dfuqAcUCmUiyfk9gccT3
         EvVtK/SltlEUQHbXyNs0Zn7TmpO1fxTcOwVrPIWjh2AFhGLU8iOhCz1IjI1XgLCdUuPb
         0d6YOc5es/cXdV9JeTY2Q/uhrW+ouIi6vYQUkkQ77XO50Lk5589rY5JOYV13ByVpUbUu
         8Aiw==
X-Forwarded-Encrypted: i=1; AJvYcCWWs6Bop+RTHLKt0/yMaFE0EDCxGcHbdr2TZhGbriGOUzrVHihmyZKsg5AbKkOF/ZzI61dpAG2JVQk87ol1PlqxEMv9
X-Gm-Message-State: AOJu0Yw06hnb3plT3EvEHoNrRHpuWYWIT2Hyj4HzNa1xSwWF9AyJl+6Q
	ARMtvBO/0bkfTLFGdbcXhvFoJpiHNZiyTYnrK+K/YqnbwiYxIy137zwkLlRCP8d87rU1UEsQCPg
	ai2F/lPbBlZisp59VwzwNTZccXPQ=
X-Google-Smtp-Source: AGHT+IFRhMoULAn7R7WVa7f1UNWrBdng113twb2RKfsV8ekxfgin9FY4weQJEd89zatb1+ndCNrXKzI0hFKuqnxZF8g=
X-Received: by 2002:a17:902:f54f:b0:1f3:10ce:2ab3 with SMTP id
 d9443c01a7336-1f310ce2e63mr29880275ad.16.1716317666957; Tue, 21 May 2024
 11:54:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240517102246.4070184-1-alan.maguire@oracle.com>
 <b647e0d1d225f9d21e78c6ffedb722507f42eff0.camel@gmail.com>
 <3ae296b2-402a-4e17-b874-e067c57fc091@oracle.com> <81bbbbad95244dd74801497414c2cdad88815f83.camel@gmail.com>
In-Reply-To: <81bbbbad95244dd74801497414c2cdad88815f83.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 21 May 2024 11:54:14 -0700
Message-ID: <CAEf4BzbdoXTeTSx-1Vu+sA6MKphQq91p1TwnSkK3Yv3msa7h9Q@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 00/11] bpf: support resilient split BTF
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, andrii@kernel.org, jolsa@kernel.org, 
	acme@redhat.com, quentin@isovalent.com, mykolal@fb.com, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@google.com, haoluo@google.com, houtao1@huawei.com, bpf@vger.kernel.org, 
	masahiroy@kernel.org, mcgrof@kernel.org, nathan@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 9:19=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Tue, 2024-05-21 at 10:15 +0100, Alan Maguire wrote:
>
> [...]
>
> > This is a neat approach, and as you say it eliminates the need to modif=
y
> > bpftool to handle distilled base BTF and relocation.  The only wrinkle
> > is resolve_btfids; we call resolve_btfids for modules with a "-B
> > vmlinux" argument, so in that case we'd be calling btf_parse_elf() with
> > both a split and base BTF. According to the approach outlined above,
> > we'd relocate split BTF - originally relative to .BTF.base - to be
> > relative to vmlinux BTF, but in the case of resolve_btfids we don't wan=
t
> > that relocation. We want the BTF ids to reflect the distilled base BTF
> > ids since they will be relocated later on module load along with the
> > split BTF references themselves.
>
> You are correct, I missed this detail, resolve_btfids needs distilled
> base instead of vmlinux for out of tree modules.
>
> > We can handle this by having a -R flag to skip relocation; it would
> > simply ensure we first try calling btf__parse(), falling back to
> > btf__parse_split(); we need the fallback logic as it is possible the
> > pahole version didn't add .BTF.base sections. This logic would only be
> > activated for out-of-tree module builds so seems acceptable to me. If
> > that makes sense, with your permission I can rework the series to
> > include your BTF parsing patch.
>
> Makes sense to me, but I'm curious whether you and Andrii consider
> this a good interface, compared to _opts version.
>

Hey, sorry for delays, just getting back to reviewing patches, I will
go through this revision today.

I'm probably leaning towards not doing automatic relocations in
btf__parse(), tbh. Distilled BTF is a rather special kernel-specific
feature, if we need to teach resolve_btfids and bpftool to do
something extra for that case (i.e., call another API for relocation,
if necessary), then it's fine, doesn't seems like a problem.

Much worse is having to do some workarounds to prevent an API from
doing some undesired extra steps (like in resolve_btfids not wanting a
relocation). Orthogonality FTW, IMO.


> Thanks,
> Eduard

