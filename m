Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 496112778C3
	for <lists+bpf@lfdr.de>; Thu, 24 Sep 2020 20:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728420AbgIXS5N (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Sep 2020 14:57:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45769 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727992AbgIXS5N (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 24 Sep 2020 14:57:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600973832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Axiq0yReIhbW6/4dmIx+opfMoBleK5yZs2UhwoE+Kvs=;
        b=WQVX3iBTEE/USJn8DQ3nzvKKCUqfHt/pi2+NR/laK0DKifMdQcLnUfg/Z5H88GRuzfBoT8
        iwLDnebdVOzknriDdju+tlED36wbcHwZzh//WjtUPhdwzik82E5Xo3o5SxOirCAX0HQCrI
        VNn9LL3qIUSF5K0NdX5ZrsFeRGxNiqY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-WVV_JMg6OJmaRNofl0ABnw-1; Thu, 24 Sep 2020 14:57:07 -0400
X-MC-Unique: WVV_JMg6OJmaRNofl0ABnw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8268E1868410;
        Thu, 24 Sep 2020 18:57:05 +0000 (UTC)
Received: from mail (ovpn-118-223.rdu2.redhat.com [10.10.118.223])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BDB1A73693;
        Thu, 24 Sep 2020 18:57:02 +0000 (UTC)
Date:   Thu, 24 Sep 2020 14:57:02 -0400
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     YiFei Zhu <yifeifz2@illinois.edu>, Jann Horn <jannh@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Valentin Rothberg <vrothber@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Josep Torrellas <torrella@illinois.edu>,
        Tianyin Xu <tyxu@illinois.edu>, bpf@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/6] seccomp: Implement constant action bitmaps
Message-ID: <20200924185702.GA9225@redhat.com>
References: <20200923232923.3142503-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200923232923.3142503-1-keescook@chromium.org>
User-Agent: Mutt/1.14.7 (2020-08-29)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

I'm posting this only for the record, feel free to ignore.

On Wed, Sep 23, 2020 at 04:29:17PM -0700, Kees Cook wrote:
> rfc: https://lore.kernel.org/lkml/20200616074934.1600036-1-keescook@chromium.org/
> alternative: https://lore.kernel.org/containers/cover.1600661418.git.yifeifz2@illinois.edu/
> v1:
> - rebase to for-next/seccomp
> - finish X86_X32 support for both pinning and bitmaps

It's pretty clear the O(1) seccomp filter bitmap was first was
proposed by your RFC in June (albeit it was located in the wrong place
and is still in the wrong place in v1).

> - replace TLB magic with Jann's emulator
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    
That's a pretty fundamental change in v1 compared to your the
non-competing TLB magic technique you used in the RFC last June.

The bitmap isn't the clever part of the patch, the bitmap can be
reviewed in seconds, the difficult part to implement and to review is
how you fill the bitmap and in that respect there's absolutely nothing
in common in between the "rfc:" and the "alternative" link.

In June your bitmap-filling engine was this:

https://lore.kernel.org/lkml/20200616074934.1600036-5-keescook@chromium.org/

Then on Sep 21 YiFei Zhu posted his new innovative BPF emulation
innovation that obsoleted your TLB magic of June:

https://lists.linuxfoundation.org/pipermail/containers/2020-September/042153.html

And on Sep 23 instead of collaborating and helping YiFei Zhu to
improve his BPF emulator, you posted the same technique that looks
remarkably similar without giving YiFei Zhu any attribution and you
instead attribute the whole idea to Jann Horn:

https://lkml.kernel.org/r/20200923232923.3142503-5-keescook@chromium.org

Thanks,
Andrea

