Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85DB2523A8E
	for <lists+bpf@lfdr.de>; Wed, 11 May 2022 18:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242503AbiEKQqF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 May 2022 12:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbiEKQqE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 May 2022 12:46:04 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA5321E37;
        Wed, 11 May 2022 09:46:01 -0700 (PDT)
Received: from zn.tnic (p5de8eeb4.dip0.t-ipconnect.de [93.232.238.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1D6611EC0535;
        Wed, 11 May 2022 18:45:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1652287556;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=FGkN+pgwoH3lcFfR2LvkS/139fj7xrKIIH7QmQPBYXk=;
        b=XRNkHo7jdhufEhi/XWBzJPKQ24r1ZITjET8quNbVN39633Vpe/H6zD0LU8lVZEVb9uNr/t
        8jwnGC+D6lxPjCxmq+0aLD5aCE+O3DISg5vD0MuvpugoiKqy63WkmJDz4DU1etNV3q9ea8
        Of1qmwYLSSGlJ4uvl7GWdS5rL5fEsu4=
Date:   Wed, 11 May 2022 18:45:58 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Song Liu <songliubraving@fb.com>, bpf <bpf@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev
Subject: Re: [PATCH] bpf.h: fix clang compiler warning with
 unpriv_ebpf_notify()
Message-ID: <YnvoRsxEc+FsLcAj@zn.tnic>
References: <20220509203623.3856965-1-mcgrof@kernel.org>
 <YnvdOAaYmhNiA5WN@bombadil.infradead.org>
 <CAADnVQLCvjqphpJDkz-5bpJLs3k_PRH1JcwehCRLrWYvsA9ENw@mail.gmail.com>
 <YnvflsM1t5vL/ViP@bombadil.infradead.org>
 <3e3ed3d1-937b-a715-376d-43a8b7485f68@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3e3ed3d1-937b-a715-376d-43a8b7485f68@iogearbox.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, May 11, 2022 at 06:17:26PM +0200, Daniel Borkmann wrote:
> Borislav was planning to route it via tip tree, maybe confusion was that the
> fix in the link below is from Josh:
> 
> https://lore.kernel.org/bpf/CAADnVQKjfQMG_zFf9F9P7m0UzqESs7XoRy=udqrDSodxa8yBpg@mail.gmail.com/
> 
> But I presume this is routed as fix to Linus,

Yap: https://git.kernel.org/tip/2147c438fde135d6c145a96e373d9348e7076f7f

Will go to Linus in the next merge window.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
