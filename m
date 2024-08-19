Return-Path: <bpf+bounces-37534-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6D595741F
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 21:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8677E285456
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 19:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F7C1D54DD;
	Mon, 19 Aug 2024 19:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lzC1qlUu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CF01D54E1
	for <bpf@vger.kernel.org>; Mon, 19 Aug 2024 19:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724094377; cv=none; b=FZ4Fua/mShPlGYOEdFTS+O6f2gA96uewYvPSJNZ9tssNgsGcB+tKl61FtMA6smP6U3LNvS43rmlV+ORw1WrJj8/ydW12MLgG+exp0xHWymzMb8u1sA79R9cmePWYNuWU0Y9wgn7eqr8xPEaYNNW0OCl3+37jWK04tDPmhA7UfZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724094377; c=relaxed/simple;
	bh=ZOmpoV2tEdUFrVa5RI+AkesGt6dYQh9a5AOy4xRvmLk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=C8SJ6dDMNKrGal3Z8pUBSoq7Z0OiNOW5aGuA+w9W1GwQoTXyh8gz54D4QPWHorFyjq8o0lUkegJkUA1W55TLFvir5vP7FR6KZF+EnDb43f9GDMwoIeDZkKmRtaNenlFaUbaQFt+CabjofIhAApUl0MHZyB/b8eJR0QLYjR/MIFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lzC1qlUu; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5bec7ee6f44so4169144a12.0
        for <bpf@vger.kernel.org>; Mon, 19 Aug 2024 12:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724094374; x=1724699174; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xpAZramWONn8vOEqfHVOxy50BnBQq4M8nzGv89LSyDA=;
        b=lzC1qlUuIWJ6aSDarUyrmvpTuBe8Cd+N3aT8+jQWZfGo1DeXrskrMevudwNha0E6B4
         C9vCB/iXVgS/6UpHtVeQmEWXhEQuf7r4u2dibPHLG5xPSxhhggckmG1POlT0KbezmPsl
         8jTAUkP6IRhDtNsxIycgz2dyyDLOnnQtVVfI77cAfm6y0jfyxP4LxIcs3JmJPzD+ypDY
         1GXc8Q0ljiZ6cS8t7JYqMEW9fQKkrtBTgtZ4qACzGCAsWw/tERGC4vUafW7OZkDaTzvP
         haV5mLGcIieFQMeGDmtgo47+dONLTznoJbo6bCA9Vl9qHDKmnBMJMvPLCRDgNPzoC0N6
         lQdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724094374; x=1724699174;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xpAZramWONn8vOEqfHVOxy50BnBQq4M8nzGv89LSyDA=;
        b=Smo5lpAAFZd2/nVTkuCokpMkdMlfvjkeX+/TF9SXTjGaTFKsbSlDxvt9sf6JY7taWw
         sijn5h86MZTMB6ooG0wdm4z/yfP19RLYNy/kML0vFI3OQlXouHYctS3qyAw+E4Q06fxF
         o4L02IugGsFVYVSyCC0KqtKes6hCeI/cjyIqO+5W/3cx7OUjMjcihYLOiNNIVzbzfj8d
         85NnyUobe1rp6brA5bZ0hmF7WHyWMMDZQMpY6ZPOhzrCAKY2utytdfURPfsH1vQuiCdl
         BcixIUVD/iSDT5qqxyW6B9yxR6OjLu0+7f2bCIDCGFLxr5M/h0XftTbmadg/jMsAOz7E
         Y++g==
X-Gm-Message-State: AOJu0YxMP+1uSB6ve8VKfhlI69BCcf4WshrWIz89pWf0XDzPDDtlw4Nc
	k8Ya0yLaiUQ5nyZd89IqXBzaB/v7sw01QUUbrhyezZ0obSwwKOloV72LQax1aUJUj+Jrc++e1V1
	hEKU=
X-Google-Smtp-Source: AGHT+IHS7zo5e7902iNUDnPPR6SioO6pXYwQcqzC0BdGhlmJF+4NcA0LVgInhvXRdkMUPVgqBWaG+Q==
X-Received: by 2002:a05:6402:11d4:b0:5a1:c40a:3a81 with SMTP id 4fb4d7f45d1cf-5beca8d129cmr8278470a12.35.1724094373700;
        Mon, 19 Aug 2024 12:06:13 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bebbde4964sm5870402a12.24.2024.08.19.12.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 12:06:12 -0700 (PDT)
Date: Mon, 19 Aug 2024 22:06:09 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Joe Stringer <joe@wand.net.nz>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [bug report] selftests/bpf: Add C tests for reference tracking
Message-ID: <418e180c-31b5-4777-b341-8503b1d5e0b9@stanley.mountain>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Joe Stringer,

Commit de375f4e91e3 ("selftests/bpf: Add C tests for reference
tracking") from Oct 2, 2018 (linux-next), leads to the following
Smatch static checker warning:

	./tools/testing/selftests/bpf/progs/test_sk_lookup_kern.c:70 sk_lookup_success()
	warn: potential pointer math issue ('tuple' is a 288 bit pointer)

./tools/testing/selftests/bpf/progs/test_sk_lookup_kern.c
    55 SEC("?tc")
    56 int sk_lookup_success(struct __sk_buff *skb)
    57 {
    58         void *data_end = (void *)(long)skb->data_end;
    59         void *data = (void *)(long)skb->data;
    60         struct ethhdr *eth = (struct ethhdr *)(data);
    61         struct bpf_sock_tuple *tuple;
    62         struct bpf_sock *sk;
    63         size_t tuple_len;
    64         bool ipv4;
    65 
    66         if (eth + 1 > data_end)
    67                 return TC_ACT_SHOT;
    68 
    69         tuple = get_tuple(data, sizeof(*eth), data_end, eth->h_proto, &ipv4);
--> 70         if (!tuple || tuple + sizeof *tuple > data_end)
                             ^^^^^^^^^^^^^^^^^^^^^
This is pointer math.  It should be "tuple + 1" or (u8 *)tuple + sizeof(*tuple).

    71                 return TC_ACT_SHOT;
    72 
    73         tuple_len = ipv4 ? sizeof(tuple->ipv4) : sizeof(tuple->ipv6);
    74         sk = bpf_sk_lookup_tcp(skb, tuple, tuple_len, BPF_F_CURRENT_NETNS, 0);
    75         bpf_printk("sk=%d\n", sk ? 1 : 0);
    76         if (sk)
    77                 bpf_sk_release(sk);
    78         return sk ? TC_ACT_OK : TC_ACT_UNSPEC;
    79 }

regards,
dan carpenter

