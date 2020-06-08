Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 250341F19A3
	for <lists+bpf@lfdr.de>; Mon,  8 Jun 2020 15:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729056AbgFHNFH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Jun 2020 09:05:07 -0400
Received: from verein.lst.de ([213.95.11.211]:37113 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728245AbgFHNFH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Jun 2020 09:05:07 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3058D68AFE; Mon,  8 Jun 2020 15:05:04 +0200 (CEST)
Date:   Mon, 8 Jun 2020 15:05:03 +0200
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
Message-ID: <20200608130503.GA22898@lst.de>
References: <20200424064338.538313-1-hch@lst.de> <20200424064338.538313-6-hch@lst.de> <1fc7ce08-26a7-59ff-e580-4e6c22554752@oracle.com> <20200608065120.GA17859@lst.de> <c0f216d1-edc1-68e6-7f3e-c00e33452707@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0f216d1-edc1-68e6-7f3e-c00e33452707@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jun 08, 2020 at 09:45:49AM +0200, Vegard Nossum wrote:
> Just a test case.
>
> Allowing the kernel to allocate an unbounded amount of memory on behalf
> of userspace is an easy DOS.
>
> All the length checks were already in there, e.g.
>
>  static int cmm_timeout_handler(struct ctl_table *ctl, int write,
>                               void __user *buffer, size_t *lenp, loff_t 
> *ppos)
>  {
>         char buf[64], *p;
> [...]
>                 len = min(*lenp, sizeof(buf));
>                 if (copy_from_user(buf, buffer, len))
>                         return -EFAULT;

Doesn't help if we don't know the exact limit yet.  But we can put
some arbitrary but reasonable limit like KMALLOC_MAX_SIZE on the
sysctls and see if this sticks.
