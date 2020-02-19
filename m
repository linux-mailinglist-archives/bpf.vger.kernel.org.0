Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50444164DA4
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2020 19:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgBSS3P (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Feb 2020 13:29:15 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25274 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726613AbgBSS3O (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Feb 2020 13:29:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582136953;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2Mz69PjmsyHQBI/G3RZVA2s4R+NZkXcIdE2OoEkW/zI=;
        b=cFBjuCiNPdMEtQB4hYM1G102m/X84D/duiAPUiLneujMIB9YUgrO3ktNEBUAOll0bFbtqY
        Cfpbx8zr0otqYFo2ECFPlxl9PpDDzt3iz+FcDPVxpJWj/65Y71Bgcm+0MHQndkP1ejezC0
        JifcaFGI7TCGw4TGvbEggFx68dOl9hU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-17zdG8vBOv2BUK5ucj4YRA-1; Wed, 19 Feb 2020 13:29:08 -0500
X-MC-Unique: 17zdG8vBOv2BUK5ucj4YRA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2266C8017DF;
        Wed, 19 Feb 2020 18:29:05 +0000 (UTC)
Received: from carbon (ovpn-200-26.brq.redhat.com [10.40.200.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A0DA960BE1;
        Wed, 19 Feb 2020 18:28:56 +0000 (UTC)
Date:   Wed, 19 Feb 2020 19:28:54 +0100
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrii Nakryiko <andriin@fb.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        BPF-dev-list <bpf@vger.kernel.org>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        David Miller <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>,
        brouer@redhat.com
Subject: Re: Kernel 5.5.4 build fail for BPF-selftests with latest LLVM
Message-ID: <20200219192854.6b05b807@carbon>
In-Reply-To: <CAEf4Bza9imKymHfv_LpSFE=kNB5=ZapTS3SCdeZsDdtrUrUGcg@mail.gmail.com>
References: <20200219133012.7cb6ac9e@carbon>
        <CAADnVQKQRKtDz0Boy=-cudc4eKGXB-yParGZv6qvYcQR4uMUQQ@mail.gmail.com>
        <20200219180348.40393e28@carbon>
        <CAEf4Bza9imKymHfv_LpSFE=kNB5=ZapTS3SCdeZsDdtrUrUGcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 19 Feb 2020 09:38:50 -0800
Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> On Wed, Feb 19, 2020 at 9:04 AM Jesper Dangaard Brouer
> <brouer@redhat.com> wrote:
> >
> > On Wed, 19 Feb 2020 08:41:27 -0800
> > Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> >  
> > > On Wed, Feb 19, 2020 at 4:30 AM Jesper Dangaard Brouer
> > > <brouer@redhat.com> wrote:  
> > > >
> > > > I'm willing to help out, such that we can do either version or feature
> > > > detection, to either skip compiling specific test programs or at least
> > > > give users a proper warning of they are using a too "old" LLVM version.  
> > > ...  
> > > > progs/test_core_reloc_bitfields_probed.c:47:13: error: use of unknown builtin '__builtin_preserve_field_info' [-Wimplicit-function-declaration]
> > > >         out->ub1 = BPF_CORE_READ_BITFIELD_PROBED(in, ub1);  
> > >
> > > imo this is proper warning message already.  
> >
> > This is an error, not a warning.  The build breaks as the make process stops.
> >  
> 
> Latest Clang was a requirement for building and running all selftests
> for a long time now. There were few previous discussions on mailing
> list about this and each time the conclusion was the same: latest
> Clang is a requirement for BPF selftests.

The latest Clang is 9.0.1, and it doesn't build with that.

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

