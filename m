Return-Path: <bpf+bounces-23095-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BB486D6E3
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 23:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C7FBB2157A
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 22:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D0D20317;
	Thu, 29 Feb 2024 22:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MOVffLEa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E6C3E485;
	Thu, 29 Feb 2024 22:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709246004; cv=none; b=DuwKROOzFx1GBzThtINLgq5vuVctccFI588PA4xo8Df0tKr4aN9a8YzlW8zIq7dnunfmn02M0PlfN82wRPPJJoDZN7odATGVyG3YP4Ui3yTK0v1Rcr3kE1bx75o7sXM4dxfQ+qIZby8dZssYFvGgYP47n3h0Ha6jZ6WK72mieLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709246004; c=relaxed/simple;
	bh=aqRda5K2hgiYA4mq43wQqPpn8pR+Zkux/QdlhvfokzU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=o29t+I6GVj3V6FXqfgw6TxJRSGXJHfdpQawJI7kpHHkPGjktk+L1+roSmWthLan5N3CApsTFyF0u1nlBxjwdX/uU7S2cGT6178C3xrBfqIURm4912DRrBSPQzNLonKZTCvl1srb899TK6Yc+EUVJBCoAqVKk1xc+xS6oHKSx7YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MOVffLEa; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6e47a9f4b70so797525a34.1;
        Thu, 29 Feb 2024 14:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709246002; x=1709850802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ztO4xdRuBU+sJMbAYpHYx8WfXjhkzyJSRid7I5kMfVE=;
        b=MOVffLEacBcWvoQaSxPaJ4TPPNXaAvcZ2ZL/Z1cM/UXgoHsmlNYsCMbpb4RP6UkHzx
         jAEdSo9ZJrUPolwCmHaVw3f1asv/jWn+JlN14sM6AUwFybc0QLA25QKm5cIqKjTksOHv
         DvQJ8TZmQhm4Y9ox0KLqOj/Bp6HEmleZAggGyzYqTxJ8w3+OY9VKQoXJuk6MRsg3YC84
         7jk/ak1cmT50BYgOwgVzXqZ043pFA1unGHC24p693QgNvaYfIH5B0maygax4co9U1r6c
         G5++gZ4mLWXAacTV0g246171cYJbSnOTAeYwdb63ePFBcBrZYA9NBo0KUp+9ZgppWfru
         6jpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709246002; x=1709850802;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ztO4xdRuBU+sJMbAYpHYx8WfXjhkzyJSRid7I5kMfVE=;
        b=B4mJEjge1+0524e2mFS57BevBNS6N/KhlNDtjwCzb7g9ok5U1uvYm1ZUK9P/caXi0Y
         QxFcysg8WXUNvp+3BP53V8vOUnh9JFfdna7a+ZA65eVw7+zv7XjQha0b4Yd0/Pqep13q
         HKVlRtrlGKb06C2/GrAdqgAhRKljeLpb7mgTwFW/eknnyg2GUrnCGiV5KxZoABZen1D2
         PTXb57awycsuJjPsUYNEbfeTf8LPpfPtQWWhMaWxUqK+2+EV+pYFWtOsih4kW+Tec14Z
         Z0+b2YbC7u/kV/YOvczGaiBAyMnFV7neuoltdnue7TRSCtP0cEc2ielfhnXDICUrL0Cd
         CbAg==
X-Forwarded-Encrypted: i=1; AJvYcCXuiYZgosQB8LWLVLdT/mUHXA6yT99hkLczogsFZ3P9rWBgGc0U2JHNRbq4I71/ydfIls/DBGElIuRhvUnaXT2tRMN3YfmEs5wIjTwGjunGirVIKgT+gf+SruWS
X-Gm-Message-State: AOJu0YwJDf4wN0tQ5pE6qaEBFPo16HWZ7I1mrdTQ+8KEGlOXc6FqH+Eo
	peJBsY9Mk2rfvDreDnISjGVNZKqlBSBmJX9f9Lb+Y8mmp4KlkhTP
X-Google-Smtp-Source: AGHT+IFuZs37NlSi2A217IwMOZ96r8sI2uo8PlZRHWFjzhGPEWUX5jvGb+8+IYz+/l/p9D9tdmNJag==
X-Received: by 2002:a9d:741a:0:b0:6e4:c149:e786 with SMTP id n26-20020a9d741a000000b006e4c149e786mr55853otk.2.1709246002392;
        Thu, 29 Feb 2024 14:33:22 -0800 (PST)
Received: from localhost ([98.97.43.160])
        by smtp.gmail.com with ESMTPSA id y11-20020aa79e0b000000b006e537e90f91sm1749524pfq.131.2024.02.29.14.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 14:33:21 -0800 (PST)
