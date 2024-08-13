Return-Path: <bpf+bounces-37029-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BCE495067B
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 15:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4A85B2228B
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 13:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E6119B3ED;
	Tue, 13 Aug 2024 13:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHrOXJtn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517AF199E82;
	Tue, 13 Aug 2024 13:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723555721; cv=none; b=rvgNRmnJPdZoKnwudzLScKf2+ObUCqSJTynsoPN5o7o3mP8R6dlRq5dOq2PI7/mxPZ+lGKXEadtsDeaTSaJ05ISIpQV8zujbsa0Fkw3v+osPag2wmtV210GJjo3MxHK3iawF0F3Vo4PyZP7ZSv0PuNqdRDpFYQu9iLWz5ky/60k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723555721; c=relaxed/simple;
	bh=omIJfKYw2egwVmf5lbet99q1zMk5J+CI0zdkAO5zrK8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SpubVeGWHIIYpvej4gGHB01I18nshblMMF6PJTpygbUiRzndiBbCZaC+BrbZ0d3TGeShQAW01f9cAJQOCqt0l/JI21ZIP7QVGfbnqsUuHill8R8fhmxmf17GsNU0dh4gS/VDBvxBwqc9Djk5Joj2zn/a86obcCT3fbAWZ52V0h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HHrOXJtn; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52f04b3cb33so10999810e87.0;
        Tue, 13 Aug 2024 06:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723555718; x=1724160518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+ufyp1YewT3UBL0l7saBKEpm/91exDWMVMxtzbazdbk=;
        b=HHrOXJtnk7QrSqaFPrJ0Z4+ViYCCL/W39WD9LhtTV3KY+wupbYlqtevnjpIDAD0yPO
         K5+I4vqy/abWFDStZ8NCUf+I3HL++KkYr4iNFhsr+bKBaeR70CWGLhWLzhfeC/fI81M+
         ss0ZR3bnsm2ilH5E8HHeUUwOQkTyxAQtsZ8ZpeCirKsP+VGJ1DHFUfccrtwXO09/VAT8
         rN8onsY0duyWV8iMaw1isss04lUMZGW0v1Vzosy/jt9Ssl5ix6V8b2vcZDdHndTBImT+
         CgIZaH6bpDO75KtWFLo+S+KU3yObuE9G650RZhhemQIocoCPcwtJrJLVCUdLNsIwajPO
         Drng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723555718; x=1724160518;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+ufyp1YewT3UBL0l7saBKEpm/91exDWMVMxtzbazdbk=;
        b=tyfCbnjxWpF4DHqv/YQ1SZpwxS3bAye/iRsc5iAG0gvukma6i1f5iSsE/kWs6E2dgD
         Pl7MfxGVIQvT222o+xnrPykh2tDDSIduvlqxUWpBoRepf+ec5LEy1XynEyUuA5Ei8asQ
         /5lLWz+PzW2PMgSrnYJKMUdJmSit7/tOqkGjG54DJ3Sluz19/1312OU/pb7EADsXJ2U9
         0eCUQJLBLe53G5jdtBVnSgkahf7vkcR6ock+OlYSAmIyrSnqw9DmOGUm4VZCbhJJvmph
         YLH65wq/GqCQWnYjvZ2ealIBuLLwEJuxuqJGlG67MlcEz+4Z8a28CLULolrywxvwsEh1
         66qg==
X-Forwarded-Encrypted: i=1; AJvYcCXCVzRhl2NUeUN+4V5aCLXgKXMNUZhb1pSGeSbqK1X/xeukuTwD7pkDP3BQlyNcOuwRtU7bbV4ntiJ1BhvCVjmam9i9EUMhCmdjI6RE7BL3UVSVVWg3Y8DoEmYmhu/rd5wUcdda7xZQ
X-Gm-Message-State: AOJu0YwtJ0l2c41cKff1/dF97v21dJmUGwSJ296c6RFkoWSncQeES7k0
	E8glrXgVsl+TJMnXpyLuQTTj+keg92Sve7fgmDKjXp5sJEHe6Hzy
X-Google-Smtp-Source: AGHT+IHbsSgAHK1PYVI2pml4zpwK340pt4pevStZqO5NlzVhCEcDUHLi5mX6a7F3DIgVXMu0YR0MQw==
X-Received: by 2002:a05:6512:114c:b0:530:ad8d:dcdb with SMTP id 2adb3069b0e04-53213653341mr3033154e87.19.1723555717803;
        Tue, 13 Aug 2024 06:28:37 -0700 (PDT)
Received: from lenovo.homenet.telecomitalia.it (host-79-17-17-86.retail.telecomitalia.it. [79.17.17.86])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f414afe2sm70426766b.144.2024.08.13.06.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 06:28:37 -0700 (PDT)
From: Matteo Croce <technoboy85@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Matteo Croce <teknoraver@meta.com>
Subject: [PATCH bpf-next v5 0/2] bpf: enable some functions in cgroup programs
Date: Tue, 13 Aug 2024 15:28:29 +0200
Message-ID: <20240813132831.184362-1-technoboy85@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matteo Croce <teknoraver@meta.com>

Enable some BPF kfuncs and the helper bpf_current_task_under_cgroup()
for program types BPF_CGROUP_*.
These will be used by systemd-networkd:
https://github.com/systemd/systemd/pull/32212

v4->v5:
Same code, but v4 had an old cover letter

v3->v4:
Reset all the acked-by tags because the code changed a bit.

Signed-off-by: Matteo Croce <teknoraver@meta.com>

Matteo Croce (2):
  bpf: enable generic kfuncs for BPF_CGROUP_* programs
  bpf: allow bpf_current_task_under_cgroup() with BPF_CGROUP_*

 include/linux/bpf.h      |  1 +
 kernel/bpf/btf.c         |  8 ++++++--
 kernel/bpf/cgroup.c      |  2 ++
 kernel/bpf/helpers.c     | 29 +++++++++++++++++++++++++++++
 kernel/trace/bpf_trace.c | 23 -----------------------
 5 files changed, 38 insertions(+), 25 deletions(-)

-- 
2.46.0


