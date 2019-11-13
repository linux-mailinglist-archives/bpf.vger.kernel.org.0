Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36B98FA039
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2019 02:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbfKMBf7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Nov 2019 20:35:59 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:35774 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727205AbfKMBf6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Nov 2019 20:35:58 -0500
Received: by mail-ot1-f66.google.com with SMTP id z6so212319otb.2
        for <bpf@vger.kernel.org>; Tue, 12 Nov 2019 17:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tA9TOCxBga9LLC7wRjd3ONed6e5UCLIuIdqzN/pcWuk=;
        b=pgvm7B7MKRNHPnnm+UXqpNAxEKn59mgIkjpVIugT59Mu8TwvXIAzzyQhvDiVCxIl0p
         vI+Yj+13Wusmq5tADceFQlsKUjuwgmmDrjkNeYGEIUHh9w8tZNldmP6Q5WtjVpISdJ0i
         r3oVh4apWhwsDdj9Nw0bWAyVdq8zxIhXTRj/8PmhzFCoHQ/9X/Dg5B4Hj6Y0ruPyQaaR
         rEPfI8qEDLrnHlL1idX+oRviz/9wQZUiz6o40remYNFeKqLceiYDgbAXk1ppNt84zSqw
         zf+6WmCRWk7Wod/xBPOURyhyWoKZqScoLNTr5ASvgI3i5qH5c+mNJETCAbPrPmJU7Yqj
         fNKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tA9TOCxBga9LLC7wRjd3ONed6e5UCLIuIdqzN/pcWuk=;
        b=RN+2ZLlu8rkAdS+MNBM9QZ0BsGkthhMbTlAhM4OdpZ+6ZEp7Zkx4mt9E+fdTsX6OnN
         oMeAWdx3PzV31zqiGZbxee3oWQ3VzW8py6O0AghuYXlsvZvwUhc457ViI1DpMtSSyF0c
         oqBbOPA1FXEAV+EA6P6gouXV8uVXAYStALYmp9P0mea0vJc4BFoC7fdcI5yyd0uWWifW
         B3hNNtRj9PWqdiB1oYo3qhULFwmZhoWvh6yUQBlT1sgSZ22SEiiEtEl8iitv6+q9xniY
         CgJT5Bf3rJsfd9qFYycVIZVJdHEtvKOhZFAZ6a10o52VICIVNZPUyhgv8fxDux2ix8QG
         Tm1w==
X-Gm-Message-State: APjAAAWsZtnS/Zrz1daQO/Lrnn327A6pQ6o6xplRoHwEvE0yvPCmaxJN
        lczPdyNwCxxUD6oibbs5hq+s/ypEMkRjV+LYl3f4Mg==
X-Google-Smtp-Source: APXvYqzyV061KEXPKPAkyAkGRgXJ6fWU+P7KwNCWCXXtSomJ5IUaejCErE/o1rH0NBMapixozrDCWZBdHagrZr75cJE=
X-Received: by 2002:a05:6830:1b70:: with SMTP id d16mr411248ote.71.1573608957281;
 Tue, 12 Nov 2019 17:35:57 -0800 (PST)
MIME-Version: 1.0
References: <20191112000700.3455038-1-jhubbard@nvidia.com> <20191112000700.3455038-9-jhubbard@nvidia.com>
 <20191112204338.GE5584@ziepe.ca> <0db36e86-b779-01af-77e7-469af2a2e19c@nvidia.com>
 <CAPcyv4hAEgw6ySNS+EFRS4yNRVGz9A3Fu1vOk=XtpjYC64kQJw@mail.gmail.com>
 <20191112234250.GA19615@ziepe.ca> <CAPcyv4hwFKmsQpp04rS6diCmZwGtbnriCjfY2ofWV485qT9kzg@mail.gmail.com>
 <28355eb0-4ee5-3418-b430-59302d15b478@nvidia.com>
In-Reply-To: <28355eb0-4ee5-3418-b430-59302d15b478@nvidia.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 12 Nov 2019 17:35:46 -0800
Message-ID: <CAPcyv4hdYZ__3+KJHh+0uX--f-U=pLiZfdO0JDhyBE-nZ=i4FQ@mail.gmail.com>
Subject: Re: [PATCH v3 08/23] vfio, mm: fix get_user_pages_remote() and FOLL_LONGTERM
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alex Williamson <alex.williamson@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Chinner <david@fromorbit.com>,
        David Airlie <airlied@linux.ie>,
        "David S . Miller" <davem@davemloft.net>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Paul Mackerras <paulus@samba.org>,
        Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, bpf@vger.kernel.org,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, KVM list <kvm@vger.kernel.org>,
        linux-block@vger.kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        "Linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Netdev <netdev@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 12, 2019 at 5:08 PM John Hubbard <jhubbard@nvidia.com> wrote:
>
> On 11/12/19 4:58 PM, Dan Williams wrote:
> ...
> >>> It's not redundant relative to upstream which does not do anything the
> >>> FOLL_LONGTERM in the gup-slow path... but I have not looked at patches
> >>> 1-7 to see if something there made it redundant.
> >>
> >> Oh, the hunk John had below for get_user_pages_remote() also needs to
> >> call __gup_longterm_locked() when FOLL_LONGTERM is specified, then
> >> that calls check_dax_vmas() which duplicates the vma_is_fsdax() check
> >> above.
> >
> > Oh true, good eye. It is redundant if it does additionally call
> > __gup_longterm_locked(), and it needs to do that otherwises it undoes
> > the CMA migration magic that Aneesh added.
> >
>
> OK. So just to be clear, I'll be removing this from the patch:
>
>         /*
>          * The lifetime of a vaddr_get_pfn() page pin is
>          * userspace-controlled. In the fs-dax case this could
>          * lead to indefinite stalls in filesystem operations.
>          * Disallow attempts to pin fs-dax pages via this
>          * interface.
>          */
>         if (ret > 0 && vma_is_fsdax(vmas[0])) {
>                 ret = -EOPNOTSUPP;
>                 put_page(page[0]);
>         }
>
> (and the declaration of "vmas", as well).

...and add a call to __gup_longterm_locked internal to
get_user_pages_remote(), right?
