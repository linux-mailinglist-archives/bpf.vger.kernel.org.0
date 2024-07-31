Return-Path: <bpf+bounces-36168-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F43E943750
	for <lists+bpf@lfdr.de>; Wed, 31 Jul 2024 22:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFC86283DF6
	for <lists+bpf@lfdr.de>; Wed, 31 Jul 2024 20:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD0116A382;
	Wed, 31 Jul 2024 20:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eBVd7sFv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238D03F9C5
	for <bpf@vger.kernel.org>; Wed, 31 Jul 2024 20:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722458696; cv=none; b=e6x/nJ2ERO4iJ/N2mxUsrXZUJY7zZAmk2e58ADlC1ZWf8NeQ5s/U7VGE572mtijNSuB+SliRxo+OPTAZ1u3M0bQSrs3ODYPGUeOxyLVze3VUnQxiZh6h8sM1tixBpAxt7tvvYghOekoyW0yYVAjFIwxWNxKGqrdVmRGhCIsgBEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722458696; c=relaxed/simple;
	bh=93gIujm5oOGpSphEXLXF2kioqHMZ+itqJZXH21GcHH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sRUOVE3OyCKlMMqR6uBpj2mlHfltJcT7ZqGlYHBZnr4SvhyH3wR3qsTGnQ5tCuGn2Y8GQsq/eTuhuiCE3kO3JOC3FKLwQP8StyO+MDx5sQiReXHM/NlQZQ55K4aLacdeMNR75BQHSL7st6AnbGDUJ2hLtD2yfwSeSh3BTVONW9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eBVd7sFv; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-70d19c525b5so4368553b3a.2
        for <bpf@vger.kernel.org>; Wed, 31 Jul 2024 13:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722458694; x=1723063494; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g8nVADXV85rjWROpQmG7Vv3lmkiRexVahOsKQHN4CrQ=;
        b=eBVd7sFvMy1OueNmXKkabGhn5sSNkoe9HHzqylkDE9BiSLLGl07C/G4OjQ68P7JOph
         5CFjhQkCs2PjOg76TV6QDB4KKO7EmgU15QJ/RWZ8ncgRFVpCy7DzLUMQ3DyZ28OSWgAq
         vNS+3FbIdVHKr/DfxuRIM3QUl6qSgqgNVg4EeIDbxo9MCGu/kvS2INB3YOjHOusRS3Q0
         /JVF7djLplqG3duO0lHvfuW5d6K1NHNMUf1PpxQMOaFYTyi0S8DoAYoQrPjmDk5qGvON
         UH7ZCFnS/W8IcNfy/oxr1dgoYDAz/6Rx2lUWpsI3e9bjjjIS+R+5IHKE4ZT1rriD5Avo
         EM8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722458694; x=1723063494;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g8nVADXV85rjWROpQmG7Vv3lmkiRexVahOsKQHN4CrQ=;
        b=tvRG6aelWyrFG1NcyUi0ZE0/TZ/kae7g0yE3ukQY77CEbQuowxTiKSY8kAg5y956ke
         aYfoNl25b31Jzwyx5HWveR7dg6dFw1kgo+hPWs/J8nQeaUponUYsLEADJ/3P95lbHPGF
         GECXXUXxcePbiSpE1f+9dQtB+eSYWF6aS5+h+MaMOyOr+CLlGFIRfL2g7YYZxZgHJWJH
         tX+O3rYe4Z4E2hPMsWU+sNbicrxjFVS4yK3ABArxDo3pYlGbDZc9n1z81SDxVjJjcGA1
         VO7KAXElrRHDWBk+xk+plJWxpymUlIE91p6aFo/jBqbLTsGl1rlRkcnQjG53NHF93XPh
         XiUg==
X-Forwarded-Encrypted: i=1; AJvYcCXPF5d0KsUezztAdI/16K12IqrPbjFFjs5DPcW2dx9neSWDSqyuq6iS9HctoYeF0gZK26JC9SwtmM0+LBMctXcYab4G
X-Gm-Message-State: AOJu0YywdoDgBkmZ1Vry6uIRODv9mUjZ+LkkOSIqqlOlfai5E/Lxik3+
	0+r0AGAYQd1Qie9rMetHG460Ec8vIjfbFDu/YislvCgIyO9mEAR50r7yMH4W2g==
