Return-Path: <bpf+bounces-38699-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 663B89682DE
	for <lists+bpf@lfdr.de>; Mon,  2 Sep 2024 11:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24890283B42
	for <lists+bpf@lfdr.de>; Mon,  2 Sep 2024 09:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B96187349;
	Mon,  2 Sep 2024 09:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="khrcyasl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D63C186E5D;
	Mon,  2 Sep 2024 09:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725268487; cv=none; b=l53EWRywxju9nCCU/hqws/hai9C22n9jRYEL1IWnPtDddKEeTn5fHnvkyxsARlffcwa/xx2sIOuzbSlU/gDYbQvoBCQbouezS/HjcqixemlKnBTrrIzYm9+zkK4y4LkfD9cowyLUVB1TF4kolHJHNkxrzJwna0VHqDUGAsSgivM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725268487; c=relaxed/simple;
	bh=nVz6OHwyQjfOoL4dw7thO5BADMzA8OnQ8aX7rEev/bc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pcok84PsJudn2wyGA67YiDtR6IAwMt88TZU14U7+s7qavbR6Yz7EkCAR7swWmLe0rEjVKLKcX8FPCw5iY8pS7vGqzLOxVGXOCR10Gxjv1SRiTRWQE5hASmbTYZ3YKcPO7q3FPLeh+A5htAow9l7VBq98WGazWwLC12+aHis5pUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=khrcyasl; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2f40a1a2c1aso36880991fa.3;
        Mon, 02 Sep 2024 02:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725268484; x=1725873284; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UodyzbJSkk+eMFXI+6sMbq8FsUp3GNOPoUxWd/Q/ST0=;
        b=khrcyaslgBJUdeG0VvGhRmgF533OS8UpPE9V8kti79dfhkNAv76zFlcUagTs58QIOc
         j2sLJI2jJ/vRCJcKt+7ZJbSXxHyMpF1Tt2E8spIHMeqq5Nzlak6ncEN6LAJ7LcQe2HEh
         rFb9juZSd2hl+UG/vrsKqndSmduI/BfNpgveRmbI6UaMjSgR8PO+pzMGS5vfKbSMHMry
         j5omEUXFh7VKls0gUdw+KjTR0MHScLweT5Fo6SIOFO5bwo48al01prqb84d+W1ZiyU8S
         gnr1SdiUTgT2ak/X1vxTuO61Zhezi6Zk27AdrzeXo+AXxDqivNLY6LRsszP44KBS11r2
         oBhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725268484; x=1725873284;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UodyzbJSkk+eMFXI+6sMbq8FsUp3GNOPoUxWd/Q/ST0=;
        b=fAALBtiszYXCW3+dWPJW4MazcwJ2a7Oau2dT9zTt9hnXbI1N/wxybMs7CpfoMp3Mn4
         LTi6KsNKY1fbYNwV+FacUEXTZCPEGR1ffhoYMvOckqoJlS37ptzdwZS+T6CAS81Q9sum
         3oeyQsoSJDntG1w8xjWnCFkpo6HKPtbJ+7puCe/L6Gw0xmYkjSl+qubm0NXfgxzzlJoP
         XRvgjkGIJgBjMdxERwt3E3BOJmEIIE45JElltU0kcB9y7n0Ds1TOzBUzvHqOwDx0YtL1
         abQ9RTbA2aLrm9vcC/VnZXDbtkpaZOOjstu3Ag0/8q0dLWpo8OWdTI857KdM95v0S2j0
         FiPw==
X-Forwarded-Encrypted: i=1; AJvYcCUZyoju5zUq3Ax/mABgp/YJP0OV8zPyoKloBgU1RKt7WsimrtT1PlrRDlUIYnpXx8s0AQQ8UN3kPMy8ej/L3wMIEYAr@vger.kernel.org, AJvYcCV358DyNDHAvBVi2Qnp67oeggNeHUY1sND91jcD2GnL9KZ7fGfTR46D3cZGub4lB42+b6M=@vger.kernel.org, AJvYcCXeqn8NypDqXTWxsLoJEmmEUAdse2DrDwnh5ZPyREnJNpnE1yVnAtR8LUb5ippvojaHpZolq6JdQboC995i@vger.kernel.org
X-Gm-Message-State: AOJu0YyV692Fb/jiIWxR/yQ+XL862UWwbnnnpXaRI8J5etk98Y1NP1zg
	tV8YWrnBt4KQ3jaVaFjLr3b9/NwCSXHNabZ7UqsNLjGhrtWmvD0w1GIoiJHST9g=
