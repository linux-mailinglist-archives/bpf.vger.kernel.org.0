Return-Path: <bpf+bounces-43750-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B148F9B96E7
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 18:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60EBD1F21F2F
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 17:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2CD1CDA35;
	Fri,  1 Nov 2024 17:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j0it9Nem"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADE814885D;
	Fri,  1 Nov 2024 17:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730483695; cv=none; b=saBkf5nbsd/ZphToDdvffz4btaU9gYWgpApTZy2RyUEgJ5s5ktHaTO4V0WobWsOAUO3CziZer+TcoeUn+u7bFip7EV5forbngYSSpM/o4UymlAzj5LeevNvwSm7GFCguean1YYHkvfZ2PCtFiw08DFFvpn6vNVXyIrFLpbtc0CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730483695; c=relaxed/simple;
	bh=EGkqfd8c96O+Rb4F7Xo5wRnM4M4E4BFsxwNWtKe1GeI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AtHTgMJaJ0o9AKudXVYI6W5XLApjsoLM0XpwhrGh6qfh6AIQ2LUEwkv9ufEgCcF0DFRHKhc24zBPM/+bqoqrq/7dXLm0Ct0dYQW1vgDXhzILlw+SzCl/Ogj1sJkDENtTetNIMbu8PyRB5ohu+q2yZN9/d0Nb/pLFQwqWQJ/vyWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j0it9Nem; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7ee6edc47abso116556a12.3;
        Fri, 01 Nov 2024 10:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730483693; x=1731088493; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EGkqfd8c96O+Rb4F7Xo5wRnM4M4E4BFsxwNWtKe1GeI=;
        b=j0it9Nem9mO2lwXvRFeGRrcK7X27/aEf6qlG/qegaEipK6GwJae39gtn7az7a1m38Y
         h7Xa1ySO3UNcK2uIGuJfOayebjVMvdEONWwBGcb8tRDn0tWfUzlmUh36seKkccT/7M8Z
         J/gZyC73Gg7rjITdkJjBamR8NRXmCN9UrAFpdRKexSaQC8wqbuQNWc4T8QRmhpWR6ypV
         MxJHu3yWdqRRHhj4aldHsd76/ajDE2I88tA04M3qxmZu/H7GFt3nsw47YAQ0YSjvW8NI
         JSwrzc/eqV++nf8av4eZvzVPUfsJ7iS2Mkre2Y3x2QCSm+nLLXN5I6mvY58Ij5+Y43wl
         BEHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730483693; x=1731088493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EGkqfd8c96O+Rb4F7Xo5wRnM4M4E4BFsxwNWtKe1GeI=;
        b=NWBg15iZR6WvvCU6C4Te/EidYka0IsSC4uZilcmVWMN2jiv8qlqM4uuG9L9syKpNkw
         ybiS/ez+Xj2s60plq4Bmern2rqJFrAhsXffy/O/EJDY+tFAPJglq4LtcmrClrUgiIiI5
         OUzEWAa7zcSsQt8AG4/igmsDz2+tXJXgpJX8B2xzlqpTCHvbTbHB2i9HFUYN1f9QbLR+
         jZNposNm5CYo35UAY4n9kJGdVnhQVrgz/C1e3v8uYQOw6q4jJVdDRH81Pq2vTZFliciy
         E4eZ5FfrhD6S6hhbx9mOJdlNCaYblmxlgF67QZJZGqZOj1GrLCP5b1z2fB2y5HRCq0Mx
         JraA==
X-Forwarded-Encrypted: i=1; AJvYcCU1lPQN1xMAHM7ZR6Hw9LDqCszWIgBTZpaapOn035jpFoj27ISDuJSmhUA/e2r6LcJPLIA=@vger.kernel.org, AJvYcCUUbjDd8/79ZIOYS6iTLQPMEeCjLW/6L2bIHllthEKegvkgQHun38yw7U+RqOmkim0yohJDYO7rkuqBRJik5C4aYuFb@vger.kernel.org, AJvYcCUcslwOAuUbbfDJy7Rgnkdvgi1xxR13RpAEUWCJO8gnLqYvMoBy0gnPWKMU8s9cnLt/uxXW4xAsQ0RyudEZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwXv/4Z7qcmrwKy1eu/zfW0ikm/OamFh983jKJfcDx7XUpMoh2G
	rSiznTV4OuK4CXBBCHzKaIbPxCGOEIvKQM8pqvyt6gGMYEbjNz5tDEODZOPSqUgv+jxGnBinBub
	Qd5eWmWjzgoiWfgpdVUqygIRarnQ=
