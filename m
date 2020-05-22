Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B36FB1DE00D
	for <lists+bpf@lfdr.de>; Fri, 22 May 2020 08:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbgEVGkx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 May 2020 02:40:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45555 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728200AbgEVGkw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 May 2020 02:40:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590129651;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mTaoeYWrAmwNDuPFgsH0H1f2AsEd8kq2roldQNjN7NI=;
        b=EHoq9U5MTwKUVB8jRXFhSE07+u3ePJ3LSw8W5xHEv9QT6n6EBRhv+xp/4gm5IJ8vq1EBEJ
        J4duytyFRj2b8UjnWdTW90J5HKTI3Pnfdfc4UhO1XxhcTwALsOxcbLkoi5VdnwurrM0Li6
        s3S8lYwB6fk7p0i/+t55zE+lTboC3bI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-487-q-91C4HgMT-rl7WniVaH1A-1; Fri, 22 May 2020 02:40:49 -0400
X-MC-Unique: q-91C4HgMT-rl7WniVaH1A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9E7BE80B72D;
        Fri, 22 May 2020 06:40:48 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-112-212.ams2.redhat.com [10.36.112.212])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2536960CC0;
        Fri, 22 May 2020 06:40:46 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     bpf@vger.kernel.org
Cc:     Jiri Benc <jbenc@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH 0/8] selftests/bpf: installation and out of tree build fixes
References: <20200522041310.233185-1-yauheni.kaliuta@redhat.com>
Date:   Fri, 22 May 2020 09:40:44 +0300
In-Reply-To: <20200522041310.233185-1-yauheni.kaliuta@redhat.com> (Yauheni
        Kaliuta's message of "Fri, 22 May 2020 07:13:02 +0300")
Message-ID: <xuny367so4k3.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


Actually, a bit more needed :)

>>>>> On Fri, 22 May 2020 07:13:02 +0300, Yauheni Kaliuta  wrote:

 > I had a look, here are some fixes.
 > Yauheni Kaliuta (8):
 >   selftests/bpf: remove test_align from Makefile
 >   selftests/bpf: build bench.o for any $(OUTPUT)
 >   selftests/bpf: install btf .c files
 >   selftests/bpf: fix object files installation
 >   selftests/bpf: add output dir to include list
 >   selftests/bpf: fix urandom_read installation
 >   selftests/bpf: fix test.h placing for out of tree build
 >   selftests/bpf: factor out MKDIR rule

 >  tools/testing/selftests/bpf/Makefile | 77 ++++++++++++++++++++--------
 >  1 file changed, 55 insertions(+), 22 deletions(-)

 > -- 
 > 2.26.2


-- 
WBR,
Yauheni Kaliuta

