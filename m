Return-Path: <bpf+bounces-73971-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59352C41110
	for <lists+bpf@lfdr.de>; Fri, 07 Nov 2025 18:41:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 187BF3A4619
	for <lists+bpf@lfdr.de>; Fri,  7 Nov 2025 17:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0003358DA;
	Fri,  7 Nov 2025 17:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CMcgFpqZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85307333758
	for <bpf@vger.kernel.org>; Fri,  7 Nov 2025 17:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762537273; cv=none; b=nQFjBYh8a7cHV03e5UhSKhz1LVZGB56xSAAbfncWFbbEVvQkYPZhDyJtumLfILochdnPTPS7cQl5A9iNF+1HY4e+JaV6d9H4GLoqB0RLAbwYno3YRJKhLUqoAsHZLEFY5rC19Yn66n4TyqXhSMZLDaDubp0VAGlqPfWJIoiZZWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762537273; c=relaxed/simple;
	bh=di5HYt605tX16tZ8/vaKsRinUBUUoU5Lq1QfVdIXGog=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fbkXPEaLo65pCbhINHUdgGEnnlcJVp2pUMWzCnbKAt8XXlnHLVqnj0CgNQKmcmF+Fp5D0TDd9tW1P9UPQ7B7M8NkTYMurwvs7/67H8XkOWiURUHx+d58gtCk1WQe4AV4Yz+6+eCvJ9dyayn7TBwEDj2+9yOSO8F3pjHdLCmagq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CMcgFpqZ; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4775ae77516so11680645e9.1
        for <bpf@vger.kernel.org>; Fri, 07 Nov 2025 09:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762537270; x=1763142070; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ebrs+wN1ScAdbwQrebQQor/ad4bv1DpNTmTftSXcwN0=;
        b=CMcgFpqZe/oxgipDhf5hoioX1i0DHFYgpYL4pOb7pz9GohREbu/y1fGOeFcqWZp2/a
         n05PmIsDwnh78FeiTT3/N+rMHOF2X6Yb7XlI1umdnQb5V4AOYofJEDKUnPtgwR2DGpFa
         R1L76mW/bU3F92g6U74j7K1Z1yDnP/B8lPFSPvB9iJ/VBu+N0ymdZu3w5Hki2sCrNCTq
         y+g2bYLDYeXeJ8WY1pBd4QkHkJCo+ilve0qV9f3MqthChSCso5ohUBsBiNjuiEcuL9mM
         vSHCpLOsyHoBrHEJJBfEpRdeAPYiPtm4MTg2WU9yRamhmvHS2Jum7zvmMhwAZJZqN7qi
         eFOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762537270; x=1763142070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ebrs+wN1ScAdbwQrebQQor/ad4bv1DpNTmTftSXcwN0=;
        b=cbzksknI9qaBNO+fQieMYTsTkIoS+BUa2BG86RPbNF1lLjJiFtYGxL+0Z3Rj4y8xX8
         2e1JH1IV/6Kit53OUl2ClYOIhsuQXnx257hjXCdoqCOzzI8h9k1+wUt+oY8wBX0mivaW
         D94fiHRbKfVyW45YGfJp4BFXKhoTQr+15yLOjol3o2aQr8opZ+l2A/Ko7wThBTI/ghUF
         T3+DKNWOi+yPPll/GP3nOyJk6vwDs/y0B8JvJ+dU6uiNAq5OrBXV8IaW9YZUJxDsR2t6
         mzeoLkI05HHq2ngq8MqFOmkwFYM2SX41SL+MmhXNNKLBDo+VjohAjz3B+ZdhnO5wJb2T
         jCyg==
X-Forwarded-Encrypted: i=1; AJvYcCW6Ja0BF/Q93YLHUwujiUJ+x6VUusliK7xWNE9I38gPf2KU0lR+vprz+xmPPCJdlUMrsSg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7JwPrayrJymtL6fQFBnAbNsyfr9ZYJY93xIlHrMu9DzwruVNN
	glVubyLO/uguk1RyfnF1AhJKucAUVC4h/K9T8VVUoe8TcZj4Mww4xP867rCXWgIJgOqhv6qAp+F
	pPx6kjL+qKEZ+XhxCWi30awgVmgBPXIw=