X-Google-Smtp-Source: AGHT+IHHzCk0o+jT01bGivLrYPPEh1XQtuTW35W/Wg/8G3+LkmILao43mPxxrvxmkMCVfvz99UQ4pA==
X-Received: by 2002:a05:6512:b20:b0:52e:9d60:7b4c with SMTP id 2adb3069b0e04-53546bbea37mr5568298e87.61.1725268483169;
        Mon, 02 Sep 2024 02:14:43 -0700 (PDT)
Received: from krava ([87.202.122.118])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6e33e2asm131076895e9.45.2024.09.02.02.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 02:14:42 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 2 Sep 2024 12:14:40 +0300
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jiri Olsa <olsajiri@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
	linux-trace-kernel@vger.kernel.org, peterz@infradead.org,
	rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, paulmck@kernel.org,
	willy@infradead.org, surenb@google.com, akpm@linux-foundation.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v4 4/8] uprobes: travers uprobe's consumer list
 locklessly under SRCU protection
Message-ID: <ZtWCAN_F1DkFAFNp@krava>
References: <20240829183741.3331213-1-andrii@kernel.org>
 <20240829183741.3331213-5-andrii@kernel.org>
 <ZtD_x9zxLjyhS37Z@krava>
 <CAEf4Bzb3mCWK5St51bRDnQ1b-aTj=2w6bi6MkZydW48s=R+CCA@mail.gmail.com>
 <ZtHM_C1NmDSKL0pi@krava>
 <20240830143151.GC20163@redhat.com>
 <CAEf4BzbOjB9Str9-ea6pa46sRDdHJF5mb0rj1dyJquvBT-9vnw@mail.gmail.com>
 <20240830202050.GA7440@redhat.com>
 <CAEf4BzZCrchQCOPv9ToUy8coS4q6LjoLUB_c6E6cvPPquR035Q@mail.gmail.com>
 <20240831161914.GA9683@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240831161914.GA9683@redhat.com>

On Sat, Aug 31, 2024 at 06:19:15PM +0200, Oleg Nesterov wrote:
> On 08/30, Andrii Nakryiko wrote:
> >
> > On Fri, Aug 30, 2024 at 1:21 PM Oleg Nesterov <oleg@redhat.com> wrote:
> > >
> > > I'll probably write another email (too late for me today), but I agree
> > > that "avoid register_rwsem in handler_chain" is obviously a good goal,
> > > lets discuss the possible cleanups or even fixlets later, when this
> > > series is already applied.
> > >
> >
> > Sounds good. It seems like I'll need another revision due to missing
> > include, so if there is any reasonably straightforward clean up we
> > should do, I can just incorporate that into my series.
> 
> I was thinking about another seq counter incremented in register(), so
> that handler_chain() can detect the race with uprobe_register() and skip
> unapply_uprobe() in this case. This is what Peter did in one of his series.
> Still changes the current behaviour, but not too much.
> 
> But see below,
> 
> > I still think it's fine, tbh.
> 
> and perhaps you are right,
> 
> > Which uprobe user violates this contract
> > in the kernel?
> 
> The only in-kernel user of UPROBE_HANDLER_REMOVE is perf, and it is fine.
> 
> But there are out-of-tree users, say systemtap, I have no idea if this
> change can affect them.
> 
> And in general, this change makes the API less "flexible".
> 
> But once again, I agree that it would be better to apply your series first,
> then add the fixes in (unlikely) case it breaks something.

FWIW I (strongly) agree with merging this change and fixing the rest as follow up

thanks,
jirka

> 
> But. Since you are going to send another version, may I ask you to add a
> note into the changelog to explain that this patch assumes (and enforces)
> the rule about handler/filter consistency?
> 
> Oleg.
> 

