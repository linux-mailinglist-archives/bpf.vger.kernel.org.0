Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C572C22AD1F
	for <lists+bpf@lfdr.de>; Thu, 23 Jul 2020 13:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbgGWLCK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Jul 2020 07:02:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35691 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726867AbgGWLCK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Jul 2020 07:02:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595502129;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=b82ezmpSci/dO9hVLi35LzcHZ4KMjZ2t5b1gXidbMGY=;
        b=Bpx4fkzVth0M4UV7IW3U8qfyGxDu69cz0HXhYa9FgWX6gteYt70EGleLZqXMJkvPGF42XX
        8RQmkQgAYN///IxrjAOS+I+/fUZ1WQ5meuuP8xf+PAXM6/yBd63PUQs7WnGvRumywWx8zk
        8Rd9JEFmCdjSci3Hi2R9HI8ro1ic+bw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-m-21d_5VPLuA1bwHMiTBVQ-1; Thu, 23 Jul 2020 07:02:07 -0400
X-MC-Unique: m-21d_5VPLuA1bwHMiTBVQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 817BE8015CE;
        Thu, 23 Jul 2020 11:02:06 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-114-85.ams2.redhat.com [10.36.114.85])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 065966932D;
        Thu, 23 Jul 2020 11:02:04 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     bpf@vger.kernel.org
Cc:     Andrii Nakryiko <andriin@fb.com>, Jiri Olsa <jolsa@redhat.com>,
        Jiri Benc <jbenc@redhat.com>
Subject: selftests: bpf: mmap question
Date:   Thu, 23 Jul 2020 14:02:02 +0300
Message-ID: <xunyft9i1olx.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi!

I have a question about the part of the test:

	/* check some more advanced mmap() manipulations */

	/* map all but last page: pages 1-3 mapped */
	tmp1 = mmap(NULL, 3 * page_size, PROT_READ, MAP_SHARED,
			  data_map_fd, 0);
	if (CHECK(tmp1 == MAP_FAILED, "adv_mmap1", "errno %d\n", errno))
		goto cleanup;

	/* unmap second page: pages 1, 3 mapped */
	err = munmap(tmp1 + page_size, page_size);
	if (CHECK(err, "adv_mmap2", "errno %d\n", errno)) {
		munmap(tmp1, map_sz);
		goto cleanup;
	}

	/* map page 2 back */
	tmp2 = mmap(tmp1 + page_size, page_size, PROT_READ,
		    MAP_SHARED | MAP_FIXED, data_map_fd, 0);
	if (CHECK(tmp2 == MAP_FAILED, "adv_mmap3", "errno %d\n", errno)) {
		munmap(tmp1, page_size);
		munmap(tmp1 + 2*page_size, page_size);
		goto cleanup;
	}
	CHECK(tmp1 + page_size != tmp2, "adv_mmap4",
	      "tmp1: %p, tmp2: %p\n", tmp1, tmp2);

	/* re-map all 4 pages */
	tmp2 = mmap(tmp1, 4 * page_size, PROT_READ, MAP_SHARED | MAP_FIXED,
		    data_map_fd, 0);
	if (CHECK(tmp2 == MAP_FAILED, "adv_mmap5", "errno %d\n", errno)) {
		munmap(tmp1, 3 * page_size); /* unmap page 1 */
		goto cleanup;
	}
	CHECK(tmp1 != tmp2, "adv_mmap6", "tmp1: %p, tmp2: %p\n", tmp1, tmp2);


In my configuration the first mapping

	/* map all but last page: pages 1-3 mapped */
	tmp1 = mmap(NULL, 3 * page_size, PROT_READ, MAP_SHARED,
			  data_map_fd, 0);


maps the area to the 3 pages right before the TLS page.
I find it's pretty ok.

But then the 4 page mapping

	/* re-map all 4 pages */
	tmp2 = mmap(tmp1, 4 * page_size, PROT_READ, MAP_SHARED | MAP_FIXED,
		    data_map_fd, 0);


since it has MAP_FIXED flag, unmaps TLS and maps the former TLS
address BPF map.

Which is again exactly the behaviour of MAP_FIXED, but it breaks
the test.

Using MAP_FIXED_NOREPLACE fails the check:

CHECK(tmp1 != tmp2, "adv_mmap6", "tmp1: %p, tmp2: %p\n", tmp1, tmp2);

as expected.


Should the test be modified to be a bit more relaxed? Since the
kernel behaviour looks correct or I'm missing something?


PS: BTW, the previous data_map mapping left unmmaped. Is it expected?

-- 
WBR,
Yauheni Kaliuta

