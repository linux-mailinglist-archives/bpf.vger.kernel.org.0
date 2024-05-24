Return-Path: <bpf+bounces-30491-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4008F8CE6CA
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 16:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB5EE1F21B39
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 14:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4030A12C526;
	Fri, 24 May 2024 14:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ICXuCUSO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D593E86643
	for <bpf@vger.kernel.org>; Fri, 24 May 2024 14:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716560112; cv=none; b=UuvHskmNOT2RrfJrWTT//cWWUzRXUJawucqc0Z7q6iAriOqRwYzEtsQBFbgGXMIwMVrv29nblTQxXovQKfX5cstYevYaVuwYCD+48ll2skQpXjKjpuB3H+AhjTSjbHUKmWz00HjTk/vq15R2Nv2KXzxqUKjEj5nqXUoyhmUoBe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716560112; c=relaxed/simple;
	bh=Ncsyl74jMB4y+2C/6f3XjyjhbV9IDOKTgeQe/duHYi8=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=uUMc91dpjY2pySurLMJhiJFt3Ilb6N1FlYvx8HR9B1soWrLwA3dRsKJBCQIvmT7H/9uIIDPQdiZlZpnnOeFugao4WJyOqHNjqaj0g5CrsG8fEQn+k268EG/+Ku3aqe14/YZpBju0qPiGQdTsKY2lrZYCkw6uTsmgROXwZAkXvWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=ICXuCUSO; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1f304533064so23227895ad.0
        for <bpf@vger.kernel.org>; Fri, 24 May 2024 07:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1716560110; x=1717164910; darn=vger.kernel.org;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=KSpHyoXQyrWQ7YpniL++kWwmn1IU/Ue+KamaV2Z1ewg=;
        b=ICXuCUSOb4wjKppaWzqmfhNgO6S3RW5d09IgaK64A18Y7J98Mkz1R7y3f8Tt6zrkUY
         aZ/9I3R5QfBfSBizJsPKqzZgcJHRqgJhY6uimV1kipZHsCITgXPD6s+rqlidVl8i4Lni
         iq6oHqvENK+OHSL4WUBC+MDvONCCukSG2pGMUj4iZmJbPjqXSQOA+ywO6dqAnjFdOc4q
         fDqhHHi+Cd6IJgOeywiyTDxlrTFdrew++z0CcWP5/sXVVn/2X31n1Gzzxr8f8/Lr4mhk
         xsy4WIjdNIIvOjMMv/Y+W3cqjxfr5Hx7neVUZZihS9YcXMdn+wn3FBULFhwBik3/vw1G
         tGag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716560110; x=1717164910;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KSpHyoXQyrWQ7YpniL++kWwmn1IU/Ue+KamaV2Z1ewg=;
        b=fjMq4Z+hvQm6B05+LXI2S2FZHvX9rEPdK2BEbxHttaIduGrE/7ULynGfsKDgbB77zY
         517fV/ewr4dTSlCTV1i9e6fqOEw0DNvaqE0dpG/LrNkC9SxDBjPx3smIyFwzyCkdHz63
         SrBycF5Lq06H9jlQvVnS/41BuDpSN30mnfKywxn8tZwcCrZFweU+hc8RPt7+gDLpXBNH
         TLDYQI9sYCQKUfMV9vcHZO5bnsTOG2sq9nT2C98X6BUj6i1vljVsk8UNMO+fzK9Tz5By
         k/SIXKWrggrHHCnXJresdVsQrxSPKHHiWhWXCgbBJLtlZurVE/1x6up667aKAiwvie64
         oURA==
X-Forwarded-Encrypted: i=1; AJvYcCX9XuMyuq+EadFn6N7k2zmCjagCbQoUCWBpCzAGNIgOj7mUcnc4mT5iG+Xdp7XpsBcNU2XG/z13GWqP6vyakfTAJR3E
X-Gm-Message-State: AOJu0YyGjpRASM6wZ633VOr1v6yMDFbamggSnfWkRMSoWAiunv3tsG4D
	u9q1TF2+lHsvSvjoMC+tsPYSXSXpgafQz/pQVSV2uadPtyI8Kz6kX1/TQgyb
