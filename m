Return-Path: <bpf+bounces-15740-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CDCF7F59DB
	for <lists+bpf@lfdr.de>; Thu, 23 Nov 2023 09:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D2C51C20CEA
	for <lists+bpf@lfdr.de>; Thu, 23 Nov 2023 08:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A0A1946D;
	Thu, 23 Nov 2023 08:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x2rkB6ud"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 756921BF
	for <bpf@vger.kernel.org>; Thu, 23 Nov 2023 00:15:50 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-6baaa9c0ba5so724969b3a.0
        for <bpf@vger.kernel.org>; Thu, 23 Nov 2023 00:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700727350; x=1701332150; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CrEIDOduhti6InSDnRypg+BVJxqG3xXbxgAmhP0hxmM=;
        b=x2rkB6udHXM79Gx1VkF6RrzD0tkl8Be5FgtE3leLVPPPHRlc3EdNlXYMpWS1WCQu15
         jpB9m/m1cj39LXqICa4WRPMBzhRmRC7MdKehkFEZ6SKY+Cr21d0Ohza5FhK8wi1FRGbk
         MwSle3fAAhUf8CUlZE5QA3qedYhd9XPLO7ebvQllVBP670LRNX2qrCXm94laDm3nVw+W
         SFnTAd/1AYN2Jr/Tr5yme7rKS6ARtt3VUC/3sNhFijq/dZomO18mOpRxQ/E+Th0vTpPH
         qJpY7AeLAVPnsYEJNmm3oh49t4jQj1w1hgwL4rT3aKTczffTP84nb03xP331TWGGfk/p
         ITbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700727350; x=1701332150;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CrEIDOduhti6InSDnRypg+BVJxqG3xXbxgAmhP0hxmM=;
        b=XiWvDul2QC9xCuJtCnnaBje1DF1B/L+hhASFpx4b7oH4NstuqHWkFBsHW5+YcSOGT5
         Cl+ARx3IoEX0m24bXns3RTwxoUZMC9LewCgFJQCtlIIOpyyJzNa1iL/QfPfQSla1yKL0
         R8jCqrUUu+O2m3CE3WdAxPOu1wVQdNFfTEQvH48J1YqIm4IiITobee/fa2L8EgMkdsQE
         AeXPluZKQe/BND/u3eEdACOxg1zxObF3vO5euztwxO2gtDr4zdtaihqgwksngvUBA/Qi
         NR6CK7pdM2EhYDA/4zHIz6iVdJDke6xlOdwSkTT9ru1Gwm0PAq1bf0owWcqTyiP+oUMt
         xrVQ==
X-Gm-Message-State: AOJu0Yy21aJa8s5+O1oZ0K9HhnQ0883rZrJW5tUF7T+/2OmnDSRNO2im
	I+MqtMtxLKCsUhUBlIUNip6YOKm6AxO3Xw==
X-Google-Smtp-Source: AGHT+IH9adT6B0i1q+P6CsoaxvjLgFLnosKLJplk4qIgLHNWoRCdaiFD4O87oq0Kh4mkVoq1iaj+K6sacIpqzQ==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a05:6a00:1da3:b0:6c4:ec00:2941 with SMTP
 id z35-20020a056a001da300b006c4ec002941mr1201225pfw.4.1700727349918; Thu, 23
 Nov 2023 00:15:49 -0800 (PST)
Date: Thu, 23 Nov 2023 08:15:47 +0000
In-Reply-To: <20231123080334.5owfpg7zl4nzeh4t@CAB-WSD-L081021>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231122100156.6568-1-ddrokosov@salutedevices.com>
 <20231122100156.6568-2-ddrokosov@salutedevices.com> <20231123072126.jpukmc6rqmzckdw2@google.com>
 <20231123080334.5owfpg7zl4nzeh4t@CAB-WSD-L081021>
Message-ID: <20231123081547.7fbxd4ts3qohrioq@google.com>
Subject: Re: [PATCH v2 1/2] mm: memcg: print out cgroup name in the memcg tracepoints
From: Shakeel Butt <shakeelb@google.com>
To: Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc: rostedt@goodmis.org, mhiramat@kernel.org, hannes@cmpxchg.org, 
	mhocko@kernel.org, roman.gushchin@linux.dev, muchun.song@linux.dev, 
	akpm@linux-foundation.org, kernel@sberdevices.ru, rockosov@gmail.com, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Nov 23, 2023 at 11:03:34AM +0300, Dmitry Rokosov wrote:
[...]
> > > +		cgroup_name(memcg->css.cgroup,
> > > +			__entry->name,
> > > +			sizeof(__entry->name));
> > 
> > Any reason not to use cgroup_ino? cgroup_name may conflict and be
> > ambiguous.
> 
> I actually didn't consider it, as the cgroup name serves as a clear tag
> for filtering the appropriate cgroup in the entire trace file. However,
> you are correct that there might be conflicts with cgroup names.
> Therefore, it might be better to display both tags: ino and name. What
> do you think on this?
> 

I can see putting cgroup name can avoid pre or post processing, so
putting both are fine. Though keep in mind that cgroup_name acquires a
lock which may impact the applications running on the system.

