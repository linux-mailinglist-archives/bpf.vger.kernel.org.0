Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDD922697B
	for <lists+bpf@lfdr.de>; Wed, 22 May 2019 20:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729437AbfEVSA6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 May 2019 14:00:58 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42777 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727984AbfEVSA6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 May 2019 14:00:58 -0400
Received: by mail-pg1-f195.google.com with SMTP id e17so1555366pgo.9
        for <bpf@vger.kernel.org>; Wed, 22 May 2019 11:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fomichev-me.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2tdbUZKcbmM5eG+7PJ6oNYXv2F3nrkrzT44hhTiJB5E=;
        b=Fko0kVHzVua4V1E+skFJRk1+jeekM43F+Q2jSAsUmHOWIy3HZZ5iZmKZZ9JRA1NL+d
         M+LivpcFcyiDckUrzJ8X99ivhfUliHGeBXC3JPPXu9IJ2isaTI8RpcnXVXAtDcdpiGWs
         7a6sZUTGP0ApvZVYKyfXp0pKhhKvzRtwah+PIoBpY4NpYM93Bpmt/fF9Zjka411qe9pf
         z1t33BQn/fiI0IGox21oSjv8gJ0Cs5IpOZQ5YWbek8qxvpuVk5BW7WfuMvCt55NVKqU3
         dhIaPPpwpLQGX1z+fAAK8MjstIJQUyLRBqHgV5+U/LXNYuxuJQge4R0VE/KOzgrk+PZF
         LLZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2tdbUZKcbmM5eG+7PJ6oNYXv2F3nrkrzT44hhTiJB5E=;
        b=ZBKG24XG548SQw3hwA//bpop4O2ZrB2kMMceOL+fb3wdEl25n7sYuMFpYF0wVOpMt3
         79wmm440bpAZDxZ+xtvJ1H7sJHXrtf8bcrVfji2asxG21zceb3sMc16LBagvD3f59SYg
         QFHaV4sAFSR1R+mQ//8vE1sLRJ5zMmHkoTSOwRNYe/fTkvx6IAclAUc5Jc5f3N31sVx2
         sPiG/bNOTgpSKIEc7BaQoCWMXjAMAH2/37i/6Lrg/mcReIisKPM9SQdhkuqiBPczhfGh
         yPjYZ6wsq7upVws2IO3o1czPXxaeuW8+Lb3CaNQhn6ZVHvcQ6CoNmU3SRuY8YhuYONG4
         JU0Q==
X-Gm-Message-State: APjAAAVga1lpdKO0FNEINudPA6/KtvZRybrXCIsICaIzCA3S1RgL4UFI
        FwQgCRTwHSsTrnNcRgsnq1Igzw==
X-Google-Smtp-Source: APXvYqw+IVPXpkj0GJcQviTi4t8KCOSlo3RNdJoP1pEHfin0HvL0CMDPw1VCiuMAnYpyH4nK1uiTzw==
X-Received: by 2002:a63:2d41:: with SMTP id t62mr92627876pgt.113.1558548057332;
        Wed, 22 May 2019 11:00:57 -0700 (PDT)
Received: from localhost ([2601:646:8f00:18d9:d0fa:7a4b:764f:de48])
        by smtp.gmail.com with ESMTPSA id p63sm27535722pfb.70.2019.05.22.11.00.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 May 2019 11:00:56 -0700 (PDT)
Date:   Wed, 22 May 2019 11:00:55 -0700
From:   Stanislav Fomichev <sdf@fomichev.me>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@fb.com>, Andrii Nakryiko <andriin@fb.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next] libbpf: emit diff of mismatched public API, if
 any
Message-ID: <20190522180055.GM10244@mini-arch>
References: <20190522161520.3407245-1-andriin@fb.com>
 <1b027a52-4ac7-daf8-ee4a-eb528f53e526@fb.com>
 <20190522164656.GK10244@mini-arch>
 <CAEf4BzYRRgei0DE_K2XKg9y6BJRj8X1ob_6uV4oi9Vm5t=eAQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzYRRgei0DE_K2XKg9y6BJRj8X1ob_6uV4oi9Vm5t=eAQA@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 05/22, Andrii Nakryiko wrote:
