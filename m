Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 331B7697BD2
	for <lists+bpf@lfdr.de>; Wed, 15 Feb 2023 13:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233443AbjBOMdJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Feb 2023 07:33:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbjBOMdG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Feb 2023 07:33:06 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 797803669C;
        Wed, 15 Feb 2023 04:33:05 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id be8so20085885plb.7;
        Wed, 15 Feb 2023 04:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1IsC8ng/nt0IIOs5zLEhvzEjLU5ZtX7trPinF9wC4HY=;
        b=XpjVcbaAfAVK6cvQGU8LDsYr96rqAbvOVHsTzUlNZqTf6q6zEyEXhHiraiEGhgr6a4
         f8PSxKnB5I5nSqeED5HwnD7OFwqfdrbjru1pzgA0SzLob3RBUE/f22Sks3NVtY7if7PN
         LCvI/3Ug6wKAf5ihUKtvqERBxvgW0eFHx3n4iWOtDrliTYYvaiuQYFmpRef3q/+t4wNV
         ylIQA66PF8DlHMoCTeXnJq2RXyqBXBIdto+B4MZTSP0prH6tT3sY7OJbLUFZvsXPWr1Y
         v+F/zLqf9Wla01E4HQtZ0lJncCLgOB5vT41JeiqEeDxKpEg2gNRFNh2Qp8XWYf/FcDYB
         DhnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1IsC8ng/nt0IIOs5zLEhvzEjLU5ZtX7trPinF9wC4HY=;
        b=c80ieYSvL+YEUhXOWq3d6zH0kD/EVGzJPWFzpEBWxYtpSv6kXYSnT8v3d2mx7vTA06
         +60bWUlNzURoyK8rIRnlr3r5U98dRXLIZM/mK8rNEw2RwO8DifU1Q/5UK6Ts3TqwMWy0
         e5WJSGd02xtB8jTnPcPPgA3kq2ry45ALTL1wLfPmEiY6NAdn+k9sAXvm9RUlkvvQ9u8m
         65UJkWkskLTuUp/jPyoIK8Xm+QWSYXOqEJ46u0NOiyHedaBkQFULpHBLloZDHH5nHiMj
         W99fkZ65Uizzc19CiQbL7XyueCunjggZcp82hpeC5NbvjEpz4aQIDMV6U/JGIs64gqkf
         1pYQ==
X-Gm-Message-State: AO0yUKWp1rdIK4h95rQlPGLWZJEkiuJnbnLYwtYU9Qxj9zojxDBZMJsq
        oPSfVM3zfK2+cEJ2Un8WBKQ=
X-Google-Smtp-Source: AK7set9sYhrmqIc2PoBdRatAonL/QL6fPII6/8bPAa4/6SESq5JoJ9lV3XsruwM0w5/4COASa9t/rQ==
X-Received: by 2002:a05:6a20:e688:b0:b8:78dd:5fa2 with SMTP id mz8-20020a056a20e68800b000b878dd5fa2mr1533864pzb.52.1676464384335;
        Wed, 15 Feb 2023 04:33:04 -0800 (PST)
Received: from debian.me (subs03-180-214-233-93.three.co.id. [180.214.233.93])
        by smtp.gmail.com with ESMTPSA id u9-20020a63a909000000b004790eb3fee1sm10219535pge.90.2023.02.15.04.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 04:33:03 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 70F8C1055EA; Wed, 15 Feb 2023 19:32:58 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Power Management <linux-pm@vger.kernel.org>,
        Linux BPF Development <bpf@vger.kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, Huang Rui <ray.huang@amd.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Perry Yuan <perry.yuan@amd.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Wyes Karny <wyes.karny@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        oe-kbuild-all@lists.linux.dev
Subject: [PATCH 0/3] Documentation fixes for next-20230215
Date:   Wed, 15 Feb 2023 19:32:50 +0700
Message-Id: <20230215123253.41552-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=832; i=bagasdotme@gmail.com; h=from:subject; bh=/OLtDi2ZSSHFwhtEVzxXuHzhqWiXCRsIhg/ssojQQRs=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDMlvLry90P20YdMKq8sTi8OPLpn7s4x/y//U2uoXJT6mT/YV O+236ChlYRDjYpAVU2SZlMjXdHqXkciF9rWOMHNYmUCGMHBxCsBEUsQZ/md7dP5oNzG4fMz6/uOM62 vmpoTuMGs48nJlW+dHNekTttKMDPsNG7c8vf/mur7iF6c7rXpXuT311luYpmws56mVXf17GRMA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Here are fixes for documentation (htmldocs) warnings as reported for
next-20230215. The changelog below should be self-explanatory.

Each patch can be applied separately by respective maintainers.

Bagas Sanjaya (3):
  Documentation: hw-vuln: Wrap mitigate_smt_rsb example in literal code
    block
  Documentation: bpf: Add missing line break separator in node_data
    struct code block
  Documentation: amd-pstate: disambiguate user space sections

 Documentation/admin-guide/hw-vuln/cross-thread-rsb.rst | 3 ++-
 Documentation/admin-guide/pm/amd-pstate.rst            | 8 ++++----
 Documentation/bpf/graph_ds_impl.rst                    | 1 +
 3 files changed, 7 insertions(+), 5 deletions(-)


base-commit: 9d9019bcea1aac7eed64a1a4966282b6b7b141c8
-- 
An old man doll... just what I always wanted! - Clara

