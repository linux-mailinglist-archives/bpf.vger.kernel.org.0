Return-Path: <bpf+bounces-56234-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E35FA93A4E
	for <lists+bpf@lfdr.de>; Fri, 18 Apr 2025 18:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 241053B0905
	for <lists+bpf@lfdr.de>; Fri, 18 Apr 2025 16:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA62A21480D;
	Fri, 18 Apr 2025 16:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="f4qIYwQc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28842116F1
	for <bpf@vger.kernel.org>; Fri, 18 Apr 2025 16:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744992431; cv=none; b=JaRZU1xkZLD15heHaZG6/F3Ybtwugb12r4MyM56Ujko4h7C1VcOravSiFNzL5VpzjKQdXyO+W+JqpD1IG+sjJJuVegxe/XhYIDVNJAgR0/r+a3nnz8hasnr/0nKHyD+5QZNY/r1Ne34FFSz8nwR6OAbu4jXsDrnQ9mRxuCbJGKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744992431; c=relaxed/simple;
	bh=mJDJYr7lVaC8wf49jlEbGffCUgODVQ8wlaVjxXpd9NU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ILnFL8Zd7regReQi2M0g5BOQPn1mXwoKt9FC9f8uxAboztQ/MCu5XOUZ5ugpnZWdcwRligDzytIiH9kmsxlO1VibB/Y/+5o8zdSOuOg1bduKJ0h1+Te6Jd8IxDy/cNjszsXYxJA5Zyu7ljCHhD0oQNAKZVq/T/K0M8lnHGc9u9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=f4qIYwQc; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5e5e8274a74so3042626a12.1
        for <bpf@vger.kernel.org>; Fri, 18 Apr 2025 09:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1744992428; x=1745597228; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=mJDJYr7lVaC8wf49jlEbGffCUgODVQ8wlaVjxXpd9NU=;
        b=f4qIYwQcWNfstcEj05cGQ6wxM6ZVHkbgt2n8qZ3xy5J5HxdCEqKcsnWGOZrvjMRT1I
         a6x2Ko6aVbvtiDzRGEveqOi3v3ciEG31INr1o/O9VkwlPy25yYLK/r3zEnym7lgzP9aD
         is4fHwXQupWP7/coXFHK0uFfKSHeW9hVADg8zEl5GYHN0ev3XCBzYEhH8lUOkQstrF4T
         nRq/kdKQWdJ41TEiznqhRPugV1fNG+ZDBu49p+5mF4z+6WaQdtcNVrn9WOOit/OikQ+T
         rjw4SxM5scU7cbvD8Z8icpnZgetRXCbk/LMlWNfnhA/dozN2T3PTUEzN+r5BI+hBfDvR
         PRTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744992428; x=1745597228;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mJDJYr7lVaC8wf49jlEbGffCUgODVQ8wlaVjxXpd9NU=;
        b=Pp+h1/MpTtUdOlpW172aRzqaAlyEdN7Em1Sh39TPNyCAY3xUxPg/mwQLWKEdHx+U4I
         +QrY4Jtj07WqPcNlihkvSD+1jGmU68H9m+s1YADXNVWUnqiYQ3jQqh77ypvhNJD/Y0hX
         oaM4WjfJjOvnhrudhHrDA9u/XDIlVJK+ZVLqjuEIUpE+vvqrfOlyaSbhWpQugciCpzcX
         RVkh3WJv+y6BLKDB45c/Bm11dEAYiqC9ChSOPPOSuJfcx2vfOv2/cPhylTTSfsoEGrxj
         5VbMTtN9XuwzIw5eXU4vgK6ZyC1Y0WTTHaYUfDFoBtibftXWD82bgzvATIAIroybnRJt
         CLCw==
X-Forwarded-Encrypted: i=1; AJvYcCWJQm5GmSPjKeYVlqjUsEU6/lOSVrHvBDF23Rnrc0mpy+F9cs3q4GRjnYXDDWX/hpG5p6g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHvTPmLON+CW8q3TquGZ4V4B5xE40NEw57GRrUHHRia4FF+V7H
	oMIX/uCtYKzwrTCQASZ2Vc2t6E1SPuPD0qBl8wzoyF0qlVM43+e9qjdJvblc7Ak=
X-Gm-Gg: ASbGnctHaVzVZhgAS7E8HAmj9r+DrwMdqRm36JW6MyZxqabxr/z8K+Q0UZ+FU9QJoFd
	H1BbyLA5Pal7VOjver4IReXTrwInpdrPvk3/VViWtXTtvhixNzlZUFAj/ke/aP0ux/UIvQXlfpJ
	rruHJVBLAlUrVqvOxjSBBfQ5OlMUk+ERDYN8wn3S97c6EWNZIeFZn6VqhknvdDsuJy/H2v4Js5x
	59Q8RwyQZtFrVXntwI1CBjnDVo91A6kLcwfDDG662cMUElb+NwNSY4G02yLmDxD/4M4HxvEiT9U
	be5bN1NPDxm0xPiGQux6Z9vyzBrO0NyDSg==
X-Google-Smtp-Source: AGHT+IGA0mJvYWhzAc0oNHZeKO+KGsF+25BJMfzQI0JM3A/aTXEi+UCjUxCGApuU0msTc2ARl0raKw==
X-Received: by 2002:a17:907:1b22:b0:aca:c6db:2586 with SMTP id a640c23a62f3a-acb74b18d90mr295654566b.14.1744992427833;
        Fri, 18 Apr 2025 09:07:07 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:506a:2387::38a:4e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb6ec10011sm139200266b.14.2025.04.18.09.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 09:07:07 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Andrii Nakryiko <andrii@kernel.org>,  Eduard Zingerman
 <eddyz87@gmail.com>,  Mykola Lysenko <mykolal@fb.com>,  Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,  Martin KaFai
 Lau <martin.lau@linux.dev>,  Song Liu <song@kernel.org>,  Yonghong Song
 <yonghong.song@linux.dev>,  John Fastabend <john.fastabend@gmail.com>,  KP
 Singh <kpsingh@kernel.org>,  Stanislav Fomichev <sdf@fomichev.me>,  Hao
 Luo <haoluo@google.com>,  Jiri Olsa <jolsa@kernel.org>,  Shuah Khan
 <shuah@kernel.org>,  Jonathan Corbet <corbet@lwn.net>,
  bpf@vger.kernel.org,  linux-kselftest@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-doc@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 1/9] selftests/bpf: Support af_unix
 SOCK_DGRAM socket pair creation
In-Reply-To: <20250411-selftests-sockmap-redir-v2-1-5f9b018d6704@rbox.co>
	(Michal Luczaj's message of "Fri, 11 Apr 2025 13:32:37 +0200")
References: <20250411-selftests-sockmap-redir-v2-0-5f9b018d6704@rbox.co>
	<20250411-selftests-sockmap-redir-v2-1-5f9b018d6704@rbox.co>
Date: Fri, 18 Apr 2025 18:07:05 +0200
Message-ID: <87ldrxa1xy.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Apr 11, 2025 at 01:32 PM +02, Michal Luczaj wrote:
> Handle af_unix in init_addr_loopback(). For pair creation, bind() the peer
> socket to make SOCK_DGRAM connect() happy.
>
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> ---

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

