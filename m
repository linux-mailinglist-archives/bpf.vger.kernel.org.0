Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A42B08B98E
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2019 15:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728601AbfHMNJi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Aug 2019 09:09:38 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52136 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728501AbfHMNJi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Aug 2019 09:09:38 -0400
Received: by mail-wm1-f65.google.com with SMTP id 207so1464732wma.1
        for <bpf@vger.kernel.org>; Tue, 13 Aug 2019 06:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=tLx3mu9PZ5t3XynVFq/naBZY66BrZah0JkK9e1BReq0=;
        b=wYG9/UojKxWfJ856+uQvwJkh7RXhcT4lvVl99F9QYmOenfq4qoGA2+OxsTyUPRe21g
         MeIsDjqLGMCBu2AhBy2WnNTR4W23TbBuODFGv9HCvU3xFRMGiWsKOWngEfJafHhgF7Ez
         NTpuPvxWM+E4QHQfeC3JmuQQfLO9ZjRaevXrXLA6sO3C24cfW645g+t6C4xP2/SXvTMJ
         +Yc579ZcLM4gu/L33UGVBdvMsRMSZdpQORG8843CcFmUkV23UYJvIByp0I9Z1yJrSMLV
         XiVTTmF32q2/Xaor85qQo8wbgeIUD4FOhYiNfdrSx8IBo2FYLt3pl1YS7usas0v0crbq
         rJLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tLx3mu9PZ5t3XynVFq/naBZY66BrZah0JkK9e1BReq0=;
        b=d4E+EkgkD1MhvaNZURSmdMWtazOmWu0/hkiV8jqJ1APN30ZT7ceqN4JBzZJk9ogVEx
         S5IVhc+uBAOpwrZKFye/S04CsxP9YKpKPLjH9dCzS0ZnOT8n+g9vYZ6vudavwtX9Tajo
         d/3LOrVN/vhiYfOXywjxI6+wpf+CrZlnR4IZMtK0y3e3wFlhxB1IURGZZYdYRy3T720w
         4jm+i4K0a+C5IdyEVVn3f9cdM/eq8A3P9r5CCiPPvMuBNmiKt/2ibX69unv3Uh+DudR4
         WWzIX22PE0L6GTi6+NifOmEeX/mvU5wTdbJTCleZYYPQ7fd5DVfhMIouvHJBXFbArm/B
         ZNxQ==
X-Gm-Message-State: APjAAAWIBhGN+MykJayodnprh4qqnTQBdtYjWHK7H65OE3GHHyrw65zU
        UnIUS+GnlY6wQqxXwYTVSvgNTj3Ijp8=
X-Google-Smtp-Source: APXvYqyaqHCrnP4oACjmxeVXsvuCbnBh86YddzoyKE01zs398MEAti1idt3y0eEvC61PN0+nNDSYsg==
X-Received: by 2002:a1c:a909:: with SMTP id s9mr3099450wme.20.1565701776602;
        Tue, 13 Aug 2019 06:09:36 -0700 (PDT)
Received: from cbtest32.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id e3sm130534191wrs.37.2019.08.13.06.09.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 13 Aug 2019 06:09:35 -0700 (PDT)
From:   Quentin Monnet <quentin.monnet@netronome.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com,
        Quentin Monnet <quentin.monnet@netronome.com>
Subject: [RFC bpf-next 0/3] tools: bpftool: add subcommand to count map entries
Date:   Tue, 13 Aug 2019 14:09:18 +0100
Message-Id: <20190813130921.10704-1-quentin.monnet@netronome.com>
X-Mailer: git-send-email 2.17.1
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This series adds a "bpftool map count" subcommand to count the number of
entries present in a BPF map. This results from a customer request for a
tool to count the number of entries in BPF maps used in production (for
example, to know how many free entries are left in a given map).

The first two commits actually contain some clean-up in preparation for the
new subcommand.

The third commit adds the new subcommand. Because what data should count as
an entry is not entirely clear for all map types, we actually dump several
counters, and leave it to the users to interpret the values.

Sending as a RFC because I'm looking for feedback on the approach. Is
printing several values the good thing to do? Also, note that some map
types such as queue/stack maps do not support any type of counting, this
would need to be implemented in the kernel I believe.

More generally, we have a use case where (hash) maps are under pressure
(many additions/deletions from the BPF program), and counting the entries
by iterating other the different keys is not at all reliable. Would that
make sense to add a new bpf() subcommand to count the entries on the kernel
side instead of cycling over the entries in bpftool? If so, we would need
to agree on what makes an entry for each kind of map.

Note that we are also facing similar issues for purging map from their
entries (deleting all entries at once). We can iterate on the keys and
delete elements one by one, but this is very inefficient when entries are
being added/removed in parallel from the BPF program, and having another
dedicated command accessible from the bpf() system call might help here as
well.

Quentin Monnet (3):
  tools: bpftool: clean up dump_map_elem() return value
  tools: bpftool: make comment more explicit for count of dumped entries
  tools: bpftool: add "bpftool map count" to count entries in map

 .../bpf/bpftool/Documentation/bpftool-map.rst |  15 +++
 tools/bpf/bpftool/bash-completion/bpftool     |   4 +-
 tools/bpf/bpftool/map.c                       | 110 ++++++++++++++++--
 3 files changed, 119 insertions(+), 10 deletions(-)

-- 
2.17.1

