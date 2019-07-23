Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0193071886
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2019 14:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389816AbfGWMrK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Jul 2019 08:47:10 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36209 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389806AbfGWMrK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Jul 2019 08:47:10 -0400
Received: by mail-qt1-f193.google.com with SMTP id z4so41776342qtc.3
        for <bpf@vger.kernel.org>; Tue, 23 Jul 2019 05:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=piZ8i8TowZ2SsXDzt8tX5OF8nKyYqoULcyfh5zRNZ38=;
        b=AIBWSs3L6TMrqR1kjSjiMOoco1Jvz8sMlyjAm/koUlgASb3F1pge4pF62yhgDzaLyN
         8W6kJiJVRv2Ltl10P0KJ3h4Rxv4Sqan/wDHsLcdXsjf9MrtAiVLfb6MvuqzOUpw1Pvo5
         nfDvSBFzcy4NTtXExC58RlVhp7zb6QbnLZPrvQwNNigrLSQSCT0Y7gE3jAYG9SExooUW
         JtXIQ7nuInz2UXqhOw5OA3nFxJXlzY3ERVxPfPBlTt9/UEojN9Wnpkk9roKmmsv/AIWs
         aeioIMb0c14NQnQgfwpCWB/P0nQs5B9LzMw6NDgi8cvJhVre3EHc/K68PAB7f3zGy6Lb
         WGNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=piZ8i8TowZ2SsXDzt8tX5OF8nKyYqoULcyfh5zRNZ38=;
        b=kN9Wi921Ynoi2xe7LgAKFJC99woFpgVaGDIIcH1w6Fy5jY26xqRQpTLNKMkInPMGmS
         r2a4mC0Tr1OevDUNRckIZVjV+riau6viIc6OZXYyR/ivftXJBj7do+qWwQ81yUsguPKD
         HrkQYsPb27vFMmDxnA1Dj/2O9XrSMwXQ5I8uT6RglNY1kSDxSK9gB74dl3IKnzhRdFe0
         TZk48W38Qxkn81iXp7XzXjQQ3huMGRY9wdQbi42mjzTGTWsgewU1c9a9X+cZH+z0i8Bg
         gG90JaDJ9EA0TjQpqrouOQW9OZc7TKZ2JsuNfF95FCdZOfbijGwY3vQPhZGMdYM1PPRR
         OK5Q==
X-Gm-Message-State: APjAAAXyC/GEVX+JBiexICDgBlObMEmp0heOU9xKVx8hks1ckr4+xp8e
        PtmVaN6KPzL3L6wDhTEJuF+KEA==
X-Google-Smtp-Source: APXvYqyDweYbQsaT3Kt4MRrQs5/v1m87TpQW/FZm/84f2JQiv3oW3vaHuL2MCkVEVWkDHF7BwFh/Mg==
X-Received: by 2002:ac8:877:: with SMTP id x52mr53156167qth.328.1563886029140;
        Tue, 23 Jul 2019 05:47:09 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id q3sm19357570qkq.133.2019.07.23.05.47.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Jul 2019 05:47:08 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hpuCB-0004tl-I7; Tue, 23 Jul 2019 09:47:07 -0300
Date:   Tue, 23 Jul 2019 09:47:07 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, john.hubbard@gmail.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        Boaz Harrosh <boaz@plexistor.com>,
        Christoph Hellwig <hch@lst.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        David Airlie <airlied@linux.ie>,
        "David S . Miller" <davem@davemloft.net>,
        Ilya Dryomov <idryomov@gmail.com>, Jan Kara <jack@suse.cz>,
        Jens Axboe <axboe@kernel.dk>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Ming Lei <ming.lei@redhat.com>, Sage Weil <sage@redhat.com>,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        Yan Zheng <zyan@redhat.com>, netdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
        linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] net/xdp: convert put_page() to put_user_page*()
Message-ID: <20190723124707.GB15357@ziepe.ca>
References: <20190722223415.13269-1-jhubbard@nvidia.com>
 <20190722223415.13269-4-jhubbard@nvidia.com>
 <20190723002534.GA10284@iweiny-DESK2.sc.intel.com>
 <a4e9b293-11f8-6b3c-cf4d-308e3b32df34@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4e9b293-11f8-6b3c-cf4d-308e3b32df34@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jul 22, 2019 at 09:41:34PM -0700, John Hubbard wrote:

> * The leading underscores are often used for the more elaborate form of the
> call (as oppposed to decorating the core function name with "_flags", for
> example).

IMHO usually the __ version of a public symbol means something like
'why are you using this? you probably should not'

Often because the __ version has no locking or some other dangerous
configuration like that.

Jason
