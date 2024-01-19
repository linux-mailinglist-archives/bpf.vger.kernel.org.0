Return-Path: <bpf+bounces-19879-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D85583255F
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 09:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42F231C21279
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 08:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53335219E8;
	Fri, 19 Jan 2024 08:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GhwwrWeu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F49DDD4
	for <bpf@vger.kernel.org>; Fri, 19 Jan 2024 08:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705651404; cv=none; b=QrK/POE1BQY2c9iEaMeuHsXWdx8V2fqUA+PDKdIUa9Wxkhmwd7hSgQWTqTA2D7AUjf4iSAuXzOBAKndYzq3MRrX2AdGRHB4D4/QBhfT9zi/QZTiMDfqBYyM522oPYK6Zby5p9RA6Nk0ot4mTIkm9rl8UDvezUFTk2BECICJpzbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705651404; c=relaxed/simple;
	bh=bwtB5rnF2uPUj8avDxDZiKzUFehzsQj9sfCGvkQ20CE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q4CL1Ks9ZeHzs5D68sJwMlPEwAuN2ut1wSGPZknokBux3sjYLEXg3++HuJEvsNG8HvNySraAicAodQ4RgHbmBlQU9xKjCeG7Hbgo2s6u/HikUmtDKthk0hUafrw32SCnexW53T3kVHF8F83GeM5liaZFGyG4e8DXu9WpEvQ+L9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GhwwrWeu; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-50e7ddd999bso552214e87.1
        for <bpf@vger.kernel.org>; Fri, 19 Jan 2024 00:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705651401; x=1706256201; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BUlcqhiwBSSyCBCx9G051HEujjt3b3AZTJz1/X662mc=;
        b=GhwwrWeuANQ8UvJqZ+ov2l1NU0O/KQi7/baECIMDf3pB6OfTqQzvHppMAfIU6j1pkL
         vO1Am6Nq6mJI4kdJa4w7TR3YoGx9pwL7/X4rwmpwS9uHX4BHfhvAAAB/yKHE04UExdr5
         pFTQ89TiprJ2rLWpJ8mK090p2BSLurG2NqIlnvslDYBUadZVMSA5nf9Lf8QJsG4p+Qhh
         SIJuzPe1ZYGNk91BeyWwjW9e+fYaHqJowPCOB0aoJZCyhvx9jfaFzcMWlkDTozgGJPMx
         fSs0XQsLcI+CV5ZISLOBz5DNpxAufdRyWHTOT817zlcLJgB/XpgDxKz4hVpKNahj8Fab
         Ix+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705651401; x=1706256201;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BUlcqhiwBSSyCBCx9G051HEujjt3b3AZTJz1/X662mc=;
        b=rYjDhYWOaJLYEopw1a3412OFbm0tKxxT4NUxHIB/ymRoMe9W3Fs0mwh1nUH/k8te1m
         KyjStU57f5lT7bulS0w/rBxN/1P5kHXRD2sE2g3CSsVHnCHiyFj9wEJtLojyBCjMgHWJ
         y0Z3gjlgrLHMAB4Owtg86Kaav13nwxDTTEb1q0zyhvrToRX8n7XkjuB+60VVsbCbpwdl
         jINE94OKBAYAK8JBKZEDi/iI+whuwPYF1xy4lG/difj3W9Z3xxY8NLRgItpLi1yXx7tE
         MV38gaKgBKHXcC8joceL1ikeeVYcQzG0tKyn0W/d35JX3M+rr5UwTH3rABw0lR443Kf2
         NAIw==
X-Gm-Message-State: AOJu0YxGI/qAgAolOtxFvQADe8Pi7Otb4VBwka+i+wmTP4DKeR56L2AY
	8lFuRbWL+YZNyn4pmmuvmUhviHg11x+mXAumh9SRlHNCn1rE4v0d
X-Google-Smtp-Source: AGHT+IEYIWoGBedbVlRxH4jfL+utXvLu1POyqFCJvYMBTNZzBqVZApOE5PfRebyXnXynlM13z5lmQg==
X-Received: by 2002:ac2:58f3:0:b0:50e:9127:8112 with SMTP id v19-20020ac258f3000000b0050e91278112mr397855lfo.17.1705651400969;
        Fri, 19 Jan 2024 00:03:20 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id c15-20020a0564021f8f00b005598e3d6d23sm4319237edc.16.2024.01.19.00.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 00:03:20 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 19 Jan 2024 09:03:18 +0100
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Quentin Monnet <quentin@isovalent.com>
Subject: Re: [PATCH bpf-next 1/8] bpf: Add cookie to perf_event bpf_link_info
 records
Message-ID: <Zaosxtg3Ko7ttJz1@krava>
References: <20240118095416.989152-1-jolsa@kernel.org>
 <20240118095416.989152-2-jolsa@kernel.org>
 <CALOAHbDnUaGtTAnrJthHV_U1Oz6c+2MeE7LQ6aqeW6y5cKt=OQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbDnUaGtTAnrJthHV_U1Oz6c+2MeE7LQ6aqeW6y5cKt=OQ@mail.gmail.com>

