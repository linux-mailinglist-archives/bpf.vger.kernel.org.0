Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 305A263A5A
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2019 20:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbfGISAK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Jul 2019 14:00:10 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:33520 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbfGISAK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Jul 2019 14:00:10 -0400
Received: by mail-vk1-f201.google.com with SMTP id l80so3619402vkl.0
        for <bpf@vger.kernel.org>; Tue, 09 Jul 2019 11:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=eE901hT8R2cec0a/P3JUXxUcLDbh/ozDY5skKWvugSY=;
        b=nfhZ4cPCMV1EB/Em4l3UIu7WdNtfaMDsQNa1eXsjN6HNOV0/LVFnQDG71OvEOI1Afk
         x1WQsMApWjCgtcZ+2ZT6ixhYFaHFQNJcVAj5azIi6y4uJuToHNu4FuH3C+/D5oRyXi8L
         7HexPUYxRehA0KioBHIwVtRkajvhHmliEdQNdHoZu1ns7ub2phR8kLRcd3mvGewz1G7t
         +hJaz4Y2ZZh1JPIEfpvIwa1wgNJ/EJOzNfzDzfyp40seliHcR8lOT+LEp6AxJEFuvMVO
         csEHlZhQDbo95wG7zyk1oN6fF6meXytaoc2gEvxGODq4Lm6vQTdaiWmqriYuA3eIKoDj
         7W3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=eE901hT8R2cec0a/P3JUXxUcLDbh/ozDY5skKWvugSY=;
        b=kYreRXOzAbC3CgXIIUI1MbN8/6jO4e0DQFs3IBTip9/A4CQ5Ix9i1gtx4TqWlMwaVq
         C6gXZURbpmLxGGI5J5le51fmeHJQsWfscBB7PA+N4ijfRRHDP3zvSTCZoZYXM1PwqivZ
         kwT+LKj0cZBfRqE6EXLW55qZcTHVCv8l4JJj8DwZ+xsI8FcBuYGi+0nYAn9e0QhvHMGE
         RCi6yy/63kRtvNiH3rT/rlI7WQtrWC2ubxd3Ln46UYIu3INLi7A86n/RX2Ds6PMHkzub
         pPlxBx+rY6JIHBnDUSMfmuUSQjHZT7XucSrtMmhhi4qj/du7KcKjobWCpSHT8HOrvn9e
         RJsg==
X-Gm-Message-State: APjAAAXHfXBpXnMZi60+1c9lAA9VEFK7AGesQrJaEsxdREz50Ny7tZ0N
        hNzvek5Sy4eKpR1yJSvtbfHjzP+P8piaGn61
X-Google-Smtp-Source: APXvYqwD2WvwohQV90HUaS7J0WOgV9bCvpzuCOqvMRhI/HyBwQfswTU8DPrKF49s2asjwZPHHUfBWkv4jLuoF7I0
X-Received: by 2002:ab0:7442:: with SMTP id p2mr14401363uaq.92.1562695209169;
 Tue, 09 Jul 2019 11:00:09 -0700 (PDT)
Date:   Tue,  9 Jul 2019 11:00:03 -0700
Message-Id: <20190709180005.33406-1-allanzhang@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH bpf-next v8 0/2] bpf: Allow bpf_skb_event_output for more prog types
From:   Allan Zhang <allanzhang@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org, songliubraving@fb.com,
        daniel@iogearbox.net
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

