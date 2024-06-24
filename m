Return-Path: <bpf+bounces-32932-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F670915694
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 20:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82E001C2125E
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 18:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FEE81A00F7;
	Mon, 24 Jun 2024 18:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ph7OOlWi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9ED1E4AE;
	Mon, 24 Jun 2024 18:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719254496; cv=none; b=mBSLIIhrFheWk9jfp9zMLHd+VAdy6OiFHCSz5VHA/xJUQfx+fXK/wk12Ifacni3Te4R+FBmA4XGG7LAfEK7z2/zgsZYSuuuXKARFx6tSweazPOUAakDF1jgrwfEImqlClCfZhmZElMpmOeXS+foRthMcku/eA0VuLYZTOMGW2EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719254496; c=relaxed/simple;
	bh=AEymIACj9acXLypRztPM/3ziXQiHuyEEdFekiJgFUnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kb9GFLKYbHUKYTzbNIXOk6A+sBbUCiuzvm+baD62+6Kb6parW+dZ/6zDR+NNdnfG4izd1+Zucv1ExFzqHxV9fpb2UvSz6FsNS7eA9RM+50youHh9SSOSoTHHKVXLwn3ajrNOaK9cQEVXMvqHMRTZhYce5u70bao1UW0bxF9MzUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ph7OOlWi; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1f9b364faddso37915175ad.3;
        Mon, 24 Jun 2024 11:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719254494; x=1719859294; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QhZ81C/8tpw4iH8irCIrIcQkzUSzJK7fYT6KA3XkY3I=;
        b=Ph7OOlWiYfvpB9HzucA5YIRBX8F+NwKqVSbJSHeIHAZ8kY2a4IlzEYXjRysE6C1BJ2
         jZ3FTAjTyc9rE+PPpl8kP6nWKoFJKnYo19SzGapNwst31jF7NjfgyV13plawxWN57CSt
         PjMkk1JWcuuYgW0NMVT2vD5TaGT+HEz8F/xRqY8qeiq0H6JMfa1vMo+V1PQ9bOzUE2nw
         bZDyFY55YFTAg+ZA47DOXHseYEaOuW9cgrtG5DXZ0yJalOoC5qhQ/7cnu3Jqu/+utvtT
         NOC66bC1CmlA2LvstEhQnmGSqjXtoar5rvGlGmAuKudwkZ8y4HhqxVJJsKM5VcWXxi7A
         v85Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719254494; x=1719859294;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QhZ81C/8tpw4iH8irCIrIcQkzUSzJK7fYT6KA3XkY3I=;
        b=bjZsl6D9aGRLFYA20Q84GNWSOsAxvsfs1EAe+CWGhRieZqBnCzkWDmzaRBaLKgq/kV
         BJSsilIdFiaAXg/W2ZcUcKFNxaa28D6izyL4Ouk8Vb0Vzy1Np7b5Il55WK4VBMEbI22d
         NyFDbvmiXvuJfy+4SCEJB/gHZQenfhqyf5+wXABBV/XSQ0r8XNEldl47HUBGm7zFUGjE
         ut3zmq0AIWgf9lKblAoBahQzu0arkjawNoARg/VXYdkh+lVPfgz0qrIq2383wDtLcfN/
         T0moKqcFDH7ot1PS9Id0pE/K+b4Hus9t/1vf5weMYLSvQ5vBMAN9qVTa3hg7N1MxlGzC
         xMpg==
X-Forwarded-Encrypted: i=1; AJvYcCWcD6B50m3YqmogNGobywGF4wzpGcfzvYsvFnWUgcJaZG29uRy6/uyEGkhKRtl//MIZxWukOzBVgx35YaXQiUvuTrfyHFlMXZQdMlN4BAIEUgT8rZsYfp5Y9J1PuzYPNLrO
X-Gm-Message-State: AOJu0Yx6RDW/vPg5yFXSlPqRy6ENL1U2PB6qWAmTUoAlermlK5HUvTmB
	ybrektZddYyReoCvhqdhsisKTbsOkqwMi+qGJiuDTgt+RosQKDFE
X-Google-Smtp-Source: AGHT+IHwDb7OfmdnB6WV41jjpLoadn0eOZuEF1l7dGFQ+jEFir7EFuJdONcztpz/6d1eLQ8oL7qIYA==
X-Received: by 2002:a17:902:ccce:b0:1fa:12b4:587c with SMTP id d9443c01a7336-1fa240c50c4mr61742885ad.56.1719254493982;
        Mon, 24 Jun 2024 11:41:33 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb7d244fsm66055045ad.234.2024.06.24.11.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 11:41:33 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 24 Jun 2024 08:41:32 -1000
From: Tejun Heo <tj@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@kernel.org, joshdon@google.com, brho@google.com,
	pjt@google.com, derkling@google.com, haoluo@google.com,
	dvernet@meta.com, dschatzberg@meta.com, dskarlat@cs.cmu.edu,
	riel@surriel.com, changwoo@igalia.com, himadrics@inria.fr,
	memxor@gmail.com, andrea.righi@canonical.com,
	joel@joelfernandes.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH sched_ext/for-6.11] sched, sched_ext: Replace
 scx_next_task_picked() with sched_class->switch_class()
Message-ID: <Znm93GMnCiAkcCIq@slm.duckdns.org>
References: <87bk3wpnzv.ffs@tglx>
 <CAHk-=wiKgKpNA6Dv7zoLHATweM-nEYWeXeFdS03wUQ8-V4wFxg@mail.gmail.com>
 <878qz0pcir.ffs@tglx>
 <CAHk-=wg88k=EsHyGrX9dKt10KxSygzcEGdKRYRTx9xtA_y=rqQ@mail.gmail.com>
 <CAHk-=wgjbNLRtOvcmeEUtBQyJtYYAtvRTROBy9GHeF1Quszfgg@mail.gmail.com>
 <ZnRptXC-ONl-PAyX@slm.duckdns.org>
 <ZnSp5mVp3uhYganb@slm.duckdns.org>
 <CAHk-=wjFPLqo7AXu8maAGEGnOy6reUg-F4zzFhVB0Kyu22h7pw@mail.gmail.com>
 <ZnXYsHw1gOZ4jlp2@slm.duckdns.org>
 <20240624090431.GG31592@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624090431.GG31592@noisy.programming.kicks-ass.net>

Hello, Peter.

On Mon, Jun 24, 2024 at 11:04:31AM +0200, Peter Zijlstra wrote:
> > I'll update the patch description to point to the previous message just in
> > case and apply it to sched_ext/for-6.11.
> 
> Can you please back merge and keep it a sane series? I'm going to have
> to review it (even though I still very strongly disagree with the whole
> thing) and there really is nothing worse than a series that introduces
> things only to remove/change them again later.

I started the sched_ext/for-6.11 branch last week with the v7 patchset:

  http://lkml.kernel.org/r/20240618212056.2833381-1-tj@kernel.org

and would much prefer to just run it as a normal branch. No matter what form
the patchset gets applied in, we'll have constant flow of changes, fixes,
reverts and improvements no matter what, so I'd much prefer to avoid another
round of reshuffling and reposting.

Thanks.

-- 
tejun

