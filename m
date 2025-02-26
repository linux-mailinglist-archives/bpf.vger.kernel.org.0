Return-Path: <bpf+bounces-52634-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF91A45CD2
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 12:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09FE53AD517
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 11:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F01214803;
	Wed, 26 Feb 2025 11:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DVdemwKX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258D2212FB0;
	Wed, 26 Feb 2025 11:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740568369; cv=none; b=aFzV4IPfAgEV/WKuETn+dZJDFEelfUUpzoLYUMoXGHdN/A97rqT8UT+vV8xG95kbYuFoMzXdSM5GBGH1D6+DM+l44glOqWBVEqzk/NeyMO6ntV0A4mwFQAvKPOyiFXAAibf1HKRM/0Vm1sQGa4So5vf9vLPj7fb+dqfA2KTFiJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740568369; c=relaxed/simple;
	bh=0UlUDFrQTjxR5+TiaNCyX/ilCZ98LfsN6ADmFlOi+lI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ji8kQ+POMFghXJOununu4Sf93J3EPS46uRlEbSA4jOokQ7Sd9/L4fwccnQ4rLJNJNZXbccWVBJuUIb4u4CJix4MkFEGWHVhqx6p7v03x8jP9nLsLkXXLEJHrwpBVuOznuzYO4MUlIczpq7oaQZ/O1joeJ3vNSi4yqKuEC702Ysk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DVdemwKX; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-abb7520028bso898635266b.3;
        Wed, 26 Feb 2025 03:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740568366; x=1741173166; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HSX1gchtdLPsHJVZW3liHqT5F/QQ11+VlmXYOeh0zFY=;
        b=DVdemwKXeW/W/sQLj2J/v2CRufUJI+LzzODfgBMy2rZ5YmMGooPiQUY8NoKEansU5K
         PImt+I4aXKB0Slmc+dkZrCURbu+0F5uZnL2jkf0x7ltGsM83gK44KXKVIbSXUIh9DPFH
         IeA/cBO/MI3jGJYHT02MN3Vnr0o9rbtw2MDuMzFZC9XLHj/Q9JfrLWW+PEYiu/7zshiy
         Umn/x4rpj7DvaSSpV3LI+BZLXsyLBRto50s158x8weF8cQT6o1hJ5U7w9TlNtDbJl/ND
         FybW2INDbh1cfrzPjK/SKARZ3gTFXtLocbdQDNxWVI+X4gNnnV08J/Fmr9A6Nv92BwFO
         g6Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740568366; x=1741173166;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HSX1gchtdLPsHJVZW3liHqT5F/QQ11+VlmXYOeh0zFY=;
        b=UKEZbfl84vuzIdAKewf0J2cZ1cJUdMqstGWl7X4zXgkDs7IQd4ZJQXB+Xw8l3KhFBA
         I8tQPhriFx6YSk0SqGvdGLxrtyVHTlWsW7vkuf+e3md/TvY9aie4MHT3diY6XowOPHE7
         AE3XToU1u7p0M3UanHkGkDLWwyoSfOeCfL+yN3JGDKEhF1kig3XkwjmHcpICubenwVDT
         b7OIVQ6JrLJikYFnwkQ2aDKYo/nYmlIc/oK6ZV0VykaKR1Uqjj2Nsz5+V+mqUPnh8g5b
         Y7fUqStAEPY2EQYBBScyP27jsLSvDy+VCyO+2N2xbTRvkx5V7D0tNLJPcOiMeqXOAXvP
         fvSw==
X-Forwarded-Encrypted: i=1; AJvYcCUJk9tHUJP9RaNXYzpKZOgFUYmSpImsfBREAJ8LDCfvmeJtbKMYa4uzgW1qHGbgen6dN6+dW1861PsMvB6j@vger.kernel.org, AJvYcCWfJ0Ci/g7ZXbdVo/JewzRVhMbefcT3lRSvgxlm3TOOd4OTdzNmCTOM1/BGZSCYLyQddKc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDThznxkNgF5qnLrXihcgNSdY+L498hD4dOb7fDDE0nmGOJkr/
	rIK/xUji/F8mU9jolxNOOs7xa4aSwLouvVJUDLvPIq2Jqf551RMu
X-Gm-Gg: ASbGncug2qv3B6cpQQ1v1bhsq/HwlpfXaHvLVAlexcoPPyiklLscYZanjk3tYj7d80L
	6aFJj4J1AOPkB6N+aU5dWm/dnv0hKvgFu06Ag4nN/KmdmRES+Y4VbIVNfSHuF3k5eoWK9qDoth5
	BUZCmpA7I+73deJc2y2c+L4cK6qHU3FuGLhq1oE7fsTBu98rzoNp4di8pEQ6AWuIdm/Tj9WJRJX
	huax4TQPAYfRpGbCw04hOWnY6IQtYu1juo2i3I+oEruSM0fK/JmlVorQCR27vcPEk45O3hkOlMk
	03iqijwI91Vh
