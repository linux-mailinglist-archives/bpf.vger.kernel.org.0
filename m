Return-Path: <bpf+bounces-71107-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 03930BE2B88
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 12:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 42C5F5482EA
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 10:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56912E175C;
	Thu, 16 Oct 2025 10:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="amnLWnjS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3AB328620
	for <bpf@vger.kernel.org>; Thu, 16 Oct 2025 10:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760609634; cv=none; b=giZCPKeYYi0fCPy//kROiC1cwRrHNpocTxyDTAtu/00HAETMpybuDWK9V64Dvgv+n3qJNOvJlrO8HXchDGWyKc6UeOCW+ytqSi91gE1oycUmT4ROm87mGVNHVdw0MLXaFUnLzqCigPT1zh7fMa/M1/fSryrPHLnhJL0gqQCllAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760609634; c=relaxed/simple;
	bh=Jl788zXICHJ5acrAZyD/a37MrSRcVADO7fQVKMuIvDc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=X0pZnUDnYYqTOgqN6ReYjZeuWE0Xj4HXCJZe74B9zChWRLxyE57f4ri+9pHPeo7jTO+88dTqVIDrQVxRjRKlWRwCF8mQC3hYRPbofro9N41wP4kxBhJJ3ZTm2apZxwhWDi1WpMn/8QgcNSmdGPyOhkJkmlbQkXhgfqTi/HnxM5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=amnLWnjS; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-78125ed4052so785718b3a.0
        for <bpf@vger.kernel.org>; Thu, 16 Oct 2025 03:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760609632; x=1761214432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jq8OW6TGbxrBXRjrgbfzJXwoQLqOW1xHiJ8eAh8jstY=;
        b=amnLWnjSbbOqvsSnLuFG7s1CoRvBEF8bvBuGqo3mxlP/XaxLuG+QTb6sikwtGcyxNa
         GegbH3fFt6JGPT46BcNXXKNVj4VKjw/lZKhy5BHW07os4eHr+LrRRsZ324J+A3E59nXD
         CeB+tuQu3WHHLXoQqhzMS4Ku3O3VlNGbCEUKLztWqtLrJRz8gFd9oR3axgEcjrYTaIP9
         //GSmZE9LsHKenWR8FuaWM/gX8f+Rx/Ew09lxMISmZ1BpoZhXN1Hnufy2RwwdeW4eHyy
         nM9Wv5WVnNquxmUSbUzVUrB+qgWnHvd3F2K7wJ0BRkKBWOIEzjh+e30OJC7CS5LpVq0T
         J52Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760609632; x=1761214432;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jq8OW6TGbxrBXRjrgbfzJXwoQLqOW1xHiJ8eAh8jstY=;
        b=EhlD6ZV20ksyHGUetPVwSM/dDoMko3zi3Q0Of93Bjc0/LoaOe1b3ltSjOiHaYIZebF
         b8ScUJ5z78IJ8TuymCUvwPLHK7d7hOWcVSTR7svJ/2syhkFkk0Gqc8t39urM9pAcJzFH
         B+5kjiH3K/St1+E3rUrxTvqaJwya4Lgs7peQRoLzJr0DKYOyQTAWNOUlgsbjZFAVFUNB
         PsUd0EC6SzdsxjJuclAUt1UvWAgnFLraBBppK4NzYhuo38TJQ0LmkckH1KoQQ9ipqcK+
         3l51HOJ8IZ88PX0+Uv2fZtWo+dgpuDkxQXSqGjeDsDJbyyeBd09S0pqRAyCyz3hqsKaO
         EWFw==
X-Gm-Message-State: AOJu0YxrTKpY/T8xXpZMkcCuqWcrrAICweRXRY7aPkmdIAZz/ptah2v/
	cB8D1bmONJj2EwD9oW0fTxxogba5BDzRwnmZ7VnjNcDpuGV+kRg1mDWMAPhYNhDf
X-Gm-Gg: ASbGncsjkFcs4rESHll1TG5ARvBQzu4zy3G6mWRRqlOmgxjYvobsiufdbKWVFQjUKlW
	eBRIRee1esWbbbO2ZsBv3keU7EKrD7S4Jv+ll159HfNdcbELtdgyQpLnUawH1I/WXCZbYNqqpoz
	/ZNDLhacFtl7FDbG0Uxpdqic/cCE7hAwTDLR96Pu967gL/3ArMvyaaP1DeHxhbiSD77zBkKOlkh
	QgM7pLVOtoaXyog/H0kiXWJOzYyxq854rAcv9hOSK3B/iMyOejeUGqjYxCV5AHOrm/gArSD2+Ir
	m4je6ObrseS/kjj4urx9rjJzXTdMlkh/S7gukIl0TyymnNnlPWzfTcm4FGp2Ax3Liqi23OFEFlz
	Rcw5jQtzU5XQUuNo/UyvEA/hsyQVFBMgwxAcEP6ahvtxUtGjrxdtce5Nj8ZbENDi1FetyCstSOA
	==
X-Google-Smtp-Source: AGHT+IG8QZYlL4nYUg/eotHES9Ezn/ZamnzArtEteyIfhrKsS2XovswaFPXwaQddIH+JOobnNopYuQ==
X-Received: by 2002:a05:6a20:6a29:b0:2b1:c9dc:6da0 with SMTP id adf61e73a8af0-32da845f7afmr43305814637.46.1760609631920;
        Thu, 16 Oct 2025 03:13:51 -0700 (PDT)
Received: from Shardul.. ([223.185.43.66])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a2288bd55sm2354263a12.9.2025.10.16.03.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 03:13:51 -0700 (PDT)
From: Shardul Bankar <shardulsb08@gmail.com>
To: bpf@vger.kernel.org
Cc: shardulsb08@gmail.com,
	Alexei Starovoitov <ast@kernel.org>,
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
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH bpf 0/1] Follow-up fix for potential error pointer dereference in propagate_to_outer_instance()
Date: Thu, 16 Oct 2025 15:43:41 +0530
Message-Id: <20251016101343.325924-1-shardulsb08@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi BPF maintainers,

This patch follows up on my previous submission:

  [PATCH v2 bpf] bpf: Fix memory leak in __lookup_instance error path
  Link: https://patchwork.kernel.org/project/netdevbpf/list/?series=1012189&state=*

During the review and CI discussions for that patch, a potential issue was
identified in propagate_to_outer_instance(), where get_outer_instance() may
return an ERR_PTR (e.g. -ENOMEM) that is not currently checked before use.

This patch adds a simple IS_ERR() guard and returns the error code to prevent
dereferencing the error pointer.

Thanks,
Shardul

---

Shardul Bankar (1):
  bpf: liveness: Handle ERR_PTR from get_outer_instance() in
    propagate_to_outer_instance()

 kernel/bpf/liveness.c | 2 ++
 1 file changed, 2 insertions(+)

-- 
2.34.1


