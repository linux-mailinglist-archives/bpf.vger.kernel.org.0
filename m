Return-Path: <bpf+bounces-52677-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B81A469D5
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 19:33:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CC533ACC55
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 18:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D5B22B8C8;
	Wed, 26 Feb 2025 18:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HIiPxydn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27BE19597F
	for <bpf@vger.kernel.org>; Wed, 26 Feb 2025 18:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740594734; cv=none; b=ZVh0ZzG0+rw2M1FlU8pwLQSr0b22e1n6jPlpZKhNwpr+IoJe3TK7T924neqmkf4ujvSGExGj/cXkqlZjPaCmgnVTeWwf5xn6KlhXxf8fQ5jnJKnZ8Z437rN0ofslqBOxJPhrlYUjqq44T9G/MZyv1XIshJr7a+NGAPQyPY+vrtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740594734; c=relaxed/simple;
	bh=jcCTI68joep0ib8KPvsgStE0kvt+usYByTIw6uqy5ko=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dp+mFhlEvDla//Wz3364XIzEn6HfjKB643Jbcmk16TX4RfF1EQFXBiacBi4KcJe8aC5dlX3lcigyA6wLFIP932f+0ao3sHuCB5baQbDY9eCwSqSz/hSxDbJRrpzZAz9JnP+cpXIaEd2RA1fRz7zH/YwGUfUx+o/kcVYVnVI6ehY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HIiPxydn; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-390d98ae34dso18648f8f.3
        for <bpf@vger.kernel.org>; Wed, 26 Feb 2025 10:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740594731; x=1741199531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RKc5FWe9rIRUe5KqVeN7p5KLPMx6Xq8hW1SK3zAUxhg=;
        b=HIiPxydntLVIaieUcMUoDvRqDknk+YbIErHxdrCY3mg0tOmWhbUTW00xa9MnfA85yD
         rYSxhDhBnCH/KtXbA5cQdU7CWkLWKCukePbUUDs0T/YJQWIkBT+1pVp2/gR9vflt3m7V
         LLZ9zWmDoUvimYIdrU0h/rlzUayw/sRqes8c73UgqXpyH12UP5grVImy54ZCw/XaHo4g
         MhjxJQrA2sSasqsWcRRDNhPjD/ORE95dz/5AGiEZAM3gmimxZbGSZnWw2bTpfIopcEHM
         4bAPi/7iRZ/xI7YBY4pzl7mScVbM0akVHnLxRFC6Ot4OEqlb37kYf9Hg5Z60p+qw6xuc
         ySvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740594731; x=1741199531;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RKc5FWe9rIRUe5KqVeN7p5KLPMx6Xq8hW1SK3zAUxhg=;
        b=lXuJl0xG8b/wUfR99zX0laU32Q5L1JoMZSjxHkD+UxRrMNVlDW/iYOEs9rSxcgTNMI
         VQw2hwtMqcecQ4InpU/Tn7Y61kPNAALoLpRheE1vucP0igrRnhFuXMuF1/UgOUIDWPKZ
         O5tPnJWGCuM78ngWB819koSSJLo+Yd6NVHKcXgXdXHSdq62+mpTqjSjjN5ewo6by7ZI7
         oXnqNf6sjleRPmAzDOTAdD/3JnAtgp+zQLGQXQQ1NXswZAbZrberRC0dwqB4K1SJuW7e
         oYJOq0Qxt7BkqnXIJbXXZwBYjcr51qyvWV0zklUGLCohv9gNUkgNqVqBeO+0/x3coYvm
         khPQ==
X-Gm-Message-State: AOJu0Yztp8EfUKLkoO8gs3Px3qd+eLx4vUH+1ssRQ3OkRDg3jm/PPEQz
	xZSgqHN7YFW8SW3AxE/sD/GI1Z35G3zkXEGb8VQDoAhFuda9h/Q/T+9oUg==
X-Gm-Gg: ASbGncs5zzqfXacDjB0ay+fxz4DyRl2UJTmnmLXSB1XyIkQFlra/7d005IQvICmOhF+
	Wlxht3pmeFnFAPiMcsWeln0ztcrw99f2gCur+4QILPg1hOSFYxUpTa57c81ua2o1Evdz1Sy6yxf
	l26QqK944rpJN8fBs5h6+zVNDZoEPC899/Lfn8aBQ/viOjEoyfmT4ERzOKsApkKikpPD+Hlac6U
	CuAtMP3R7mRDPq/U9sn4t3UC97G3Z12oJtehmpOzLgGHqWG5oMiVwylMvx8Rf1CGm4LHFgEeio/
	/o98kBAIvACHlwIPPDsu+YY0IoZzntE0HjjC8RZWcybX6Xxmmxm7KAgNok9AmzppZ6AhimYbpSy
	28oQpRgKAPHCpAoZDVZbROlkPtEB6FCg=
X-Google-Smtp-Source: AGHT+IEYWcrhcCb/BuCpRPxfR0Lec9vOFPrnC7yVlAWjyQHxFSbooW5bWDBry8JX9GZuqU5KKo4FjA==
X-Received: by 2002:a5d:64e3:0:b0:38a:8ace:85e8 with SMTP id ffacd0b85a97d-390d4f8b6e8mr4585819f8f.44.1740594730943;
        Wed, 26 Feb 2025 10:32:10 -0800 (PST)
Received: from localhost.localdomain (cpc158789-hari22-2-0-cust468.20-2.cable.virginm.net. [86.26.115.213])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd866afesm6520531f8f.18.2025.02.26.10.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 10:32:10 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v3 0/3] introduce bpf_dynptr_copy kfunc
Date: Wed, 26 Feb 2025 18:31:58 +0000
Message-ID: <20250226183201.332713-1-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Introduce a new kfunc, bpf_dynptr_copy, which enables copying of
data from one dynptr to another. This functionality may be useful in
scenarios such as capturing XDP data to a ring buffer.
The patch set is split into 3 patches:
1. Refactor bpf_dynptr_read and bpf_dynptr_write by extracting code into
static functions, that allows calling them with no compiler warnings
2. Introduce bpf_dynptr_copy
3. Add tests for bpf_dynptr_copy

v2->v3:
  * Implemented bpf_memcmp in dynptr_success.c test, as __builtin_memcmp
  was not inlined on GCC-BPF.

Mykyta Yatsenko (3):
  bpf/helpers: refactor bpf_dynptr_read and bpf_dynptr_write
  bpf/helpers: introduce bpf_dynptr_copy kfunc
  selftests/bpf: add tests for bpf_dynptr_copy

 kernel/bpf/helpers.c                          |  75 ++++++++++-
 .../testing/selftests/bpf/prog_tests/dynptr.c |  21 +++
 .../selftests/bpf/progs/dynptr_success.c      | 123 +++++++++++++++++-
 3 files changed, 210 insertions(+), 9 deletions(-)

-- 
2.48.1


