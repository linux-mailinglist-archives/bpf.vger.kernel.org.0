Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2E17B52B7
	for <lists+bpf@lfdr.de>; Tue, 17 Sep 2019 18:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfIQQQL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Sep 2019 12:16:11 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36877 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbfIQQQL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 Sep 2019 12:16:11 -0400
Received: by mail-qt1-f196.google.com with SMTP id d2so5132150qtr.4
        for <bpf@vger.kernel.org>; Tue, 17 Sep 2019 09:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wUSrZbzIskB5WIv6mGXsAI6kr8i5gc29LkRGwKVeGXM=;
        b=UB8ZjQ6t2RXRP4qUcxodQZxciXCCc7sxGAk2UUoDWxaB7d5HQ3MdDo5sdwrjqxk5L4
         Oo4MhddCK3g+VR/wr0z8ftJQ7PG/yHSdJOG/z+rOmnFb+XODTEZ73B2kKPrSC2xg3z1O
         UEZwV4cfvp7L7yD7Dg74u+oJKxy3rNk0KjMj9NCYoatcjrTj59pzE+c/hoqVEYS4nbKJ
         gHcjMVekrpawig5RFqZsai39k2ibTaAOmGGaEE5xiNnsQraObvK1GTRkASUVsU1+iA8P
         u3e5/MRCd9nJT81eyF4H27txFn4LKeR9TKwkCSspUtU9S1t01/WQGyBY0pBm0LrNmVTJ
         U5Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wUSrZbzIskB5WIv6mGXsAI6kr8i5gc29LkRGwKVeGXM=;
        b=iku18rUk2Fy47g1gH8Tk49fKC5UyhpRWkfS0/xAOPn/CEH2hE4xoPIwupUlk3Ts1y6
         EhZkWDptJKyvbsh/UbIy9NZq96b/4S/P71HTSb3C8xGEbqcbaQ6cyfhF3j3GFcLA1E0T
         yjg7hvN84mF9SO/QFByZC75IC14RZkEOx7fLVb4iJ7ab1HNo/nI+8UAk9h43mr4XjpZA
         ZRjyO9A8lQk/wuU9TWxPhZK82krAsFOMhdY6N81xAs1J1HwbM5q9MLxYYvxTmvjwo7FM
         v1OcUQEp22FzLQP2iT+exWc2X+GdHD0YqLbWgsNuvr1aS3rgzAghLw9CK1GieVwNi+FO
         Rg/Q==
X-Gm-Message-State: APjAAAXbgFbL3XlJ/SKy/8uBYmdGpVx6jZFRmYDNOkw09z2jk0KTK/D1
        oFj3oNIvahnHa/CaLA4rBh/0kg==
X-Google-Smtp-Source: APXvYqxhRx/kCEQ+mWvLpcBHWrhM2cXxzhSNrnf0x3fx4s9weIUtltlWrAZoFR448w68N1H6KAMkjw==
X-Received: by 2002:a0c:be88:: with SMTP id n8mr3759902qvi.67.1568736970347;
        Tue, 17 Sep 2019 09:16:10 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-223-10.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.223.10])
        by smtp.gmail.com with ESMTPSA id f144sm1325940qke.132.2019.09.17.09.16.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Sep 2019 09:16:09 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iAG9B-0003iJ-0R; Tue, 17 Sep 2019 13:16:09 -0300
Date:   Tue, 17 Sep 2019 13:16:08 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        ksummit-discuss@lists.linuxfoundation.org,
        linux-nvdimm@lists.01.org, Vishal Verma <vishal.l.verma@intel.com>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [Ksummit-discuss] [PATCH v2 3/3] libnvdimm, MAINTAINERS:
 Maintainer Entry Profile
Message-ID: <20190917161608.GA12866@ziepe.ca>
References: <156821692280.2951081.18036584954940423225.stgit@dwillia2-desk3.amr.corp.intel.com>
 <156821693963.2951081.11214256396118531359.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190911184332.GL20699@kadam>
 <9132e214-9b57-07dc-7ee2-f6bc52e960c5@kernel.dk>
 <20190913010937.7fc20d93@lwn.net>
 <20190913114849.GP20699@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190913114849.GP20699@kadam>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 13, 2019 at 02:48:50PM +0300, Dan Carpenter wrote:

> It used to be that infiniband used "sizeof foo" instead of sizeof(foo)
> but now there is a new maintainer.

These days I run everything through checkpatch and generally don't
want to see much deviation from the 'normal' style, a few minor
clang-format quibbles and other check patch positives excluded.

This means when people touch lines they have to adjust minor things
like the odd 'sizeof foo' to make it conforming.

Like others there is a big historical mismatch and the best I hope for
is that new stuff follow the cannonical style. Trying to guess what
some appropriate mongral style is for each patch is just a waste of my
time.

I also hold drivers/infiniband as an example of why the column
alignment style is harmful. That has not aged well and is the cause of
a lot of ugly things.

> There is one subsystem where the maintainer is super strict rules that
> you can't use "I" or "we" in the commit message.  So you can't say "I
> noticed a bug while reviewing", you have to say "The code has a bug".

Ah, the imperative mood nitpick. This one is very exciting to explain
to non-native speakers. With many regular submitters I'm still at the
"I wish you would use proper grammer and sentence structure" phase..

These days I just end up copy editing most of the commit messages :(

> I don't think it's shaming, I think it's validating.  Everyone just
> insists that since it's written in the Book of Rules then it's our fault
> for not reading it.  It's like those EULA things where there is more
> text than anyone can physically read in a life time.

Yeah, I tend to agree.

The big special cases with high patch volumes (net being the classic
example) should remain special.

But everyone else is not special, and shouldn't act the same.

The work people like DanC do with static analysis is valuable, and we
should not be insisting that those contributors have to jump through a
thousand special hoops.

I have simply viewed it as the job of the maintainer to run the
process and deal with minor nit picks on the fly.

Maybe that is what we should be documenting? 

Jason
