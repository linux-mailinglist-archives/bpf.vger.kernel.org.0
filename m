Return-Path: <bpf+bounces-46010-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7169E2B36
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 19:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B38A1B32858
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 16:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862711F8AD4;
	Tue,  3 Dec 2024 16:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MLoCLy36"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775461F8933
	for <bpf@vger.kernel.org>; Tue,  3 Dec 2024 16:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733243212; cv=none; b=Q1lpkMYo+E/tUDYCk2BMZlKmViUCUnyC85RezXQYytOWEHWkJ2bVIJwF5ApcanUiy2DwkmkbK03136Dr9R7IybhIQly6qhMDZcnietm85dRgy24BbYaNVgfHj641DMw79tbBIx1+wgIrbX8fblk80rLVK+ae6WFW7HTr60cTFAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733243212; c=relaxed/simple;
	bh=BkSzMCMwBhXw1RJp2P+9QtJ2Nu6otyn05ju5zUKJGFo=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To; b=gCnO9jDrVIuoTv53JlrUsRNMB0hS3BTO6/kO+0wdLzCAnnoAUMhEBNQryylLH+RBrWxjy2NreQVa5JE9dPUlEyncOEFgQZPHMCKnq8mU1685Vc8JlOLKyfuM9UY+KcWXjG+Xx0eNmiD+xRbCzDArszoC2AYCuQMMe682hYcV/a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MLoCLy36; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ffb3cbcbe4so62141891fa.0
        for <bpf@vger.kernel.org>; Tue, 03 Dec 2024 08:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733243208; x=1733848008; darn=vger.kernel.org;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ax5q7VmGj3/BaYNXmu8U7t8oSydl1mzaSCDys4BGvzQ=;
        b=MLoCLy3656u4KjMdHIsX8Q5yCvJvC+rJMJC1zKDKmdhoPggtfOEO5li9mLvJkw7zV8
         UfL8HbPY+wP5R8KGplIP3e6g30nzf5SxEiiBPAX9pOnDGDc69GutZbn6FSvg70lJaNP6
         RM1UxNcJAksQrNe6xIPmlv8QelaqlHGN5N3Lxxr2LcT2LHV3y/k5T5c+7lhCsZVzNGp/
         m7K0oVcWKMX/rWgvdUFYDy5PYmsjCOD4rkAedTiMJt2J+WNTxYdG2wyRT+QnEdW9nqbL
         IW++mw4AyQy9LPgS+AbYoDgRxLD0AM5gHMW/ZjxiZ5HrozNL0rDYJz9Msw9gse3pais/
         ng0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733243208; x=1733848008;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ax5q7VmGj3/BaYNXmu8U7t8oSydl1mzaSCDys4BGvzQ=;
        b=EmRvuvVuGEUTHZOHNizZ+/Jc4BvgVB5G7Kqd3V0t1jaAcB619AllWtV5BcMOvYWMQl
         /CuoB+Tu4VzYODsoDlmNQvho2/E4n8KMnV04BhQaOeesAw7h2KOVGRkBoMK0NJXl7QLt
         veTKKVNNe4a2QPPdRYhQPfyWfauh8y/Fjre0zRyvpBDckLbYow3ci/I3HRauQHOfvCi5
         l7REg41699xe3VoHB/XwW53HpKOdF3arcCBziXDEeC94lT75uXDFlOZ6VbbrJ//VNWAv
         OuHtMNOdd/OACEHU0CB8udorxfnSP2DBTBXoQ8oNL4cegISsxqYMjbjpHL3T5dVRaLsD
         lX2g==
X-Gm-Message-State: AOJu0YxNBJRUdwGGboENdPKN/msvBZXYjdLRbmG+Bjrw13OZdZsNS0u0
	ZXLXNdUtfthxAAa+93t8H4vp4qZfEBUWKzmbL6eemaOg3SBWE0gJT3SEraaHK9s=
X-Gm-Gg: ASbGncv0vtn+rpYBY3hU5zKt2K6Zl3VpaSRgYHWzFlf6ClUyZFBEMPU0w8E1enqUjyr
	03DrMCQjGOth8j3/nDz6YuGmh426MI6NfZusuogqm1FHzoD8G1d12+Y/xqheeQtg10r6WvukD6y
	vonveKnpg4Xz4nDarqmzsgY4L1kqAWHkNRtNw2DLm3bVT23twwihxsK43UN6iCs9RxOk4mx+yTY
	tNhrFhVT9NTkokq0J8BIMEOxTUpVFGrcJmUN/G78cLkIFLr/nsSTGNb4Lr6Ylhn5t3Fz6wr3AE=
X-Google-Smtp-Source: AGHT+IEgO9TWFYdY5Qj4tLay3BM5XcAuBOmncE0aji/hH5utLopf9Hj/mHm41wk3Q1mDi46kgR1otg==
X-Received: by 2002:a05:651c:892:b0:2ff:c741:db84 with SMTP id 38308e7fff4ca-30009bf618dmr25558471fa.1.1733243208429;
        Tue, 03 Dec 2024 08:26:48 -0800 (PST)
Received: from smtpclient.apple ([2a02:8109:9291:f500:15a7:6a63:17f6:c1f5])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d097e8dcefsm6508641a12.55.2024.12.03.08.26.45
        for <bpf@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Dec 2024 08:26:46 -0800 (PST)
From: Nick Zavaritsky <mejedi@gmail.com>
X-Google-Original-From: Nick Zavaritsky <MeJedi@gmail.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.200.121\))
Subject: Packet pointer invalidation and subprograms
Message-Id: <0498CA22-5779-4767-9C0C-A9515CEA711F@gmail.com>
Date: Tue, 3 Dec 2024 17:26:34 +0100
To: bpf@vger.kernel.org
X-Mailer: Apple Mail (2.3826.200.121)

Hi,

Calls to helpers such as bpf_skb_pull_data, are supposed to invalidate
all prior checks on packet pointers.

I noticed that if I wrap a call to bpf_skb_pull_data in a function with
global linkage, pointers checked prior to the call are still considered
valid after the call. The program is accepted on 6.8 and 6.13-rc1.

I'm curious if it is by design and if not, if it is a known issue.
Please find the program below.

#include <linux/bpf.h>
#include <bpf/bpf_helpers.h>

__attribute__((__noinline__))
long skb_pull_data(struct __sk_buff *sk, __u32 len)
{
    return bpf_skb_pull_data(sk, len);
}

SEC("tc")
int test_invalidate_checks(struct __sk_buff *sk)
{
    int *p = (void *)(long)sk->data;
    if ((void *)(p + 1) > (void *)(long)sk->data_end) return TCX_DROP;
    skb_pull_data(sk, 0);
    *p = 42;
    return TCX_PASS;
}

If I remove noinline or add static, the program is rejected as expected.

