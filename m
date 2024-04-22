Return-Path: <bpf+bounces-27459-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C61E28AD487
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 21:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5004CB2254E
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 19:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F80155312;
	Mon, 22 Apr 2024 19:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="haQJUttz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE5A219E0
	for <bpf@vger.kernel.org>; Mon, 22 Apr 2024 19:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713812509; cv=none; b=LbS+lzAOesoq8Q2ml4emQI6herFLYMlhzbQYOzK4bn2LmGpTWkXnPc1cX35NfJq+EIn70t2EKEih6F4JJBSAgnx5oZGfd0RP/LtdKATc0T0fvflNq1WfALgtuv8GUE7HPr+8pyhBZzzTJ2zZODA54oachX0vFZ/+usQYmXBJUtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713812509; c=relaxed/simple;
	bh=VUfQzjh5+xIuRNiKyJ8NbutxlsICHqqDcLaERMfZook=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZfydxIKG74wC5tst+HQZrQvz7nwgXunLPcrnyUuJ4SQnj1K0QsVUIZODFIq4wb1cR3U/Sm4TdPOAmDTxPpg/VxgWxR/Mj/rCmyMFpqUBejVILElrAsxRWzxK9tpwAwL3I06t2bWuwha0Tb1vE2NPmd8vw/N+4KzHCPBJApU2+b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=haQJUttz; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-41a7ae25d53so7632375e9.1
        for <bpf@vger.kernel.org>; Mon, 22 Apr 2024 12:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713812506; x=1714417306; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VUfQzjh5+xIuRNiKyJ8NbutxlsICHqqDcLaERMfZook=;
        b=haQJUttzpmSnnKoQUAYlaX0et3f/cGYrGNMmGmBRfGikupXbBwDE2a2v1cmJGwUatE
         ZP6AqFvCA0I/xhXbRI8YC5G9G2lhadwaWmGmU4SgvAYrt4U1+ljNRQ2h5DvbIhUUb3cr
         m2ukyB95HUu9DZQLn+MIvptvobiqclHEAcnPigucdXT1Lu4hu14Jqme8LIL4cXDvqco+
         q8M27EJ9SnTrsNhhF5StvdoKPTVRyceTylshaIekP2Y6uYsrfyZbwARvv1JLfV+1JOuN
         zNs8fvkuPEynKFQQyQSkZfHLxpQjXQI98m9lgsyDMKAXFSdmfaAgWpW+6UrcU4lvcp9j
         jCuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713812506; x=1714417306;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VUfQzjh5+xIuRNiKyJ8NbutxlsICHqqDcLaERMfZook=;
        b=NimMJesiIpQDIyRwhoph5VFnOG0mWBAyVbnDvpFD5d68vnqUBJKzIXUBvdfH9SdJ1z
         zjcUTRLtcia99AqvsLx9h+Ymgk28QkyR3lyEP4RdSA1GxR5G/utipPUAGG26uPdI7VIv
         /eppjSmnxvmsAvTgj187AQO/BnTJ3OREiGShpC37paz6FBtjtm0stmgrqTePjaQbStI3
         +I1npm+v/GvYzbkhpA6/zHELdApR4DfsAihbvcRLdQizDMwTFKVxsyJMtcZ4cK06LvlQ
         XnAlX2TMxhvg6XajL4CbDrUydXOGLYKE3gW5GuYkKh53rYsJ3Q/H0Y3jEQFKycN1cECi
         Rv1A==
X-Forwarded-Encrypted: i=1; AJvYcCUEbiUd5n+MM1tpaBLgXTCv73YYwuNQ5t8P0mMODSsfM7ditt/Khy0lwYZ3awEvZP2XuKdCQEysWiU/wKTTJNqKcCS4
X-Gm-Message-State: AOJu0YxtY3diU9B1ohFMfep65FgbIwzq09V5KnsLcASCTNz7mv0XRr8x
	xQEiyQXCetJo0qiSm7N25SPaUEWG66vPovJ2qZj9RoIhRL+MgKUQw52t9agL8a5x2P+neq1pNZB
	8zlr11C5Wh2hUd7gOZH4CL6aI/o3KWg==
X-Google-Smtp-Source: AGHT+IH/8dEhCWbw/CH5S8l8yh0CzyTyogFe6tRxXEQfqQO2r1LBdjIJo2S6MT+QzY+8I51hB/vvCuqq2iqB3JTyp/c=
X-Received: by 2002:a05:600c:5405:b0:418:fa03:ca68 with SMTP id
 he5-20020a05600c540500b00418fa03ca68mr7380092wmb.17.1713812505758; Mon, 22
 Apr 2024 12:01:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <093301da933d$0d478510$27d68f30$@gmail.com>
In-Reply-To: <093301da933d$0d478510$27d68f30$@gmail.com>
From: Watson Ladd <watsonbladd@gmail.com>
Date: Mon, 22 Apr 2024 12:01:34 -0700
Message-ID: <CACsn0ckPptm05-G6tXPaJJSvKmP3e-nCKPJJCdkmzZOYkQX-Tw@mail.gmail.com>
Subject: Re: [Bpf] BPF ISA Security Considerations section
To: dthaler1968=40googlemail.com@dmarc.ietf.org
Cc: bpf@ietf.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 20, 2024 at 9:09=E2=80=AFAM
<dthaler1968=3D40googlemail.com@dmarc.ietf.org> wrote:
>
> Per https://authors.ietf.org/en/required-content#security-considerations,
> the BPF ISA draft is required to have a Security Considerations section
> before
> it can become an RFC.
>
> Below is strawman text that tries to strike a balance between discussing
> security issues and solutions vs keeping details out of scope that belong=
 in
> other
> documents like the "verifier expectations and building blocks for allowin=
g
> safe
> execution of untrusted BPF programs" document that is a separate item on =
the
> IETF WG charter.
>
> Proposed text:
>
> > Security Considerations
> >
> > BPF programs could use BPF instructions to do malicious things with
> memory,
> > CPU, networking, or other system resources. This is not fundamentally
> different
> > from any other type of software that may run on a device. Execution
> environments
> > should be carefully designed to only run BPF programs that are trusted =
or
> verified,
> > and sandboxing and privilege level separation are key strategies for
> limiting
> > security and abuse impact. For example, BPF verifiers are well-known an=
d
> widely
> > deployed and are responsible for ensuring that BPF programs will termin=
ate
> > within a reasonable time, only interact with memory in safe ways, and
> adhere to
> > platform-specified API contracts. The details are out of scope of this
> document
> > (but see [LINUX] and [PREVAIL]), but this level of verification can oft=
en
> provide a
> > stronger level of security assurance than for other software and operat=
ing
> system
> > code.

I would put a reference to the other deliverable to say more. If we
think that's suboptimal for publication strategy, maybe we can be more
generic about it.

Often BPF programs are executed on the other side of a reliability
boundary, e.g. if you execute a BPF filter saying drop all on your
network card, have fun. This isn't different from firewalls and the
like, but it's a new risk that people aren't expecting. I think we
might also need to call out that BPF security assurance requires
careful design and thought about what is exposed via BPF.

Sincerely,
Watson

> Bpf@ietf.org
> https://www.ietf.org/mailman/listinfo/bpf



--=20
Astra mortemque praestare gradatim

