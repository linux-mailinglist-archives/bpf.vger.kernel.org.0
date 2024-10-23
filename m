Return-Path: <bpf+bounces-42873-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27CE79AC165
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 10:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D1CF1F21EA7
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 08:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA61487BE;
	Wed, 23 Oct 2024 08:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UCjsnGoV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F6C146018;
	Wed, 23 Oct 2024 08:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729671584; cv=none; b=GnBsILpL//dQzwG6+pGZEu5ksESjAXesndPizKOAG1JLbE3IHILfac98zAN8RQenArjFgSp87hSTeFdvz9PKBPvcYTrZJ3cXBQkC2YDUzyIeALMA1h03TULrg08nO13zFd8HT0BASDfYYWkNwKCwglOQITsAFRjoxEzZGBrhgvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729671584; c=relaxed/simple;
	bh=sKnGqfdi/X1bpd3CmPQy4hod8cSQLJ3eOZVZwk0+ZQE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cshijN8SgpycHqqSrDygCj9osKJCoelmwKCjYqWjpPGsChCngJ23QCQ0loqe3/QGNOowFVVR1tCEI792AcqHUkrLIk7vVhZ87Rfu//yy9FV5H6y3wZ2UCRU18iC4H0INFsIfjZJyjgeZ9s8fw+yJ/PN7ygQfNzXMeWuCgssjoxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UCjsnGoV; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c96936065dso6854055a12.3;
        Wed, 23 Oct 2024 01:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729671581; x=1730276381; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hHwWvR1xcXKAIgnKGQ+F36y6LrNpA+v1vplrWLR/SUA=;
        b=UCjsnGoVWqP6R07yqU34M07GPJXhQmqW+wbSrAVQ+XUofcF6aeGnoLr5kFyxaGHLdN
         TvybwRo5mahtfRAHCtpwiqweAzzBV7M6BFyGS+o/yjogPxB2XAkV/38YZh2I8oc7T3sB
         /KQAifYGx3l2XTZLKhdLLA+jiG/959DqLLISdQRJZefXQ8yHe9JriVpjfPCILiu8E+r+
         MxkssrMeMVjdW1i9F8a9c445rtcBxbabtNEp42wXDPAclRDe7zQqkJxwZxEy82/MgbAz
         aNejaLjKNAU1hpUBL1I3oU/2ZLmeZiPI1fmn0y5NX5J7FizffZWGruf/eYcipQHHZMy/
         Y6AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729671581; x=1730276381;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hHwWvR1xcXKAIgnKGQ+F36y6LrNpA+v1vplrWLR/SUA=;
        b=T5t2JO8K8kyO9oHRumEgGak1zvQfUGluK8vNZptfNSlxkTmZqaBzn3lsS+YLgQBgSo
         kdmUQcmR4Hl0+Btkjjxd004WXZD4HlTSjs9e940omThEEM1e+df2VWCpt3ByIeTzWU38
         R4sKhFOeCYXVv5TedJp6A+au5Km3sjLf19RCTkvRTIKrZURph6fmQV8D6apFXtl/KsFb
         sWjTyMc/W15QNbDUZFjyMPOmltxoEq3aoUIV9M2FX0/MD8H4/sc/LFBo5PynVtAqSnHA
         9fW622JJtphwELRrNVcVPB9uv3BlOqorR/aqfslr1QxJBNTTkelA6FueVf41W5TEoda9
         c6cA==
X-Forwarded-Encrypted: i=1; AJvYcCW2gCqFojEYuPVO9uaHgXSMRYMk5rUmy96vcrbkzNTLpwJQPNZwcHQJMvtsTi4Drt3+3p8=@vger.kernel.org, AJvYcCWnQxpU/eU18ttwSTkzo/dK5v6SjoGuy3mWK0gVKMDzp9VAGP7+huMb3lRWxP+gkDup/1mdJx+1Tq61OFj0@vger.kernel.org
X-Gm-Message-State: AOJu0YwAls5BeI80wYPpo2zoWpljI9GWy3L7EisCQv3DYhbP21VPNx6r
	BaX5W7p4mmOSMIbKng5Q/GOmNEGKaoi8gCrTQXgIU/Rl3XMGVTMH
X-Google-Smtp-Source: AGHT+IEcv6upnpzJoycpTtgD/ihtVGV/+R9UvjxE11dUmBktLECMtGIjIbNxSbIasJgWiVhCWcgjFg==
X-Received: by 2002:a05:6402:51c8:b0:5c2:439d:90d4 with SMTP id 4fb4d7f45d1cf-5cb8b1a1084mr1357715a12.30.1729671581173;
        Wed, 23 Oct 2024 01:19:41 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cb66c7262bsm4054501a12.82.2024.10.23.01.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 01:19:40 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 23 Oct 2024 10:19:38 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
	andrii@kernel.org, yhs@fb.com, linux-kernel@vger.kernel.org,
	daniel@iogearbox.net, sean@mess.org, bpf <bpf@vger.kernel.org>
Subject: Re: perf_event_detach_bpf_prog() broken?
Message-ID: <ZxixmhdyhGSt1_Jx@krava>
References: <20241022111638.GC16066@noisy.programming.kicks-ass.net>
 <ZxewvPQX7bq40PK3@krava>
 <CAEf4Bzbp-LxpFR5Ue6YTfana5ST+sHMLi_zxS9Ax3uR7bXpuNA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bzbp-LxpFR5Ue6YTfana5ST+sHMLi_zxS9Ax3uR7bXpuNA@mail.gmail.com>

On Tue, Oct 22, 2024 at 10:33:37AM -0700, Andrii Nakryiko wrote:
> + bpf ML
> 
> On Tue, Oct 22, 2024 at 7:03 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Tue, Oct 22, 2024 at 01:16:38PM +0200, Peter Zijlstra wrote:
> > > Hi guys,
> > >
> > > Per commit 170a7e3ea070 ("bpf: bpf_prog_array_copy() should return
> > > -ENOENT if exclude_prog not found") perf_event_detach_bpf_prog() can now
> > > return without doing bpf_prog_put() and leaving event->prog set.
> > >
> > > This is very 'unexpected' behaviour.
> > >
> > > I'm not sure what's sane from the BPF side of things here, but leaving
> > > event->prog set is really rather unexpected.
> > >
> > > Help?
> >
> > IIUC the ENOENT should never happen in perf event context, so not
> 
> yep, if it does return an error it's a bug, right? So we can add
> WARN_ONCE() or just drop the check, probably.

I'm now more inclined to have the WARN there, because it's possible
return value of bpf_prog_array_copy .. I'll send the patch and let's
discuss over the change

jirka

> 
> > sure why we have that check.. also does not seem to be used from
> > lirc code, Sean?
> >
> > perf_event_detach_bpf_prog is called when the event is being freed
> > so I think we should always put and clear the event->prog
> >
> > jirka

