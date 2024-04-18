Return-Path: <bpf+bounces-27151-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA438AA04A
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 18:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50AE6283FBE
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 16:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2385F171092;
	Thu, 18 Apr 2024 16:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XF/vq2h1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EFD16F8F3
	for <bpf@vger.kernel.org>; Thu, 18 Apr 2024 16:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713458285; cv=none; b=pe9IfYo/xBzEF+3cMwAWllSHljOp57yUFYa3hCIn3UwexfpHsbYwMhLVwHtNN46bQavR4+zNP3+l6FB+purHBdpy7jCHGk9GJpvvRi6gqJ7BPYdiFRmy8GE/U9OrMg68Y/O4kOzFqDdpnB9g6EUKCR3dlwGzbbvN/Ocou8sjsBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713458285; c=relaxed/simple;
	bh=V626uEJkH9jBbP9aHpW/Nvz/TdS8JMzCVHPPyBjG91g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ohzHWsn2sykiKn1oI+J2JXaLDmfA6PdN2a7IeZvv1lSBI5I8Vnyf5mleZzh69XKrydJjVjCiGv7Uty8AevkWyqrwgyMFsqeBNxMs0Xzhnh79IgjLaoU90SxMpMrp5p7rinLlLEMGF1cj8/orFPaSryz5AeIRPcLLiuZ0ZDdsai8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XF/vq2h1; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-516f2e0edb7so1393442e87.1
        for <bpf@vger.kernel.org>; Thu, 18 Apr 2024 09:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713458282; x=1714063082; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2fvL6J9nXYqFFsxzFO/o7239dRTb2u5K1mOJJhr20OI=;
        b=XF/vq2h16JiedJw086qXgxCqT2jcfCjetovrVB7yhOjpuIXVSsUgAwsktvz6AsguI9
         FjY7BzLhlG4++UipNYXkk4Nzons0R+tVK0CUElomCZqr72gp3wUHB8Iuj4QBsU7IGTtV
         AgK41rVLCyUI9al8bNZByzGuDmNrJDFb6ZHz/TzrG4gNJES7MzofytYRU9LVubMuz0Z4
         +smFhaKVF2iwq2JBL8EO2x/qQQ5tJu/UChtYa8cohr3Z0Ue1w+80tr77xQtKBxnZmS/1
         ma2S13tienorDtfpO9C8awyWpH/ASwLLIf4/pHkKj4WA+EKA75irZzL4Y3nO/Tp//vW8
         7kuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713458282; x=1714063082;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2fvL6J9nXYqFFsxzFO/o7239dRTb2u5K1mOJJhr20OI=;
        b=BSAL9KiOV9CS/Lr1YOK0C+6C4lk/XOsE8N5NqP2TDVtVR2Vpx7y8PYvemdrcEAKCsr
         MjPZQn1zEQokZ1I24shyWUpHOUe6yqUtXVtnTNQu5wyEA7AACz1xM0W1lPGTcJJsdjNa
         wFjJ+2hfw3tKu02fK3VIfOc1C807Lsy1ZgcFRu+3j23037RnCOS09lqVP1/v8RCJRIUW
         s0IcG5TT/EH74+fB8aXcOQ1g54AL0e8lqFrBILqM9a/rfG6znSJp3m1We7ndjHh3OFkv
         vp63QrM0BycW0VSta0ndBprAUg8WWiLR0pl4K+ccng9/97/YqqZhQZ8hSqfR6bvptnTn
         WeCA==
X-Gm-Message-State: AOJu0YwNMy1+lwxKnghE9+OUWrbb0iDEjAPETCqZDzaji9cQMesL6JDK
	2Gg9jgFrYvY3JhbCw9M8jlsll3uxBjd0OAHpFbXuD4R+zgtzV9wGWMTVbvEpxpcB+z5WXJLE0zY
	x0Y7pcmFmYLQCxmdN9JK9TwIZGEnYiSm9xwrr
X-Google-Smtp-Source: AGHT+IE/svMEdblsX6s5vPxV2ylObzjaIZ55o97lvAaXhYSugvIA3wFEwwhMNS0cq5OY9J8vFtE9CdF9Q9hKNy9Yx24=
X-Received: by 2002:a19:5e55:0:b0:519:5df9:d945 with SMTP id
 z21-20020a195e55000000b005195df9d945mr1975972lfi.4.1713458282190; Thu, 18 Apr
 2024 09:38:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240412165230.2009746-1-jrife@google.com> <20240412165230.2009746-5-jrife@google.com>
 <3df13496-a644-4a3a-9f9b-96ccc070f2a3@linux.dev> <CADKFtnQDJbSFRS4oyEsn3ZBDAN7T6EvxXUNdrz1kU3Bnhzfgug@mail.gmail.com>
 <f164369a-2b6b-45e0-8e3e-aa0035038cb6@linux.dev>
In-Reply-To: <f164369a-2b6b-45e0-8e3e-aa0035038cb6@linux.dev>
From: Jordan Rife <jrife@google.com>
Date: Thu, 18 Apr 2024 12:37:49 -0400
Message-ID: <CADKFtnQHy0MFeDNg6x2gzUJpuyaF6ELLyMg3tTxze3XV28qo7w@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 4/6] selftests/bpf: Add IPv4 and IPv6 sockaddr
 test cases
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Kui-Feng Lee <thinker.li@gmail.com>, Artem Savkov <asavkov@redhat.com>, 
	Dave Marchevsky <davemarchevsky@fb.com>, Menglong Dong <imagedong@tencent.com>, Daniel Xu <dxu@dxuuu.xyz>, 
	David Vernet <void@manifault.com>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"

> The test_sock_addr.{c,sh} can be retired as long as all its tests are migrated
> to sock_addr.c

test_sock_addr.c has a few more test dimensions than
prog_tests/sock_addr.c currently does, so it covers a few more
scenarios.

struct sock_addr_test {
    const char *descr;
    /* BPF prog properties */
    load_fn loadfn;
    enum bpf_attach_type expected_attach_type;
    enum bpf_attach_type attach_type;
    /* Socket properties */
    int domain;
    int type;
    /* IP:port pairs for BPF prog to override */
    const char *requested_ip;
    unsigned short requested_port;
    const char *expected_ip;
    unsigned short expected_port;
    const char *expected_src_ip;
    /* Expected test result */
    enum {
        LOAD_REJECT,
        ATTACH_REJECT,
        ATTACH_OKAY,
        SYSCALL_EPERM,
        SYSCALL_ENOTSUPP,
        SUCCESS,
    } expected_result;
};

We focus on the "happy path" scenarios currently in
prog_tests/sock_addr.c while test_sock_addr.c has test cases that
cover a range of scenarios where loading or attaching a BPF program
should fail. There are also a few asm tests that use program loader
functions like sendmsg4_rw_asm_prog_load which specifies a series of
BPF instructions directly rather than loading one of the skeletons.
Adding in these test dimensions and migrating the test cases is a
slightly bigger lift for this patch series. Do we want to try to
migrate all of these to prog_tests/sock_addr.c in order to fully
retire it?

-Jordan

