Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F03F24A3A3
	for <lists+bpf@lfdr.de>; Wed, 19 Aug 2020 17:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbgHSP5i (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Aug 2020 11:57:38 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:49416 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726632AbgHSP5h (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 19 Aug 2020 11:57:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597852656;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3CF/ezO2LMu2FPJiLYr77h3LAOworvbz4RhCVNAQFKY=;
        b=haWgPiQq7yGW8prDyXv/djagfoJb6yv5z+WHICgTH3c8wqTk7MDdYvxpvx1TRaytFn/28o
        ltfqvZ04JwMM1vjnYhFUVuPTkHljUK5Mnmp+8WLLotjYppYOc6AtDtSoNNuSGtxQcfHzGT
        ivwbYk10CNdD3C9a2P0uA7OIpn324cw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-565-f-C4C0SjMCqwLZaEmDyuAQ-1; Wed, 19 Aug 2020 11:57:32 -0400
X-MC-Unique: f-C4C0SjMCqwLZaEmDyuAQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DA59F1084C8E;
        Wed, 19 Aug 2020 15:57:30 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D1FAB26DD4;
        Wed, 19 Aug 2020 15:57:30 +0000 (UTC)
Received: from zmail19.collab.prod.int.phx2.redhat.com (zmail19.collab.prod.int.phx2.redhat.com [10.5.83.22])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id BEDC41832FC1;
        Wed, 19 Aug 2020 15:57:30 +0000 (UTC)
Date:   Wed, 19 Aug 2020 11:57:30 -0400 (EDT)
From:   Veronika Kabatova <vkabatov@redhat.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, sdf@google.com, andriin@fb.com,
        skozina@redhat.com, brouer@redhat.com
Message-ID: <871756322.7804389.1597852650610.JavaMail.zimbra@redhat.com>
In-Reply-To: <8c876d8d-c13b-279d-6b94-15c3ad4f0a9c@fb.com>
References: <20200819102354.1297830-1-vkabatov@redhat.com> <8c876d8d-c13b-279d-6b94-15c3ad4f0a9c@fb.com>
Subject: Re: [PATCH] selftests/bpf: Remove test_align from TEST_GEN_PROGS
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.194.249, 10.4.195.15]
Thread-Topic: selftests/bpf: Remove test_align from TEST_GEN_PROGS
Thread-Index: D0clzo8PdIvo/7kIgar6RNEduai8TQ==
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



----- Original Message -----
> From: "Yonghong Song" <yhs@fb.com>
> To: "Veronika Kabatova" <vkabatov@redhat.com>, bpf@vger.kernel.org
> Cc: sdf@google.com, andriin@fb.com, skozina@redhat.com, brouer@redhat.com
> Sent: Wednesday, August 19, 2020 5:36:01 PM
> Subject: Re: [PATCH] selftests/bpf: Remove test_align from TEST_GEN_PROGS
> 
> 
> 
> On 8/19/20 3:23 AM, Veronika Kabatova wrote:
> > Calling generic selftests "make install" fails as rsync expects all
> > files from TEST_GEN_PROGS to be present. The binary is not generated
> > anymore (commit 3b09d27cc93d) so we can safely remove it from there.
> > 
> > Fixes: 3b09d27cc93d ("selftests/bpf: Move test_align under test_progs")
> > Signed-off-by: Veronika Kabatova <vkabatov@redhat.com>
> 
> Could you remove 'test_align' for .gitignore as well? With this,
> Acked-by: Yonghong Song <yhs@fb.com>
> 

Good idea. Will send a v2 soon.

Veronika

> > ---
> >   tools/testing/selftests/bpf/Makefile | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/testing/selftests/bpf/Makefile
> > b/tools/testing/selftests/bpf/Makefile
> > index a83b5827532f..fc946b7ac288 100644
> > --- a/tools/testing/selftests/bpf/Makefile
> > +++ b/tools/testing/selftests/bpf/Makefile
> > @@ -32,7 +32,7 @@ LDLIBS += -lcap -lelf -lz -lrt -lpthread
> >   
> >   # Order correspond to 'make run_tests' order
> >   TEST_GEN_PROGS = test_verifier test_tag test_maps test_lru_map
> >   test_lpm_map test_progs \
> > -	test_align test_verifier_log test_dev_cgroup test_tcpbpf_user \
> > +	test_verifier_log test_dev_cgroup test_tcpbpf_user \
> >   	test_sock test_btf test_sockmap get_cgroup_id_user test_socket_cookie \
> >   	test_cgroup_storage \
> >   	test_netcnt test_tcpnotify_user test_sock_fields test_sysctl \
> > 
> 
> 

