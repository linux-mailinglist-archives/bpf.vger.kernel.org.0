Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4B04F109
	for <lists+bpf@lfdr.de>; Sat, 22 Jun 2019 01:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbfFUXQ4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Jun 2019 19:16:56 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:43599 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfFUXQz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Jun 2019 19:16:55 -0400
Received: by mail-pg1-f202.google.com with SMTP id p7so4932659pgr.10
        for <bpf@vger.kernel.org>; Fri, 21 Jun 2019 16:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=9PdGwLy1mM/ZLJdwl5NFEAnMyG/HeH/hHEoctq0zwqU=;
        b=njXISLkrndmcqBcLnF/JExTh5XBHtoCPItkFCRI61ScX25wAdiXZdicB/6JIicdQN/
         CyjrBb1sw5Uc7mE0RjmQewkyS6XmeN7okIeCI0UWIZfkHDZpG2C4PZKVFaG802B/B7KG
         p6HrcEup8pXj3PHgBq5FoWhFGaYKkyz081ngycm6GlJIluk8LgG3yl6udKvbTEBqAQ1S
         RKYaFJqkc4t9sg4CjkKBu3NjLGrtxdUioV4euZ6Q3kOclJo1L4S04s6njUlUIqKpiSGW
         uUDEHYQnMQJPMzEFQrXgcFu1c0xPQznjCJV/gIrVFnRfF9CX0ZwcNczzZ9x69mQodbk9
         t/5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=9PdGwLy1mM/ZLJdwl5NFEAnMyG/HeH/hHEoctq0zwqU=;
        b=cMG4ZG6gikBuFfuHSJ+viSVFcWpq8GgY8X4ErXwWEsqNF3mWRdKA7kChtSfI4Rb243
         YSsGIc0JgGYpVedgf/UbfzRuWAsnyJqAZPVfTYrHYAxrc7COVJ3TF0VdGlvOz90eaEH4
         qgZzXkj6QAlfS9H4B98aHSNoTK4i0v7eY2+1LsEoaQOhpGMhkVubA4qpdTPn8/uS9GZo
         Mk4BQLj4KJ7YTf878Akl5MP7kDwAVkwnTNSeObdNymc5rwxTFzCPgsfbyDROspRY7cO0
         OQj0QwPP558kqd884dPTlrzZZP6wtSBOeKzNahiwg6f9k+brzhG02ABmetUFEkT5I2zv
         qRqg==
X-Gm-Message-State: APjAAAVeC1Zpv2laGMvVSfwsoEA18ebvov4tBqEmkXOGCFaz9pjsFXXt
        MidyALZPyeBRW2MlEg0vMsRxKCOQuilM
X-Google-Smtp-Source: APXvYqw3R8uRDdGAiWcWKoTtbaC0NhEW8qdXMhY61IxaPC3W/Z/bPMYvTiz0gPiA8JFU9JhxWn2sq4RYIZ0H
X-Received: by 2002:a65:404a:: with SMTP id h10mr21335826pgp.262.1561159014649;
 Fri, 21 Jun 2019 16:16:54 -0700 (PDT)
Date:   Fri, 21 Jun 2019 16:16:44 -0700
Message-Id: <20190621231650.32073-1-brianvv@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [RFC PATCH 0/6] bpf: add BPF_MAP_DUMP command to access more
From:   Brian Vazquez <brianvv@google.com>
To:     Brian Vazquez <brianvv.kernel@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S . Miller" <davem@davemloft.net>
Cc:     Stanislav Fomichev <sdf@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Petar Penkov <ppenkov@google.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Brian Vazquez <brianvv@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This introduces a new command to retrieve a variable number of entries
from a bpf map.

This new command can be executed from the existing BPF syscall as follows:

err =  bpf(BPF_MAP_DUMP, union bpf_attr *attr, u32 size)
using attr->dump.map_fd, attr->dump.prev_key, attr->dump.buf,
attr->dump.buf_len
returns zero or negative error, and populates buf and buf_len on
succees

This implementation is wrapping the existing bpf methods:
map_get_next_key and map_lookup_elem
the results show that even with a 1-elem_size buffer, it runs ~40 faster
than the current implementation, improvements of ~85% are reported when
the buffer size is increased, although, after the buffer size is around
5% of the total number of entries there's no huge difference in increasing
it.

Tested:
Tried different size buffers to handle case where the bulk is bigger, or
the elements to retrieve are less than the existing ones, all runs read
a map of 100K entries. Below are the results(in ns) from the different
runs:

buf_len_1:       55528939 entry-by-entry: 97244981 improvement 42.897887%
buf_len_2:       34425779 entry-by-entry: 88863122 improvement 61.259769%
buf_len_230:     11700316 entry-by-entry: 88753301 improvement 86.817036%
buf_len_5000:    11615290 entry-by-entry: 88362637 improvement 86.854976%
buf_len_73000:   12083976 entry-by-entry: 89956483 improvement 86.566865%
buf_len_100000:  12638913 entry-by-entry: 89642303 improvement 85.900727%
buf_len_234567:  11873964 entry-by-entry: 89080077 improvement 86.670461%

Suggested-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: Brian Vazquez <brianvv@google.com>

Brian Vazquez (6):
  bpf: add bpf_map_value_size and bp_map_copy_value helper functions
  bpf: add BPF_MAP_DUMP command to access more than one entry per call
  bpf: keep bpf.h in sync with tools/
  libbpf: support BPF_MAP_DUMP command
  selftests/bpf: test BPF_MAP_DUMP command on a bpf hashmap
  selftests/bpf: add test to measure performance of BPF_MAP_DUMP

 include/uapi/linux/bpf.h                |   9 +
 kernel/bpf/syscall.c                    | 242 ++++++++++++++++++------
 tools/include/uapi/linux/bpf.h          |   9 +
 tools/lib/bpf/bpf.c                     |  28 +++
 tools/lib/bpf/bpf.h                     |   4 +
 tools/lib/bpf/libbpf.map                |   2 +
 tools/testing/selftests/bpf/test_maps.c | 141 +++++++++++++-
 7 files changed, 372 insertions(+), 63 deletions(-)

-- 
2.22.0.410.gd8fdbe21b5-goog

