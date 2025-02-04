Return-Path: <bpf+bounces-50377-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F056AA26BA3
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 06:59:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B287F7A265B
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 05:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27571FFC54;
	Tue,  4 Feb 2025 05:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dugeHlr5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5977B158558;
	Tue,  4 Feb 2025 05:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738648736; cv=none; b=YkC9/4IYR4eQZjqNZ3Z52OrvcwqxYGGFumNZQUrv7sG6I/FlbbMHY+rrd6osxmqyTgYSNMl087bekMSW4ptVVTlieCHE7uH6k9s7oKUy2E8z7+6kLU1hIQxPyo8QGfaMHt0mOpdcKYDBsChE9ELdIFqX4tuAZuew2XdI1F+5SDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738648736; c=relaxed/simple;
	bh=Mcl8svOJgCl0ZHJ/RMQOfuumyrGthpsMWmfu0nBHLPU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a1RokD4aOWcummaTkzG0iWYODTSHdNBqHi4TSbfU+GuMGrxQc2zFChT6HJWSm3akOQ0FR/Qlabe1KaMcFPv4fLRAwfMu0/DAle06qCsDoEUKn9vyYhNnGfqxkTYFiYOWus620MQb+nPy/HFBKrdMov/tHio59vhBgEpagr0O19E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dugeHlr5; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2166651f752so3348125ad.3;
        Mon, 03 Feb 2025 21:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738648733; x=1739253533; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Mcl8svOJgCl0ZHJ/RMQOfuumyrGthpsMWmfu0nBHLPU=;
        b=dugeHlr5mfHcOjgmUpyF732sFrhjLmzJVQ4v7LRekKg3fwG0GSDpWDKV56mYdaFgEm
         1YqOgr6JUYpsTeZBry6DGLFeSuXSioe3KD2Bc1xCfHNP3DEFn/3kcnACMIdUP6iNNKJ4
         9FWyuCaLREB6YeQeZZPyf3Lahp3ZOS3l314XkQbH1sl6YH+HTL691z15owQzv4CmrA5u
         HGadiimDfIXrMQP+zLc1L1zvSWM/piFdStucZQPUyDWW2oEw90cSCRdRXrtV9y85WIYB
         Z/YYDxziAFSBQv44NmRWQss5Te1C9VPnwqcvhtI2k/Fb0nuqUvju7SEUFjXTLVDmBhJh
         oNCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738648733; x=1739253533;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mcl8svOJgCl0ZHJ/RMQOfuumyrGthpsMWmfu0nBHLPU=;
        b=puiWe1EH1JWdKmI75s98sc4liQpT/78dJENqqGbKVn5Y1oH6nWQqMiu/E/wUkNT7Ho
         Ly4aKfIm7A0Xlvv0tGGnxQcBjeN0d6CMl4wFfdBEwZWSffC/14eBzXn9R/EoyYh0Oulx
         uP2xw07pI2ZA+SGhbRH1Zw5DxFT2yaWDx+zHZKhzbTwwYUUb4CHGBpOTl0HtmxJiBr2c
         UFwpDLO4Jfv/opjTfiyPfugZ3gRN9xqXqQK5NVxl3b8gyhQPRAT+rZwmO/+jeKBbtHpm
         A1+yPy2IY0AFNZpwG0DszjUunHZGQZFLjjAzDj8TJE4XWtUnTQd3CIXVr9jwnFITh46h
         8WHw==
X-Forwarded-Encrypted: i=1; AJvYcCUvRiCwR1dIZpmrtptLhyvG6mhUrlc4N5RIgpa+DQ1yQ8J4JYqOpxjbpNJufilNBn84wne4fr0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxZnC1NWJUNSlc3wWKTvYARITSBA+8Ko5jSJQ3cmygLFpL1mIy
	7njMMgO27w50YQe1BsnRdqkJ9HBDsg7ClNoKJzAiQgFBKc1gC3Kg
X-Gm-Gg: ASbGncsxxF1qm6XuIgfftpjtJfw5haUWK6aslh0OpcQfJXvm1844FxUUgmOHISyqVkN
	L1eP0diK61aIbBndc1YYyPIAvvyjAwzc1AXnyb+V7mmcvycU0VnzmhPKpqacJ1flTbDaJLXbodF
	cgUohj7qIyz/j1+OJsM2wTw8W+t7IKav2G1zgt4l5CMhv17w0p2YOPZkJMK/5NkMA6i5MEpDmaw
	skokP7EzcVTtuULB/0XpPEE27SiCVKfttXGb5X/lPd70Zy/S+C2sw8HiKNsBryAZJkPC+njoJmj
	uznI7kHecrU1
X-Google-Smtp-Source: AGHT+IEv9TlfKByklRKOO/1nGncspakqcK3wtITD0R/TDRgDpShcdagLUUkSw4k02m2n/J19wWYmzg==
X-Received: by 2002:a17:903:1252:b0:216:69ca:770b with SMTP id d9443c01a7336-21dd7c6625emr415299795ad.12.1738648733615;
        Mon, 03 Feb 2025 21:58:53 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de3302e63sm86256525ad.172.2025.02.03.21.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 21:58:53 -0800 (PST)
Message-ID: <97d9f2b5c570e9581c8a13956897357459f65618.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 05/18] selftests/bpf: Test returning
 referenced kptr from struct_ops programs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	alexei.starovoitov@gmail.com, martin.lau@kernel.org, kuba@kernel.org, 
	edumazet@google.com, xiyou.wangcong@gmail.com, cong.wang@bytedance.com, 
	jhs@mojatatu.com, sinquersw@gmail.com, toke@redhat.com, jiri@resnulli.us, 
	stfomichev@gmail.com, ekarani.silvestre@ccc.ufcg.edu.br,
 yangpeihao@sjtu.edu.cn, 	yepeilin.cs@gmail.com, ming.lei@redhat.com,
 kernel-team@meta.com
Date: Mon, 03 Feb 2025 21:58:47 -0800
In-Reply-To: <20250131192912.133796-6-ameryhung@gmail.com>
References: <20250131192912.133796-1-ameryhung@gmail.com>
		 <20250131192912.133796-6-ameryhung@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-01-31 at 11:28 -0800, Amery Hung wrote:
> From: Amery Hung <amery.hung@bytedance.com>
>=20
> Test struct_ops programs returning referenced kptr. When the return type
> of a struct_ops operator is pointer to struct, the verifier should
> only allow programs that return a scalar NULL or a non-local kptr with th=
e
> correct type in its unmodified form.
>=20
> Signed-off-by: Amery Hung <amery.hung@bytedance.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]


