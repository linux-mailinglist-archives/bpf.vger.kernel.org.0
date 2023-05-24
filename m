Return-Path: <bpf+bounces-1150-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC9070EE6F
	for <lists+bpf@lfdr.de>; Wed, 24 May 2023 08:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C94C028115F
	for <lists+bpf@lfdr.de>; Wed, 24 May 2023 06:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81EFE1FC2;
	Wed, 24 May 2023 06:48:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF3B15D2
	for <bpf@vger.kernel.org>; Wed, 24 May 2023 06:48:02 +0000 (UTC)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8CCD10EB
	for <bpf@vger.kernel.org>; Tue, 23 May 2023 23:47:34 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f607839b89so4967705e9.3
        for <bpf@vger.kernel.org>; Tue, 23 May 2023 23:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684910850; x=1687502850;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hAUcdovUZ34LewVomk1G54xS7H/kGPFBviNRXNtl+HQ=;
        b=P9nvhFeiworIIVT4kdxN6BLNpfijxODGC01sGw45U5E7PNN272i3fdgLzpHgJETb6D
         cUoZvUVAR66DyCX6tSv+ItekT/gusQ8gR4MfwZhKt9+KMBe3Do+gRFN15sj3mduRlWQM
         4n0BFsAyrROw8hOOJ4ee8VxjPC6lSG957PN4HlbIAOeFlnODIojyLHku9lBwoIA2Gmx3
         X6RDNanDVpkSt/jDANLtgzBPdB+6v7wTH1HCN+9nsx8K6dubTPu+HYTcKZU+3aMSK5ZN
         czbpiOR4eIQhiKj4C58UKgWupmECTxYblFj9f5Fv98X0A6NSHdXwAEBIKd26fQQfAoms
         Hp4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684910850; x=1687502850;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hAUcdovUZ34LewVomk1G54xS7H/kGPFBviNRXNtl+HQ=;
        b=gKAeg7Zd4NnHU6QaGRYZJcV+XPkVvyOqheIZvaMKWaNFcjJ5CjfHhUErNcAfZqIiLQ
         It4+4ZJxaIDkzriDRR2HHh+M9xhyiuSsxBPgkqqAm1JtvmKHiBYZOfZlCgiKBnSXzJ/k
         6BpYsScwS5En0PJ02fl+tTs7V0If7NH0e32lOJeC1j9hHoFqVCOSQMsD5e6FC9OFnnL1
         oewqpnLqortWehLXwBOdv0uBkZyzu1uVXXvRAf5pLRjms8LCRk1iH4HUMoouEbeA9WpX
         rvwOLL9Pd3Vkh98eVze18ZZuTAbx4Rt3e6/CbpUG1q1cM2qKCOGjwoEPD2tED4GhpvRE
         mm1Q==
X-Gm-Message-State: AC+VfDyyYc5eL6oAWIbNh/KouKCAxxFM/60GEgmMKvhMy+LJaEljda1/
	3B8rs8lR4X9uTPIprZm3lBY=
X-Google-Smtp-Source: ACHHUZ6RLwdxbiwgU/AxSs+rpNQM0eLdBVxPe0ByN6rjGwIb7OwVTWI1HR/QnDosc03WypYsiGa0iw==
X-Received: by 2002:a05:600c:2312:b0:3f6:832:aae7 with SMTP id 18-20020a05600c231200b003f60832aae7mr5259474wmo.25.1684910850080;
        Tue, 23 May 2023 23:47:30 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id l14-20020a7bc44e000000b003f60514bdd7sm1250829wmi.4.2023.05.23.23.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 23:47:29 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 24 May 2023 08:47:27 +0200
To: Jackie Liu <liu.yun@linux.dev>
Cc: Jiri Olsa <olsajiri@gmail.com>, andrii@kernel.org, martin.lau@linux.dev,
	song@kernel.org, yhs@fb.com, bpf@vger.kernel.org,
	liuyun01@kylinos.cn
Subject: Re: [PATCH] libbpf: kprobe.multi: Filter with blacklist and
 available_filter_functions
Message-ID: <ZG2y/zBhk4hnUfSg@krava>
References: <20230523132547.94384-1-liu.yun@linux.dev>
 <ZGznHMU1uhdPnE/F@krava>
 <f3b21f27-a284-a42c-8636-181e24c325fd@linux.dev>
 <eab45de6-f5cd-c500-e6b7-940540fa047a@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eab45de6-f5cd-c500-e6b7-940540fa047a@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, May 24, 2023 at 09:19:48AM +0800, Jackie Liu wrote:
