Return-Path: <bpf+bounces-31985-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF2E905EF9
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 01:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54AE2284CAB
	for <lists+bpf@lfdr.de>; Wed, 12 Jun 2024 23:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B2212C80F;
	Wed, 12 Jun 2024 23:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gZ9HRbds"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2811B4315D
	for <bpf@vger.kernel.org>; Wed, 12 Jun 2024 23:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718233975; cv=none; b=FfKKhqPrfPTNf5gQMw6RnOHZNlR6MQI6DXeei8kHscdjvr7POveNcG6rzffd37OdfVDSbrIX6d4WXhe2BK4Yni7cn9Q97ArjJ1EV/mHlq9XMgOxcLzHX5m/N4qzv5B14Z56XY8iX1f5NujbFo4wmkwbHoPc2zhIQO/TEDdaY4Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718233975; c=relaxed/simple;
	bh=vz/L2wlP8+Ri/8r2p3FqFxZCBJtI6Xm34AXGyf2d5/o=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=bY187O4eR6mLrDwtnniNNPxMc9Gat2MNsKMDgadAK52siWo+AzjyqiVZ+5SfX4yiIHM+DRJJ+V44LMJT24mdL9aBPS5PJUxkwTP+ReW70CpjI2Cwc4sNh7+wxpDNhsoRESxq0VfkeDq2FmBPNtDaTZOr+Th+/uJqU4DsauAIDH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gZ9HRbds; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3759a6423a6so1933085ab.1
        for <bpf@vger.kernel.org>; Wed, 12 Jun 2024 16:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718233973; x=1718838773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UwShtlyLMV9VTtyyslK6XvDE+iidzuifx2xzs5ot2Xs=;
        b=gZ9HRbdsjH9fjgIS9ljiUuP7kiScAeDvokE6xA9s2afKR4NWeGIafKAZN/JjfdwRri
         rCyXo9r6rIXHq+0Bw4IpjTN7/B1aiNfaJJ7A9nmz64Z6S9Oz+U4c2Bq/Kv0LCmktMvkn
         jGhTqOsYCsyxBJ8nxsZpxMSynYy16bmhoLtD9hxtPtE/KsHOyetmgtokEE981l6xwZKr
         ko0gNDN2JxlJIqRCOhSoJLGpsWBpbFfk4VekSCCnKFAJJLURoScZ/YXe7ETB/1yAlLlD
         hhqYz9xDi3Toiz3PYsCAKjijOOhh3EqhrGj5MqhCwOxxBPk8J7+HnXcmDG9RBE3JNSxR
         cscg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718233973; x=1718838773;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UwShtlyLMV9VTtyyslK6XvDE+iidzuifx2xzs5ot2Xs=;
        b=DW8xvk3suvFYoJuUrSY9jOvYdjpCxDcdErhs8vdMXISZdb1hYmV9KsyFpp0gB33ZFm
         69/LBn7QybQ4P2A9Jg8qWus3FiwX5sMyLKxSETrvX250D2WZ4NOD5ifi5QIMnieweHH5
         ajFs0Hj8zHXT/of4peRXq8/FkEDlnhw3hAUV7S3aFAiDfB6/3rwRDbATb8U5DpV6Cy2n
         ZURSV8tnu1V4ROg9sGhUyaqPc83Vr6Tpzg6EUhM8Rw7NptVyVywimi7pSThJj9fGDG+J
         Xf/KhgHsP9Efzwe2/JaE+Ii5+IwpfDHZwm2JL4qXu1M3Vt3XLGrZpDbbysOYoFZkdf5m
         QNrw==
X-Forwarded-Encrypted: i=1; AJvYcCUqcEQ6UQDGIYdqpYfIBMcj4VUENuFY8H1Biheq81bLdoqD5M1Z4QhmAZtoouyLekEy+D8BPc/wRPSE/GCIjiYMDa+2
X-Gm-Message-State: AOJu0Yzyddf30eKYPtI0BT0ytnddyL9Q+qogsDF2kCom3rSsWvBx7PBc
	E2wuDbLAYs/6gA6CpYbYqXTp6JrE42/4NU4G/7YzRFqzWauOt+jT/GRnXQ==
X-Google-Smtp-Source: AGHT+IHxaU6PjWgmOpf1gQ8SLG9cZsghSSnlIXpK/nUJW4AXNJ/sT9sWzFxdEUWYuaOBcXcamOGOEg==
X-Received: by 2002:a05:6e02:1e0a:b0:375:9dd4:d693 with SMTP id e9e14a558f8ab-375cd14fe9fmr38570795ab.3.1718233973182;
        Wed, 12 Jun 2024 16:12:53 -0700 (PDT)
Received: from localhost ([50.169.240.3])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b9568de22csm38222173.23.2024.06.12.16.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 16:12:52 -0700 (PDT)
Date: Wed, 12 Jun 2024 16:12:52 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>, 
 bpf@vger.kernel.org
Cc: jjlopezjaimez@google.com, 
 Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <666a2b749d47d_12372081d@john.notmuch>
In-Reply-To: <20240612221405.3378-2-daniel@iogearbox.net>
References: <20240612221405.3378-1-daniel@iogearbox.net>
 <20240612221405.3378-2-daniel@iogearbox.net>
Subject: RE: [PATCH bpf 2/2] selftests/bpf: Add test coverage for
 reg_set_min_max handling
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Daniel Borkmann wrote:
> Add a test case for the jmp32/k fix to ensure selftests have coverage.
> 
> Before fix:
> 
>   # ./vmtest.sh -- ./test_progs -t verifier_or_jmp32_k
>   [...]
>   ./test_progs -t verifier_or_jmp32_k
>   tester_init:PASS:tester_log_buf 0 nsec
>   process_subtest:PASS:obj_open_mem 0 nsec
>   process_subtest:PASS:specs_alloc 0 nsec
>   run_subtest:PASS:obj_open_mem 0 nsec
>   run_subtest:FAIL:unexpected_load_success unexpected success: 0
>   #492/1   verifier_or_jmp32_k/or_jmp32_k: bit ops + branch on unknown value:FAIL
>   #492     verifier_or_jmp32_k:FAIL
>   Summary: 0/0 PASSED, 0 SKIPPED, 1 FAILED
> 
> After fix:
> 
>   # ./vmtest.sh -- ./test_progs -t verifier_or_jmp32_k
>   [...]
>   ./test_progs -t verifier_or_jmp32_k
>   #492/1   verifier_or_jmp32_k/or_jmp32_k: bit ops + branch on unknown value:OK
>   #492     verifier_or_jmp32_k:OK
>   Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---

Acked-by: John Fastabend <john.fastabend@gmail.com>

