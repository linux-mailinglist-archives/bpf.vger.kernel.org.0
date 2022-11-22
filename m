Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC66633396
	for <lists+bpf@lfdr.de>; Tue, 22 Nov 2022 03:55:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbiKVCzU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Nov 2022 21:55:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiKVCzT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Nov 2022 21:55:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B78178B2
        for <bpf@vger.kernel.org>; Mon, 21 Nov 2022 18:55:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CEACEB81603
        for <bpf@vger.kernel.org>; Tue, 22 Nov 2022 02:55:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59BAFC433D6
        for <bpf@vger.kernel.org>; Tue, 22 Nov 2022 02:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669085715;
        bh=y87F50pgoXn/vExBQVCL5ei/ZfSRdM8VAn2jZcONyS0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UCwlBnf5hBHM8hAHvs/UUi8opNokYQFnS/O0IqClDXowoH8br6cGEbz7Ikt+qqdF0
         D+Q4pWK+28b0RFE2HJpUB2pPeTdsYAY+HabC95bdKvlWOHSlfVLzjpv53iyrtO45p/
         PJ/uEhtm/qxsPPFnpFO5Fo8FwiIyoQc00soN+MFgchwjgDudsIxT3+lK+FjyQ+jMsr
         CseK9NbogsyGn04zJtqa3HsqAgTfpsh02dZiGMV6WiDyUc/9tVf5R3cMB197oMDu/f
         g8YnuDAKCvV0EuYvmmNNIcX19LMmWXaDAi1taio3Gs6X51rs4fzEuIcC9ASJ7WTEi5
         eSLcZjwSlIu9w==
Received: by mail-ej1-f48.google.com with SMTP id me22so16179923ejb.8
        for <bpf@vger.kernel.org>; Mon, 21 Nov 2022 18:55:15 -0800 (PST)
X-Gm-Message-State: ANoB5pkb5hxLVrypYonJvQYo7OzDCG6/d46ItLto4cMDmbbNueiMzw/p
        jScQDFpIMtasIwPRmY7iC2JBoO7CqPOtDMwbNkI=
X-Google-Smtp-Source: AA0mqf4Fr50DSq7OxTYj2C5VwJm+YBbb7DwZ5Pnkup+zdJ0j80WfsM5Be0e3eIx8FA5Ex/xjC0le/sy/ZMo2nc4tEIE=
X-Received: by 2002:a17:906:c34f:b0:78e:17ad:ba62 with SMTP id
 ci15-20020a170906c34f00b0078e17adba62mr17968858ejb.719.1669085713590; Mon, 21
 Nov 2022 18:55:13 -0800 (PST)
MIME-Version: 1.0
References: <20221117202322.944661-1-song@kernel.org> <Y3vbwMptiNP6aJDh@bombadil.infradead.org>
In-Reply-To: <Y3vbwMptiNP6aJDh@bombadil.infradead.org>
From:   Song Liu <song@kernel.org>
Date:   Mon, 21 Nov 2022 19:55:01 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4353BfXu05npveQg9MiKRTHFNrL_owFZ19EbAx1Rigbw@mail.gmail.com>
Message-ID: <CAPhsuW4353BfXu05npveQg9MiKRTHFNrL_owFZ19EbAx1Rigbw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 0/6] execmem_alloc for BPF programs
To:     Luis Chamberlain <mcgrof@kernel.org>, akpm@linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     bpf@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        peterz@infradead.org, hch@lst.de, rick.p.edgecombe@intel.com,
        rppt@kernel.org, willy@infradead.org, dave@stgolabs.net,
        a.manzanares@samsung.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 21, 2022 at 1:12 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Thu, Nov 17, 2022 at 12:23:16PM -0800, Song Liu wrote:

[...]

> > 5. Introduce a unified API to allocate memory with special permissions.
> >
> > This will help get rid of set_vm_flush_reset_perms calls from users of
> > vmalloc, module_alloc, etc.
>
> And *this* is one of the reasons I'm so eager to see a proper solution
> drawn up. This would be a huge win for modules, however since some of
> the complexities in special permissions with modules lies in all the
> cross architecture hanky panky, I'd prefer to see this through merged
> *iff* we have modules converted as well as it would give us a clearer
> picture if the solution covers the bases. And we'd get proper testing
> on this. Rather than it being a special thing for BPF.

Module code is clearly the most difficult to migrate. (It has to work on
almost all archs, and it contains 3 allocations: core, data, init.) If we
want actionable path towards fixing all these, I don't think we should
use module code as the bar for the very first set. (Of course, if
Andrew or Linus insists that way, I will rethink about this).

PS: I don't quite understand why there is a strong concern in adding
this to core mm API, especially that there is also an argument that
this is only for BPF.

IIUC, the real concern comes for a core API that is
   1. easy to use, and have many users;
   2. has a horrible internal implementation (maybe bpf_prog_pack
      falls in here, but it is not easy to use).

Such API will cause a lot of problems, and it is also so hard to
remove. execmem_* APIs are quite the opposite. It is hard to use,
and it has a decent internal implementation (at least better than
bpf_prog_pack).

In 4/5 of the set, we easily reverted all the code bpf_prog_pack
and used execmem_* instead. If execmem_* turn out to be
horrible, and only useful for BPF, we can easily migrate it to the
next good API, right?

Thanks,
Song
