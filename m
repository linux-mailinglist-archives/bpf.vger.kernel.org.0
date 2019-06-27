Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80E2358B91
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2019 22:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbfF0UY3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Jun 2019 16:24:29 -0400
Received: from mail-vk1-f202.google.com ([209.85.221.202]:42955 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbfF0UY2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Jun 2019 16:24:28 -0400
Received: by mail-vk1-f202.google.com with SMTP id y198so1012414vky.9
        for <bpf@vger.kernel.org>; Thu, 27 Jun 2019 13:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=hnna79W33XQAUXPg9/1+75Om8IQv4yeuG+2GOpSRqBk=;
        b=nxoAM6/0hGn9NpaSYkYsfcEUMyOmigbO9cRWQGsKt89RvIm2YqeNo//qXLvo8oP3PS
         044tGgQaJF6TUV2OD1DOGYhpWiVRgmNgcIieqC4IxiN7jF46Q2vEdgWcMNciwawDG/AQ
         qmU8RI9XseqCOqRMIO4iOtL0dAQYkRx+mkzpto6iDU6t/RtQ5oMsx7h4xDmKBIByaz2u
         C3lTXK7g9C1k5hrluQjotj5WqqIcZqTDZakn/6bA8HJ+1ccSkOHQBeI2DFslXr/X214I
         9+Qc6yCYXZjKdDeW5LcFVq/qi3wbLHBba78weED+B0NMjwDU95y86cTEVN9MMrDEllPL
         oZeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=hnna79W33XQAUXPg9/1+75Om8IQv4yeuG+2GOpSRqBk=;
        b=p9aHD0cf2lt2NvRVjxxtTKMA5Sj1cthQ9mE51lvGDAw1ZcIZkvJDh8f6rBCvt+WCVy
         zhnvquvAYvietBpU6clbtd2g4NT/+qMnYTnZn4qTF+lR8Yq5XZvLyZvE+I479u10y9o2
         fSEKnF+ofkmAN/ufgY4LZyG+v42svS/O2mBNo1H8rIx8a7XHqDsdK8Tkw9t7sUuZ0gqJ
         ocpHyS7ug/MU3WeJY0SXG+4l1Ewy3V/iKw21BnOfNOJ8PnGrWxftIAc/O30q0/9uOOco
         4sCnJPUS7Y7jt8BLuMEXPJ1ZbdrRaR2vqU+PFs7PJDcfOKivjFbuj569qkdh3jzNZOXY
         WeNg==
X-Gm-Message-State: APjAAAVaO5rwowt01qN4Jb7fiJwZmd0pNW5OyJ5fS6pXzRVeOSh6ulSn
        uFprf2/2f1triyVQGj6+GIMZnYerTG1f
X-Google-Smtp-Source: APXvYqyGMmarmCuZNKwB2NjDgUL40WdgGdUxR1eho0gTMhTpsyVa2Pg7TtSOJs9XeWofmor+SkOYMqXqeQFV
X-Received: by 2002:a1f:50c1:: with SMTP id e184mr2322952vkb.86.1561667067716;
 Thu, 27 Jun 2019 13:24:27 -0700 (PDT)
Date:   Thu, 27 Jun 2019 13:24:11 -0700
Message-Id: <20190627202417.33370-1-brianvv@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [RFC PATCH bpf-next v2 0/6]  bpf: add BPF_MAP_DUMP command to
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

This new command can be executed from the existing BPF syscall as
follows:

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
5% of the total number of entries there's no huge difference in
increasing
it.

Tested:
Tried different size buffers to handle case where the bulk is bigger, or
the elements to retrieve are less than the existing ones, all runs read
a map of 100K entries. Below are the results(in ns) from the different
runs:

buf_len_1:       55528939 entry-by-entry: 97244981 improvement
42.897887%
buf_len_2:       34425779 entry-by-entry: 88863122 improvement
61.259769%
buf_len_230:     11700316 entry-by-entry: 88753301 improvement
86.817036%
buf_len_5000:    11615290 entry-by-entry: 88362637 improvement
86.854976%
buf_len_73000:   12083976 entry-by-entry: 89956483 improvement
86.566865%
buf_len_100000:  12638913 entry-by-entry: 89642303 improvement
85.900727%
buf_len_234567:  11873964 entry-by-entry: 89080077 improvement
86.670461%

Changelog:

v2:
- use proper bpf-next tag

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

