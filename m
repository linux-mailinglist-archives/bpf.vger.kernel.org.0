Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E77B4AE68C
	for <lists+bpf@lfdr.de>; Wed,  9 Feb 2022 03:39:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241226AbiBICjZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Feb 2022 21:39:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241323AbiBIAwi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Feb 2022 19:52:38 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF736C061576
        for <bpf@vger.kernel.org>; Tue,  8 Feb 2022 16:52:37 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id x4so815292plb.4
        for <bpf@vger.kernel.org>; Tue, 08 Feb 2022 16:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=czRTT56tb0CcrVHiiatHDJLx3pD9bKo0chH15xPS/g8=;
        b=hqXC8FSympw+nsaw0iiZ6QoiiPbaX1/vyjK6mc8T0HMoBKa2euB1nGZdjKlOD0uQgO
         zHtKBzM2mP5XZWa8rVy43v2yx66+Er/fwaddsXOn3JWkNvaka4wiIBfO85hSwBCC8TC/
         2phwLmQIwLEgdGSQOZWWSloDU1yijwq4waXCfZuXmDvot/oj5AMvK44cinaHg2ZQHd1D
         vx3/3Vf+QGt5Ng3cCYFvvTp6K3jhwk977GkFYqKonl8VNRR1DXQ8/V46PLlbb3k22frO
         fPINCWq2X1Pay6k0cF36tUJXuwIqeWi9tTnhR+eO1YphpqotUEQxGTcVR/pv/yVhMB2Q
         lm4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=czRTT56tb0CcrVHiiatHDJLx3pD9bKo0chH15xPS/g8=;
        b=0+nAAiJy61xCUNa7J4AJtHgg3DJe0lCClcHeQshDUTO0tPN/SOBim2NQWfVUa80xpN
         OmOUyJ28bVKsvp39Ds24mghrCIKp5hhiF6m+YnXJGlQ4U2Hch4NyP0ibTK+3lVxt689m
         SyYQqIiWcrp6eW1w2Soqu2yP6foPfWOWKtBcPcVV08oAXRGrBLIVkbJgStxT2pxtgyeR
         yB4yvE9DYFPxZ6ZymbdpeDV32rXBWhdKm5aAzosu9u8oA3kazrbEzQsbyLV/7YO6y3FT
         dDj6EMo1TaaTUQK9fL1GqBMQI1Z1IBDtJwQMUtiXyoqfAtUx67SZ4IPce4teq4c3VytU
         orIg==
X-Gm-Message-State: AOAM533iohScABlivOciLhchbbqAFw+9GRK+qHg9w9eD/cXHhoIhlT7N
        BJLcLHeOcb6sTwPedzOYci8=
X-Google-Smtp-Source: ABdhPJxwiVew7FrYwi/9hh4ruoowuHDFtty4/FFI40nZofvs9qFLbZyBxkE9I7xVoVHr8WHT1KOQtQ==
X-Received: by 2002:a17:90a:f491:: with SMTP id bx17mr666510pjb.3.1644367957444;
        Tue, 08 Feb 2022 16:52:37 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:cbf])
        by smtp.gmail.com with ESMTPSA id 13sm4891733pfx.122.2022.02.08.16.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 16:52:36 -0800 (PST)
Date:   Tue, 8 Feb 2022 16:52:35 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     davem@davemloft.net, daniel@iogearbox.net, andrii@kernel.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 bpf-next 3/5] bpftool: Generalize light skeleton
 generation.
Message-ID: <20220209005235.jqc3ox557oceuwsb@ast-mbp.dhcp.thefacebook.com>
References: <20220208191306.6136-1-alexei.starovoitov@gmail.com>
 <20220208191306.6136-4-alexei.starovoitov@gmail.com>
 <8a126b25-b8d0-3838-ecaa-0613c9e4894e@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a126b25-b8d0-3838-ecaa-0613c9e4894e@fb.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 08, 2022 at 04:25:15PM -0800, Yonghong Song wrote:
