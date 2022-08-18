Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF99A599130
	for <lists+bpf@lfdr.de>; Fri, 19 Aug 2022 01:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241562AbiHRX1k (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Aug 2022 19:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242965AbiHRX1i (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Aug 2022 19:27:38 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC65BD7590
        for <bpf@vger.kernel.org>; Thu, 18 Aug 2022 16:27:37 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id x8-20020a17090a1f8800b001faa9857ef2so1697235pja.0
        for <bpf@vger.kernel.org>; Thu, 18 Aug 2022 16:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=JhzdXfdOhmVSvb0f5hdzA4lwR+CApXODWOocBmtmUrg=;
        b=Akf3QfEltB1vKEmY/upgIoTcgqhx/oa2l0O5R8eo9NmC/80GnSd3lstyQchgGNUPMh
         2t/4GsXFnrQ5o+LDOGG2JrqO4EAkRNi3HkNUTlAxhCNjrMUo3YKPFcUZTSXzDALGTHEE
         Vs7+MH919Q9UABgMMAkSVpJlZC95CZeWwEaWeJcl/GK/jEl36yIieiZ19YtJra7MQkvo
         Hx9fB9GbQROJKKPyEEtDECGm3uTYPX5lyYjY6F8mPUJVoYEJFcxVOI4/FdZ3xok596kv
         6hHNTOEW9FZr0Zc+uNR3NVG+1/7U9hJcb8arI5snluORYEBcgzE2x9Fjs4LhLtyGjoN0
         nlEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=JhzdXfdOhmVSvb0f5hdzA4lwR+CApXODWOocBmtmUrg=;
        b=W2I5NLHHm+VudJPHgGHsvGOIkhpFqrSKAuubasDZJhszKIcz2/nlTyP8hak0W1hukU
         rAkaieREdl2WAHokiWBQyNNK7GeM9rqC/K1sZNcnepSBlLeP7ct68BZD/x29ebXOSodA
         qGnRMa9Ka/epIJILbgTxTOIZYsenXLhlXd92OoS9665b0FigFD48G6+dO+S9N5bLx64Q
         eveXOrOiW9+k3VEzjoWH0LG4Hcu0uZXLUcTNnlTzvwL865fUPQbXHyVgH0pKmGKphns6
         vkIVCl9+KF8dLQLpX2OBQYAlxwQ48xnxFQ+WFhcn0ElmxAe2DIxqZvjvA01s67VkzAHl
         Apew==
X-Gm-Message-State: ACgBeo0iGFpA4CWylYQs1wMGK8U1g4qIjL6LQ76W0vBteQFWLPpb22AD
        3oZmETh8900TJZgIta8yAbk1EOMzDNVtx2WixVUZ2mZmCDD0coUqdtXfU1llb99WPxEHwZsxiym
        dpPUWGwzY24+gomcpQzm0pvjuOEzdS8yEyubxvRqaILR31JzChw==
X-Google-Smtp-Source: AA6agR7O4Lgu3JHFALIUqgmBpjs8GeajBfiqX8aGkJeLGnIM1QDUFGLfDdX4qT002mdvfgVnaNbPb2k=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:902:b086:b0:171:2632:cd3b with SMTP id
 p6-20020a170902b08600b001712632cd3bmr4989465plr.111.1660865257244; Thu, 18
 Aug 2022 16:27:37 -0700 (PDT)
Date:   Thu, 18 Aug 2022 16:27:28 -0700
In-Reply-To: <20220818232729.2479330-1-sdf@google.com>
Message-Id: <20220818232729.2479330-5-sdf@google.com>
Mime-Version: 1.0
References: <20220818232729.2479330-1-sdf@google.com>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH bpf-next v3 4/5] bpf: update bpf_{g,s}et_retval documentation
From:   Stanislav Fomichev <sdf@google.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

* replace 'syscall' with 'upper layers', still mention that it's being
  exported via syscall errno
* describe what happens in set_retval(-EPERM) + return 1
* describe what happens with bind's 'return 3'

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 include/uapi/linux/bpf.h       | 22 +++++++++++++++++-----
 tools/include/uapi/linux/bpf.h | 22 +++++++++++++++++-----
 2 files changed, 34 insertions(+), 10 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 934a2a8beb87..954b897a631e 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5085,17 +5085,29 @@ union bpf_attr {
  *
  * int bpf_get_retval(void)
  *	Description
- *		Get the syscall's return value that will be returned to userspace.
+ *		Get the BPF program's return value that will be returned to the upper layers.
  *
- *		This helper is currently supported by cgroup programs only.
+ *		This helper is currently supported by cgroup programs and only by the hooks
+ *		where BPF program's return value is returned to the userspace via errno.
  *	Return
- *		The syscall's return value.
+ *		The BPF program's return value.
  *
  * int bpf_set_retval(int retval)
  *	Description
- *		Set the syscall's return value that will be returned to userspace.
+ *		Set the BPF program's return value that will be returned to the upper layers.
+ *
+ *		This helper is currently supported by cgroup programs and only by the hooks
+ *		where BPF program's return value is returned to the userspace via errno.
+ *
+ *		Note that there is the following corner case where the program exports an error
+ *		via bpf_set_retval but signals success via 'return 1':
+ *
+ *			bpf_set_retval(-EPERM);
+ *			return 1;
+ *
+ *		In this case, the BPF program's return value will use helper's -EPERM. This
+ *		still holds true for cgroup/bind{4,6} which supports extra 'return 3' success case.
  *
- *		This helper is currently supported by cgroup programs only.
  *	Return
  *		0 on success, or a negative error in case of failure.
  *
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 1d6085e15fc8..b99ff5f34c61 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5085,17 +5085,29 @@ union bpf_attr {
  *
  * int bpf_get_retval(void)
  *	Description
- *		Get the syscall's return value that will be returned to userspace.
+ *		Get the BPF program's return value that will be returned to the upper layers.
  *
- *		This helper is currently supported by cgroup programs only.
+ *		This helper is currently supported by cgroup programs and only by the hooks
+ *		where BPF program's return value is returned to the userspace via errno.
  *	Return
- *		The syscall's return value.
+ *		The BPF program's return value.
  *
  * int bpf_set_retval(int retval)
  *	Description
- *		Set the syscall's return value that will be returned to userspace.
+ *		Set the BPF program's return value that will be returned to the upper layers.
+ *
+ *		This helper is currently supported by cgroup programs and only by the hooks
+ *		where BPF program's return value is returned to the userspace via errno.
+ *
+ *		Note that there is the following corner case where the program exports an error
+ *		via bpf_set_retval but signals success via 'return 1':
+ *
+ *			bpf_set_retval(-EPERM);
+ *			return 1;
+ *
+ *		In this case, the BPF program's return value will use helper's -EPERM. This
+ *		still holds true for cgroup/bind{4,6} which supports extra 'return 3' success case.
  *
- *		This helper is currently supported by cgroup programs only.
  *	Return
  *		0 on success, or a negative error in case of failure.
  *
-- 
2.37.1.595.g718a3a8f04-goog

