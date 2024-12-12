Return-Path: <bpf+bounces-46687-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B0E9EDFF5
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 08:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C08A1693C3
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 07:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07B62063E9;
	Thu, 12 Dec 2024 07:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hd0rBb7e"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E942B206278
	for <bpf@vger.kernel.org>; Thu, 12 Dec 2024 07:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733987250; cv=none; b=Bozoarmxoee1mQebFqZoCdps+bpmHeh7VUh45ma3cZlVJaePQWj46DDxIUxsNHMDX3Mq/txIj3GfiX81qLDwB5GmMFW2LnUZ6/tHVdDSDbfDjjdRAU2RGDfOt42wl6fkOs5M3jceMcosFPFMDLEEZq+rYe1cF3HaBjxexlgWNzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733987250; c=relaxed/simple;
	bh=CNN1tzGSlWyQuHNjfFOip6+XNFd2pY7xASbPWiFfvvI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qc8NYSMzb6R14XJDf0ouuW9sLRY2Hey0DY5Ccva/mDcbW2/a+Kwuhh2u+mDxbQ/pqJWlUpA9OINEMFQd3ZPI0ebinDyFTem6AjrVtkQyJLVpT+TnUhSJ3grguhEbLunSIkW+NNb1sjVR2rmf1q4/buWL6uxC+N3bADFDuuKJUsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hd0rBb7e; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7feb6871730so202379a12.2
        for <bpf@vger.kernel.org>; Wed, 11 Dec 2024 23:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733987246; x=1734592046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oo2HvqJfyyczUF61w4dstsX8Ca1IntU4zGLNKXpDkY8=;
        b=hd0rBb7e/WhpvxM3EdqicX7lCD5afynKP8WJqW37Ic8bL+/OvAxpsM/7Z7Pp65G8SY
         wcXWAt+kGzmFxL+SeNcWkagpxQFqLGdTyOlWY2eX95MAaJHHILxUEJfNWkG+x9pBSdRc
         oKmwBCn4wUPyAaF2a1zB2M6h87TUK+2iKBRkOSZx8AJoHb0T2ptKVpTXH6NzS0sTr9+m
         f5JUy4i6AKfl5+yYOhTGl4FoV6PU44JXYyd4jMc7Lpcg4JcJTS+nHiHMuunCh4WU2FRw
         J6QGzgg65B6hHHZT0rOLfIVDOYVIHeiuwKzr2sMkf6sKr/qcfLZma/PAXDiM2OXiFJrg
         W3UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733987246; x=1734592046;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oo2HvqJfyyczUF61w4dstsX8Ca1IntU4zGLNKXpDkY8=;
        b=txMcDxPbHrly7HE7dvq9lp7hhCRFAWfk7HSFfzuX1bMPrajAo6F/sNQN1D5w6H316A
         U/sRPLf/qE60esvluN62Mr7Fj9VXwYCxyOb0RmtwoRJ7SRAR0Sl1RuwAJZLeFlfu8Rxf
         yR9s7nWtds3Ev01UzShbq9Mq9Ns/TWouXjBYPSxZqMRfec76T8dmkbJiw6tlcL7bDoWh
         x6wfwTi66gQHDtNZ/90+RwPLJvDFYvubvUEiKQGoU1MCYdLB68MSPpOdNjZmUcZkAJt+
         z2z1Vy7G8m6tUg5tuXCOyCnsrJmnZD5+OxawJdUL7F4fsWoa8L70KlC0HWP06BcHme+M
         +3KQ==
X-Gm-Message-State: AOJu0YyN7VrGKDAaDlLNJuEhCZqEThPpfe03fF6dB4ILhZIpfro18t36
	6oMWvUftriSmjwSHcjxWZCTnkLytMXt5/Umas5N86QTCBVwbqpJUcryJhQ==
X-Gm-Gg: ASbGncvoLW3uuFh/ZfVMlkx/gGZIY5goBit7gTRBQRzQ04aYdstyDDm2Scyx9NFi9vt
	shXLl3TdtJOulYdEbuUx8xkWgt+mz5tzQjcyDsoZyYvSx0V7t/KCnW/LMX0uYuBPaWzbMYUN7kW
	AqP4C2OOz63lJqkw7wbpbsnKoj99kIaw3Sm7UZxZjqiXM8r2jY4ww7bxm4ZibTqq+d4yajc8AqN
	dtVFNBmIRQaYE4TafteNNQHf5xVttKjnPuRH2lZz0XjXAR+ljGB
X-Google-Smtp-Source: AGHT+IH9yMPudEk+qGCNfGKIGCOKbBLD1MCFmVJX05aqdOyLkCEQp99A6TYUDLIdlPg/m6vvT0O23A==
X-Received: by 2002:a17:90b:3c44:b0:2ee:e113:815d with SMTP id 98e67ed59e1d1-2f127f7e1fdmr9056053a91.8.1733987245743;
        Wed, 11 Dec 2024 23:07:25 -0800 (PST)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142d90bd8sm600217a91.10.2024.12.11.23.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 23:07:25 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	mejedi@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel test robot <lkp@intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH bpf 1/2] bpf: fix NPE when computing changes_pkt_data of program w/o subprograms
Date: Wed, 11 Dec 2024 23:07:10 -0800
Message-ID: <20241212070711.427443-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_prog_aux->func field might be NULL if program does not have
subprograms except for main sub-program. The fixed commit does
bpf_prog_aux->func access unconditionally, which might lead to null
pointer dereference.

The bug could be triggered by replacing the following BPF program:

    SEC("tc")
    int main_changes(struct __sk_buff *sk)
    {
        bpf_skb_pull_data(sk, 0);
        return 0;
    }

With the following BPF program:

    SEC("freplace")
    long changes_pkt_data(struct __sk_buff *sk)
    {
        return bpf_skb_pull_data(sk, 0);
    }

bpf_prog_aux instance itself represents the main sub-program,
use this property to fix the bug.

Fixes: 81f6d0530ba0 ("bpf: check changes_pkt_data property for extension programs")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202412111822.qGw6tOyB-lkp@intel.com/
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c2e5d0e6e3d0..5e541339b2f6 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -22193,6 +22193,7 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 	}
 	if (tgt_prog) {
 		struct bpf_prog_aux *aux = tgt_prog->aux;
+		bool tgt_changes_pkt_data;
 
 		if (bpf_prog_is_dev_bound(prog->aux) &&
 		    !bpf_prog_dev_bound_match(prog, tgt_prog)) {
@@ -22227,8 +22228,10 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 					"Extension programs should be JITed\n");
 				return -EINVAL;
 			}
-			if (prog->aux->changes_pkt_data &&
-			    !aux->func[subprog]->aux->changes_pkt_data) {
+			tgt_changes_pkt_data = aux->func
+					       ? aux->func[subprog]->aux->changes_pkt_data
+					       : aux->changes_pkt_data;
+			if (prog->aux->changes_pkt_data && !tgt_changes_pkt_data) {
 				bpf_log(log,
 					"Extension program changes packet data, while original does not\n");
 				return -EINVAL;
-- 
2.47.0


