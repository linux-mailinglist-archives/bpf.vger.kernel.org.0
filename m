Return-Path: <bpf+bounces-15009-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 682FA7EA31A
	for <lists+bpf@lfdr.de>; Mon, 13 Nov 2023 19:53:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA431280F15
	for <lists+bpf@lfdr.de>; Mon, 13 Nov 2023 18:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3809D22EEF;
	Mon, 13 Nov 2023 18:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zdOhWB51"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F1022EEB
	for <bpf@vger.kernel.org>; Mon, 13 Nov 2023 18:53:20 +0000 (UTC)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 868EC10DA
	for <bpf@vger.kernel.org>; Mon, 13 Nov 2023 10:53:19 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-777754138bdso323798285a.1
        for <bpf@vger.kernel.org>; Mon, 13 Nov 2023 10:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699901598; x=1700506398; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e/1vgNbrzcrjswtNPRvbWXiDhjN8BGJ6BpUfet0Upv0=;
        b=zdOhWB51qfQM0pc8M5Z+lcdjYXg2gW3TcYrdrHP1kS1r8T4PXEjv4DS7V03uqCc+GH
         crJvcntaIB15rbcy0yQ0RO4JR1yAw9olEnQtPOQqXqeHVMtLoRB7kAsTnUEYdhqqXNpF
         KtBpNw0Ny0qjurcViDLl3zgMjbLEv/fv4TcBTAevdvfRZKf2bfX9U6lSZ20IwebqYszT
         5QYResB0x0uM4KehvxPdaIEtlRUESMnHr2YeI13uc3lMCNIBBSscXyqlKJCNnps1GwxO
         WtWEO3wZthSG8VhiDca3k/QvxEMEQbn217LYX6VwZs43RfiZY9z/7sK9GZOj6Kny+Ojw
         vmPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699901598; x=1700506398;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e/1vgNbrzcrjswtNPRvbWXiDhjN8BGJ6BpUfet0Upv0=;
        b=HlKwY784erd7LDq+6WqIHT7XoOvz18bWzD2cY18liOh7ewAQekG5IADytgr2isTx23
         HDf84MsL/5D9FCSstn3mNfRhn0XqeET5+aI7Ctn1o3YFcetcnQnWlbCEvrgWnpFs1Dnu
         PqywrBOknGu4jgdwjTS64gF4szmRBskacAThEZt2wqg82PBpmV5vvAEoIrAFzTmEQDPK
         9d9r5JlwE5mys9oIJq5r/vUc/KYX0KcRNW00fNh+hca7pa6PB+bPyMvKZ521sOpmXQIB
         F9IRra6PWidjdcAmtI2E5M5z/qJi7oLF22brPfeYZVt5JhOax2hWOSYibibqP1vTEg4J
         EBJg==
X-Gm-Message-State: AOJu0YwRDUQHNipFmHBRN9rkIvfzhsp6q9ei5RE9b7FB90ph4ubxeRIU
	ivyEnC/HVGKlV7CxyJtMSJNuRWsLLKnvVFyVLVMMZw==
X-Google-Smtp-Source: AGHT+IGe+tP2mJU2qINFsQN9XAQoKcE+glB8AASGRH9LpqzP4vJSnSNzpjP8PcYaT0DrVCiGgSp9lQ==
X-Received: by 2002:ad4:4441:0:b0:658:c75c:1946 with SMTP id l1-20020ad44441000000b00658c75c1946mr50346qvt.52.1699901598493;
        Mon, 13 Nov 2023 10:53:18 -0800 (PST)
Received: from [192.168.1.31] (d-65-175-157-166.nh.cpe.atlanticbb.net. [65.175.157.166])
        by smtp.gmail.com with ESMTPSA id dm2-20020ad44e22000000b0064f3b0d0143sm2233203qvb.142.2023.11.13.10.53.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Nov 2023 10:53:18 -0800 (PST)
Message-ID: <a7ff8638-84b2-467f-89fa-63916a082d09@google.com>
Date: Mon, 13 Nov 2023 13:53:17 -0500
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: BPF memory model
Content-Language: en-US
To: paulmck@kernel.org
Cc: Josh Don <joshdon@google.com>, Hao Luo <haoluo@google.com>,
 davemarchevsky@meta.com, Tejun Heo <tj@kernel.org>,
 David Vernet <dvernet@meta.com>, Neel Natu <neelnatu@google.com>,
 Jack Humphries <jhumphri@google.com>, bpf@vger.kernel.org, ast@kernel.org
References: <CABk29NuQ4C-w_JA-zev796Nr_vx932qC4_OcdH=gMM6HZ_r4WQ@mail.gmail.com>
 <33f06fa6-2f4d-4e50-a87e-0d6604d3c413@paulmck-laptop>
 <5c3b16c8-63e6-4f80-8fa2-6bacb38cdcb6@google.com>
 <e5c6b7f7-3776-4c2e-9896-fe44e735c1d1@paulmck-laptop>
 <22da941e-384a-4f02-80c4-8b84c0073f8d@google.com>
 <5b23c67b-8b15-4d54-8f38-c201a6842b20@paulmck-laptop>
From: Barret Rhoden <brho@google.com>
In-Reply-To: <5b23c67b-8b15-4d54-8f38-c201a6842b20@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/16/23 12:48, Paul E. McKenney wrote:
> Hopefully better late than never, here is a draft:
> 
> https://docs.google.com/document/d/1TaSEfWfLnRUi5KqkavUQyL2tThJXYWHS15qcbxIsFb0/edit?usp=sharing
> 
> Please do feel free to add relevant comments.
> 
> 							Thanx, Paul

thanks for putting this together, and great LPC talk today!

barret

