Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A29B9294483
	for <lists+bpf@lfdr.de>; Tue, 20 Oct 2020 23:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409914AbgJTV0C (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Oct 2020 17:26:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57470 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2409910AbgJTV0C (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 20 Oct 2020 17:26:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603229160;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=vdxj7wwck99hwiPOLIiRh/bcID2cwGqfhg3CmYVD7tM=;
        b=HxPFjU0eNfjipY7hu8RhrvMzu6SQvbcv5AtGwH2Tym8Mi7IrCGOCl+wK6b3h3DxKalmVdC
        Fn3VHZOFQwr7DooHV476/TUR2gW0iGUPLDOSJPMGQKK02+yBLDxGVnEk8urQXxXogteRyy
        9eazPTL6yuWh/ms32xAv6l1jTHdqPlU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-CuEXI1UDMa-7S-E6Lv5bVw-1; Tue, 20 Oct 2020 17:25:58 -0400
X-MC-Unique: CuEXI1UDMa-7S-E6Lv5bVw-1
Received: by mail-ej1-f70.google.com with SMTP id k23so72516ejx.0
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2020 14:25:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=vdxj7wwck99hwiPOLIiRh/bcID2cwGqfhg3CmYVD7tM=;
        b=NkIjVzHrRx4S9WNQSkh0AntSf+0gBVUqYpA/yJgBlxWqie6rxTbf2iSn2bLWob716D
         BW/8N2dc4KBr0s0iuVK2X9AYoH559bHjkt32UsRxcUk5FjHjuRUVt69dzZZhHXLZ02S8
         uvbmSrNTalpKCLaukTm4iE45fdMzSDeKquEjk5XVkbdX7RPVSgSCKIEuLzcO8fTVDQIZ
         uR4KqNCpWFoxD5em1xXjYn0yuBdFiFMthVZ/bC8+wUymyPuWi7H/8uAXealamES+LIzm
         2jVL2YYEYa8s1pq+fV2GGdVxAqUYF9yaolKyPlDZZpo/VXiMZkOWUySmrjyiZbVUd94S
         cZ6w==
X-Gm-Message-State: AOAM530PZ+QO7j/Tdbf5x3TkeaLEBR44+DqyCmeiCzUAhyczCZ4Zy/YX
        ixoqPfI1hzPyXUs4y1Lc4njUXy3+A7QZblcwcDrqLkt5J9aA4SnHw4wzRRczc2iDPDlPPTtSUuL
        cCW/WUr1CdMQS
X-Received: by 2002:aa7:d30d:: with SMTP id p13mr4830403edq.315.1603229157528;
        Tue, 20 Oct 2020 14:25:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz4XMFVzIobX6MHENn+jpLOcr1qxr0DeCYqHmX303v0OuzdqXQPMQjdbrY8T8M0jCFBcLjtAQ==
X-Received: by 2002:aa7:d30d:: with SMTP id p13mr4830372edq.315.1603229157141;
        Tue, 20 Oct 2020 14:25:57 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id gv10sm44968ejb.46.2020.10.20.14.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 14:25:56 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 2496D1838FA; Tue, 20 Oct 2020 23:25:55 +0200 (CEST)
Subject: [PATCH bpf v3 0/2] bpf: Rework bpf_redirect_neigh() to allow
 supplying nexthop from caller
From:   =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Date:   Tue, 20 Oct 2020 23:25:55 +0200
Message-ID: <160322915507.32199.17907734403861652183.stgit@toke.dk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Based on previous discussion[0], we determined that it would be beneficial to
rework bpf_redirect_neigh() so the caller can supply the nexthop information
(e.g., from a previous call to bpf_fib_lookup()). This way, the two helpers can
be combined without incurring a second FIB lookup to find the nexthop, and
bpf_fib_lookup() becomes usable even if no nexthop entry currently exists.

This patch (and accompanying selftest update) accomplishes this by way of an
optional paramter to bpf_redirect_neigh(). This series is against the -bpf tree,
since we need to change this call signature before it becomes API.

[0] https://lore.kernel.org/bpf/393e17fc-d187-3a8d-2f0d-a627c7c63fca@iogearbox.net/

Changelog:

v3:
- Just use a u32 for nh_family instead of filling the hole with 'u8 unused[3]' (Daniel)
- Drop the SKIP_NEIGH flag to bpf_fib_lookup() (David Ahern)

v2:
- Add 'unused' member to fill hole in bpf_redir_neigh struct (David Ahern)
- Fix compilation with INET/INET6 disabled - properly this time (kbot)
- Add back the BPF_FIB_LOOKUP_SKIP_NEIGH flag as new patch 2 (Daniel)

v1:
- Rebase on -bpf tree
- Fix compilation with INET/INET6 disabled (kbot)
- Keep v4/v6 signatures similar, use internal flag (Daniel)
- Use a separate selftest BPF program instead of modifying existing one (Daniel)
- Fix a few style nits (David Ahern)

---

Toke Høiland-Jørgensen (2):
      bpf_redirect_neigh: Support supplying the nexthop as a helper parameter
      selftests: Update test_tc_redirect.sh to use the modified bpf_redirect_neigh()


 .../selftests/bpf/progs/test_tc_neigh.c       |   5 +-
 .../selftests/bpf/progs/test_tc_neigh_fib.c   | 155 ++++++++++++++++++
 .../testing/selftests/bpf/test_tc_redirect.sh |  18 +-
 3 files changed, 173 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_tc_neigh_fib.c

