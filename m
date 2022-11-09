Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BEC76231EE
	for <lists+bpf@lfdr.de>; Wed,  9 Nov 2022 18:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiKIRxk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Nov 2022 12:53:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbiKIRxk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Nov 2022 12:53:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E516E12622
        for <bpf@vger.kernel.org>; Wed,  9 Nov 2022 09:53:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 95B28B81F5E
        for <bpf@vger.kernel.org>; Wed,  9 Nov 2022 17:53:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 488F3C43142
        for <bpf@vger.kernel.org>; Wed,  9 Nov 2022 17:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668016416;
        bh=Cfrx6SNIS1GrC9wpADzVUni35TVkWLZWrBS8seRzIqg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fYKPHc6UBiX3qkIjlUKny/HYh3crymPUd+MblFksaBiIV+Xqem4fX0N9+i79aUd2Z
         hih9kisibocMwGOYzlO/8P+G4z57eKCVy9XQ+fZX3K/DYye3DeCsq/vj57yMzKxHln
         F53m6M3cu24Qaj5z45Xu/uQoiwVqhKc56BRJQWlaaMP4+hfS8AIqnU0Vo3/NxstbZq
         tnlqqsgQ/eKgJEr2Bj8uYhbuwwPKxkN2n4O/QtzP2IGR/9bZz4cMNuy02hikedsFAM
         nZBUyAbNF0vfhF8nlmrnPLa5CA3hnp8VOrOMpNH0Ksaq5My6hW9/AHg7a1wBDoXTbi
         XdBveS2c3lBBg==
Received: by mail-ej1-f49.google.com with SMTP id t25so48851618ejb.8
        for <bpf@vger.kernel.org>; Wed, 09 Nov 2022 09:53:36 -0800 (PST)
X-Gm-Message-State: ANoB5pmVc0p2OOAHpyykkF6rmABYpnuPONx0dqJfKJErc6Ix+36eaMwP
        12HmivKHOMXjbDv/YgVNIscaXPau35hes7HsUiQ=
X-Google-Smtp-Source: AA0mqf4QQjt0kKSyCr5k2IT/Ezjzn7T8jZYVXzl+jehe6aSglRllibKghzaWxJyhykogXsawPRURinneME1WsGumqUQ=
X-Received: by 2002:a17:906:eec1:b0:782:6384:76be with SMTP id
 wu1-20020a170906eec100b00782638476bemr7600535ejb.756.1668016414461; Wed, 09
 Nov 2022 09:53:34 -0800 (PST)
MIME-Version: 1.0
References: <20221107223921.3451913-1-song@kernel.org> <Y2o9Iz30A3Nruqs4@kernel.org>
 <9e59a4e8b6f071cf380b9843cdf1e9160f798255.camel@intel.com>
 <Y2uMWvmiPlaNXlZz@kernel.org> <bcdc5a31570f87267183496f06963ac58b41bfe1.camel@intel.com>
In-Reply-To: <bcdc5a31570f87267183496f06963ac58b41bfe1.camel@intel.com>
From:   Song Liu <song@kernel.org>
Date:   Wed, 9 Nov 2022 09:53:22 -0800
X-Gmail-Original-Message-ID: <CAPhsuW6pO3=RdYd1PdxDHXLU03Gr55PXHhq9PuN8uzteu0xoQQ@mail.gmail.com>
Message-ID: <CAPhsuW6pO3=RdYd1PdxDHXLU03Gr55PXHhq9PuN8uzteu0xoQQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/5] execmem_alloc for BPF programs
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "rppt@kernel.org" <rppt@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "hch@lst.de" <hch@lst.de>, "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "Lu, Aaron" <aaron.lu@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 9, 2022 at 9:04 AM Edgecombe, Rick P
<rick.p.edgecombe@intel.com> wrote:
>
[...]
>
> Similar to the perm_alloc() hacks?
>
> > with similar rodata_alloc() that uses yet another tree in vmalloc?
>
> It would have to group them together at least. Not sure if it needs a
> separate tree or not. I would think permission flags would be better
> than a new function for each memory type.
>
> > How the caching of large pages in vmalloc can be made useful for use
> > cases
> > like secretmem and PKS?
>
> This part is easy I think. If we had an unmapped page allocator it
> could just feed this. Do you have any idea when you might pick up that
> stuff again?
>
> To answer my own question, I think a good first step would be to make
> the interface also work for non-text_poke() so it could really be cross
> arch, then use it for everything except modules. The benefit to the
> other arch's at that point is centralized handling of loading text.

AFAICT, most major archs are introducing text_poke or similar support.
What would be a good non-text_poke major to look into?

Thanks,
Song
