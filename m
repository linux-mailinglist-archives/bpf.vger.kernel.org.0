Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43397509553
	for <lists+bpf@lfdr.de>; Thu, 21 Apr 2022 05:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377181AbiDUDWz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Apr 2022 23:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383945AbiDUDWm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Apr 2022 23:22:42 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED34DD7;
        Wed, 20 Apr 2022 20:19:51 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id r83so3540558pgr.2;
        Wed, 20 Apr 2022 20:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=O48qIPjrX8Xe0hflytk+FHKidZ/wdCazg6Nj2YRoxXo=;
        b=L3L+4mLfMDLwo5UlvqchVDDF4Qi7CtqsKTmdiaEZlGmsvIAZMw3p6AYJS7gAE8WrXg
         tKW3/VoOsgYHMtWFuL0zi++QHYRdzCY3Xc9w2TQ7opDKLR/1gCGnPNYfriESXqJZ/Si3
         7Pxh6eQBywlasNG6EJcCN8H/UJUZeA0x9RAnzOHBFKKBwhp/vcAKiHmAJkipM39YyWKB
         vGOIDEprXI/ZniWjbZPUS+zFekYTH27x1hO66lZ3vSnmtTNFWAXb4rUVZKDunAvl8+ld
         gDrVlJQg12r7jgsVi3apxbYICirn6ZQIUNVo18XvK7iLO82CoqRQi1hOLkgMtlQCF3/0
         t1pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=O48qIPjrX8Xe0hflytk+FHKidZ/wdCazg6Nj2YRoxXo=;
        b=Os8O9vAjjioby5yqq17oPtDUgxmdhZVwq3icNEEaAeSbMPqyTbDxuK5liZ979Ntzt/
         PPujxMWMGxN9HltoYPBTJtg6s1Wq5bj3D1B6uPioEalbRHjh3f25qmf22dX6BQHyRhEv
         INuKnth2CdHhNO99D1iOPEMdJheYG0XB3FWc/aIrbc7SQ+ZsnPw+ZJHik1qhbiQYxSi6
         TDWLqr0Owo0ND5lwS8x4EIv/MBcs4Tml56LrEUV4r5gCt1/1nwFNFFRxfwRj8bxf/89S
         vEKmQqQrDS2trxfRXwGwwSwOKHVKtohqPgIpQ2QjGrWAdINJ/H2mcHOacMXOlmHQGEwF
         p/nA==
X-Gm-Message-State: AOAM532b25bX9aS8My1zci5pD7TtTGWMNu3zOW5AFBgJJ9hNSHvo33Of
        0kBChfkes72blyeIU9Ckzak=
X-Google-Smtp-Source: ABdhPJxlj/Cv9i7bzjODu0drT5IErA6bWCTVIXD+VB8HfowEPzEjnAef10H1ZhO8T9QsXuZraBnlBA==
X-Received: by 2002:a63:484f:0:b0:3aa:3f25:25a0 with SMTP id x15-20020a63484f000000b003aa3f2525a0mr9716006pgk.559.1650511190816;
        Wed, 20 Apr 2022 20:19:50 -0700 (PDT)
Received: from localhost ([203.221.203.144])
        by smtp.gmail.com with ESMTPSA id x184-20020a6286c1000000b0050ad3051f53sm1272382pfd.147.2022.04.20.20.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 20:19:50 -0700 (PDT)
Date:   Thu, 21 Apr 2022 13:19:43 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v4 bpf 0/4] vmalloc: bpf: introduce VM_ALLOW_HUGE_VMAP
To:     Christoph Hellwig <hch@infradead.org>,
        Luis Chamberlain <mcgrof@kernel.org>
Cc:     akpm@linux-foundation.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, imbrenda@linux.ibm.com, kernel-team@fb.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        rick.p.edgecombe@intel.com, Song Liu <song@kernel.org>
References: <20220415164413.2727220-1-song@kernel.org>
        <YlnCBqNWxSm3M3xB@bombadil.infradead.org> <YlpPW9SdCbZnLVog@infradead.org>
In-Reply-To: <YlpPW9SdCbZnLVog@infradead.org>
MIME-Version: 1.0
Message-Id: <1650511051.ez3mdems3d.astroid@bobo.none>
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

Excerpts from Christoph Hellwig's message of April 16, 2022 3:08 pm:
> On Fri, Apr 15, 2022 at 12:05:42PM -0700, Luis Chamberlain wrote:
>> Looks good except for that I think this should just wait for v5.19. The
>> fixes are so large I can't see why this needs to be rushed in other than
>> the first assumptions of the optimizations had some flaws addressed here=
.
>=20
> Patches 1 and 2 are bug fixes for regressions caused by using huge page
> backed vmalloc by default.  So I think we do need it for 5.18.

No, the huge vmap patch should just be reverted because that caused
the regression, rather than adding another hack on top of it. All the
breakage is in arch/x86/, it doesn't make sense to change this code
and APIs outside x86 to work around it.

And once they are fixed these shouldn't be needed.

Thanks,
Nick
