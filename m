Return-Path: <bpf+bounces-34113-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE6692A827
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 19:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63306B2157E
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 17:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3261147C82;
	Mon,  8 Jul 2024 17:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RHcpwr7y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B16EAD55
	for <bpf@vger.kernel.org>; Mon,  8 Jul 2024 17:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720459200; cv=none; b=PvFF1eeNK8g8902Wnhd1POsoWvaJTiFB99OIrsunJOU6PQxIN9T2URAsgF2oMh03+Mr3obGhx+JMO2YA41+aIlrHh1GYkqDZTszCYWsZ39AjN+lIlhmiTb2K2XXzl8W9XUsTMYKugE9kHGfRaG6mjDVUx/hZkAftbOK2CflRmwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720459200; c=relaxed/simple;
	bh=Pt1XWNg8ecfC8S53ZCPXq8nbjJgJI069kvIi5eyvIhs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ja2QLPxjSeYDdk1kTBBER3gy1cLuA23szYKLRQD+mFD2FrAlWaaNTWIe40KVwf4HvOmkFdG9EdbY1RihSMs1FRyamKdkCroPpCDzBpi1wEEEg5z6R+zMiNjFRVgCBY2EhYGeMwLJFtDnQfUnKZQRHzvT2HV5Qxcf7HBAUD+Y38A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RHcpwr7y; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-70afe18837cso2412554b3a.3
        for <bpf@vger.kernel.org>; Mon, 08 Jul 2024 10:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720459198; x=1721063998; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IXq14Jv/4kV1u6WmzV7m0esiqCkt95EsGgqz/wK/n3I=;
        b=RHcpwr7yVYkm2fhRDSuZ0/NIVsI5cqo6tFrfXNmd9lmDImJLDw576hVw1C3wGRYey1
         DtV5lMmbN8J4pNn979mqi3v0TAk3hDNhTL4UQ+CkSF5l8zEl5Ti6u9DwuPsJ3FVseT/J
         mar13nj20udrDzAxa3lLtaVgR8b+qjaSWRZdpWp6dopxfG5NXFU05zui9FQSVcdnJJpo
         vmbw9QgtzsTXey17tV9bWgWNsnITSS7itsSOtr0ljjJgwnpvh0jdJQZ/Zq1FCUnddyn3
         6s7EoLcF9jtidpkclesneCZFJQIaaWrrMq1dvv1wL6TQJMyj8LTRCVZiy8/cZMLmHfjR
         PgIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720459198; x=1721063998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IXq14Jv/4kV1u6WmzV7m0esiqCkt95EsGgqz/wK/n3I=;
        b=wGns12XYKPVXQHjMvstf5U7ORuORCOOnkyH+oaeDMrXOTmJP9QujaAugu4svpL/mFt
         19twDJEWr/a1VcmTbJf3bG0gNrlUeEFuzz73m0BSp+cae7yDQIAfCAHj+zXHiD6APSu5
         f0hQceaF3Wtl8VMLF1nmtSrUyJefqxK69xO9geLoyE/gFEyAqKSdGxu0qfduxbqtxz83
         xBYma65d1SgjX//lCgJ01N5eWFg54EIiccg6Xrfwv+PjDXTutFURKh/+s699Imny5QMx
         f5QchJZJZfq1IaDsEVyci09KOIoXfFJlcQE77x6+4d9e3llpDGUZF9pDXtO6yQoo3uBl
         R94w==
X-Forwarded-Encrypted: i=1; AJvYcCUSyQHwccSAeqlkHFlaNA6w3wGMcNULgb77MXle2MR8b/gZO4SxkignUgOl/qQWBgYHFeXNS2oFjo97f3hehMzXBXA5
X-Gm-Message-State: AOJu0Yy2DbNrdamhPy0kitG6IjEYpkue5kGUD1ynMxseA71VdqpT/5di
	0EtVz17tJvrXRX1Wkm9VExCWTdYZn1HqqIYt6iZub5OsHpTSq1kLFiBSqJ+WwLqNdvFQE/z+HIn
	R721InKdmVEUKA8bSt/v+69grnbY=
X-Google-Smtp-Source: AGHT+IFrOhktoFLmuJmROFAaIOq8G0OI8aacp9a3u0UWz1ZQa+o9oTDYMogJPx8r8Pm7KDkmYpEE1ne6RIMpSf4bfT8=
X-Received: by 2002:a05:6a20:7288:b0:1c1:f6f1:de05 with SMTP id
 adf61e73a8af0-1c298206687mr75845637.6.1720459198347; Mon, 08 Jul 2024
 10:19:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240704001527.754710-1-andrii@kernel.org> <20240704001527.754710-3-andrii@kernel.org>
 <13891abf-3c88-4369-8fe3-0fb8f5673038@oracle.com> <2b28deafbfdd5cccc0781bb95ebf8a966ceb6c74.camel@gmail.com>
In-Reply-To: <2b28deafbfdd5cccc0781bb95ebf8a966ceb6c74.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 8 Jul 2024 10:19:46 -0700
Message-ID: <CAEf4BzawG5L9B5GPDnNJDRoqnTycJkiWEphYTm1wdUdKR6-Paw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] libbpf: fix BPF skeleton forward/backward
 compat handling
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org, 
	kernel-team@meta.com, Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 4, 2024 at 1:56=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Thu, 2024-07-04 at 16:16 +0100, Alan Maguire wrote:
>
> [...]
>
> > Nit: would it be worth dropping a debug logging message here
> >
> >
> >         /* Skeleton is created with earlier version of bpftool
> >          * which does not support auto-attachment
> >          */
> > -        if (s->map_skel_sz < sizeof(struct bpf_map_skeleton))
> > +        if (s->map_skel_sz < sizeof(struct bpf_map_skeleton)) {
> > +             pr_debug("libbpf version mismatch, cannot auto-attach\n")=
;
> >               return 0;
> > +     }
> >
> > ...as it's a hard issue to spot?
>
> +1 for debug message, but this is not an error condition,
> so I'd say something like "..., skipping auto-attach for struct_ops".

agreed, thinking to make it info-level and only output if we actually
have struct_ops, so not to spam people unnecessarily

