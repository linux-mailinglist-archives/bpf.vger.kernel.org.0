Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4059D2A8A34
	for <lists+bpf@lfdr.de>; Thu,  5 Nov 2020 23:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgKEW4b (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Nov 2020 17:56:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46428 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726801AbgKEW4b (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 5 Nov 2020 17:56:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604616990;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C+3TCobREZNEd40HyH1ZY7BViufAqVh7MIgfcPDtSbs=;
        b=EzQFH8tOFLKVPFd3WTMEhrCp8lvmniUwozhmAbFh5LGmLF+4uFCDrNJRnY2Vs8xdmg9TXX
        4ymrz9M1HwwYfYhU5QidfAIs26Hx89XJXXkstFHWs9IK4uDYqcTtaK7CQYgFgpkzu71SW1
        QbRXvWK5EECm780KtD56nKI1+BWu9T0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-476-0lIZyU9nNem3ZMhLEBaTjQ-1; Thu, 05 Nov 2020 17:56:26 -0500
X-MC-Unique: 0lIZyU9nNem3ZMhLEBaTjQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CC5CF86ABD6;
        Thu,  5 Nov 2020 22:56:23 +0000 (UTC)
Received: from krava (unknown [10.40.192.38])
        by smtp.corp.redhat.com (Postfix) with SMTP id 371DD1002C03;
        Thu,  5 Nov 2020 22:56:18 +0000 (UTC)
Date:   Thu, 5 Nov 2020 23:56:17 +0100
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
Subject: Re: [PATCH 3/3] btf_encoder: Change functions check due to broken
 dwarf
Message-ID: <20201105225617.GB4112111@krava>
References: <20201104215923.4000229-1-jolsa@kernel.org>
 <20201104215923.4000229-4-jolsa@kernel.org>
 <CAEf4BzZaUyY0TA_Gq559ojEeT2mHtdc3aUbvB9Q_4u0pZ+WiWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZaUyY0TA_Gq559ojEeT2mHtdc3aUbvB9Q_4u0pZ+WiWQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 05, 2020 at 11:52:35AM -0800, Andrii Nakryiko wrote:

SNIP

> > +        * Let's got through all collected functions and filter
> > +        * out those that are not in ftrace and init code.
> > +        */
> > +       for (i = 0; i < functions_cnt; i++) {
> > +               struct elf_function *func = &functions[i];
> > +
> > +               /*
> > +                * Do not enable .init section functions,
> > +                * but keep .init.bpf.preserve_type functions.
> > +                */
> > +               if (is_init(ms, func->addr) && !is_bpf_init(ms, func->addr))
> > +                       continue;
> > +
> > +               /* Make sure function is within ftrace addresses. */
> > +               if (bsearch(&func->addr, addrs, count, sizeof(addrs[0]), addrs_cmp)) {
> > +                       /*
> > +                        * We iterate over sorted array, so we can easily skip
> > +                        * not valid item and move following valid field into
> > +                        * its place, and still keep the 'new' array sorted.
> > +                        */
> > +                       if (i != functions_valid)
> > +                               functions[functions_valid] = functions[i];
> > +                       functions_valid++;
> > +               }
> > +       }
> 
> can we re-assign function_cnt = functions_valid here? and
> functions_valid could be just a local temporary variable?

good idea, should be simpler.. will change

and ack to all naming changes above ;-)

thanks,
jirka

> 
> > +
> > +       free(addrs);
> > +       return 0;
> > +}
> > +
> 
> [...]
> 

