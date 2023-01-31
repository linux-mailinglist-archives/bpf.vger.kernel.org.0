Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDD006820A7
	for <lists+bpf@lfdr.de>; Tue, 31 Jan 2023 01:24:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjAaAYN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Jan 2023 19:24:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjAaAYN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Jan 2023 19:24:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2537E12590
        for <bpf@vger.kernel.org>; Mon, 30 Jan 2023 16:24:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D037BB818BF
        for <bpf@vger.kernel.org>; Tue, 31 Jan 2023 00:24:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BAA1C433D2;
        Tue, 31 Jan 2023 00:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675124649;
        bh=PXq1DoSF5zl/Bz73z8r9ntFD5aJyWrwFPp00Fk5jP6I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GxBD+TNfewXZJ8Q9UmUq+p4fhdkZCfXGUqcpC8UdXIkYOrFMn3OVPEuuPLzhxltqx
         thofEOhBBDKILOQvqjb52CGK+zhXFiht/s7MwqgtteqSoqPOTceLRBu5ONYOmUlFTE
         2r5Evkoxht6MJd2XrkjmuvrFGghBIL54ZySAlHDxIHsHeV6F5GysZqkuTqS9bP0ZEf
         h1hNlanSbVRGI7Za+0oYdjmOERfuKpMSvJ5MKVGA72dSNjYle9lumeuO79LZRiR4Yx
         dOUukloIV66Q8N60L2IJN1ijcW+q7PLmA2hSLPWRNbnZcA3JalQqNadTgFgK8CnZuq
         nl16yUKDH0z8w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 32A4C405BE; Mon, 30 Jan 2023 21:24:06 -0300 (-03)
Date:   Mon, 30 Jan 2023 21:24:06 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Alan Maguire <alan.maguire@oracle.com>, yhs@fb.com, ast@kernel.org,
        eddyz87@gmail.com, sinquersw@gmail.com, timo@incline.eu,
        daniel@iogearbox.net, andrii@kernel.org, songliubraving@fb.com,
        john.fastabend@gmail.com, kpsingh@chromium.org, sdf@google.com,
        haoluo@google.com, martin.lau@kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v2 dwarves 3/5] btf_encoder: rework btf_encoders__*() API
 to allow traversal of encoders
Message-ID: <Y9hfpqES52+um9mR@kernel.org>
References: <1675088985-20300-1-git-send-email-alan.maguire@oracle.com>
 <1675088985-20300-4-git-send-email-alan.maguire@oracle.com>
 <Y9g+5LlDrOjqS5ES@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9g+5LlDrOjqS5ES@krava>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Mon, Jan 30, 2023 at 11:04:20PM +0100, Jiri Olsa escreveu:
> On Mon, Jan 30, 2023 at 02:29:43PM +0000, Alan Maguire wrote:
> > To coordinate across multiple encoders at collection time, there
> > will be a need to access the set of encoders.  Rework the unused
> > btf_encoders__*() API to facilitate this.
> > 
> > Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> > ---
> >  btf_encoder.c | 30 ++++++++++++++++++++++--------
> >  btf_encoder.h |  6 ------
> >  2 files changed, 22 insertions(+), 14 deletions(-)
> > 
> > diff --git a/btf_encoder.c b/btf_encoder.c
> > index 44f1905..e20b628 100644
> > --- a/btf_encoder.c
> > +++ b/btf_encoder.c
> > @@ -30,6 +30,7 @@
> >  
> >  #include <errno.h>
> >  #include <stdint.h>
> > +#include <pthread.h>
> >  
> >  struct elf_function {
> >  	const char	*name;
> > @@ -79,21 +80,32 @@ struct btf_encoder {
> >  	} functions;
> >  };
> >  
> > -void btf_encoders__add(struct list_head *encoders, struct btf_encoder *encoder)
> > -{
> > -	list_add_tail(&encoder->node, encoders);
> > -}
> > +static LIST_HEAD(encoders);
> > +static pthread_mutex_t encoders__lock = PTHREAD_MUTEX_INITIALIZER;
> >  
> > -struct btf_encoder *btf_encoders__first(struct list_head *encoders)
> > +/* mutex only needed for add/delete, as this can happen in multiple encoding
> > + * threads.  Traversal of the list is currently confined to thread collection.
> > + */
> > +static void btf_encoders__add(struct btf_encoder *encoder)
> >  {
> > -	return list_first_entry(encoders, struct btf_encoder, node);
> > +	pthread_mutex_lock(&encoders__lock);
> > +	list_add_tail(&encoder->node, &encoders);
> > +	pthread_mutex_unlock(&encoders__lock);
> >  }
> >  
> > -struct btf_encoder *btf_encoders__next(struct btf_encoder *encoder)
> > +#define btf_encoders__for_each_encoder(encoder)		\
> > +	list_for_each_entry(encoder, &encoders, node)
> > +
> > +static void btf_encoders__delete(struct btf_encoder *encoder)
> >  {
> > -	return list_next_entry(encoder, node);
> > +	pthread_mutex_lock(&encoders__lock);
> > +	list_del(&encoder->node);
> > +	pthread_mutex_unlock(&encoders__lock);
> >  }
> >  
> > +#define btf_encoders__for_each_encoder(encoder)			\
> > +	list_for_each_entry(encoder, &encoders, node)
> > +
> 
> there's extra btf_encoders__for_each_encoder define
> 
> hum I'm scratching my head how this compile, probably because it's identical

I removed it, thanks!

- Arnaldo
 
> jirka
> 
> 
> >  #define PERCPU_SECTION ".data..percpu"
> >  
> >  /*
> > @@ -1505,6 +1517,7 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
> >  
> >  		if (encoder->verbose)
> >  			printf("File %s:\n", cu->filename);
> > +		btf_encoders__add(encoder);
> >  	}
> >  out:
> >  	return encoder;
> > @@ -1519,6 +1532,7 @@ void btf_encoder__delete(struct btf_encoder *encoder)
> >  	if (encoder == NULL)
> >  		return;
> >  
> > +	btf_encoders__delete(encoder);
> >  	__gobuffer__delete(&encoder->percpu_secinfo);
> >  	zfree(&encoder->filename);
> >  	btf__free(encoder->btf);
> > diff --git a/btf_encoder.h b/btf_encoder.h
> > index a65120c..34516bb 100644
> > --- a/btf_encoder.h
> > +++ b/btf_encoder.h
> > @@ -23,12 +23,6 @@ int btf_encoder__encode(struct btf_encoder *encoder);
> >  
> >  int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct conf_load *conf_load);
> >  
> > -void btf_encoders__add(struct list_head *encoders, struct btf_encoder *encoder);
> > -
> > -struct btf_encoder *btf_encoders__first(struct list_head *encoders);
> > -
> > -struct btf_encoder *btf_encoders__next(struct btf_encoder *encoder);
> > -
> >  struct btf *btf_encoder__btf(struct btf_encoder *encoder);
> >  
> >  int btf_encoder__add_encoder(struct btf_encoder *encoder, struct btf_encoder *other);
> > -- 
> > 1.8.3.1
> > 

-- 

- Arnaldo
