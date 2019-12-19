Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1BFA1261B6
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2019 13:07:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbfLSMHd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Dec 2019 07:07:33 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:45195 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726668AbfLSMHc (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 19 Dec 2019 07:07:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576757252;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Br/cg8Xfu6sMsg27brwJ8qm737WLDYMwR8gi4ySebN4=;
        b=RUYV27KeTkQZ1KLwMeaX9JdA/vSIBRvggRjS56CzTNnykSxb4yazT/WVMPeqMIMOkgYl7I
        R8PW1RJqihOJ9lWCoHSu9G6WmcICdszbvdIJw6W8NntOM18TBM3PZYmU55G6jik/59tY1w
        oBO6De7PkXtbTTDupyZnQtwT9ayLxeU=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-jN_wo5wvOxKek1etAWogoA-1; Thu, 19 Dec 2019 07:07:27 -0500
X-MC-Unique: jN_wo5wvOxKek1etAWogoA-1
Received: by mail-lj1-f198.google.com with SMTP id t11so1837003ljo.13
        for <bpf@vger.kernel.org>; Thu, 19 Dec 2019 04:07:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Br/cg8Xfu6sMsg27brwJ8qm737WLDYMwR8gi4ySebN4=;
        b=NSvUL3uoSLobnzigKZsGygRLXjBAKuxTK5flF94BQomRntWccWGuxy9wXGggWE9m9f
         2tIKcHgl3jOfLaXIUV1tr6m6gyeDqbQjL1rdVqtlxXO+q+RFf41ALA0CiXwL9OkhbDuI
         eolCQeGB/IHxMBgQUiUDTx56P1DO3cwqqB+jsm7TEi4PE/SZooQNi3DU0yeq9TN3Yzob
         Mrmpg3exqcBxqIeywsJPT4hXK23+B2VFk2F4RiOrpSLlrg9O6zNhXJjlL60Bi/wx7N29
         kMlmZ53BpwYy4mn78sePjkbtV+ft0PMGR/Ioa6ht7eIhJ+ze76BqBFQQGanGdzIStR5O
         2nlw==
X-Gm-Message-State: APjAAAWcefWeobtp8YmGZFUO9glWpgrKEu4HH41Kr9MjjKOrgnaXYiDt
        8jFjvTJXL0lynNpfOlEWnyZ0vek7G8Ri9wEQvc9j0bagC2Ye7UHBpcpxfkkeIQ069b3cCho/bHD
        hhlnWV2YUfdaP
X-Received: by 2002:a2e:3609:: with SMTP id d9mr5632716lja.188.1576757245481;
        Thu, 19 Dec 2019 04:07:25 -0800 (PST)
X-Google-Smtp-Source: APXvYqx+DUn8p4tIwpYWIONrSldquMChWpqKujbcbHNpW4ZKGW2L9RPA7P1btsS8OQaY+xN5eRD+fw==
X-Received: by 2002:a2e:3609:: with SMTP id d9mr5632706lja.188.1576757245329;
        Thu, 19 Dec 2019 04:07:25 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id y14sm2754049ljk.46.2019.12.19.04.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 04:07:24 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 47B5B180969; Thu, 19 Dec 2019 13:07:23 +0100 (CET)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH bpf-next] libbpf: Add missing newline in opts validation macro
Date:   Thu, 19 Dec 2019 13:07:14 +0100
Message-Id: <20191219120714.928380-1-toke@redhat.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The error log output in the opts validation macro was missing a newline.

Fixes: 2ce8450ef5a3 ("libbpf: add bpf_object__open_{file, mem} w/ extensible opts")
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/lib/bpf/libbpf_internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index 7d71621bb7e8..8c3afbd97747 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -76,7 +76,7 @@ static inline bool libbpf_validate_opts(const char *opts,
 
 		for (i = opts_sz; i < user_sz; i++) {
 			if (opts[i]) {
-				pr_warn("%s has non-zero extra bytes",
+				pr_warn("%s has non-zero extra bytes\n",
 					type_name);
 				return false;
 			}
-- 
2.24.1