X-Google-Smtp-Source: AGHT+IHxaxG3/nqN+f1ZywQsH++WuHgrLdfQcwjzXk7qipY/6uFHmnx/buQ4Ri15+XVWmTuHBCSYMw==
X-Received: by 2002:a17:902:e749:b0:1f3:642:9f5a with SMTP id d9443c01a7336-1f339ef522cmr76574365ad.6.1716560110109;
        Fri, 24 May 2024 07:15:10 -0700 (PDT)
Received: from ArmidaleLaptop (c-67-170-74-237.hsd1.wa.comcast.net. [67.170.74.237])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c7c379dsm14353155ad.102.2024.05.24.07.15.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2024 07:15:09 -0700 (PDT)
From: dthaler1968@googlemail.com
X-Google-Original-From: <dthaler1968@gmail.com>
To: <bpf@ietf.org>,
	<bpf@vger.kernel.org>
Cc: <draft-ietf-bpf-isa.all@ietf.org>,
	"'Ines Robles'" <mariainesrobles@googlemail.com>
References: <171588680595.59757.9400896368334392439@ietfa.amsl.com>
In-Reply-To: <171588680595.59757.9400896368334392439@ietfa.amsl.com>
Subject: RE: Genart last call review of draft-ietf-bpf-isa-02
Date: Fri, 24 May 2024 07:15:07 -0700
Message-ID: <0ce301daade4$c8a890d0$59f9b270$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQHhYwHWHvkDI0nYzQ93mgSzZBpWQrGZAimg

> -----Original Message-----
> From: Ines Robles via Datatracker <noreply@ietf.org>
> Sent: Thursday, May 16, 2024 12:13 PM
> To: gen-art@ietf.org
> Cc: bpf@ietf.org; draft-ietf-bpf-isa.all@ietf.org; last-call@ietf.org
> Subject: Genart last call review of draft-ietf-bpf-isa-02
>=20
> Reviewer: Ines Robles
> Review result: Ready with Nits
>=20
> I am the assigned Gen-ART reviewer for this draft. The General Area =
Review
> Team (Gen-ART) reviews all IETF documents being processed by the IESG =
for
> the IETF Chair.  Please treat these comments just like any other last =
call
> comments.
>=20
> For more information, please see the FAQ at
>=20
> <https://wiki.ietf.org/en/group/gen/GenArtFAQ>.
>=20
> Document: draft-ietf-bpf-isa-02
> Reviewer: Ines Robles
> Review Date: 2024-05-16
> IETF LC End Date: 2024-05-16
> IESG Telechat date: Not scheduled for a telechat
>=20
> Summary:
>=20
> This document specifies the BPF instruction set architecture (ISA). =
The document
> is clear and well-written. No major issues were found, just some minor
> suggestions.
>=20
> Major issues: None
> Minor issues: None
> Nits/editorial comments:
>=20
> * In the introduction, maybe?: "eBPF (which is no longer an acronym =
for anything),
> also commonly referred to as BPF" --> eBPF (which originally stood for =
"extended
> Berkeley Packet Filter" but is no longer an acronym), also commonly =
referred to as
> BPF...

This sounds reasonable to me but at one point the BPF Steering Committee =
(BSC)
discussed the text to appear on the eBPF Foundation website at
https://ebpf.foundation/ebpf-resources/
(which is where the present text there came from), and at the time they =
did not want
to state the expansion.

https://ebpf.io/what-is-ebpf/#what-do-ebpf-and-bpf-stand-for on the =
other hand does.

What do others think about Ines's suggestion?
=20
> * It would be nice to add caption to the tables (from Table 3 to Table =
18).

Can do.

> Thanks for this document,
>=20
> Ines

Thanks for the review,
Dave


