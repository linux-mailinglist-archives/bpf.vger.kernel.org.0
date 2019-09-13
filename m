Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64537B23A1
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2019 17:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388247AbfIMPqd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Sep 2019 11:46:33 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43396 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387971AbfIMPqd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 Sep 2019 11:46:33 -0400
Received: by mail-qk1-f195.google.com with SMTP id h126so20921169qke.10;
        Fri, 13 Sep 2019 08:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XO70El4oS2tOzApEnum8feip+ENgacm8GuaL7eIjAHM=;
        b=AhblWwK/ROHlFbIbdNsCh7YKSiQqOvgtvVUg/nA45czjfbmYf3swhf+jd8vv5Nv2eE
         TOajmML3fZQqKooKG8Fw3e5TDIxCqjKhdH/ekU91iKoV0+jCPGgCyCjBsQF3zMzumpej
         MmaKBFBxLynI0g5CPUu3a9NN3tGgmF+PmJy5vLJw94ezrvqPGzQ7mnpqdKQPwgp7jOIe
         LaAAjUNA+7bzjNk1JXfVdS0aUPQBpSyHc2cRKejQLhS3s0ug8XSVDzEpvxySyt6egjs4
         G7imPpb0kaQRrEy8d0rYC/MQQPqwnV9g1YOW4o+7LEjbgw4HE+IGDQv84aUiM3SrzDEa
         t/4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XO70El4oS2tOzApEnum8feip+ENgacm8GuaL7eIjAHM=;
        b=l8PQMzJnCQFzUEN5C1oztOWioZW3ugGpWGXX7H+AcERJRNRtZC7hSlZ5RtxDbhC63q
         pV+VMNqnpaAZt7Q0igP7XZgWIchjP7Eu/4ToWXhpqu+aIPzI+k7kONXrgVPisxOPQirX
         GG4xWydhiWtdGz+hWoRfoDnH2oFH703WncAwoV/L0pBFd0CfRh5UlsEWsB+2DfMj+4BV
         pNxD6+BhZ1MThilOWo/GiQ5SOzjad9hsibyZ7TSIWLwbYUiW8BpSoxb/yQ/6QNEv/lB4
         0DbrgcSNVnalrcIezUMdnMvN5tu5dJWXy5Aq2oplfW6WM0CYmZxAZqKF0Qss4vBZjVlV
         8eDA==
X-Gm-Message-State: APjAAAWu0O03YkFgXr/arG8ZATysyzPawWpQof2+o9VOlBFtkI0U3C4M
        dxY/nV5GNM3kL5bzBar8rGrzu+wd1s4QDrNVpw==
X-Google-Smtp-Source: APXvYqwkoYIPGED4jHTOIcDuuctuHZYBF5qjDvf9su4HjEVpVRrH0fkPzLII7bGDsE7EPykfDy10fpoUaYfUeHquyaA=
X-Received: by 2002:a37:682:: with SMTP id 124mr46792397qkg.393.1568389592307;
 Fri, 13 Sep 2019 08:46:32 -0700 (PDT)
MIME-Version: 1.0
References: <156821692280.2951081.18036584954940423225.stgit@dwillia2-desk3.amr.corp.intel.com>
 <156821693963.2951081.11214256396118531359.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190911184332.GL20699@kadam> <9132e214-9b57-07dc-7ee2-f6bc52e960c5@kernel.dk>
 <20190913010937.7fc20d93@lwn.net> <20190913114849.GP20699@kadam> <b579153b-3f6d-722c-aea8-abc0d026fa0d@infradead.org>
In-Reply-To: <b579153b-3f6d-722c-aea8-abc0d026fa0d@infradead.org>
From:   Rob Herring <robherring2@gmail.com>
Date:   Fri, 13 Sep 2019 16:46:21 +0100
Message-ID: <CAL_JsqLo9-zQYGj2vaEWppbioO0rXu-QNbHhydYdMgrZo0_ESg@mail.gmail.com>
Subject: Re: [Ksummit-discuss] [PATCH v2 3/3] libnvdimm, MAINTAINERS:
 Maintainer Entry Profile
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Dave Jiang <dave.jiang@intel.com>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 13, 2019 at 4:00 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 9/13/19 4:48 AM, Dan Carpenter wrote:
>
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

+1

Better make this a regex to deal with (net|net-next).

We could probably script populating MAINTAINERS with this using how it
is done manually: git log --oneline <dir>

Rob
