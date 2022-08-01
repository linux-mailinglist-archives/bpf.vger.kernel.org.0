Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5CCC587009
	for <lists+bpf@lfdr.de>; Mon,  1 Aug 2022 20:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233703AbiHASCT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Aug 2022 14:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233658AbiHASCR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Aug 2022 14:02:17 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3DF125E91
        for <bpf@vger.kernel.org>; Mon,  1 Aug 2022 11:02:15 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-10ee900cce0so2626061fac.5
        for <bpf@vger.kernel.org>; Mon, 01 Aug 2022 11:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=neYCRoMJHZhrkPomT+D8lBoa9lWbM2Zjq7tdhg++BD8=;
        b=Mhxk6WOQ1kBwvZATBE/fUmbfdcWPONvbLqPeeFwjgpXx30ZOq9K8e9XiO+heooXplM
         yIxZGuPYi6Y3upntqiTXP/fp9FqKCw4yfTan+k9O5EO5dpK1xku83lnqrHR4EC2zmuYi
         1Wtv13AgwXk1J74t2M0Zv22JEVrbvaw3bB9ww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=neYCRoMJHZhrkPomT+D8lBoa9lWbM2Zjq7tdhg++BD8=;
        b=57aidxWoAEj/xH9Ogeky84BaMjITU3fbPe3wzvpioqQHnyBpwhS+jZp/kh1ryDIrtg
         xKEx6CUAC+/Kni+HtRsYBGLk2wDvaTC/WJaRcQU9m/T1wRH4I8z6BnUhomr9YT3E/mZs
         VtbfiUqaUA4prOvrCvSKA23YtRja8Bho9+0+0oIlZHX+2lM1GMFjWR7ltwoLzrrjRiJV
         ykPCd4FXISDMH7OyQ25UZDNPbWFfd9cS+3si8a8F3F43GagtDpyYVO4OwC2N8qexjO8W
         FaJrQ2pnQUCZuMgpVeRfEklkp0NQDicV9lQ0FniAqM0NWFc9AMTKL+gOgiP8T32uEn5c
         Ij9g==
X-Gm-Message-State: AJIora/AUuJOpQoxWtiUGXMYPJeKFm48hY/zL8ZraXSJ9FXVL5w3Mf68
        bh+bKfhHUaFyZUgQCVIQwZUQhA==
X-Google-Smtp-Source: AGRyM1s00uyA5RxFeoJiOwnWUCMdS5VnKo6fHkNTdsQVmzGj5TtMhEcfqeGl5rB5c+kZha+7htuYfg==
X-Received: by 2002:a05:6870:4302:b0:10d:c587:d30e with SMTP id w2-20020a056870430200b0010dc587d30emr7992216oah.28.1659376935129;
        Mon, 01 Aug 2022 11:02:15 -0700 (PDT)
Received: from localhost.localdomain ([184.4.90.121])
        by smtp.gmail.com with ESMTPSA id n14-20020a9d64ce000000b00618fa37308csm2881348otl.35.2022.08.01.11.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 11:02:14 -0700 (PDT)
From:   Frederick Lawler <fred@cloudflare.com>
To:     kpsingh@kernel.org, revest@chromium.org, jackmanb@chromium.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, jmorris@namei.org, serge@hallyn.com,
        paul@paul-moore.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, shuah@kernel.org, brauner@kernel.org,
        casey@schaufler-ca.com, ebiederm@xmission.com, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        kernel-team@cloudflare.com, cgzones@googlemail.com,
        karl@bigbadwolfsecurity.com, Frederick Lawler <fred@cloudflare.com>
Subject: [PATCH v4 0/4] Introduce security_create_user_ns()
Date:   Mon,  1 Aug 2022 13:01:42 -0500
Message-Id: <20220801180146.1157914-1-fred@cloudflare.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

While creating a LSM BPF MAC policy to block user namespace creation, we
used the LSM cred_prepare hook because that is the closest hook to prevent
a call to create_user_ns().

The calls look something like this:

    cred = prepare_creds()
        security_prepare_creds()
            call_int_hook(cred_prepare, ...
    if (cred)
        create_user_ns(cred)

We noticed that error codes were not propagated from this hook and
introduced a patch [1] to propagate those errors.

The discussion notes that security_prepare_creds()
is not appropriate for MAC policies, and instead the hook is
meant for LSM authors to prepare credentials for mutation. [2]

Ultimately, we concluded that a better course of action is to introduce
a new security hook for LSM authors. [3]

This patch set first introduces a new security_create_user_ns() function
and userns_create LSM hook, then marks the hook as sleepable in BPF.

Links:
1. https://lore.kernel.org/all/20220608150942.776446-1-fred@cloudflare.com/
2. https://lore.kernel.org/all/87y1xzyhub.fsf@email.froward.int.ebiederm.org/
3. https://lore.kernel.org/all/9fe9cd9f-1ded-a179-8ded-5fde8960a586@cloudflare.com/

Past discussions:
V3: https://lore.kernel.org/all/20220721172808.585539-1-fred@cloudflare.com/
V2: https://lore.kernel.org/all/20220707223228.1940249-1-fred@cloudflare.com/
V1: https://lore.kernel.org/all/20220621233939.993579-1-fred@cloudflare.com/

Changes since v3:
- Explicitly set CAP_SYS_ADMIN to test namespace is created given
  permission
- Simplify BPF test to use sleepable hook only
- Prefer unshare() over clone() for tests
Changes since v2:
- Rename create_user_ns hook to userns_create
- Use user_namespace as an object opposed to a generic namespace object
- s/domB_t/domA_t in commit message
Changes since v1:
- Add selftests/bpf: Add tests verifying bpf lsm create_user_ns hook patch
- Add selinux: Implement create_user_ns hook patch
- Change function signature of security_create_user_ns() to only take
  struct cred
- Move security_create_user_ns() call after id mapping check in
  create_user_ns()
- Update documentation to reflect changes

Frederick Lawler (4):
  security, lsm: Introduce security_create_user_ns()
  bpf-lsm: Make bpf_lsm_userns_create() sleepable
  selftests/bpf: Add tests verifying bpf lsm userns_create hook
  selinux: Implement userns_create hook

 include/linux/lsm_hook_defs.h                 |   1 +
 include/linux/lsm_hooks.h                     |   4 +
 include/linux/security.h                      |   6 ++
 kernel/bpf/bpf_lsm.c                          |   1 +
 kernel/user_namespace.c                       |   5 +
 security/security.c                           |   5 +
 security/selinux/hooks.c                      |   9 ++
 security/selinux/include/classmap.h           |   2 +
 .../selftests/bpf/prog_tests/deny_namespace.c | 102 ++++++++++++++++++
 .../selftests/bpf/progs/test_deny_namespace.c |  33 ++++++
 10 files changed, 168 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/deny_namespace.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_deny_namespace.c

-- 
2.30.2

