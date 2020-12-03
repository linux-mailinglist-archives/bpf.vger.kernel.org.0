Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1112CE2CE
	for <lists+bpf@lfdr.de>; Fri,  4 Dec 2020 00:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbgLCXjY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Dec 2020 18:39:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20869 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727495AbgLCXjY (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 3 Dec 2020 18:39:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607038677;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GOkNExEfqJGC/gxnW5k2ZBTTtsT71mTbidAaMq6A3fw=;
        b=iN69z+rhRg4zb+aldRiOwT/taXeooD3cZRyLiT1GICWW07mqlq9aGWY0xPI547CiwDCHbk
        Ek5B/3Zo5WAQP0MT+kbd4dZE+ArthTToh3pb5iPUyN1Ib4FVcxZxSK7UsX1OBVKh7A0KWU
        f+1LK5z+oFeupjET5rOSUybdQqKWl7w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-572-rhCcX1EOMeGAOtCQfXfXoQ-1; Thu, 03 Dec 2020 18:37:55 -0500
X-MC-Unique: rhCcX1EOMeGAOtCQfXfXoQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A63EA190B2A5;
        Thu,  3 Dec 2020 23:37:53 +0000 (UTC)
Received: from krava (unknown [10.40.195.70])
        by smtp.corp.redhat.com (Postfix) with SMTP id BFE2A5D9CA;
        Thu,  3 Dec 2020 23:37:51 +0000 (UTC)
Date:   Fri, 4 Dec 2020 00:37:50 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        dwarves@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>
Subject: Re: [PATCH 2/3] btf_encoder: Use address size based on ELF's class
Message-ID: <20201203233750.GG3613628@krava>
References: <20201203220625.3704363-1-jolsa@kernel.org>
 <20201203220625.3704363-3-jolsa@kernel.org>
 <CAEf4BzbdB4DUJ2BKVsVdpcZHunNxb_6FvAWOFt_be=81Jyxmnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzbdB4DUJ2BKVsVdpcZHunNxb_6FvAWOFt_be=81Jyxmnw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 03, 2020 at 03:22:18PM -0800, Andrii Nakryiko wrote:
> On Thu, Dec 3, 2020 at 2:08 PM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > We can't assume the address size is always size of unsigned
> > long, we have to use directly the ELF's address size.
> >
> > Changing addrs array to __u64 and convert 32 bit address
> > values when copying from ELF section.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> 
> It looks ok to me, but I didn't expect that changes would be so
> numerous... Makes me wonder if pahole ever supported working with ELF
> files of different bitness. I'll defer to Arnaldo to make a call on
> whether this is necessary.

so to test this I built 32bit vmlinux and used 64bit pahole
to generate BTF data on both vmlinux and modules, which I
thought was valid use case

jirka

> 
> >  btf_encoder.c | 24 +++++++++++++++++-------
> >  1 file changed, 17 insertions(+), 7 deletions(-)
> >
> 
> [...]
> 

