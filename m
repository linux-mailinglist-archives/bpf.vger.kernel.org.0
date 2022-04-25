Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD8C550D9E5
	for <lists+bpf@lfdr.de>; Mon, 25 Apr 2022 09:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232432AbiDYHKq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Apr 2022 03:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240653AbiDYHKi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Apr 2022 03:10:38 -0400
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A464D13D1E;
        Mon, 25 Apr 2022 00:07:26 -0700 (PDT)
Received: by mail-qv1-f51.google.com with SMTP id kk26so3188514qvb.6;
        Mon, 25 Apr 2022 00:07:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i0fy0ju/RjV4t6J/6vekfJMKMcci/Xy9FO1WhPYjEWY=;
        b=DA6BMPi7Hq+DnQbnyeinKQe9ta7PvzFmtWmkvAtgkl9xJkY89J47qbMV+0CRIBJ4uY
         nD86dGyith2PQSGtDsV5EOnTE/BuCQNAUz4e1y8aqtUzq/C4o8ejrm4b/KjKwrWzcx1A
         5cn0XOTjH81KYOcmIkm4e0h3RlUxMzx5acs9lnQt4x+KQvAXYpO5bok9D2UaCF7wIl/k
         L98ZjgnhK9EC0ao0iHWv5Gngnju5fGdzyVVMdCUU5JTJmBXxTbpj0cKL/5Tgwuuhq9VM
         HxNykWxAyWa7d/hjnD9mnaXNhGCbkxqqmTSsQrB2dDz7KhgQUqeUMIW8kXcBOSIjBXWZ
         KmHQ==
X-Gm-Message-State: AOAM532x/nIp6FHYwgVH742xxoxhwYt1aGjJQSqZTtGzlY9N86WJt11B
        vZ6rBXhv1+bxNp1NJncL8/8ZoGi3B+CzQg==
X-Google-Smtp-Source: ABdhPJwxFCI5s1Q5M44JkUkqTIzYTNsUZbzfwqsmX0j31BEplLJg2+KB/3DkznDcZ8tyf4V3zFX8hA==
X-Received: by 2002:a0c:d80e:0:b0:456:31a1:fa52 with SMTP id h14-20020a0cd80e000000b0045631a1fa52mr4816712qvj.109.1650870445711;
        Mon, 25 Apr 2022 00:07:25 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id 2-20020ac85702000000b002f367910ab0sm1792026qtw.94.2022.04.25.00.07.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 00:07:25 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id j2so25444033ybu.0;
        Mon, 25 Apr 2022 00:07:24 -0700 (PDT)
X-Received: by 2002:a25:d393:0:b0:648:4871:3b91 with SMTP id
 e141-20020a25d393000000b0064848713b91mr5823322ybf.506.1650870444696; Mon, 25
 Apr 2022 00:07:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220415164413.2727220-1-song@kernel.org> <20220415164413.2727220-3-song@kernel.org>
 <5e5e4759efef83250f9511d4ab0e1ba34f987ce5.camel@fb.com>
In-Reply-To: <5e5e4759efef83250f9511d4ab0e1ba34f987ce5.camel@fb.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 25 Apr 2022 09:07:12 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVdx2V1uhv_152Sw3_z2xE0spiaWp1d6Ko8-rYmAxUBAg@mail.gmail.com>
Message-ID: <CAMuHMdVdx2V1uhv_152Sw3_z2xE0spiaWp1d6Ko8-rYmAxUBAg@mail.gmail.com>
Subject: Re: [PATCH v4 bpf 2/4] page_alloc: use vmalloc_huge for large system hash
To:     "song@kernel.org" <song@kernel.org>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Rik van Riel <riel@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>,
        "hch@lst.de" <hch@lst.de>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "hch@infradead.org" <hch@infradead.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "imbrenda@linux.ibm.com" <imbrenda@linux.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Song,

On Fri, 2022-04-15 at 09:44 -0700, Song Liu wrote:
> > Use vmalloc_huge() in alloc_large_system_hash() so that large system
> > hash
> > (>= PMD_SIZE) could benefit from huge pages. Note that vmalloc_huge
> > only
> > allocates huge pages for systems with HAVE_ARCH_HUGE_VMALLOC.
> >
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > Signed-off-by: Song Liu <song@kernel.org>
>
> Reviewed-by: Rik van Riel <riel@surriel.com>

Thanks for your patch, which is now commit f2edd118d02dd114
("page_alloc: use vmalloc_huge for large system hash") upstream
(and which hasn't been in linux-next before).

As reported by noreply@ellerman.id.au, this is breaking e.g.
m68k/m5272c3_defconfig with:

page_alloc.c:(.init.text+0x13de): undefined reference to `vmalloc_huge'

vmalloc_huge() is provided by mm/vmalloc.c, which is not
compiled if CONFIG_MMU=n.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
