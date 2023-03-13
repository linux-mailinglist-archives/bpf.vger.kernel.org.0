Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7A26B807D
	for <lists+bpf@lfdr.de>; Mon, 13 Mar 2023 19:28:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjCMS2C (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Mar 2023 14:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbjCMS1p (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Mar 2023 14:27:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613D983154
        for <bpf@vger.kernel.org>; Mon, 13 Mar 2023 11:27:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A9DB361479
        for <bpf@vger.kernel.org>; Mon, 13 Mar 2023 18:26:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5CB3C433D2;
        Mon, 13 Mar 2023 18:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678732009;
        bh=Bia+GBKG8lmRyWsYvCyQF1r8bz6gNTQ5x24Bf8skdlM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F9wBC7oTETh2cuzFiBHMKef/UTwVJ6igmGT08AotB0xDuzGfz2JcDTQ9wzAVyS66l
         JoZK/mHUC3KNJDhgRer6X7eVyNGTF+6N1GJ7QOBiLPd0iCmvuonAQruv2+kkCIw6uu
         mE7wImrI92Je0nVPX14ai6B0oYPYC0R8bMrQLQTzTBC2kuWsf0931F7Nlb0bqPzyyj
         K9W6cLLVxoOI3MxXGg6MDW6mY+FzqaZhu4TjeWvlv48YBEQ7WYAvHIvCREgFb5k+KN
         4pXcpPsD+T1LSFRZMXZDuBy+vuTm3zjslldMObtkXG+0HwdXkX10QNH4f848lKiYSB
         tsiX/zMNPvR8w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B03CF4049F; Mon, 13 Mar 2023 15:26:46 -0300 (-03)
Date:   Mon, 13 Mar 2023 15:26:46 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     Eduard Zingerman <eddyz87@gmail.com>, ast@kernel.org,
        andrii@kernel.org, daniel@iogearbox.net, haoluo@google.com,
        jolsa@kernel.org, john.fastabend@gmail.com, kpsingh@chromium.org,
        sinquersw@gmail.com, martin.lau@kernel.org, songliubraving@fb.com,
        sdf@google.com, timo@incline.eu, yhs@fb.com, bpf@vger.kernel.org
Subject: Re: [PATCH dwarves 2/3] dwarves_fprintf: support skipping modifier
Message-ID: <ZA9q5sY+8pd3kiAP@kernel.org>
References: <1678459850-16140-1-git-send-email-alan.maguire@oracle.com>
 <1678459850-16140-3-git-send-email-alan.maguire@oracle.com>
 <87964239858beb2fe8e2d625953a3606161c85b3.camel@gmail.com>
 <1d545a22-05ff-5a4d-e7bf-8cce08709c84@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d545a22-05ff-5a4d-e7bf-8cce08709c84@oracle.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Mon, Mar 13, 2023 at 05:18:28PM +0000, Alan Maguire escreveu:
> On 13/03/2023 14:45, Eduard Zingerman wrote:
> > On Fri, 2023-03-10 at 14:50 +0000, Alan Maguire wrote:
> > [...]
> >> diff --git a/dwarves_fprintf.c b/dwarves_fprintf.c
> >> index 5c6bf9c..b20a473 100644
> >> --- a/dwarves_fprintf.c
> >> +++ b/dwarves_fprintf.c
> >> @@ -506,7 +506,8 @@ static const char *tag__ptr_name(const struct tag *tag, const struct cu *cu,
> >>  				struct tag *next_type = cu__type(cu, type->type);
> >>  
> >>  				if (next_type && tag__is_pointer(next_type)) {
> >> -					const_pointer = "const ";
> >> +					if (!conf->skip_emitting_modifier)
> >> +						const_pointer = "const ";
> >>  					type = next_type;
> >>  				}
> >>  			}
> >> @@ -580,13 +581,16 @@ static const char *__tag__name(const struct tag *tag, const struct cu *cu,
> >>  				   *type_str = __tag__name(type, cu, tmpbf,
> >>  							   sizeof(tmpbf),
> >>  							   pconf);
> >> -			switch (tag->tag) {
> >> -			case DW_TAG_volatile_type: prefix = "volatile "; break;
> >> -			case DW_TAG_const_type:    prefix = "const ";	 break;
> >> -			case DW_TAG_restrict_type: suffix = " restrict"; break;
> >> -			case DW_TAG_atomic_type:   prefix = "_Atomic ";  break;
> >> +			if (!conf->skip_emitting_modifier) {
> >> +				switch (tag->tag) {
> >> +				case DW_TAG_volatile_type: prefix = "volatile "; break;
> >> +				case DW_TAG_const_type: prefix = "const"; break;
> > 
> > Here the space is removed from literal "const " and this results in
> > the following output (`pahole -F btf --sort ./vmlinux`):
> > 
> >     struct ZSTD_inBuffer_s {
> >             constvoid  *               src;                  /*     0     8 */
> >             ...
> >     };
> > 
> 
> great catch, thanks Eduard! Arnaldo will I send a followup patch for this?

Would be interesting to fold it into the one introducing the problem,
since I didn't push this to master yet.

You can send the patch and I can fold it, so that I keep that fixe I
made.

- Arnaldo
