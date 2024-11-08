Return-Path: <bpf+bounces-44339-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E605F9C1819
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 09:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4D58282D1D
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 08:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8BA71DEFD6;
	Fri,  8 Nov 2024 08:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hAaDdgms"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EE71F5FA;
	Fri,  8 Nov 2024 08:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731054940; cv=none; b=T8C7wwEmvbZmY0DoR1On2q9zqt1zHgFCM4ZUQuc4JLgy3n+LB37WGru1jZigqlBG9k/opmfE0gm31T5khDV8CzfiCQ2buegry8XEjnd840mLqmsWsMcK9/dHesXjia7OZX7ZB6BLsZJI2suX5Ueide3DxrXJYhqxhJ34GV+Qc+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731054940; c=relaxed/simple;
	bh=O+/+S076NvjXKoCnCGtPzOmgOPCrXENMgPUPkH5hqPQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hy7z29wOSaGQxDNxAfgWo6bdRbfVZI6JAtu9gLl0/eend3JtxG7gEqn+cbIWS6X4icNuvYOzkNELDzsiY1mw7T4mpkP4UDZPohFGQ3rvA8bux+o6sjmE5pm1w6a1rhG+LPER8jYxrfBgJQgM+N2vg6wPUQluYq8aufk+2ee/DlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hAaDdgms; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5cec7cde922so2403588a12.3;
        Fri, 08 Nov 2024 00:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731054937; x=1731659737; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/E2JQn1w8PZb9OK5WGvb8o22/47bYA0PR0jq9rxm3pc=;
        b=hAaDdgms3dlOnx3RwVbogn8Npj+Q8biD92zPpAfNEXnzhefrygvYGiBdcpjPB2KfAo
         xVemvXErXZrBWEgudPAlu/v7N5E+/Ia8qSY/J2qPISCjqzC6vcH8vbnRK188G8GgPuVv
         cJ0A+MXepYPsmFicAZBdpVh1tgBZNKHKEY9PL8ejZCqUZ3Z84f6rLDXPcr/KtHeNUxSN
         vqoTT2eJSpNStpvtgum8xNfQYlrXbgSpx4a46k0DrWiyaJ3w19VfKKxbZz1h+qAwaMOE
         ejjeXhC3GY1O9lsN8wKPu+HqHCXOQcntB72iCIawT59rwrJWqNP923C4z59PDMOWFvbT
         km7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731054937; x=1731659737;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/E2JQn1w8PZb9OK5WGvb8o22/47bYA0PR0jq9rxm3pc=;
        b=ReDQHAEGbC7HOb9Kr8yF/YIExoGeoZANkLszH0rNsONSj7DaZEzawI+XnOOOSJVzyo
         b4EQN9JKbxUsGRfOfiWk4uGu7gxMbdb8ZiuzIWhMgMJFKpMVJOXtVniZ2TjdFSvm5/an
         hoFclIb37iZbFv/+rO1oMWiTlg3ExMhoc3vyV9HyYKg8nD7maE7DgTwYORW7R6rN8JMG
         fTALNCgUo4igN6c5n+phOrs4iRE5+6b3yyJT79e8Zbp4vnvGh4q2EkFt0PLezazT6QAu
         /xEGZV40KpnM3GROAS6bUSZn21Y4Gd/futFdGQlFF3E98LLYEfO6WcrFaolDBkgXI1Jw
         nRow==
X-Forwarded-Encrypted: i=1; AJvYcCUnUv/gkDPJN0J4nCQUaWcCdID10Ad4OMefWjxs/LxgCOpdTt7thynp4r5k+M83hcJpAxg=@vger.kernel.org, AJvYcCXosZ1/gNxOUNvpt3PDOHR14zxBFeSwnepfnj7pXMjoUsBUjktcz38PnOjY6Co+9d1Lya8WkVY0@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/LzeZ+kqo0dVJAhFU5qGrcI3xZwNeF1nzWrY6kPMdXNp2TXd5
	PIfiB+jNLB7ZnATuuvCutjWF8t+4FPx6G3o8coEII0Crw/y1V7znBrYOyA==