X-Google-Smtp-Source: AGHT+IG6nv9/XwtpnqwP2B7iSlv++f30WmqM4YXxtwsRw3knxqrVG4UWLaI/rDCow5d0mwGdA95fvmjZYqmzyQhz3g4=
X-Received: by 2002:a17:90b:380f:b0:2e2:8bce:3d02 with SMTP id
 98e67ed59e1d1-2e94c50d452mr6081821a91.30.1730483692753; Fri, 01 Nov 2024
 10:54:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241031210938.1696639-1-andrii@kernel.org> <20241101065558.4be28057@gandalf.local.home>
In-Reply-To: <20241101065558.4be28057@gandalf.local.home>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 1 Nov 2024 10:54:40 -0700
Message-ID: <CAEf4BzZrYM6HdoxLB1ru7SV6rH_-LTkS7JC0qCyUZSz-LW-wsg@mail.gmail.com>
Subject: Re: [PATCH trace/for-next 1/3] bpf: put bpf_link's program when link
 is safe to be deallocated
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-kernel@vger.kernel.org, mhiramat@kernel.org, peterz@infradead.org, 
	paulmck@kernel.org, jrife@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 1, 2024 at 3:55=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> On Thu, 31 Oct 2024 14:09:36 -0700
> Andrii Nakryiko <andrii@kernel.org> wrote:
>
> > In general, BPF link's underlying BPF program should be considered to b=
e
> > reachable through attach hook -> link -> prog chain, and, pessimistical=
ly,
> > we have to assume that as long as link's memory is not safe to free,
> > attach hook's code might hold a pointer to BPF program and use it.
> >
> > As such, it's not (generally) correct to put link's program early befor=
e
> > waiting for RCU GPs to go through. More eager bpf_prog_put() that we
> > currently do is mostly correct due to BPF program's release code doing
> > similar RCU GP waiting, but as will be shown in the following patches,
> > BPF program can be non-sleepable (and, thus, reliant on only "classic"
> > RCU GP), while BPF link's attach hook can have sleepable semantics and
> > needs to be protected by RCU Tasks Trace, and for such cases BPF link
> > has to go through RCU Tasks Trace + "classic" RCU GPs before being
> > deallocated. And so, if we put BPF program early, we might free BPF
> > program before we free BPF link, leading to use-after-free situation.
> >
> > So, this patch defers bpf_prog_put() until we are ready to perform
> > bpf_link's deallocation. At worst, this delays BPF program freeing by
> > one extra RCU GP, but that seems completely acceptable. Alternatively,
> > we'd need more elaborate ways to determine BPF hook, BPF link, and BPF
> > program lifetimes, and how they relate to each other, which seems like
> > an unnecessary complication.
> >
> > Note, for most BPF links we still will perform eager bpf_prog_put() and
> > link dealloc, so for those BPF links there are no observable changes
> > whatsoever. Only BPF links that use deferred dealloc might notice
> > slightly delayed freeing of BPF programs.
> >
> > Also, to reduce code and logic duplication, extract program put + link
> > dealloc logic into bpf_link_dealloc() helper.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>
>
> Hi Andrii,
>
> Do you want me to add this on top of my queue? If so, would it be possibl=
e
> that I can get a tested-by from someone? As I don't do much to test BPF
> patches.

Hey Steven,

Yep, this should go on top of Mathieu's patch set. Let me send v2 with
fixed up stub definition. Jordan gave his Tested-By and Alexei seems
fine with this as well, so I think it should be good to go.

>
> -- Steve

