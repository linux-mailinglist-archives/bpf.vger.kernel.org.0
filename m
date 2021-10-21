Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 875E3436359
	for <lists+bpf@lfdr.de>; Thu, 21 Oct 2021 15:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbhJUNug (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Oct 2021 09:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbhJUNuf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Oct 2021 09:50:35 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56385C0613B9
        for <bpf@vger.kernel.org>; Thu, 21 Oct 2021 06:48:19 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id u6-20020a17090a3fc600b001a00250584aso3170604pjm.4
        for <bpf@vger.kernel.org>; Thu, 21 Oct 2021 06:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EchErvKuG1pMSv87yNi99pHU0Il9TI5cOb42EriXsPk=;
        b=QdTrqAaR3++sxpS7J8e7QW36A3/RXvEJbSKGNdsZN+Ttyp3ocRp8KBKVEsZolr8JIg
         iHSRhq14AxQbDNBTiCkd/ueq/7IMMMhU7XDqUW0BINw/ckMzSVyq5uIDyhB3bbN9KAfq
         6fKu38oXIkRzPi8ZdQFiwn7pDEhplCXuvJ/6b/5snHN1QIURnzc5U6fK1eOtKBsF0OAl
         sqodjowj1p8rTkGw6EPWAeu4OvmWY+NZzpGRO2fhiSYM0XiaMxpWiSbXerIVsY03zE+4
         s26HX7rRPC+ysuTQvct+QLxl7OgLWYgZj7I/afT0UwVWRbbu+utpGo/NYHF6VnhdTkrY
         uW0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EchErvKuG1pMSv87yNi99pHU0Il9TI5cOb42EriXsPk=;
        b=f/VX4QdFJ68MN+xHuWx4pbT4U3EuEgRPh35hTrIsgeL0znlZ+M0NjfmxTFAzmfzNoa
         DH4JedYCOXAhk+3yh0xqQ+i0vvTKlF1e/wlUzwn24mcxocF/q+QzybP0SrAl2o7f9+o7
         37iMrNRBm2ZCp3Eg1W/w+4avGmtlCpohGVV88OQYh7RBF/isxY1HIVjCI4zaXV1ARFbB
         1ZH1o+4ENDXfC/a2x4KJP+ks3LQPUAZ8HBueJoLQr3XQHKRtSab9QfWkJsiQu8p+1ZMa
         1fDyrFwTj/liNZk5ElIMXp+EnTT8CYUS7CK3XgOO+qIasVKDphVg8hyMLPvna6GQmdOo
         EU8A==
X-Gm-Message-State: AOAM530tbDMBzXdhcD4UFN7nswpAR7aWU0V9ktxNPgwdoBBkbTmyGSJ+
        dRrWO6LgxntoHlAyuBKsehPesk+U5XHxIg==
X-Google-Smtp-Source: ABdhPJzDJc3q+kxotDUSiW4JD+QGQm5PbDSUDqIrt5UN61jwN13dYZfiXy94EX550UXqtF19qU/aeg==
X-Received: by 2002:a17:90b:782:: with SMTP id l2mr6670657pjz.190.1634824098727;
        Thu, 21 Oct 2021 06:48:18 -0700 (PDT)
Received: from VM-32-4-ubuntu.. ([43.132.164.184])
        by smtp.gmail.com with ESMTPSA id f21sm6830067pfc.203.2021.10.21.06.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 06:48:18 -0700 (PDT)
From:   Hengqi Chen <hengqi.chen@gmail.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kafai@fb.com,
        songliubraving@fb.com, hengqi.chen@gmail.com
Subject: [PATCH bpf-next v3 0/2] Add bpf_skc_to_unix_sock() helper
Date:   Thu, 21 Oct 2021 21:47:50 +0800
Message-Id: <20211021134752.1223426-1-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch set adds a new BPF helper bpf_skc_to_unix_sock().
The helper is used in tracing programs to cast a socket
pointer to a unix_sock pointer.

v2->v3:
 - Use abstract socket in selftest (Alexei)
 - Run checkpatch script over patches (Andrii)

v1->v2:
 - Update selftest, remove trailing spaces changes (Song)

Hengqi Chen (2):
  bpf: Add bpf_skc_to_unix_sock() helper
  selftests/bpf: Test bpf_skc_to_unix_sock() helper

 include/linux/bpf.h                           |  1 +
 include/uapi/linux/bpf.h                      |  7 +++
 kernel/trace/bpf_trace.c                      |  2 +
 net/core/filter.c                             | 23 ++++++++
 scripts/bpf_doc.py                            |  2 +
 tools/include/uapi/linux/bpf.h                |  7 +++
 .../bpf/prog_tests/skc_to_unix_sock.c         | 54 +++++++++++++++++++
 .../bpf/progs/test_skc_to_unix_sock.c         | 40 ++++++++++++++
 8 files changed, 136 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/skc_to_unix_sock.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_skc_to_unix_sock.c

--
2.30.2