X-Google-Smtp-Source: AGHT+IFdIUe113pQ9aBMOx/Kec2tqsyE4hd//z7X6rppgZT+x1Cc7dpwlCSlJ6Hm7EO+IR6epmXO6Q==
X-Received: by 2002:a05:6402:d0d:b0:5c2:439d:90d4 with SMTP id 4fb4d7f45d1cf-5cf0a45f22bmr1352065a12.30.1731054936670;
        Fri, 08 Nov 2024 00:35:36 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf03c4ecd5sm1724334a12.59.2024.11.08.00.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 00:35:36 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 8 Nov 2024 09:35:34 +0100
To: Omar Sandoval <osandov@osandov.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Greg KH <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org, bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: Fix build ID parsing logic in stable trees
Message-ID: <Zy3NVkewYPO9ZSDx@krava>
References: <20241104175256.2327164-1-jolsa@kernel.org>
 <2024110536-agonizing-campus-21f0@gregkh>
 <ZyniGMz5QLhGVWSY@krava>
 <2024110636-rebound-chip-f389@gregkh>
 <ZytZrt31Y1N7-hXK@krava>
 <Zy0dNahbYlHISjkU@telecaster>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zy0dNahbYlHISjkU@telecaster>

On Thu, Nov 07, 2024 at 12:04:05PM -0800, Omar Sandoval wrote:
> On Wed, Nov 06, 2024 at 12:57:34PM +0100, Jiri Olsa wrote:
> > On Wed, Nov 06, 2024 at 07:12:05AM +0100, Greg KH wrote:
> > > On Tue, Nov 05, 2024 at 10:15:04AM +0100, Jiri Olsa wrote:
> > > > On Tue, Nov 05, 2024 at 07:54:48AM +0100, Greg KH wrote:
> > > > > On Mon, Nov 04, 2024 at 06:52:52PM +0100, Jiri Olsa wrote:
> > > > > > hi,
> > > > > > sending fix for buildid parsing that affects only stable trees
> > > > > > after merging upstream fix [1].
> > > > > > 
> > > > > > Upstream then factored out the whole buildid parsing code, so it
> > > > > > does not have the problem.
> > > > > 
> > > > > Why not just take those patches instead?
> > > > 
> > > > I guess we could, but I thought it's too big for stable
> > > > 
> > > > we'd need following 2 changes to fix the issue:
> > > >   de3ec364c3c3 lib/buildid: add single folio-based file reader abstraction
> > > >   60c845b4896b lib/buildid: take into account e_phoff when fetching program headers
> > > > 
> > > > and there's also few other follow ups:
> > > >   5ac9b4e935df lib/buildid: Handle memfd_secret() files in build_id_parse()
> > > >   cdbb44f9a74f lib/buildid: don't limit .note.gnu.build-id to the first page in ELF
> > > >   ad41251c290d lib/buildid: implement sleepable build_id_parse() API
> > > >   45b8fc309654 lib/buildid: rename build_id_parse() into build_id_parse_nofault()
> > > >   4e9d360c4cdf lib/buildid: remove single-page limit for PHDR search
> > > > 
> > > > which I guess are not strictly needed
> > > 
> > > Can you verify what exact ones are needed here?  We'll be glad to take
> > > them if you can verify that they work properly.
> > 
> > ok, will check
> 
> Hello,
> 
> I noticed that the BUILD-ID field in vmcoreinfo is broken on
> stable/longterm kernels and found this thread. Can we please get this
> fixed soon?
> 
> I tried cherry-picking the patches mentioned above ("lib/buildid: add
> single folio-based file reader abstraction" and "lib/buildid: take into
> account e_phoff when fetching program headers"), but they don't apply
> cleanly before 6.11, and they'd need to be reworked for 5.15, which was
> before folios were introduced. Jiri's minimal fix works for me and seems
> like a much safer option.

hi,
thanks for testing

I think for 6.11 we could go with backport of:
  de3ec364c3c3 lib/buildid: add single folio-based file reader abstraction
  60c845b4896b lib/buildid: take into account e_phoff when fetching program headers

and with the small fix for the rest

but I still need to figure out why also 60c845b4896b is needed
to fix the issue on 6.11.. hopefully today

jirka

> 
> Tested-by: Omar Sandoval <osandov@fb.com>
> 
> Thanks,
> Omar

