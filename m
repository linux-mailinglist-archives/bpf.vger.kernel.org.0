Return-Path: <bpf+bounces-35381-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A275939D07
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 10:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E28111F22904
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 08:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F6E14C5A3;
	Tue, 23 Jul 2024 08:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ze3jQvti"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BA1DDDC
	for <bpf@vger.kernel.org>; Tue, 23 Jul 2024 08:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721725104; cv=none; b=PvVQ7mdmvLGDvAPcha//L2Owa7MqAXwB2/pWq5ErGOZEuv0YdJlQDak4ZWRjMjOIw/XmuH7ntRmClnGKpLCwbnzXAot59KcV0MqkWggP6MSfJCJvm6pW+1jSOAFnDUj9BWHQDi8SmKJDoUs6H7bL8EwKVHjmtmx7+W7oYIJgh+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721725104; c=relaxed/simple;
	bh=lwp8eaRFC6z/Gc1ob2Zs66/spXVlkV202kPq1Eml92M=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=stESKn0i8MRjYhsH9q9UUtD8M7fyNOvk/sfDC86jvez4+uZtsXq4U8zogSUYP6dc4HwOj7fW1fRY/KsA2Fs0+FOWPHGdPKgKjj8Njpk2KgyCNAXRLcvfPhvyhBk+RSxJzQCfr2LM6HBVaReN/hYupJkSm/fZMuz7NkXxmS3ZM44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ze3jQvti; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-39949ebafc2so8251995ab.1
        for <bpf@vger.kernel.org>; Tue, 23 Jul 2024 01:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721725102; x=1722329902; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=E47cn0oC1nchUV873sm7Ubu3fhZVA3n9JN11ZO7d588=;
        b=Ze3jQvtii10CBmHuAp8OGNgzLncL1zKbaQdhiaKCdg4mtgIDHV8qj985V/YZPdBPHa
         GvnLswOmPwTf0lmDiQ44akZEYLJWoOOLhNtAymRu6VDkVGax2VXQnH5VjqS2VNqHUux0
         MTIoioal9pnzA1MpBHQmm9ddGSudMBQly0Ewx/JbvlIIqIG/jylPZ0Wl/wEkeVGIs88m
         byExHkUomS4NQR1wGm0Ius3MdGK4JnhHbg6B0M5yTVky4w6Mw2OxamjbZ+nfYjpXZdIO
         XYCSPKcbQ9RSRHbNoyts32xjsiFyXjBVEaRdtCJ17s4m7UIW7ffXDJMuMdX7/7xEQMDa
         70Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721725102; x=1722329902;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E47cn0oC1nchUV873sm7Ubu3fhZVA3n9JN11ZO7d588=;
        b=CAn8e2pdRQ9cEnrbkOX9kqkj8EvEQoD5ouKIxQnCZEwvuwhjMbnY0KbkwOa3WSlnq+
         Yls9myBBmzDGn6nsl2Vn1V75Nv82dQDa9INC6RWs5cnDk+G4zca1bfqsBpeCkQN5N8xH
         4+ooMub1faBkRtqmLctVhjumUAd/hSsPFcOB/RqZoC0u+cojb6lN58rXcQha/UDgfcxX
         XtpKjC9kamKiCKBQrpz7ll4UwpvQkC1EUbLfDiMgiJZ9fZmltgm7y4iepXhZX7oNB/H7
         aon26tyl1QbzErNKCeI3YnazhT6Ih2kw/3kRynI6zSwojBd5bcAts5sz2E6ilwIk3YbE
         BMmA==
X-Gm-Message-State: AOJu0Yw4iAOSNL7icHy/SFeioL6SUxEGYkbO/FaBbpT4AjQSls+MwZc7
	RpL6wKvhHS9QJc/T2R1qcjayIMWuKE9perKmKen9q5pjPn1u5RP0
X-Google-Smtp-Source: AGHT+IHZ+dDqgLW/I2vRwq/x14sUaU8utKcXvsaQP0dfhw1UFTAaXAKcy/RMumK61kf2/DaGJLZmIA==
X-Received: by 2002:a05:6e02:1a2b:b0:382:e6eb:3645 with SMTP id e9e14a558f8ab-398e753cc66mr155314785ab.25.1721725101675;
        Tue, 23 Jul 2024 01:58:21 -0700 (PDT)
Received: from kodidev-ubuntu (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-79f0a5c84b1sm5892969a12.12.2024.07.23.01.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 01:58:21 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
X-Google-Original-From: Tony Ambardar <Tony.Ambardar@gmail.com>
Date: Tue, 23 Jul 2024 01:58:19 -0700
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH bpf-next v2] tools/runqslower: Fix LDFLAGS and add LDLIBS
 support
Message-ID: <Zp9wq1fRPdaU9/sE@kodidev-ubuntu>
References: <20240723003045.2273499-1-tony.ambardar@gmail.com>
 <f81c1c05642980981d82fbeef1e0f2afe30c993b.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f81c1c05642980981d82fbeef1e0f2afe30c993b.camel@linux.ibm.com>

On Tue, Jul 23, 2024 at 09:56:56AM +0200, Ilya Leoshkevich wrote:
> On Mon, 2024-07-22 at 17:30 -0700, Tony Ambardar wrote:
> > Actually use previously defined LDFLAGS during build and add support
> > for
> > LDLIBS to link extra standalone libraries e.g. 'argp' which is not
> > provided
> > by musl libc.
> > 
> > Fixes: 585bf4640ebe ("tools: runqslower: Add EXTRA_CFLAGS and
> > EXTRA_LDFLAGS support")
> > Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
> > ---
> > v1-v2:
> >  - add missing CC for Ilya
> > 
> > ---
> >  tools/bpf/runqslower/Makefile | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/bpf/runqslower/Makefile
> > b/tools/bpf/runqslower/Makefile
> > index d8288936c912..c4f1f1735af6 100644
> > --- a/tools/bpf/runqslower/Makefile
> > +++ b/tools/bpf/runqslower/Makefile
> > @@ -15,6 +15,7 @@ INCLUDES := -I$(OUTPUT) -I$(BPF_INCLUDE) -
> > I$(abspath ../../include/uapi)
> >  CFLAGS := -g -Wall $(CLANG_CROSS_FLAGS)
> >  CFLAGS += $(EXTRA_CFLAGS)
> >  LDFLAGS += $(EXTRA_LDFLAGS)
> > +LDLIBS += -lelf -lz
> >  
> >  # Try to detect best kernel BTF source
> >  KERNEL_REL := $(shell uname -r)
> > @@ -51,7 +52,7 @@ clean:
> >  libbpf_hdrs: $(BPFOBJ)
> >  
> >  $(OUTPUT)/runqslower: $(OUTPUT)/runqslower.o $(BPFOBJ)
> > -	$(QUIET_LINK)$(CC) $(CFLAGS) $^ -lelf -lz -o $@
> > +	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) $^ $(LDLIBS) -o $@
> >  
> >  $(OUTPUT)/runqslower.o: runqslower.h
> > $(OUTPUT)/runqslower.skel.h	      \
> >  			$(OUTPUT)/runqslower.bpf.o | libbpf_hdrs
> 
> Looks reasonable to me, but I don't quite get what exactly did
> 585bf4640ebe break? In any case:
> 
> Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>

I believe 585bf4640ebe added the LDFLAGS definition above but then didn't
include it in the runqslower target's compile command. I only happened to
notice while adding LDLIBS.

Thanks for looking at this.

