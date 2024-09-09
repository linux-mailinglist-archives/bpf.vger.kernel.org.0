Return-Path: <bpf+bounces-39331-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C290F971FAF
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 18:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF0441C21524
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 16:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E6B16DEB4;
	Mon,  9 Sep 2024 16:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GEzNWPKn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93277494;
	Mon,  9 Sep 2024 16:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725901063; cv=none; b=V5qp05bfeEcW/IYaoZwlKzBm5assmXtqlj5Y0aF8h7ejG6h9FuEl+GfjDEmsjsLdrBRHzF55d5GKs6YNDO3u/1MM4kCA4FnHG3wOBYSiyiJ3M9N92RGfobZ6wktc1oIUe2/IsdZHhsMcY3moWwv8UvS3yO1T4mqqVtUKJy2vvg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725901063; c=relaxed/simple;
	bh=QCNK9zP8bGz5ckOaJiJWjF8Cds6zTixKftz7aBjGHbk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W/ieZzXrLma1zfxDttBHakl2M/XUnv513UuFvg8I0CHZAEwaYUfQ+nRTEP2ws1Q4XdaCGA+t1enoIAqQifXxEazfHJvi1CyzbBZiOn/pzbwkGxDrDclcTLiDGSq7GwMkfEXEEPrpbkiiaX8eu+uvSZuklIbczc9yrXzGeoWbCQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GEzNWPKn; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-718d8d6af8fso2695442b3a.3;
        Mon, 09 Sep 2024 09:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725901061; x=1726505861; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QCNK9zP8bGz5ckOaJiJWjF8Cds6zTixKftz7aBjGHbk=;
        b=GEzNWPKnhda+7UYcbHt14VTzefK0iV0QT72GIHwiU5no/aD/17joBclnOunHrttXJ/
         Hj4ZRQo8GlESM9c7dC84EIdaCqx66gfai2YWADQsQlBhTkq8dBPKRZpc31OpLsYcq/R3
         m7bKZCr1elrW9OWDa4/kV4hWxq/imzbFLFz939GRO+otihrWztibt3+gPNZMQEqMk6GZ
         qCMSpZ+sysiA69catX9RYCbdIc0pTOB4qrbEsPWGN/uJy0QU9uS9t/TqmvSXI68CzPjR
         ODZJpsPClDDN9yIo0X5qj3M5HnSH0rD5PQGLcrUF/3ApIDWwUAc2lSo8IDDS3pz0foVZ
         xh3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725901061; x=1726505861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QCNK9zP8bGz5ckOaJiJWjF8Cds6zTixKftz7aBjGHbk=;
        b=XybfCGkGhW0d00DU2vpVPPoJCNY24tI7a8HFaBSgxiSGZezrPwx7YwNVtHARaxelN4
         mF0QwEJgYBX+EHHdlkKlAPvdJuOgKBsg3cEXYvIfG9zUYOP56yhkJumhkTZUYLaMSthG
         dGx7pHmW/abou/0iVqyXUEeNDzeFtOELkVC7OsiDcePzM5MWWfyf4FSQ0r5iBl4YuG3p
         JEj29+svfPh+OhO15FwOvMqPmhmwX6/4D3Zh3JGNZ6KGW56p5a/DxdRUh5gflmYERPgF
         PaWT3HXQLv8xsgW/5oP8b1TdH/KBacPh9fBavvyTcBrrQ/LXEuGsnp8vu/onL5Nnwy/C
         /4tQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwj+n5HZdOCDEjMSMnzrHWnjm37vUswY3j6XpQTum4L8QrBplhmJmoTEVXs+42Ips6nuzRSpb6cotcoHZT@vger.kernel.org, AJvYcCWC7kaBdrrt/hO4OQK+cqCbhUeNyi69f679axjrEiCVLbMRyA/gRlJUGXqw+QUmB5YV2TA=@vger.kernel.org, AJvYcCWXFQJBUAumX+rAOOKqqswHk8aH4Xs94y4ZUwJ1gzrSx4eG6B+4tYb7KdmyIRM8byraNIAqczsPL1PekTA1+kCbK7nN@vger.kernel.org
X-Gm-Message-State: AOJu0YyHGZRSouHhDlWmTKDeUrbnwrLog3gRHPb60xlztwgHnT09j2pn
	DxevqwQOxilTR+BciODhC7l/2tATmi37Y7eqpx/hHmG9xo1RJqMnnmyFIzUMuHqW/7xkZiK3vPs
	1F2xuyI9FRa4mfLfKbACsYeUPDl2SCg==
