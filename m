Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BAE658F2A6
	for <lists+bpf@lfdr.de>; Wed, 10 Aug 2022 21:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbiHJTAG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Aug 2022 15:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiHJTAF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Aug 2022 15:00:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6598D3DC;
        Wed, 10 Aug 2022 12:00:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA8F961474;
        Wed, 10 Aug 2022 19:00:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7F39C433D6;
        Wed, 10 Aug 2022 19:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660158004;
        bh=kpkug43r/mu6B8UwPvE9lX1MDYhE5WZMwEJOzV0s2nk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gfIKauT77/6xqs2jULvclokXA9kxZ04Ke6/lkqGqehimp1QROt55oHqnetfyQiC/H
         DOSlMcBNCkOUcU3Cqq+x0NTmUS0SpLo7rI4FbLRzp4AyNATjd+N2SnZklxMi0dzIiu
         iWSI4htilaUYj0RZRR8ZzXGm0KAvRPRMXPeFzVRv7ZLi4toE2CMi76s/EKHayWjP3I
         HuMdadm/ZqIf5vVkAIJGDVTo/X5/1/QzjUolT+/cRhbq3stt+Xg2i8FxbZ0a4TeYJf
         0tAEWNiSgogaxXFkvASBuem87CjniKgk2Y97aTJOAKJA3k1yj61ixj2Tow7TPpgtec
         oRjOx0YAovElQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0C0D84035A; Wed, 10 Aug 2022 16:00:00 -0300 (-03)
Date:   Wed, 10 Aug 2022 15:59:59 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Yonghong Song <yhs@fb.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
Subject: Re: [PATCH dwarves] dwarf_loader: encode char type as signed
Message-ID: <YvQAL+8Ah5J0hWAg@kernel.org>
References: <20220807175309.4186342-1-yhs@fb.com>
 <CAEf4BzZJdqxOS_8VLX73z94GCUBVW4k6hKo3WGHyv4n-jQ-niQ@mail.gmail.com>
 <CAEf4BzYaWboRjHqewen71QZhvQyvtkeE5N43y=NvE+igw4RXYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzYaWboRjHqewen71QZhvQyvtkeE5N43y=NvE+igw4RXYw@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Mon, Aug 08, 2022 at 03:52:38PM -0700, Andrii Nakryiko escreveu:
> On Mon, Aug 8, 2022 at 3:52 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Sun, Aug 7, 2022 at 10:53 AM Yonghong Song <yhs@fb.com> wrote:
> > >
> > > Currently, the pahole treats 'char' or 'signed char' type
> > > as unsigned in BTF generation. The following is an example,
> > >   $ cat t.c
> > >   signed char a;
> > >   char b;
> > >   $ clang -O2 -g -c t.c
> > >   $ pahole -JV t.o
> > >   ...
> > >   [1] INT signed char size=1 nr_bits=8 encoding=(none)
> > >   [2] INT char size=1 nr_bits=8 encoding=(none)
> > > In the above encoding '(none)' implies unsigned type.
> > >
> > > But if the same program is compiled with bpf target,
> > >   $ clang -target bpf -O2 -g -c t.c
> > >   $ bpftool btf dump file t.o
> > >   [1] INT 'signed char' size=1 bits_offset=0 nr_bits=8 encoding=SIGNED
> > >   [2] VAR 'a' type_id=1, linkage=global
> > >   [3] INT 'char' size=1 bits_offset=0 nr_bits=8 encoding=SIGNED
> > >   [4] VAR 'b' type_id=3, linkage=global
> > >   [5] DATASEC '.bss' size=0 vlen=2
> > >           type_id=2 offset=0 size=1 (VAR 'a')
> > >           type_id=4 offset=0 size=1 (VAR 'b')
> > > the 'char' and 'signed char' are encoded as SIGNED integers.
> > >
> > > Encode 'char' and 'signed char' as SIGNED should be a right to
> > > do and it will be consistent with bpf implementation.
> > >
> > > With this patch,
> > >   $ pahole -JV t.o
> > >   ...
> > >   [1] INT signed char size=1 nr_bits=8 encoding=SIGNED
> > >   [2] INT char size=1 nr_bits=8 encoding=SIGNED
> > >
> > > Signed-off-by: Yonghong Song <yhs@fb.com>
> > > ---
> >
> > LGTM.
> 
> Acked-by: Andrii Nakryiko <andrii@kernel.org>

Thanks, tested before/after, applied.

Pushing out next for CI testing.

- Arnaldo
