Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCAE349BB01
	for <lists+bpf@lfdr.de>; Tue, 25 Jan 2022 19:12:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbiAYSMA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Jan 2022 13:12:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30057 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233711AbiAYSL7 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 25 Jan 2022 13:11:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643134318;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZYZFcKeTPsQCFaSsqNlB8G3oqmreXQCJIoK82/wxEkU=;
        b=XEI8APwOLMstwDfrWdiGxohk0Tj8iYSCVRKmV+JMtqSXFTuhnopJyp3loDxYaHHf8o6WO3
        zXkPX9jUNBdvt/mZ5qSie953p3xwpFT67vrMTvNMTWIr8HrCqg8yCIjR4ZExKqYfBDjcK3
        WoGPRhqRNFS9hfmvU8oHnW67UDy54qE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-504-JGXaFftgN9ykUQMIDNMlDQ-1; Tue, 25 Jan 2022 13:11:56 -0500
X-MC-Unique: JGXaFftgN9ykUQMIDNMlDQ-1
Received: by mail-ej1-f71.google.com with SMTP id r18-20020a17090609d200b006a6e943d09eso3773080eje.20
        for <bpf@vger.kernel.org>; Tue, 25 Jan 2022 10:11:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZYZFcKeTPsQCFaSsqNlB8G3oqmreXQCJIoK82/wxEkU=;
        b=rMimxcWj2+9FTEnwz/aggVzsV7KuqcszpTeNCEdjEgVeO9QgKQvjI7H0CyAnAPtvvi
         yShy7pvEGj7d0L2yLNI6ZCdtwzr6hxelLYppyOHONPA0LPCf7ED4G65M5xgyhQkJCDwB
         P+nMICpFRmmG8L6Q+TDfDtvtXZLrZYD98RlffJTgsyZs2AUU6Gyv33dbMonTU8aXw3dP
         ZJ2c8edMhr5eWD4Roq/ZfCvBrqOAFtRhjkgiO/B4YM6oaRvQvIizedAqaOkHfqWER5CC
         U17FC6EONLL2tVX5ZZtimCOXNGcyV/zwsMKRlIhv4S1XSrMBrNymuJ/GJl1bmzCuJgvo
         gFKQ==
X-Gm-Message-State: AOAM5339WD+Wy+vp42QYkuoEbANLQg/GLkNR/X3tDS8GIbCMQk4+Goey
        Xszazqmjmz8w087aNpiCzvpA4CAdnyeFAA3BuJx9jZ1+5ZPokyezQkIncpBMCmdEIvAbDVkqpCB
        zAUg+gwHef/8z
X-Received: by 2002:a17:907:9605:: with SMTP id gb5mr17348654ejc.685.1643134315381;
        Tue, 25 Jan 2022 10:11:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyoPAYB5FVJEoP403NezL+MUS0Tv2jX6/UgHpSL8/pKp8IUbV8+JT6INoyPbobrfnoWYRryPQ==
X-Received: by 2002:a17:907:9605:: with SMTP id gb5mr17348639ejc.685.1643134315151;
        Tue, 25 Jan 2022 10:11:55 -0800 (PST)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id k7sm6425341ejp.182.2022.01.25.10.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 10:11:54 -0800 (PST)
Date:   Tue, 25 Jan 2022 19:11:52 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH v5 2/9] fprobe: Add ftrace based probe APIs
Message-ID: <YfA9aC5quQNc89Hc@krava>
References: <164311269435.1933078.6963769885544050138.stgit@devnote2>
 <164311271777.1933078.9066058105807126444.stgit@devnote2>
 <YfAoMW6i4gqw2Na0@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfAoMW6i4gqw2Na0@krava>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 25, 2022 at 05:41:24PM +0100, Jiri Olsa wrote:
> On Tue, Jan 25, 2022 at 09:11:57PM +0900, Masami Hiramatsu wrote:
> 
> SNIP
> 
> > +
> > +/* Convert ftrace location address from symbols */
> > +static int convert_func_addresses(struct fprobe *fp)
> > +{
> > +	unsigned long addr, size;
> > +	unsigned int i;
> > +
> > +	/* Convert symbols to symbol address */
> > +	if (fp->syms) {
> > +		fp->addrs = kcalloc(fp->nentry, sizeof(*fp->addrs), GFP_KERNEL);
> > +		if (!fp->addrs)
> > +			return -ENOMEM;
> > +
> > +		for (i = 0; i < fp->nentry; i++) {
> > +			fp->addrs[i] = kallsyms_lookup_name(fp->syms[i]);
> > +			if (!fp->addrs[i])	/* Maybe wrong symbol */
> > +				goto error;
> > +		}
> > +	}
> > +
> > +	/* Convert symbol address to ftrace location. */
> > +	for (i = 0; i < fp->nentry; i++) {
> > +		if (!kallsyms_lookup_size_offset(fp->addrs[i], &size, NULL))
> > +			size = MCOUNT_INSN_SIZE;
> > +		addr = ftrace_location_range(fp->addrs[i], fp->addrs[i] + size);
> 
> you need to substract 1 from 'end' in here, as explained in
> __within_notrace_func comment:
> 
>         /*
>          * Since ftrace_location_range() does inclusive range check, we need
>          * to subtract 1 byte from the end address.
>          */
> 
> like in the patch below
> 
> also this convert is for archs where address from kallsyms does not match
> the real attach addresss, like for arm you mentioned earlier, right?
> 
> could we have that arch specific, so we don't have extra heavy search
> loop for archs that do not need it?

one more question..

I'm adding support for user to pass function symbols to bpf fprobe link
and I thought I'd pass symbols array to register_fprobe, but I'd need to
copy the whole array of strings from user space first, which could take
lot of memory considering attachment of 10k+ functions

so I'm thinking better way is to resolve symbols already in bpf fprobe
link code and pass just addresses to register_fprobe

I assume you want to keep symbol interface, right? could we have some
flag ensuring the conversion code is skipped, so we don't go through
it twice?

in any case I need addresses before I call register_fprobe, because
of the bpf cookies setup

thanks,
jirka

