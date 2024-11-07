Return-Path: <bpf+bounces-44202-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8EC19BFE95
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 07:38:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AFE71F23DF0
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 06:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE1B1CC16A;
	Thu,  7 Nov 2024 06:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OIM5CJnz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C4B194C6A;
	Thu,  7 Nov 2024 06:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730961434; cv=none; b=qc2CSIENd/JTdmFBFZ5ykxap+EHnzwVVA/vWGp4Xh7ZJPvQLOzJl0ZL6/KvaaAKqguN9A5WUrUu/hNYJd5xFfdIPBScMcwvVz7vZ/ce1NtlUr3O9q3+FsdyYSqph72AA5A3YdhQJY/nYVAgxr7tnUmdwOv8rz9jcLsDOOYQornE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730961434; c=relaxed/simple;
	bh=AefW8bsaSt3rDRVGJf+8Zsu15+j4HqVp75JUKe9nL44=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BTgsMf8Lgf1/ROAAXBkb5WraOE1odZwGzXLNx9jpgHhza83t/DZbhn0d8K1tD64O7ekTOi2D5dzoQp3tazW+3XboA9byzBhfjAGvqbGLy/sl4UBcybRuQ6HxNhUSVkuIQDqW/XBBkTD9CGDYZH2ApHyaIbgTaebftwCW5Jc1+dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OIM5CJnz; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3e5f86e59f1so399204b6e.1;
        Wed, 06 Nov 2024 22:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730961432; x=1731566232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VbO6aB5fSbhKrtKv66n/69pu6+mqeAhZ9XD1hcKe/DY=;
        b=OIM5CJnzrsWWj+jjp2rR4zzEoeyMvgakGxpyEywKti8RbwXo9aA39Bf1eXVRyfR7hK
         Qlz3TimI7c28IOYxR0Z5YPZ0YNa+RHCF3oLr+gyWl2BKT6zvJOPzxFVy07Y9VT2ggo3n
         rI94ElybzkA083Tnvq6mvh17smD7hA1poKktKr+eod6GJsTgKSliE0ZAeMjNcipVy1p9
         wLNIJT97q13MJkP8GGgOss1BMRe1bYX3uIgfXQPZqVcQjRPs0XjlFjX7PaG3FhmYhh86
         zwn/myIYzQrAS5bnVBp/NEtPcvmR7KzzQJRFLehQcwXd2woD5wFftLSnmVFM8ySzKRJg
         bKFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730961432; x=1731566232;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VbO6aB5fSbhKrtKv66n/69pu6+mqeAhZ9XD1hcKe/DY=;
        b=RoZ+40jyj+2tmHRxXkJdsFYFu1EoT08bw73592P+Rs+GxTWlJznIeF8PX5K2a1UHdd
         9eYhWVa7vs0QAY29NZq9UtviJiBIMNQgHYfbUrazW1Ajhc85TUYOKjCHClqDtiRCa5T0
         PxoR2QBGSa2lF3a5beDJnniLi4QfRdMJY3wo3pShOAKqTeazK5iTXQ95PtbNe3SXFClg
         LgXpkY9H+UmWoQPilrOGwsSRLY+fqdCcnRuWULxjayp2CyOMLSuOcBDA/X0owj4/7NZy
         tP03JgEQiw8Oi6o/uU9JheUYAenucj8MbTw4E1f+04z+KO37GRYx7QLdtlBpytn5plot
         /zGQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1pytsghjG5NyAqxT3P2z3KEjQV3C0GUisQpm9XWWCUn5SY62txuuF8y+hWDiip9rK7NUuEzOmXpK2nHFH@vger.kernel.org, AJvYcCWo6zkjzivEmXUyMalcRngwCIgtb7TwZrqP+TAqo+3+pDh20AB1BOhuSSdItZbfhZBNJT4=@vger.kernel.org, AJvYcCXBsYfQIMY+Im2T4SNS8BZQX2ooC0boOhmmcGkSh/rlIHii6U+rjZPKmP86Gyhf13/klGGjuDHJc3pa@vger.kernel.org
X-Gm-Message-State: AOJu0Yxntndq2LfVec07jM+tY8cM+IlR8+los8I4w+TPH0s1YkRR6ZJa
	h1hFlx7CXAVpPN+aoumXR86CmmQSIoV6NKlIwQHJblt1pnwPwN7h
X-Google-Smtp-Source: AGHT+IGF4lMbiPUR9KrbGhCZDmM8tQUV8/34OZwedmF370vmbPjqFl5VyJ2LhEm1KCCLi5+DOH4kQA==
X-Received: by 2002:a05:6808:1482:b0:3e5:ff0b:e9ec with SMTP id 5614622812f47-3e78d33d090mr1058502b6e.9.1730961431676;
        Wed, 06 Nov 2024 22:37:11 -0800 (PST)
Received: from 1337.tail8aa098.ts.net (ms-studentunix-nat0.cs.ucalgary.ca. [136.159.16.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f41f48abbdsm616310a12.10.2024.11.06.22.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 22:37:11 -0800 (PST)
From: Abhinav Saxena <xandfury@gmail.com>
To: linux-kernel-mentees@lists.linuxfoundation.org,
	bpf@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Abhinav Saxena <xandfury@gmail.com>
Subject: [PATCH 0/1] BPF verifier documentation cleanup
Date: Wed,  6 Nov 2024 23:37:07 -0700
Message-Id: <20241107063708.106340-1-xandfury@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi everyone,

I am interested in contributing to the BPF subsystem, starting with
documentation cleanup. The patch removes trailing whitespace from the
verifier documentation to maintain consistent formatting.

I have tested this patch with scripts/checkpatch.pl and it reports no
issues.

Best,
Abhinav


Abhinav Saxena (1):
  docs: bpf: verifier: remove trailing whitespace

 Documentation/bpf/verifier.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.34.1


