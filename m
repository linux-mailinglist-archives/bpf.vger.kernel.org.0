Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B375367DD21
	for <lists+bpf@lfdr.de>; Fri, 27 Jan 2023 06:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbjA0Fgf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Jan 2023 00:36:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjA0Fge (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Jan 2023 00:36:34 -0500
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA8CE6DFC8
        for <bpf@vger.kernel.org>; Thu, 26 Jan 2023 21:36:29 -0800 (PST)
Received: by mail-qt1-f173.google.com with SMTP id g16so3269080qtu.2
        for <bpf@vger.kernel.org>; Thu, 26 Jan 2023 21:36:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vo7rTMB6b9MTTmmDalV5pHqdKZvkPbkSDY5acSyftlA=;
        b=WC3YQkIDlY2OQUVnbysI10GczzkbC0BnSOdZUoODhzbBtXbQbNnRthjWPiM6lINBPk
         sOjHVUYiAnkVNs85KEcVlenBKVLIVlV2HgRT+/NdvYWLccdRauu0TOxpr6kI+6Cg7qWu
         BADdwAsbevD20CYUVkpi3HCCeAOJGSGoJIZM+Jzht46J8cE29i11le2Bii+LduxYkZNC
         rKutK/pdYksxSdAUy1fc1FJgBS6SyAYhQ7jBftZPbboGTh2uZb3Cgg4Unlb8DoJTdcTD
         aGwhRvRzj2nYvozNwcQuU3QDz1ORUuraDgwxAWLDE1uT/d63LDdwEPw9wrYKzSqzhkIt
         kyXg==
X-Gm-Message-State: AFqh2kojDpg4ikLnckf0h4j/59TY5qTO4qejYRsxkXpDA4JZIsxCVvQU
        H13Gj+0YxgCNsK4R2j4xLUenV5+eTskSzQ==
X-Google-Smtp-Source: AMrXdXu8VEonbJRhgcj2w1U676qudOtYqL9qLBjS+xM654lBNfmeLhdOmqNb3ekSzf+htAJcLk7lFA==
X-Received: by 2002:ac8:610f:0:b0:3b6:9c63:5ca1 with SMTP id a15-20020ac8610f000000b003b69c635ca1mr39346537qtm.43.1674797788704;
        Thu, 26 Jan 2023 21:36:28 -0800 (PST)
Received: from maniforge ([2620:10d:c091:480::1:64b2])
        by smtp.gmail.com with ESMTPSA id h185-20020a376cc2000000b007069375e0f4sm2265028qkc.122.2023.01.26.21.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 21:36:28 -0800 (PST)
Date:   Thu, 26 Jan 2023 23:36:26 -0600
From:   David Vernet <void@manifault.com>
To:     Dave Thaler <dthaler@microsoft.com>
Cc:     "dthaler1968@googlemail.com" <dthaler1968@googlemail.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "bpf@ietf.org" <bpf@ietf.org>
Subject: Re: [PATCH] bpf, docs: Use consistent names for the same field
Message-ID: <Y9Ni2tmbNqF4QBL4@maniforge>
References: <20230125185817.6408-1-dthaler1968@googlemail.com>
 <Y9GOiIbWz5mL0nSv@maniforge>
 <PH7PR21MB38789524AE1609A864894A04A3CC9@PH7PR21MB3878.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR21MB38789524AE1609A864894A04A3CC9@PH7PR21MB3878.namprd21.prod.outlook.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 27, 2023 at 02:09:28AM +0000, Dave Thaler wrote:
> David Vernet <void@manifault.com> wrote: 
> > In the future, if sending subsequent iterations of a patch, could you please
> > follow the typical versioning  and changelog convention described in [0]?
> 
> Thanks for being patient with a newcomer to this particular process :)

No problem, the process can be a bit arcane :-)

> 
> > >  =============  =======  ===============  ====================
> > ============
> > >  32 bits (MSB)  16 bits  4 bits           4 bits                8 bits (LSB)
> > >  =============  =======  ===============  ====================
> > ============
> > > -immediate      offset   source register  destination register  opcode
> > > +imm            offset   src              dst                   opcode
> > 
> > What's the rationale for changing source register and destination register to
> > src and dst respectively here? Below you clarify that they mean something
> > other than register number after this section in the document, so why not
> > just leave them as is here to avoid any confusion?
> 
> Fair point, will update.
> 
> > Can we make all of these bold, just to slightly improve readability.
> > E.g.:
> > 
> > **imm**
> 
> My view was that it was up to the RST renderer to do so. For example,
> if you look at https://github.com/ebpffoundation/ebpf-docs/blob/update/rst/instruction-set.rst which is what I used
> to validate the look of this patch plus other patches, it is already
> bolded because the github RST renderer bolds definition list terms.
> 
> On the other hand, https://htmlpreview.github.io/?https://raw.githubusercontent.com/ebpffoundation/ebpf-docs/pdf/draft-thaler-bpf-isa.html#section-3 is the output of RST -> xml2rfcv3 -> HTML
> doesn't do so.  That could be addressed either by me updating the
> RST -> xml2rfcv3 converter to automatically bold (i.e., add <strong> to the XML)
> or by adding an explicit bolding as you suggest.
> 
> I guess the benefit of adding the bolding into the RST itself is if there
> are other RST renderers that don't automatically bold definition list terms but
> we want them to.  I see other RST files in the Documentation/bpf directory
> vary in terms of whether any explicit bolding is used, but I see maps.rst
> does so, so I will go ahead and do this and make the RST -> xml2rfcv3
> converter map bolding correctly to xml.

Yeah, definition list items are weird. Not a huge deal either way, but
my preference would be to just force the issue by using the ** ... **
syntax to make it bold. Sounds like we're in agreement.

Thanks,
David
