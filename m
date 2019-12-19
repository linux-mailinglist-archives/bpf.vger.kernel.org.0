Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 720FA125D2F
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2019 10:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbfLSJC5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Dec 2019 04:02:57 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42402 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726623AbfLSJC4 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 19 Dec 2019 04:02:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576746175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=QxDIaWdT8batw2rKwD3TMKwDU+xiK4PL5KHw6ZGQad8=;
        b=EIb9pEwQlJ9aDkAE/Qy93PZjhxtc+ZoLLMwXlj2VCJz4f6hdvCte4CnhWIUdmVg9QaWyaZ
        wwRqZFaLU3dyDMN6BvWbLuscd7UaUizabNALU8eKJIvKT+inKwiQLGyDn0eqZl4O9eMVD9
        tBio1yDFJOKfe5tqr9CX3nZvUyb/vl8=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-bXMhvRT4P6iIup9rLrF2cQ-1; Thu, 19 Dec 2019 04:02:52 -0500
X-MC-Unique: bXMhvRT4P6iIup9rLrF2cQ-1
Received: by mail-lf1-f71.google.com with SMTP id t8so192737lfc.21
        for <bpf@vger.kernel.org>; Thu, 19 Dec 2019 01:02:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QxDIaWdT8batw2rKwD3TMKwDU+xiK4PL5KHw6ZGQad8=;
        b=SKbVt0F/mzg6V/j5RXkh2kyx3UBTABY038PQ4yhOu6FPFvW6NsE+WelbCLhJYlOzw+
         kjGpjWqeBHMwa1zfax8x6RMBn0TKRcxiFAkkPyAZP1zOCqt7fzpjcWrqPYXup2FjLrDz
         LBMdQPkPCibFvXS7CrAur3Aeaoj4BWKJrcYbUNu6Wt4caHTJcDxN5xmVyYkMeOwsAabf
         8BxrtvFAH048B403owtGw6CdFnR4sU7d79blfDUUgNERSUfX4dQ5r7HRRlrGUs7kdSSO
         LQaEO2S4lIuSe+h1Up6PM8pVkygi6uuk6QJqfHb3Op3WS29ZUJJudc4DNAFxydf62F3a
         uiwg==
X-Gm-Message-State: APjAAAUmN23MV5FNIL1WgGeJ8UAoqZjAkBD4L+oY2e2VZCOfHlhX5xeA
        sMwM9le992JyqiJ0hB2SIba2h67B1yqKrmSP4fgmv//dDSJyzQR4NCPjFSeuQogQ61lqmPpt734
        63jegbsctabXf
X-Received: by 2002:a2e:8745:: with SMTP id q5mr5223645ljj.208.1576746170784;
        Thu, 19 Dec 2019 01:02:50 -0800 (PST)
X-Google-Smtp-Source: APXvYqyZ+C/Pil77EjYzmhfrYVbigzr+NO1QGwq89zUMQ8vsExgbh4KpvgbQCNNxUhznT0vQHIKypA==
X-Received: by 2002:a2e:8745:: with SMTP id q5mr5223627ljj.208.1576746170531;
        Thu, 19 Dec 2019 01:02:50 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id i4sm3089417lji.0.2019.12.19.01.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 01:02:49 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 3D17D180969; Thu, 19 Dec 2019 10:02:49 +0100 (CET)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: [PATCH bpf-next v2] libbpf: Fix printing of ulimit value
Date:   Thu, 19 Dec 2019 10:02:36 +0100
Message-Id: <20191219090236.905059-1-toke@redhat.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Naresh pointed out that libbpf builds fail on 32-bit architectures because
rlimit.rlim_cur is defined as 'unsigned long long' on those architectures.
Fix this by using %zu in printf and casting to size_t.

Fixes: dc3a2d254782 ("libbpf: Print hint about ulimit when getting permission denied error")
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
v2:
  - Use %zu instead of PRIu64
  
 tools/lib/bpf/libbpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index c69a3745ecb0..59bae2cac449 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -117,7 +117,7 @@ static void pr_perm_msg(int err)
 		return;
 
 	if (limit.rlim_cur < 1024)
-		snprintf(buf, sizeof(buf), "%lu bytes", limit.rlim_cur);
+		snprintf(buf, sizeof(buf), "%zu bytes", (size_t)limit.rlim_cur);
 	else if (limit.rlim_cur < 1024*1024)
 		snprintf(buf, sizeof(buf), "%.1f KiB", (double)limit.rlim_cur / 1024);
 	else
-- 
2.24.1

