Return-Path: <bpf+bounces-27489-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C23E8AD8EA
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 01:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E537E1F23208
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 23:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5BA3E474;
	Mon, 22 Apr 2024 23:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uhD+HpL8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1636D20DFC
	for <bpf@vger.kernel.org>; Mon, 22 Apr 2024 23:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713827356; cv=none; b=CQaNJzO9jLVfD/0SoswjlERiFp9U5h3wY7X0CG0RzrbA+9jVCEWc4+wLokaHSUvMPhwNxxDJwJ3XOhRgeM8maHMQrhzX9vEn6s02ha9E71Tl+M0qoKEABxQ0uArD8v/Uvc5NupSca9K9qwpMcvMg+UOEKAEbFOAJKaUB8vkwUSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713827356; c=relaxed/simple;
	bh=YgH5tot4dhaAdVq9yVNWJY2zGeD10lBUtCC5fNxwyRk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ieaq0GNICBZniBKZrS5FOIWdl5EhDsjwiloMgV3RbySCrXwiE+aFubVdh9Rbd6nQTfHOuZIp9TRNhqv3Z914OGzgLqGqj5EJU1LUhrlvhroUTdCUa2Vqo5uD99tQ5LIXySf3Lm8ZhNaIG6RJ/36TdAuj/hfHn25xaaFJrpnP2bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uhD+HpL8; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-5c6245bc7caso4907136a12.3
        for <bpf@vger.kernel.org>; Mon, 22 Apr 2024 16:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713827354; x=1714432154; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Snl1rZABVtdI19qJOvg1X3Ix5qzNqJ79l8KmmK+1QA8=;
        b=uhD+HpL8uCFXuPtYpKletnG3K7ghJRfUfc1qCdRpYhMCZjYkbXoOL1H+lmAqYc7+Qo
         MqvRW6eU1zEIvwsSqDQGNL0Zkc56QkuQoCwZB0Fe+c43YmbCkXp3czfuNB9BpvQPq3Oc
         tfMpO9gJf8HCCieHqW8ilWd/gx7B+3E51SNMpBmXaZpVKNiRvkjMY7cVzQ+1n9iF4IQe
         /0CkWfi6lSExJPVqa+3QDB+afB5f4MShgAPK6RMFVeW20uTyHo0oiGsE0OSrBpPpdOkZ
         ny9t5xgOi/rowHmS1dliXWFhUeMSfm+3eXwN5YnZbp8/T8sqGAqm2jbHQ9DsJk2dTlaL
         W7Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713827354; x=1714432154;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Snl1rZABVtdI19qJOvg1X3Ix5qzNqJ79l8KmmK+1QA8=;
        b=lR5s2fqnWO2LfeDgePusUrFzCL4AlLUs3e+RICYX52qR+mKaJKz6DDiNALEMtURU3p
         90+qLB6wBjfdxtyjsbtnpdC0xxWbiDBy1TkXAgbfJf9pBsknijcPfIOwUFLcanF9g7Zd
         H4MnvawBiKJLHUzYA3Jkdi42MZ/WDbIkA480khHuhz12Bk5NFLo4x/WcnZkMDoQwJKjB
         XS0QGNgQ/42+ZOzYVnKM2F01CsGMND4Gn7CdC9PMxKCF7e/226LAdzz7hDcpI3XZtm6y
         DQMOAxY6+s0uP7x3krZVzrmasU217RoSUv1cfvCwJ1m2dQLMYpg6dUm689LMAVKVxL+I
         rfAA==
X-Gm-Message-State: AOJu0YxuJYs9fbUNd/IvkAs4bIkwHGCqqgDqp6ry7FjohXhBcu67ECyU
	3jpvqYDgRbDqW/HCyMCc4M1Dqw0pBJwCKRO7hX5DXxhCQlHpRZGodIB3NZpgM/HN4w==
X-Google-Smtp-Source: AGHT+IGI2tNtJNzapupWAIygnHgAAUku0uZ/zIZHlgyPSdhy5YUHK70l7spxUH48kYpaAQhtigchWfc=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:903:1cf:b0:1de:f18c:ce4 with SMTP id
 e15-20020a17090301cf00b001def18c0ce4mr998171plh.0.1713827353500; Mon, 22 Apr
 2024 16:09:13 -0700 (PDT)
Date: Mon, 22 Apr 2024 16:09:11 -0700
In-Reply-To: <20240421042440.33125-1-lulie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240421042440.33125-1-lulie@linux.alibaba.com>
Message-ID: <ZibuF9_INOxYUVch@google.com>
Subject: Re: [PATCH bpf-next] bpf: add mrtt and srtt as BPF_SOCK_OPS_RTT_CB args
From: Stanislav Fomichev <sdf@google.com>
To: Philo Lu <lulie@linux.alibaba.com>
Cc: bpf@vger.kernel.org, edumazet@google.com, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	haoluo@google.com, jolsa@kernel.org, dsahern@kernel.org, laoar.shao@gmail.com, 
	fred.cc@alibaba-inc.com, xuanzhuo@linux.alibaba.com
Content-Type: text/plain; charset="utf-8"

On 04/21, Philo Lu wrote:
> Two important arguments in RTT estimation, mrtt and srtt, are passed to
> tcp_bpf_rtt(), so that bpf programs get more information about RTT
> computation in BPF_SOCK_OPS_RTT_CB.
> 
> The difference between bpf_sock_ops->srtt_us and the srtt here is: the
> former is an old rtt before update, while srtt passed by tcp_bpf_rtt()
> is that after update.

Can you also extend the rtt selftest to exercise there new numbers?
Something simple like making sure they are non-zero should be enough.

