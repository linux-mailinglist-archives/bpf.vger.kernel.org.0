Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2BDB24CA
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2019 19:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729871AbfIMR6F (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Sep 2019 13:58:05 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36772 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbfIMR6F (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 Sep 2019 13:58:05 -0400
Received: by mail-ot1-f67.google.com with SMTP id 67so30223981oto.3;
        Fri, 13 Sep 2019 10:58:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fc8ArwY2yHMv3VLGfSx43u0p3YGfGGpe4m6tepZiINk=;
        b=r3aVCvVytjIjwe/cpovpTALdFJONhd7f610WgoiZEDiMVJNy1HdVbeF0aKgJk0t945
         WpuLHfcCTs38glsv9SCnjV7I+pY3qgdc6ltQochYaIUQgQBo+FfzUAdlYFr7jozRcZ+L
         PxBjxVZM2CXEjIzKJCbzge9oF0PRPmk7G9yDbnnJz0w/6H6aT2cwHV3tXGhhagsGcz+z
         h4lsYGmC/bZiqpWDi0P02yiVgBPuHX/tgeO/p00rSwblhk3fGapaueGsSy/8g6gzl/wB
         80VgY/otAS34FZQZC7fWagChA3Z/jeSOKYOLulYeDzwCubybRhs9UtLp8R/ypWYKGSL0
         khlg==
X-Gm-Message-State: APjAAAW7Kh8Vhtxkymil/iGIHBRYzaZLG1Og902LfKqrCJmLj0QWaYCD
        ZNBAVQhZbFCaxx3iw2sLKXjL8OzNmDfTR/32Zqk=
X-Google-Smtp-Source: APXvYqzyImSnQNT/1nq0D+U2KoEgWBUwap3ooX9gDEXxtzeKquL0nJSL5mI7pRuhD9SS70qXmVNHPZNrhoiX0dxj2SU=
X-Received: by 2002:a05:6830:1196:: with SMTP id u22mr1341707otq.39.1568397484322;
 Fri, 13 Sep 2019 10:58:04 -0700 (PDT)
MIME-Version: 1.0
References: <156821692280.2951081.18036584954940423225.stgit@dwillia2-desk3.amr.corp.intel.com>
 <156821693963.2951081.11214256396118531359.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190911184332.GL20699@kadam> <9132e214-9b57-07dc-7ee2-f6bc52e960c5@kernel.dk>
 <20190913010937.7fc20d93@lwn.net> <20190913114849.GP20699@kadam> <b579153b-3f6d-722c-aea8-abc0d026fa0d@infradead.org>
In-Reply-To: <b579153b-3f6d-722c-aea8-abc0d026fa0d@infradead.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 13 Sep 2019 19:57:52 +0200
Message-ID: <CAMuHMdWZyJ-z6dLFMOdCLotP8J114hGX9C7+bGgxk9ReQ-Si=w@mail.gmail.com>
Subject: Re: [Ksummit-discuss] [PATCH v2 3/3] libnvdimm, MAINTAINERS:
 Maintainer Entry Profile
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Dave Jiang <dave.jiang@intel.com>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Randy,

On Fri, Sep 13, 2019 at 5:00 PM Randy Dunlap <rdunlap@infradead.org> wrote:
> On 9/13/19 4:48 AM, Dan Carpenter wrote:
> >> So I'm expecting to take this kind of stuff into Documentation/.  My own
> >> personal hope is that it can maybe serve to shame some of these "local
> >> quirks" out of existence.  The evidence from this brief discussion suggests
> >> that this might indeed happen.
> >
> > I don't think it's shaming, I think it's validating.  Everyone just
> > insists that since it's written in the Book of Rules then it's our fault
> > for not reading it.  It's like those EULA things where there is more
> > text than anyone can physically read in a life time.
>
> Yes, agreed.
>
> > And the documentation doesn't help.  For example, I knew people's rules
> > about capitalizing the subject but I'd just forget.  I say that if you
> > can't be bothered to add it to checkpatch then it means you don't really
> > care that strongly.
>
> If a subsystem requires a certain spelling/capitalization in patch email
> subjects, it should be added to MAINTAINERS IMO.  E.g.,
> E:      NuBus

Oh, I understood the question differently.  I thought it was about
"sub: system: Fix foo" vs. "sub: system: fix foo".

For simple and trivial things, I tend to make changes while applying, as that's
usually less work than complaining, and verifying that it's been fixed in the
next (if any) version n days/weeks/months later.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