> On Wed, May 22, 2019 at 9:46 AM Stanislav Fomichev <sdf@fomichev.me> wrote:
> >
> > On 05/22, Alexei Starovoitov wrote:
> > > On 5/22/19 9:15 AM, Andrii Nakryiko wrote:
> > > > It's easy to have a mismatch of "intended to be public" vs really
> > > > exposed API functions. While Makefile does check for this mismatch, if
> > > > it actually occurs it's not trivial to determine which functions are
> > > > accidentally exposed. This patch dumps out a diff showing what's not
> > > > supposed to be exposed facilitating easier fixing.
> > > >
> > > > Signed-off-by: Andrii Nakryiko <andriin@fb.com>
> > > > ---
> > > >   tools/lib/bpf/.gitignore | 2 ++
> > > >   tools/lib/bpf/Makefile   | 8 ++++++++
> > > >   2 files changed, 10 insertions(+)
> > > >
> > > > diff --git a/tools/lib/bpf/.gitignore b/tools/lib/bpf/.gitignore
> > > > index d9e9dec04605..c7306e858e2e 100644
> > > > --- a/tools/lib/bpf/.gitignore
> > > > +++ b/tools/lib/bpf/.gitignore
> > > > @@ -3,3 +3,5 @@ libbpf.pc
> > > >   FEATURE-DUMP.libbpf
> > > >   test_libbpf
> > > >   libbpf.so.*
> > > > +libbpf_global_syms.tmp
> > > > +libbpf_versioned_syms.tmp
> > > > diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
> > > > index f91639bf5650..7e7d6d851713 100644
> > > > --- a/tools/lib/bpf/Makefile
> > > > +++ b/tools/lib/bpf/Makefile
> > > > @@ -204,6 +204,14 @@ check_abi: $(OUTPUT)libbpf.so
> > > >                  "versioned symbols in $^ ($(VERSIONED_SYM_COUNT))." \
> > > >                  "Please make sure all LIBBPF_API symbols are"       \
> > > >                  "versioned in $(VERSION_SCRIPT)." >&2;              \
> > > > +           readelf -s --wide $(OUTPUT)libbpf-in.o |                 \
> > > > +               awk '/GLOBAL/ && /DEFAULT/ && !/UND/ {print $$8}'|   \
> > > > +               sort -u > $(OUTPUT)libbpf_global_syms.tmp;           \
> > > > +           readelf -s --wide $(OUTPUT)libbpf.so |                   \
> > > > +               grep -Eo '[^ ]+@LIBBPF_' | cut -d@ -f1 |             \
> > > > +               sort -u > $(OUTPUT)libbpf_versioned_syms.tmp;        \
> > > > +           diff -u $(OUTPUT)libbpf_global_syms.tmp                  \
> > > > +                $(OUTPUT)libbpf_versioned_syms.tmp;                 \
> > > >             exit 1;                                                  \
> > >
> > > good idea.
> > > how about removing tmp files instead of adding them to .gitignore?
> > We should be able to do it without any temp files. At least in bash
> > one can do:
> >
> > diff -u <(readelf -s --wide ${OUTPUT}libbpf-in.o | \
> >           awk '/GLOBAL/ && /DEFAULT/ && !/UND/ {print $8}' | \
> >           sort -u) \
> >         <(readelf -s --wide ${OUTPUT}libbpf.so | \
> >           grep -Eo '[^ ]+@LIBBPF_' | cut -d@ -f1 | \
> >           sort -u)
> >
> > But might be complicated in the makefile :-/
> 
> that was my initial implementation, but it doesn't work in Makefile,
> as it's bash-specific
I guess you can wrap it in 'bash -c', but I'm not sure it's better
than the temp files at this point :)

diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
index f91639bf5650..a0005673dcd5 100644
--- a/tools/lib/bpf/Makefile
+++ b/tools/lib/bpf/Makefile
@@ -204,6 +204,13 @@ check_abi: $(OUTPUT)libbpf.so
                     "versioned symbols in $^ ($(VERSIONED_SYM_COUNT))." \
                     "Please make sure all LIBBPF_API symbols are"       \
                     "versioned in $(VERSION_SCRIPT)." >&2;              \
+               bash -c " \
+                    diff -u <(readelf -s --wide $(OUTPUT)libbpf-in.o |  \
+                              awk '/GLOBAL/ && /DEFAULT/ && !/UND/      \
+                              {print \$$8}' | sort -u)                  \
+                            <(readelf -s --wide $(OUTPUT)libbpf.so |    \
+                              grep -Eo '[^ ]+@LIBBPF_' | cut -d@ -f1 |  \
+                              sort -u);"                                \
                exit 1;                                                  \
        fi
