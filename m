Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97630627920
	for <lists+bpf@lfdr.de>; Mon, 14 Nov 2022 10:38:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236794AbiKNJio (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Nov 2022 04:38:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236478AbiKNJin (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Nov 2022 04:38:43 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C719F1A3B3
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 01:38:41 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id l14so17048893wrw.2
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 01:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gk0wDqaeIteIPWX+fh6LCTRY6H/7I09heKmSat8+Xq8=;
        b=cNaqT+CUMFTflrtybExMiz+whdcEAWbdB6ssZ+C25wVKwDBXRYqa8VSXGeUFsbo2h3
         zwIl1zdzBkiTAChuOdZ2E8gIsqMyL8Bylyv4+KSDueH9dsli8ZJfBSiI3J9/bH/7WNpB
         YNjdi+HdsbWPlwEhwSxYAJDg04Y7xbxB+29KPBOlsyE5T8Blid6zq7mi2nMTCCmc7HEy
         wIXWq3pVWBifdgIFkQxEUA0ghZ48lz01TiAWGiNIMAdONOD+jl4pRn5SgqY/qbarRqNR
         1txniIycywDUds68yL2ARIidNFRtfPFARcl4WirDuoiKggWa1DpYyr1vWiFnlwHknR5B
         9spA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gk0wDqaeIteIPWX+fh6LCTRY6H/7I09heKmSat8+Xq8=;
        b=2uW8sPNjJfqQkVj4CGNR4fB/uApKfw2npQj1P1SZ8+2DOLVEs3UdllmG1L90MhFb8L
         rQGw37Yp3Trj3Kyf0NXP7QkZsppy1rJpyk9u7bqr0CRxm6/2KWrUSXXhpQTcN5jqsddO
         BFzm3pQ97akvu9dmSJBqEol5JBBppGhbmkRlM9hBoiVTEpaDUA37xMCZcRJN9yUyW9CC
         k5vzkDwRjCg6DXAw/KP4o3LaL9sjTlQnv9H8j3+Q4xxsDMbrODpsxmYBTPinbY6as4yY
         pb5NsDNB8m53M+gYINyHYYglPnfPO5T14+NG8NXvpV5Fg/OZIaKoRXM4FyoRzDBOQxsI
         Egmg==
X-Gm-Message-State: ANoB5plb3m4Kk0NeUEHOgdbezFc21BYiLkDWqFx0Vuo3KS15RpDfnzX4
        kVOk6BkTNnQsF1pCG+YV3Xs=
X-Google-Smtp-Source: AA0mqf7Sf0pcsYD1g4YeP9hI5wzejL0opgcwP2g/YxYjAodcFOefLLs66sxhmIaUPfdo3y8JtUBTVg==
X-Received: by 2002:a5d:528c:0:b0:22f:da60:345 with SMTP id c12-20020a5d528c000000b0022fda600345mr6838499wrv.218.1668418720173;
        Mon, 14 Nov 2022 01:38:40 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id v10-20020adf8b4a000000b00235da296623sm9105788wra.31.2022.11.14.01.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 01:38:39 -0800 (PST)
Date:   Mon, 14 Nov 2022 12:38:36 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     oe-kbuild@lists.linux.dev, bpf@vger.kernel.org, lkp@intel.com,
        oe-kbuild-all@lists.linux.dev, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: Re: [PATCH bpf-next v6 11/26] bpf: Allow locking bpf_spin_lock in
 allocated objects
Message-ID: <Y3IMnCft+np21Z7f@kadam>
References: <20221111193224.876706-12-memxor@gmail.com>
 <202211140520.Q5kvXPSL-lkp@intel.com>
 <20221114091100.xc6manlxdjad2t24@apollo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221114091100.xc6manlxdjad2t24@apollo>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 14, 2022 at 02:41:00PM +0530, Kumar Kartikeya Dwivedi wrote:
> On Mon, Nov 14, 2022 at 01:55:01PM IST, Dan Carpenter wrote:
> > Hi Kumar,
> >
> > url:    https://github.com/intel-lab-lkp/linux/commits/Kumar-Kartikeya-Dwivedi/Allocated-objects-BPF-linked-lists/20221112-033643
> > base:   e5659e4e19e49f1eac58bb07ce8bc2d78a89fe65
> > patch link:    https://lore.kernel.org/r/20221111193224.876706-12-memxor%40gmail.com
> > patch subject: [PATCH bpf-next v6 11/26] bpf: Allow locking bpf_spin_lock in allocated objects
> > config: x86_64-randconfig-m001
> > compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
> >
> > If you fix the issue, kindly add following tag where applicable
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Reported-by: Dan Carpenter <error27@gmail.com>
> >
> > smatch warnings:
> > kernel/bpf/verifier.c:5623 process_spin_lock() error: uninitialized symbol 'rec'.
> >
> > vim +/rec +5623 kernel/bpf/verifier.c
> 
> Hi Dan,
> 
> Thanks for the report! I noticed it yesterday night.
> 
> How should I be crediting you in the respin? Not sure Reported-by: is ok if I
> incorporate the fix into the patch and resend it. Would Fixed-by: be better?
> 

I've always said there should be a Fixes-from: tag but it doesn't exist.

Just leave it off.  These emails are auto-generated by the kbuild-bot
because credit helps fund their work.  I just look the bug reports and
forward the reports.

regards,
dan carpenter

