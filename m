Return-Path: <bpf+bounces-27454-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B14CD8AD415
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 20:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1F6D1C20BA3
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 18:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEEDF15443D;
	Mon, 22 Apr 2024 18:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Y3/biIjE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42666153BFC
	for <bpf@vger.kernel.org>; Mon, 22 Apr 2024 18:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713811074; cv=none; b=df19fHOpgDCYtuVdUiL0ssBP7FCL23/uJM8X/BHt3OFYFZAibNUi7j5mfYWwGgvW0aHOs/HDfIoAAN6BocGy1BYNQKGOXX9/gSln/jljdb2/+l9LOa8tFqXqPq/7PMYH08iUGcj2nM5sdCiOlv/4gttOQs+1OV+/1QJ8lZTF6cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713811074; c=relaxed/simple;
	bh=Itd3L/OCuCAqmJ4nX1oUVNH9ljB/0uDzwB4022YeUv4=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=rvHW6soSL5SjGrWOzroqOmIooVycdxGBpzO2NNjzbQC/xTqiwu0eQNX32Ta19O3kXk/7cD34ke7bvg6GidmWUcIeso4zZBSqzLf3XdhLKZsIKEgnHANFpG7uaT3CizRq9vgEw5BJJYXZ7/zL273A3a0IGqb/UXYk6h3fLtZaVLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Y3/biIjE; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6eff9dc1821so4681357b3a.3
        for <bpf@vger.kernel.org>; Mon, 22 Apr 2024 11:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1713811072; x=1714415872; darn=vger.kernel.org;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=i/O8pnmYH0xDG4ELW4n0m95T2/dxB9yFPAEgLSJkkMk=;
        b=Y3/biIjEzMQQGckRygvl17s46rFZ9XhPZDUnpbHBWxa8CGcsTwYY5Zh7+4Euiw3MkN
         HpvJaUyzSvievm+wemsg+1AQJDroy8djEzIkzz9GsZtv7MkYYSjanRV3/zLE2uFMXpJG
         8EG/tXp/HvKPi6xcqfZnhuCg24YBRAONS6kCWwhnKLZ+j9a1ZYDqusEqmr4m0JeehfPT
         VOQMWjl7QYgg3VPUtVRAU+EW63sEfT41WoDzhM/ljkCMoagwgGa6I9tfDyIlDCnz3k5W
         AJjyvGRasGRyE+PFGaJrfNk076HoG37s9ZCFkNpovtHYU7FUw43IMEr46lqXKd5kUhEj
         vgUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713811072; x=1714415872;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i/O8pnmYH0xDG4ELW4n0m95T2/dxB9yFPAEgLSJkkMk=;
        b=S0C0sNfXXiPGPvakSXSslV6pLYSeUwftWSCbGzjdkF3Qu23WbIg8i1jpjsvmFMfzwW
         YrbJYczlOgasHgo+s8BC3p6vipPap9wCaAkVywag0zUKofeQ1A3lmQiqSol+Isn91xbg
         Lc9p2ZM3+ZGXsVSSyzKLBBfLxXVNFcRTF4uJSfBIdTAcZB9Vxa18ApecnQH8I9/Rqkkc
         N490FX4xQ1XYmFYWQlxJVIGJaxRhZPyLoknXgEdRXeJXRiSYKPGMN5lNWEOu1nc6TykZ
         yZ/hWdj5E62j4g34JcwGaPQhhkVWgR2+UuGIGnkMyKhXy4K6mxvIfYu04UToI0CuAkkm
         UkEg==
X-Forwarded-Encrypted: i=1; AJvYcCW5Xn2iSnuCjzSsaExDKFvLqWmcYmemFpTOMuvzgCm0Vfb3jmGYnTkgaYvkZ/3070cYzJOjERb+5TUOT+uYJvhKgJBo
X-Gm-Message-State: AOJu0Yyt9EgAe2K4/PYwM6gJLGnthZM7GHaL+X8dSeJMPqkqIjaom2GZ
	lL6YS/i3uQD1wLIzCq3vPEWA5cuLTA6fzVeyriOUncFmxh6eR2ezj3pi750g
