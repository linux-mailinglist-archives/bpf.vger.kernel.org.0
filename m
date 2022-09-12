Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69BD05B5721
	for <lists+bpf@lfdr.de>; Mon, 12 Sep 2022 11:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbiILJYj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Sep 2022 05:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiILJYh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Sep 2022 05:24:37 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 001406159;
        Mon, 12 Sep 2022 02:24:35 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id d64-20020a17090a6f4600b00202ce056566so2296310pjk.4;
        Mon, 12 Sep 2022 02:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=A+Syqg4y1JE8bIO5x/LU8yXwkMx7DMhEF6V8BixASDk=;
        b=i3jYkx3jASZnk7nQzWlUfg3hG5o5zcavYIAbbpiOGm0filEkseTQmzjV5rub+XCMwk
         W355ocRljQy4Que7e2ixQmf01KSfbnPJdOIr6Mw3GYhKVpAmIH6oNc20n6wOq8reN1x7
         V3Rf/QtIlh8ajmgSwZIdm4mFL3dS5VyIyx9SBYqGU38UEKDu1dci1bA/TtWOFhkFic4m
         7trBiqNfFh+KrcRh5gBKf3xU+J4RZQrMbbGmiaavLQHMpfAvHu6HeXwSjcYC6R7plXCT
         /tqUaQFjpVn98LeNwv7q0MV4JwmGCLNq+V9+bhCxK7+qA/2kFCDxX1nhHxB9mJ3/M97b
         t4vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=A+Syqg4y1JE8bIO5x/LU8yXwkMx7DMhEF6V8BixASDk=;
        b=zGBhOMRdxidGWA39sJvdR5U3UoXf8leiO5WMEhHlL+T+O65eGI2SY9JRtPWOLHpj3Y
         neDpUQJz/d4SQMozhYIyq5C/avVKWQpKbu726vW4XKWr+VkBfb5vdhoiy82MghYq3AeL
         3EoZNc61K69Xspo5AEQVkH5bKkNsK9ASjumAOESkRkn7FtVmnd395cf2vnoOpYJ86FUI
         hiG7xHcMkvJYzVOHZXXgq4syGmURHDN7RkOIOp2UuZLj8X6LwZMCtSGDuDaPfA+O1tq3
         SWoRMQzi9Dscr888mTECsG79M+3IeXBcmUTrNovJ2WVMQAjv13BcIY9+4XJzMc4u4iV1
         331Q==
X-Gm-Message-State: ACgBeo2cCJchcQ+1rSLFZ5BAlXLiX3VMsClavcunc6DL+MSVkng/M4kW
        QtfpbCF88GUM/c1c1A9Dh04=
X-Google-Smtp-Source: AA6agR4oaU+WBpYICmUHkFCM/PO1PEe4j28gFaz3bM+cs+H79Ws+xUcg+YIvrolIkiP+agnqJx6YKw==
X-Received: by 2002:a17:90a:6d62:b0:200:579f:e4ea with SMTP id z89-20020a17090a6d6200b00200579fe4eamr23220150pjj.244.1662974675500;
        Mon, 12 Sep 2022 02:24:35 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id i5-20020a17090a4b8500b0020080e8c8besm4645681pjh.40.2022.09.12.02.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 02:24:34 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: xu.panda@zte.com.cn
To:     paul@paul-moore.com
Cc:     stephen.smalley.work@gmail.com, eparis@parisplace.org,
        keescook@chromium.org, anton@enomsg.org, ccross@android.com,
        tony.luck@intel.com, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Xu Panda <xu.panda@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] selinux/hooks: remove the unneeded result variable
Date:   Mon, 12 Sep 2022 09:17:19 +0000
Message-Id: <20220912091718.18053-1-xu.panda@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Xu Panda <xu.panda@zte.com.cn>

Return the value avc_has_perm() directly instead of storing it in
another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
---
 security/selinux/hooks.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 2a1168b33218..f553c370397e 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -5995,7 +5995,6 @@ static int selinux_msg_queue_alloc_security(struct kern_ipc_perm *msq)
 	struct ipc_security_struct *isec;
 	struct common_audit_data ad;
 	u32 sid = current_sid();
-	int rc;
 
 	isec = selinux_ipc(msq);
 	ipc_init_security(isec, SECCLASS_MSGQ);
@@ -6003,10 +6002,9 @@ static int selinux_msg_queue_alloc_security(struct kern_ipc_perm *msq)
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = msq->key;
 
-	rc = avc_has_perm(&selinux_state,
-			  sid, isec->sid, SECCLASS_MSGQ,
-			  MSGQ__CREATE, &ad);
-	return rc;
+	return avc_has_perm(&selinux_state,
+			    sid, isec->sid, SECCLASS_MSGQ,
+			    MSGQ__CREATE, &ad);
 }
 
 static int selinux_msg_queue_associate(struct kern_ipc_perm *msq, int msqflg)
@@ -6134,7 +6132,6 @@ static int selinux_shm_alloc_security(struct kern_ipc_perm *shp)
 	struct ipc_security_struct *isec;
 	struct common_audit_data ad;
 	u32 sid = current_sid();
-	int rc;
 
 	isec = selinux_ipc(shp);
 	ipc_init_security(isec, SECCLASS_SHM);
@@ -6142,10 +6139,9 @@ static int selinux_shm_alloc_security(struct kern_ipc_perm *shp)
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = shp->key;
 
-	rc = avc_has_perm(&selinux_state,
-			  sid, isec->sid, SECCLASS_SHM,
-			  SHM__CREATE, &ad);
-	return rc;
+	return avc_has_perm(&selinux_state,
+			    sid, isec->sid, SECCLASS_SHM,
+			    SHM__CREATE, &ad);
 }
 
 static int selinux_shm_associate(struct kern_ipc_perm *shp, int shmflg)
@@ -6219,7 +6215,6 @@ static int selinux_sem_alloc_security(struct kern_ipc_perm *sma)
 	struct ipc_security_struct *isec;
 	struct common_audit_data ad;
 	u32 sid = current_sid();
-	int rc;
 
 	isec = selinux_ipc(sma);
 	ipc_init_security(isec, SECCLASS_SEM);
@@ -6227,10 +6222,9 @@ static int selinux_sem_alloc_security(struct kern_ipc_perm *sma)
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = sma->key;
 
-	rc = avc_has_perm(&selinux_state,
-			  sid, isec->sid, SECCLASS_SEM,
-			  SEM__CREATE, &ad);
-	return rc;
+	return avc_has_perm(&selinux_state,
+			    sid, isec->sid, SECCLASS_SEM,
+			    SEM__CREATE, &ad);
 }
 
 static int selinux_sem_associate(struct kern_ipc_perm *sma, int semflg)
-- 
2.15.2

