Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1D633504E6
	for <lists+bpf@lfdr.de>; Wed, 31 Mar 2021 18:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233704AbhCaQpO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 31 Mar 2021 12:45:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57257 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229615AbhCaQon (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 31 Mar 2021 12:44:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617209082;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=4oBfYqxLBpaR17Djif+kt/njXUZuQMGTrpzQ/bLdSzg=;
        b=JROqOCuOBL1AGORvwYEC4HoJCK8Hbl1KrWgQkpgOJhtUg6+PQ9NYlvWpSZLCOmI1KxjGz9
        SPRmypdduOSVTfYDzAHuyOMfPipD9osR4wnBPaqW9XOW8bsxuhlQkqhNPX/kJdCzqPVBdA
        kcm4hiWYTK3h1Z0ljQzR4Os4L89n2B0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-BqPuOxY4PPuqmpE-YSqNvQ-1; Wed, 31 Mar 2021 12:44:40 -0400
X-MC-Unique: BqPuOxY4PPuqmpE-YSqNvQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DF5461B2C989;
        Wed, 31 Mar 2021 16:44:39 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-114-48.ams2.redhat.com [10.36.114.48])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 42BA119C59;
        Wed, 31 Mar 2021 16:44:35 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, jolsa@redhat.com,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Subject: [PATCH bpf-next v3 0/8] bpf/selftests: page size fixes
Date:   Wed, 31 Mar 2021 19:44:33 +0300
Message-Id: <20210331164433.320534-1-yauheni.kaliuta@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

A set of fixes for selftests to make them working on systems with PAGE_SIZE > 4K

--
v2->v3:
 - reorder: move version removing patch first to keep main patches in
   one group;
 - rename "selftests/bpf: pass page size from userspace in sockopt_sk"
   as suggested;
 - convert sockopt_sk test to use ASSERT macros;
 - set page size from userspace
 - split patches to pairs userspace/bpf. It's easier to check that
   every conversion works as expected;

v1->v2:

- add missed 'selftests/bpf: test_progs/sockopt_sk: Convert to use BPF skeleton'

Yauheni Kaliuta (8):
  selftests/bpf: test_progs/sockopt_sk: remove version
  selftests/bpf: test_progs/sockopt_sk: Convert to use BPF skeleton
  selftests/bpf: pass page size from userspace in sockopt_sk
  selftests/bpf: pass page size from userspace in map_ptr
  selftests/bpf: mmap: use runtime page size
  selftests/bpf: ringbuf: use runtime page size
  libbpf: add bpf_map__inner_map API
  selftests/bpf: ringbuf_multi: use runtime page size

 tools/lib/bpf/libbpf.c                        | 10 +++
 tools/lib/bpf/libbpf.h                        |  1 +
 tools/lib/bpf/libbpf.map                      |  1 +
 .../selftests/bpf/prog_tests/map_ptr.c        | 15 ++++-
 tools/testing/selftests/bpf/prog_tests/mmap.c | 24 +++++--
 .../selftests/bpf/prog_tests/ringbuf.c        | 17 +++--
 .../selftests/bpf/prog_tests/ringbuf_multi.c  | 23 ++++++-
 .../selftests/bpf/prog_tests/sockopt_sk.c     | 65 +++++--------------
 .../selftests/bpf/progs/map_ptr_kern.c        |  4 +-
 .../testing/selftests/bpf/progs/sockopt_sk.c  | 11 ++--
 tools/testing/selftests/bpf/progs/test_mmap.c |  2 -
 .../selftests/bpf/progs/test_ringbuf.c        |  1 -
 .../selftests/bpf/progs/test_ringbuf_multi.c  |  1 -
 13 files changed, 101 insertions(+), 74 deletions(-)

-- 
2.31.1

