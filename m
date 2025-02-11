Return-Path: <bpf+bounces-51091-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB86A3011B
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 02:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46FE618834E9
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 01:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9888B1D47A6;
	Tue, 11 Feb 2025 01:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A7hinud3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C433EA76
	for <bpf@vger.kernel.org>; Tue, 11 Feb 2025 01:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739238289; cv=none; b=fQotl1MfEsSvUrS57UdPTtLxihRdfWpUUcqnag3jzugAEbUXu5KUVr/Yrys9fpLLIX2AppiQnkaqo4mzGvjBwOrCnyR/8rgknPsWxwQi9/hMGKxnqDQebuxLVol34TZ2ijTBEiCjIWh9XIf/qLY/Ppe8ZL6d0eVx+IkZEZYtHek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739238289; c=relaxed/simple;
	bh=JYLZ8Q6zEhwggtmfYgX/O3GolTJ5UVFkoftRp9PeVZE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MiXN1+4HS9I9E9sEHCaFUwNkqy9Mr6NgieH7d5hfVvvk1Q4KhZeVwPTudbxaXLA2swrCDwjhYoceFY6kZEgsczj8jzllLEJeiJ/N81tmm9CG8QyZ3FBDBveqj1fnIiL/K8oo7+WAeJLPKbNBl5nu3nJIXjIOrJmGFmYudrAo6lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A7hinud3; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21f4af4f9ddso56895755ad.1
        for <bpf@vger.kernel.org>; Mon, 10 Feb 2025 17:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739238287; x=1739843087; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=S5JLi+/6txbi8k2zUqtJWHlza6ir67Ess1zh2873FdQ=;
        b=A7hinud398QKflUyp0irKdlgqVUXWqR4RLWsT6dRYX6TSu40/RE/fZ+CnkaFj9CgVP
         uSzPgfHjuc2+ujX7P25UAPs5EqHaxDqGQx+tFLmL/YJm4H08ar5sws/yoNzurxJfXCU3
         kDceLfpTBBNVrL7Ss18FJC+0EuOGpcjXc0PkXUmN1Cd37toaz7BBonjEohEyPArVyScX
         zHEPx7lCIvdUh9fc/d7r409OMn5TulTBAGGKgOV4dYWxcQgnsb+YJvTmTDgkTyjyplMx
         b9XFfNy4ewBbPz/4X+LmBfnkBrEVYycXEr5vZ/ag7DDtqeG+xOsA7wHrMWcWymmsg9yw
         PXOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739238287; x=1739843087;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S5JLi+/6txbi8k2zUqtJWHlza6ir67Ess1zh2873FdQ=;
        b=gqnyccjuAYzKAA16T1HG08blfZJQc4ykBSAsgyDfF6j0pQEcPUCe8qBTFwflru97fy
         S+gdIq7/mkgDuK0SAtzaVUUp8xRud9VBtB+QelMEAx1BRu/yQXOgJQmfV8FDyNBORoPU
         eAFjdOEodCkANWnohATlHArpBO3Q+k6h+fLU3YUwCjvIc8cIfRnvz8//KqyZvmsbwl0+
         YYYTufYs8/HdPsdZbuTr9eZ/tNnxh7kqIwt4XYI4yPxXQLbAr4cx4chVaopBq6+LDyyy
         XxfHj3gkAyMi5QxsTryDmwt6gToDMzIYfIu6abZUUDm3pUslHY5cCjg9/chthqcIIBbv
         pmtA==
X-Gm-Message-State: AOJu0Yx51hM8FwuOcm7wV5UBoFCj2F8zu9XeJfrrEg+rPY6wAa1MDmMb
	4d0wYEaofs8UTlJj6cpMJz4DKAQkEcnVr1vCE2w5EoGROzaztzZ4
X-Gm-Gg: ASbGnctXrAMTkIsAhnXmG8nxoBEHKEiDqYWS/nhJR7tQJlLw2hAJkxkpmc+CvQmlwhT
	Vrvqe56Cw8jadIcTsPDLtsgxy+SeoRrDNXuCwCmDjccBmP9K7ShU18nn5+CE+5noZwzL/hav2SR
	/XGgcCOMbf2LeiX/qPDGlOfYa67dV3tBjHLiSIIFu/QgmBdk4Q0B80nX4Hemy6/n5GtifIvw1sX
	+ryOqlxt8C4Yt5ifgQ54HUTY7PeKqYEHBaSbTN3xHMUdK4CBN7TT13KWM7Fz07vtOMZnskeiEuW
	JYY4MiDlm98U
X-Google-Smtp-Source: AGHT+IG/Xo1aeasa5ZnL5MMN9Ee5P7mAPjBHaHxE5cOukyBQ2wONY4X+hGie5/utuodThyQDA2nvhQ==
X-Received: by 2002:a17:902:f60a:b0:21f:6c3:aefb with SMTP id d9443c01a7336-21f4e75a349mr277293335ad.35.1739238287017;
        Mon, 10 Feb 2025 17:44:47 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f368cff88sm85301975ad.242.2025.02.10.17.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 17:44:46 -0800 (PST)
Message-ID: <fba26c0939c3de14527774cd3d466b2f7ca33192.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] selftests/bpf: implement setting global
 variables in veristat
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Mykyta Yatsenko
	 <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, 	kafai@meta.com, kernel-team@meta.com, Mykyta
 Yatsenko <yatsenko@meta.com>
Date: Mon, 10 Feb 2025 17:44:41 -0800
In-Reply-To: <CAEf4BzYVWSogUYk8pEPGs0N4eNb5fcXtmFMLkicokmqHPpbZCg@mail.gmail.com>
References: <20250210135129.719119-1-mykyta.yatsenko5@gmail.com>
	 <20250210135129.719119-2-mykyta.yatsenko5@gmail.com>
	 <CAEf4BzYVWSogUYk8pEPGs0N4eNb5fcXtmFMLkicokmqHPpbZCg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-02-10 at 17:13 -0800, Andrii Nakryiko wrote:

[...]

> > @@ -1334,17 +1634,6 @@ static int process_obj(const char *filename)
> >=20
> >         env.files_processed++;
> >=20
> > -       bpf_object__for_each_program(prog, obj) {
> > -               prog_cnt++;
> > -       }
> > -
> > -       if (prog_cnt =3D=3D 1) {
> > -               prog =3D bpf_object__next_program(obj, NULL);
> > -               bpf_program__set_autoload(prog, true);
> > -               process_prog(filename, obj, prog);
> > -               goto cleanup;
> > -       }
> > -
>=20
> I think this was an optimization to avoid a heavy-weight ELF parsing
> twice, why would we want to remove it?..
>=20
> pw-bot: cr

The v1 of this patch missed the case that globals have to be set in
both cases, when prog_cnt =3D=3D 1 and prog_cnt !=3D 1. I remember making
same mistake when debugging something unrelated. Hence I suggested
removing this special case.

> >         bpf_object__for_each_program(prog, obj) {
> >                 const char *prog_name =3D bpf_program__name(prog);
> >=20


