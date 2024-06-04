Return-Path: <bpf+bounces-31285-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9296F8FA8DA
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 05:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 881141C235BE
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 03:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112A213D610;
	Tue,  4 Jun 2024 03:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WKQzp9jn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A2312E1CA;
	Tue,  4 Jun 2024 03:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717472849; cv=none; b=CTfiX9XMuhH1a66iCEx9okw654dlHNxzYz+fL2fx9yDR+G3t2n0oBWyh0gq/NoEELXRe99TmT0qyYvsBd0lQu8dWbHpkmIQz10FkOHahO2fE2hyopuCZzayzy37O/8TNOGyYHL8d9SQ207+cmXOvgmiJmbHS60mVTdUpkUC8uMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717472849; c=relaxed/simple;
	bh=lYgQ8mGvxT+1WAkUeu0t9pUOgqqff82r7laa7FjigyY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aJp0zDuS1R7rUICNQs7+2Js8paKZxGCld7s/EQgXG/DutmUIq6t0BZke3iXCmeiHlHvs86qmlljIs7L9ng36F+ThEr7cp1MR2x1sT+KcdbTZngjhaTg7HtOfX+qw++BfYBPuxlUmWBSP9wmqc1juCq2ZGCxcAITSctd6kWxNluc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WKQzp9jn; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6f4603237e0so3301338b3a.0;
        Mon, 03 Jun 2024 20:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717472847; x=1718077647; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ak/eZx5EWA1JDi4ZUDaC6vp4qjbYsrz29dtwd00aoe0=;
        b=WKQzp9jnxaT7pU9ExVOEvD4ZSPKEEQdxzcunqFERkGwcteRDdPMKuBnwR4tlR9OZi+
         psgU46Q1fM8nDgle2csUq6tTFUH3QU8Rpi7kjcap0aW6/RnHUYAIWcbsmZ/X6qCGpJ1i
         e/NCVw/teRDQzIaHNXQf9pTZW0QogUxfsJlwIWIzn6UfmrPIHCcq5+chB2aDEAkZEL79
         q6FNYg8kec1p9E3TI2AGwG8vfoZad4SrmgokHBNcIvoF2KuS1itfxHqxYm5oCmRvT3xS
         Hranh4VtpjEPMv7GbJRhXsc4jYe70v9jzb7iG7Br3oci4H69Yn9KBXrhhLbObuFxksB0
         9LFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717472847; x=1718077647;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ak/eZx5EWA1JDi4ZUDaC6vp4qjbYsrz29dtwd00aoe0=;
        b=aPgCWc/8K11FFALeqBOe1hXFFQNyfZy0fR4fTGxUHhhikiNSOesyIso3o5u31y/H9y
         xV1B2nTV4dhUd04arzAlOl3ApNIx4EwVm58sznyMuact5g+domQOOrvwdPSMr4I6Z3fy
         0V5dGrqgNaJklfpZVDFISxrjhjefTaf/FAAHG99gYTmZ95MNyVMVQdb6Xs9szI+uI6sX
         OBg34LXOcCV40OtGPq27kr1rIElgTThHvEufh0zWEAyepW2IogeMCjDpQQ3qdjB4Wwdu
         urmeHctiX50hrbyrA4tABFTIVJxY1mPw+auHOb9Wq3024erNNBI1IoT1FuiWxok+Gx47
         fpMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVI2PbIQ4A8RrV+XASlO2MdqWg/pNV9Jtz17NLT4PaQpNoVIwEO3wIH+L7zVxMVr+QkEL4OLY213gnvEtimqlstN2b0kVoeVDWSca5rZAd0blDAgdTBvAVWmOTxwA==
X-Gm-Message-State: AOJu0Yzq3g52beJp1Vy5/Mol6GFM+cPN125Psfn/oM136vcx6UfprgXh
	gIwUo1sgrZ+seSx6arXiM75RDGeLH0MHtP+lRnRBxiajSy04Z/Ek2Lhf+xv+
