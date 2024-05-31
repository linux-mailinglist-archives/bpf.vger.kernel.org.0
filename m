Return-Path: <bpf+bounces-31014-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B568D5FFE
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 12:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D298C1C21CCB
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 10:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544C2157493;
	Fri, 31 May 2024 10:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XsLAv8t3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF3F15747A;
	Fri, 31 May 2024 10:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717152583; cv=none; b=SHPy3Mjcto2fzr/Uk1ChQ6ojfTogeRsFXYU4l1JP0L0SxmmBcUv8tctabVIcgLBGwUETrr6v60tsk8urIdxOipcMxXKIGwOWa+etYtoWLdMOXJ3UQxhh20OMF57Op5KoPijN25wHpvSisXOHnvWp0lVMjjbck/F+E0FvHdUmwq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717152583; c=relaxed/simple;
	bh=TZK5LxeUICrVQHiZoUcyt6cd5p1exOK0M3353KuNPMo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s/cRYULnNHeFFn1gA9gRfnBfMcWZFLQM8MfVhR1y7S2X56OhJhgaPDTp9JNQXVmNFNNNcd6PzxXnQt6enR+diZ1mouz65r3PMYJ+H1+iet26LHKCZ6YU6Qi95yzvM6P+cjotHjZFmaArnz5hIyDbSuIsFAwrvtGjYFMboDxgHcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XsLAv8t3; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-70224f928edso791079b3a.0;
        Fri, 31 May 2024 03:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717152581; x=1717757381; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=g4n0R3mMEdWCwf2SbY1d4W48Oq3QTZVbiN4nRsQtqCM=;
        b=XsLAv8t3nH0zFcRukjzxdcouXMfaDV8xmpb9G82qWvNk1cwzHm1Q3yGTDa8JnxvxkA
         ltTZWDCQqOzlAWVfpSBi11H4BA/DxFrMTYh7R6WHMmrnd48QLfH1wxaMNN/9giseSv5j
         xXUw04OsUK9jyxGijYi7A+usLHL9JJyH83X7TpZhdhQBAGvBTxR5abGg+Y0MXgYkZre+
         1+Fy891in28VkVTUR+RN8J/rXH1lwt6to5dYu8hnFMvMsBNY5gD6uxE4jpVlvlADmDzQ
         47Tjn7PEpBYfAkDjl1BCXIlMs1lQHCsOTzMTdtowVL+RCwSEla7cagX9GrDsmOadUy8B
         n+yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717152581; x=1717757381;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g4n0R3mMEdWCwf2SbY1d4W48Oq3QTZVbiN4nRsQtqCM=;
        b=CvR/FQQLEBwVwzZsWAOHGT+iw+Ctn5RdQw9RS5gvkQYW1CtPmOdx6Vi7FA5hur0+0H
         zGIzUEZtBP7e/Y41yLjbGU551fJ9Jgq9WirMXm6O+jocz/Hiex5vxuccPDBtXiUiqFgP
         PUW3ZK1OM9AVworPsJomdZfHRarvINaCnivU2E/RuFX0R4q0FPa8j+SD2DjiDXAPUmun
         9GLwlvciwVVuI2V4vHG0p7idoAl8SVTO7TIjnXTzzIfmBL0aG2WOhIUZkOSDX2GEB4Be
         i4i2qBA6gqNBoZoBqONuMiLJS6u7W41nxu6FwONPI/C+4D5PHMAWCNUOoJIA9OPhVsj7
         Ukeg==
X-Forwarded-Encrypted: i=1; AJvYcCXU2EK3Q8osS7UPZpc2SZovzXILsuMMeqYe4R6g39J6HB+wx/5KXi1odELiRmKUeOGOpiFP4n12ZFL5eualNn/nuWqelLrx+g==
X-Gm-Message-State: AOJu0YzczBDpk9JApWV5eUX98fgr+TElmnJSJvinAh+6o3G4Nw6KlH4w
	GNEhF2lLElH4/lJf8tc3kwvzFaSKGSmoHVKeCjbujJPP+m8UoOjv
X-Google-Smtp-Source: AGHT+IGqOSEhK3+tVMLzk4BJnhb0whESZZrWo194wDn9S9npz2F/mDu+whzHIX91GD2aZ+B9zmYv5Q==
X-Received: by 2002:a05:6a00:18a7:b0:702:40ac:3d34 with SMTP id d2e1a72fcca58-702477bc01dmr1554636b3a.3.1717152580741;
        Fri, 31 May 2024 03:49:40 -0700 (PDT)
Received: from kodidev-ubuntu (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70242b0506bsm1170230b3a.144.2024.05.31.03.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 03:49:40 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
X-Google-Original-From: Tony Ambardar <Tony.Ambardar@gmail.com>
Date: Fri, 31 May 2024 03:49:38 -0700
To: Hengqi Chen <hengqi.chen@gmail.com>
Cc: bpf@vger.kernel.org, dwarves@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: Problem with BTF generation on mips64el
Message-ID: <ZlmrQqQSJyNH7fVF@kodidev-ubuntu>
References: <ZlkoM6/PSxVcGM6X@kodidev-ubuntu>
 <CAEyhmHT_1N3xwLO2BwVK97ebrABJv52d5dWxzvuNNcF-OF5gKw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEyhmHT_1N3xwLO2BwVK97ebrABJv52d5dWxzvuNNcF-OF5gKw@mail.gmail.com>

Hello Hengqi,

On Fri, May 31, 2024 at 10:17:53AM +0800, Hengqi Chen wrote:
> Hi Tony,
> 
> On Fri, May 31, 2024 at 9:30 AM Tony Ambardar <tony.ambardar@gmail.com> wrote:
> >
> > Hello,
> >
> > For some time now I'm seeing multiple issues during BTF generation while
> > building recent kernels targeting mips64el, and would appreciate some help
> > to understand and fix the problems.
> >
> SNIP
> >
> > >   CC [M]  net/ipv6/netfilter/nft_fib_ipv6.mod.o
> > >   CC [M]  net/ipv6/netfilter/ip6t_REJECT.mod.o
> > >   CC [M]  net/psample/psample.mod.o
> > >   LD [M]  crypto/cmac.ko
> > >   BTF [M] crypto/cmac.ko
> > > die__process: DW_TAG_compile_unit, DW_TAG_type_unit, DW_TAG_partial_unit
> > > or DW_TAG_skeleton_unit expected got member (0xd)!
> 
> The issue seems to be related to elfutils. Have you tried build from
> the latest elfutils source ?
> I saw the latest MIPS backend in elfutils already implemented the
> reloc_simple_type hook.

Good idea. I tried rebuilding elfutils from the latest upstream commit:
https://sourceware.org/git/?p=elfutils.git;a=commit;h=935ee131cf7c87296df9412b7e3370085e7c7508

I then linked this elfutils with pahole built from the latest pahole/next:
https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?h=next&id=a9ae414fef421bdeb13ff7ffe13271e1e4f58993

I also confirmed resolve_btfids links to the new elfutils, and then rebuilt
the kernel with the same config. Unfortunately, the warnings/errors from
resolve_btfids and pahole still occur.

> SNIP
> >
> > I'd be grateful if some of the BTF/pahole experts could please review this
> > issue and share next steps or other details I might provide.
> >
> > Thanks,
> > Tony Ambardar
> >
> > Link: https://lore.kernel.org/all/202401211357.OCX9yllM-lkp@intel.com/ [1]
> > Link: https://github.com/acmel/dwarves/issues/45 [2]
> 
> Cheers,
> Hengqi

Thanks for the suggestion,
Tony

