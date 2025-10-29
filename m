Return-Path: <bpf+bounces-72844-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E659C1CBC8
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 19:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3F27B4E05DC
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 18:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A70E34FF65;
	Wed, 29 Oct 2025 18:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cAQOYnU+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026D93002D5
	for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 18:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761761917; cv=none; b=FsvfTu6d+qfKb4XSGmMi36hH2yoF0TG6ft1Ei+KVDFoAsAkZVGh0DSZVz5rY+pEY2bpqc7CXyzmXUsVqiB8DIbRfb+71wXaKG6I0nqlb+hUm9yYqspdYOb2/ENa1RkofCfTtU71OFyTeTQtgrKkFJTOMk8i2UjLU4/fREwaeUms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761761917; c=relaxed/simple;
	bh=aTeVF3oOGj0e3xvPkSu3ZWajjuStq46hmtcGfisJdvg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WQfK61axpuYGnzsQtAAAwUz1HOprqprd3Hbh6bNqc6Mwt+GHB6PoRIZoMs3e/Q67F20eik0MFA6Q0QAuEZVPcmR2Ay2btPAGlpVo5WM/cTXL0/mFtsByQhTcWsweYPqWLzoIjEoo8YNKYrO6DyTBnRoWPfzm8j/j8LvY9IGykeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cAQOYnU+; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-4710a1f9e4cso1290745e9.0
        for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 11:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761761914; x=1762366714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q8e62lxN6BFa72nFnPJVCn/PMcvJKcYncd3Cw4/VUwM=;
        b=cAQOYnU+8meGxIHMHGkhMGMnsPDZzsiS/N4eZQ95fdMjUaG3DmLd/hyZ6DJidsZe8e
         4OXPpSVOsUcf07h81vRloBAaCSg2sztBBdc6QpYgEcCCVVhNlyYvDAtEHqsyyO0bOnz4
         1wZppItL7PMMJ3+PmOKklmc89WORo5Oq47Uw/cw03E8s0rpKHu8IDaFirIoAN1hanyl/
         x1Ty1EcUfJOwJGSfC/tgn0CjM+AncwG0UpudkYjs75Sc4bLb5xKyDorQm+F+Ar3yJeWs
         EefY0DAXjfTpgbrE/0PkS6I5BJ02hiackwalrLkpZmAldCi+nGqzQCtAs+e79T/ktHtx
         dq8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761761914; x=1762366714;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q8e62lxN6BFa72nFnPJVCn/PMcvJKcYncd3Cw4/VUwM=;
        b=ItUVfrYX2Z3bOsrxDsmsWIAiK6VzWdh/PVJHp2Bbar1Xye/pe38oCpJfq56SvqTGEV
         0Tchc6wF4O5JVm8OQ9XV5s3npn0tlSiG/ipPZk0Lojx47NuJVCzGmtojkgy4VSSDObeU
         Bp084HFaO9C7Rtm5PESO+E6KHqsRD9NEPlkwvxreA6dX5Cw8xkV8k5e40PH4CwKHPyTf
         bXNWrbKtOA0BP7678dDgpbzyLW19aaNcvuJtlSNfx3tIDcWeNnWej8TNi9/E/yzA/hwH
         edUlfejFxQsvnpfogeCzNgX+2J/fcBZhqei7Tsp+YcxMS5/g2tP7LrCrh2LZaXojE53p
         Snsw==
X-Gm-Message-State: AOJu0YwXA41kr1v9prHPujqs3vLacCy9+zu+9Wewe/EIzy4l19qtqY9B
	VkXPrfTkZ/v96eQ3XTeVm9afwXG4GFByHpXK15k2VqohqqcNnI4NN9QtNRO+3tYG
