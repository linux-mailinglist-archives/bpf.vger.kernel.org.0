Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49697641054
	for <lists+bpf@lfdr.de>; Fri,  2 Dec 2022 23:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbiLBWHq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 2 Dec 2022 17:07:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234369AbiLBWHm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 2 Dec 2022 17:07:42 -0500
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DFDFE02F;
        Fri,  2 Dec 2022 14:07:39 -0800 (PST)
Received: by mail-qt1-f179.google.com with SMTP id a27so7121218qtw.10;
        Fri, 02 Dec 2022 14:07:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lkTcKNMIja3P0DZgrqBZsD+lkTUQzIAo4sE7fLKbeNA=;
        b=pm5n4aLa3Bm1V9CrTYzDs8FeMzPzxrDNEa+E6jKdvB2ZSqt3mDpP1t3jh/eYTZHwuA
         4lsAb+KErcKNUN3FMQoe78JbEzONi7h9hYXppEu8xa5nDKXQBqBeab1kll4CbYciKIiK
         CPa0/cPT+mUolkJy1UtFR6CxT7yYI3wKhrsQ/07wsrZN6rU8SP/r4SpQtmyDfyyAI1D4
         zXL9PRgY/fRy+dgbwbaCjvw4GeZ/JIQyiSGagXz0PcVh9Zk9G+DsL6zpbQYSF0Cd0d+p
         ekqQTUHqMmnlWBqaXORvmrot/vhRsPO5pcJlw1VggV3hoNntILzdDW5Q55l56mOc6Cql
         o0fQ==
X-Gm-Message-State: ANoB5pklXwNaJhuCAZO9xLMwVR3GFBss74jzqOvgbhhc9N+ct18/i2HB
        vOFgmMn29TLUtVIAAhZzRvtUo+5gvRUHa6bs
X-Google-Smtp-Source: AA0mqf7dI94abK6G2EtGz9/cIoAc+IZNkkKPqmr7Cvj7t49xVsPGant49Sg2Xu4Qdraq8FmVo+rIZw==
X-Received: by 2002:a05:622a:13d3:b0:3a6:8f93:11e with SMTP id p19-20020a05622a13d300b003a68f93011emr11357735qtk.474.1670018858009;
        Fri, 02 Dec 2022 14:07:38 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:6d2e])
        by smtp.gmail.com with ESMTPSA id p26-20020ac8461a000000b003a50d92f9b4sm4912630qtn.1.2022.12.02.14.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 14:07:37 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@meta.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com
Subject: [PATCH bpf-next 0/2] Document some recent core kfunc additions
Date:   Fri,  2 Dec 2022 16:07:34 -0600
Message-Id: <20221202220736.521227-1-void@manifault.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

A series of recent patch sets introduced kfuncs that allowed struct
task_struct and struct cgroup objects to be used as kptrs. These were
introduced in [0], [1], and [2].

[0]: https://lore.kernel.org/lkml/20221120051004.3605026-1-void@manifault.com/
[1]: https://lore.kernel.org/lkml/20221122145300.251210-2-void@manifault.com/T/
[2]: https://lore.kernel.org/lkml/20221122055458.173143-1-void@manifault.com/

These are "core" kfuncs, in that they may be used by a wide variety of
possible BPF tracepoint or struct_ops programs, and are defined in
kernel/bpf/helpers.c. Even though as kfuncs they have no ABI stability
guarantees, they should still be properly documented. This patch set
adds that documentation.

Some other kfuncs were added recently as well, such as
bpf_rcu_read_lock() and bpf_rcu_read_unlock(). Those could and should be
added to this "Core kfuncs" section as well in other patch sets.

David Vernet (2):
  bpf/docs: Document struct task_struct * kfuncs
  bpf/docs: Document struct cgroup * kfuncs

 Documentation/bpf/kfuncs.rst | 198 +++++++++++++++++++++++++++++++++++
 kernel/bpf/helpers.c         |  10 +-
 2 files changed, 203 insertions(+), 5 deletions(-)

-- 
2.38.1

