Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CABC761A55F
	for <lists+bpf@lfdr.de>; Sat,  5 Nov 2022 00:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiKDXKf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Nov 2022 19:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiKDXKe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Nov 2022 19:10:34 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85BA7A19F;
        Fri,  4 Nov 2022 16:10:33 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id C35E82C8;
        Fri,  4 Nov 2022 23:10:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net C35E82C8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1667603432; bh=hrRJCfax9hvAb9UzryvBrpCL6w0tDPadfdbP2XtM8T4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=hos/qeQCIvdU1pNKwBpWwCpSvg+L/oCV+7awU4OsvHsS2cxH6xNcpJjp2hoxSjzan
         IxlNJcInNFz9RQI6Z5l+vvzO2Zqbest6sAYh6K45Fzq+1HrRTUmdfDVftWGMKwO7z2
         3xgc7X7UTc1EHPd5dky1Wd5QQsA8SHLfP5LII7zFt/ofkNr5KdIj4WRSKTb2BcHiTC
         vkZw0kRGw2aSmNAKlbwHgAhup2QHL0P5IjRuLFgLL8o9Dm+/0OhPNsdj/eGfUnUS8G
         MPSiMUzQPzDopPwATzPO2Yix/ZcKDKvt1JHJdB6LDNXBur4TkBQ8OoHSvhgGWBMGJj
         d3JBaRHGjjhhQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Joe Stringer <joe@isovalent.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev
Subject: Re: [PATCH bpf-next v2] docs/bpf: Add LRU internals description and
 graph
In-Reply-To: <CADa=RyxodgJ+Wa3tiWxTntZoy7eSm_UkuzDBx9tCN=s_QnsDOw@mail.gmail.com>
References: <20221103205010.3266865-1-joe@isovalent.com>
 <101ab00c-5fa7-c3ee-63bd-f235e7c4d398@gmail.com>
 <CADa=RyxodgJ+Wa3tiWxTntZoy7eSm_UkuzDBx9tCN=s_QnsDOw@mail.gmail.com>
Date:   Fri, 04 Nov 2022 17:10:31 -0600
Message-ID: <87fseyqpso.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Joe Stringer <joe@isovalent.com> writes:

> Resending, this time without HTML.
>
> On Fri, Nov 4, 2022 at 2:31 AM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>>
>> Shouldn't the table be written in reST table syntax instead?
>
> This table follows the syntax outlined in
> https://docs.kernel.org/doc-guide/sphinx.html#list-tables . Is that
> document not up to date?

That document, right where you linked, says:

	The list-table formats can be useful for tables that are not
	easily laid out in the usual Sphinx ASCII-art formats. These
	formats are nearly impossible for readers of the plain-text
	documents to understand, though, and should be avoided in the
	absence of a strong justification for their use.

The list-table formats exist for a reason, and sometimes they can't
really be avoided, but they do impose a heavy readability cost on the
plain-text files.

> I'm happy to do this, but several of the diagram boxes will reference
> terms like rotation, shrinking etc without explaining what they are. I
> think it's a net negative to readability if this text is not included
> with the diagram. If you think the commit formatting is a bit over the
> top, I could maybe just remove the decoration and embed the content
> directly in the doc? On my first attempt at sketching this up, it just
> felt a bit weird for me to submit that text directly if Martin was the
> author of the text. But I could figure something out for that if
> that's the preferred approach.

I don't quite understand this comment; I don't think anybody is asking
you to take information out?  Just to use one of the other table formats
if you can.

>> Since it references the same figure, just say "See the figure above for more
>> details".
>
> The figure is rendered visually in the docs without the corresponding
> node names, so developers would need to look at either the dot source
> or maybe the SVG source though that's arguably a little less readable.
> The suggested phrasing to see the figure doesn't sound very useful to
> me since the simple reader's interpretation would be to look directly
> at the render rather than the source. This last sentence was intended
> as a helpful way for developers to find the path to the corresponding
> document, but if you think that is too much detail then I could also
> just drop this last sentence. Thoughts?

That sentence is fine, I wouldn't mess with it.

Thanks,

jon