X-Google-Smtp-Source: AGHT+IFApPizW7xqNkTHSmiNEWQUS+OJNd1Gro6foYoJ+rcZwtGDgWdsEDvQSdwD9lVR0uoBUsshIirR3/BtJEzYuFs=
X-Received: by 2002:a05:6a21:3a94:b0:1cf:4ea4:17c with SMTP id
 adf61e73a8af0-1cf4ea40234mr815722637.15.1725901060848; Mon, 09 Sep 2024
 09:57:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814080356.2639544-1-liaochang1@huawei.com>
 <Zr3RN4zxF5XPgjEB@J2N7QTR9R3> <f95fc55b-2f17-7333-2eae-52caae46f8b2@huawei.com>
 <8cc13794-30a7-a30b-2ac9-4d151499d184@huawei.com> <ZtrN4eWwrSWTMGmD@J2N7QTR9R3>
 <CAEf4BzYn3EkVVk4dnWMBMKa16y_ZFvQp3ZcdM44a2LeS08S6FQ@mail.gmail.com> <Zt7LWaoZ0PTFqVLF@J2N7QTR9R3>
In-Reply-To: <Zt7LWaoZ0PTFqVLF@J2N7QTR9R3>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 9 Sep 2024 09:57:28 -0700
Message-ID: <CAEf4BzbWnGiRQm+eZAYSsHzy5+9jbZ87=m0sg5zxAjVDSkPFiA@mail.gmail.com>
Subject: Re: [PATCH] arm64: insn: Simulate nop and push instruction for better
 uprobe performance
To: Mark Rutland <mark.rutland@arm.com>
Cc: "Liao, Chang" <liaochang1@huawei.com>, catalin.marinas@arm.com, will@kernel.org, 
	mhiramat@kernel.org, oleg@redhat.com, peterz@infradead.org, 
	puranjay@kernel.org, ast@kernel.org, andrii@kernel.org, xukuohai@huawei.com, 
	revest@chromium.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 3:18=E2=80=AFAM Mark Rutland <mark.rutland@arm.com> =
wrote:
>
> On Fri, Sep 06, 2024 at 10:46:00AM -0700, Andrii Nakryiko wrote:
> > On Fri, Sep 6, 2024 at 2:39=E2=80=AFAM Mark Rutland <mark.rutland@arm.c=
om> wrote:
> > >
> > > On Tue, Aug 27, 2024 at 07:33:55PM +0800, Liao, Chang wrote:
> > > > Hi, Mark
> > > >
> > > > Would you like to discuss this patch further, or do you still belie=
ve emulating
> > > > STP to push FP/LR into the stack in kernel is not a good idea?
> > >
> > > I'm happy with the NOP emulation in principle, so please send a new
> > > version with *just* the NOP emulation, and I can review that.
> >
> > Let's definitely start with that, this is important for faster USDT tra=
cing.
> >
> > > Regarding STP emulation, I stand by my earlier comments, and in addit=
ion
> > > to those comments, AFAICT it's currently unsafe to use any uaccess
> > > routine in the uprobe BRK handler anyway, so that's moot. The uprobe =
BRK
> > > handler runs with preemption disabled and IRQs (and all other maskabl=
e
> > > exceptions) masked, and faults cannot be handled. IIUC
> > > CONFIG_DEBUG_ATOMIC_SLEEP should scream about that.
> >
> > This part I don't really get, and this might be some very
> > ARM64-specific issue, so I'm sorry ahead of time.
> >
> > But in general, at the lowest level uprobes work in two logical steps.
> > First, there is a breakpoint that user space hits, kernel gets
> > control, and if VMA which hit breakpoint might contain uprobe, kernel
> > sets TIF_UPROBE thread flag and exits. This is the only part that's in
> > hard IRQ context. See uprobe_notify_resume() and comments around it.
> >
> > Then uprobe infrastructure gets called in user context on the way back
> > to user space. This is where we confirm that this is uprobe/uretprobe
> > hit, and, if supported, perform instruction emulation.
> >
> > So I'm wondering if your above comment refers to instruction emulation
> > within the first part of uprobe handling? If yes, then, no, that's not
> > where emulation will happen.
>
> You're right -- I had misunderstood that the emulation happened during
> handling of the breakpoint, rather than on the return-to-userspace path.
> Looking at the arm64 entry code, the way uprobe_notify_resume() is
> plumbed in is safe as it happens after we've re-enabled preemption and
> unmasked other exceptions.
>
> Sorry about that.
>
> For the moment I'd still prefer to get the NOP case out of the way
> first, so I'll review the NOP-only patch shortly.
>

Yep, one step at a time makes sense, thanks! Regardless, I'm glad we
clarified the confusion.

> Mark.

