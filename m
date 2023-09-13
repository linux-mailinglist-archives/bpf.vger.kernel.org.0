Return-Path: <bpf+bounces-9960-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F22E79F243
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 21:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD8382819E2
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 19:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3B51DA53;
	Wed, 13 Sep 2023 19:39:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427341A29E
	for <bpf@vger.kernel.org>; Wed, 13 Sep 2023 19:39:56 +0000 (UTC)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C10DB7
	for <bpf@vger.kernel.org>; Wed, 13 Sep 2023 12:39:55 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-34f5357cca7so250085ab.1
        for <bpf@vger.kernel.org>; Wed, 13 Sep 2023 12:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1694633995; x=1695238795; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tft1HooN87hi/19RuephXAGarkXU4BD94o5nCoYckJ8=;
        b=pNQ0oV1Wwn3LRIFz/Kn8b8xec3OuZPtPpz/wzOcOfDndpvgi6/oE8Y8qDS1W23RBl/
         gsjsyUxgzV9SIXxLsBhEz80kFbNmjjpntZ2K+hIlCRuuIDc00ARCHjsP2qjsFFYtU+8d
         adccqSp4pwsT+Mz+rfrjOUbXf5MZkx2ttYieZyLeznSDIVl7vxk/UVTDRNWzfEImsJa2
         PYLUNpD6cKeZ9HGUhFlqIKpCKka8NMUE/rvZWMq+HUQfLMg3SlO+OdX865sPO7923rkw
         ZPICN4yBO6BpIhqGWUztAfkHMugorYZALESivKg4DLoAmMinwMhcfYZGwuIXziPys7SH
         SleQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694633995; x=1695238795;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tft1HooN87hi/19RuephXAGarkXU4BD94o5nCoYckJ8=;
        b=SZj70KS2Kd8JXvJQURNj5L3iSFrpJH7iAfxUNk8/K7T5RBdY0uFNPS4PzsJX6zx9Jx
         slAOjREHVR6NIVW+TmjQhgdk9EyFQ82ta1VYhd7tMe+0XQ1XPr0uVamn2NGVrhXQ5V6t
         LPll5dz1p3+VYimwKzB7HWIFDgYb/+bSTmTfOBCOK3b6eY/44ytWpSQ0rxuTCO/iC8t+
         DX/iao4Es7n6ItMRYg3cJdBsGS8ZUxhXk574U+dii7CGj24oI5/DkZdaDgiD3c79tKgF
         kHOLh9vXcTCu//1CENHIaIp1ULOXk6R/GNw+DTvXg+3k0+PqJx6q+5tAmdhOmH1daU45
         8KHg==
X-Gm-Message-State: AOJu0YxeCtlaejx7pjlmdUHdubDhFoYmPXV6wOQmM9s/PgEq29QhURpo
	aLf1bLm2yP3OU/i9e8rmX6xFNA==
X-Google-Smtp-Source: AGHT+IGtBzcobfCWCkQ5HPj4+SqKK9ECxFRGlGCGQqDAtr3vPCIrAPClhL0Dsulx18cZsBLQCEwl2g==
X-Received: by 2002:a92:d986:0:b0:349:4e1f:e9a0 with SMTP id r6-20020a92d986000000b003494e1fe9a0mr3254955iln.2.1694633994913;
        Wed, 13 Sep 2023 12:39:54 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id d4-20020a056e02214400b0034ac1a32fd9sm2500863ilv.44.2023.09.13.12.39.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 12:39:54 -0700 (PDT)
Message-ID: <efe602f1-8e72-466c-b796-0083fd1c6d82@kernel.dk>
Date: Wed, 13 Sep 2023 13:39:53 -0600
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 7/8] io_uring/cmd: Introduce SOCKET_URING_OP_SETSOCKOPT
Content-Language: en-US
To: Breno Leitao <leitao@debian.org>, sdf@google.com, asml.silence@gmail.com,
 willemdebruijn.kernel@gmail.com, kuba@kernel.org, pabeni@redhat.com,
 martin.lau@linux.dev, krisman@suse.de
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, io-uring@vger.kernel.org
References: <20230913152744.2333228-1-leitao@debian.org>
 <20230913152744.2333228-8-leitao@debian.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230913152744.2333228-8-leitao@debian.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/13/23 9:27 AM, Breno Leitao wrote:
> Add support for SOCKET_URING_OP_SETSOCKOPT. This new command is similar
> to setsockopt(2). This implementation leverages the function
> do_sock_setsockopt(), which is shared with the setsockopt() system call
> path.
> 
> Important to say that userspace needs to keep the pointer's memory alive
> until the operation is completed. I.e, the memory could not be
> deallocated before the CQE is returned to userspace.

This is different than other commands that write data. Since
IORING_FEAT_SUBMIT_STABLE was introduced, any command that writes data
should ensure that this data is stable. Eg it follows the life time of
the SQE, and doesn't need to be available until a CQE has been posted
for it. This is _generally_ true, even if we do have a few exceptions.

The problem is that then you cannot use user pointers, obviously, you'd
need to be able to pass in the value directly to do_sock_setsockopt()...

-- 
Jens Axboe


