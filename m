Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21B4B357C2F
	for <lists+bpf@lfdr.de>; Thu,  8 Apr 2021 08:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbhDHGM6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Apr 2021 02:12:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25523 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229691AbhDHGM6 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 8 Apr 2021 02:12:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617862367;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=dmf4U6SwbzWvz/DzaqK9yqzuUwBKl0ySGyn4G8V0BcM=;
        b=Nt/qz2P3p8rqe/kIX0TPghEjFtRv8ubDxIsBE7aISp5C+ZvFtEGjZh5epfZGn/BiNXE4TZ
        IWFcXwq4eFsRcJAIsKVYlwuPE883YfS0MnAINp/ieNlFvb7eQljutYVBfzPQzI8foGQIKW
        2B26csRbd9hlQ06Y6zD2jyQ4Jdvs1ME=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-3XsB5qwDO1uHgvv15i-aaw-1; Thu, 08 Apr 2021 02:12:45 -0400
X-MC-Unique: 3XsB5qwDO1uHgvv15i-aaw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 68BD01008060;
        Thu,  8 Apr 2021 06:12:44 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-112-182.ams2.redhat.com [10.36.112.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AF4A57A395;
        Thu,  8 Apr 2021 06:12:39 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, jolsa@redhat.com,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Subject: [PATCH bpf-next v4 0/9] bpf/selftests: page size fixes
Date:   Thu,  8 Apr 2021 09:12:38 +0300
Message-Id: <20210408061238.95803-1-yauheni.kaliuta@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

A set of fixes for selftests to make them working on systems with PAGE_SIZE > 4K
+ cleanup (version) and ringbuf_multi extention.

--
v3->v4:
- zero initialize BPF programs' static variables;
- add bpf_map__inner_map to libbpf.map in alphabetical order;
- add bpf_map__set_inner_map_fd test to ringbuf_multi;

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



Yauheni Kaliuta (9):
  selftests/bpf: test_progs/sockopt_sk: remove version
  selftests/bpf: test_progs/sockopt_sk: Convert to use BPF skeleton
  selftests/bpf: pass page size from userspace in sockopt_sk
  selftests/bpf: pass page size from userspace in map_ptr
  selftests/bpf: mmap: use runtime page size
  selftests/bpf: ringbuf: use runtime page size
  libbpf: add bpf_map__inner_map API
  selftests/bpf: ringbuf_multi: use runtime page size
  selftests/bpf: ringbuf_multi: test bpf_map__set_inner_map_fd

 tools/lib/bpf/libbpf.c                        | 10 +++
 tools/lib/bpf/libbpf.h                        |  1 +
 tools/lib/bpf/libbpf.map                      |  1 +
 .../selftests/bpf/prog_tests/map_ptr.c        | 15 ++++-
 tools/testing/selftests/bpf/prog_tests/mmap.c | 24 +++++--
 .../selftests/bpf/prog_tests/ringbuf.c        | 17 +++--
 .../selftests/bpf/prog_tests/ringbuf_multi.c  | 34 +++++++++-
 .../selftests/bpf/prog_tests/sockopt_sk.c     | 65 +++++--------------
 .../selftests/bpf/progs/map_ptr_kern.c        |  4 +-
 .../testing/selftests/bpf/progs/sockopt_sk.c  | 11 ++--
 tools/testing/selftests/bpf/progs/test_mmap.c |  2 -
 .../selftests/bpf/progs/test_ringbuf.c        |  1 -
 .../selftests/bpf/progs/test_ringbuf_multi.c  | 12 +++-
 13 files changed, 123 insertions(+), 74 deletions(-)

-- 
2.31.1

