Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCCA330B18B
	for <lists+bpf@lfdr.de>; Mon,  1 Feb 2021 21:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbhBAUY4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Feb 2021 15:24:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37590 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231233AbhBAUYz (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 1 Feb 2021 15:24:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612211009;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Zy/d3ouwW+DEWPfMWwSlPLzxe73fc6UfNq2CAJ05vH4=;
        b=UK68ChqmhtSur30yEOWeTkbhU5p8jHBokuCrYpRPAcVB/AiFkTj+LvvSvCSeL19TqT/4bv
        bKihZU1oybb7/C0L8tbxxGm8xyYzoAVqEHegdkJG1sxIr8dpC1TALpPNx0itlf9+ijS8Vo
        TyTBVsKOyyBknAOgOur9dvdP4pgQQB4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-504-DgSPE66WOtGeWOBB6QGMnw-1; Mon, 01 Feb 2021 15:23:25 -0500
X-MC-Unique: DgSPE66WOtGeWOBB6QGMnw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4CEDE801AC0;
        Mon,  1 Feb 2021 20:23:24 +0000 (UTC)
Received: from krava (unknown [10.40.192.169])
        by smtp.corp.redhat.com (Postfix) with SMTP id B5E9C60877;
        Mon,  1 Feb 2021 20:23:22 +0000 (UTC)
Date:   Mon, 1 Feb 2021 21:23:21 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Paul Moore <paul@paul-moore.com>,
        Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>
Subject: Re: selftest/bpf/test_verifier_log fails on v5.11-rc5
Message-ID: <YBhjOaoV2NqW3jFI@krava>
References: <CAHC9VhQgy959hkpU8fwZnrTqGphVSA+ONF99Yy4ZQFyjQ_030A@mail.gmail.com>
 <CAADnVQJaJ0i2L2k-dM+neeT61q+pwEd+F6ASGh4Xbi-ogj0hfQ@mail.gmail.com>
 <CAHC9VhSTJ=009hsXm=8jtQ_ZL-n=+tzKPbWj2Cnoa5w3iVNuew@mail.gmail.com>
 <CAADnVQKbku+Mv++h2TKYZfFN7NjPgaeLHJsw0oFNUhjUZ6ehSQ@mail.gmail.com>
 <YBXGChWt/E2UDgZc@krava>
 <YBci6Y8bNZd6KRdw@krava>
 <20210201122532.GE794568@kernel.org>
 <YBgVLqNxL++zVkdK@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YBgVLqNxL++zVkdK@krava>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 01, 2021 at 03:50:22PM +0100, Jiri Olsa wrote:

SNIP

> > > 
> > > with Arnaldo's fixes I see less struct duplications,
> > > but still there's some
> > > 
> > > > 
> > > > I uploaded the build log from linking part to:
> > > >   http://people.redhat.com/~jolsa/build.out.gz
> > > 
> > > however looks like we don't handle DW_FORM_implicit_const
> > > when counting the byte offset.. it was used for some struct
> > > members in my vmlinux, so we got zero for byte offset and
> > > that created another unique struct
> > > 
> > > with patch below I no longer see any struct duplication,
> > > also test_verifier_log is working for me, but I could
> > > not reproduce the error before
> > > 
> > > I'll post full dwarves patch after some more testing
> > > 
> > > also I wonder we could somehow use btf_check_all_metas
> > > from kernel after we build BTF data, that'd help to catch
> > > this earlier/easier ;-) I'll check on this
> > 
> > Seems like a good idea indeed :-)
> > 
> > I'm applying the patch below with your Signed-off-by, etc, ok?
> 
> ok, thanks

Paul, Ondrej,

I put all the recent fixes and made a scratch build:
  https://koji.fedoraproject.org/koji/taskinfo?taskID=61049457

if you have a chance to test and check your issue was resolved,
that'd be great

thanks,
jirka

