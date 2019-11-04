Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4F28EE99D
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2019 21:33:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729587AbfKDUdN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 4 Nov 2019 15:33:13 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34251 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729580AbfKDUdM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 4 Nov 2019 15:33:12 -0500
Received: by mail-pf1-f194.google.com with SMTP id n13so1514107pff.1
        for <bpf@vger.kernel.org>; Mon, 04 Nov 2019 12:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=DnK/FIUjtfMpvgjhYJHwDVVqbAfzXMvLjaoAfA8yVt8=;
        b=OY0XB+pnC7EUpHSQ8yqmSdGzuM19l1QV2njz4lt2384NL+vVsTzKuslwpXHwsk0N+I
         dZMVtGQNTBtLEVBnR8gAD9XNgACmQrzJC68sh448rTQlDayrJqeB0M445s6/jf3cT6Pb
         NZZ+pL+6f4BBHH/B3nMcaAYKUkl2AQQnq6f98/RCiuh6DgUl+/f96fWCFaFlkmskNChx
         MZ/7akyfS7PP1xF/9bTh/55R2+Y5DT5rWJm7Cv0RUqBYhuwjKxViCvgW0uYk/xg33Sc/
         xfRMVnNsQczWqMvmGtgK05lodct1STvVjmeasrhxMRgmb3Ko1i8IBBDPrpRAfsUyE3+k
         eHpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=DnK/FIUjtfMpvgjhYJHwDVVqbAfzXMvLjaoAfA8yVt8=;
        b=rpQ/O4C0KOZG298eB28e44BJJ5amTs6GVMa/+SPADJ+vWzdPonnYWd1uHrc306wYe2
         KbhjWGvgA2rKuJbsjQL9dzuRw0EFprFB8vYG3c1YwBV4XCylICxhZ1dYdBghvFqSyTVF
         RgnwelTX67wVkrll8rv7pCj84JcSZktBqhIWgXnC85beySm596YgT8SrOIlEdI1ICtGJ
         ArmKFHBaML4tCcdMNtHnzD/+yFw9rZ8HxIlbBwOdWn8u5HBcMAbYpAuMTGGvMExbmHhZ
         3+RSFRRb8vVN8y0izZpItnReFCVCo9iCdNsOGgp6PHEgd+VNoZXAFnfVToorX3Bt3hx7
         lqmw==
X-Gm-Message-State: APjAAAXBu/2gcDqMZITR8nIbqc7IZI+ZC0tjKz3/iqaKVgdksxf7ov3b
        ie4vMCTnLS7SnY2ho0OCjwSIzA==
X-Google-Smtp-Source: APXvYqyhviRnVEE8HSNsRv5kFXmlmiRaKK/VWcjGWZKAhJfF3CiA7Y5Kptgh8pnqs8cZ8TjFJYIjHQ==
X-Received: by 2002:a17:90a:9406:: with SMTP id r6mr1471858pjo.0.1572899590774;
        Mon, 04 Nov 2019 12:33:10 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id e17sm18228455pfh.121.2019.11.04.12.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 12:33:10 -0800 (PST)
Date:   Mon, 4 Nov 2019 12:33:09 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     John Hubbard <jhubbard@nvidia.com>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alex Williamson <alex.williamson@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        =?UTF-8?Q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Chinner <david@fromorbit.com>,
        David Airlie <airlied@linux.ie>,
        "David S . Miller" <davem@davemloft.net>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jens Axboe <axboe@kernel.dk>,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?Q?J=C3=A9r=C3=B4me_Glisse?= <jglisse@redhat.com>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Paul Mackerras <paulus@samba.org>,
        Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, bpf@vger.kernel.org,
        dri-devel@lists.freedesktop.org, kvm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-media@vger.kernel.org, linux-rdma@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 05/18] mm/gup: introduce pin_user_pages*() and
 FOLL_PIN
In-Reply-To: <20191103211813.213227-6-jhubbard@nvidia.com>
Message-ID: <alpine.DEB.2.21.1911041231520.74801@chino.kir.corp.google.com>
References: <20191103211813.213227-1-jhubbard@nvidia.com> <20191103211813.213227-6-jhubbard@nvidia.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On Sun, 3 Nov 2019, John Hubbard wrote:

> Introduce pin_user_pages*() variations of get_user_pages*() calls,
> and also pin_longterm_pages*() variations.
> 
> These variants all set FOLL_PIN, which is also introduced, and
> thoroughly documented.
> 
> The pin_longterm*() variants also set FOLL_LONGTERM, in addition
> to FOLL_PIN:
> 
>     pin_user_pages()
>     pin_user_pages_remote()
>     pin_user_pages_fast()
> 
>     pin_longterm_pages()
>     pin_longterm_pages_remote()
>     pin_longterm_pages_fast()
> 
> All pages that are pinned via the above calls, must be unpinned via
> put_user_page().
> 

Hi John,

I'm curious what consideration is given to what pageblock migrate types 
that FOLL_PIN and FOLL_LONGTERM pages originate from, assuming that 
longterm would want to originate from MIGRATE_UNMOVABLE pageblocks for the 
purposes of anti-fragmentation?
