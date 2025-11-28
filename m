Return-Path: <bpf+bounces-75717-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF14C922ED
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 14:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 14CB834C3E2
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 13:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5B8241114;
	Fri, 28 Nov 2025 13:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YRS3PbHj"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9B617A2F6
	for <bpf@vger.kernel.org>; Fri, 28 Nov 2025 13:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764337986; cv=none; b=B55xYeUBKICUm6f1hS5kWpt8rphL/Fknsqf/30+au75BZJtrdnkuOP39wUYeO0Yrk5nB1sYtVJ29LGbBJyMXxZdWphTkwLq6p0D6SM+EDWSufjT8mqpIR//wIsqfgwKiJfTHGWeML2leXs9qAS/vvHYTp8mk2LT2zy1LOmPtO4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764337986; c=relaxed/simple;
	bh=pbBawiQmtNJdVZxeYvEt9G/XaBTVKaR9xIboieApa7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mgVNwfoBZLm4tju75/PGhXo4O6NdxdZ3ZgDquVzS2jAbziCfmI4OK4PXjRog1NIUu48yTD8P4wphlVnU0BUJMFWId87gKDtS+Y0tjS8XQtOMC9BEiLtj0RkL4izR3dSRs/Y6jfqZJa/AmfL+Xu1BrBYvTVyyJNISYboQv/LKI3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YRS3PbHj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764337984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pbBawiQmtNJdVZxeYvEt9G/XaBTVKaR9xIboieApa7U=;
	b=YRS3PbHj+7O97VPNDsTTUg68MEaW4KrnK0QbuDQr+VSqs7t6MTcSAfXlAFgYIuNKgl/CGE
	AEppqgvLmKJV50QCsN3MEZqS0WVvtMmwYTGU6PBUXnCKtOZSudOiD0HcjNKc0La6l24SEZ
	e/GpOU6FzoFbu8W3NIavNsZoOyEKing=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-yRGj3X2XPK-x98fqMCSXAA-1; Fri, 28 Nov 2025 08:53:02 -0500
X-MC-Unique: yRGj3X2XPK-x98fqMCSXAA-1
X-Mimecast-MFC-AGG-ID: yRGj3X2XPK-x98fqMCSXAA_1764337981
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-595892a393eso1197400e87.3
        for <bpf@vger.kernel.org>; Fri, 28 Nov 2025 05:53:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764337981; x=1764942781;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pbBawiQmtNJdVZxeYvEt9G/XaBTVKaR9xIboieApa7U=;
        b=LEYujbuZspHvk+uQ33zbMA7yGc3IQBXPug8cmI5vio/96agkJWKLjPCpdKzg6kxZJO
         oKrGXf9bRJ9oMUzSOrAETbn8vqDZoEtj7YN2ytD7bUc+OYnNYD4DTi6Qdngxitx38yoW
         /It+ZCgoNayECNLI6YzxIJtrqkJ1s52LYg6j2hPJxGO/LxHl8g5cxt+naophNy10cpIu
         GCq00ZZPSngx7CfOx2GVljzG0epfUYv4g5rzT4UFe2zOlAybOsPTa2gOfoRqFDsH/JF6
         gBIGJWi1I0+K6e13sXGWxvY4krbetVXH1vGs+nyf0ilDrO29CPcb3xp9Bnk07jpv8iu3
         G37g==
X-Forwarded-Encrypted: i=1; AJvYcCXOHljdit4RpuFkADwQ9hXRXYSaqtzrJ3yX2xOnoLnP1j3Lwf87k9ncvujSmi/FTj+Vaj4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBNzPIq0dB6XEy3G++/ndDCg/Pc+naJzFv6ZLby5LHyAFQ/YvJ
	YThsNCILs6EDyMhvCwHyB8US4YrLOSL742FBKHyRqnNLGQhgmqQpJKQ7juFf6sjHZuxnuB/bn9Y
	WdgxoBSNK8wYIEj3dH5d6FqPFur28WOzaGvUG5aXndhd05WRdDxmGe6ChQCkSBmgt4DRFPvB/At
	s3jCDxC45Vh1dIAEulw5NWiQh19Y0C
X-Gm-Gg: ASbGncsf+xStRmF7k02YXuyGJ2ag5idv05I03V7W7jfk4A7e+XmiYC7C5KK/wu7TrBI
	INSmvpj2SFvauA947uekxIGMT9hoAnJg2nsdbvDfFGvi3wnr6PfVbPH8moiqkI9OjtKa//upY/W
	Q8febEu1QZwCR/mvHjR0j/heUzAGVE323rJYetd5Q3zT9xRttUW+9dHBVe1GNmgH/IYg==
X-Received: by 2002:a05:6512:110a:b0:594:2df2:84c8 with SMTP id 2adb3069b0e04-596a3ecf652mr8065922e87.33.1764337981164;
        Fri, 28 Nov 2025 05:53:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGxr/p6KFwbxmBeYyfFkOgez8vD9eAT2uUP849jN8015e5rnJowKoYbVC9lcjOKCZyBvhu+4pGX0/eZBkRGR8U=
X-Received: by 2002:a05:6512:110a:b0:594:2df2:84c8 with SMTP id
 2adb3069b0e04-596a3ecf652mr8065918e87.33.1764337980757; Fri, 28 Nov 2025
 05:53:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251117184409.42831-1-wander@redhat.com> <20251117184409.42831-2-wander@redhat.com>
 <CADDUTFwK=TuhMcfr9C4NXOEQc89wBvdZtv+DtYFuHfc9wh5R=A@mail.gmail.com>
In-Reply-To: <CADDUTFwK=TuhMcfr9C4NXOEQc89wBvdZtv+DtYFuHfc9wh5R=A@mail.gmail.com>
From: Wander Lairson Costa <wander@redhat.com>
Date: Fri, 28 Nov 2025 10:52:49 -0300
X-Gm-Features: AWmQ_bkeS6Y54WrCji-DPm62oeGH0r4pGKqlqBcxo7rjyOZqWF3Uwi0VtVBxrd0
Message-ID: <CAAq0SUnYnopSwd2ir_J1roFU31SzK5SQkv1L+WhP=T=Xbq479A@mail.gmail.com>
Subject: Re: [rtla 01/13] rtla: Check for memory allocation failures
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Tomas Glozar <tglozar@redhat.com>, 
	Ivan Pravdin <ipravdin.official@gmail.com>, Crystal Wood <crwood@redhat.com>, 
	John Kacur <jkacur@redhat.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	"open list:Real-time Linux Analysis (RTLA) tools" <linux-trace-kernel@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:BPF [MISC]:Keyword:(?:b|_)bpf(?:b|_)" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 28, 2025 at 10:30=E2=80=AFAM Costa Shulyupin <costa.shul@redhat=
.com> wrote:
>
> On Mon, 17 Nov 2025 at 20:54, Wander Lairson Costa <wander@redhat.com> wr=
ote:
> > Add checks for the return value of memory allocation functions
> > and return an error in case of failure. Update the callers to
> > handle the error properly.
>
> Would you like to consider using fatal("Out of memory") instead of
> returning an error code?
> Anyway there is no work around for out of memory.
>

Good idea. I am going to update the patches.

> Costa
>


