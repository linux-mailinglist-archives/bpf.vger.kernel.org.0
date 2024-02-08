Return-Path: <bpf+bounces-21488-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1614684DC6C
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 10:09:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4850D1C24239
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 09:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8106A8DF;
	Thu,  8 Feb 2024 09:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dowERX2t"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3DD67E74
	for <bpf@vger.kernel.org>; Thu,  8 Feb 2024 09:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707383368; cv=none; b=jKB2VFMxw+NwJAerzaJy/3E62tazVaZBqccNUi4Y04ENFrpxYy2xIuwIlTe/JAdLk4K5YswRTpL2X0vOGzGUG1JY703bTjte620OTcZwInvxrcHAX0rtuhvryA2lRJ8uScQvpa4yB1Rg7qRM37THmbOfGpAxrKuE0H8fw169S8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707383368; c=relaxed/simple;
	bh=86XAcE42jdD0XhmGd+T7IrRc/SlKyS2LaVCoq7OwEGw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=owpHCFH52/rEPpkfbVFlf51z+FvTUHZzSYZdImZ3UEt9dFwOX36EWmXJZNuYy/lr/IzIUeXpF7h/h4J+aH9pH9gOINQFg4ioKev2aarCQw8FQhV7C9eG+Sutv7QdohoT5IVy+9kkQtBRAaPhL5wdkWmgkvgbaJ0IvknoEXF72dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dowERX2t; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6da9c834646so1264975b3a.3
        for <bpf@vger.kernel.org>; Thu, 08 Feb 2024 01:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707383366; x=1707988166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j9bX3cbyb07HOyknW+SgFa/3kzG7jmbZ2HUI2pNkL0U=;
        b=dowERX2tgDKr12ucVs8kxjiRaHKGR6FOXwkmrkpUYhXMu/fzfW3enVIc70bYkCdr7e
         Yj1bx8RNSViUqSTOR1cNf+wkU28CKZ7aLjKv6rClVOZf/pbDPtD5XjeQoUIED9ZqAFbC
         DZyEYHKGvnXX1s/AQGiAyvPzHr5aheD5NZ5p4ZXE4Oe4PQQlEc4On3mf5LrROAwpg/H1
         XMHMUhkwx9tFfsCr3Yl5pRQtn6Syd7VayjhUBE+D7n9Re8waO47WskZgZ60GnIdhFDdE
         YDMCgNAp35mrO//oR61ia34sHARBnptIvhn3q4RUU8B+4yCtq8RZHBnWVCv6GbX/RM/L
         v92g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707383366; x=1707988166;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j9bX3cbyb07HOyknW+SgFa/3kzG7jmbZ2HUI2pNkL0U=;
        b=szqL+cxN8tqxxacnRyPBPI4R/0xZyq5/O7rMSb/o3TevTMQjmGRUd7lQqd31fAWYUs
         u+oJbHd0R2/XMpEaUG6ls7yfwv9CRA2jvx6vw82U1ZvvPJW3mIvOGFSKLXUmPffp4g3C
         JUK/hfR6Y7rMV4KRWeqH1Px9hN5HdvwZL1vnOq7B5qv9L8N5C/2gbUr/cIeKrW5zJXBJ
         wrWH5Op2qiztlyDfiLgGNBLXrQx3dGAETvczSVcGGXXfQvs2WtwvN0FKZQtxWEVQpB+X
         9CgQcKV8tr0nmabN4eYZqBBpNS356UEQje5Unfaqkso/v9paazyWdTmjlKL50kge9ZQM
         aoWw==
X-Gm-Message-State: AOJu0YxghBZexR5zHdmqpSL4d0DRrL3jaAy/0QVNuua5hYyu6GUe6k5t
	Gw6nfysRmHi0zQA+6nk9quWgR7fpZA86fzb1vw9h7D5OqwR+vqmJ
X-Google-Smtp-Source: AGHT+IHuBPNTg4dH8H+KS6F/Y0DUaMkoJB+qeGCxw3wAoptwdd504mxZ2yQEd/OCNmnFYF/wqEQWUg==
X-Received: by 2002:a05:6a20:d489:b0:19c:b0f6:25c with SMTP id im9-20020a056a20d48900b0019cb0f6025cmr9054471pzb.45.1707383366000;
        Thu, 08 Feb 2024 01:09:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWvEPY9zyxEGW1v5TxtWYaAZ6FbK35lTmwmjuUCwe473oPVadrweMhAMMJO+QZyb1miapnKz2D2nQMcLvKiDbm5yyU1mFcOlmUxwXDVbq2EvBKcxqP1Kpnxrbr2tqMUyrRQzuiI99SOwWrjv6tBGSXrwdGiqswBV74pukskm4T5DDxDcqbpl9XAi8eC6K61nBzVuA1ZoZyFisQQrw7lfapv6aXlZ0V/1+W0dkGi/ek9a3MM10S2gMKpWEmi8U2RTuOUE9ESm/YA1C2Dhr9hLYxx4yw9eEHUQqop7FOQCmH0KLk688ddVeXXdxQVaYQ4pCPdP3dkhUSyMu9l3ZVtuaV3rLDwTUj0XYCJOT9RIHmozr6wTrjeE3tx6v7XhmegTzUqCFQ=
Received: from localhost.localdomain ([39.144.103.18])
        by smtp.gmail.com with ESMTPSA id gg18-20020a17090b0a1200b0029685873233sm952361pjb.45.2024.02.08.01.09.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Feb 2024 01:09:25 -0800 (PST)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next 0/3] bpf: Fix an issue in bpf_iter_task 
Date: Thu,  8 Feb 2024 17:09:03 +0800
Message-Id: <20240208090906.56337-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The uninitialized bpf_iter_task variable poses a risk of triggering a
kernel panic. To fix this potential issue, it's imperative to ensure proper
initialization of the variable. This problem surfaced during the
implementation phase of the bits iterator [0]. 

[0]. https://lwn.net/ml/bpf/CALOAHbDJWHOB+viBz6SUqdeF+Nkxmh4gLZo5Ad_keQXjBWHAsQ@mail.gmail.com 

Yafang Shao (3):
  bpf: Fix an issue due to uninitialized bpf_iter_task
  selftests/bpf: Add negtive test cases for task iter
  libbpf: Check the return value of bpf_iter_<type>_new()

 kernel/bpf/task_iter.c                         |  2 ++
 tools/lib/bpf/bpf_helpers.h                    | 16 ++++++++++++----
 tools/testing/selftests/bpf/prog_tests/iters.c |  1 +
 tools/testing/selftests/bpf/progs/iters_task.c | 12 +++++++++++-
 4 files changed, 26 insertions(+), 5 deletions(-)

-- 
2.39.1


