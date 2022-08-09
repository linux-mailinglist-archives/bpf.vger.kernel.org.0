Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C881458D8E3
	for <lists+bpf@lfdr.de>; Tue,  9 Aug 2022 14:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243109AbiHIMr3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Aug 2022 08:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238259AbiHIMr3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Aug 2022 08:47:29 -0400
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC95BE0C;
        Tue,  9 Aug 2022 05:47:28 -0700 (PDT)
Received: by mail-qt1-f171.google.com with SMTP id u12so8661539qtk.0;
        Tue, 09 Aug 2022 05:47:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=skGgXQvIc7cnUz2HlWUu8GijSgY3uLhsRNuHzFVWxBQ=;
        b=AxsMVTNUSxAj/6qnVSsmXS9ETrt3oXgyr//c+e4xYMgaiQRBoFfvnzAoT6RA+Ntnsn
         LBtsuzM28GI0+bL6Ho0P15bIJm0mQOlspQ7lMX9oZDEUgu2o9530BanQstfIqsaVYPMA
         U/D/z9d7z3oAVdyf3zgIZtSfTaZ5PC1uaactPhyp+tPH9UzkLj7D3n10/3TPVEAdbP5c
         Z1z9mzVly11vIwLkGN72YlW2kpWrqN0jrbkwqjmGFe+e/Ndi/BUw2puiO7KYzxpzB3Lo
         QNgvwaffwryVe3Qlyrdid9cQZspORVN/3bSf0qO5WRj34AfyncprRMnNB529HvEbNJnB
         D1sQ==
X-Gm-Message-State: ACgBeo2+LNTGyNPjwuMd26ekapcBXkhgmU0FebcE6HadkIi64b/+slRb
        bLivNfXWvpJ3X3fLcMtredQ=
X-Google-Smtp-Source: AA6agR4MS/Ygz4SSC60dOJMkIOXOssulJx/2usTjn6qa6vaG5OdU29OU5WlHvW3zYHmCrSeuzjBZAw==
X-Received: by 2002:a05:622a:447:b0:31e:ea5d:34c2 with SMTP id o7-20020a05622a044700b0031eea5d34c2mr19441652qtx.604.1660049247328;
        Tue, 09 Aug 2022 05:47:27 -0700 (PDT)
Received: from dev0025.ash9.facebook.com (fwdproxy-ash-006.fbsv.net. [2a03:2880:20ff:6::face:b00c])
        by smtp.gmail.com with ESMTPSA id s12-20020a05622a018c00b003431446588fsm973559qtw.5.2022.08.09.05.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 05:47:27 -0700 (PDT)
Date:   Tue, 9 Aug 2022 05:47:24 -0700
From:   David Vernet <void@manifault.com>
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, john.fastabend@gmail.com, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, tj@kernel.org,
        linux-kernel@vger.kernel.org, Kernel-team@fb.com
Subject: Re: [PATCH 1/5] bpf: Clear callee saved regs after updating REG0
Message-ID: <20220809124724.ps6fmzeazizzjoon@dev0025.ash9.facebook.com>
References: <20220808155341.2479054-1-void@manifault.com>
 <CAJnrk1YL1N371vkRDx9E6_OU2GwCj4sVzasBdjmYNUBuzygF_g@mail.gmail.com>
 <20220808185021.6papg2iwujlcaqlc@dev0025.ash9.facebook.com>
 <CAJnrk1bxiYfaR-2aM-PQdg75UQxWt0XJZxxrMs3sfZo02vvkYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJnrk1bxiYfaR-2aM-PQdg75UQxWt0XJZxxrMs3sfZo02vvkYw@mail.gmail.com>
User-Agent: NeoMutt/20211029
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 08, 2022 at 04:32:39PM -0700, Joanne Koong wrote:

[...]

> > It being a read-only const is was why I made this a BUILD_BUG_ON. My
> > intention here was to ensure that we're not accidentally skipping the
> > resetting of caller_saved[0]. The original code iterated from
> > caller_saved[0] -> caller_saved[CALLER_SAVED_REGS - 1]. Now that we're
> > starting from caller_saved[1], this compile-time assertion verifies that
> > we're not accidentally skipping caller_saved[0] by checking that it's the
> > same as BPF_REG_0, which is reset above. Does that make sense?
> 
> I think it's an invariant that r0 - r5 are the caller saved args and
> that caller_saved[0] will always be BPF_REG_0. I'm having a hard time
> seeing a case where this would change in the future, but then again, I
> am also not a fortune teller so maybe I am wrong here :) I don't think
> it's a big deal though so I don't feel strongly about this

I agree that it seems very unlikely to change, but I don't see the harm in
leaving it in. Compile time checks are very fast, and are meant for cases
such as these to check constant, build-time invariants. If you feel
strongly, I can remove it.

Thanks,
David
