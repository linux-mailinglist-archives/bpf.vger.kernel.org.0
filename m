Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47A0E204F19
	for <lists+bpf@lfdr.de>; Tue, 23 Jun 2020 12:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732172AbgFWKfD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Jun 2020 06:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732076AbgFWKfC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Jun 2020 06:35:02 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEC82C061755
        for <bpf@vger.kernel.org>; Tue, 23 Jun 2020 03:35:02 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id s1so22867077ljo.0
        for <bpf@vger.kernel.org>; Tue, 23 Jun 2020 03:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ckNZyFhILcN6tTy3sbdLcXRbhqu7O7I6+l82jLAf/oo=;
        b=gcLnIZwmr46yO7C7Aw8/ee5lRzLULbGM2uebrVAIdF/WaITv2S6PkqlN8HPJN7F8fk
         KlVEzPOK4FhzfWA7TCTNqdSvVMPujpG0zMLbSQlVm1/jL8uULEifZnww0qRHh8MpPWe2
         TQgl0WrDjPkhJayWRcvGb4SdJY9R1ZAJYCfa0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ckNZyFhILcN6tTy3sbdLcXRbhqu7O7I6+l82jLAf/oo=;
        b=h5XBWcpnlUQ2yoVIh+xD1AOVTjgllVbo4sxXz/mP1fiK8VdXFVRKvbK8ntPrvj6W5r
         lGOT2wQn92IoYDShIU6p8pZbdQkLqC7QwmPqvzaTfb82176mZ0LP/pi9nucNHSVKa8Mb
         cP923hqdaKBydlNcyVUGZ01lrtbg9/UiPwqwDdUR7WaYXaWLycZF9ncK3fQsdspNdRrJ
         kLwzw1eGwJi6wUyCbSQ4kPwgVRD5MdxZ+/0hDTDWknwBAo2bbv9D3iAnYRNPDloH+Kuh
         RC/ltDp3Hmgm1nZexhYfrPRT1YpdJGluBqhfzS9JIb34aBx0D0AjL+M/5zEpIWGjpenp
         KTiQ==
X-Gm-Message-State: AOAM530bQxj84fA2McMS3v9x6LCJhMJh7W8F3rxRLqW5A0P4PY3rNvpE
        JsquuHHLGUzdzsqabfsU+du9sWUf8Ni0ow==
X-Google-Smtp-Source: ABdhPJxD7hsOiiFUc+D1OLjeylemR8lyswAtHxnKLHjYnJUMSYZkyKFIXWfnI/I7ZiePV8v4vmkhQA==
X-Received: by 2002:a2e:b814:: with SMTP id u20mr11807935ljo.261.1592908500718;
        Tue, 23 Jun 2020 03:35:00 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id w20sm2871301lfe.66.2020.06.23.03.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 03:35:00 -0700 (PDT)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, kernel-team@cloudflare.com,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Stanislav Fomichev <sdf@google.com>
Subject: [PATCH bpf-next v2 0/3] bpf, netns: Prepare for multi-prog attachment
Date:   Tue, 23 Jun 2020 12:34:56 +0200
Message-Id: <20200623103459.697774-1-jakub@cloudflare.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch set prepares ground for link-based multi-prog attachment for
future netns attach types, with BPF_SK_LOOKUP attach type in mind [0].

Two changes are needed in order to attach and run a series of BPF programs:

  1) an bpf_prog_array of programs to run (patch #2), and
  2) a list of attached links to keep track of attachments (patch #3).

I've been using these patches with the next iteration of BPF socket lookup
hook patches, and saw that they are self-contained and can be split out to
ease the review burden.

Nothing changes for BPF flow_dissector. That is at most one prog can be
attached.

Thanks,
-jkbs

[0] https://lore.kernel.org/bpf/20200511185218.1422406-1-jakub@cloudflare.com/

Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Stanislav Fomichev <sdf@google.com>

v1 -> v2:

- Show with a (void) cast that bpf_prog_array_replace_item() return value
  is ignored on purpose. (Andrii)
- Explain why bpf-cgroup cannot replace programs in bpf_prog_array based
  on bpf_prog pointer comparison in patch #2 description. (Andrii)

Jakub Sitnicki (3):
  flow_dissector: Pull BPF program assignment up to bpf-netns
  bpf, netns: Keep attached programs in bpf_prog_array
  bpf, netns: Keep a list of attached bpf_link's

 include/linux/bpf.h          |   3 +
 include/net/flow_dissector.h |   3 +-
 include/net/netns/bpf.h      |   7 +-
 kernel/bpf/core.c            |  20 +++-
 kernel/bpf/net_namespace.c   | 189 +++++++++++++++++++++++++----------
 net/core/flow_dissector.c    |  34 +++----
 6 files changed, 173 insertions(+), 83 deletions(-)

-- 
2.25.4

