Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 159A21C0C34
	for <lists+bpf@lfdr.de>; Fri,  1 May 2020 04:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbgEACiZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Apr 2020 22:38:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53150 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728024AbgEACiZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Apr 2020 22:38:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588300703;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P8k2aTeCbIA0Pe5nqRNlnguJBbZob6iEKj+wNv40n6s=;
        b=X+kNky8FxvVt4czptIdJNzpjOTygN2raEEp0wFsi0Athju4aulnSJQuVY0TkeQo0wAZEA0
        c3IVN06HAPUKUtEBtE6r1BTTxEhh21viVgRmRrXLqEW2rc12ce1p/vc9t5//pffmjcrOk/
        kmfDbQXXw1XSR/oS8EwhSnLZbykGyj0=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-O4kmHAwuPQ-quxnvhwYaxQ-1; Thu, 30 Apr 2020 22:38:22 -0400
X-MC-Unique: O4kmHAwuPQ-quxnvhwYaxQ-1
Received: by mail-ua1-f72.google.com with SMTP id a19so3652431uah.20
        for <bpf@vger.kernel.org>; Thu, 30 Apr 2020 19:38:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P8k2aTeCbIA0Pe5nqRNlnguJBbZob6iEKj+wNv40n6s=;
        b=C24amob+dL2288oJFs+wRlNo8NruL7yPoP8EvMIHzCIEY9d2qzuvsfHm3QQPRZy3As
         oQ1r6+GREfB1a3+cFRKY5bZcbJKYqGePi5eX5kgQJfft6bDeyALPMZ3WyRpCWBg/t20w
         J0eaitChtLHLoTfDfzER7em8qBbN3b5+WimYZfNotFIatirMvEXBqtOo8uATrVeNh+O6
         PbcXp71xWyn+egLfWbzcN5KsDg1coby5xAadDmUF2oyhHDTCRXCLQM3yBv1fykoBrCIn
         w2YJurC1pFs/z4cREcoGWS7MzedaVJciQzSo3XWJpLvDkYAXOy+JknjcJYark1SvzHTD
         j1Nw==
X-Gm-Message-State: AGi0Pua3HshwMXLIiuVvNroehu8kKLtWQqaZjJUkeFuC5Cqor/WNa+PA
        1e77VqGfXrBlZ5fT7hmxQ2qfJzjBS6VM3sFTtAyBli23XOQRIGSHPVZCBaX4OCNwJ3iXYvc1xY9
        5wTeGKpAuG3ykcPJk/W/uhKPiHizf
X-Received: by 2002:a05:6102:4d:: with SMTP id k13mr1848872vsp.198.1588300701703;
        Thu, 30 Apr 2020 19:38:21 -0700 (PDT)
X-Google-Smtp-Source: APiQypKu6ClZ61atP80MD4lQJkn2FtP3gZkiC+YuTXU2rwKV21SshkG1nW93zQxISm3Y7jRVOl6JpuyIYF8Yu55j3FA=
X-Received: by 2002:a05:6102:4d:: with SMTP id k13mr1848869vsp.198.1588300701546;
 Thu, 30 Apr 2020 19:38:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200414131348.444715-1-hch@lst.de> <20200414131348.444715-22-hch@lst.de>
 <20200414151344.zgt2pnq7cjq2bgv6@debian> <CAMeeMh8Q3Od76WaTasw+BpYVF58P-HQMaiFKHxXbZ_Q3tQPZ=A@mail.gmail.com>
In-Reply-To: <CAMeeMh8Q3Od76WaTasw+BpYVF58P-HQMaiFKHxXbZ_Q3tQPZ=A@mail.gmail.com>
From:   John Dorminy <jdorminy@redhat.com>
Date:   Thu, 30 Apr 2020 22:38:10 -0400
Message-ID: <CAMeeMh_9N0ORhPM8EmkGeeuiDoQY3+QoAPX5QBuK7=gsC5ONng@mail.gmail.com>
Subject: Re: [PATCH 21/29] mm: remove the pgprot argument to __vmalloc
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>, x86@kernel.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Peter Zijlstra <peterz@infradead.org>,
        linuxppc-dev@lists.ozlabs.org, linux-hyperv@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        bpf@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Gao Xiang <xiang@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

>> On Tue, Apr 14, 2020 at 03:13:40PM +0200, Christoph Hellwig wrote:
>> > The pgprot argument to __vmalloc is always PROT_KERNEL now, so remove
>> > it.

Greetings;

I recently noticed this change via the linux-next tree.

It may not be possible to edit at this late date, but the change
description refers to PROT_KERNEL, which is a symbol which does not
appear to exist; perhaps PAGE_KERNEL was meant? The mismatch caused me
and a couple other folks some confusion briefly until we decided it
was supposed to be PAGE_KERNEL; if it's not too late, editing the
description to clarify so would be nice.

Many thanks.

John Dorminy

