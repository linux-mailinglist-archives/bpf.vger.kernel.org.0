Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6AE268F90D
	for <lists+bpf@lfdr.de>; Wed,  8 Feb 2023 21:51:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbjBHUvy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Feb 2023 15:51:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231872AbjBHUvx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Feb 2023 15:51:53 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC5BEC51
        for <bpf@vger.kernel.org>; Wed,  8 Feb 2023 12:51:51 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id ud5so535152ejc.4
        for <bpf@vger.kernel.org>; Wed, 08 Feb 2023 12:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O6JD1YGK92+DAj5sFxRZQdANB7vgvqHonYCnX6Je3Aw=;
        b=f/wVIXr0aDBEYTXURksu92FKry6475XZW+3rO1w52hZIDOTAZWTzX9OhYUcEzC4ehU
         dC7WM0erHfimruVA9OWQERzkc/nWcbz/+di/WUCB534imTcuwyXxlo4aHA0CvW4a0eiX
         xWuvRETOadvd6rTzP2sICMHjaVGrRRD7sqnUmhbEMcN7UDpTZo1feCJGW/ELmT3mR71e
         IEhfOUvYWMMkZ/xqjxRdSfrZFSdLLvkC0c9g27aHC8IV5ABdnHsOoFwsMNyvAdFkB3Sk
         MkcnUDkjTrPXDYyf6ckO1PaK8U4/1aQ5QviBbtmu37gO6CKugtxAlVNWIMSK658D/q1x
         ticw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O6JD1YGK92+DAj5sFxRZQdANB7vgvqHonYCnX6Je3Aw=;
        b=QyQFkCu0W96T/TX70W06n3NN7TsE+ManApXfbFzSNZCjqmkapjrJ8E9hwq/6vmiJv+
         2e2VDl+jYbYW3n2IvYy9zGkCxHaXEIsZZkwV9A/M1AckIOdv7QYQIWci1c7NA+l6cjcz
         cfPQdFT1oXDiDNVR5fwXEKvzu1UxQCU2qd0FByGm1lG4zpjddLIjrPyXg1oQ7XHXlff3
         Z3aUul3nTVB91vV2FU1dl+LRFSmRVr1+zPGHA3QpwMi7VYSGj7TdwqVqaDszpPh3EfIu
         wr6u5M2ABCBJceF2GGqkDycVB44biPnYAUkGeWfsI8Jd6coa3N0qNmv0qGW/UD8H7xtK
         zvfQ==
X-Gm-Message-State: AO0yUKU/b/GqsIAgOET4xXMVEn5CdoSd+C1JTR1g7iJNd7ZfHDooiUVk
        qOPqjVaGsIxg0CGLCwl+0YQ=
X-Google-Smtp-Source: AK7set/XkztpTaln2y07HnFGfL4waPEeyNGsBXfBFICt4CNPQar09bKa2Bna+982Sy9umSVGaBwspw==
X-Received: by 2002:a17:907:3f93:b0:82e:a57b:cc9b with SMTP id hr19-20020a1709073f9300b0082ea57bcc9bmr5602408ejc.24.1675889510285;
        Wed, 08 Feb 2023 12:51:50 -0800 (PST)
Received: from krava ([83.240.61.48])
        by smtp.gmail.com with ESMTPSA id gw1-20020a170906f14100b0087bd4e34eb8sm8655226ejb.203.2023.02.08.12.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 12:51:49 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Wed, 8 Feb 2023 21:51:47 +0100
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>,
        Alan Maguire <alan.maguire@oracle.com>, ast@kernel.org,
        andrii@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com,
        haoluo@google.com, john.fastabend@gmail.com, kpsingh@chromium.org,
        sinquersw@gmail.com, martin.lau@kernel.org, songliubraving@fb.com,
        sdf@google.com, timo@incline.eu, yhs@fb.com, bpf@vger.kernel.org
Subject: Re: [PATCH v3 dwarves 5/8] btf_encoder: Represent "."-suffixed
 functions (".isra.0") in BTF
Message-ID: <Y+QLY1cZGAxq6sbW@krava>
References: <1675790102-23037-1-git-send-email-alan.maguire@oracle.com>
 <1675790102-23037-6-git-send-email-alan.maguire@oracle.com>
 <Y+OhWAjPI5ngE/Jc@krava>
 <Y+O1Bvur0VnHJX6C@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+O1Bvur0VnHJX6C@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 08, 2023 at 11:43:18AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Wed, Feb 08, 2023 at 02:19:20PM +0100, Jiri Olsa escreveu:
> > On Tue, Feb 07, 2023 at 05:14:59PM +0000, Alan Maguire wrote:
> > 
> > SNIP
> > 
> > > +
> > >  /*
> > >   * This corresponds to the same macro defined in
> > >   * include/linux/kallsyms.h
> > > @@ -818,6 +901,11 @@ static int functions_cmp(const void *_a, const void *_b)
> > >  	const struct elf_function *a = _a;
> > >  	const struct elf_function *b = _b;
> > >  
> > > +	/* if search key allows prefix match, verify target has matching
> > > +	 * prefix len and prefix matches.
> > > +	 */
> > > +	if (a->prefixlen && a->prefixlen == b->prefixlen)
> > > +		return strncmp(a->name, b->name, b->prefixlen);
> > >  	return strcmp(a->name, b->name);
> > >  }
> > >  
> > > @@ -850,14 +938,22 @@ static int btf_encoder__collect_function(struct btf_encoder *encoder, GElf_Sym *
> > >  	}
> > >  
> > >  	encoder->functions.entries[encoder->functions.cnt].name = name;
> > > +	if (strchr(name, '.')) {
> > > +		const char *suffix = strchr(name, '.');
> > > +
> > > +		encoder->functions.suffix_cnt++;
> > > +		encoder->functions.entries[encoder->functions.cnt].prefixlen = suffix - name;
> > > +	}
> > >  	encoder->functions.entries[encoder->functions.cnt].generated = false;
> > > +	encoder->functions.entries[encoder->functions.cnt].function = NULL;
> > 
> > should we zero functions.state in here? next patch adds other stuff
> > like got_parameter_names and parameter_names in it, so looks like it
> > could actually matter
> 
> Probably, but that can come as a followup patch, right?

sure, if Alan is ok with that

jirka

> 
> I've applied the patches, combining the patches documenting the two new
> command line options with the patches where those options are
> introduced.
> 
> Testing everything now.
> 
> Thanks,
> 
> - Arnaldo
>  
> > jirka
> > 
> > >  	encoder->functions.cnt++;
> > >  	return 0;
> > >  }
> > >  
> > > -static struct elf_function *btf_encoder__find_function(const struct btf_encoder *encoder, const char *name)
> > > +static struct elf_function *btf_encoder__find_function(const struct btf_encoder *encoder,
> > > +						       const char *name, size_t prefixlen)
> > >  {
> > > -	struct elf_function key = { .name = name };
> > > +	struct elf_function key = { .name = name, .prefixlen = prefixlen };
> > >  
> > 
> > SNIP
> 
> -- 
> 
> - Arnaldo
