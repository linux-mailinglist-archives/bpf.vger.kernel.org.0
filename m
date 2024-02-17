Return-Path: <bpf+bounces-22205-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 719AC858F28
	for <lists+bpf@lfdr.de>; Sat, 17 Feb 2024 12:42:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A48761C2166A
	for <lists+bpf@lfdr.de>; Sat, 17 Feb 2024 11:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5802269DF2;
	Sat, 17 Feb 2024 11:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h4W+Vd9L"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6575A6519E
	for <bpf@vger.kernel.org>; Sat, 17 Feb 2024 11:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708170123; cv=none; b=uiR4wR5yRS24SZKZHsqUJrsq3Z/hit3v5ZIiSHdAW5T4dYULdXlI4jGClMInBH71o2eAc4xhWlUgJTRrTOm45Q16Th8XIOUQFT/PNEV7GjvMxDTwiYivHzNiCTWM7Hx/foDx1zvxLcz//s7RT7B7g+DmCC+HsNNzbo+jfRLFTHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708170123; c=relaxed/simple;
	bh=IrVZoKGcX2ihS/UEszm6E7TUle/PTKNdRuHoS8IkrI0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HqyljAV50YyWkDcZceH+a7VenIrm0AhMrfFOZ/1yRXybHLQutN4NzO3HGXqnHsXJ2YnHCMRZpdoiEW/NUr79JXEdKg1tpeBtC53f0WEdB4Y7vLLX9HpIL2+dl0L8rKv/pi7rPxQ5z78R+kQa0n8PtXr7wRStMX9A7z5VfaasKzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h4W+Vd9L; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d7431e702dso29074395ad.1
        for <bpf@vger.kernel.org>; Sat, 17 Feb 2024 03:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708170122; x=1708774922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o+KQXclFWq5vVUg/PZ2YPu4AXVt6a+zncM0AZC0DXjc=;
        b=h4W+Vd9LpH9XyCE9yDNhHaY67S0IFUXjNpaEgJrNoXhSavSwfAVgy/L5T/wtHh0tp1
         Jcx7AK0nzxf6pw93AU+1n1k1idR5tYqdXuefDpVOPe8YV9jrzjC9MUEixg8LAo1FufyQ
         JTm4OUd/6jSJYmVKZiIrMnD811Vq31bS98q3ED1z9q17+DozyLVIuYWhDKUeHHnmeww4
         FjAKbt6RJQL5o0ySfxKR+cHT2jRS7/vDLYlY6cuirnS2+PjMW5wFWvP163OkEA/PutA3
         gqJshEen0hkfTu3b72TC0IFJaiePP7lz47lvS//YDg8Exjqlh5rgE3hLY7Pc7YpcWPr/
         TDUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708170122; x=1708774922;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o+KQXclFWq5vVUg/PZ2YPu4AXVt6a+zncM0AZC0DXjc=;
        b=Z79h9fN99lvr2zUFdpK34yONl31qZRDfE6W69jnW2jkRlBgJ76xc9d/dYcGCK2bmk2
         e1XqFHhaMgIJM0kuhzYdo4HTJW/eqJM+acOF7ZZRydY7NMhbaXC71juFnc5aO+tm8W+v
         hjgEq0WdZXlCqauW9JRW1EsjThZgGeCjVt1Xg3CRdbL1fd1EhS3bFCKAYP+W94Rm0Rqw
         HhTqRhXcUp1/rSVu/StyxWe/pT/+Xpb1WNyAZ9Kaky5F2cOjE2PgtJ/S0fRFYnaZZHvk
         RhAzi30DYgJdyW59SA83zw1uS2D6dTWvn4K6+maBubQ2K9KXJp4br1M5X/7cxk0ZVyI+
         crXQ==
X-Gm-Message-State: AOJu0YyMj2E4BHqwTWQPrT/TFSAacdo8eDcuW3p1iz6QmuW/6A2dG/wO
	KQK4e15C1bthKSmv6XPXYmIdOiOZ0vNqC1ZIkdOrIjXYwsU6CNaIJxC6CJ348FXcuKjB
X-Google-Smtp-Source: AGHT+IE1ppIlKpxCP0HTS53zO6HcTUu7fEavoBnQ7A1JYToBzUEDmKfacYlYz1cFBTH/qHPGjIHNYA==
X-Received: by 2002:a17:902:d489:b0:1db:b36c:716c with SMTP id c9-20020a170902d48900b001dbb36c716cmr4012690plg.55.1708170121597;
        Sat, 17 Feb 2024 03:42:01 -0800 (PST)
Received: from localhost.localdomain ([39.144.45.19])
        by smtp.gmail.com with ESMTPSA id m20-20020a170902f21400b001d8f6ae51aasm1307201plc.64.2024.02.17.03.41.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Feb 2024 03:42:00 -0800 (PST)
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
Subject: [PATCH v2 bpf-next 0/2] bpf: Fix an issue in bpf_iter_task
Date: Sat, 17 Feb 2024 19:41:50 +0800
Message-Id: <20240217114152.1623-1-laoar.shao@gmail.com>
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

v1->v2:
- Correct the fixes tag (Chuyi)  

Yafang Shao (2):
  bpf: Fix an issue due to uninitialized bpf_iter_task
  selftests/bpf: Add negtive test cases for task iter

 kernel/bpf/task_iter.c                         |  2 ++
 tools/testing/selftests/bpf/prog_tests/iters.c |  1 +
 tools/testing/selftests/bpf/progs/iters_task.c | 12 +++++++++++-
 3 files changed, 14 insertions(+), 1 deletion(-)

-- 
2.39.1


