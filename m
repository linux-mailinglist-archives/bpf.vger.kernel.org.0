Return-Path: <bpf+bounces-37060-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55AE1950A8D
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 18:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AC771C23514
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 16:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76551A7046;
	Tue, 13 Aug 2024 16:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="a2brPvgs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781491A2C00
	for <bpf@vger.kernel.org>; Tue, 13 Aug 2024 16:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723567215; cv=none; b=YEHhXoF83gyBa+6Ec7xBwnxnajOfZmUhpG4yHFU8ZVTFltdZIvJrcrwRW1YY9eI3BzskqXHQLIP7jcmYzRlRep3IzEyL921gKQl04aGi36wkuq3k5U1iZHKJjZYgp/UpHxDcg9+JE5G1mOKoAD/zE2Z2GfCy0fBWhPI3I7fhPIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723567215; c=relaxed/simple;
	bh=z9ThKaCl2dwq7iAZdlUAc8Sa13mjVWGUvaiqO0kBgkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S7pBRd1WCnrTS4n0yKepac4YhExjGw5ZU2pyKWrTm7Mp8CWWa1Dnt4aDZSu0alC3Gn6Mqabk5xYP13LsbNQgHewOHPvYgOf9AZqYc/GVnKYAYzlzlEA+dx3wcz9cuWm2rOYEMx8hsbZAWaujs7mkzXUT49degEOH/Rj6FiljZ8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=a2brPvgs; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1fc52394c92so52248275ad.1
        for <bpf@vger.kernel.org>; Tue, 13 Aug 2024 09:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723567212; x=1724172012; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UIj0JJnYshjIVjXZcWpKVRySnGCTB+N0e3BxW4PAJ2c=;
        b=a2brPvgsk37d3qEyACZw8pnMuzwnqzj8UVLFy0XDBxdHcZBcdvbXNJ8srijEPHliOP
         /EiS3GAHdEvtm2cNhaUiC78JjFz3LDzcXujtGcT9AS4sIZftNpOExDZoxiz32MZrkqqi
         IwwtVgcK89m4JXQFMxV2Xby5TMMYa4cxnDIvY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723567212; x=1724172012;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UIj0JJnYshjIVjXZcWpKVRySnGCTB+N0e3BxW4PAJ2c=;
        b=ShA76QarZaCW+wKYXS5FDqvE7ls/CVtK1Er7S32kEV8xrMawO4ST5MauzPuGVKVR5F
         VGV0Nt5nId/Tk8IseRHDZpe2Z9wluwYOIpAtRPo9T/2zQMaF1e3KTaGZklPQMIvzjNdp
         PvCSLujTtdrYMDg42HyPdW9t1W85piTT0bGgRa9+GCE9Vgzx9Og9ANaDWHOeI+1xlx2i
         3RwmHQzQtnUWoUEQSG6imE6uE56RT76r1mrSSC3xJRuR6i9cpfCwJdIdSi/O0A61qa01
         SUhnJepPe7dMssfcoRv2iL7D5Q8EgzSSQyMZoF0bHlMkl7Fu9vlDtQHr47upn+8Xn5C0
         DUkA==
X-Forwarded-Encrypted: i=1; AJvYcCWF8/hfB4DXqO14Z3UmQEwdKo37A+FHI7eWIZPuG2cTLy6s8xCUkG54E1y/mP5kf7720jBDQF9dRjzXiEgn9EiQNixz
X-Gm-Message-State: AOJu0YxkUHufmZ0enZCb+AWI6S4jaXhxL4FggB/4cDUc1OPPMhtqaL/e
	IeeQhozvBFNPymtTtHo6Txl3W3dnh2UwVgTX7CVPSOuBy45lLqZEMb45q0z6Qw==
X-Google-Smtp-Source: AGHT+IH/REf7OKTZn9xv3HDv0yFQhoCXp3NXeg4RoixeHv4QdV9uxYQmfmO+wc0WQGBCMgKE9Yyo2Q==
X-Received: by 2002:a17:903:1c6:b0:1fb:9280:c970 with SMTP id d9443c01a7336-201d638d7a2mr1036295ad.7.1723567211719;
        Tue, 13 Aug 2024 09:40:11 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:45ad:979d:1377:77f0])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-201cd130632sm15867485ad.49.2024.08.13.09.40.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Aug 2024 09:40:11 -0700 (PDT)
