Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB9C91DDE94
	for <lists+bpf@lfdr.de>; Fri, 22 May 2020 06:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbgEVENW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 May 2020 00:13:22 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30937 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727809AbgEVENW (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 22 May 2020 00:13:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590120801;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=/g6qMkIHDmI5EO54B2xAjEUyYVF96DMskIRvUptNZRY=;
        b=avC8XGGWCS5Fy8U0RKi5ZOClT+QIBQKzA0b6jn65N6t+neAoytTfuzzDWUQafcjqDDgKvq
        pVqkVO7ZL8IUzgujoHsNrSTw8tugcvqYamoaFCkw0C8uPZ81PvljKC4s5ok/0qIMfztncE
        Jp3i90PLFlekvgZyHszgkwmgy9zQwcw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-Adli3xHRNmi36cfXGgZ3Yw-1; Fri, 22 May 2020 00:13:15 -0400
X-MC-Unique: Adli3xHRNmi36cfXGgZ3Yw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 20DC6107ACF2;
        Fri, 22 May 2020 04:13:14 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-112-74.ams2.redhat.com [10.36.112.74])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7630C5D9C9;
        Fri, 22 May 2020 04:13:12 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     bpf@vger.kernel.org
Cc:     Jiri Benc <jbenc@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH 0/8] selftests/bpf: installation and out of tree build fixes
Date:   Fri, 22 May 2020 07:13:02 +0300
Message-Id: <20200522041310.233185-1-yauheni.kaliuta@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

I had a look, here are some fixes.

Yauheni Kaliuta (8):
  selftests/bpf: remove test_align from Makefile
  selftests/bpf: build bench.o for any $(OUTPUT)
  selftests/bpf: install btf .c files
  selftests/bpf: fix object files installation
  selftests/bpf: add output dir to include list
  selftests/bpf: fix urandom_read installation
  selftests/bpf: fix test.h placing for out of tree build
  selftests/bpf: factor out MKDIR rule

 tools/testing/selftests/bpf/Makefile | 77 ++++++++++++++++++++--------
 1 file changed, 55 insertions(+), 22 deletions(-)

-- 
2.26.2

