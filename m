Return-Path: <bpf+bounces-79089-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F215CD26BC4
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 18:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C92DC31754E7
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 17:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048F33D3326;
	Thu, 15 Jan 2026 17:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SoH3wfb5"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391A83D330F
	for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 17:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768498048; cv=none; b=SAJlvcUfJjIOlHy2FMF0XhOEMqG7JSzZvI2qZWD4pNL53Zi1jKzySe18y7gmZt61RykLBJqFWCZEuhLH0ACRgLxHPXxO73IolM9RiKvmXyacjv0os+VqUhuoTSXOmC3Lyhl76OlAcjWb0Ibg7J0Bw6K2jzv9kXpplfoBJQ0wJ68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768498048; c=relaxed/simple;
	bh=pf4PhOMROdXPWvou4acT8TMe1DaE0/Vcfn0EXJ5jwGU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CghX5IPUtcuvjElwIcCELIL2F5chfsilIXALysxPYzPy9B0S4kN61cnGealSbjv7JcDs97dQmFgypTL56Aq9kTdEqeQKZ6ZHndrB6aVbrVismG3kq++tlDxEcOvE9uUqvcJykozkElL0lnjOEUIWFwlBGhHzQsPLqyqXcmXhBKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SoH3wfb5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768498046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jeefTd42LAWau21bgi4bPgUTY/EIGN9zI5P01XBYpQo=;
	b=SoH3wfb5aq5gyuS+bh68QgHAONG350XMRKEnPn+3jWPzhBGMZOT2vAWdJwJDtFR3Cxc7tV
	I6fSTOdBeczL1gS+ZYigTIH8VKg8uNeQ+8lyyAewtdUgsbnMUuhejH85S3o9jeVIioSqVU
	jjZR+GacvVvZfsq9IXfo2XDeLfslyVE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-582-7mQIheweNQKnyjthnAyH-A-1; Thu,
 15 Jan 2026 12:27:23 -0500
X-MC-Unique: 7mQIheweNQKnyjthnAyH-A-1
X-Mimecast-MFC-AGG-ID: 7mQIheweNQKnyjthnAyH-A_1768498041
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C788C1955F38;
	Thu, 15 Jan 2026 17:27:21 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.64.87])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3CD2D18007D2;
	Thu, 15 Jan 2026 17:27:16 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Ivan Pravdin <ipravdin.official@gmail.com>,
	Crystal Wood <crwood@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Daniel Wagner <dwagner@suse.de>,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	linux-trace-kernel@vger.kernel.org (open list:Real-time Linux Analysis (RTLA) tools),
	linux-kernel@vger.kernel.org (open list:Real-time Linux Analysis (RTLA) tools),
	bpf@vger.kernel.org (open list:BPF [MISC]:Keyword:(?:\b|_)bpf(?:\b|_))
Subject: [PATCH v3 09/18] rtla: Handle pthread_create() failure properly
Date: Thu, 15 Jan 2026 13:31:52 -0300
Message-ID: <20260115163650.118910-10-wander@redhat.com>
In-Reply-To: <20260115163650.118910-1-wander@redhat.com>
References: <20260115163650.118910-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Add proper error handling when pthread_create() fails to create the
timerlat user-space dispatcher thread. Previously, the code only logged
an error message but continued execution, which could lead to undefined
behavior when the tool later expects the thread to be running.

When pthread_create() returns an error, the function now jumps to the
out_trace error path to properly clean up resources and exit. This
ensures consistent error handling and prevents the tool from running
in an invalid state without the required user-space thread.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tools/tracing/rtla/src/common.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/tracing/rtla/src/common.c b/tools/tracing/rtla/src/common.c
index cbc207fa58707..73906065e7772 100644
--- a/tools/tracing/rtla/src/common.c
+++ b/tools/tracing/rtla/src/common.c
@@ -303,8 +303,10 @@ int run_tool(struct tool_ops *ops, int argc, char *argv[])
 		params->user.cgroup_name = params->cgroup_name;
 
 		retval = pthread_create(&user_thread, NULL, timerlat_u_dispatcher, &params->user);
-		if (retval)
+		if (retval) {
 			err_msg("Error creating timerlat user-space threads\n");
+			goto out_trace;
+		}
 	}
 
 	retval = ops->enable(tool);
-- 
2.52.0


