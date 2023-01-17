Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 763BD670BC0
	for <lists+bpf@lfdr.de>; Tue, 17 Jan 2023 23:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjAQWkK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Jan 2023 17:40:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjAQWjd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 Jan 2023 17:39:33 -0500
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3666F5AB6A
        for <bpf@vger.kernel.org>; Tue, 17 Jan 2023 14:22:08 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 9A7B3240435
        for <bpf@vger.kernel.org>; Tue, 17 Jan 2023 23:22:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1673994126; bh=NugUdNmAxkmrBjvc5pW6xtysgvVUKeiaDrAzvrQrsO8=;
        h=Date:From:To:Cc:Subject:From;
        b=FZQN9LMWGiP7bBQ+Be74ime4sIznbNQw3GmWuLL4dtZjJR04IhsAKBOCqbGk76Rvo
         DmWgo7+//zqQsQk0xgtAdGOFxzOxwbMVFeUpegargYIcUXpEaaMOCW7tprsAjpFjXh
         q8mXsmzZL724m+ZLRvHBjW04694VN8/DXRuKpQd8n4dPw3ZwKQklHm83fkDvi9sRIE
         MlqT73YTRkCczxa+1OU2Y6525ojqgJSgzEKuZkX127gxfopsazsWh2CDX6LCsxwncw
         b+zmZYmA5HGJ5p2FScrlHlINWdB0bySf9pKpXS5GBLjQ2IAtC7tz0WuIEQYSKXXgx6
         vWXXpyAC+UyEQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4NxNfd6dZkz6tmN;
        Tue, 17 Jan 2023 23:22:01 +0100 (CET)
Date:   Tue, 17 Jan 2023 22:21:58 +0000
From:   Daniel =?utf-8?Q?M=C3=BCller?= <deso@posteo.net>
To:     Hao Luo <haoluo@google.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>, kernel-team@meta.com
Subject: Re: CORE feature request: support checking field type directly
Message-ID: <20230117222158.uyezr5ab72ck5fhv@muellerd-fedora-PC2BDTX9>
References: <CA+khW7ju-gewZVNxopBi3Uvhiv8Wb=a-D4gaW3MD-NkUg0WSSg@mail.gmail.com>
 <20230117215658.xec7cirlfx2z7z2m@muellerd-fedora-PC2BDTX9>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230117215658.xec7cirlfx2z7z2m@muellerd-fedora-PC2BDTX9>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

I apologize for the response. Somehow Andrii's reply and the entire thread was
lost on me. Anyway, glad it's working for you.

Thanks,
Daniel

On Tue, Jan 17, 2023 at 09:56:58PM +0000, Daniel Müller wrote:
> Hi Hao,
> 
> On Thu, Jan 12, 2023 at 02:18:05PM -0800, Hao Luo wrote:
> > Feature request:
> > 
> > To support checking the type of a specific field directly.
> > 
> > Background:
> > 
> > Currently, As far as I know, CORE is able to check a field’s
> > existence, offset, size and signedness, but not the field’s type
> > directly.
> 
> Are you aware of the TYPE_MATCHES support [0] that was added a while back?
> Specifically, for types to "match" they have to be of the same "kind" (struct
> vs. struct, union vs. union, etc.). That check is done recursively for fields
> from what I recall (please see linked change description or source code for more
> details).
> 
> > There are changes that convert a field from a scalar type to a struct
> > type, without changing the field’s name, offset or size. In that case,
> > it is currently difficult to use CORE to check such changes. For a
> > concrete example,
> > 
> > Commit 94a9717b3c (“locking/rwsem: Make rwsem->owner an atomic_long_t”)
> > 
> > Changed the type of rw_semaphore::owner from tast_struct * to
> > atomic_long_t. In that change, the field name, offset and size remain
> > the same. But the BPF program code used to extract the value is
> > different. For the kernel where the field is a pointer, we can write:
> > 
> > sem->owner
> > 
> > While in the kernel where the field is an atomic, we need to write:
> > 
> > sem->owner.counter.
> > 
> > It would be great to be able to check a field’s type directly.
> > Probably something like:
> > 
> > #include “vmlinux.h”
> > 
> > struct rw_semaphore__old {
> >         struct task_struct *owner;
> > };
> > 
> > struct rw_semaphore__new {
> >         atomic_long_t owner;
> > };
> > 
> > u64 owner;
> > if (bpf_core_field_type_is(sem->owner, struct task_struct *)) {
> >         struct rw_semaphore__old *old = (struct rw_semaphore__old *)sem;
> >         owner = (u64)sem->owner;
> > } else if (bpf_core_field_type_is(sem->owner, atomic_long_t)) {
> >         struct rw_semaphore__new *new = (struct rw_semaphore__new *)sem;
> >         owner = new->owner.counter;
> > }
> 
> I haven't tried it out, but from the top of my head, TYPE_MATCHES should be able
> to help with this case. If not, it may be useful for us to understand why it is
> insufficient. Could you share feedback?
> 
> Thanks,
> Daniel
> 
> [0]: https://lore.kernel.org/bpf/20220620231713.2143355-5-deso@posteo.net/