Date: Tue, 13 Aug 2024 09:40:08 -0700
From: Brian Norris <briannorris@chromium.org>
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>, bpf@vger.kernel.org,
	linux-kbuild@vger.kernel.org
Subject: Re: [PATCH v4 2/3] tools build: Avoid circular .fixdep-in.o.cmd
 issues
Message-ID: <ZruMaIGu8EoAE1Fy@google.com>
References: <20240715203325.3832977-1-briannorris@chromium.org>
 <20240715203325.3832977-3-briannorris@chromium.org>
 <99ae0d34-ed76-4ca0-a9fd-c337da33c9f9@leemhuis.info>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99ae0d34-ed76-4ca0-a9fd-c337da33c9f9@leemhuis.info>

Hi Thorsten,

On Mon, Aug 12, 2024 at 08:32:29AM +0200, Thorsten Leemhuis wrote:
> Lo! TWIMC, this change broke my daily arm64 and x86_64 Fedora vanilla RPM
> builds on all Fedora releases when it hit -next a few days ago. Reverting
> it fixes the problem.
> 
> The problem is related to the RPM magic somehow, as building worked fine
> when when I omitted stuff like "-specs=/usr/lib/rpm/redhat/redhat-
> hardened-cc1 -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1" from the
> make call. So the real problem might be that space somewhere.
> 
> 
> This is how the build fails on x86_64:
> 
> + /usr/bin/make -s 'HOSTCFLAGS=-O2  -fexceptions -g -grecord-gcc-switches -pipe -Wall -Werror=format-security -Wp,-U_FORTIFY_SOURCE,-D_FORTIFY_SOURCE=3 -Wp,-D_GLIBCXX_ASSERTIONS -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1  -m64 -march=x86-64 -mtune=generic -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection   ' 'HOSTLDFLAGS=-Wl,-z,relro -Wl,--as-needed  -Wl,-z,pack-relative-relocs -Wl,-z,now -specs=/usr/lib/rpm/redhat/redhat-hardened-ld -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1  -Wl,--build-id=sha1 -specs=/usr/lib/rpm/redhat/redhat-package-notes ' ARCH=x86_64 'KCFLAGS= ' WITH_GCOV=0 -j2 bzImage
> /usr/bin/ld: /tmp/ccMoR0Wr.o: relocation R_X86_64_32 against `.rodata' can not be used when making a PIE object; recompile with -fPIE
> /usr/bin/ld: failed to set dynamic section sizes: bad value
> collect2: error: ld returned 1 exit status
> make[4]: *** [Makefile:47: /builddir/build/BUILD/kernel-next-20240812/linux-6.11.0-0.0.next.20240812.329.vanilla.fc40.x86_64/tools/objtool/fixdep] Error 1
> make[3]: *** [/builddir/build/BUILD/kernel-next-20240812/linux-6.11.0-0.0.next.20240812.329.vanilla.fc40.x86_64/tools/build/Makefile.include:15: fixdep] Error 2
> make[2]: *** [Makefile:73: objtool] Error 2
> make[1]: *** [/builddir/build/BUILD/kernel-next-20240812/linux-6.11.0-0.0.next.20240812.329.vanilla.fc40.x86_64/Makefile:1361: tools/objtool] Error 2
> make[1]: *** Waiting for unfinished jobs....
> make: *** [Makefile:226: __sub-make] Error 2
> error: Bad exit status from /var/tmp/rpm-tmp.ZQfBFY (%build)

I don't have a Fedora installation on hand at the moment, and the logs
don't seem to include most of the actual kernel build logs
(stdout+stderr of a V=1 build might help), but I think what you've
provided so far has highlighted one possible problem -- that the new
one-shot compile+link is ignoring HOSTCFLAGS, which were previously
respected via tools/build/Build.include. Could you try the following
diff? I'll cook a proper patch and description later, but for now:

--- a/tools/build/Makefile
+++ b/tools/build/Makefile
@@ -44,4 +44,4 @@ ifneq ($(wildcard $(TMP_O)),)
 endif
 
 $(OUTPUT)fixdep: $(srctree)/tools/build/fixdep.c
-	$(QUIET_CC)$(HOSTCC) $(KBUILD_HOSTLDFLAGS) -o $@ $<
+	$(QUIET_CC)$(HOSTCC) $(HOSTCFLAGS) $(KBUILD_HOSTLDFLAGS) -o $@ $<

