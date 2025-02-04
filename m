Return-Path: <bpf+bounces-50425-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA27A27808
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 18:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6D22160B53
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 17:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2061215F63;
	Tue,  4 Feb 2025 17:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X+ykwxy9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC63C20C494;
	Tue,  4 Feb 2025 17:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738689107; cv=none; b=j255P3vC5WHrO0S4Q67kFtWbcAtMo6RK8+7+2XCK5kXYmJFm3td67NbJ93mVr9Cr0ZVfsx1/i83XafG4P6RpdhvSFs5euGfP3EzklAKwaUlPSSBugbV4hUxz1X/RoUButiL77swkRu08zVeydOmrhAKyLBHc025nyYhMmLQsf1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738689107; c=relaxed/simple;
	bh=byCYM8qSkT1AzKT0+shndeX3NZuiL6f+7MpBXusWsB8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=TTBho+685zIyn3u4vkZpubEraRTr9fB1e+JhvfeSYamc/Q702Qxf3HtV8pdh8n3mkIImM4L8jQZASb5A4HIp2JHLBKE6mhxd7OkR4S4OSSimHehbXC/T1zv0kk2JceqaiBfxshb9z3m5DD6lgn+cAJ0EdU9a+0xj6hVs/SO9e3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X+ykwxy9; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6dfbc45355bso61844326d6.2;
        Tue, 04 Feb 2025 09:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738689105; x=1739293905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=byCYM8qSkT1AzKT0+shndeX3NZuiL6f+7MpBXusWsB8=;
        b=X+ykwxy9RmOxYg7JWeUFXbQ3XbG6F6CnyGdsiiMt+HgdRLNu5Qf/yb7yRY5OPn3Tj7
         KES+wQ4N5DRjmx05g1W2YznzsboIgPrehg0qIVxnSaPC4VM2jMfvc7g+S9ZHsfj+5EZ0
         6xGdNZyKssAyNONaQXXcBFAaYjZmR0qPGREGgHdOonNHS36DEDzHoyuUehGSDiyTAq7o
         fCZgzidWOS/aWJZ9DvJCIPM6ijwtBecWP/Mb/xIlOHryKPmbKtleYdo3ck58G0DTUyP8
         pkDYU+4hR9FRwjXvIaSdp7IJaGv7/V8Rq/rYFOO1IRUWkU/vSVWxhrlUGzi1C50fuMCX
         EH4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738689105; x=1739293905;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=byCYM8qSkT1AzKT0+shndeX3NZuiL6f+7MpBXusWsB8=;
        b=O+uXd3KWXz6alte50mqivhSvjJ6jj6Tr4zWPXkqcnNOohc/Bm53rHc/2Dg5Um2jTd8
         Uyl27ahmYdzf9TK0nxXS+PSB6Ny8KvEIMlwRsrjFKl4W2wUWmzWW2lZ4nJgxTSrVJBj9
         2Mou33/Mw1dqMmglF/JN16PG589dr6K3VtJ0vDrh8UYPJacH2oUBug/ykoWJ5pA7UkJQ
         26wb0vY2tO25lQBxAmiIE2I1LqKZDjHJt7YxmcqUSpsDUi/xTLe/hUxDQyxYzjHRZKsn
         bngZKVTbSm/Xn9QtzlxLtjTDhOrdB2IQZso3cXlZdfAnF8M99aD/or49mOrgYsHxLN+L
         ahjw==
X-Forwarded-Encrypted: i=1; AJvYcCUhs0cUz46XRsFmle/3uimuqjlOcENNMyEdF8m2z/3EH83HFEB+3bMj4CXJDZZSVtD7pHOGbh8X@vger.kernel.org, AJvYcCWsmzIzyHCsTMDVvIbkReL1xF53guwuAejfYUk4D7Z5J/lgJhubisSe7BfJkRGG8nAJa40=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywyk/Xv1XFaxb5qZudVMn1oYlCU5rIySnn8PzGUaFwUcHkbkfxf
	AoKbGIk6tFuuJNZ2aAmG/MxaPB8kueo4u07Tk/msOJIagfnvkrFT
X-Gm-Gg: ASbGncsdIQgjcLU2SNG+DT0mLs9ZsWD5qMoZXjfqNBCL7VtLcnMhFjp8xKQl+Za1eCa
	4Te+1OtTvincmmppwgT/9HHhfF09Xu5vF5M4aAHc7WbrqXjJNUYRNeSx/H5LziMrO+Wso3nyTL0
	zeYR6O3gSZ9sXbPAeWKp7Ee9mZ2PiCq5+3Yyu4gK2XiBoNAJjY/wCp/0tTscOxLI/d+qZlpftcY
	VwTzQH33e9z/mVBB7WDbO9/Nca063DaEnO44fUfNDHU2vBjo9IAbE+3G1EXEJZ4WD16JtMhtGH8
	TXVTJSjPulN2ouJmjzCjlATYj4ESVOKKr6Rgtz51eJDgAO3LmHI14I/aOGxlrFw=
