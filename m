Return-Path: <bpf+bounces-1151-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC9070EEE8
	for <lists+bpf@lfdr.de>; Wed, 24 May 2023 09:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A1012811C9
	for <lists+bpf@lfdr.de>; Wed, 24 May 2023 07:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF096FC9;
	Wed, 24 May 2023 07:03:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4711B6FB6
	for <bpf@vger.kernel.org>; Wed, 24 May 2023 07:03:57 +0000 (UTC)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4706B1BB
	for <bpf@vger.kernel.org>; Wed, 24 May 2023 00:03:52 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-307d58b3efbso252862f8f.0
        for <bpf@vger.kernel.org>; Wed, 24 May 2023 00:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684911830; x=1687503830;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cuTh8MQt+cJrqd0KF9p/Sw/yvw7prj61CNy9gPQxwtM=;
        b=EymZI4UJP6LCyVeQQbHUHxJpAYZsOXU18HIJotLr0rBL3WyZwushQ0lthTzZiRJeZh
         Xg2eMEzm3puA7k+PJ17M+lvjeXCWIB0HMf11RCvuqL0NiPEhu20Y7TV4RcUXyl/y8sG9
         1sVPjxUX6EW2+M/wqCXueryGjobFVg4oUn/6u29QR1E7L+jZu1GGrk6JC5gZn+Ijpv8i
         vDAluIMbs4/Ejw27YP5IvYf7dYS0ApK0BRkYMfun4E59URbDhxZZAGMeh5DTPL/KzU45
         WA6bEx4xYU3pU0Ht2xlKz6db5Bi+iR8ZJgTP/wqXo+KpXV8kS8xiThsOD30rVTrg8ucR
         OYgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684911830; x=1687503830;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cuTh8MQt+cJrqd0KF9p/Sw/yvw7prj61CNy9gPQxwtM=;
        b=Ddb8LQb9b0HnCkT4zKGDyZKgld4/zrieLBtA9AQJSzb7jR9680Hh5X2CnDW6b6pTWa
         YL9IvYrs/ZDghignXXbh16Pwi+nle/T0qmUrCTDypznDguH0MbWqZ/4FFjPzmi2MxHH1
         7a9V3XgwAuwJcNJ8Pbr2KyS+Ycb0hQd98kVdyrJWAMQdA8oeEEa01Ccuqhg11SOVUY/i
         TmPN7kb99Uom+0CAm3JCM9OaPB/eCQUW868W4sVRW+nOxeJxPjufbilz/UxMNSQgqwxb
         nyPGTew8Emqm8MC388uoWWXCdZf5E+x8vE3X9jLiqtVC4IArCqkJGq0VZAEl7IcBhb/0
         N48g==
X-Gm-Message-State: AC+VfDxq8laQX7/Y98KveKUWXQ3XobYC6Er37zatNBYrVeRYjfMW0iCc
	qCZqCxmyI2Yn+NX0S+wvHbw=
X-Google-Smtp-Source: ACHHUZ7DPpYcMmtUcT/Z0ukH5vjTVWdqC2uf8w2A9lnwD6pMDTz7fTHxHt7nt7GopDoMBZVStWnVoA==
X-Received: by 2002:adf:ea02:0:b0:309:475c:c90e with SMTP id q2-20020adfea02000000b00309475cc90emr12735948wrm.37.1684911830340;
        Wed, 24 May 2023 00:03:50 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id k16-20020a5d5190000000b003078c535277sm13290685wrv.91.2023.05.24.00.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 00:03:49 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 24 May 2023 09:03:47 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Jackie Liu <liu.yun@linux.dev>,
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
	yhs@fb.com, bpf@vger.kernel.org, liuyun01@kylinos.cn,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] libbpf: kprobe.multi: Filter with blacklist and
 available_filter_functions
Message-ID: <ZG2207+R//XmQV95@krava>
References: <20230523132547.94384-1-liu.yun@linux.dev>
 <ZGznHMU1uhdPnE/F@krava>
 <CAEf4BzZTn41v7_xAzg4A0xCq9qWmFjLxebHe5gTw9p-=A93RQw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZTn41v7_xAzg4A0xCq9qWmFjLxebHe5gTw9p-=A93RQw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, May 23, 2023 at 11:22:46AM -0700, Andrii Nakryiko wrote:

SNIP

> > > +avail_filter:
> > > +     f = fopen("/sys/kernel/debug/tracing/available_filter_functions", "r");
> > > +     if (!f)
> > > +             return true;
> > > +
> > > +     while (true) {
> > > +             ret = fscanf(f, "%s%*[^\n]\n", sym_name);
> > > +             if (ret == EOF && feof(f))
> > > +                     break;
> > > +             if (ret != 1)
> > > +                     break;
> > > +             if (!strcmp(name, sym_name)) {
> > > +                     fclose(f);
> > > +                     return true;
> > > +             }
> > > +     }
> > > +     fclose(f);
> > > +     return false;
> > > +}
> > > +
> > >  static int
> > >  resolve_kprobe_multi_cb(unsigned long long sym_addr, char sym_type,
> > >                       const char *sym_name, void *ctx)
> > > @@ -10431,6 +10475,9 @@ resolve_kprobe_multi_cb(unsigned long long sym_addr, char sym_type,
> > >       if (!glob_match(sym_name, res->pattern))
> > >               return 0;
> > >
> > > +     if (!filter_available_function(sym_name))
> > > +             return 0;
> >
> > I think it'd be better to parse available_filter_functions directly
> > for kprobe_multi instead of filtering out kallsyms entries
> 
> yep, available_filter_functions should be cheaper to parse than
> kallsyms. We can probably fallback to kallsyms still, if
> available_filter_functions are missing.
> 
> Furthermore, me and Steven chatted at lsfmm2023 about having an
> available_filter_functions-like file with kernel function addresses
> (not just names), which would speed up attachment as well. It could be
> useful in some other scenarios as well (e.g., I think retsnoop has to
> join kallsyms and available_filter_functions). I think it's still a
> good idea to add this new file, given kernel has all this information
> readily available anyways.

yes, would be useful for this, and likely in other places

jirka

> 
> 
> >
> > we could add libbpf_available_filter_functions_parse function with
> > similar callback to go over available_filter_functions file
> 
> or iterator ;)
> 
> but either way, current approach will do linear scan for each matched
> function, which is hugely inefficient, so definitely a no go
> 
> >
> >
> > jirka
> >
> > > +
> > >       err = libbpf_ensure_mem((void **) &res->addrs, &res->cap, sizeof(unsigned long),
> > >                               res->cnt + 1);
> > >       if (err)
> > > --
> > > 2.25.1
> > >
> > >

