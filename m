Return-Path: <bpf+bounces-57774-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 470AEAB0133
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 19:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DDA61BA48BF
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 17:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9195C286439;
	Thu,  8 May 2025 17:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qc7sXeGe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CE22857DB
	for <bpf@vger.kernel.org>; Thu,  8 May 2025 17:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746724709; cv=none; b=lh3tN/am7tJkIPhWjoysG7jWLYi6HNxGDiZ07K0HQRceayz3cy869+Gh8UFJQa1tZfk2ZHinj4TEnHMU24qtY4e6wL0G/rv9gaWo23X51bTdR+dvcbkShXwWiXKx7Nt6Nn3+/RWKn/jzKW7B/VItzQvSkuuDAEbFAq//PPrvciQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746724709; c=relaxed/simple;
	bh=HE8TRSvFA3HhTCthoL6NLbaTdhlJClwbkdTsmBtcveA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lg5XdFCXB2kPu6UUJsiDQYaAOygbSVmKJPEAQrwsNC6sHDLVvbTywVHiuNLoE/tvDCxOYlMPujPkK52osGBVDenV75ZcnKXUaoKtkA7e0uKtav858V/Ju/G+VHIp6zKMgN3OTcQaiGqzOxMyx6eyVvGt6VqyuZcjho+nrladS84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qc7sXeGe; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a1d8c09683so290097f8f.0
        for <bpf@vger.kernel.org>; Thu, 08 May 2025 10:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746724705; x=1747329505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z5t0c0WQs4dd6GTjzNN9izSd8ZyS6dC5eniHhd9VVaM=;
        b=Qc7sXeGedAWvpbxukttCiWZVYYLXY4w4LzbXzdXqleDuGdptbOCWVjPrDHrzvgO4aM
         o6KoK2ymzjsHUNYeIGEJpiC6qVpQpUjxJVKN+OJH+eSGKmO4vxXV56ynyTjIpQqSxiDo
         gL1YKoIhuaCQLMpBP5dNz9OASof6MA2OF8V3ebya922cP1NiiutrVueG6rtR58TFUrlx
         zM/2CyiTzkQvCegQjF7V9Hb9uu/HsBQj9gh/0y1+6rWL9ZoAEJYnbp2jmb1w4dQkRyGI
         VI1TWQvnnzFE+sIAF0joC2g+IW34XrZbVPBjZbCQ1UBF+ecAQjMSDW1YvaOPooDKVzAd
         YGGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746724705; x=1747329505;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z5t0c0WQs4dd6GTjzNN9izSd8ZyS6dC5eniHhd9VVaM=;
        b=PBs5c9fx2sW2rfwVzXYw+FZp/nStwbRI3nRweq+KkNYz/lEFfy1/RgEayN9x+yXeAh
         trzXej1lCB4f86Qs499Q1CEaxnDumh8AlVtH8LGiHoMwA+H5DneXRgcHv8ej6hLM6KD3
         o8k61DJjlidSIqyT9DMsYRVAKZDawaFplyiACiiHey61FZ6VvJbY3RDe8qVGNWRyLMXL
         bDR+tTwgU85AwUwe4KTuXgKowWGaSgy1baPsMV2Q1Za6G3dueTTMvq5PsWzPZ1iTEnW7
         SGzWuO1HwS3IUPO0bRJF64rhf2lTQlxYTMtK9C73RWVTMRa2L4HT0tM8vbUtUq9IdRzY
         AwIQ==
X-Gm-Message-State: AOJu0YwNXbiWzdJi17Td0dNMZyJKWnqgeL3AkxiTQx/mRFP0ACcwRrpx
	ihoFIHwU54LPBHPFXIzNrcS9r5AifSNPJrvGXMj5+87p4C+Nk6At3E9YLw==
X-Gm-Gg: ASbGncvB5dq1rZuTSk5MyIF6PO15JvHEezqCJm/RU2s9zQNC4UGGjvtO1U/ied2bFb2
	C0XUbUzANAnzikvYXHVxkK7kH/NlY6Nbd6ToImxmTIiN3bnMLePARxKP85OjKpsCr35qsF6XeAr
	CYjOjEVauYSAIJB0vPh0Hs3f0NitinM5ympUEZ2oHWSxinwrU/zR/pEtwGPf0/JHSgXPZjaLsah
	+TTyYmBzWtLUWiGfJHO6NWJFFxToKPMQpJKFN9lumQ1sq6+mYqkLeCUyC4PPApZI9aWOf0I+NrB
	/v6AIka5t0ABHPJQnK/P40EszwW1TFXWw64lrI7FdnlDiAOBVMLcNJcku3I=
X-Google-Smtp-Source: AGHT+IG0eFBnLgDbULhdmrOrItwqERxKa9jchFq7dZfMTjrIxROObUcw0jAfSWdbNzEJSje1/kaNfQ==
X-Received: by 2002:a05:6000:22c5:b0:390:f738:246b with SMTP id ffacd0b85a97d-3a1f643112dmr335089f8f.15.1746724705423;
        Thu, 08 May 2025 10:18:25 -0700 (PDT)
Received: from msi-laptop.mynet ([2a01:4b00:bf28:2e00:ff96:2dac:a39:3e10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f5a2d2d3sm528261f8f.63.2025.05.08.10.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 10:18:25 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v2 0/3] Introduce kfuncs for memory reads into dynptrs
Date: Thu,  8 May 2025 18:18:19 +0100
Message-ID: <20250508171822.152266-1-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

This patch adds new kfuncs that enable reading variable-length
user or kernel data directly into dynptrs.
These kfuncs provide a way to perform dynamically-sized reads
while maintaining memory safety. Unlike existing
`bpf_probe_read_{user|kernel}` APIs, which are limited to constant-sized
reads, these new kfuncs allow for more flexible data access.

Mykyta Yatsenko (3):
  helpers: make few bpf helpers public
  bpf: implement dynptr copy kfuncs
  selftests/bpf: introduce tests for dynptr copy kfuncs

 include/linux/bpf.h                           |  14 ++
 kernel/bpf/helpers.c                          |  22 +-
 kernel/trace/bpf_trace.c                      | 193 ++++++++++++++++
 tools/testing/selftests/bpf/DENYLIST          |   1 +
 .../testing/selftests/bpf/prog_tests/dynptr.c |  13 ++
 .../selftests/bpf/progs/dynptr_success.c      | 218 ++++++++++++++++++
 6 files changed, 449 insertions(+), 12 deletions(-)

-- 
2.49.0


