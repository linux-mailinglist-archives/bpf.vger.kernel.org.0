Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DFCE403EF2
	for <lists+bpf@lfdr.de>; Wed,  8 Sep 2021 20:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234070AbhIHSQh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Sep 2021 14:16:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:46980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232509AbhIHSQg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Sep 2021 14:16:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 656E861100;
        Wed,  8 Sep 2021 18:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1631124928;
        bh=G9enD3BK6oGuRKGWCXkTjniebaPc0KdYuaPPqV3q80A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cTCIvgQSGjSt3cQVQO+EYTwnCE7lZr9v5WJ45kCaDFBRIVj4Od7K/Sjw1RmONruHS
         HIxFkdeaP5W5q6xJaDLGA48LlwveR9X+FiKpN0fhmz3WPo93US8uuH7kWhviOKbuiL
         FF6ek7PEYgI5G5hqZnBZCticc2GNpACi84cC2mT8=
Date:   Wed, 8 Sep 2021 11:15:27 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Luigi Rizzo <lrizzo@google.com>, Yonghong Song <yhs@fb.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Michel Lespinasse <walken@google.com>,
        bpf <bpf@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH mm/bpf v2] mm: bpf: add find_vma_no_check() without
 lockdep_assert on mm->mmap_lock
Message-Id: <20210908111527.9a611426e257d55ccbbf46eb@linux-foundation.org>
In-Reply-To: <20210908180258.yjh62e5oouckar5b@ast-mbp.dhcp.thefacebook.com>
References: <20210908044427.3632119-1-yhs@fb.com>
        <ebcddf07-f329-05fa-8fdc-b2b9d6b0127b@iogearbox.net>
        <20210908135326.GZ1200268@ziepe.ca>
        <YTjFcek5B3ltYtG3@hirez.programming.kicks-ass.net>
        <CAMOZA0+FofdYMivrBR14snb6Xo_i6BV7gVX1dGCtJa=ue3VqEQ@mail.gmail.com>
        <20210908151230.m2zyslt4qrufm4bv@revolver>
        <f5328a05-ed3c-a868-9240-1b0852e01406@fb.com>
        <CAMOZA0+2KLgYTXDZHGUYFnYezee=_hH6kFVM+-n2ZQuFTfh6yg@mail.gmail.com>
        <20210908172118.n2f4w7epm6hh62zf@ast-mbp.dhcp.thefacebook.com>
        <20210908105259.c47dcc4e4371ebb5e147ee6e@linux-foundation.org>
        <20210908180258.yjh62e5oouckar5b@ast-mbp.dhcp.thefacebook.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 8 Sep 2021 11:02:58 -0700 Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> > Please describe the expected userspace-visible change from Peter's
> > patch in full detail?
> 
> User space expects build_id to be available. Peter patch simply removes
> that feature.

Are you sure?  He ends up with

static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
					  u64 *ips, u32 trace_nr, bool user)
{
	int i;

	/* cannot access current->mm, fall back to ips */
	for (i = 0; i < trace_nr; i++) {
		id_offs[i].status = BPF_STACK_BUILD_ID_IP;
		id_offs[i].ip = ips[i];
		memset(id_offs[i].build_id, 0, BUILD_ID_SIZE_MAX);
	}
	return;
}

and you're saying that userspace won't like this because we didn't set
BPF_STACK_BUILD_ID_VALID?
