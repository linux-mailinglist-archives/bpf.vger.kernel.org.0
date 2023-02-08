Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04F6968F10C
	for <lists+bpf@lfdr.de>; Wed,  8 Feb 2023 15:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbjBHOnb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Feb 2023 09:43:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBHOna (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Feb 2023 09:43:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B084ABD1
        for <bpf@vger.kernel.org>; Wed,  8 Feb 2023 06:43:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 32A33B81D48
        for <bpf@vger.kernel.org>; Wed,  8 Feb 2023 14:43:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B67A1C433D2;
        Wed,  8 Feb 2023 14:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675867401;
        bh=sk3e37zsu/gD/F9XbpIauUYCql5oA+bTNcHPLugkOMY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=slsQocVS1oLmG6Birl9bxELmaKWMB1yfIH44x0XuqFFiQ+6kY0CmR0mFlzFySvSJt
         7bKQdLaYttzo+5HTVnWt3nt5vpCrABeFy3VRbgbNGrtOCuykX8aJES/3PD46Ske3hc
         ujwT4ENTztEbEwr6sa7wmTYrKzi3YRC4WU9xPHuAYQhrA14VKxxljpBegRFV1cDWFd
         l4lS/UahQUGXa93AS7+X2/RK1p5QzfQE7d5erARfm9wSWdKMQXnAPrf+N2/Y1lzg0e
         SBSnt3SS52KctZpClsOydR4U37BmlPBmz8O/nvTCrYxx1h9b6aU+uOPGe0tZ3NqUD0
         SEnX+V0SJa3qA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E7B7B405BE; Wed,  8 Feb 2023 11:43:18 -0300 (-03)
Date:   Wed, 8 Feb 2023 11:43:18 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Alan Maguire <alan.maguire@oracle.com>, ast@kernel.org,
        andrii@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com,
        haoluo@google.com, john.fastabend@gmail.com, kpsingh@chromium.org,
        sinquersw@gmail.com, martin.lau@kernel.org, songliubraving@fb.com,
        sdf@google.com, timo@incline.eu, yhs@fb.com, bpf@vger.kernel.org
Subject: Re: [PATCH v3 dwarves 5/8] btf_encoder: Represent "."-suffixed
 functions (".isra.0") in BTF
Message-ID: <Y+O1Bvur0VnHJX6C@kernel.org>
References: <1675790102-23037-1-git-send-email-alan.maguire@oracle.com>
 <1675790102-23037-6-git-send-email-alan.maguire@oracle.com>
 <Y+OhWAjPI5ngE/Jc@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+OhWAjPI5ngE/Jc@krava>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Wed, Feb 08, 2023 at 02:19:20PM +0100, Jiri Olsa escreveu:
> On Tue, Feb 07, 2023 at 05:14:59PM +0000, Alan Maguire wrote:
> 
> SNIP
> 
> > +
> >  /*
> >   * This corresponds to the same macro defined in
> >   * include/linux/kallsyms.h
> > @@ -818,6 +901,11 @@ static int functions_cmp(const void *_a, const void *_b)
> >  	const struct elf_function *a = _a;
> >  	const struct elf_function *b = _b;
> >  
> > +	/* if search key allows prefix match, verify target has matching
> > +	 * prefix len and prefix matches.
> > +	 */
> > +	if (a->prefixlen && a->prefixlen == b->prefixlen)
> > +		return strncmp(a->name, b->name, b->prefixlen);
> >  	return strcmp(a->name, b->name);
> >  }
> >  
> > @@ -850,14 +938,22 @@ static int btf_encoder__collect_function(struct btf_encoder *encoder, GElf_Sym *
> >  	}
> >  
> >  	encoder->functions.entries[encoder->functions.cnt].name = name;
> > +	if (strchr(name, '.')) {
> > +		const char *suffix = strchr(name, '.');
> > +
> > +		encoder->functions.suffix_cnt++;
> > +		encoder->functions.entries[encoder->functions.cnt].prefixlen = suffix - name;
> > +	}
> >  	encoder->functions.entries[encoder->functions.cnt].generated = false;
> > +	encoder->functions.entries[encoder->functions.cnt].function = NULL;
> 
> should we zero functions.state in here? next patch adds other stuff
> like got_parameter_names and parameter_names in it, so looks like it
> could actually matter

Probably, but that can come as a followup patch, right?

I've applied the patches, combining the patches documenting the two new
command line options with the patches where those options are
introduced.

Testing everything now.

Thanks,

- Arnaldo
 
> jirka
> 
> >  	encoder->functions.cnt++;
> >  	return 0;
> >  }
> >  
> > -static struct elf_function *btf_encoder__find_function(const struct btf_encoder *encoder, const char *name)
> > +static struct elf_function *btf_encoder__find_function(const struct btf_encoder *encoder,
> > +						       const char *name, size_t prefixlen)
> >  {
> > -	struct elf_function key = { .name = name };
> > +	struct elf_function key = { .name = name, .prefixlen = prefixlen };
> >  
> 
> SNIP

-- 

- Arnaldo