X-Google-Smtp-Source: AGHT+IFuag5Hh8iCN/4J2NNLM8BFpJbCM7MdvAPaAId6Hc9uWb70DG+3MrrwrflsCiucQcaMVkjZxA==
X-Received: by 2002:a17:907:72d4:b0:ab7:b6cb:b633 with SMTP id a640c23a62f3a-abeeee40310mr343858566b.34.1740568366130;
        Wed, 26 Feb 2025 03:12:46 -0800 (PST)
Received: from krava ([173.38.220.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed1cd5629sm305686566b.8.2025.02.26.03.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 03:12:45 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 26 Feb 2025 12:12:43 +0100
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Tao Chen <chen.dylane@linux.dev>, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, eddyz87@gmail.com, haoluo@google.com,
	qmo@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	chen.dylane@gmail.com
Subject: Re: [PATCH bpf-next v8 4/5] libbpf: Init kprobe prog
 expected_attach_type for kfunc probe
Message-ID: <Z773KxMF0N1nEFsH@krava>
References: <20250224165912.599068-1-chen.dylane@linux.dev>
 <20250224165912.599068-5-chen.dylane@linux.dev>
 <CAEf4BzYz9_0Po-JLU+Z4kB7L5snuh2KFSTO0X9KK00GKSq91Sw@mail.gmail.com>
 <d25b468f-0a84-45c9-b48e-9fd3b9f65b54@linux.dev>
 <CAEf4BzY85DmfwRruD4tnTj+UiRTk64k1N5vO69cdL1T7H+QTXw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzY85DmfwRruD4tnTj+UiRTk64k1N5vO69cdL1T7H+QTXw@mail.gmail.com>

On Tue, Feb 25, 2025 at 09:04:58AM -0800, Andrii Nakryiko wrote:
> On Mon, Feb 24, 2025 at 9:44 PM Tao Chen <chen.dylane@linux.dev> wrote:
> >
> > 在 2025/2/25 09:15, Andrii Nakryiko 写道:
> > > On Mon, Feb 24, 2025 at 9:03 AM Tao Chen <chen.dylane@linux.dev> wrote:
> > >>
> > >> Kprobe prog type kfuncs like bpf_session_is_return and
> > >> bpf_session_cookie will check the expected_attach_type,
> > >> so init the expected_attach_type here.
> > >>
> > >> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> > >> ---
> > >>   tools/lib/bpf/libbpf_probes.c | 1 +
> > >>   1 file changed, 1 insertion(+)
> > >>
> > >> diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
> > >> index 8efebc18a215..bb5b457ddc80 100644
> > >> --- a/tools/lib/bpf/libbpf_probes.c
> > >> +++ b/tools/lib/bpf/libbpf_probes.c
> > >> @@ -126,6 +126,7 @@ static int probe_prog_load(enum bpf_prog_type prog_type,
> > >>                  break;
> > >>          case BPF_PROG_TYPE_KPROBE:
> > >>                  opts.kern_version = get_kernel_version();
> > >> +               opts.expected_attach_type = BPF_TRACE_KPROBE_SESSION;
> > >
> > > so KPROBE_SESSION is relative recent feature, if we unconditionally
> > > specify this, we'll regress some feature probes for old kernels where
> > > KPROBE_SESSION isn't supported, no?
> > >
> >
> > Yeah, maybe we can detect the kernel version first, will fix it.
> 
> Hold on. I think the entire probing API is kind of unfortunately
> inadequate. Just the fact that we randomly pick some specific
> expected_attach_type to do helpers/kfunc compatibility detection is
> telling. expected_attach_type can change a set of available helpers,
> and yet it's not even an input parameter for either
> libbpf_probe_bpf_helper() or kfunc variant you are trying to add.

could we use the libbpf_probe_bpf_kfunc opts argument and
allow to specify and override expected_attach_type?

jirka

> 
> Basically, I'm questioning the validity of even adding this API to
> libbpf. It feels like this kind of detection is simple enough for
> application to do on its own.
> 
> >
> > +               if (opts.kern_version >= KERNEL_VERSION(6, 12, 0))
> > +                       opts.expected_attach_type =BPF_TRACE_KPROBE_SESSION;
> 
> no, we shouldn't hard-code kernel version for feature detection (but
> also see above, I'm not sure this API should be added in the first
> place)
> 
> >
> > > pw-bot: cr
> > >
> > >>                  break;
> > >>          case BPF_PROG_TYPE_LIRC_MODE2:
> > >>                  opts.expected_attach_type = BPF_LIRC_MODE2;
> > >> --
> > >> 2.43.0
> > >>
> >
> >
> > --
> > Best Regards
> > Tao Chen