> 
> 
> On 2/8/22 11:13 AM, Alexei Starovoitov wrote:
> > From: Alexei Starovoitov <ast@kernel.org>
> > 
> > Generealize light skeleton by hiding mmap details in skel_internal.h
> > In this form generated lskel.h is usable both by user space and by the kernel.
> > 
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > ---
> >   tools/bpf/bpftool/gen.c | 45 ++++++++++++++++++++++++-----------------
> >   1 file changed, 27 insertions(+), 18 deletions(-)
> > 
> > diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
> > index eacfc6a2060d..903abbf077ce 100644
> > --- a/tools/bpf/bpftool/gen.c
> > +++ b/tools/bpf/bpftool/gen.c
> > @@ -472,7 +472,7 @@ static void codegen_destroy(struct bpf_object *obj, const char *obj_name)
> >   			continue;
> >   		if (bpf_map__is_internal(map) &&
> >   		    (bpf_map__map_flags(map) & BPF_F_MMAPABLE))
> > -			printf("\tmunmap(skel->%1$s, %2$zd);\n",
> > +			printf("\tskel_free_map_data(skel->%1$s, skel->maps.%1$s.initial_value, %2$zd);\n",
> >   			       ident, bpf_map_mmap_sz(map));
> >   		codegen("\
> >   			\n\
> > @@ -481,7 +481,7 @@ static void codegen_destroy(struct bpf_object *obj, const char *obj_name)
> >   	}
> >   	codegen("\
> >   		\n\
> > -			free(skel);					    \n\
> > +			skel_free(skel);				    \n\
> >   		}							    \n\
> >   		",
> >   		obj_name);
> > @@ -525,7 +525,7 @@ static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *h
> >   		{							    \n\
> >   			struct %1$s *skel;				    \n\
> >   									    \n\
> > -			skel = calloc(sizeof(*skel), 1);		    \n\
> > +			skel = skel_alloc(sizeof(*skel));		    \n\
> >   			if (!skel)					    \n\
> >   				goto cleanup;				    \n\
> >   			skel->ctx.sz = (void *)&skel->links - (void *)skel; \n\
> > @@ -544,18 +544,12 @@ static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *h
> >   		codegen("\
> >   			\n\
> > -				skel->%1$s =					 \n\
> > -					mmap(NULL, %2$zd, PROT_READ | PROT_WRITE,\n\
> > -					     MAP_SHARED | MAP_ANONYMOUS, -1, 0); \n\
> > -				if (skel->%1$s == (void *) -1)			 \n\
> > -					goto cleanup;				 \n\
> > -				memcpy(skel->%1$s, (void *)\"\\			 \n\
> > -			", ident, bpf_map_mmap_sz(map));
> > +				skel->%1$s = skel_prep_map_data((void *)\"\\	 \n\
> > +			", ident);
> >   		mmap_data = bpf_map__initial_value(map, &mmap_size);
> >   		print_hex(mmap_data, mmap_size);
> > -		printf("\", %2$zd);\n"
> > -		       "\tskel->maps.%1$s.initial_value = (__u64)(long)skel->%1$s;\n",
> > -		       ident, mmap_size);
> > +		printf("\", %1$zd, %2$zd);\n",
> > +		       bpf_map_mmap_sz(map), mmap_size);
> >   	}
> >   	codegen("\
> >   		\n\
> > @@ -592,6 +586,24 @@ static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *h
> >   	codegen("\
> >   		\n\
> >   		\";							    \n\
> > +		");
> > +	bpf_object__for_each_map(map, obj) {
> > +		size_t mmap_size = 0;
> > +
> > +		if (!get_map_ident(map, ident, sizeof(ident)))
> > +			continue;
> > +
> > +		if (!bpf_map__is_internal(map) ||
> > +		    !(bpf_map__map_flags(map) & BPF_F_MMAPABLE))
> > +			continue;
> > +
> > +		bpf_map__initial_value(map, &mmap_size);
> > +		printf("\tskel->maps.%1$s.initial_value ="
> > +		       " skel_prep_init_value((void **)&skel->%1$s, %2$zd, %3$zd);\n",
> > +		       ident, bpf_map_mmap_sz(map), mmap_size);
> > +	}
> > +	codegen("\
> > +		\n\
> >   			err = bpf_load_and_run(&opts);			    \n\
> >   			if (err < 0)					    \n\
> >   				return err;				    \n\
> > @@ -611,9 +623,8 @@ static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *h
> >   		else
> >   			mmap_flags = "PROT_READ | PROT_WRITE";
> > -		printf("\tskel->%1$s =\n"
> > -		       "\t\tmmap(skel->%1$s, %2$zd, %3$s, MAP_SHARED | MAP_FIXED,\n"
> > -		       "\t\t\tskel->maps.%1$s.map_fd, 0);\n",
> > +		printf("\tskel->%1$s = skel_finalize_map_data(&skel->maps.%1$s.initial_value,\n"
> > +		       "\t\t\t%2$zd, %3$s, skel->maps.%1$s.map_fd);\n",
> >   		       ident, bpf_map_mmap_sz(map), mmap_flags);
> >   	}
> >   	codegen("\
> > @@ -751,8 +762,6 @@ static int do_skeleton(int argc, char **argv)
> >   		#ifndef %2$s						    \n\
> >   		#define %2$s						    \n\
> >   									    \n\
> > -		#include <stdlib.h>					    \n\
> > -		#include <bpf/bpf.h>					    \n\
> 
> I noticed that in patch2, the "bpf.h" is used instead of <bpf/bpf.h>.
> Any particular reason for this or it is a bug fix?

skel_internal.h didn't include bpf.h directly.
gen_loader.c needs it. It does:
#include "skel_internal.h"
because gen_loader.c is part of libbpf.
libbpf sources cannot do #include <bpf/...>

If skel_internal.h did
#include <bpf/bpf.h>
there would be a build error:
In file included from gen_loader.c:15:
skel_internal.h:17:10: fatal error: bpf/bpf.h: No such file or directory
 #include <bpf/bpf.h>

Hence #include "bpf.h" in skel_internal.h
So it works for libbpf's gen_loader.c and for generated lskel.h too.
