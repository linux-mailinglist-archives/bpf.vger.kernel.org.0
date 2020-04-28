Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 275021BC187
	for <lists+bpf@lfdr.de>; Tue, 28 Apr 2020 16:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbgD1OkR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Apr 2020 10:40:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35961 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726868AbgD1OkR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Apr 2020 10:40:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588084815;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=88WT6jFz/l1fCI+TfJK9Dp/9BTx/uaCpqzP31W/LwAs=;
        b=i7c+SS5w83beABpQ+8omYw3eo7nJ5aqn3tzLXuSnHv5O2bTS/3d88mZ3ZWCmsVfK85WNXt
        /V8MEXF0aDfcBllOpZimYczV66HOPgFO0E0Zd8hI7Ko4xuql6dv+Qn5KE0L1f0BQhC2SUa
        9yCFgmVJUun/CCxivoCAmgYpVCLwjqI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-_JzlJ-oqMZqK_RPhn_krZQ-1; Tue, 28 Apr 2020 10:40:12 -0400
X-MC-Unique: _JzlJ-oqMZqK_RPhn_krZQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1CB68100CCC0;
        Tue, 28 Apr 2020 14:40:11 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1282360C87;
        Tue, 28 Apr 2020 14:40:11 +0000 (UTC)
Received: from zmail19.collab.prod.int.phx2.redhat.com (zmail19.collab.prod.int.phx2.redhat.com [10.5.83.22])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 01DFF4CA95;
        Tue, 28 Apr 2020 14:40:11 +0000 (UTC)
Date:   Tue, 28 Apr 2020 10:40:10 -0400 (EDT)
From:   Veronika Kabatova <vkabatov@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Jesper Dangaard Brouer <brouer@redhat.com>,
        bpf <bpf@vger.kernel.org>
Message-ID: <478368089.20968928.1588084810801.JavaMail.zimbra@redhat.com>
In-Reply-To: <CAEf4BzbZPHyR5cqqM73QbppHMDuaRXCf9z08VZFcohdsQE2DGw@mail.gmail.com>
References: <20200427132940.2857289-1-vkabatov@redhat.com> <20200427160240.5e66a954@carbon> <CAEf4BzbZPHyR5cqqM73QbppHMDuaRXCf9z08VZFcohdsQE2DGw@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: Copy runqslower to OUTPUT directory
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.195.57, 10.4.195.25]
Thread-Topic: selftests/bpf: Copy runqslower to OUTPUT directory
Thread-Index: +KelcYQW98mjf/NnImv6T0gGKm6B8Q==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



----- Original Message -----
> From: "Andrii Nakryiko" <andrii.nakryiko@gmail.com>
> To: "Jesper Dangaard Brouer" <brouer@redhat.com>
> Cc: "Veronika Kabatova" <vkabatov@redhat.com>, "bpf" <bpf@vger.kernel.org>, "Andrii Nakryiko" <andriin@fb.com>
> Sent: Monday, April 27, 2020 10:18:37 PM
> Subject: Re: [PATCH] selftests/bpf: Copy runqslower to OUTPUT directory
> 
> On Mon, Apr 27, 2020 at 7:03 AM Jesper Dangaard Brouer
> <brouer@redhat.com> wrote:
> >
> > On Mon, 27 Apr 2020 15:29:40 +0200
> > Veronika Kabatova <vkabatov@redhat.com> wrote:
> >
> > > $(OUTPUT)/runqslower makefile target doesn't actually create runqslower
> > > binary in the $(OUTPUT) directory. As lib.mk expects all
> > > TEST_GEN_PROGS_EXTENDED (which runqslower is a part of) to be present in
> > > the OUTPUT directory, this results in an error when running e.g. `make
> > > install`:
> > >
> > > rsync: link_stat "tools/testing/selftests/bpf/runqslower" failed: No
> > >        such file or directory (2)
> > >
> > > Copy the binary into the OUTPUT directory after building it to fix the
> > > error.
> > >
> > > Signed-off-by: Veronika Kabatova <vkabatov@redhat.com>
> > > ---
> >
> 
> Did I miss original patch somewhere on bpf@vger mailing list?..
> 

Sorry about that, it looks like the smtp setup selectively drops external
addresses. I'll send the v2 from my private email account to avoid this
problem until I figure out what's wrong.

> > Looks good to me
> >
> > Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>
> >
> > >  tools/testing/selftests/bpf/Makefile | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/tools/testing/selftests/bpf/Makefile
> > > b/tools/testing/selftests/bpf/Makefile
> > > index 7729892e0b04..cb8e7e5b2307 100644
> > > --- a/tools/testing/selftests/bpf/Makefile
> > > +++ b/tools/testing/selftests/bpf/Makefile
> > > @@ -142,6 +142,7 @@ $(OUTPUT)/runqslower: $(BPFOBJ)
> > >       $(Q)$(MAKE) $(submake_extras) -C $(TOOLSDIR)/bpf/runqslower     \
> > >                   OUTPUT=$(SCRATCH_DIR)/ VMLINUX_BTF=$(VMLINUX_BTF)   \
> > >                   BPFOBJ=$(BPFOBJ) BPF_INCLUDE=$(INCLUDE_DIR)
> > > +     @cp $(SCRATCH_DIR)/runqslower $(OUTPUT)/runqslower
> 
> This should be AND'ed (&&) with $(MAKE) to not attempt copy on failed
> make run. Also in general @cp should be $(Q)cp, but if you use $$ you
> shouldn't need $(Q).
> 
> Also, just use $@ instead of $(OUTPUT)/runqslower:
> 
> cp $(SCRATCH_DIR)/runqslower $@
> 

Sounds reasonable, thanks.

Veronika

> > >
> > >  $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED): $(OUTPUT)/test_stub.o
> > >  $(BPFOBJ)
> >
> > --
> > Best regards,
> >   Jesper Dangaard Brouer
> >   MSc.CS, Principal Kernel Engineer at Red Hat
> >   LinkedIn: http://www.linkedin.com/in/brouer
> >
> 
> 