X-Gm-Gg: ASbGncuTZXZlW1asNKYe0cPZ54rXCKAg9gNAU5fu7+lFCqqIGXIQ0gVXlwuyVDPVIJf
	W2G7oNVvPEI+oBOfCvHZLsW4STwuE375IAFekOEiXe8Roq1MGZNnxmgFEhboYY2Z+EuU4CVF5fF
	djVelCzWKW3mBG8ULBhjOBWwJN2Gass38J0N3/KS2bvHEJthDm4wuINho/P7IbN+3kzuC1bNFdW
	pkHBjA1agG9hq3a88hquqgTyNTHrvECqiA+HH0RisNnMivWYnLAdynK7WHpG1JhYB5KlZqc21uu
	fg5Ql/vpzO6A+Nfl5aSVRm31J2lEy3autzmHWh4=
X-Google-Smtp-Source: AGHT+IGp7kJ7DPn6W1TJBQil5AyrS3gfjJGyOVkoIQA+7AMrhZauVz76TN8srDIORbwUd/LWwQX0PHgCg3hdmEyhYfc=
X-Received: by 2002:a05:6000:184b:b0:429:c989:ceaf with SMTP id
 ffacd0b85a97d-42aefb436c6mr3589088f8f.46.1762537269792; Fri, 07 Nov 2025
 09:41:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105142319.1139183-3-pmladek@suse.com> <451acb410ee1ce42f7fb2da9f3b8162708f40788cb849cc0f50851ad16813349@mail.kernel.org>
 <aQ3w0awU61mrS_AF@pathway.suse.cz>
In-Reply-To: <aQ3w0awU61mrS_AF@pathway.suse.cz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 7 Nov 2025 09:40:58 -0800
X-Gm-Features: AWmQ_blok1LYmBhcs5jqmjitBnxB1MxfCx6dTvXIZc5Oxu7WIxc0TZwB0cXRC_A
Message-ID: <CAADnVQ+tbHC25R_qwJsZL2G9VM1kseOviQ8mAsaTNg68-2nWBw@mail.gmail.com>
Subject: Re: [PATCH 2/6] kallsyms: Cleanup code for appending the module buildid
To: Petr Mladek <pmladek@suse.com>
Cc: bot+bpf-ci@kernel.org, Petr Pavlu <petr.pavlu@suse.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	"Luis R. Rodriguez" <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, linux-modules@vger.kernel.org, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Chris Mason <clm@meta.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025 at 5:15=E2=80=AFAM Petr Mladek <pmladek@suse.com> wrote=
:
>
> On Wed 2025-11-05 14:59:53, bot+bpf-ci@kernel.org wrote:
> > > diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
> > > index 1e7635864..9455e3bb0 100644
> > > --- a/kernel/kallsyms.c
> > > +++ b/kernel/kallsyms.c
> > > @@ -423,6 +423,37 @@ int lookup_symbol_name(unsigned long addr, char =
*symname)
> > >     return lookup_module_symbol_name(addr, symname);
> > >  }
> > >
> > > +#ifdef CONFIG_STACKTRACE_BUILD_ID
> > > +
> > > +static int append_buildid(char *buffer,  const char *modname,
> > > +                     const unsigned char *buildid)
> > > +{
> > > +   if (!modname)
> > > +           return 0;
> > > +
> > > +   if (!buildid) {
> > > +           pr_warn_once("Undefined buildid for the module %s\n", mod=
name);
> > > +           return 0;
> > > +   }
> >
> > When ftrace_mod_address_lookup() succeeds in kallsyms_lookup_buildid(),
> > it sets *modname but doesn't initialize *modbuildid. This leaves the
> > buildid variable uninitialized when __sprint_symbol() calls
> > append_buildid().
>
> Just for record. This is a great analyze. This patchset is fixing
> this bug in a later patch. ;-)

Currently AI analyses one patch at a time and comments on what it
understands the way humans would do if they read and comment
as they go.
Teaching AI to understand the whole series is on todo list.
Chris may comment on how feasible that is.

