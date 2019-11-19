Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 999BD102CB4
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2019 20:32:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbfKSTap (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Nov 2019 14:30:45 -0500
Received: from mail-pj1-f73.google.com ([209.85.216.73]:35971 "EHLO
        mail-pj1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbfKSTap (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Nov 2019 14:30:45 -0500
Received: by mail-pj1-f73.google.com with SMTP id o4so1593813pjp.3
        for <bpf@vger.kernel.org>; Tue, 19 Nov 2019 11:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=C47Ki3HabBbaxKIHhsS43LGLmAjUHPP9alFct2tZKio=;
        b=AQhhVmFWnFPcXgEc/Fk9f4e4x5ge44nDIJoAhq06dkr8uxhVWVodJBcAw6jHJBnHSv
         XVLDjEH6hlcjYJCj8rmlXhSI/MzVybNW+HRETZq0VCQE23W/K10hRk2FBE0iUcwF4eF9
         pocSqz04vLq6s74RaiVdieK/1p1PXI3RWfzPnp2NwquFVjrOT0w/+XdF+FmKOFzDDZfy
         nVFpwnL1fjbAmDA3yMmCu6c0GSj2cuTtbUtJhIZPof7fXdPVAkhiXCYs5FAvRIja2vNE
         y/33W28eNuTi/lhOFQG1DbNU/ICiItg7jIV1B243hN15HdPLDo6YW7tXTQXzBdHtFWrU
         /q2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=C47Ki3HabBbaxKIHhsS43LGLmAjUHPP9alFct2tZKio=;
        b=aKLK/5kMhINUQ65SZVVosWlJn8wIZk5BpWdlfdszL7q0sNkW5fsN7/PCTghj8Pkf1Z
         j9Xn92rwqAhmatVptsADlCuWpp6BtGRq0Fdxo5qAzP4NYI0jqQeSA++MSdRpfQzDkp4X
         ulEFxuhg74bka4af2DThd2IkXiAwjXqBqBKejgIMuSCF5F7SxwfJRhJmkpkwcgWpMNSY
         U9etjJ9tH2ynH6xifEeSoW4nJdeej7s1aYf70VGeIdzIGJOXMX2BmJ4JPE1+Emgs2GB2
         KmLuDk35npsf/bY00pd+JPU9s7puqzRzBgJGfjEvvrI6M1dSU0jOCmpXMoPp0oLtdEIB
         l1kQ==
X-Gm-Message-State: APjAAAXQ21dNiGP9J16RS+mbP2oHcxhxkQ/2aChL3zNyHwqhb5/XwY8y
        T3bR5tKfeSU53QGZA/mutPOupGrvunge
X-Google-Smtp-Source: APXvYqzNIz68u9dcwE5s1aVXZ2ZnlnOhQePgjaRrwKXmA62Rg/x1cqHffWrblYFqeoJW0i+OdYASh4loV7Gh
X-Received: by 2002:a63:a34e:: with SMTP id v14mr7487127pgn.58.1574191842857;
 Tue, 19 Nov 2019 11:30:42 -0800 (PST)
Date:   Tue, 19 Nov 2019 11:30:27 -0800
Message-Id: <20191119193036.92831-1-brianvv@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH v2 bpf-next 0/9] add bpf batch ops to process more than 1 elem
From:   Brian Vazquez <brianvv@google.com>
To:     Brian Vazquez <brianvv.kernel@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S . Miller" <davem@davemloft.net>
Cc:     Yonghong Song <yhs@fb.com>, Stanislav Fomichev <sdf@google.com>,
        Petar Penkov <ppenkov@google.com>,
        Willem de Bruijn <willemb@google.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Brian Vazquez <brianvv@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch series introduce batch ops that can be added to bpf maps to
lookup/lookup_and_delete/update/delete more than 1 element at the time,
this is specially useful when syscall overhead is a problem and in case
of hmap it will provide a reliable way of traversing them.

The implementation inclues a generic approach that could potentially be
used by any bpf map and adds it to arraymap, it also includes the specific
implementation of hashmaps which are traversed using buckets instead
of keys.

The bpf syscall subcommands introduced are:

  BPF_MAP_LOOKUP_BATCH
  BPF_MAP_LOOKUP_AND_DELETE_BATCH
  BPF_MAP_UPDATE_BATCH
  BPF_MAP_DELETE_BATCH

The UAPI attribute is:

  struct { /* struct used by BPF_MAP_*_BATCH commands */
         __aligned_u64   in_batch;       /* start batch,
                                          * NULL to start from beginning
                                          */
         __aligned_u64   out_batch;      /* output: next start batch */
         __aligned_u64   keys;
         __aligned_u64   values;
         __u32           count;          /* input/output:
                                          * input: # of key/value
                                          * elements
                                          * output: # of filled elements
                                          */
         __u32           map_fd;
         __u64           elem_flags;
         __u64           flags;
  } batch;


in_batch and out_batch are only used for lookup and lookup_and_delete since
those are the only two operations that attempt to traverse the map.

update/delete batch ops should provide the keys/values that user wants
to modify.

Here are the previous discussions on the batch processing:
 - https://lore.kernel.org/bpf/20190724165803.87470-1-brianvv@google.com/
 - https://lore.kernel.org/bpf/20190829064502.2750303-1-yhs@fb.com/
 - https://lore.kernel.org/bpf/20190906225434.3635421-1-yhs@fb.com/

Changelog since v1:
 - Fix SOB ordering and remove Co-authored-by tag (Alexei)

Changelog since RFC:
 - Change batch to in_batch and out_batch to support more flexible opaque
   values to iterate the bpf maps.
 - Remove update/delete specific batch ops for htab and use the generic
   implementations instead.

Brian Vazquez (5):
  bpf: add bpf_map_{value_size,update_value,map_copy_value} functions
  bpf: add generic support for lookup and lookup_and_delete batch ops
  bpf: add generic support for update and delete batch ops
  bpf: add lookup and updated batch ops to arraymap
  selftests/bpf: add batch ops testing to array bpf map

Yonghong Song (4):
  bpf: add batch ops to all htab bpf map
  tools/bpf: sync uapi header bpf.h
  libbpf: add libbpf support to batch ops
  selftests/bpf: add batch ops testing for hmap and hmap_percpu

 include/linux/bpf.h                           |  21 +
 include/uapi/linux/bpf.h                      |  21 +
 kernel/bpf/arraymap.c                         |   2 +
 kernel/bpf/hashtab.c                          | 244 ++++++++
 kernel/bpf/syscall.c                          | 571 ++++++++++++++----
 tools/include/uapi/linux/bpf.h                |  21 +
 tools/lib/bpf/bpf.c                           |  61 ++
 tools/lib/bpf/bpf.h                           |  14 +
 tools/lib/bpf/libbpf.map                      |   4 +
 .../map_lookup_and_delete_batch_array.c       | 119 ++++
 .../map_lookup_and_delete_batch_htab.c        | 257 ++++++++
 11 files changed, 1215 insertions(+), 120 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/map_tests/map_lookup_and_delete_batch_array.c
 create mode 100644 tools/testing/selftests/bpf/map_tests/map_lookup_and_delete_batch_htab.c

-- 
2.24.0.432.g9d3f5f5b63-goog

