Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4FC6690834
	for <lists+bpf@lfdr.de>; Thu,  9 Feb 2023 13:08:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbjBIMIc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Feb 2023 07:08:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbjBIMIU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Feb 2023 07:08:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B5F6F22F
        for <bpf@vger.kernel.org>; Thu,  9 Feb 2023 04:00:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 657B3B82108
        for <bpf@vger.kernel.org>; Thu,  9 Feb 2023 11:59:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE855C433D2;
        Thu,  9 Feb 2023 11:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675943989;
        bh=oXWvt9ikQIdybvm5fghQw40e9FhoWGUho7ULGneVAbo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T+GGFWFn5EvAH1tb/mI/mA5LZZpsN254Mx/QSMgDuo6wtd136+hyoQXtFBpU1ti08
         /9XwjvmwLBzfv6rP+uF29AGrm3n/qmbYuUxaFT+guHHIEbkSJKoxuuhwlBXwPCqt7s
         ZiH1hXnh+ORpTcFK81JpE3wpVbvmrRpOMiDpIf+sZbsKiACqb4Dx1aXrQXxFMKTQlE
         s+ls9oCNDN3ntWKVK7lxd9nNLT9AmkI4OHcXCRFxbb0ebYCaQClPAGD8lVqgaBy5CP
         6RZIlwkCp+tQi6YLqvCH4z0/+suuHXjSxJKIZi1Byb2gI45fS6BUUzJ1OF8dQJ9oNT
         Z5yjY6wetnDfg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7E105405BE; Thu,  9 Feb 2023 08:59:45 -0300 (-03)
Date:   Thu, 9 Feb 2023 08:59:45 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Alan Maguire <alan.maguire@oracle.com>, ast@kernel.org,
        andrii@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com,
        haoluo@google.com, john.fastabend@gmail.com, kpsingh@chromium.org,
        sinquersw@gmail.com, martin.lau@kernel.org, songliubraving@fb.com,
        sdf@google.com, timo@incline.eu, yhs@fb.com, bpf@vger.kernel.org
Subject: Re: [PATCH dwarves] btf_encoder: ensure elf function representation
 is fully initialized
Message-ID: <Y+TgMeSP99YAfS6N@kernel.org>
References: <1675896868-26339-1-git-send-email-alan.maguire@oracle.com>
 <Y+S+p3RuPg7KIFft@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+S+p3RuPg7KIFft@krava>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Thu, Feb 09, 2023 at 10:36:39AM +0100, Jiri Olsa escreveu:
> On Wed, Feb 08, 2023 at 10:54:28PM +0000, Alan Maguire wrote:
> > new fields in BTF encoder state (used to support save and later
> > addition of function) of ELF function representation need to
> > be initialized.  No need to set parameter names to NULL as
> > got_parameter_names guards their use.
> > 
> > A follow-on patch intended to be applied after the series [1].
> > 
> > [1] https://lore.kernel.org/bpf/1675790102-23037-1-git-send-email-alan.maguire@oracle.com/
> > 
> > Suggested-by: Jiri Olsa <jolsa@kernel.org>
> > Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>

Thanks, applied.

- Arnaldo

 
> thanks,
> jirka
> 
> > ---
> >  btf_encoder.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/btf_encoder.c b/btf_encoder.c
> > index 35fb60a..ea5b47b 100644
> > --- a/btf_encoder.c
> > +++ b/btf_encoder.c
> > @@ -1020,6 +1020,8 @@ static int btf_encoder__collect_function(struct btf_encoder *encoder, GElf_Sym *
> >  	}
> >  	encoder->functions.entries[encoder->functions.cnt].generated = false;
> >  	encoder->functions.entries[encoder->functions.cnt].function = NULL;
> > +	encoder->functions.entries[encoder->functions.cnt].state.got_parameter_names = false;
> > +	encoder->functions.entries[encoder->functions.cnt].state.type_id_off = 0;
> >  	encoder->functions.cnt++;
> >  	return 0;
> >  }
> > -- 
> > 1.8.3.1
> > 

-- 

- Arnaldo
