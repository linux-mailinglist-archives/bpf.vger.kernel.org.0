Return-Path: <bpf+bounces-44401-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC2B9C281D
	for <lists+bpf@lfdr.de>; Sat,  9 Nov 2024 00:26:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98D2DB22B7A
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 23:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DAEB1E32B0;
	Fri,  8 Nov 2024 23:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJYJ75Kk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC43A1DC06B;
	Fri,  8 Nov 2024 23:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731108395; cv=none; b=mi6Mc9rHecWRGWy/5fVqPYfFnQWkOrNatXLSVfeTNEVWhpOvfKO5k6sqwDHULSYbFDYZ5rXp9hIdD4TiElL7mtYb7j8UJNlkhuXdX0yV0xXbZYEK8xBzRuIFKBCO8AcW7x1MIF7kg0Bw33lhsu3UohGozJIrxea5yTTWu2b0J5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731108395; c=relaxed/simple;
	bh=sxA+We695iipQ4eZV9aeSTLGXVdWZwHQT9IuQKh8rl0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=crhRoE+3BAAvlSXd/MKY098Jeb5x5g4N+2vMEdcghrjareMuew4ZT93iQxC5J+oK0BeqoRmutYKWJyJdbf1J4eD4Oelr04m6eewJ+/NTzyHBqRDk+tMlb3yGJjSx9I1Bfcu5cyWCLG/VDrFNjcCJ/e0PjbnrU6i5syfak01sVPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aJYJ75Kk; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-37d473c4bb6so2237255f8f.3;
        Fri, 08 Nov 2024 15:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731108392; x=1731713192; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y372NZXOCshw1bVMFXTnFTZlB5n9lu8kCY0Rrvuncr4=;
        b=aJYJ75KkhQWuACICEBlytc+wVOWZN02173Da2X4Am4C1+ujNeKqIQiME0t37HWOGj7
         YSsPzvHl+YA4OAbe+h8RVlg7OvRutjZjjT8+Cjem0gW4/is5aoadvsT3WB5qLGrCF5SL
         4neoS3PC4arWdARyLkFa4vutG322Mru3Hq4DE+15jaqmA6Qc1yKJSiIv4oxtN2qkPRgR
         eMHT6M4S7jF3H94YTl2ohfGv2mYc2xb5KI8szLjJwXj9YsVXz/A2sXw/E2JqpWUyDZ8s
         9EPCjA8mICD7Vz/CWBlZwhI69HW7QUgosQixHr5VrwVDyDZ19n9JXzbH+d97y2J0fKRX
         /6pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731108392; x=1731713192;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y372NZXOCshw1bVMFXTnFTZlB5n9lu8kCY0Rrvuncr4=;
        b=gjeIFcitAzcCjDspZHhkW5dRoNJXzVwH5g3GmYQV5qeS4mpnR+t5MdzdXwVGY5Z77M
         NQ+zIfGjgQ3dd2vODvGVXzvwGRYrNhMb2yP3GpJYOE98qNuw8LoPCdwXV35aI09HE60P
         o5V9TgVDAQAypX6ukgdgyVPSt8TxImHd01tOZ9Szqo5IIEG0XCwzt5McdW+xzFO3LZ3f
         hmcwUGfV37vbI8Gui26t8XPCGe0bDDMrlJE46Jk4Q0E4mEe79S00Mjpvi4M1CxNT4xl4
         B/11VvXB26who0ygjUOLtEPE1WxrBCHnUUiz9ThPNm7Zb3eXynHz3t/bfiR7F5xC1fBJ
         5oSw==
X-Forwarded-Encrypted: i=1; AJvYcCWA6qW35JCSERMso8mAR/j7rmBdwBbdpbYQuYtzLqeZoTAuaPvFaK11cW/8vXoq1lZA1F8++Ug3@vger.kernel.org, AJvYcCXOhiI9N+G799mYgzMbijr/UFzl2p9OfmdPUS+P4iS5qtmRiGND3FkHnouvNmc4//Gw7Rs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7ctTN9EEjMGXDFz74oDQfAcKY4WVErutpXoQo6/10Ge5dbqCK
	VtcLoQ3o1OjJEmr0NEGxcaNfCWrqfZHgMN/bseP0BVed1pGKZGII
X-Google-Smtp-Source: AGHT+IEkL/K3Y9tz8xmrufY9me3usEv0F8ozJQaRjEh6waSAev7wq5HlOzUzqA5MDO6lZftgdX0V9A==
X-Received: by 2002:a05:6000:1a89:b0:37d:4cf9:e08b with SMTP id ffacd0b85a97d-381f18723d4mr4377981f8f.31.1731108391817;
        Fri, 08 Nov 2024 15:26:31 -0800 (PST)
