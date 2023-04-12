Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A704D6DFB61
	for <lists+bpf@lfdr.de>; Wed, 12 Apr 2023 18:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjDLQaV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Apr 2023 12:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjDLQaV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Apr 2023 12:30:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5278D4228;
        Wed, 12 Apr 2023 09:30:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC1B762D59;
        Wed, 12 Apr 2023 16:30:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3871C433EF;
        Wed, 12 Apr 2023 16:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681317019;
        bh=xr8xMxEDBkUnuwk9S5+wT+dGX4efZJI50h6/870XpHI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hRbRHWLluhYDIaIvsIQXLloQQ/siu96TaNjy0ww5ksO0UlO9ktx1aSBDZFPu6iYtN
         dTvn5JH7nOVAYdF1HM+xlDaAigE69U8FxWtateOyDJWDAM8uMFqoTmRGQL8oYHBequ
         t2/UzX001+VmzJcVg8enNLaEFrhPmQn2fZNFCmcPSp1AS0IWAdu6LgqX1Yt8mG7hBt
         kM5Q+JvrI6HfpWan8u33h/DhGBPAjf+4xPzD+OdO5K71FW0lCN0Jdz5GF4pbJmMyWu
         xZB+QXmFOioMeDdg3Gq0o5uYHXvBa/wUdXC2yVdUK6muNx/YjZBBgGQu+lDePTOZ6J
         AODuyRJAYJAYw==
Date:   Wed, 12 Apr 2023 09:30:16 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Tianyi Liu <i.pear@outlook.com>
Cc:     acme@kernel.org, alan.maguire@oracle.com, alexandref75@gmail.com,
        bpf@vger.kernel.org, dxu@dxuuu.xyz, jforbes@redhat.com,
        linux-kernel@vger.kernel.org, olsajiri@gmail.com,
        peterz@infradead.org, ptalbert@redhat.com, yhs@fb.com
Subject: Re: [PATCH] vmlinux.lds.h: Force-align ELF notes section to four
 bytes
Message-ID: <20230412163016.5p7wve3meeahdecp@treble>
References: <20230411170058.7677oximl7oq4hkv@treble>
 <SY4P282MB10847ED9277ECA2E7B8A52779D9B9@SY4P282MB1084.AUSP282.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SY4P282MB10847ED9277ECA2E7B8A52779D9B9@SY4P282MB1084.AUSP282.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 12, 2023 at 03:10:14PM +0800, Tianyi Liu wrote:
> On Tue, Apr 11, 2023 at 17:00 , Josh Poimboeuf wrote:
> > On Tue, Feb 14, 2023 at 02:33:02PM +0800, Tianyi Liu wrote:
> > > > LLVM_OBJCOPY=objcopy pahole -J --btf_gen_floats -j
> > > > --skip_encoding_btf_inconsistent_proto --btf_gen_optimized
> > > > .tmp_vmlinux.btf
> > > > btf_encoder__encode: btf__dedup failed!
> > > > Failed to encode BTF
> > > >
> > > > Thanks,
> > > >
> > >
> > > I encountered the same problem when building a new kernel and I found some
> > > reasons for the error.
> > >
> > > In short, enabling CONFIG_X86_KERNEL_IBT will change the order of records in
> > > .notes section. In addition, due to historical problems, the alignment of
> > > records in the .notes section is not unified, which leads to the inability of
> > > gelf_getnote() to read the records after the wrong one.
> > 
> > Alexandre, Tianyi, are you still seeing this issue with the latest
> > dwarves?  If so can you confirm the below patch fixes it?
> > 
> 
> Josh, first of all, thank you very much for your help. However, this patch
> doesn't work in my environment. I am using gcc 12.2.1 20230201.
> After compiling, when I use readelf -S to view ELF sections,
> the align of .notes section is still 8:
> 
> $ readelf -S .tmp_vmlinux.btf
> [20] .notes            NOTE             ffffffff8250b570  0170b570
>      0000000000000084  0000000000000000   A       0     0     8

Hm, weird.

> > Apparently the latest dwarves release fixes it on Fedora Rawhide [1],
> > does anybody know if there a specific dwarves and/or libbpf change for
> > this?
> > 
> 
> It has been fixed in dwarves[1], but it may just be a coincidence.

So just to confirm, the btf__dedup error is gone for you with the latest
dwarves?

-- 
Josh