Date: Thu, 29 Feb 2024 14:33:20 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: "Singhai, Anjali" <anjali.singhai@intel.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 "Hadi Salim, Jamal" <jhs@mojatatu.com>, 
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: "Chatterjee, Deb" <deb.chatterjee@intel.com>, 
 "Limaye, Namrata" <namrata.limaye@intel.com>, 
 "tom@sipanda.io" <tom@sipanda.io>, 
 "mleitner@redhat.com" <mleitner@redhat.com>, 
 "Mahesh.Shirshyad@amd.com" <Mahesh.Shirshyad@amd.com>, 
 "Vipin.Jain@amd.com" <Vipin.Jain@amd.com>, 
 "Osinski, Tomasz" <tomasz.osinski@intel.com>, 
 "jiri@resnulli.us" <jiri@resnulli.us>, 
 "xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>, 
 "davem@davemloft.net" <davem@davemloft.net>, 
 "edumazet@google.com" <edumazet@google.com>, 
 "kuba@kernel.org" <kuba@kernel.org>, 
 "vladbu@nvidia.com" <vladbu@nvidia.com>, 
 "horms@kernel.org" <horms@kernel.org>, 
 "khalidm@nvidia.com" <khalidm@nvidia.com>, 
 "toke@redhat.com" <toke@redhat.com>, 
 "daniel@iogearbox.net" <daniel@iogearbox.net>, 
 "victor@mojatatu.com" <victor@mojatatu.com>, 
 "Tammela, Pedro" <pctammela@mojatatu.com>, 
 "Daly, Dan" <dan.daly@intel.com>, 
 "andy.fingerhut@gmail.com" <andy.fingerhut@gmail.com>, 
 "Sommers, Chris" <chris.sommers@keysight.com>, 
 "mattyk@nvidia.com" <mattyk@nvidia.com>, 
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Message-ID: <65e106305ad8b_43ad820892@john.notmuch>
In-Reply-To: <CO1PR11MB49931E501B20F32681F917CD935F2@CO1PR11MB4993.namprd11.prod.outlook.com>
References: <20240225165447.156954-1-jhs@mojatatu.com>
 <b28f2f7900dc7bad129ad67621b2f7746c3b2e18.camel@redhat.com>
 <CO1PR11MB49931E501B20F32681F917CD935F2@CO1PR11MB4993.namprd11.prod.outlook.com>
Subject: RE: [PATCH net-next v12 00/15] Introducing P4TC (series 1)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Singhai, Anjali wrote:
> From: Paolo Abeni <pabeni@redhat.com> 
> 
> > I think/fear that this series has a "quorum" problem: different voices raises opposition, and nobody (?) outside the authors
> > supported the code and the feature. 
> 
> > Could be the missing of H/W offload support in the current form the root cause for such lack support? Or there are parties 
> > interested that have been quite so far?
> 
> Hi,
>    Intel/AMD definitely need the p4tc offload support and a kernel SW pipeline, as a lot of customers using programmable pipeline (smart switch and smart NIC) prefer kernel standard APIs and interfaces (netlink and tc ndo). Intel and other vendors have native P4 capable HW and are invested in P4 as a dataplane specification.

Great what hardware/driver and how do we get that code here so we can see
it working? Is the hardware available e.g. can I get ahold of one?

What is programmable on your devices? Is this 'just' the parser graph or
are you slicing up tables and so on. Is it a FPGA, DPU architecture or a
TCAM architecture? How do you reprogram the device? I somehow doubt its
through a piecemeal ndo. But let me know if I'm wrong maybe my internal
architecture details are dated. Fully speculating the interface is a FW
big thunk to the device?

Without any details its difficult to get community feedback on how the
hw programmable interface should work. The only reason I've even
bothered with this thread is I want to see P4 working.

Who owns the AMD side or some other vendor so we can get something that
works across at least two vendors which is our usual bar for adding hw
offload things.

Note if you just want a kernel SW pipeline we already have that so
I'm not seeing that as paticularly motivating. Again my point of view.
P4 as a dataplane specification is great but I don't see the connection
to this patchset without real hardware in a driver.

> 
> - Customers run P4 dataplane in multiple targets including SW pipeline as well as programmable Switches and DPUs.
> - A standardized kernel APIs and implementation brings in portability across vendors and across targets (CPU/SW and DPUs).
> - A P4 pipeline can be built using both SW and HW (DPU/switch) components and the P4 pipeline should seamlessly move between the two. 
> - This patch series helps create a SW pipeline and standard API.
> 
> Thanks,
> Anjali
> 



