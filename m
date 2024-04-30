Return-Path: <bpf+bounces-28263-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DAA18B76A6
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 15:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5DB9B23529
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 13:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59995171661;
	Tue, 30 Apr 2024 13:12:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6950F12C462;
	Tue, 30 Apr 2024 13:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714482769; cv=none; b=bizNtb/IinhwxloC/8ccMhsuleR6fCZz/2yXPHhYB8KuOo+xY5yxVl54ZZx00ZbbTkCmOXL/1/iH4SkZ/zOG5eRmknYkpGI1fpT1DS4c6BaTKbj/6R4YfaRB8Qnwnk3px3352SCcwof3yaqd6vBKapz9k3RhwM1O5FAVUDYFwyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714482769; c=relaxed/simple;
	bh=c2b9oVIC0DFqIbH95w9MNMEfLtZMODrmGOv2WIJUmB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IBxTsSLYD/lVbTWC4+vCycmNrnOYcS/cdyRChQ4iiN6vzIywH0+q/kL9S3sZzdZQC4EMbJwRampnYGhIGn5pCiZrrp63hJc9igXZK8SRIZU0+OUjsgSdpQ4GJHRzS5Py8wkS0WDte/VguKSEaPyU9CpRZxddgnPPYttv6RMH2Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-572250b7704so5863045a12.2;
        Tue, 30 Apr 2024 06:12:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714482765; x=1715087565;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cii8/IWqKhvh8abgMj6yG5t33aO8AJebZceGcfgu+WM=;
        b=ejplV1gXTmzT76lfB3FlKJNsnVh5ubp+0z8PgBwzg5w8EHKjeg1Eq4HFaygGIAgeji
         AomSHnNk2hhbynxRj6DfmQoqG8Cs2EmF5DbxENeEW1nTGp2Lnc75GwvDbio/MDJAXl4Z
         15RxeWKWck0Eoel48sYBdWn/ZGXHkgqlTebpMt849oLjFOsjB6dhecPL7mf/ofcT+am1
         crOeoHW6+18kC8UMfOS4H/0MFOq/6p3X6K39VICVLVTUc7PCxSDxXa6DIQSCV71qofy2
         inLMaRgCHYm0nK3Ohp8gnTcvzjZHUSLj/D4NmLCaKFCd+bbNeT3tuWnzASK0hH+kTlBq
         rfVw==
X-Forwarded-Encrypted: i=1; AJvYcCXfUXcfUlgW3ZKgsThGolNKY1ETL5dSIVQk4HNfqVZ8uDTyLHhXajmRL66iiqXCz+wmIAZ7QIO4o8wptuYwaQklD1B5JqzB2Y6ZPB0HG0noeyHGp53Y5Ue0HQ/MaL8bZOCg
X-Gm-Message-State: AOJu0YxxljX0QSAzvfGsRdwHU5fDOXP9qY7lWUa71rutQlha/NyuKP87
	Fpbm79A+92AH/Dx4O3Wq/PSY87tiWbALfLFHGI8OkEcreHuVqcmw
X-Google-Smtp-Source: AGHT+IEkHgtxOrJTZCEhXu6z1xJ8e341ftN/dsJCk0MOFDl0lI0eGJaRYQtIL8w8CcBZw5QGKZgfdg==
X-Received: by 2002:a17:906:358b:b0:a51:9911:eba8 with SMTP id o11-20020a170906358b00b00a519911eba8mr1889747ejb.4.1714482765279;
        Tue, 30 Apr 2024 06:12:45 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-009.fbsv.net. [2a03:2880:30ff:9::face:b00c])
        by smtp.gmail.com with ESMTPSA id t11-20020a170906a10b00b00a5244a80cfcsm15157574ejy.91.2024.04.30.06.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 06:12:44 -0700 (PDT)
Date: Tue, 30 Apr 2024 06:12:42 -0700
From: Breno Leitao <leitao@debian.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: jpoimboe@kernel.org, mingo@redhat.com, tglx@linutronix.de, bp@alien8.de,
	x86@kernel.org, leit@meta.com, linux-kernel@vger.kernel.org,
	pawan.kumar.gupta@linux.intel.com, bpf@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v6 00/13] x86/bugs: Add a separate config for each
 mitigation
Message-ID: <ZjDuSkXi2D01DK1y@gmail.com>
References: <20231121160740.1249350-1-leitao@debian.org>
 <ZZ5p3vdnTtU5TeJe@gmail.com>
 <ZZ6FwMTRppSa2eOG@gmail.com>
 <ZZ7c9EbJ71zU5TOF@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZ7c9EbJ71zU5TOF@gmail.com>

Hello Ingo,

On Wed, Jan 10, 2024 at 07:07:48PM +0100, Ingo Molnar wrote:
> 
> * Breno Leitao <leitao@debian.org> wrote:
> 
> > > Yeah, so:
> > > 
> > >  - I took this older series and updated it to current upstream, and made
> > >    sure all renames were fully done: there were two new Kconfig option
> > >    uses, which I integrated into the series. (Sorry about the delay, holiday & stuff.)
> > > 
> > >  - I also widened the renames to comments and messages, which were not
> > >    always covered.
> > > 
> > >  - Then I took this cover letter and combined it with a more high level
> > >    description of the reasoning behind this series I wrote up, and added it
> > >    to patch #1. (see it below.)
> > > 
> > >  - Then I removed the changelog repetition from the other patches and just
> > >    referred them back to patch #1.
> > > 
> > >  - Then I stuck the resulting updated series into tip:x86/bugs, without the 
> > >    last 3 patches that modify behavior.
> > 
> > Thanks for your work. I am currently reviwing the tip branch and the
> > merge seems go so far.
> > 
> > Regarding the last 3 patches, what are the next steps?
> 
> Please resubmit them in a few days (with Josh's Acked-by added and any 
> fixes/enhancements done along the way), on top of tip:x86/bugs.

I've sent the commits on top of the latest mitigations. Have you had a
chance to see them?

	https://lore.kernel.org/all/20240422165830.2142904-1-leitao@debian.org/

PS: I took the opportunity to break them down, one per mitigation, so, it
could simplify the patch management.

Thanks

