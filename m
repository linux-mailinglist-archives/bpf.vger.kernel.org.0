Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAE81B0A31
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2019 10:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730178AbfILIYP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Sep 2019 04:24:15 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38208 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730179AbfILIYP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Sep 2019 04:24:15 -0400
Received: by mail-lj1-f193.google.com with SMTP id y23so22383737ljn.5;
        Thu, 12 Sep 2019 01:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ECkS2puFAK1gVjPinpMaI687BSxI+r7g336/1esz1k0=;
        b=bobU2/X+jXrG7Z7VhdAPWfrQEBrRDHgblPscgg39+wUJnCf7d4fx3qf6vcFFVvxSkN
         3U4gbkvDhjbCnuW8meMQgC2Ft3e3FFwa0KHF1D5u7qW7MBU1GnNfd/QMkK8wWUaaRqCB
         3JpC+A70eitPZT6pl0sNnHh2A+r/Bjvb6UnMxMWGl1ObfMLIR+F5cnwsHKrEwhjq8yyf
         MAFpuPAHwSYnNDLUlhili68ZfGdf+ruL/K0+YDRvDT04U78lShW4wiNWlvwbwU67SIo/
         T3D0trHu4hTkAJJSD3d30zL/Ox1rPT250C9erYGII76G3/3XIUEY41WiGKx5RXmDT1UJ
         x+xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ECkS2puFAK1gVjPinpMaI687BSxI+r7g336/1esz1k0=;
        b=LRerhYz0dapsDal6WCveyZMFx6etC+hACuljn9qOP2PqzEDl5sbz0bzqv4G/rduYCU
         1siAsCRX00wZ4sIbyqC/ZU1+agBDd/gNp6GupK8marOQgciS8RfiPbKkqa5NGQe6nLm0
         8xZPybx2LdIs/c9yhRAwYDx9f++RMmeS3hGEom4K4ZD981a1KdqX8SApvnpb5S1WyMlA
         Gm2/fTzhW0GpEPg2ExLEr5AftXOfKDNo1nOB2TgzLX/0C1Pyy85eT251NWmMipXtXQ+z
         0vnopwRNX+oqxvMCRVL53i3lMDcNvutXYvNZUAlysaM59XY3cO8f4R0lMe05syXo/Jm2
         xDCQ==
X-Gm-Message-State: APjAAAXT+zcodJ6gyXxIxECUsgigFun1DQD+aKMKn84oJn6IFwoZOvWj
        W6l/JFKHgyPOkFV2eMIeKS8XL7+MLSoJUnuOELc=
X-Google-Smtp-Source: APXvYqwJdAIg0MN468eMceiqvbqhEFZIaSKfHpA6hbEW7p8IU8l3e2/DQsQGc8lPdxLHrAXG/fVObo9RcVpmFUoxXg8=
X-Received: by 2002:a2e:9555:: with SMTP id t21mr9396134ljh.93.1568276653052;
 Thu, 12 Sep 2019 01:24:13 -0700 (PDT)
MIME-Version: 1.0
References: <156821692280.2951081.18036584954940423225.stgit@dwillia2-desk3.amr.corp.intel.com>
 <156821693963.2951081.11214256396118531359.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190911184332.GL20699@kadam> <9132e214-9b57-07dc-7ee2-f6bc52e960c5@kernel.dk>
 <CAPcyv4ij3s+9uO0f9aLHGj3=ACG7hAjZ0Rf=tyFmpt3+uQyymw@mail.gmail.com>
In-Reply-To: <CAPcyv4ij3s+9uO0f9aLHGj3=ACG7hAjZ0Rf=tyFmpt3+uQyymw@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 12 Sep 2019 10:24:01 +0200
Message-ID: <CANiq72k2so3ZcqA3iRziGY=Shd_B1=qGoXXROeAF7Y3+pDmqyA@mail.gmail.com>
Subject: Re: [Ksummit-discuss] [PATCH v2 3/3] libnvdimm, MAINTAINERS:
 Maintainer Entry Profile
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Dan Carpenter <dan.carpenter@oracle.com>,
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

On Thu, Sep 12, 2019 at 9:43 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
> Now I come to find that CodingStyle has settled on clang-format (in
> the last 15 months) as the new standard which is a much better answer
> to me than a manually specified style open to interpretation. I'll
> take a look at getting libnvdimm converted over.

Note that clang-format cannot do everything as we want within the
kernel just yet, but it is a close enough approximation -- it is near
the point where we could simply agree to use it and stop worrying
about styling issues. However, that would mean everyone needs to have
a recent clang-format available, which I think is the biggest obstacle
at the moment.

Cheers,
Miguel
