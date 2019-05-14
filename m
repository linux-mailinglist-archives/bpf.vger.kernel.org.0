Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6005F1C0D5
	for <lists+bpf@lfdr.de>; Tue, 14 May 2019 05:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbfENDK7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 May 2019 23:10:59 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:48495 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbfENDK7 (ORCPT
        <rfc822;groupwise-bpf@vger.kernel.org:0:0>);
        Mon, 13 May 2019 23:10:59 -0400
Received: from emea4-mta.ukb.novell.com ([10.120.13.87])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Tue, 14 May 2019 05:10:57 +0200
Received: from GaryWorkstation (nwb-a10-snat.microfocus.com [10.120.13.201])
        by emea4-mta.ukb.novell.com with ESMTP (TLS encrypted); Tue, 14 May 2019 04:10:40 +0100
Date:   Tue, 14 May 2019 11:10:35 +0800
From:   Gary Lin <glin@suse.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH v2 bpf-next] bpf: btf: fix the brackets of
 BTF_INT_OFFSET()
Message-ID: <20190514031035.GB23588@GaryWorkstation>
References: <20190513094548.9542-1-glin@suse.com>
 <CAEf4BzYaxdyO+4y9U6TYrKw7fi6KrA5UBNPURfz+p1qc13x03g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzYaxdyO+4y9U6TYrKw7fi6KrA5UBNPURfz+p1qc13x03g@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, May 13, 2019 at 08:57:00AM -0700, Andrii Nakryiko wrote:
> On Mon, May 13, 2019 at 3:23 AM Gary Lin <glin@suse.com> wrote:
> >
> > 'VAL' should be protected by the brackets.
> >
> > v2:
> > * Squash the fix for Documentation/bpf/btf.rst
> >
> > Fixes: 69b693f0aefa ("bpf: btf: Introduce BPF Type Format (BTF)")
> > Signed-off-by: Gary Lin <glin@suse.com>
> > ---
> >  Documentation/bpf/btf.rst | 2 +-
> >  include/uapi/linux/btf.h  | 2 +-
> 
> Can you please also sync btf.h into tools/include/uapi/linux/btf.h?
> But as a separate patch, because otherwise it will cause issues when
> syncing libbpf into github.com/libbpf/libbpf repo. Thanks!
> 
I didn't notice that btf.h is also in tools/include.
Will send another patch to sync the fix.

Thanks,

Gary Lin

> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/bpf/btf.rst b/Documentation/bpf/btf.rst
> > index 8820360d00da..35d83e24dbdb 100644
> > --- a/Documentation/bpf/btf.rst
> > +++ b/Documentation/bpf/btf.rst
> > @@ -131,7 +131,7 @@ The following sections detail encoding of each kind.
> >  ``btf_type`` is followed by a ``u32`` with the following bits arrangement::
> >
> >    #define BTF_INT_ENCODING(VAL)   (((VAL) & 0x0f000000) >> 24)
> > -  #define BTF_INT_OFFSET(VAL)     (((VAL  & 0x00ff0000)) >> 16)
> > +  #define BTF_INT_OFFSET(VAL)     (((VAL) & 0x00ff0000) >> 16)
> >    #define BTF_INT_BITS(VAL)       ((VAL)  & 0x000000ff)
> >
> >  The ``BTF_INT_ENCODING`` has the following attributes::
> > diff --git a/include/uapi/linux/btf.h b/include/uapi/linux/btf.h
> > index 9310652ca4f9..63ae4a39e58b 100644
> > --- a/include/uapi/linux/btf.h
> > +++ b/include/uapi/linux/btf.h
> > @@ -83,7 +83,7 @@ struct btf_type {
> >   * is the 32 bits arrangement:
> >   */
> >  #define BTF_INT_ENCODING(VAL)  (((VAL) & 0x0f000000) >> 24)
> > -#define BTF_INT_OFFSET(VAL)    (((VAL  & 0x00ff0000)) >> 16)
> > +#define BTF_INT_OFFSET(VAL)    (((VAL) & 0x00ff0000) >> 16)
> >  #define BTF_INT_BITS(VAL)      ((VAL)  & 0x000000ff)
> >
> >  /* Attributes stored in the BTF_INT_ENCODING */
> > --
> > 2.21.0
> >
> 
