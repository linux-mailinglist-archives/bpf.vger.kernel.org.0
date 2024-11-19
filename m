Return-Path: <bpf+bounces-45192-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3DD9D2982
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 16:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A40152830B1
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 15:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5C81CF2A6;
	Tue, 19 Nov 2024 15:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HzK2ILIy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFFA1CEAB8;
	Tue, 19 Nov 2024 15:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732029784; cv=none; b=UBM3AcoIeGcsw336GHJJQ0vxsilYiSA6RuyZ95xkMJiLX+CKi5vIuQutVk8JQ5+/HsucfS0IdJJ0eI/uUUXjEv23pr1dMddXAHsLQcP3dFLcbWp6Gr9uPcAVJHCDZ1iNrT01ns/C7f/XdoUt7UcP8ylS2732u9n5q9qiAqTHX/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732029784; c=relaxed/simple;
	bh=5u9IOamW6ThE9+oNsHjhT6A1o1r9h/A0pmniqNKUgiI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GnvaAcH5Ysc+hGVpLXX3f1cBzE8XkW2Nn4CTq/U8aObmSTR0gLNTDCxOHRqtjmO8KXPHtgvNSp1dhbKdCTs359rjCTfkP5CnTAgyKMfxyy5bcSqIRsUd8NDTUru+CguPlPyGkHh5Pa4sN7GxZ98SOqSHRoXc/++vTjnzbz+eYSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HzK2ILIy; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4314fa33a35so47081775e9.1;
        Tue, 19 Nov 2024 07:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732029781; x=1732634581; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4DR5BsjCRl1rkPCWbfou0D00YBGACEs7JX1z1Y/fK5Y=;
        b=HzK2ILIy6z32wVI2Kz41TCzl7i+6sYmg3I/uvy2IKf7oI4co+qGU0PmyXUm+3pE5va
         /EVjdcMMYosMl2ohQOD7UkxX5b0A2+dM8bdKM03U38vcV37o3qq2zyO+4vKOxjDVBOL8
         mTJPj18pHXdvlExqL2D63HIcfRM19vt5rvlRXb28cneRxUrmrulDdSOILxVwOWFlodIE
         yZBQuw1ZyTZNnVORymc+V5gF+BPlMPE//NsiBFaFcfP4B7F7rXJhDNmbgPs11WabYQdb
         TTDpetzUgFM3//B+qLY3lTj9nIdIq/iVZOca3/8850xcoZYA0utOt9LfPhbz9UP6pTBZ
         HMuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732029781; x=1732634581;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4DR5BsjCRl1rkPCWbfou0D00YBGACEs7JX1z1Y/fK5Y=;
        b=Iube6tBxPa8mqsx7EWkPjyqXcG4Y29EuI+Y9wJAOBdeAjfrMO98fMClCPg+uKBr3T5
         uSdZa0gaa6XZnMgJTQw0JjsnZX5+cVCxKwKqtqqy7Ab6eMhAlDjxyqKsVS2/UFARiyJ2
         IC0YNQwlzs1sTWW/dLewN1RsIQ9pfCEorhsHBSb9mK5inv4oL+X1iA6YLVB850WCzrxQ
         383mudM+YkV8T8klx7q/sCAtmn8IVIYYAYP4iHW9ImzU4FItBXdSF4wXezVt9zwfyOsb
         PJTvMQR/NxVWhswPiquAMtwsQrhhsE41c1xbk/eea8Gfm2Ncu+g2pgVKT5/G66N4DUNR
         kXhA==
X-Forwarded-Encrypted: i=1; AJvYcCUiXZKdvBk58Ft6o3DNaUX9Utmav4KMb88XPNSnr7XS1906efd1fqOcPdSg68YQBizAqPZoc1ji@vger.kernel.org, AJvYcCVx16XABJwV7XWBVoDYKuc1XbOPAtpnbV+sv9ipjxN19pILZwsoSiV3rPGNj7yEJUr09qE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOWF8PdtJbFa3aq9Rt85IvVlm3xBbQp1S1sELyOqLErrpU7365
	oSi/tMVYyFKMGSfXsBaaDkV3ZDDcJVBOb+b0q/aCHM1PcvubHRf2
X-Google-Smtp-Source: AGHT+IE215p1cfBnYIitD+B1fAUaDKTRHNGSjEbICNKHauWOyVHxwOfRESqgE/oA9BawlC/YjrjSIg==
X-Received: by 2002:a05:600c:3b2a:b0:431:6060:8b22 with SMTP id 5b1f17b1804b1-432df72c076mr163048685e9.10.1732029780937;
        Tue, 19 Nov 2024 07:23:00 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dab7206csm194647105e9.7.2024.11.19.07.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 07:23:00 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 19 Nov 2024 16:22:58 +0100
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Omar Sandoval <osandov@osandov.com>, stable@vger.kernel.org,
	Jiri Olsa <olsajiri@gmail.com>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: Fix build ID parsing logic in stable trees
Message-ID: <ZzytUhGqbCMZtS7T@krava>
References: <ZyniGMz5QLhGVWSY@krava>
 <2024110636-rebound-chip-f389@gregkh>
 <ZytZrt31Y1N7-hXK@krava>
 <Zy0dNahbYlHISjkU@telecaster>
 <Zy3NVkewYPO9ZSDx@krava>
 <Zy6eJdwR3LWOlrQg@krava>
 <CAEf4Bza3PFp53nkBxupn1Z6jYw-FyXJcZp7kJh8aeGhe1cc6CA@mail.gmail.com>
 <ZzUWRyDmndTpZU3Y@krava>
 <ZzeQrYy-6I3NK4gX@telecaster>
 <2024111955-excursion-diaper-2675@gregkh>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024111955-excursion-diaper-2675@gregkh>

On Tue, Nov 19, 2024 at 12:58:21PM +0100, Greg KH wrote:

SNIP

> > > > >
> > > > > ok, so the fix the issue in 6.11 with upstream backports we'd need both:
> > > > >
> > > > >   1) de3ec364c3c3 lib/buildid: add single folio-based file reader abstraction
> > > > >   2) 60c845b4896b lib/buildid: take into account e_phoff when fetching program headers
> > > > >
> > > > > 2) is needed because 1) seems to omit ehdr->e_phoff addition (patch below)
> > > > > which is added back in 2)
> > > > >
> > > > > IMO 6.11 is close to upstream and by taking above upstream fixes it will be
> > > > > easier to backport other possible fixes in the future, for other trees I'd
> > > > > take the original one line fix I posted
> > > > 
> > > > I still maintain that very minimal is the way to go instead of risking
> > > > bringing new potential regressions by partially backporting folio
> > > > rework patchset.
> > > > 
> > > > Jiri, there is no point in risking this, best to fix this quickly and
> > > > minimally. If we ever need to backport further fixes, *then* we can
> > > > think about folio-based implementation backport.
> > > 
> > > ok, make sense, the original plan works for me as well
> > > 
> > > jirka
> > 
> > Greg, could you please queue up Jiri's one line fixes for 5.15, 6.1,
> > 6.6, and 6.11?
> 
> Ok, will do, but hopefully you all will help out if there's any problems
> with the change going forward...

no worries, will help with that

thanks,
jirka