On Thu, Jan 18, 2024 at 08:24:58PM +0800, Yafang Shao wrote:
> On Thu, Jan 18, 2024 at 5:54 PM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > At the moment we don't store cookie for perf_event probes,
> > while we do that for the rest of the probes.
> >
> > Adding cookie fields to struct bpf_link_info perf event
> > probe records:
> >
> >   perf_event.uprobe
> >   perf_event.kprobe
> >   perf_event.tracepoint
> >   perf_event.perf_event
> >
> > And the code to store that in bpf_link_info struct.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  include/uapi/linux/bpf.h       | 4 ++++
> >  kernel/bpf/syscall.c           | 4 ++++
> >  tools/include/uapi/linux/bpf.h | 4 ++++
> >  3 files changed, 12 insertions(+)
> >
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index a00f8a5623e1..b823d367a83c 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -6582,6 +6582,7 @@ struct bpf_link_info {
> >                                         __aligned_u64 file_name; /* in/out */
> >                                         __u32 name_len;
> >                                         __u32 offset; /* offset from file_name */
> > +                                       __u64 cookie;
> >                                 } uprobe; /* BPF_PERF_EVENT_UPROBE, BPF_PERF_EVENT_URETPROBE */
> >                                 struct {
> >                                         __aligned_u64 func_name; /* in/out */
> > @@ -6589,14 +6590,17 @@ struct bpf_link_info {
> >                                         __u32 offset; /* offset from func_name */
> >                                         __u64 addr;
> >                                         __u64 missed;
> > +                                       __u64 cookie;
> >                                 } kprobe; /* BPF_PERF_EVENT_KPROBE, BPF_PERF_EVENT_KRETPROBE */
> >                                 struct {
> >                                         __aligned_u64 tp_name;   /* in/out */
> >                                         __u32 name_len;
> 
> It might be beneficial to include an alignment pad '__u32 :32;' here,
> following the pattern used in other instances within this file.

good cactch, thanks

jirka

> 
> > +                                       __u64 cookie;
> >                                 } tracepoint; /* BPF_PERF_EVENT_TRACEPOINT */
> >                                 struct {
> >                                         __u64 config;
> >                                         __u32 type;
> 
> Same here.
> 
> > +                                       __u64 cookie;
> >                                 } event; /* BPF_PERF_EVENT_EVENT */
> >                         };
> >                 } perf_event;
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index a1f18681721c..13193aaafb64 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -3501,6 +3501,7 @@ static int bpf_perf_link_fill_kprobe(const struct perf_event *event,
> >         if (!kallsyms_show_value(current_cred()))
> >                 addr = 0;
> >         info->perf_event.kprobe.addr = addr;
> > +       info->perf_event.kprobe.cookie = event->bpf_cookie;
> >         return 0;
> >  }
> >  #endif
> > @@ -3526,6 +3527,7 @@ static int bpf_perf_link_fill_uprobe(const struct perf_event *event,
> >         else
> >                 info->perf_event.type = BPF_PERF_EVENT_UPROBE;
> >         info->perf_event.uprobe.offset = offset;
> > +       info->perf_event.uprobe.cookie = event->bpf_cookie;
> >         return 0;
> >  }
> >  #endif
> > @@ -3553,6 +3555,7 @@ static int bpf_perf_link_fill_tracepoint(const struct perf_event *event,
> >         uname = u64_to_user_ptr(info->perf_event.tracepoint.tp_name);
> >         ulen = info->perf_event.tracepoint.name_len;
> >         info->perf_event.type = BPF_PERF_EVENT_TRACEPOINT;
> > +       info->perf_event.tracepoint.cookie = event->bpf_cookie;
> >         return bpf_perf_link_fill_common(event, uname, ulen, NULL, NULL, NULL, NULL);
> >  }
> >
> > @@ -3561,6 +3564,7 @@ static int bpf_perf_link_fill_perf_event(const struct perf_event *event,
> >  {
> >         info->perf_event.event.type = event->attr.type;
> >         info->perf_event.event.config = event->attr.config;
> > +       info->perf_event.event.cookie = event->bpf_cookie;
> >         info->perf_event.type = BPF_PERF_EVENT_EVENT;
> >         return 0;
> >  }
> > diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> > index a00f8a5623e1..b823d367a83c 100644
> > --- a/tools/include/uapi/linux/bpf.h
> > +++ b/tools/include/uapi/linux/bpf.h
> > @@ -6582,6 +6582,7 @@ struct bpf_link_info {
> >                                         __aligned_u64 file_name; /* in/out */
> >                                         __u32 name_len;
> >                                         __u32 offset; /* offset from file_name */
> > +                                       __u64 cookie;
> >                                 } uprobe; /* BPF_PERF_EVENT_UPROBE, BPF_PERF_EVENT_URETPROBE */
> >                                 struct {
> >                                         __aligned_u64 func_name; /* in/out */
> > @@ -6589,14 +6590,17 @@ struct bpf_link_info {
> >                                         __u32 offset; /* offset from func_name */
> >                                         __u64 addr;
> >                                         __u64 missed;
> > +                                       __u64 cookie;
> >                                 } kprobe; /* BPF_PERF_EVENT_KPROBE, BPF_PERF_EVENT_KRETPROBE */
> >                                 struct {
> >                                         __aligned_u64 tp_name;   /* in/out */
> >                                         __u32 name_len;
> > +                                       __u64 cookie;
> >                                 } tracepoint; /* BPF_PERF_EVENT_TRACEPOINT */
> >                                 struct {
> >                                         __u64 config;
> >                                         __u32 type;
> > +                                       __u64 cookie;
> >                                 } event; /* BPF_PERF_EVENT_EVENT */
> >                         };
> >                 } perf_event;
> > --
> > 2.43.0
> >
> 
> 
> -- 
> Regards
> Yafang

