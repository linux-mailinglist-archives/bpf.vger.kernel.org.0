Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59EE3B17D7
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2019 07:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbfIMFAh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Sep 2019 01:00:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:45028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725385AbfIMFAg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 Sep 2019 01:00:36 -0400
Received: from localhost (unknown [84.241.200.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01BAA20717;
        Fri, 13 Sep 2019 05:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568350836;
        bh=yHqpSeWaKdWHTKdxmQpNg5pLxh28uD8FY7G7RDJZJ/Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CljD4YMOdbV28FTif1XLxmaHj1ZdQT/ts0RyBESTYvHflGm7l5aP0S7mF1I9mlBqE
         YBX/SmZmIV61gJbWliZToRYsIEX6EhLRBArA0u82XFHM2IaLxKc0IrEZOEqNNpe6no
         QUFTwH/A9myiKrqb3UXL2Jkqu+dmdcpOSlG0LO3Y=
Date:   Fri, 13 Sep 2019 06:00:31 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, linux-nvdimm@lists.01.org,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [Ksummit-discuss] [PATCH v2 3/3] libnvdimm, MAINTAINERS:
 Maintainer Entry Profile
Message-ID: <20190913050031.GB128462@kroah.com>
References: <156821692280.2951081.18036584954940423225.stgit@dwillia2-desk3.amr.corp.intel.com>
 <156821693963.2951081.11214256396118531359.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190911184332.GL20699@kadam>
 <c2c734d3-ca8d-8485-9b9e-fd64e12aa0f0@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2c734d3-ca8d-8485-9b9e-fd64e12aa0f0@linux.ibm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 13, 2019 at 07:41:55AM +0530, Aneesh Kumar K.V wrote:
> On 9/12/19 12:13 AM, Dan Carpenter wrote:
> > On Wed, Sep 11, 2019 at 08:48:59AM -0700, Dan Williams wrote:
> > > +Coding Style Addendum
> > > +---------------------
> > > +libnvdimm expects multi-line statements to be double indented. I.e.
> > > +
> > > +        if (x...
> > > +                        && ...y) {
> > 
> > That looks horrible and it causes a checkpatch warning.  :(  Why not
> > do it the same way that everyone else does it.
> > 
> > 	if (blah_blah_x && <-- && has to be on the first line for checkpatch
> > 	    blah_blah_y) { <-- [tab][space][space][space][space]blah
> > 
> > Now all the conditions are aligned visually which makes it readable.
> > They aren't aligned with the indent block so it's easy to tell the
> > inside from the if condition.
> 
> 
> I came across this while sending patches to libnvdimm subsystem. W.r.t
> coding Style can we have consistent styles across the kernel? Otherwise, one
> would have to change the editor settings as they work across different
> subsystems in the kernel. In this specific case both clang-format and emacs
> customization tip in the kernel documentation directory suggest the later
> style.

We _should_ have a consistent coding style across the whole kernel,
that's the whole reason for having a coding style in the first place!

The problem is, we all have agreed on the "basics" a long time ago, but
are now down in the tiny nits as to what some minor things should, or
should not, look like.

It might be time to just bite the bullet and do something like
"clang-format" to stop arguing about stuff like this for new
submissions, if for no other reason to keep us from wasting mental
energy on trivial things like this.

thanks,

greg k-h
