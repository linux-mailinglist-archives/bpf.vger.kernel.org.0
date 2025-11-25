Return-Path: <bpf+bounces-75486-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DB4C8676B
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 19:09:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A32423A3422
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 18:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683AD32C92D;
	Tue, 25 Nov 2025 18:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MXIBuKys"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737FA2512E6
	for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 18:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764094173; cv=none; b=DGtinCbDIpGVXNph/8HvFHp1uqfKqPDArhx0GKSpxMKocV0BERPQot6+723YGFpj/sbLWnhqQA8wD/lzsRU7z6d8+2rjALL/ky311VtUYsxbNQvgvPzxOu5gCNv1M/Z50XrD6830zah4Vi9JVdO9t1+nhoO8yNle54Y8mx4qGIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764094173; c=relaxed/simple;
	bh=ZaCWiMgstn7nTBo+iZMAGV8wK/vR1o5i3IH5dDzLN/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B6BTr+5Llw7udw3X08C2y75x6ZzfWw392OwGcMeereNbwSDV7jSOuyOEJblKL6mPlGxW2ldTmr2CFFOzkoN0AsyjtwbfBw7pdKVuodj5AKTbR+3XUY/P7w9rXF5YOjI7SAFaJ4AyaoeQH+TNCXu0nJeE6QP+YuzledgUkOWn/zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MXIBuKys; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764094171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VaP5r2WF0NQOUygG1QUNsqxGUL+netXL3q2fn1MfCgE=;
	b=MXIBuKysGaEkkjL9xTfbbeMXrpGtF1xSFV8d+Nj777UlNSEDerfp6if5Ed7vFMgi4oMHLC
	HsuTgvw93tC6Xob3A0fZWGrosd4IQJRavk/igfBAnGfjN5ymScUF82kRLP/pY2f6v8Pm2X
	apXgxMxttwXZv9ZzrGpIW9yEW9S+O5o=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-v78FIXp_Ooeo_yNU5rqj9g-1; Tue, 25 Nov 2025 13:09:29 -0500
X-MC-Unique: v78FIXp_Ooeo_yNU5rqj9g-1
X-Mimecast-MFC-AGG-ID: v78FIXp_Ooeo_yNU5rqj9g_1764094168
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-5957ecd65c8so4669064e87.0
        for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 10:09:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764094168; x=1764698968;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VaP5r2WF0NQOUygG1QUNsqxGUL+netXL3q2fn1MfCgE=;
        b=swma/uf2QOTAhCDcgCEUxorj21bocnNtXlLmExp/KIEyUT+pECyGU5rfqewnUwTaKw
         8+RGpeKXA29Wq7Zjjm1gqD+J/UzMn5L3A7AWce+jo0oBDrX7AbucdtOL5FjMlZVO3xXx
         LlQVar824MYJkQxajso4kFs2uiIGdGt/GOXD+OptYICjnWw0aJ0pDKXUoplHaH/trIf0
         QE3UwOPb5dFn80rQ5M3RbYCSfJSWkNS/OZEpFXiivw3l6SauXk6G9lKzQZ9lU0h97dcm
         M6QZxZR42nM+WFepCw+8dvNIRenZNXAvgEXbaXDaIKG7pWGMzFTUrAXAsOAc8AlvJAsD
         OJhg==
X-Forwarded-Encrypted: i=1; AJvYcCVMqz3bTOuT81ZMreU1Qylvv/yepEXMjBvnrslhwHKIxLXQZgBWdax/buMwUhFB4HkvRy4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyDH1gE7j4qzHg5YGBQEEAm3BZ7eHvpZV3s4m22Wg7y/o5ti5J
	HWJUI6x+RnCr0vaEPV4XCLdLLrxyy4g8kVwidOG44JB1jTb5h/shtkD2Fq7lMlEtzXP0ArB3Zqf
	Ym0epg+e1hk/Cze/mMng1/D0sc1u5f1I3TSBjJJNwHT9CD5OmWNAKUQNBdy46v66pwaX0Dgq29R
	4noeFGoxMNsu+xz/FKdCmEj8l2Wktv
