Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 180203315FA
	for <lists+bpf@lfdr.de>; Mon,  8 Mar 2021 19:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbhCHS0r (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Mar 2021 13:26:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbhCHS0Z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Mar 2021 13:26:25 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87559C06174A
        for <bpf@vger.kernel.org>; Mon,  8 Mar 2021 10:26:25 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id u187so92057wmg.4
        for <bpf@vger.kernel.org>; Mon, 08 Mar 2021 10:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B1IIeLNaenKh+iouBtlfH+++D7+xvrJGx65uHrDu3tA=;
        b=MCbkvYz8LdhermeUvU03muGFmIKzRpAlX040djGjB4Nnb/crKrwe4mAu4cd8hh0SiF
         un4CG2N674tZWQcrocNfNZo2ozqMZs9YvAE5xWc3uZAgv5i8YpJiUM8qXfEt6IyBLT82
         MJgF4Od1wdfySBgwNYgAOE/S2kaUzmXAAX3+kGm2ehRgBmjeMe5OGNE1xIVCZ9PQhkoa
         Fd7ESM8AY2pz62lSTY9YGrpD+LU5nMiJOHUCwOuqdiKlFfU7tgWXv+XCpiuLk4ymmZf0
         fKry9Q+V2zfJtzAh7p9Nr4gnLvCKrrKx6MgjYFvctXK7jMWnKZapxYoqLsZwV72O5F82
         HYTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B1IIeLNaenKh+iouBtlfH+++D7+xvrJGx65uHrDu3tA=;
        b=LoXA5goByw3O2AoAbvIZyRLqo8PqrIEnKkXNktfGEbm35cLQgwt0fEQ9vTF55fWWhf
         BJDi/tpNIj/kkOPAyF6aijc3UW0Dq5VUjXMFJvX8rfC8GCPr5mnAhZMi2vhqOVOmBorI
         CMnn3I+QfSMdHkL9c70hjppbe5YWvuEs7DiV877l9RjHO1TtS8gOAml93v882o8PYkm1
         fG9BMYI9s4t2Y7aBYym65UFtFBBsPqOJRscDXOXPfTWd4/Ppfltz8fUydPz76O8ybUmX
         /l6L+V4YIEBAlNLdyqxKdFKr5AIPXT2oIvMoQSqZnqXY0juNRwfjfn9g6CQlAwjxd2mO
         uHMg==
X-Gm-Message-State: AOAM533zyjB/VrlIKSRcONkEYLT/2mTGUQ1Z7nPVFqQEKI9DufAfOfm/
        ydvoNX5ab5fCzCnfhoNv9Ecrpg==
X-Google-Smtp-Source: ABdhPJzJjQXNqnr31fW0J3k6R0HJG5R27JTa8OT4YAWtYv/dGCdrrW7o0J+LOV+eSkWuAbI/MLGykA==
X-Received: by 2002:a1c:dd44:: with SMTP id u65mr90827wmg.87.1615227984309;
        Mon, 08 Mar 2021 10:26:24 -0800 (PST)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id j12sm19825900wrx.59.2021.03.08.10.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 10:26:23 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc:     bpf@vger.kernel.org, bjorn@kernel.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH bpf-next] libbpf: Fix arm64 build
Date:   Mon,  8 Mar 2021 19:25:22 +0100
Message-Id: <20210308182521.155536-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The macro for libbpf_smp_store_release() doesn't build on arm64, fix it.

Fixes: 60d0e5fdbdf6 ("libbpf, xsk: Add libbpf_smp_store_release libbpf_smp_load_acquire")
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 tools/lib/bpf/libbpf_util.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf_util.h b/tools/lib/bpf/libbpf_util.h
index 94a0d7bb6f3c..cfbcfc063c81 100644
--- a/tools/lib/bpf/libbpf_util.h
+++ b/tools/lib/bpf/libbpf_util.h
@@ -35,7 +35,7 @@ extern "C" {
 		typeof(*p) ___p1;					\
 		asm volatile ("ldar %w0, %1"				\
 			      : "=r" (___p1) : "Q" (*p) : "memory");	\
-		__p1;							\
+		___p1;							\
 	})
 #elif defined(__riscv)
 # define libbpf_smp_store_release(p, v)					\
-- 
2.30.1