X-Google-Smtp-Source: AGHT+IHIdONuhi1tU+z0ZhjG4E0Tr/CgUPURvarA/i4pLG2Vs562U3KrvymtWQu3Xe5GyxVhorKclA==
X-Received: by 2002:a05:6a00:a0e:b0:6eb:6:6b72 with SMTP id p14-20020a056a000a0e00b006eb00066b72mr12320037pfh.25.1713811072347;
        Mon, 22 Apr 2024 11:37:52 -0700 (PDT)
Received: from ArmidaleLaptop (c-67-170-74-237.hsd1.wa.comcast.net. [67.170.74.237])
        by smtp.gmail.com with ESMTPSA id s11-20020a62e70b000000b006ecde91bb6esm8169972pfh.183.2024.04.22.11.37.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Apr 2024 11:37:52 -0700 (PDT)
From: dthaler1968@googlemail.com
X-Google-Original-From: <dthaler1968@gmail.com>
To: <dthaler1968@googlemail.com>,
	"'David Vernet'" <void@manifault.com>
Cc: <bpf@ietf.org>,
	<bpf@vger.kernel.org>
References: <093301da933d$0d478510$27d68f30$@gmail.com> <20240421165134.GA9215@maniforge> <109c01da9410$331ae880$9950b980$@gmail.com>
In-Reply-To: <109c01da9410$331ae880$9950b980$@gmail.com>
Subject: RE: BPF ISA Security Considerations section
Date: Mon, 22 Apr 2024 11:37:48 -0700
Message-ID: <149401da94e4$2da0acd0$88e20670$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIuELsBo+B+UsoJNRbSlFOn1N3FrQD/w4oWAbyzN8Swt8KZIA==
Content-Language: en-us

David Vernet <void@manifault.com> wrote:
> > Thanks for writing this up. Overall it looks great, just had one
> > comment
> below.
> >
> > > > Security Considerations
> > > >
> > > > BPF programs could use BPF instructions to do malicious things
> > > > with memory, CPU, networking, or other system resources. This is
> > > > not fundamentally different  from any other type of software that
> > > > may run on a device. Execution environments should be carefully
> > > > designed to only run BPF programs that are trusted or verified,
> > > > and sandboxing and privilege level separation are key strategies
> > > > for limiting security and abuse impact. For example, BPF verifiers
> > > > are well-known and widely deployed and are responsible for
> > > > ensuring that BPF programs will terminate within a reasonable
> > > > time, only interact with memory in safe ways, and adhere to
> > > > platform-specified API contracts. The details are out of scope of
> > > > this document (but see [LINUX] and [PREVAIL]), but this level of
> > > > verification can often provide a stronger level of security
> > > > assurance than for other software and operating system code.
> > > >
> > > > Executing programs using the BPF instruction set also requires
> > > > either an interpreter or a JIT compiler to translate them to
> > > > hardware processor native instructions. In general, interpreters
> > > > are considered a source of insecurity (e.g., gadgets susceptible
> > > > to side-channel attacks due to speculative execution) and are not
> > > > recommended.
> >
> > Do we need to say that it's not recommended to use JIT engines? Given
> > that
> this is
> > explaining how BPF programs are executed, to me it reads a bit as
> > saying,
> "It's not
> > recommended to use BPF." Is it not sufficient to just explain the risks?
> 
> It says it's not recommended to use interpreters.
> I couldn't tell if your comment was a typo, did you mean interpreters or
JIT
> engines?
> It should read as saying it's recommended to use a JIT engine rather than
an
> interpreter.
> 
> Do you have a suggested alternate wording?

How about:

OLD: In general, interpreters are considered a
OLD: source of insecurity (e.g., gadgets susceptible to side-channel attacks
due to speculative execution)
OLD: and are not recommended.

NEW: In general, interpreters are considered a
NEW: source of insecurity (e.g., gadgets susceptible to side-channel attacks
due to speculative execution)
NEW: so use of a JIT compiler is recommended instead.

Dave


