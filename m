Return-Path: <bpf+bounces-39470-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 002D6973AD5
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 17:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA1E21F255A1
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 15:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7EE9197A9F;
	Tue, 10 Sep 2024 15:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PA9dIaCQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DDE6F305;
	Tue, 10 Sep 2024 15:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725980549; cv=none; b=N3jBmGHyCiAUYhK0nEo/o+4a/X3t5iTyYaWcNRZMLNlRviDuK1i8LtegPdMifJpBGfAUpXyxEYy9sJ5qAXdtt9dBgQzkq27xcUtwR4Cls0LXDyPDLNrCDviVveTOfRgilYn+xc6FnPvdmSEFwyA2yPkHPieN3aYTBWvGh5ruDLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725980549; c=relaxed/simple;
	bh=gGWKexsYFi9YaRuZoexUJVWvFejqkMttV9bnj60uo/w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=d5VBdCVcGspD5neSYVHCBH7XAm/b9trZ24AqnEyIVGj2GmshBXrDjYMf/yMLyVEr022ZLIKM1EtVZrHE58qesWuW336eyCTGfjWf24JipfVWZHaj+PzkAlA6V6LrERR3sZ/F5sL96zlukcDfB4b+7dNPLfFr8wY5B/+yeOXSkPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PA9dIaCQ; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2054feabfc3so50396965ad.1;
        Tue, 10 Sep 2024 08:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725980547; x=1726585347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DroSACjbkj0pJYXEywm5mNBEZQjoH4NoXrwqA2fbe+U=;
        b=PA9dIaCQ5jLBQvG38WfyODot9w790DOO8zCQybeuedsoMdFXtEvdbUmTD7vmncES0a
         gmSyssAB39japuwSUzTdl+eeLWUTfM06SWJatiwSnsB2aufNzkCRGINT1e84UvP6sXkP
         P13Ft3UKmiNVODMGjDxXrVdxI8tvybvEAo2MwvWFLbH0WEU2tHrq9PkSer2XskaQaCbe
         o2OGMahR55wCOKiQLxMVHK8d5z5u3poUjN1qcxM0BQRcuJc2cGVXfF2I1Dpx9lbQNYF9
         cDsa9dW7cXnTFs7YGrjh+iDeD5k6d9+0AUn4KUFDGJ6wtCSPbIBu3TAP1GBg0xlHAkke
         oCrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725980547; x=1726585347;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DroSACjbkj0pJYXEywm5mNBEZQjoH4NoXrwqA2fbe+U=;
        b=hx4mknD6CvJoeYENlfrnqKj8iYaYErf0XCm0K12u/u8xuI1QpzrCWTPfGB6LJXBImt
         FvpBPOFZ/UFvOirvqskjumWIUOrrBFAQ5nf/CEx5L8C9soIlgVnH5CfH7LRPRg2mRRof
         REFYbb5hWRg8MHHqcNIWKdk/BzexiQpPW8mPV4E5PKO5EULAYJ2taJsOwA0dt+vAVKst
         qqaO7H8OvJEynUQWCzAzToYNfacPmxe6o4n+VmLhAiOpuvqS6kQRJDGsw5UD5SgDQW0t
         3AQzmE+hlqNdO3majDqYJnNlWyleG6u35QI57ZhwJu6E11SJl7dZF1QETR1PFtAVhuh0
         OWgA==
X-Forwarded-Encrypted: i=1; AJvYcCUh3ifeyarQl07lwsafEVv4Gtq/muOf2yI82RyOhpISH32Ue3r5/GR1MEv6xKgeaBwVB88=@vger.kernel.org, AJvYcCWI9YDDg7CfYoi2hQ7rRMPWxR+qSvTV4jn7jROfV621u8SgHxXaXa7OaST02QkPGWQxjSiE1CDywHEtj++L@vger.kernel.org
X-Gm-Message-State: AOJu0YxeDWY8FmRoFQF2eNoy9WIFzyt3YkUkqzSlRFi8xMPtuwi/g5pu
	54w/vEoObDC1DQ5NTJCuOkd9aRqe0pVsQQD8C6zOfi9ZUyrbyIeb
X-Google-Smtp-Source: AGHT+IHoXu1HFcNfeR3gSRRjm0JYNt4TiNC38HN8QSAub6vO7RXUYaXPSV5g2hrxy/r63oizwrkDig==
X-Received: by 2002:a17:902:e851:b0:205:810a:18ff with SMTP id d9443c01a7336-2074c702814mr11182575ad.54.1725980547123;
        Tue, 10 Sep 2024 08:02:27 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710e349eesm49613985ad.67.2024.09.10.08.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 08:02:25 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: qmo@kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	jserv@ccns.ncku.edu.tw,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v2] bpftool: Fix undefined behavior in qsort(NULL, 0, ...)
Date: Tue, 10 Sep 2024 23:02:07 +0800
Message-Id: <20240910150207.3179306-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When netfilter has no entry to display, qsort is called with
qsort(NULL, 0, ...). This results in undefined behavior, as UBSan
reports:

net.c:827:2: runtime error: null pointer passed as argument 1, which is declared to never be null

Although the C standard does not explicitly state whether calling qsort
with a NULL pointer when the size is 0 constitutes undefined behavior,
Section 7.1.4 of the C standard (Use of library functions) mentions:

"Each of the following statements applies unless explicitly stated
otherwise in the detailed descriptions that follow: If an argument to a
function has an invalid value (such as a value outside the domain of
the function, or a pointer outside the address space of the program, or
a null pointer, or a pointer to non-modifiable storage when the
corresponding parameter is not const-qualified) or a type (after
promotion) not expected by a function with variable number of
arguments, the behavior is undefined."

To avoid this, add an early return when nf_link_info is NULL to prevent
calling qsort with a NULL pointer.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
Changes in v2:
- Change from checking nf_link_count to checking nf_link_info.

 tools/bpf/bpftool/net.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/bpf/bpftool/net.c b/tools/bpf/bpftool/net.c
index 968714b4c3d4..0ad684e810f3 100644
--- a/tools/bpf/bpftool/net.c
+++ b/tools/bpf/bpftool/net.c
@@ -824,6 +824,9 @@ static void show_link_netfilter(void)
 		nf_link_count++;
 	}
 
+	if (!nf_link_info)
+		return;
+
 	qsort(nf_link_info, nf_link_count, sizeof(*nf_link_info), netfilter_link_compar);
 
 	for (id = 0; id < nf_link_count; id++) {
-- 
2.34.1