> Hi Jiri.
> 
> 在 2023/5/24 09:03, Jackie Liu 写道:
> > Hi Jiri.
> > 
> > 在 2023/5/24 00:17, Jiri Olsa 写道:
> > > On Tue, May 23, 2023 at 09:25:47PM +0800, Jackie Liu wrote:
> > > > From: Jackie Liu <liuyun01@kylinos.cn>
> > > > 
> > > > When using regular expression matching with "kprobe multi", it scans all
> > > > the functions under "/proc/kallsyms" that can be matched.
> > > > However, not all
> > > > of them can be traced by kprobe.multi. If any one of the functions fails
> > > > to be traced, it will result in the failure of all functions. The best
> > > > approach is to filter out the functions that cannot be traced to ensure
> > > > proper tracking of the functions.
> > > > 
> > > > But, the addition of these checks will frequently probe whether
> > > > a function
> > > > complies with "available_filter_functions" and ensure that it
> > > > has not been
> > > > filtered by kprobe's blacklist. As a result, it may take a longer time
> > > > during startup. The function implementation is referenced from BCC's
> > > > "kprobe_exists()"
> > > > 
> > > > Here is the test eBPF program [1].
> > > > [1] https://github.com/JackieLiu1/ketones/commit/a9e76d1ba57390e533b8b3eadde97f7a4535e867
> > > > 
> > > > Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
> > > > ---
> > > >   tools/lib/bpf/libbpf.c | 47 ++++++++++++++++++++++++++++++++++++++++++
> > > >   1 file changed, 47 insertions(+)
> > > > 
> > > > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > > > index ad1ec893b41b..6a201267fa08 100644
> > > > --- a/tools/lib/bpf/libbpf.c
> > > > +++ b/tools/lib/bpf/libbpf.c
> > > > @@ -10421,6 +10421,50 @@ struct kprobe_multi_resolve {
> > > >       size_t cnt;
> > > >   };
> > > > +static bool filter_available_function(const char *name)
> > > > +{
> > > > +    char addr_range[256];
> > > > +    char sym_name[256];
> > > > +    FILE *f;
> > > > +    int ret;
> > > > +
> > > > +    f = fopen("/sys/kernel/debug/kprobes/blacklist", "r");
> > > > +    if (!f)
> > > > +        goto avail_filter;
> > > > +
> > > > +    while (true) {
> > > > +        ret = fscanf(f, "%s %s%*[^\n]\n", addr_range, sym_name);
> > > > +        if (ret == EOF && feof(f))
> > > > +            break;
> > > > +        if (ret != 2)
> > > > +            break;
> > > > +        if (!strcmp(name, sym_name)) {
> > > > +            fclose(f);
> > > > +            return false;
> > > > +        }
> > > > +    }
> > > > +    fclose(f);
> > > 
> > > so available_filter_functions already contains all traceable symbols
> > > for kprobe_multi/fprobe
> > > 
> > > kprobes/blacklist is kprobe specific and does not apply to fprobe,
> > > is there a crash when attaching function from kprobes/blacklist ?
> > 
> > No, I haven't got crash before, Simply because BCC's kprobe_exists has
> > implemented it so I added this, Yes, I also don't think
> > kprobes/blacklist will affect FPROBE, so I will remove it.
> > 
> > > 
> > > > +
> > > > +avail_filter:
> > > > +    f =
> > > > fopen("/sys/kernel/debug/tracing/available_filter_functions",
> > > > "r");
> > > > +    if (!f)
> > > > +        return true;
> > > > +
> > > > +    while (true) {
> > > > +        ret = fscanf(f, "%s%*[^\n]\n", sym_name);
> > > > +        if (ret == EOF && feof(f))
> > > > +            break;
> > > > +        if (ret != 1)
> > > > +            break;
> > > > +        if (!strcmp(name, sym_name)) {
> > > > +            fclose(f);
> > > > +            return true;
> > > > +        }
> > > > +    }
> > > > +    fclose(f);
> > > > +    return false;
> > > > +}
> > > > +
> > > >   static int
> > > >   resolve_kprobe_multi_cb(unsigned long long sym_addr, char sym_type,
> > > >               const char *sym_name, void *ctx)
> > > > @@ -10431,6 +10475,9 @@ resolve_kprobe_multi_cb(unsigned long
> > > > long sym_addr, char sym_type,
> > > >       if (!glob_match(sym_name, res->pattern))
> > > >           return 0;
> > > > +    if (!filter_available_function(sym_name))
> > > > +        return 0;
> > > 
> > > I think it'd be better to parse available_filter_functions directly
> > > for kprobe_multi instead of filtering out kallsyms entries
> > > 
> > > we could add libbpf_available_filter_functions_parse function with
> > > similar callback to go over available_filter_functions file
> > > 
> > 
> > Sure, if available_filter_functions not found, fallback to /proc/kallsyms.
> > 
> 
> Um.
> 
> It is difficult to judge available_filter_functions directly, because we
> not only need the function name, but also obtain its address and other
> information, but we can indeed obtain the function set from
> available_filter_functions first, and then obtain the function address
> from /proc/kallsyms. which will be slightly faster than reading
> available_filter_functions later, because if this function does not
> exist in available_filter_functions, it will take a long time to read
> the entire file.
> 
> Of course, it would be better if the kernel directly provided an
> available_filter_functions -like file containing function address
> information.

you don't need to resolve symbols, you can pass just array of symbols
to create kprobe_multi link and they will get resolved in kernel:

	struct bpf_link_create_opts {

			struct {
				__u32 flags;
				__u32 cnt;
		--->		const char **syms;
				const unsigned long *addrs;
				const __u64 *cookies;
			} kprobe_multi;
	}

I resolved the symbols in bpf_program__attach_kprobe_multi_opts mostly
because the address was available right away when parsing kallsyms,
but passing just symbols for pattern is fine

jirka

