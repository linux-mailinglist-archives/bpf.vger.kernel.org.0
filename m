Return-Path: <bpf+bounces-54989-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F358DA76DFA
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 22:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D941C16B407
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 20:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82FCF2165F3;
	Mon, 31 Mar 2025 20:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LjQbgtg1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433F6215781
	for <bpf@vger.kernel.org>; Mon, 31 Mar 2025 20:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743451825; cv=none; b=sKmzY5LTSu8Mq/Z+j2Xdp0oXRYuxicHinCLR8qgtCU8RYGOjJGrHCu0vLczclqnwKFU19HUtYUdrWkk7S3jeH5BjLJW9PN/kByItHuI27QBwXVK2IpNy9oshrJ9SufVZhn3FXJoZY4Z8f8Z2U2xXmoLCGG4ERXRilauYInyX4Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743451825; c=relaxed/simple;
	bh=Td1ye1GecL4KuWsliC6Andv5+5kKi3u6/5AOS+jLDv8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=L/+9EYgVYZGG8Rkey6/Fobz2O/KvGkikLHwk/Hj+TWcT/pMRiVw/6y8b6svCQSDnhToi1GCL+i1F8wBYqms132gqKrZ6rkeyBJiSSZgFdjkY/fGQsX264ATikRBR88vmoDEtSHHpliKNURyOU3GViVZNPQLJDR1HlWbde3+9WKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LjQbgtg1; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-54af20849bbso3345527e87.0
        for <bpf@vger.kernel.org>; Mon, 31 Mar 2025 13:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743451821; x=1744056621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=nKWetPbqU/Zf05CCYdGIu2g7/gUU1/Iq1Q3WSuqbDdo=;
        b=LjQbgtg1vOHtx1t5iqMkHTf2J6PPMepTPoK5GiyS6ooZYHnhXWvSpM8oBwWzP6wsqn
         t9HPoA6JTwzh+PaOYPTB27Aj3J49WCYls/Zeue6fjCih5RKUEDvMIHjpx2PJ+ox8i+1W
         ltoB6XVItRtq8rqv5RToIsUmyt6eCGWXJnHhBH81QmVCLAHCnyQvHnXwV9rrIgOUy2n5
         jHc1F0UbfWs8GIMMMV97I6V1QTdTJLT2nwra0ExBRk+lS5YGvbItwERTgrI/fKUZkF3v
         n7+6mnZt3xiWEg7w/srUwyZ92jNopd6G9SL6VeOLcWh0M+8jLRgyXA/kladsYqMhH2gn
         Aahw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743451821; x=1744056621;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nKWetPbqU/Zf05CCYdGIu2g7/gUU1/Iq1Q3WSuqbDdo=;
        b=dnErntGbboQ/0dp1047ImqCmDYkB4KjiFChJlEgKTyMJTZhMCLUsSswgRL1Gyshzlh
         S29qE2cBciH+I6v6H9xzcRR32gIibrLW3/RJiLtjTeLa2k5keu9EmI1J1OKGMq0G3+8A
         9RkhxFQtquQFT63Ma5zjNl0G6odj4e6oJwEh6SI6bSmCpMfV5gKv+9ctYN044P/wRD6z
         Y6VAUwx1IfoeW5eIyMt73Xa7vla5q40hIS+bAjlWt9vU74qbGet3vrK/TbJF/gxIT6Pe
         4PjFHzh4GMFRTFO7YExxTRyqJ5FjKHot0Wfx05XIVN6cIWiTSKfq8vKgfxu/dEwCPKRW
         NfYg==
X-Gm-Message-State: AOJu0YxlyzkKW+/4FGO8opLWBieUqndc2xvJlo1Jyu3h7Uw+vCP3oGDJ
	Dh54Kz9Na7IDvLbo5MO7LNcUT7fIZwFNiOVuSizWhdpJyPS1ltDU3C3Zk3dW
X-Gm-Gg: ASbGncubjeDB7qafczzASqzQo5QAwpzwLBdLVWfk0099gvlA5JTFzU3kdxD1PiG3Iy9
	SVnGS8nqG99Eg4+FAbvi8BpqjwiKKFxn4RFXnjUIMfhkBpjzLxXnMbN0G4RQbdP39myg+eRjLud
	kvX73NIeHVL4e3213Ud67mEQ2uFTrng8W9sMP90LoMM+bgP6cu6Unoh+q4YaVd1XPxi93RC5XR9
	FmzmWnVeOtWAYsmSJCLDUKZE5CX0ci2r1YGCGK2G3mLLXNjKDZSt2W6Jhxc2YS22trKQ+o0SvN1
	aF1f0C1UmOM63Ehhc6WZkBJOwIX3hRIa0GTI7RelwhFIZkgCXHolpA==
X-Google-Smtp-Source: AGHT+IEdkcQaQrafvUa2zzfZjFJbtRWiRgOuVretDr3/eNiKfYcx9OY4H88kc3JZUIkc6BQaAMXfGw==
X-Received: by 2002:a05:6512:b8f:b0:54a:ca65:7dbe with SMTP id 2adb3069b0e04-54b10da71b0mr3094430e87.11.1743451820911;
        Mon, 31 Mar 2025 13:10:20 -0700 (PDT)
Received: from cherry-pc-nix.. ([77.91.199.108])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54b09580604sm1196328e87.122.2025.03.31.13.10.18
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 13:10:19 -0700 (PDT)
From: Timur Chernykh <tim.cherry.co@gmail.com>
To: bpf@vger.kernel.org
Subject: Improvements of BTF sanitizing for old kernels
Date: Mon, 31 Mar 2025 23:09:52 +0300
Message-ID: <20250331201016.345704-1-tim.cherry.co@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello everyone. Recently I've encountered some issues with loading on debian 10 with kernel version `4.19.0-[17-22]`.

This first one consists of when the kernel loads BTF with specified min-CORE and libbpf does some sanitizing on those, then it "translates" func_proto to enum. But if `func_proto` has no names for it's parameters then kernel verifier fails with "Invalid name" error. This error caused by enum members must has a valid C identifier, but there's might be no names generated.

The second issue this PR supposed to fix is missed check whether kernel supports the `kind flag` or not. Let's say we're compiling the BPF object on new kernel with a new compiler. There's 99% percent chance that compiler will use this `kind flag`. But of we're loading on old kernels that have no support of this, so the loading will fail in multiple places.

- The type metadata check. Old BTF_INFO_MASK prohibits 31d bit
- Integer bitfield verification. Because old kernel waits for an offset-only encoding for the btf_member->offset field, but it's encoded in different way in case when the `kind flag` is set.

This PR contains:
- Enum names generation during sanitizing process for `func_proto` kind, when it being translate to `enum` kind.
- The feature check whether kernel supports the kind flag or not
- Kind flag sanitizing if kernel doesn't support one
- Struct/enum bitfield members sanitizing by generation a proper replacement the type of bitfield with corresponding integer type with same bit size

From: Timur Chernykh <tim.cherry.co@gmail.com>
To: bpf@vger.kernel.org
Cc: 
Bcc: 
Reply-To: 
Subject: Improvements of BTF sanitizing for old kernels
In-Reply-To: 


