Return-Path: <bpf+bounces-15072-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4575E7EB6BB
	for <lists+bpf@lfdr.de>; Tue, 14 Nov 2023 20:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F9991C20AD2
	for <lists+bpf@lfdr.de>; Tue, 14 Nov 2023 19:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2789D1FD3;
	Tue, 14 Nov 2023 19:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mjRnM60c"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F591FA0
	for <bpf@vger.kernel.org>; Tue, 14 Nov 2023 19:07:06 +0000 (UTC)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F658FB;
	Tue, 14 Nov 2023 11:07:05 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6bd73395bceso89017b3a.0;
        Tue, 14 Nov 2023 11:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699988825; x=1700593625; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=crYXZ2+TGefE1MZr1CPzuD2Ao+ZCyPvBl9mPlHWyCHo=;
        b=mjRnM60c2FShnMtUsAE+loAzrOpqK/2Tu3aEyJbI36eqCDMw0ZWXm/0dTNmLVzlMz7
         bfBV566ZpQJReFd91Z/Su2yUH1u1v7A22JjyJLYE1feP4/QqqAFGIf3Ogwzf0urh3vXR
         nm3pnDCepzN4PX7Fk8gh2Nl05r+tPNzDZbGqgtPpNhfs5A8LSz4PksnomnFqkajbSZrZ
         gXv3i5YV7PiJ6ma/BJGqUJPHW/VyRuqx1VXwCLSMi/wq/krUI+d0+nDbfEYYJV8Ye6lH
         wMx+Z7iNCKQqR5A8KibIoxOejX1dbL0q2HJDkOhsFU8gEim+68drBZ6o9IwR+HchlahV
         ls3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699988825; x=1700593625;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=crYXZ2+TGefE1MZr1CPzuD2Ao+ZCyPvBl9mPlHWyCHo=;
        b=tK8/n4fDkRzgi+GLSiPUWHbn4MkEUfRlqGXoAbmx0Kwc4SXjQ+pj1U4UAKUigF0HVz
         cTeuqSMjlRrwUafY8NI2yYWKqAmRgwJM8fy6wYln5Ek69e4fgnyoA72CKHa4r1Pqpavt
         wVz64oclQJbzBsCtN+2Dw532n88P1rqmCcnXyYPhUifzWLY4FWUKDv8fGhXJq66bEVh2
         0FwhENa/vsYPHccnQs35tvidsAQankBHmHy7HPv/bPqVi4BB9PA0vFtSjnzTFXYEE7lW
         +/QlAY5MLYBjnmAfvgxCVveLwC+eurl91w3VRkIGDonRHxqx8Y4qe3Pd2HAs8xTTpmQN
         1jaw==
X-Gm-Message-State: AOJu0Yw1UQPhv5fRvkXisg5yS3y9yVxYBkOwaU9bl0x7pq3Jv+71e5fc
	/erp9iewDRLsz+SCK3vgkv94HOJjQCT6og==
X-Google-Smtp-Source: AGHT+IHCyuSIrFeXT4LI4PV1GZeBni9le0dSGtwI2irVpVJXUj9vzFi6VCyrwLxbsWv0Man+4Ouk2w==
X-Received: by 2002:a05:6a20:1b26:b0:151:35ad:f331 with SMTP id ch38-20020a056a201b2600b0015135adf331mr3688236pzb.14.1699988824868;
        Tue, 14 Nov 2023 11:07:04 -0800 (PST)
Received: from localhost (dhcp-72-253-202-210.hawaiiantel.net. [72.253.202.210])
        by smtp.gmail.com with ESMTPSA id o21-20020a63fb15000000b005b7e803e672sm6036934pgh.5.2023.11.14.11.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 11:07:04 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 14 Nov 2023 09:07:03 -1000
From: Tejun Heo <tj@kernel.org>
To: Changwoo Min <changwoo@igalia.com>
Cc: torvalds@linux-foundation.org, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@kernel.org, joshdon@google.com, brho@google.com,
	pjt@google.com, derkling@google.com, haoluo@google.com,
	dvernet@meta.com, dschatzberg@meta.com, dskarlat@cs.cmu.edu,
	riel@surriel.com, himadrics@inria.fr, memxor@gmail.com,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	kernel-team@meta.com, Andrea Righi <andrea.righi@canonical.com>,
	kernel-dev@igalia.com
Subject: Re: [PATCH 12/36] sched_ext: Implement BPF extensible scheduler class
Message-ID: <ZVPFV9jG1y3YbJUd@slm.duckdns.org>
References: <20231111024835.2164816-1-tj@kernel.org>
 <20231111024835.2164816-13-tj@kernel.org>
 <c631759f-6e71-4c27-9a56-fc3159793e81@igalia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c631759f-6e71-4c27-9a56-fc3159793e81@igalia.com>

On Mon, Nov 13, 2023 at 10:34:23PM +0900, Changwoo Min wrote:
> Currently, scx_ops_enable_state_str is defined only when
> CONFIG_SCHED_DEBUG is enabled. However, print_scx_info() uses
> scx_ops_enable_state_str regardless that CONFIG_SCHED_DEBUG is enabled
> or not. So when CONFIG_SCHED_DEBUG is not enabled, the current code
> generates the following compilation error:
> 
> kernel/sched/ext.c: In function ‘print_scx_info’:
> kernel/sched/ext.c:3720:24: error: ‘scx_ops_enable_state_str’ undeclared
> 
> So CONFIG_SCHED_DEBUG should be moved to after the definition of
> scx_ops_enable_state_str.

Will fix. Thank you.

-- 
tejun