X-Gm-Gg: ASbGnctf8JuiQ8N911cJ7it3gka6PLTvetHRKHLu00WXvtourJqqVlZWNzTvJkKKDdK
	BltyTcyjfaSMMFOaWbqK7Yg39hyZApv5XM5VcL4/IhNl5F1MTUifIYZ5mnWlkqGOKoDKisCoqjZ
	OUt3h56Ck5Lt5/vMeGzoHWwaZKCSVURQg1VDAmL2l47Zht5NA2CpH2+CrbdswZWoJitQ==
X-Received: by 2002:a05:6512:39c6:b0:595:7bc3:133d with SMTP id 2adb3069b0e04-596b5046c83mr1598706e87.11.1764094168038;
        Tue, 25 Nov 2025 10:09:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFj9U31QBJxo0s+PPFfLtHCeUvLeFgn6GBmL9Wl9fbFjEaVZ/6i/71QdkrtIFvmLStQP4lVXhQRcK330bgO9PU=
X-Received: by 2002:a05:6512:39c6:b0:595:7bc3:133d with SMTP id
 2adb3069b0e04-596b5046c83mr1598694e87.11.1764094167593; Tue, 25 Nov 2025
 10:09:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251117184409.42831-1-wander@redhat.com> <20251117184409.42831-8-wander@redhat.com>
 <fb5b468b38ac9570a5f3fb948452d1b5b03c9f9c.camel@redhat.com>
 <CAAq0SUn=eK+9YZZhdL_bs0S2cfVMhuuV-v8DSRMkTOqoL=SEWA@mail.gmail.com> <99c2109dd8c4b65be34f5ee00575a267da10b002.camel@redhat.com>
In-Reply-To: <99c2109dd8c4b65be34f5ee00575a267da10b002.camel@redhat.com>
From: Wander Lairson Costa <wander@redhat.com>
Date: Tue, 25 Nov 2025 15:09:15 -0300
X-Gm-Features: AWmQ_bnRq1iq0xoYJwCmnH92Jl-x8xVbQmo2RiV7AnrVIx2PzbBwiU9tMK5MTnk
Message-ID: <CAAq0SUkchNE50vJEsZDBDQBp88KgzJNJdxaMz=p30h49mxFSHA@mail.gmail.com>
Subject: Re: [rtla 07/13] rtla: Introduce timerlat_restart() helper
To: Crystal Wood <crwood@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Tomas Glozar <tglozar@redhat.com>, 
	Ivan Pravdin <ipravdin.official@gmail.com>, John Kacur <jkacur@redhat.com>, 
	Costa Shulyupin <costa.shul@redhat.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	"open list:Real-time Linux Analysis (RTLA) tools" <linux-trace-kernel@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:BPF [MISC]:Keyword:(?:\\b|_)bpf(?:\\b|_)" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 25, 2025 at 2:36=E2=80=AFPM Crystal Wood <crwood@redhat.com> wr=
ote:
>
> On Tue, 2025-11-25 at 11:20 -0300, Wander Lairson Costa wrote:
> > On Mon, Nov 24, 2025 at 9:46=E2=80=AFPM Crystal Wood <crwood@redhat.com=
> wrote:
> > >
> > > On Mon, 2025-11-17 at 15:41 -0300, Wander Lairson Costa wrote:
> >
> > > > +
> > > > +                     if (timerlat_bpf_restart_tracing()) {
> > > > +                             err_msg("Error restarting BPF trace\n=
");
> > > > +                             return -1;
> > > > +                     }
> > >
> > > [insert rant about not being able to use exceptions in userspace code=
 in
> > > the year 2025]
> > >
> >
> > I actually find exceptions an anti-pattern. Modern languages like Zig,
> > Go and Rust came back to error returning.
>
> Maybe I'm behind the times, but I see exceptions and error returns as
> complementary... not everything should be an exception and I can
> certainly see how they could be overused in an anti-pattern way, but
> they're nice for getting useful information out rather than "something
> failed" without having to add a bunch of debug prints.
>

IIRC, you do get stack trace from the error returns. I think Golang
didn't/don't by
default. Exception as an alias for "panic()" is fine, IMO. What I've
seen in production
is services down due to unhandled exceptions. One of the reasons is
that there is nothing
in the function signature that says if or what of exceptions it raises.

> -Crystal
>


