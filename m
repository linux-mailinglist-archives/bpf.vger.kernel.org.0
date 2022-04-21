Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE442509505
	for <lists+bpf@lfdr.de>; Thu, 21 Apr 2022 04:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiDUC1R (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Apr 2022 22:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiDUC1R (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Apr 2022 22:27:17 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA36614E;
        Wed, 20 Apr 2022 19:24:29 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id q19so3428196pgm.6;
        Wed, 20 Apr 2022 19:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=/wI3QVM59jnzfvExzc3w5EEsA2aIl90/0QKeHl4f9CM=;
        b=W3vGZl7r3ZjtXymMnPLZs5bQLNRgN/w94RrpyGN0BiGqZ5/HMtlyoXuKEe2veSgDbc
         7jvuwhGTRhJAjkDdxdRKtskBgJ+8zMjavyTI8JPcGzkzSWiYFjGDbTYwVIGAWZUQpLtr
         U+a/66SpkNFIqkr7wuFYVq0v3r/az7rzZYmsXoZ/O3Dnil67+CrNGO4GCnRxfkfthtnc
         9dGxPyx08v3A1sSHgBbT4JKqn5Dtvpue+VOmaw7kq+hmkR7oiYeF4CLgv7ZI9JUTVhMZ
         qoAswAephXy9v6+53kncpD2JN+nhMom9NPD5QtdHGYtxydXUmbBYvhmNgAeIMur8SHVp
         /eow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=/wI3QVM59jnzfvExzc3w5EEsA2aIl90/0QKeHl4f9CM=;
        b=kjswNyDW99D2jk2puuXcQqK/ybs3LygOABefm63sLWO2d1+Fh4/Azf0BN+USG9FAvc
         7A8O9JZz2JPMDRH4GUqmIatc8XmXINJUd+1uqHP8VIEP0CsdaI9Ey7rrJZPbbrK89LuM
         Lewkinin83gCJbKDHyAamkTRQu0rJXiB+JCdKxyYutm75ePgQx2e4dnopUQhXSgk6guj
         ZrvingiiCxT7b09dGGx1yXpd2fGNOhK7KjaE3/PW9o5TYiXP20Y82LqZkiysTwxCZUnO
         AOEaxiBu+DpWpuvBGqvcaJhofmdwZiE/Qqt1LsHRImYklDRk96bnp2TZPqrEdX7T5C88
         pQaA==
X-Gm-Message-State: AOAM531rqmBpCLqL9k2016fNeM9FPG6qJNu2eYgD28/O1tIvG72c50YQ
        hDhHLSTcGYEiIY28OtZr3JI=
X-Google-Smtp-Source: ABdhPJwDreTNr9TQGQiEgLFd2JcwXp5IZ6wi0i625PLqgWPFG0mu3wBzk9UyJ4/IDgqaPL3UnCgyyw==
X-Received: by 2002:aa7:88cd:0:b0:50a:9579:a1b with SMTP id k13-20020aa788cd000000b0050a95790a1bmr11381732pff.25.1650507868641;
        Wed, 20 Apr 2022 19:24:28 -0700 (PDT)
Received: from localhost ([203.221.203.144])
        by smtp.gmail.com with ESMTPSA id hi21-20020a17090b30d500b001cd4989ff4csm532182pjb.19.2022.04.20.19.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 19:24:28 -0700 (PDT)
Date:   Thu, 21 Apr 2022 12:24:22 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 bpf 1/3] vmalloc: replace VM_NO_HUGE_VMAP with
 VM_ALLOW_HUGE_VMAP
To:     Christoph Hellwig <hch@infradead.org>, Song Liu <song@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, imbrenda@linux.ibm.com,
        open list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        rick.p.edgecombe@intel.com
References: <20220411233549.740157-1-song@kernel.org>
        <20220411233549.740157-2-song@kernel.org> <YlT9i9DFvwDx9+AD@infradead.org>
        <CAPhsuW7XJHa3OaTT-4=33c70gUjCaWFrVe8h8J-hZetjxXeeog@mail.gmail.com>
In-Reply-To: <CAPhsuW7XJHa3OaTT-4=33c70gUjCaWFrVe8h8J-hZetjxXeeog@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <1650507506.z839xl6pvt.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Excerpts from Song Liu's message of April 12, 2022 4:00 pm:
> On Mon, Apr 11, 2022 at 9:18 PM Christoph Hellwig <hch@infradead.org> wro=
te:
>>
>> On Mon, Apr 11, 2022 at 04:35:46PM -0700, Song Liu wrote:
>> > Huge page backed vmalloc memory could benefit performance in many case=
s.
>> > Since some users of vmalloc may not be ready to handle huge pages,
>> > VM_NO_HUGE_VMAP was introduced to allow vmalloc users to opt-out huge
>> > pages. However, it is not easy to add VM_NO_HUGE_VMAP to all the users
>> > that may try to allocate >=3D PMD_SIZE pages, but are not ready to han=
dle
>> > huge pages properly.
>>
>> This is a good place to document what the problems are, and how they are
>> hard to track down (e.g. because the allocations are passed down I/O
>> stacks)
>=20
> Will add it in v3.
>=20
>>
>> >
>> > Replace VM_NO_HUGE_VMAP with an opt-in flag, VM_ALLOW_HUGE_VMAP, so th=
at
>> > users that benefit from huge pages could ask specificially.
>> >
>> > Also, replace vmalloc_no_huge() with opt-in helper vmalloc_huge().
>>
>> We still need to find out what the primary users of the large vmalloc
>> hashes was and convert them.
>=20
> @ Claudio and Nicholas,
>=20
> Could you please help identify users of large vmalloc? So far, I found
> alloc_large_system_hash(), and something like the following seems to
> work:

The large system hashes were the main ones I was interested in. IIRC=20
there was a few more in some drivers or tracing things depending on
config but those are less important (to me at least).

Curious what the problem is though. powerpc so far has not required
any special case outside arch/powerpc/ for this so I would much
prefer x86 to fix itself rather than add APIs which non-arch code
really shouldn't need to know about.

Thanks,
Nick
