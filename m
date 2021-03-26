Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDF5434A717
	for <lists+bpf@lfdr.de>; Fri, 26 Mar 2021 13:25:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbhCZMYj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Mar 2021 08:24:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60099 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230104AbhCZMY0 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 26 Mar 2021 08:24:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616761465;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RZLwbZFYkSa9IrXUFixmpPImItehMOIfdmi+kq/yb3s=;
        b=ZpXM54O8tmjCVu8Lyu9IWITFoD5pRpNFKwVQftUWQ+Rz6IJUS+Vo9bNdzP7eDfOpF3sjDn
        zjuNhZeT4mXQFsxB/wntxxKo4yhytrXQhXg1mRWfLPfIX7Um0WVnexOOYl0k34fjzCE0IU
        CP1SkET0TmBdodmqWuWSbvVNYiPrztY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-531-Aur-eFgKOsWzHkVvRKWPvQ-1; Fri, 26 Mar 2021 08:24:21 -0400
X-MC-Unique: Aur-eFgKOsWzHkVvRKWPvQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BBA561044B59;
        Fri, 26 Mar 2021 12:24:09 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-114-130.ams2.redhat.com [10.36.114.130])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 64CC16062F;
        Fri, 26 Mar 2021 12:24:08 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, jolsa@redhat.com,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Subject: [PATCH v2 0/4] bpf/selftests: page size fixes
Date:   Fri, 26 Mar 2021 14:24:07 +0200
Message-Id: <20210326122407.211174-1-yauheni.kaliuta@redhat.com>
In-Reply-To: <20210326114658.210034-1-yauheni.kaliuta@redhat.com>
References: <20210326114658.210034-1-yauheni.kaliuta@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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

--
v1->v2:

- add missed 'selftests/bpf: test_progs/sockopt_sk: Convert to use BPF skeleton'

Yauheni Kaliuta (4):
  
  selftests/bpf: test_progs/sockopt_sk: pass page size from userspace
  bpf: selftests: test_progs/sockopt_sk: remove version
  selftests/bpf: ringbuf, mmap: bump up page size to 64K

 .../selftests/bpf/prog_tests/ringbuf.c        |  9 ++-
 .../selftests/bpf/prog_tests/sockopt_sk.c     | 68 ++++++-------------
 .../selftests/bpf/progs/map_ptr_kern.c        |  9 ++-
 .../testing/selftests/bpf/progs/sockopt_sk.c  | 11 ++-
 tools/testing/selftests/bpf/progs/test_mmap.c | 10 ++-
 .../selftests/bpf/progs/test_ringbuf.c        |  8 ++-
 .../selftests/bpf/progs/test_ringbuf_multi.c  |  7 +-
 7 files changed, 61 insertions(+), 61 deletions(-)

-- 
2.29.2

