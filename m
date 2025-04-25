Return-Path: <bpf+bounces-56733-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B272A9D3BD
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 23:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09EB43B9A29
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 21:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F374C2236FB;
	Fri, 25 Apr 2025 21:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MoNCXcn6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF69D19047A
	for <bpf@vger.kernel.org>; Fri, 25 Apr 2025 21:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745614938; cv=none; b=WqhhCI8UcGOmxtoULjOezKLjKpKHqYJ7G9PaNmK+3FAsIfjuVV2GECt01zd0pPEWkWhYAlY+Vx0tZ9fEIOoK5s2GjCuzPnPHFzoZb7TRpzxzjnpGmm5JbIRZCaBj5M5AQ93SglnkQqRvOXbsl4NZJEnIPV5tSS11D/pR3MSSPLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745614938; c=relaxed/simple;
	bh=KZKwkCJpZVNf6MbBy+5zsgDiEFNHLBX8BTzolU6D2tI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=W2eA1f8vJ0aDzwSn/wM7WKf5IWsPu5spFiwGoyEJJyleARs3SoGTGIWHjx/nocDSG/GNIJUTotPBmw7NZb+SkwuhrAWORlyAto7CiJZk8HMlhmwJqEMuXuJ7mgZjzuTZTxCi/Y7ANIogM7Km7PjJROde0Ydw430AXrArMJUqBZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MoNCXcn6; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43cf3192d8bso4185e9.1
        for <bpf@vger.kernel.org>; Fri, 25 Apr 2025 14:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745614935; x=1746219735; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=L0sBjGiN0aSmxPy5chTnxD+p5qmrnhePbtvMvpVIStA=;
        b=MoNCXcn6z9gqZPYPO3RTxGlcP4/Zz7w0em5IQN25D12wKHDGVmEpXRG9YCahLN9Nha
         GWJUyQNk8Xn7dbqdTD/t3X9hvq675ZV7SQHG1iQPhgNAIwFFSUw2U++eQNstb6vlbd8s
         q1LYb7w0ShYqktux4SUBFMff1mYtnx9sW6EzyVVEqTgvNWK5SPGTol4A/XUd50P6AunT
         UOPxxvj3pgXsnLO+mM+NirGkA/Zd20w0/T+RMoeFphOO5VPdsAm7XTHPjVPUZdV/ldt2
         4hreJwOfpAWt8CvkFfVJAOAkzJHMmqwQu6W13Fo4w5K4HhV7Revd5CA84CwN8/pzxibH
         FUXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745614935; x=1746219735;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L0sBjGiN0aSmxPy5chTnxD+p5qmrnhePbtvMvpVIStA=;
        b=b81Ts7DkHePZcCsbUvLfBFArAY3zC3IVwi3Yhli/O+YZLde9SalVY89li28HZmpss9
         1aAd0CKDUz7R1CNo8PfFj0rcG7fuXpQanxObvN75sXexYg8MMQEfaYYp4qxd9lK73VFm
         T/2rsjbTH1OpN1ex97DkEWoEAIBa7URK2U7Lk2bCVrZEhoywEIuLNAi72Wa5bai8gR1x
         7BwrBJW49OmGM1lamUIX3crJ5J18jMcLedvTd7hdLffoQL4JwkurSEvmrmIN+535ELzg
         jIh2aVoEce7V9jJChUvFVxSbBXxWKmbyZwSoy8LKeCreJdxE9awa7MXlioGPX3t373nl
         bZIg==
X-Forwarded-Encrypted: i=1; AJvYcCWU4kOkuSNjPLA6nWu6nZDKLWb9FhsXh7leLsvyaKo6Zn6oEC4K8pX7fwdJX1LJxY1Y/l0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFAQJIVMaOLQ/H+xVoDRb4Jc89umZGJGWaKmexkUtC05Z+XM1w
	pHHWEj/Z49HIJGhqMubwk290NJfrYKC2aG0ABrm7CsFfhO0Tpy/m+XywSzBQIr1GeOjXoAk+ls1
	ncuf83ejeJYuW3AYNneNHp0wMXkFLxU5aBKZ0
X-Gm-Gg: ASbGncuoCITqjPwu2k196jMhVQ4lwQzDW7h+4U64jQ89kgeb+Ep16O+G5+ld/GQXq3o
	x6pgp4fiLATsc844dbDgB2ws/TJxWZQ/t3XWw3CRIEsDENCSOU0IlELmTebnv/X5Eo/3MgqCGwM
	GDzpIEv6BUjMGSEcz15ozr76qEgboX7fx+XZJ5yByn4yiz0V97AmA=
X-Google-Smtp-Source: AGHT+IHhfewBD/8ZaYI9xvKFtic87IUGDORQC8sMuQGmHg6O5zs2PXhoNpR3WMfPfJ8eErpHOnoAs6P32OD6UDQVSfE=
X-Received: by 2002:a05:600c:1387:b0:43b:c2cc:5075 with SMTP id
 5b1f17b1804b1-440ad8089e9mr12975e9.5.1745614934981; Fri, 25 Apr 2025 14:02:14
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: YiFei Zhu <zhuyifei@google.com>
Date: Fri, 25 Apr 2025 14:02:03 -0700
X-Gm-Features: ATxdqUHuppnWRBiyUSUJiecJdkhx2t7fTZ7wrAc05TJm-R6brD9mI8rBpPkymMA
Message-ID: <CAA-VZPm4uD5h1FSgJPuqJAkoKFnou4+UZcxXr3B=EScgfK2BYg@mail.gmail.com>
Subject: Regression in backward compatibility of "bpftool cgroup tree" on
 older kernels
To: Kenta Tada <tadakentaso@gmail.com>, Quentin Monnet <qmo@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Ian Rogers <irogers@google.com>, 
	Greg Thelen <gthelen@google.com>, Mahesh Bandewar <maheshb@google.com>, 
	Minh-Anh Nguyen <minhanhdn@google.com>, Sagarika Sharma <sharmasagarika@google.com>, 
	XuanYao Zhang <xuanyao@google.com>
Content-Type: text/plain; charset="UTF-8"

Hi

We've been using the "bpftool cgroup tree" command in some of our
regression tests, and recently after a bpftool version bump we saw
this error popping up that was not previously there:

  Error: can't query bpf programs attached to [...]: Invalid argument

After a quick look at the code I located commit 98b303c9bf05
("bpftool: Query only cgroup-related attach types"), where this block
was changed:

-       for (type = 0; type < __MAX_BPF_ATTACH_TYPE; type++) {
-               int count = count_attached_bpf_progs(cgroup_fd, type);
+       for (i = 0; i < ARRAY_SIZE(cgroup_attach_types); i++) {
+               int count = count_attached_bpf_progs(cgroup_fd,
cgroup_attach_types[i]);

-               if (count < 0 && errno != EINVAL)
+               if (count < 0)
                        return -1;

It seems that it was suggested [1] to remove the `errno != EINVAL`
condition since it's no longer necessary, but the kernel we are
testing against does not yet support  BPF_CGROUP_UNIX_CONNECT, and the
syscall from count_attached_bpf_progs returned with errno EINVAL,
causing the function to fail where it previously succeeded.

Would it make sense to restore that condition or is there a better way
to fix / workaround?

YiFei Zhu

[1] https://lore.kernel.org/all/e7ca0725-9cf7-49e3-b362-93430e3c649f@kernel.org/

