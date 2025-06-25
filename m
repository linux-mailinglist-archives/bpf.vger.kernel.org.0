Return-Path: <bpf+bounces-61472-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE79AE739E
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 02:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CB4D165D8F
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 00:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D801FDA;
	Wed, 25 Jun 2025 00:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KSy4Oz7n"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71270A41
	for <bpf@vger.kernel.org>; Wed, 25 Jun 2025 00:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750810030; cv=none; b=p0Mvyt5vOITz9b9FXwafBeRHS4WTNbn5Koie18hFgRjL5BYmzWF0wxlEOPl2GZl84nE4DiVR5hHJWUCgjWnyQmww9aZOj2E55mcVWCl4T+TdZ17GzpYQHcrDC7jlMYt+sA8PQUTTdA87z82I2d3pbI0Lh4mMQsUo8oUyaQpAchQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750810030; c=relaxed/simple;
	bh=i6d8KE2fyRwEPUeh3mM9JufLQBfX1YeWtfBKmcoJKOo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YAQxv4BmDXdRSoeT8s6tegClCJ97Xc2RVOKggmzwnh65vEgVzt9UonEKWcC1mFoi4LXZLy4KzSJxM2DgzTtIfpxUBHAn8tGsF+VBqTuhO5R410/8YdGvgHkFwD0sEF+rMgIowf9uMfBeoJOBE3R73PPuhoB5437QHALNYx0Rink=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KSy4Oz7n; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2363e973db1so4004195ad.0
        for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 17:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750810028; x=1751414828; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=i6d8KE2fyRwEPUeh3mM9JufLQBfX1YeWtfBKmcoJKOo=;
        b=KSy4Oz7nCrpKP4osOPknDTGxGsSeFjBoHaB3WgKV0rRrOpfTQph6d2dAIJJHSIWbIn
         4XRNYHIvE1eFSNXcAf9TSJLG1GTRRzzheAM/7PVzCTUfbZsdeNPceA2PXe9LRy4h27GV
         pqsfCwY2B3iDrmP/dJ7cMdMQdeORr+EVbO2d08zeE2CON2Ii8fASqxk7h00CPXwr6HLM
         C7Qiy0e3zqd9RteguVuvreIRKktKCHSTjvp9ZkZGwAyf/uHkbBS58OvCRoJeNTRfb1lA
         FyOo/EOQHmSDyNflxI9BgP8VJoK1WxBU3EqzS2SwLJJj2goOwqnbH9ibzjhJZPYFH92v
         A9PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750810028; x=1751414828;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i6d8KE2fyRwEPUeh3mM9JufLQBfX1YeWtfBKmcoJKOo=;
        b=DjU8NmZCCLmIElv8D4HpumGYBzPQu7WjZ/15srJx8mPBC+GyF6xfcwj0Kb3ETOw4CL
         JGW6ec9c7P9zCKRPu0aoTCnNJh5RQPAQoaNQZ311ZJDHtteMCdTqFeUmSjSTe7FlVsPb
         h9oJ2ffrtZ6dDEcLhqaWVjJweIBEu/CYkQSKceQIGl4wvXPsi0pE+G/ibNkljoPeUugl
         t2vGz32yb8CSCfj7wwQtzpVBQ4X1IZX1ONuDFElgxEDVPEh2GvXYqlDAZsUGzTMcoHzf
         VSr2uzqSED5evNaX3NMtoc0Epfs7Yllgec3P3rOlLokiQj+JSkyVMslLpCVJJUoeORgh
         28hg==
X-Gm-Message-State: AOJu0YzF2jNYpCa6WDtOL6l6SZkl8CI5LBitgd1k73TTnesGJ5YROc6G
	PVasKISYJ3i5e7Oy+xge3sEx4/uPs1wikT4PC6hrf0HzBqfWFztee72rpY1+x6sIlq8=
X-Gm-Gg: ASbGncuxT1JD7E8G3YSKH3mNiehYPdTcwUS6MXcK1yWlMHRLgMQJ0ihcglvLPGlpTNa
	w+CL9O/E5RhQA2wgk98h7RA89vpApW6LyayaiVjVdQ8lFpTcnZnpByQm9Nc+D+++lGrg8/vIHRv
	+s8Km424YgztDmOgXemAY8/UIT1eJy1DDEzC0wguFDq55gN6pBupCjYXQj7P6sswSFTAjWwarMS
	RUndDAXgXvmRMsS3n1tR3iy9+HECoDkGIFFxLMUKSdzzEXoEs54UpZn0Qg5STNzM/Mgz5Dj+qqn
	tsybU9BhjLeeFqBxktOP0CyVXx+LdjQqopyeQHNDeKSNc+CqLmrj2vBRtyjpPDfRJF/Y7m+WwwH
	ZsvaNuSoyMw==
X-Google-Smtp-Source: AGHT+IHq4HFg+wW2NxV7FyzZ7xuP6nWgp56QXETkJ4YibYL1iSdipmDyFheG7p+JSKSKwk+eVcSTrg==
X-Received: by 2002:a17:903:98b:b0:237:e753:1808 with SMTP id d9443c01a7336-238024b07a7mr97006515ad.20.1750810028558;
        Tue, 24 Jun 2025 17:07:08 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:9b77:d425:d62:b7ce? ([2620:10d:c090:500::6:f262])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-315f5437a26sm220170a91.38.2025.06.24.17.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 17:07:08 -0700 (PDT)
Message-ID: <0a0d453753b8bc24e939cd6c86b90919451ed1fe.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 0/3] bpf: allow void* cast using
 bpf_rdonly_cast()
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev
Date: Tue, 24 Jun 2025 17:07:06 -0700
In-Reply-To: <20250625000520.2700423-1-eddyz87@gmail.com>
References: <20250625000520.2700423-1-eddyz87@gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Messed up the subject. This should be v2.
Can resend, if necessary.

