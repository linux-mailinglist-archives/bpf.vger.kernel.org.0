Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1B2A34A696
	for <lists+bpf@lfdr.de>; Fri, 26 Mar 2021 12:48:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbhCZLri (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Mar 2021 07:47:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56467 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229758AbhCZLrH (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 26 Mar 2021 07:47:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616759227;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=oUB0RU5sK3ul/waYv49PqF/y3+eKcmTRQ8v7puUMiWg=;
        b=cZnkTZr12tQ00oEl8/5ifEnCrAYmx6iAQJFrRjX04gnwUjgMsRjnNXeYQuXOB0Q1Q8VfLO
        ej1W8SWmIMH3EXVaZF37sd6Kkto2HZr/8BzNdzDWC7FtfsO/zc3hEeHIXiPW3SS6/De4IR
        Yrg0/jTKavv2eTfkUR4mAyRIpRNWe9g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-151-P2EDZRGKMam3AZaU0M9bag-1; Fri, 26 Mar 2021 07:47:04 -0400
X-MC-Unique: P2EDZRGKMam3AZaU0M9bag-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 62C8C107ACCA;
        Fri, 26 Mar 2021 11:47:03 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-114-130.ams2.redhat.com [10.36.114.130])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6E73419727;
        Fri, 26 Mar 2021 11:46:59 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, jolsa@redhat.com,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Subject: [PATCH 0/3] bpf/selftests: page size fixes
Date:   Fri, 26 Mar 2021 13:46:58 +0200
Message-Id: <20210326114658.210034-1-yauheni.kaliuta@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

A set of fixes for selftests to make them working on systems with PAGE_SIZE > 4K

2 questions left:

- about `nit: if (!ASSERT_OK(err, "setsockopt_attach"))`. I left
  CHECK() for now since otherwise it has too many negations. But
  should I anyway use ASSERT?

- https://github.com/torvalds/linux/blob/master/tools/testing/selftests/bpf/prog_tests/mmap.c#L41
  and below -- it works now as is, but should be switched also to page_size?

Yauheni Kaliuta (3):
  selftests/bpf: test_progs/sockopt_sk: pass page size from userspace
  bpf: selftests: test_progs/sockopt_sk: remove version
  selftests/bpf: ringbuf, mmap: bump up page size to 64K

 tools/testing/selftests/bpf/prog_tests/ringbuf.c      |  9 +++++++--
 tools/testing/selftests/bpf/prog_tests/sockopt_sk.c   |  2 ++
 tools/testing/selftests/bpf/progs/map_ptr_kern.c      |  9 +++++++--
 tools/testing/selftests/bpf/progs/sockopt_sk.c        | 11 ++++-------
 tools/testing/selftests/bpf/progs/test_mmap.c         | 10 ++++++++--
 tools/testing/selftests/bpf/progs/test_ringbuf.c      |  8 +++++++-
 .../testing/selftests/bpf/progs/test_ringbuf_multi.c  |  7 ++++++-
 7 files changed, 41 insertions(+), 15 deletions(-)

-- 
2.29.2