X-Gm-Gg: ASbGncv9p0TZaSl0erVUbQqf4yNK2MBIe+w3AftzSinUxj1Nj2kRWDnbCNNQoBHUMPX
	Tk7ZH/WE1iUhBzfHngO+piW6UTyq30jXXks2CyuP5ExFLY4ymtHngwecR4knGm75SdpL88S+HNQ
	rc7PqfiHxxF8E16ag7Wd+XT7EAICohav+QrwPgajwwbviioEIP6Kg0PDkvB0xytOZNFcIlut0Ii
	4rXPgjUhCkDrzJdP0LVQHfMwrxVyvBJruML5hmDbF+wxAq4ZXmjUDT2cFGuCtHJBeNDz7/HYNoI
	DZ8VAJvkAV92QAdf82Pe8UpJ3Xg+pGe1OE7Pg567VKdIMwZLOqdi017Tkm4CWs6NjYDahKpK3wY
	AFubeH2ZpF9P98Zq+lHqeAgMQnyxTXCntL/P5uBmJNnGGT7voBl8sqobA93YZ5TGQq539ufcgie
	ZeVxGLrq+fZmZMZOOZp0BoSjuZxIx2FFJiouNh1s40ysQzmSmkha47Rw==
X-Google-Smtp-Source: AGHT+IFAbMdKwb7s9NbAvg6c6PqfWB9uBSP8W00rSRAblHDammuWOGfxs1HN+DCJlCoe+AGJsenohA==
X-Received: by 2002:a05:600c:1e1b:b0:46e:4499:ba30 with SMTP id 5b1f17b1804b1-4771e1ed66emr38821585e9.30.1761761913796;
        Wed, 29 Oct 2025 11:18:33 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4771906714dsm47146135e9.13.2025.10.29.11.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 11:18:33 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 0/2] Misc rqspinlock updates
Date: Wed, 29 Oct 2025 18:18:26 +0000
Message-ID: <20251029181828.231529-1-memxor@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=779; i=memxor@gmail.com; h=from:subject; bh=aTeVF3oOGj0e3xvPkSu3ZWajjuStq46hmtcGfisJdvg=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBpAlY4xkCnjwNej2Iez7UGK3YbeUBnmAA3HI3Zz OJ9SD1yBrqJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaQJWOAAKCRBM4MiGSL8R ygr5D/4jNsDLCE0BlJXS3MUMlcjPjL+5RK00HStX/BJKToGZpj7BCrWy1rLztENBVNkPHATCxWk zCs6qhI3GAEjix1DRGb0nu3Z0vtjNgULDEPXh1CtTIcJ/in6vZSSDXdUoxAnlVA977rfTJu7a1x ojH4e9zjxC+iwwjQYQDIw/j5o1bsZCbPz85cNH5YXkp0su/1XejbqvQcLk1XqUge350KgIPcJzM nlIMt+jHpfGAadKuYr/uQjqYbaLodoco0Qg8Iu+5hTzcMiWSVe+XGLaG19DaH0VttVjohO/om1F /u7g3oHRL9NNU63tWjLMec9KHIXAwjIg/gwrUiHIkxWqLmj+K1bR7iTBBCIX9IYnIcRdEJnbdX3 CBMEbNnIUyf3Jv+3N/4/czGdTJXskIDPirlCpYK1AttYgwoqySyGqsA9XCpSapF4CX3LO1IsX9Z XeE9SGnvVd1ugAlUAco3Z83qkRmW1lBfFT2LUgQw7qWHdtZ/1keP1az7IRZXag3ozI7fiZs4x7j cRncwKaloU01dOBHsIsBLG0Q+RpWQgDkYV9csAMI5oNoHtdsblHj/Md2Fvo0eF/KFm9YvRO/Lqk 83cslWVti+VsoHCkPfnyahGK8M6rOlYcJrVJw1QWyQ0bm8QoIJAG/xkwopR1tZ+ufA38UCVYzM5 K35WN0F+k29skqA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

A couple of changes for rqspinlock, the first disables propagation of AA
and ABBA deadlocks to waiters succeeding the deadlocking waiter. A more
verbose rationale is available in the commit log. The second commit
expands the stress test to introduce a ABBCCA mode that will reliably
exercise the timeout fallback.

Kumar Kartikeya Dwivedi (2):
  rqspinlock: Disable queue destruction for deadlocks
  selftests/bpf: Add ABBCCA case for rqspinlock stress test

 kernel/bpf/rqspinlock.c                       |  8 ++
 .../selftests/bpf/prog_tests/res_spin_lock.c  |  8 +-
 .../bpf/test_kmods/bpf_test_rqspinlock.c      | 85 ++++++++++++++-----
 3 files changed, 74 insertions(+), 27 deletions(-)


base-commit: 54c134f379ee2816f60130d44e0e386c261dff45
-- 
2.51.0


