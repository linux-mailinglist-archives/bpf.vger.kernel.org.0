Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FDD847B557
	for <lists+bpf@lfdr.de>; Mon, 20 Dec 2021 22:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbhLTVpd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Dec 2021 16:45:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbhLTVpc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Dec 2021 16:45:32 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F59FC061574
        for <bpf@vger.kernel.org>; Mon, 20 Dec 2021 13:45:32 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id t18so22700285wrg.11
        for <bpf@vger.kernel.org>; Mon, 20 Dec 2021 13:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=ReHMahL4Bz1cnsNzSLZyAh5glpyLPXN+HRkz+TSIBBE=;
        b=yvg3lbHQy2PB+NWmy0b9NmuRIdjvZx8ihS/5n0UQegbi26fiYb1QE3YZ0owxymk23U
         IZzHsG6KXCzr/Au2Nsavn6IDlXaDMhmZNoTspBhF9uLbQY+ZphRzgIarZrjPvsdOgzUb
         xFQRF8eQ+2rgOE/z/Hm4Sj7NFXdvkxuKUCXERU9V7L4KGqkmAnA+U/6zskDy3ksOWqP8
         RUHB6VrSVxOiQw6QELO3vo3NzNXr2Myaae6/bUl7AO/vPDclFfkY69tTzN/G4CMq8+zQ
         fnxbl7CtRyfyYrB7gnwDfYaD4VLhQBvuWuaKcENuI9nLjIBncmCqw5U+AS9rvItXQLCn
         ckLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=ReHMahL4Bz1cnsNzSLZyAh5glpyLPXN+HRkz+TSIBBE=;
        b=rIeoZ9FPXS0soxUu6UIIOSbeWd8ANnVup5ulXyOT8DMnHsSZ/BaLw/mJfy2ftFvRBN
         rlt547+2LRQ6McnripDF+NKXyImVf/Uz2HFFYJ7EWEPFuyXIb+IWWgF6Hp3W07fUl0Jt
         l707MMf0/gMHnZ3xcX7E5RRnZ1VIDF28/EGBQq69Y+T+aVxjeSDsJ2UkUaO6VZnO8zTq
         KXdIYidh8Xo66rcYbsV+B1puUfLGeca+81/iPNZW/Ky6SZBmDt9M/hzQqXq1lRd0rq3s
         1H9PMU6Efa0KIbhaElCdVVzRr9v/7iIbGRMRPibXkpn59a5Xs9gj9HGfeovSV5n2Pykl
         /Scw==
X-Gm-Message-State: AOAM532E7LJkmZK21MuzDjdhFeHrh2n5xgAVkEQMSOUbvtg2xkh+yHbU
        98B09Ysbr7wh8+10EJFhqk3N
X-Google-Smtp-Source: ABdhPJwkAkw7AsvLZ/kl1NOv7/HeRW2myK5wazsZQNbKfcIvoHTB/fdB4ncPStDuQrpNTHae8hay9Q==
X-Received: by 2002:adf:9004:: with SMTP id h4mr47016wrh.593.1640036730621;
        Mon, 20 Dec 2021 13:45:30 -0800 (PST)
Received: from Mem (2a01cb088160fc00f5af1551c2b57bb2.ipv6.abo.wanadoo.fr. [2a01:cb08:8160:fc00:f5af:1551:c2b5:7bb2])
        by smtp.gmail.com with ESMTPSA id s1sm445558wmh.35.2021.12.20.13.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 13:45:30 -0800 (PST)
Date:   Mon, 20 Dec 2021 22:45:28 +0100
From:   Paul Chaignon <paul@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf v3] bpftool: Enable line buffering for stdout
Message-ID: <20211220214528.GA11706@Mem>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The output of bpftool prog tracelog is currently buffered, which is
inconvenient when piping the output into other commands. A simple
tracelog | grep will typically not display anything. This patch fixes it
by enabling line buffering on stdout for the whole bpftool binary.

Fixes: 30da46b5dc3a ("tools: bpftool: add a command to dump the trace pipe")
Signed-off-by: Quentin Monnet <quentin@isovalent.com>
Signed-off-by: Paul Chaignon <paul@isovalent.com>
---
Changes in v3:
  - Title changed from "bpftool: Flush tracelog output".
  - Enable line buffering for all of bpftool, as suggested by Andrii.
  - Rebased on bpf.
Changes in v2:
  - Resending to fix a format error.

 tools/bpf/bpftool/main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
index 28237d7cef67..8fbcff9d557d 100644
--- a/tools/bpf/bpftool/main.c
+++ b/tools/bpf/bpftool/main.c
@@ -400,6 +400,8 @@ int main(int argc, char **argv)
 	};
 	int opt, ret;
 
+	setlinebuf(stdout);
+
 	last_do_help = do_help;
 	pretty_output = false;
 	json_output = false;
-- 
2.25.1