X-Google-Smtp-Source: AGHT+IHXTTTJBcvMbghNtaOeDsOA2+qCaWWN0qamvWbJx/CuxZ9e1gU5OseLlb/8F8Ez+0r8Ci8zVg==
X-Received: by 2002:a05:6a00:882:b0:70d:278e:4e92 with SMTP id d2e1a72fcca58-7105d6dcaa8mr530631b3a.12.1722458693871;
        Wed, 31 Jul 2024 13:44:53 -0700 (PDT)
Received: from google.com (132.111.125.34.bc.googleusercontent.com. [34.125.111.132])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead712691sm10344541b3a.49.2024.07.31.13.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 13:44:53 -0700 (PDT)
Date: Wed, 31 Jul 2024 20:44:49 +0000
From: Peilin Ye <yepeilin@google.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	"Jose E. Marchesi" <jemarch@gnu.org>, bpf <bpf@vger.kernel.org>,
	Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>,
	Neel Natu <neelnatu@google.com>,
	Benjamin Segall <bsegall@google.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	David Vernet <dvernet@meta.com>,
	Dave Marchevsky <davemarchevsky@meta.com>
Subject: Re: Supporting New Memory Barrier Types in BPF
Message-ID: <ZqqiQQWRnz7H93Hc@google.com>
References: <20240729183246.4110549-1-yepeilin@google.com>
 <CAADnVQJqGzH+iT9M8ajT62H9+kAw1RXAdB42G3pvcLKPVmy8tg@mail.gmail.com>
 <24b57380-c829-4033-a7b1-06a4ed413a49@linux.dev>
 <CAADnVQLLjPe3cnb7RSqHHVAP=4W1mbwTz1OFKq51=TR0utyaJQ@mail.gmail.com>
 <87c8159d-602b-470c-a46c-87f5fd853a23@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87c8159d-602b-470c-a46c-87f5fd853a23@linux.dev>

Hi Alexei, Yonghong,

On Tue, Jul 30, 2024 at 08:51:15PM -0700, Yonghong Song wrote:
> > > > This sounds like a compiler bug.
> > > > 
> > > > Yonghong, Jose,
> > > > do you know what compilers do for other backends?
> > > > Is it allowed to convert sycn_fetch_add into sync_add when fetch part is unused?
> > >
> > > This behavior is introduced by the following llvm commit:
> > > https://github.com/llvm/llvm-project/commit/286daafd65129228e08a1d07aa4ca74488615744
> > > 
> > > Specifically the following commit message:
> > > 
> > > =======
> > > Similar to xadd, atomic xadd, xor and xxor (atomic_<op>)
> > > instructions are added for atomic operations which do not
> > > have return values. LLVM will check the return value for
> > > __sync_fetch_and_{add,and,or,xor}.
> > > If the return value is used, instructions atomic_fetch_<op>
> > > will be used. Otherwise, atomic_<op> instructions will be used.
> >
> > So it's a bpf backend bug. Great. That's fixable.
> > Would have been much harder if this transformation was performed
> > by the middle end.
> > 
> > > ======
> > > 
> > > Basically, if no return value, __sync_fetch_and_add() will use
> > > xadd insn. The decision is made at that time to maintain backward compatibility.
> > > For one example, in bcc
> > >     https://github.com/iovisor/bcc/blob/master/src/cc/export/helpers.h#L1444
> > > we have
> > >     #define lock_xadd(ptr, val) ((void)__sync_fetch_and_add(ptr, val))
> > > 
> > > Should we use atomic_fetch_*() always regardless of whether the return
> > > val is used or not? Probably, it should still work. Not sure what gcc
> > > does for this case.
> >
> > Right. We did it for backward compat. Older llvm was
> > completely wrong to generate xadd for __sync_fetch_and_add.
> > That was my hack from 10 years ago when xadd was all we had.
> > So we fixed that old llvm bug, but introduced another with all
> > good intentions.
> > Since proper atomic insns were introduced 3 years ago we should
> > remove this backward compat feature/bug from llvm.
> > The only breakage is for kernels older than 5.12.
> > I think that's an acceptable risk.
> 
> Sounds good, I will remove the backward compat part in llvm20.

Thanks for confirming!  Would you mind if I fix it myself?  It may
affect some of the BPF code that we will be running on ARM, so we would
like to get it fixed sooner.  Also, I would love to gain some
experience in LLVM development!

Thanks,
Peilin Ye


