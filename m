Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 384866A8830
	for <lists+bpf@lfdr.de>; Thu,  2 Mar 2023 19:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjCBSAS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Mar 2023 13:00:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjCBSAR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Mar 2023 13:00:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9026B34F52;
        Thu,  2 Mar 2023 10:00:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27AD361625;
        Thu,  2 Mar 2023 18:00:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ED63C433D2;
        Thu,  2 Mar 2023 18:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677780015;
        bh=KJV8ir8Jjr+hwTXupgZ9WqL8uKtDPclFlqYOsqUJE+I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qkWQyJJyzq6wgiw/Jtcpj/GeY1nSPVcdo5FCWv+flc7+woilQkagKjQc9EOUrMWVA
         aI3lDcNROaIBiO9G9I8MhGdvu9921A7TUXxA2B7mrV11ElgmM4MgIvrKUj6e+MVu5z
         yqlt8G97heCymDtLAxwZSwwoKEICM3REpiLC2mFOIvHUHoVjTpFDvWlh4epKfHGQ/g
         nz5WPT384er7SLGL2PL7s36Rd25jwEQZ2xA3j3WwrB/OD73fW8UPcJiX835KiAe0+9
         A24xvChdokb6fWKT23siYaPp85sjkGH1j/Q21CefzmYnNNJscfx+M4p2B7yKkS2WBO
         HrSmr//p23NdQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 88AFF4049F; Thu,  2 Mar 2023 15:00:12 -0300 (-03)
Date:   Thu, 2 Mar 2023 15:00:12 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Eduard Zingerman <eddyz87@gmail.com>, dwarves@vger.kernel.org,
        arnaldo.melo@gmail.com, bpf@vger.kernel.org, kernel-team@fb.com,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        yhs@fb.com, KP Singh <kpsingh@kernel.org>,
        Matt Bobrowski <mattbobrowski@google.com>
Subject: Re: [PATCH dwarves] dwarf_loader: Fix for BTF id drift caused by
 adding unspecified types
Message-ID: <ZADkLFc+uPLXjokq@kernel.org>
References: <20230228202357.2766051-1-eddyz87@gmail.com>
 <Y//BfO3pAixXLLyA@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y//BfO3pAixXLLyA@krava>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Wed, Mar 01, 2023 at 10:19:56PM +0100, Jiri Olsa escreveu:
> On Tue, Feb 28, 2023 at 10:23:57PM +0200, Eduard Zingerman wrote:
> > Recent changes to handle unspecified types (see [1]) cause BTF ID drift.
> > 
> > Specifically, the intent of commits [2], [3] and [4] is to render
> > references to unspecified types as void type.
> > However, as a consequence:
> > - in `die__process_unit()` call to `cu__add_tag()` allocates `small_id`
> >   for unspecified type tags and adds these tags to `cu->types_table`;
> > - `btf_encoder__encode_tag()` skips generation of BTF entries for
> >   `DW_TAG_unspecified_type` tags.
> > 
> > Such logic causes ID drift if unspecified type is not the last type
> > processed for compilation unit. `small_id` of each type following
> > unspecified type in the `cu->types_table` would have its BTF id off by -1.
> > Thus, rendering references established on recode phase invalid.
> > 
> > This commit reverts `unspecified_type` id/tag tracking.
> > Instead, the following is done:
> > - `small_id` for unspecified type tags is set to 0, thus reference to
> >   unspecified type tag would render BTF id of a `void` on recode phase;
> > - unspecified type tags are not added to `cu->types_table`.
> > 
> > This change also happens to fix issue reported in [5], the gist of
> > that issue is that the field `encoder->unspecified_type` is set but
> > not reset by function `btf_encoder__encode_cu()`. Thus, the following
> > sequence of events might occur when BTF encoding is requested:
> > - CU with unspecified type is processed:
> >   - unspecified type id is 42
> >   - encoder->unspecified_type is set to 42
> > - CU without unspecified type is processed next using the same
> >   `encoder` object:
> >   - some `struct foo` has id 42 in this CU
> >   - the references to `struct foo` are set 0 by function
> >     `btf_encoder__tag_type()`.
> > 
> > [1] https://lore.kernel.org/all/Y0R7uu3s%2FimnvPzM@kernel.org/
> > [2] bcc648a10cbc ("btf_encoder: Encode DW_TAG_unspecified_type returning routines as void")
> > [3] cffe5e1f75e1 ("core: Record if a CU has a DW_TAG_unspecified_type")
> > [4] 75e0fe28bb02 ("core: Add DW_TAG_unspecified_type to tag__is_tag_type() set")
> > [5] https://lore.kernel.org/bpf/Y%2FP1yxAuV6Wj3A0K@google.com/
> > 
> > Fixes: bcc648a10cbc ("btf_encoder: Encode DW_TAG_unspecified_type returning routines as void")
> > Fixes: 52b25808e44a ("btf_encoder: Store type_id_off, unspecified type in encoder")
> > Tested-by: KP Singh <kpsingh@kernel.org>
> > Reported-by: Matt Bobrowski <mattbobrowski@google.com>
> > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> 
> lgtm, tested on top of the pahole next branch with bpf selftests
> 
> Tested-by: Jiri Olsa <jolsa@kernel.org>

Looks good to me as well, and way more elegant, thanks!

Applied.

- Arnaldo
