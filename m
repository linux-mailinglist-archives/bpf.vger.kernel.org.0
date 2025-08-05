Return-Path: <bpf+bounces-65038-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 717C9B1AF19
	for <lists+bpf@lfdr.de>; Tue,  5 Aug 2025 09:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8DB116B054
	for <lists+bpf@lfdr.de>; Tue,  5 Aug 2025 07:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E38224B1B;
	Tue,  5 Aug 2025 07:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rs9mahRf"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DB0218AB3
	for <bpf@vger.kernel.org>; Tue,  5 Aug 2025 07:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754377462; cv=none; b=ok4IAKmX1NFAH2uP4fn/zDyindvR2inydvKJFweBazo6jGRbRw1R4A60/tV+p5tzkbkKfdV4hH15SQON3NF0WI1lKgULAwe84PYE+2eE+hLEaWsCOgErSIY6FwrdyFrTx63wKx2DrCPqqypzDYUHy+H3rioGjIOwszPQ18g73eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754377462; c=relaxed/simple;
	bh=PGYonKGyaMFSCfv/S5Qgyq0Ie5dVTihFme0wevOqbyo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hUHH4bFuDExNLlq+tNVhlAQx5LbL/sMBb1ne/Nh3bsQUANvaMpVGAxoxS6n4EWXI5c8JkAhaXVRxxg3OJoiEqqrANeqYAlYW5C5GMr5C+f9r2Mg7UBzCsmG0xI49frX3QYz21aHv3u+xNTn+bj3Vj7xVCeO0Xp8TlPIoTEFNHV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rs9mahRf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754377460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PGYonKGyaMFSCfv/S5Qgyq0Ie5dVTihFme0wevOqbyo=;
	b=Rs9mahRflMIyhhWasKmqNofwe9iQ+9C7NMU+H2CW1MLHcvb+X9wnUEg8Ip+DIQQmQzHgJf
	LHLNuALKdzC7u0k7C8E+/tYfK7fnUdiSx22dxeahaxpH3ASMe3uRBQNC/J7SwnHg9VGYN4
	X3K1IYGQCsV46zSV/Y7MFFB2Y6cxWDc=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-Se0RRjT1PeOfgFR3sFeCFA-1; Tue, 05 Aug 2025 03:04:18 -0400
X-MC-Unique: Se0RRjT1PeOfgFR3sFeCFA-1
X-Mimecast-MFC-AGG-ID: Se0RRjT1PeOfgFR3sFeCFA_1754377458
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-adb32dbf60bso464004466b.1
        for <bpf@vger.kernel.org>; Tue, 05 Aug 2025 00:04:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754377457; x=1754982257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PGYonKGyaMFSCfv/S5Qgyq0Ie5dVTihFme0wevOqbyo=;
        b=NjgTldhULn5RzktkFaIlbtO5He6JMfYTh9x+5cfp4jUFoLLRH2XTKIB9mZhBijNssj
         77Dl9gutE4IaxgIonIoSqq7Ht3WXvWI5cTDpggMXVlOcijVxWTpUXmbUAKXdgqIetsKf
         u6WOX0vhRnl5MSD6m6OId6MNd0BXz98su84fn/AH99/kA9Q6ctTE3lW0CVHO6xDfv+E0
         LxU9KAtCEwK7PnWbNAVqfeawwYAWtnO8ZqeodlcW8HkAcjBvm4DNWHn1//lRLDmJ0YI6
         RQHhXopEjbvT2sO6GFHCsnVEnsEOhmMG6xYs02GsRI4HhHYaAVb4AptOhLBIhTvCPfAq
         Xqmw==
X-Forwarded-Encrypted: i=1; AJvYcCWf3vpkD3fqbDkeFaMgzJC1jgM8+LQfMaWxMezc/CgasUuxKLgSZ8TiX/Fh4o7KFCcISTo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9K5AO25wggT1UI6uLZr9Nw+MLg/yYhN4qmIhFMFhOP/JJiVs8
	Lh684C5vjr86MvCbloMTbF5/UY1CpHTgpNDpCkpDviUpXFli05c8n46u6rM98NKko3jBCbTXl3P
	OGxTV/Op2e1Wpo1Frd7qFN3+/4/7RR70IEZKWfUukqB9lJKqDbNqMZS6DlVkMTdhHHGPcAug3Zo
	RuMm68OvOHgsf7BDoHb0dhgdNjOuvI
X-Gm-Gg: ASbGnct2TaeH+FawZtdipkZrajuu0iSk1Oeu5n9/VACh9vLrJKsOwQQ7g9f5aMgSpt3
	n80EJohMvcg5BB6/zKGN14FvMvFgXPQ3FfHKzkPd2n/7uAvKdqgzbT1SrK1YJez+xR/+jK8O0i8
	YicsdTSn3hICT2ymWw0VzFf2Fb8Xsvaa4059p2ozUF1PU2LtaPWG7LvL4=
X-Received: by 2002:a17:907:3f2a:b0:ae3:8c9b:bd61 with SMTP id a640c23a62f3a-af93ffa2d63mr1238256066b.12.1754377457468;
        Tue, 05 Aug 2025 00:04:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMbyK9gScuElH5NpUEMJ41EUPRyaWEQ72uvHWKJnSabm/rqvUckY7aYInaqvU/TD5yzgsTDQ1Qxrs3ymnlCVE=
X-Received: by 2002:a17:907:3f2a:b0:ae3:8c9b:bd61 with SMTP id
 a640c23a62f3a-af93ffa2d63mr1238253166b.12.1754377457043; Tue, 05 Aug 2025
 00:04:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250726072455.289445-1-costa.shul@redhat.com> <0faa958ef9cc4b834a5ecdc92acd89520f522d44.camel@redhat.com>
In-Reply-To: <0faa958ef9cc4b834a5ecdc92acd89520f522d44.camel@redhat.com>
From: Costa Shulyupin <costa.shul@redhat.com>
Date: Tue, 5 Aug 2025 10:03:40 +0300
X-Gm-Features: Ac12FXzlcHTYAnu-YG9PepEFtGlUSJiRNcUXl9U2QsYIFClYRFSRgHj4wuksd2s
Message-ID: <CADDUTFzWBkrKx6=fOMXp=y5cyecOvWLx5jZG6m3BMTAvL067Wg@mail.gmail.com>
Subject: Re: [PATCH v2] tools/rtla: Consolidate common parameters into shared structure
To: Crystal Wood <crwood@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Tomas Glozar <tglozar@redhat.com>, 
	John Kacur <jkacur@redhat.com>, Eder Zulian <ezulian@redhat.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Jan Stancek <jstancek@redhat.com>, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 4 Aug 2025 at 21:18, Crystal Wood <crwood@redhat.com> wrote:
> If you want, I could rebase that on this and use container_of() to for to=
ol-
> specific params... but then that adds complexity with the top and hist-
> specific params, most of which are common between timerlat and osnoise
> (and not merged by this patch).
I=E2=80=99d appreciate it if you could rebase your patchset on top of this =
one.
This patch is just the first; I=E2=80=99ve intentionally kept it minimal to
ease integration.
My goal is to refactor rtla and submit a series of follow-up patches
to reduce code duplication.

> So we might want to just keep it simple with one big struct.
This is a god object anti-pattern.

> new common.h if we want to keep the actual-osnoise-tracer stuff
> separate
I agree with the new common.h and separating things out.

-Costa


