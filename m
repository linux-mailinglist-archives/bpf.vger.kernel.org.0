Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D20C29D4C4
	for <lists+bpf@lfdr.de>; Wed, 28 Oct 2020 22:54:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbgJ1Vyb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Oct 2020 17:54:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39459 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728776AbgJ1Vya (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 28 Oct 2020 17:54:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603922069;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DQ4rNLRqwJzcOeRbgE9JyA2XHU9mU+L4iCdtxMXIb5g=;
        b=EnD2awwO8l7V6xHbQqbcmawhkZrsJgrpR//4NuEfpAGrPcGBgobjpYfsOlWok5JKrtne9/
        S9NAU1yyIGt1LF5bwvsdFrPuBTizgG8wnmKf2gJvAAQcq1vJrZj4qoece56NtmsiIiOAQM
        GFUca9OujluXtPxaGeEK74Bru1wswZM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-596-0d2c_orvNyOsPHUQmsdPXQ-1; Wed, 28 Oct 2020 11:53:37 -0400
X-MC-Unique: 0d2c_orvNyOsPHUQmsdPXQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8285C879526;
        Wed, 28 Oct 2020 15:53:35 +0000 (UTC)
Received: from krava (unknown [10.40.192.64])
        by smtp.corp.redhat.com (Postfix) with SMTP id 728AC62A0B;
        Wed, 28 Oct 2020 15:53:29 +0000 (UTC)
Date:   Wed, 28 Oct 2020 16:53:28 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        dwarves@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Mark Wielaard <mjw@redhat.com>
Subject: Re: [PATCH 3/3] btf_encoder: Include static functions to BTF data
Message-ID: <20201028155328.GR2900849@krava>
References: <20201026223617.2868431-1-jolsa@kernel.org>
 <20201026223617.2868431-4-jolsa@kernel.org>
 <CAEf4BzYpntU_ikusuwYLn0eBqvmQLt-qaOqECkBODEeSfwnx6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzYpntU_ikusuwYLn0eBqvmQLt-qaOqECkBODEeSfwnx6w@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 27, 2020 at 04:21:14PM -0700, Andrii Nakryiko wrote:
> On Mon, Oct 26, 2020 at 5:07 PM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Removing the condition to skip static functions.
> >
> > Getting extra 23k functions on my kernel .config:
> >
> >            nr     .BTF size (bytes)
> >   before:  23291  3342279
> >    after:  46606  4361045
> 
> almost exactly 2x... such coincidences make me nervous ;)

hum, nice.. 'new' functions looked good, I'll make the
full list to be sure

jirka

> 
> >
> > The BTF section size increased of about 1MB.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  btf_encoder.c | 3 ---
> >  1 file changed, 3 deletions(-)
> >
> > diff --git a/btf_encoder.c b/btf_encoder.c
> > index 99b9abe36993..03a4bef11947 100644
> > --- a/btf_encoder.c
> > +++ b/btf_encoder.c
> > @@ -485,9 +485,6 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
> >                 int btf_fnproto_id, btf_fn_id;
> >                 const char *name;
> >
> > -               if (!fn->external)
> > -                       continue;
> > -
> >                 /*
> >                  * We need to generate just single BTF instance for the
> >                  * function, while DWARF data contains multiple instances
> > --
> > 2.26.2
> >
> 