X-Google-Smtp-Source: AGHT+IF0NWi0SfgtxSzHK8dL969JfFqbPxpCygn0d74NlnzAwmc6agXzx4b2jHOUcZWEo0CsU2Kbcg==
X-Received: by 2002:ad4:5bec:0:b0:6e4:2d90:37ed with SMTP id 6a1803df08f44-6e42d9048d3mr8453546d6.18.1738689104528;
        Tue, 04 Feb 2025 09:11:44 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e2549225e8sm63603586d6.88.2025.02.04.09.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 09:11:43 -0800 (PST)
Date: Tue, 04 Feb 2025 12:11:43 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 willemb@google.com, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 andrii@kernel.org, 
 eddyz87@gmail.com, 
 song@kernel.org, 
 yonghong.song@linux.dev, 
 john.fastabend@gmail.com, 
 kpsingh@kernel.org, 
 sdf@fomichev.me, 
 haoluo@google.com, 
 jolsa@kernel.org, 
 horms@kernel.org, 
 bpf@vger.kernel.org, 
 netdev@vger.kernel.org
Message-ID: <67a24a4f8af27_bb566294bd@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAL+tcoAXcDuAsy6rqGBh3Sb1dkdZ0xn6YFCQec-K6QSPyaVwEA@mail.gmail.com>
References: <20250128084620.57547-1-kerneljasonxing@gmail.com>
 <2706706c-3d85-4f43-ad91-d04bbb4f2b92@linux.dev>
 <CAL+tcoAXcDuAsy6rqGBh3Sb1dkdZ0xn6YFCQec-K6QSPyaVwEA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 00/13] net-timestamp: bpf extension to equip
 applications transparently
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jason Xing wrote:
> On Tue, Feb 4, 2025 at 10:27=E2=80=AFAM Martin KaFai Lau <martin.lau@li=
nux.dev> wrote:
> >
> > On 1/28/25 12:46 AM, Jason Xing wrote:
> > > "Timestamping is key to debugging network stack latency. With
> > > SO_TIMESTAMPING, bugs that are otherwise incorrectly assumed to be
> > > network issues can be attributed to the kernel." This is extracted
> > > from the talk "SO_TIMESTAMPING: Powering Fleetwide RPC Monitoring"
> > > addressed by Willem de Bruijn at netdevconf 0x17).
> > >
> > > There are a few areas that need optimization with the consideration=
 of
> > > easier use and less performance impact, which I highlighted and mai=
nly
> > > discussed at netconf 2024 with Willem de Bruijn and John Fastabend:=

> > > uAPI compatibility, extra system call overhead, and the need for
> > > application modification. I initially managed to solve these issues=

> > > by writing a kernel module that hooks various key functions. Howeve=
r,
> > > this approach is not suitable for the next kernel release. Therefor=
e,
> > > a BPF extension was proposed. During recent period, Martin KaFai La=
u
> > > provides invaluable suggestions about BPF along the way. Many thank=
s
> > > here!
> > >
> > > In this series, I only support foundamental codes and tx for TCP.
> >
> > *fundamental*.
> >
> > May be just "only tx time stamping for TCP is supported..."
> >
> > > This approach mostly relies on existing SO_TIMESTAMPING feature, us=
ers
> > > only needs to pass certain flags through bpf_setsocktopt() to a sep=
arate
> > > tsflags. Please see the last selftest patch in this series.
> > >
> > > After this series, we could step by step implement more advanced
> > > functions/flags already in SO_TIMESTAMPING feature for bpf extensio=
n.
> >
> > Patch 1-4 and 6-11 can use an extra "bpf:" tag in the subject line. P=
atch 13
> > should be "selftests/bpf:" instead of "bpf:" in the subject.
> >
> > Please revisit the commit messages of this patch set to check for out=
dated
> > comments from the earlier revisions. I may have missed some of them.
> =

> Roger that, sir. Thanks for your help!
> =

> >
> > Overall, it looks close. I will review at your replies later.
> >
> > Willem, could you also take a look? Thanks.
> =

> Right, some related parts need reviews from netdev experts as well.
> =

> Willem, please help me review this when you're available. No rush :)

I won't have much to add for the BPF side, to be clear.

One small high level commit message point: as submitting-patches
suggests, use imperative mood: "adds X" when the patch introduces a
feature, not "I add". And "caller gets" rather than "we get".

Specific case, with capitalization issue: "we need to Introduce".

I'll respond to a few inline code elements later. Nothing huge.
Also feel free to post the next version and I'll respond to that, if
you prefer.

