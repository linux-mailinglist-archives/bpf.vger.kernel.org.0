Return-Path: <bpf+bounces-13297-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C9AE7D7C20
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 07:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD7261C20E7B
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 05:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F13C2D9;
	Thu, 26 Oct 2023 05:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="XjQZT9Gh"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B777BC13C
	for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 05:18:16 +0000 (UTC)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302F5C0
	for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 22:18:15 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-53df747cfe5so700555a12.2
        for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 22:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1698297493; x=1698902293; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cpa1jmHoGIDl8T9wF7rvtHmWNTSsTPL6IUnnggsmgPg=;
        b=XjQZT9GhzUF2EEQ4PPeTYT99fTYBE+3r3FyB44tM2i5Sb74qoBwFYzYTADtAhf0xps
         WFXCsGW//a7TeC48MS89p0l7HPbcn1hFRa4uyIodvU6NzZVy5Fka7zLYbI+EJKB1c5f+
         R794VF03WQB7PWFP7WG3dnkrEtO6ctWJvNzlyvI8zTEjGL71TOxt45QCPm7ORD6p+JI8
         vlDYYI++EiUtWeBY/Va93IDi0NlPuJ00EypAYM2LTGNiSTg3CTjhH/ert10CMP8qJk5N
         m/N0XYRVubzL3X5arvdIQvc+JkB1q+vfAi9/NcINdAxEwUAemZubFL2fR89PiuJhPjcj
         gwLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698297493; x=1698902293;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cpa1jmHoGIDl8T9wF7rvtHmWNTSsTPL6IUnnggsmgPg=;
        b=iH66orOn2dlytdJ74y9fIzGMA/2duZO+hgXs7dUTaI95awqOhKM8g16s43jLXSkJdg
         HcB/ACvjYMO02piPukliwk7/cc8YoJ/35JHIwrDTgkqvetIItYUHV9lWJJXWEwdHhyo5
         7H9Fie1FcgAhOSppneOKwoo6/WNg5Mdsk6jciCgGHTXVdRI/8MGcCoJj33ckA/S0CtVJ
         np54GoDWGKYN2cdGyu1ZuMYTES7LlH8HNPMiJ27MvS61Ta8J8VvO0IjBCeEvqbL6jNp7
         Lj1q4+NxmACsvERqzWCAvzNQAQdeome13Kx886Meq5XQUNTRFlpxSGDNKUrcTKsHFA2/
         mf6Q==
X-Gm-Message-State: AOJu0Yx6ql/bobR1JGsiJuGzEZHtWiuuFAGm9Bvy9zZg/Q+0ivHmGAuW
	ycL7biZTEj6YrKQYbYJR9uo2CBkEmZfx+LGaonQVMQ==
X-Google-Smtp-Source: AGHT+IHr2lMvr2Iv0qLy9WCr3A7gV0R89XchaAwGLTQBaSzY//gV50Q3bg/Nq7bS3hSAe8KeCDUytg==
X-Received: by 2002:a05:6402:190d:b0:53e:6da7:72ba with SMTP id e13-20020a056402190d00b0053e6da772bamr15933959edz.38.1698297493539;
        Wed, 25 Oct 2023 22:18:13 -0700 (PDT)
Received: from localhost ([80.95.114.184])
        by smtp.gmail.com with ESMTPSA id n15-20020aa7c68f000000b0053eb9af1e15sm10586532edq.77.2023.10.25.22.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 22:18:12 -0700 (PDT)
Date: Thu, 26 Oct 2023 07:18:11 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, martin.lau@linux.dev,
	razor@blackwall.org, ast@kernel.org, andrii@kernel.org,
	john.fastabend@gmail.com, sdf@google.com, toke@kernel.org,
	kuba@kernel.org, andrew@lunn.ch,
	Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Subject: Re: [PATCH bpf-next v4 1/7] netkit, bpf: Add bpf programmable net
 device
Message-ID: <ZTn2k1vn0AN8IHlw@nanopsycho>
References: <20231024214904.29825-1-daniel@iogearbox.net>
 <20231024214904.29825-2-daniel@iogearbox.net>
 <ZTk4ec8CBh92PZvs@nanopsycho>
 <7dcf130e-db64-34bc-5207-15e4a4963bc0@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7dcf130e-db64-34bc-5207-15e4a4963bc0@iogearbox.net>

Wed, Oct 25, 2023 at 07:20:01PM CEST, daniel@iogearbox.net wrote:
>On 10/25/23 5:47 PM, Jiri Pirko wrote:
>> Tue, Oct 24, 2023 at 11:48:58PM CEST, daniel@iogearbox.net wrote:
>[...]
>> > comes with a primary and a peer device. Only the primary device, typically
>> > residing in hostns, can manage BPF programs for itself and its peer. The
>> > peer device is designated for containers/Pods and cannot attach/detach
>> > BPF programs. Upon the device creation, the user can set the default policy
>> > to 'pass' or 'drop' for the case when no BPF program is attached.
>> 
>> It looks to me that you only need the host (primary) netdevice to be
>> used as a handle to attach the bpf programs. Because the bpf program
>> can (and probably in real use case will) redirect to uplink/another
>> pod netdevice skipping the host (primary) netdevice, correct?
>> 
>> If so, why can't you do just single device mode from start finding a
>> different sort of bpf attach handle? (not sure which)
>
>The first point where we switch netns from a K8s Pod is out of the netdevice.
>For the CNI case the vast majority has one but there could also be multi-
>homing for Pods where there may be two or more, and from a troubleshooting
>PoV aka tcpdump et al, it is the most natural point. Other attach handle
>inside the Pod doesn't really fit given from policy PoV it also must be
>unreachable for apps inside the Pod itself.

Okay. What is the usecase for the single device model then?

[..]

