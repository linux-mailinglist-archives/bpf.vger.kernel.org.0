Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED70BB18A6
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2019 09:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbfIMHJn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Sep 2019 03:09:43 -0400
Received: from ms.lwn.net ([45.79.88.28]:57676 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727661AbfIMHJn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 Sep 2019 03:09:43 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id D794177D;
        Fri, 13 Sep 2019 07:09:40 +0000 (UTC)
Date:   Fri, 13 Sep 2019 01:09:37 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        ksummit-discuss@lists.linuxfoundation.org,
        linux-nvdimm@lists.01.org, Vishal Verma <vishal.l.verma@intel.com>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [Ksummit-discuss] [PATCH v2 3/3] libnvdimm, MAINTAINERS:
 Maintainer Entry Profile
Message-ID: <20190913010937.7fc20d93@lwn.net>
In-Reply-To: <9132e214-9b57-07dc-7ee2-f6bc52e960c5@kernel.dk>
References: <156821692280.2951081.18036584954940423225.stgit@dwillia2-desk3.amr.corp.intel.com>
        <156821693963.2951081.11214256396118531359.stgit@dwillia2-desk3.amr.corp.intel.com>
        <20190911184332.GL20699@kadam>
        <9132e214-9b57-07dc-7ee2-f6bc52e960c5@kernel.dk>
Organization: LWN.net
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 11 Sep 2019 16:11:29 -0600
Jens Axboe <axboe@kernel.dk> wrote:

> On 9/11/19 12:43 PM, Dan Carpenter wrote:
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

This sort of objection came up at the maintainers summit yesterday; the
consensus was that, while we might not like subsystem-specific rules, they
do currently exist and we're just documenting reality.  To paraphrase
Phillip K. Dick, reality is that which, when you refuse to document it,
doesn't go away.

So I'm expecting to take this kind of stuff into Documentation/.  My own
personal hope is that it can maybe serve to shame some of these "local
quirks" out of existence.  The evidence from this brief discussion suggests
that this might indeed happen.

Thanks,

jon
