Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 748DE51301D
	for <lists+bpf@lfdr.de>; Thu, 28 Apr 2022 11:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbiD1Jtj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Apr 2022 05:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345429AbiD1JPU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Apr 2022 05:15:20 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637315E155;
        Thu, 28 Apr 2022 02:12:05 -0700 (PDT)
Received: from zn.tnic (p5de8eeb4.dip0.t-ipconnect.de [93.232.238.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B1B201EC04A9;
        Thu, 28 Apr 2022 11:11:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1651137119;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=4EsXYi2iN9MjtiJwAFERWO0RBwBmrl7v2x3DoW2MF7M=;
        b=Xq5QXk/4l3oFGRD8SiZTM4A+65pi7YB/k41RuzVST5sDnelaDl1N88dEu6MEiaD29t0BN1
        hwrSbhdX2zZjkg1VwAGWxAj9dchhkvT3ezxCDcD+gegx8hXVbmDYy90bR6x/MpqUhQ+D4T
        qmhRdfw4sHo2flmvgT9fmGGPeq9tGI4=
Date:   Thu, 28 Apr 2022 11:12:00 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        bpf <bpf@vger.kernel.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] x86/speculation: Add missing prototype for
 unpriv_ebpf_notify()
Message-ID: <YmpaYJP0xE7lc774@zn.tnic>
References: <5689d065f739602ececaee1e05e68b8644009608.1650930000.git.jpoimboe@redhat.com>
 <YmexSIL5pqNK63iH@zn.tnic>
 <CAADnVQKjfQMG_zFf9F9P7m0UzqESs7XoRy=udqrDSodxa8yBpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAADnVQKjfQMG_zFf9F9P7m0UzqESs7XoRy=udqrDSodxa8yBpg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 26, 2022 at 04:36:08PM -0700, Alexei Starovoitov wrote:
> I don't remember seeing the original patch on the bpf list.
> I'm guessing it was done in private as part of bhb series?

Yap.

> Feel free to land it via tip.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