Received: from krava (85-193-35-42.rib.o2.cz. [85.193.35.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381eda04ad0sm6166510f8f.100.2024.11.08.15.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 15:26:31 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sat, 9 Nov 2024 00:26:29 +0100
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Omar Sandoval <osandov@osandov.com>,
	Greg KH <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
	bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: Fix build ID parsing logic in stable trees
Message-ID: <Zy6eJdwR3LWOlrQg@krava>
References: <20241104175256.2327164-1-jolsa@kernel.org>
 <2024110536-agonizing-campus-21f0@gregkh>
 <ZyniGMz5QLhGVWSY@krava>
 <2024110636-rebound-chip-f389@gregkh>
 <ZytZrt31Y1N7-hXK@krava>
 <Zy0dNahbYlHISjkU@telecaster>
 <Zy3NVkewYPO9ZSDx@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zy3NVkewYPO9ZSDx@krava>

On Fri, Nov 08, 2024 at 09:35:34AM +0100, Jiri Olsa wrote:
> On Thu, Nov 07, 2024 at 12:04:05PM -0800, Omar Sandoval wrote:
> > On Wed, Nov 06, 2024 at 12:57:34PM +0100, Jiri Olsa wrote:
> > > On Wed, Nov 06, 2024 at 07:12:05AM +0100, Greg KH wrote:
> > > > On Tue, Nov 05, 2024 at 10:15:04AM +0100, Jiri Olsa wrote:
> > > > > On Tue, Nov 05, 2024 at 07:54:48AM +0100, Greg KH wrote:
> > > > > > On Mon, Nov 04, 2024 at 06:52:52PM +0100, Jiri Olsa wrote:
> > > > > > > hi,
> > > > > > > sending fix for buildid parsing that affects only stable trees
> > > > > > > after merging upstream fix [1].
> > > > > > > 
> > > > > > > Upstream then factored out the whole buildid parsing code, so it
> > > > > > > does not have the problem.
> > > > > > 
> > > > > > Why not just take those patches instead?
> > > > > 
> > > > > I guess we could, but I thought it's too big for stable
> > > > > 
> > > > > we'd need following 2 changes to fix the issue:
> > > > >   de3ec364c3c3 lib/buildid: add single folio-based file reader abstraction
> > > > >   60c845b4896b lib/buildid: take into account e_phoff when fetching program headers
> > > > > 
> > > > > and there's also few other follow ups:
> > > > >   5ac9b4e935df lib/buildid: Handle memfd_secret() files in build_id_parse()
> > > > >   cdbb44f9a74f lib/buildid: don't limit .note.gnu.build-id to the first page in ELF
> > > > >   ad41251c290d lib/buildid: implement sleepable build_id_parse() API
> > > > >   45b8fc309654 lib/buildid: rename build_id_parse() into build_id_parse_nofault()
> > > > >   4e9d360c4cdf lib/buildid: remove single-page limit for PHDR search
> > > > > 
> > > > > which I guess are not strictly needed
> > > > 
> > > > Can you verify what exact ones are needed here?  We'll be glad to take
> > > > them if you can verify that they work properly.
> > > 
> > > ok, will check
> > 
> > Hello,
> > 
> > I noticed that the BUILD-ID field in vmcoreinfo is broken on
> > stable/longterm kernels and found this thread. Can we please get this
> > fixed soon?
> > 
> > I tried cherry-picking the patches mentioned above ("lib/buildid: add
> > single folio-based file reader abstraction" and "lib/buildid: take into
> > account e_phoff when fetching program headers"), but they don't apply
> > cleanly before 6.11, and they'd need to be reworked for 5.15, which was
> > before folios were introduced. Jiri's minimal fix works for me and seems
> > like a much safer option.
> 
> hi,
> thanks for testing
> 
> I think for 6.11 we could go with backport of:
>   de3ec364c3c3 lib/buildid: add single folio-based file reader abstraction
>   60c845b4896b lib/buildid: take into account e_phoff when fetching program headers
> 
> and with the small fix for the rest
> 
> but I still need to figure out why also 60c845b4896b is needed
> to fix the issue on 6.11.. hopefully today

ok, so the fix the issue in 6.11 with upstream backports we'd need both:

  1) de3ec364c3c3 lib/buildid: add single folio-based file reader abstraction
  2) 60c845b4896b lib/buildid: take into account e_phoff when fetching program headers

2) is needed because 1) seems to omit ehdr->e_phoff addition (patch below)
which is added back in 2)

IMO 6.11 is close to upstream and by taking above upstream fixes it will be
easier to backport other possible fixes in the future, for other trees I'd
take the original one line fix I posted

jirka


---
diff --git a/lib/buildid.c b/lib/buildid.c
index bfe00b66b1e8..19d9a0f6ce99 100644
--- a/lib/buildid.c
+++ b/lib/buildid.c
@@ -234,7 +234,7 @@ static int get_build_id_32(struct freader *r, unsigned char *build_id, __u32 *si
 		return -EINVAL;
 
 	for (i = 0; i < phnum; ++i) {
-		phdr = freader_fetch(r, i * sizeof(Elf32_Phdr), sizeof(Elf32_Phdr));
+		phdr = freader_fetch(r, sizeof(Elf32_Ehdr) + i * sizeof(Elf32_Phdr), sizeof(Elf32_Phdr));
 		if (!phdr)
 			return r->err;
 
@@ -272,7 +272,7 @@ static int get_build_id_64(struct freader *r, unsigned char *build_id, __u32 *si
 		return -EINVAL;
 
 	for (i = 0; i < phnum; ++i) {
-		phdr = freader_fetch(r, i * sizeof(Elf64_Phdr), sizeof(Elf64_Phdr));
+		phdr = freader_fetch(r, sizeof(Elf64_Ehdr) + i * sizeof(Elf64_Phdr), sizeof(Elf64_Phdr));
 		if (!phdr)
 			return r->err;
 

