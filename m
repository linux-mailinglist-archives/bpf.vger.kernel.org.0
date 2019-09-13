Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D660B261F
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2019 21:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730844AbfIMTdG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Sep 2019 15:33:06 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:33027 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbfIMTdG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 Sep 2019 15:33:06 -0400
Received: by mail-yw1-f65.google.com with SMTP id d19so8932349ywa.0;
        Fri, 13 Sep 2019 12:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u15qLOoIkxp7cEiegHHFsMr736/3RxJj/WpvpjNuB/w=;
        b=q4dk0LhsoDsIEBV4EyhB9244sene9/mxhEF+KQV4YKoKPHE7SK7jkZFRbWgUQxR1fB
         yOE/YcUNteeeI3lU1PU9VBugQ+9OUWfGYuD++yg30ZEG4nGnzy5YgkSDAuryxrvfGslY
         m/m4CPUYI/Z5PdoIMxNaDoNyKIEX2zHa7aIf4Yrl7kJGDVDRHoGkujUbm4Q9yjFfh4RG
         FTsL8M2++sRCEMxWENJkGzYqQZywmdwLrDmLkkQZxRgyhGoBw7L6gjDcqrnPTHGdeJJL
         Lc6uQCZg8/11s0MbsSl1Kry0emON3LcNoRIzhfrf2BX0LNuU5YWF7MvHjZoU63S0X9jD
         xdTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u15qLOoIkxp7cEiegHHFsMr736/3RxJj/WpvpjNuB/w=;
        b=poZAIIIRkUYQ8dU9wG/XaJjLXFwxJdcW/ouiX2eCKEYOJsy54gMCM4toM/WAGjOBTj
         eBjkokWFvMDXxnNz7cmyaebLA/13stW62ogBY9DzYsmvcrrl1AmNJ8Kl/uTeTL08LGXd
         ZVfemUrzwElK6vN66V3tF6oT1QHyYsmrMb/hQhMZTFxtMCPqrHiWap5YL8W0yzXel5wv
         lhugfwxOeNmdE32OGmknC72oiW5stPr2WSPNOchJBvMZi4b5upUt2P66f+qr/hc6tViI
         UwQLwd5Fqcd55g1pALPPNb48bgjRcYJpxzgf5+PJJkzRpvJjKKdeUz7NEUvbGc/Dz4NX
         p1vg==
X-Gm-Message-State: APjAAAWSqqvRluyEjqLozenr5SRKZ3cHVsgWODT+GbuCZTtwjcYKkNoV
        E6wz+Vbjl/TTlqKar2SJkZq5XLDsgrd/OfrJpQ==
X-Google-Smtp-Source: APXvYqzl9Gmz00Dm5vFdc8rEO+frJ4ZNkwLJ1YEPQUO83/7IjTjFzgLFJ+QiOPrUAgRD1X21OU3A4ibVOH9g531GgIE=
X-Received: by 2002:a81:9182:: with SMTP id i124mr31070145ywg.279.1568403185288;
 Fri, 13 Sep 2019 12:33:05 -0700 (PDT)
MIME-Version: 1.0
References: <156821692280.2951081.18036584954940423225.stgit@dwillia2-desk3.amr.corp.intel.com>
 <156821693963.2951081.11214256396118531359.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190911184332.GL20699@kadam> <9132e214-9b57-07dc-7ee2-f6bc52e960c5@kernel.dk>
 <20190913010937.7fc20d93@lwn.net> <20190913114849.GP20699@kadam>
 <b579153b-3f6d-722c-aea8-abc0d026fa0d@infradead.org> <CAL_JsqLo9-zQYGj2vaEWppbioO0rXu-QNbHhydYdMgrZo0_ESg@mail.gmail.com>
 <f0ad46a34078a2c1eaa013f9b1a5a52becbcd1c5.camel@perches.com>
In-Reply-To: <f0ad46a34078a2c1eaa013f9b1a5a52becbcd1c5.camel@perches.com>
From:   Rob Herring <robherring2@gmail.com>
Date:   Fri, 13 Sep 2019 14:32:53 -0500
Message-ID: <CAL_JsqKOyLefjdW3a7m8fmqSGXAo4CCx2mZzi-JPf5qKD1NWxA@mail.gmail.com>
Subject: Re: [Ksummit-discuss] [PATCH v2 3/3] libnvdimm, MAINTAINERS:
 Maintainer Entry Profile
To:     Joe Perches <joe@perches.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Dave Jiang <dave.jiang@intel.com>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        bpf@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 13, 2019 at 11:42 AM Joe Perches <joe@perches.com> wrote:
>
> On Fri, 2019-09-13 at 16:46 +0100, Rob Herring wrote:
> > On Fri, Sep 13, 2019 at 4:00 PM Randy Dunlap <rdunlap@infradead.org> wrote:
> > > On 9/13/19 4:48 AM, Dan Carpenter wrote:
> > >
> > > > > So I'm expecting to take this kind of stuff into Documentation/.  My own
> > > > > personal hope is that it can maybe serve to shame some of these "local
> > > > > quirks" out of existence.  The evidence from this brief discussion suggests
> > > > > that this might indeed happen.
> > > >
> > > > I don't think it's shaming, I think it's validating.  Everyone just
> > > > insists that since it's written in the Book of Rules then it's our fault
> > > > for not reading it.  It's like those EULA things where there is more
> > > > text than anyone can physically read in a life time.
> > >
> > > Yes, agreed.
> > >
> > > > And the documentation doesn't help.  For example, I knew people's rules
> > > > about capitalizing the subject but I'd just forget.  I say that if you
> > > > can't be bothered to add it to checkpatch then it means you don't really
> > > > care that strongly.
> > >
> > > If a subsystem requires a certain spelling/capitalization in patch email
> > > subjects, it should be added to MAINTAINERS IMO.  E.g.,
> > > E:      NuBus
> >
> > +1
> >
> > Better make this a regex to deal with (net|net-next).
> >
> > We could probably script populating MAINTAINERS with this using how it
> > is done manually: git log --oneline <dir>
>
> I made a similar proposal nearly a decade ago to add a grammar
> to MAINTAINERS sections for patch subject prefixes.
>
> https://lore.kernel.org/lkml/1289919077.28741.50.camel@Joe-Laptop/

Perhaps there's more support for it now. I didn't get through all the
thread, but the positions seemed to range from "who cares, subjects
are easy to edit" to "seems like a good idea and doesn't hurt". I
probably would have implemented something, but perl (tacking on to
checkpatch and having you tell me everything wrong is about all I can
do :)).

Rob