X-Google-Smtp-Source: AGHT+IG6qKfUePNcjHPa7d1uDw4KJCOnQyIUq3G0C28nuhuDJrj6QSREzfb+EaIGnh1SHcrv/UQFKA==
X-Received: by 2002:aa7:9906:0:b0:702:6639:8191 with SMTP id d2e1a72fcca58-7027fca0547mr1792149b3a.16.1717472847258;
        Mon, 03 Jun 2024 20:47:27 -0700 (PDT)
Received: from kodidev-ubuntu (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-702425da465sm6224750b3a.73.2024.06.03.20.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 20:47:26 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
X-Google-Original-From: Tony Ambardar <Tony.Ambardar@gmail.com>
Date: Mon, 3 Jun 2024 20:47:24 -0700
To: Mark Wielaard <mark@klomp.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Wielaard <mjw@redhat.com>, Hengqi Chen <hengqi.chen@gmail.com>,
	Ying Huang <ying.huang@oss.cipunited.com>, bpf@vger.kernel.org,
	dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: elfutils DWARF problem was: Re: Problem with BTF generation on
 mips64el
Message-ID: <Zl6OTJXw0LH6uWIN@kodidev-ubuntu>
References: <ZlkoM6/PSxVcGM6X@kodidev-ubuntu>
 <CAEyhmHT_1N3xwLO2BwVK97ebrABJv52d5dWxzvuNNcF-OF5gKw@mail.gmail.com>
 <ZlmrQqQSJyNH7fVF@kodidev-ubuntu>
 <Zln1kZnu2Xxeyngj@x1>
 <Zl2m4RP7BwhZ0J6l@kodidev-ubuntu>
 <Zl3Zp5r9m6X_i_J4@x1>
 <Zl4AHfG6Gg5Htdgc@x1>
 <20240603191833.GD4421@gnu.wildebeest.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603191833.GD4421@gnu.wildebeest.org>

Hi Mark,

On Mon, Jun 03, 2024 at 09:18:33PM +0200, Mark Wielaard wrote:
> On Mon, Jun 03, 2024 at 02:40:45PM -0300, Arnaldo Carvalho de Melo wrote:
> > Couldn't find a way to ask eu-readelf for more verbose output, where we
> > could perhaps get some clue as to why it produces nothing while binutils
> > readelf manages to grok it, Mark, do you know some other way to ask
> > eu-readelf to produce more debug output?
> > 
> > I'm unsure if the netdevsim.ko file was left in a semi encoded BTF state
> > that then made eu-readelf to not be able to process it while pahole,
> > that uses eltuils' libraries, was able to process the first two CUs for
> > a kernel module and all the CUs for the vmlinux file :-\
> > 
> > Mark, the whole thread is available at:
> > 
> > https://lore.kernel.org/all/Zl3Zp5r9m6X_i_J4@x1/T/#u
> 
> I haven't looked at the vmlinux file. But for the .ko file the issue
> is that the elfutils MIPS backend isn't complete. Specifically MIPS
> relocations aren't recognized (and so cannot be applied). There are
> some pending patches which try to fix that:
> 
> https://patchwork.sourceware.org/project/elfutils/list/?series=31601

Earlier in the thread, Hengqi Chen pointed out the latest elfutils backend
work for MIPS, and I locally rebuilt elfutils and then pahole from their
respective next/main branches. For elfutils, main (935ee131cf7c) includes

  e259f126 Support Mips architecture
  f2acb069 stack: Fix stack unwind failure on mips
  db33cb0c backends: Add register_info, return_value_location, core_note mips

which partially applies the patchwork series but leaves out the support for
readelf, strip, and elflint.

I believe this means the vmlinux and .ko files I shared are OK, or is there
more backend work needed for MIPS?

The bits missing in eu-readelf would explain the blank output both Arnaldo
and I see from "$ eu-readelf -winfo vmlinux". I tried rebuilding with the
patchwork readelf patch locally but ran into merge conflicts.

CCing Ying Huang for any more insight.

Thanks,
Tony

