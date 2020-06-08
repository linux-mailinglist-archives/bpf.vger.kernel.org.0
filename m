Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF6F1F1310
	for <lists+bpf@lfdr.de>; Mon,  8 Jun 2020 08:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbgFHGvY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Jun 2020 02:51:24 -0400
Received: from verein.lst.de ([213.95.11.211]:36063 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728334AbgFHGvX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Jun 2020 02:51:23 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1AB7368AFE; Mon,  8 Jun 2020 08:51:20 +0200 (CEST)
Date:   Mon, 8 Jun 2020 08:51:20 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Vegard Nossum <vegard.nossum@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>, Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        bpf@vger.kernel.org, Andrey Ignatov <rdna@fb.com>
Subject: Re: WARNING: CPU: 1 PID: 52 at mm/page_alloc.c:4826
 __alloc_pages_nodemask (Re: [PATCH 5/5] sysctl: pass kernel
 pointers to ->proc_handler)
Message-ID: <20200608065120.GA17859@lst.de>
References: <20200424064338.538313-1-hch@lst.de> <20200424064338.538313-6-hch@lst.de> <1fc7ce08-26a7-59ff-e580-4e6c22554752@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1fc7ce08-26a7-59ff-e580-4e6c22554752@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jun 04, 2020 at 10:22:21PM +0200, Vegard Nossum wrote:
> It's easy to reproduce by just doing
>
>     read(open("/proc/sys/vm/swappiness", O_RDONLY), 0, 512UL * 1024 * 1024 
> * 1024);
>
> or so. Reverting the commit fixes the issue for me.

Yes, doing giant allocations will fail and trace.  We have to options
here that both seems sensible:

 - trunate sysctrl calls to some sensible length
 - (optionally) use vmalloc

Is this a real application or just a test case trying to do the
stupidmost possible thing?
