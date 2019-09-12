Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07C76B099C
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2019 09:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729785AbfILHlh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Sep 2019 03:41:37 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:43035 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbfILHlh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Sep 2019 03:41:37 -0400
Received: by mail-oi1-f193.google.com with SMTP id t84so16356255oih.10
        for <bpf@vger.kernel.org>; Thu, 12 Sep 2019 00:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o8LTeC4govd1fNBJO0ioJqcSmCWQfNIKLUUZIaiAhHg=;
        b=r5iciw4g8aqTCdevxlX7Yl1qKRDD/phXv4v2oTTELHQGit1wxhO/OmSHjpMCzaPPrC
         Vr8pfrqAPKZP/QRditALJa3T7m3utIzI7knIH43NmnrLOYeWwUlpJTX+V+qEIHPXtDWk
         i+S3TBIunng9amNi6owpSMAwGYmTOzTOg39UCXWUFCAs9mW/cRdQ9TrieNsVwozqYGMY
         ud38gNVy7hASRzjURWmOVrK8Lm1bGKmNLt/QqIPlK0Zbi79sDGl94Y4HvgRcvzJv2owV
         GO/6yFDyIZBlsfIr5xvExb4PHDGHZscKuenTgOys/I73OMjRL8cbQsLrUCTP+Fo1/Uy7
         k13A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o8LTeC4govd1fNBJO0ioJqcSmCWQfNIKLUUZIaiAhHg=;
        b=mEkwS/OpjDMp8p+w306zaGLzNYx+2h43sD8FnkfQ5rvh6sPgA5V27+wfq8MH9dFl/s
         5tj+dhJ/uw4s9gn0PbdI/n/mtnDKGplp1jt/TXZY1Sva2HydfYcnr8YMfbQGrk3qAFTp
         2ioPQ2AG9bzpVluGFRuzKsYO3mRe0hN/51f7GLDnJArciI6GQRfVLOh2u4Sybp3zOPNQ
         Imrkb/Cs5JtDXiO5v9SdD6RySV3VoxKHUjo3mGzu09s/0drQAOu7h1VS4Rn6KW0r7YHK
         A54LJkJ+1WPdDXrJF6FZUQ1oUzoweLUuUift5zF9dR3mZYnWlU7s9iL3b3/Do2vNjpzE
         rikQ==
X-Gm-Message-State: APjAAAVHBASO46UtwpPpEAiK+FlEFkYF2rmeYuDa+/4R9AxpBxx0b1wX
        NJpik1ecNQO1/EtqjWEWp00p0Y4UiP1NqpIWCgh71w==
X-Google-Smtp-Source: APXvYqw0A8Lqk6qX7CD0ZjUAfqaCMtvOeZCnyqiVzGAx3LVFCio/Y9Fb+8rbJ3TzTxR704q9l8iceiToxbjJgcESn2g=
X-Received: by 2002:aca:eb09:: with SMTP id j9mr7724558oih.105.1568274096350;
 Thu, 12 Sep 2019 00:41:36 -0700 (PDT)
MIME-Version: 1.0
References: <156821692280.2951081.18036584954940423225.stgit@dwillia2-desk3.amr.corp.intel.com>
 <156821693963.2951081.11214256396118531359.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190911184332.GL20699@kadam> <9132e214-9b57-07dc-7ee2-f6bc52e960c5@kernel.dk>
In-Reply-To: <9132e214-9b57-07dc-7ee2-f6bc52e960c5@kernel.dk>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 12 Sep 2019 00:41:24 -0700
Message-ID: <CAPcyv4ij3s+9uO0f9aLHGj3=ACG7hAjZ0Rf=tyFmpt3+uQyymw@mail.gmail.com>
Subject: Re: [Ksummit-discuss] [PATCH v2 3/3] libnvdimm, MAINTAINERS:
 Maintainer Entry Profile
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Dave Jiang <dave.jiang@intel.com>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 11, 2019 at 3:11 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 9/11/19 12:43 PM, Dan Carpenter wrote:
> > On Wed, Sep 11, 2019 at 08:48:59AM -0700, Dan Williams wrote:
> >> +Coding Style Addendum
> >> +---------------------
> >> +libnvdimm expects multi-line statements to be double indented. I.e.
> >> +
> >> +        if (x...
> >> +                        && ...y) {
> >
> > That looks horrible and it causes a checkpatch warning.  :(  Why not
> > do it the same way that everyone else does it.
> >
> >       if (blah_blah_x && <-- && has to be on the first line for checkpatch
> >           blah_blah_y) { <-- [tab][space][space][space][space]blah
> >
> > Now all the conditions are aligned visually which makes it readable.
> > They aren't aligned with the indent block so it's easy to tell the
> > inside from the if condition.
> >
> > I kind of hate all this extra documentation because now everyone thinks
> > they can invent new hoops to jump through.
>
> FWIW, I completely agree with Dan (Carpenter) here. I absolutely
> dislike having these kinds of files, and with subsystems imposing weird
> restrictions on style (like the quoted example, yuck).
>
> Additionally, it would seem saner to standardize rules around when
> code is expected to hit the maintainers hands for kernel releases. Both
> yours and Martins deals with that, there really shouldn't be the need
> to have this specified in detail per sub-system.

So this is *the* point of the exercise.

I picked up this indentation habit a long while back in response to
review feedback on a patch to a subsystem that formatted code this
way. At the time CodingStyle did not contradict the maintainer's
preference, so I adopted it across the board.

Now I come to find that CodingStyle has settled on clang-format (in
the last 15 months) as the new standard which is a much better answer
to me than a manually specified style open to interpretation. I'll
take a look at getting libnvdimm converted over.

If we can take that further and standardize all of the places where
contributors see variations across subsystems on the fundamental
questions of style, timing, follow-up, and unit test invocation the
Maintainer Entry Profile can be superseded with common guidelines.

Otherwise, yes I completely agree with you that a "Maintainer Entry
Profile" is a sad comment on the state of what contributors need to
navigate, but that's today's reality that needs to be addressed.
