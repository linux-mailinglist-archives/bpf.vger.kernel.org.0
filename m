Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE367233E
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2019 02:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbfGXAHa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Jul 2019 20:07:30 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:54956 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbfGXAHa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Jul 2019 20:07:30 -0400
Received: by mail-pf1-f201.google.com with SMTP id y66so27281580pfb.21
        for <bpf@vger.kernel.org>; Tue, 23 Jul 2019 17:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=NxZhietoTxqmHe7rhjQcGEBlG21hpAW5k0nWsJXcXr4=;
        b=wOarilnMKZx4cITmPTK6cSjWrdOahcgXqFP1HIM05QQIGN6xajWlMfEHips/l2h3KT
         Y2RBWVJc5NsEq9qvzKsW9H4x/RQjAkwa832tcCNtSOZdO3CLIlwLWEOkJb9Qy1Ad/J40
         JL7RA1tZxgECFkzQiLNw3wvfd7BxXBv32uXA9nbLJWXZQmcFrUrsta5sAJb1V1CWvdJd
         qFD2Lgnp3WeQA/xf6Th58gpZ8sJ7dybG5/CQz9Viv29TPw9zT6wAYkMDlSUKqB40nYFg
         LZ3KGqny1zAKazPvmql1ZdJinKfsXFcRmJvWsw0A9ay54eIvPbrNUuov7ZwLH2yAm3cz
         +3xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=NxZhietoTxqmHe7rhjQcGEBlG21hpAW5k0nWsJXcXr4=;
        b=DIIOMPbZLXEB00R19hUDG3iNNZNDG2B6Pnt+DKEk03eVXyA20LA0t7d0PjxO7STuPL
         KWY2F/Y5KgaX68tCfNp/QcZpLmXZ3Q+uBvVeZGhVoAUkI0JUJVn9d0iJTSeLzZ0JjJOT
         MJgMI/sdUBcvYIuwYpn5w/SW0PrB6iIB+KEqKiqcnFUYO37TT9J9WFfinWc1KAqRSHgw
         lduQh/tyMfOufKoLKqhG4mfppBfykc4+c8ACIe9lC86hylFZ7q0IDoSgIqBInjWGeRJK
         9J7FtpfVNKM9lau0nA3m6e2bYyfqfkKcWvSXPcnuqMUk4r/vie9Lsu/blD88H0yqUmvX
         fAjQ==
X-Gm-Message-State: APjAAAVmUgyL2JsIILbs9MbbvPBsoYyIXicboE7JeGzltjbF2d4J5s3a
        7yP3kfqbZNtk0+4OU+KjrHCRFnKUmYEPXoln
X-Google-Smtp-Source: APXvYqxqwVH+wUgI7kJKRoRGynBiBbLyVCYeeu36YD5QY4xlH72vjCuk/pzuVz7PHeu8kqdqm6wepAHHcP9fZ9aH
X-Received: by 2002:a65:6846:: with SMTP id q6mr39921085pgt.150.1563926849500;
 Tue, 23 Jul 2019 17:07:29 -0700 (PDT)
Date:   Tue, 23 Jul 2019 17:07:23 -0700
Message-Id: <20190724000725.15634-1-allanzhang@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
Subject: [PATCH bpf-next v10 0/2] bpf: Allow bpf_skb_event_output for more
 prog types
From:   Allan Zhang <allanzhang@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org, songliubraving@fb.com,
        daniel@iogearbox.net, andrii.nakryiko@gmail.com
Cc:     ast@kernel.org, Allan Zhang <allanzhang@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Software event output is only enabled by a few prog types right now (TC,
LWT out, XDP, sockops). Many other skb based prog types need
bpf_skb_event_output to produce software event.

More prog types are enabled to access bpf_skb_event_output in this
patch.

v10 changes:
Resubmit (v9 is submitted when bpf branch is closed).

v9 changes:
add "Acked-by" field.

v8 changes:
No actual change, just cc to netdev@vger.kernel.org and
bpf@vger.kernel.org.
v7 patches are acked by Song Liu.

v7 changes:
Reformat from hints by scripts/checkpatch.pl, including Song's comment
on signed-off-by name to captical case in cover letter.
3 of hints are ignored:
1. new file mode.
2. SPDX-License-Identifier for event_output.c since all files under
   this dir have no such line.
3. "Macros ... enclosed in parentheses" for macro in event_output.c
   due to code's nature.

Change patch 02 subject "bpf:..." to "selftests/bpf:..."

v6 changes:
Fix Signed-off-by, fix fixup map creation.

v5 changes:
Fix typos, reformat comments in event_output.c, move revision history to
cover letter.

v4 changes:
Reformating log message.

v3 changes:
Reformating log message.

v2 changes:
Reformating log message.

Allan Zhang (2):
  bpf: Allow bpf_skb_event_output for a few prog types
  selftests/bpf: Add selftests for bpf_perf_event_output

 net/core/filter.c                             |  6 ++
 tools/testing/selftests/bpf/test_verifier.c   | 12 ++-
 .../selftests/bpf/verifier/event_output.c     | 94 +++++++++++++++++++
 3 files changed, 111 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/verifier/event_output.c

-- 
2.22.0.410.gd8fdbe21b5-goog

