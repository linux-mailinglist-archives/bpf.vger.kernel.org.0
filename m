Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE17C11CA88
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2019 11:23:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728607AbfLLKXE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Dec 2019 05:23:04 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:47064 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728523AbfLLKXE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Dec 2019 05:23:04 -0500
Received: by mail-lj1-f194.google.com with SMTP id z17so1619034ljk.13
        for <bpf@vger.kernel.org>; Thu, 12 Dec 2019 02:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lqoyLq3FH/KOqdI/Fep6CHU+TUjSKzAkA1J5kFs+EMA=;
        b=gfGNX17EhCJo5/0Iu8umgwRYNwRj1qFOXKAXmHjrgX2r9Y6eS1buM24EyjMU7ncmKw
         scV2IWjHYBV7fOk2ZL3bC3BT5tqOS/zHCqLl/RZ2NjEo90Q4bWrZCR9x/QneOa8NQpD3
         pPBDtQc66ChK5Ify3ejBxwSI0mRIhnTyHCBb4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lqoyLq3FH/KOqdI/Fep6CHU+TUjSKzAkA1J5kFs+EMA=;
        b=JvIAOuITkiXMzeJqW3vnv8na3DAHJzXmoeiqXUBDrTB6Leu2mmFaBAGvk5unrz+ZGR
         jl9x1BlIa9El1TENCFUtwX6aQMFZtGndhVJkBhNEKVczczTTzP4aii7R4ChkfvHR+cVu
         Lk60Qd+HHsJWcvAJgrl7/l/C6DN8Yzdi6VaROVi7a35aq+Wg6eK1Xd/Xb8xS0YWWMSUS
         6uGVWq1TKRBXgLwbId55LbErFLjcCsdKECb+5e9TutLjS5DuhXgn5m+lDI65gBKktuJG
         xbxELteoxIpt8W7c/sp8Rhhyo+g4xN1btYd+daP5krqF3kkE/VZF/mchxVQnXJEF/8tA
         IeBQ==
X-Gm-Message-State: APjAAAUFCitighcaLmwFo+hhOqext2V0qzzXCor1Wz17rvdBThNRlKia
        yGs05YLxBY9wtB1wim0B/tY8I18gXnv9zA==
X-Google-Smtp-Source: APXvYqw7sHxROz/Gcqslu2wKDc6rDzoLxPbLt2IRHfDt1kt1Tc3ADweNuauYUzdhoo9u17UIude2ew==
X-Received: by 2002:a2e:8e97:: with SMTP id z23mr5052152ljk.125.1576146181857;
        Thu, 12 Dec 2019 02:23:01 -0800 (PST)
Received: from cloudflare.com ([176.221.114.230])
        by smtp.gmail.com with ESMTPSA id h24sm2718942ljl.80.2019.12.12.02.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 02:23:01 -0800 (PST)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     Martin Lau <kafai@fb.com>, kernel-team@cloudflare.com
Subject: [PATCH bpf-next 01/10] libbpf: Recognize SK_REUSEPORT programs from section name
Date:   Thu, 12 Dec 2019 11:22:50 +0100
Message-Id: <20191212102259.418536-2-jakub@cloudflare.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191212102259.418536-1-jakub@cloudflare.com>
References: <20191212102259.418536-1-jakub@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Allow loading BPF object files that contain SK_REUSEPORT programs without
having to manually set the program type before load if the the section name
is set to "sk_reuseport".

Makes user-space code needed to load SK_REUSEPORT BPF program more concise.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 tools/lib/bpf/libbpf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 3f09772192f1..13f6db467cdd 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -4982,6 +4982,7 @@ static const struct {
 	enum bpf_attach_type attach_type;
 } section_names[] = {
 	BPF_PROG_SEC("socket",			BPF_PROG_TYPE_SOCKET_FILTER),
+	BPF_PROG_SEC("sk_reuseport",		BPF_PROG_TYPE_SK_REUSEPORT),
 	BPF_PROG_SEC("kprobe/",			BPF_PROG_TYPE_KPROBE),
 	BPF_PROG_SEC("uprobe/",			BPF_PROG_TYPE_KPROBE),
 	BPF_PROG_SEC("kretprobe/",		BPF_PROG_TYPE_KPROBE),
-- 
2.23.0

