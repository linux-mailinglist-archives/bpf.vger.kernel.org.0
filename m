Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACB9E1C00DA
	for <lists+bpf@lfdr.de>; Thu, 30 Apr 2020 17:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbgD3Pwr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Apr 2020 11:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725844AbgD3Pwr (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 30 Apr 2020 11:52:47 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D221BC035494
        for <bpf@vger.kernel.org>; Thu, 30 Apr 2020 08:52:46 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id g13so7541129wrb.8
        for <bpf@vger.kernel.org>; Thu, 30 Apr 2020 08:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AZo6TuIE/5CcefbKGNzYSvkrg5IwPl6ltYNRWOcMaDk=;
        b=ew1UPCIe8ZacX7ovq7/6qUDJlJ+5LH1pYI4Qv9R/87Ys89GVuota9rIBbMd+Td5GWP
         8srIJ0cNMt9MTgjfWwAgBPDSbyGXi2rTY+X8LXmJodhZf7wgiI/EEWIy8gdcw6riIP5z
         fHQPkxuMdWBZXVn52OJZXfEr54kzDCckCz0FI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AZo6TuIE/5CcefbKGNzYSvkrg5IwPl6ltYNRWOcMaDk=;
        b=jmzBV3ZvrclDIwGQUbEjxq9FmFsupzqtVapXbL01KVcc+9DW4daR38L4pg6mcZMRvw
         be63p6k4prNj1njpMPmurZK7YEredxBptRfKI1IVJX/8rnK1JMBiBpc/MnL1a9ZnHIx7
         x4DhP1xiyRB1ng2SQ7wE6WXUdV5nYGR98AEIUu3oLV5TkM//rhE40I6O9Knud58kWLDy
         Q8yzpVhPiMbwSMsoYvvbPmaEBwy3bOPPoatJRS+Nd9AVSHyQM9NEathTrWGoDjYek2Ss
         22GwsD0HixdkEKWUDDRueyhF/rRcDNbDsC+DFb8SiaVDBZCuq/ORXdyuPi3yoFZIOV37
         N0Iw==
X-Gm-Message-State: AGi0PuanFBq68br50R0T7REkcWvugfvHM/R5qQxW54aT8FrDjTV0v0Et
        fVCS+SZTcGbvB/gpA5h3unmU+Q==
X-Google-Smtp-Source: APiQypKcObnvK7/azf9dwTI9MsY5sG6t8DBheJsjVNGF56u65EmqYwLcS0U3EwbjygZUPfHV+1Q/fg==
X-Received: by 2002:adf:9d85:: with SMTP id p5mr4800271wre.101.1588261965505;
        Thu, 30 Apr 2020 08:52:45 -0700 (PDT)
Received: from kpsingh.zrh.corp.google.com ([81.6.44.51])
        by smtp.gmail.com with ESMTPSA id a125sm123421wme.3.2020.04.30.08.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 08:52:44 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Mikko Ylinen <mikko.ylinen@linux.intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>
Subject: [PATCH bpf] security: Fix the default value of fs_context_parse_param hook
Date:   Thu, 30 Apr 2020 17:52:40 +0200
Message-Id: <20200430155240.68748-1-kpsingh@chromium.org>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

security_fs_context_parse_param is called by vfs_parse_fs_param and
a succussful return value (i.e 0) implies that a parameter will be
consumed by the LSM framework. This stops all further parsing of the
parmeter by VFS. Furthermore, if an LSM hook returns a success, the
remaining LSM hooks are not invoked for the parameter.

The current default behavior of returning success means that all the
parameters are expected to be parsed by the LSM hook and none of them
end up being populated by vfs in fs_context

This was noticed when lsm=bpf is supplied on the command line before any
other LSM. As the bpf lsm uses this default value to implement a default
hook, this resulted in a failure to parse any fs_context parameters and
a failure to mount the root filesystem.

Fixes: 98e828a0650f ("security: Refactor declaration of LSM hooks")
Reported-by: Mikko Ylinen <mikko.ylinen@linux.intel.com>
Signed-off-by: KP Singh <kpsingh@google.com>
---
 include/linux/lsm_hook_defs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 9cd4455528e5..1bdd027766d4 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -55,7 +55,7 @@ LSM_HOOK(void, LSM_RET_VOID, bprm_committing_creds, struct linux_binprm *bprm)
 LSM_HOOK(void, LSM_RET_VOID, bprm_committed_creds, struct linux_binprm *bprm)
 LSM_HOOK(int, 0, fs_context_dup, struct fs_context *fc,
 	 struct fs_context *src_sc)
-LSM_HOOK(int, 0, fs_context_parse_param, struct fs_context *fc,
+LSM_HOOK(int, -ENOPARAM, fs_context_parse_param, struct fs_context *fc,
 	 struct fs_parameter *param)
 LSM_HOOK(int, 0, sb_alloc_security, struct super_block *sb)
 LSM_HOOK(void, LSM_RET_VOID, sb_free_security, struct super_block *sb)
-- 
2.26.2.303.gf8c07b1a785-goog

