Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2750358A884
	for <lists+bpf@lfdr.de>; Fri,  5 Aug 2022 11:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237660AbiHEJKO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Aug 2022 05:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233549AbiHEJKM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Aug 2022 05:10:12 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D3C92C3
        for <bpf@vger.kernel.org>; Fri,  5 Aug 2022 02:10:11 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id o5-20020a17090a3d4500b001ef76490983so2230629pjf.2
        for <bpf@vger.kernel.org>; Fri, 05 Aug 2022 02:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=XXtPKRU/xVeBR4eN7h6KkoP1u0xs1Ws3L4GoPNuwcPw=;
        b=GjcyS4Atah8YfULUM8Y90Yu0zOw56TfOhyKYtJXT7xQPNDgYqUcyDX2bcJYsWI6YFg
         gsARIwzz1aTruJnmF0Wdp9V5thCjtAA2Tl1eJrz7WR4CGIDC5LytU+SOIhuObHYuhzZK
         vqoq/DUAfoX+u34g9oYNlx8cin9FSqC2KWRl3DDEYRXiOYzJKQ6dH9BgCN5McX/2QZIf
         4KpVKwFqR+u2eoFyRCdlef6CUFLH86Om0q+gb7BkY43bVTWfZ3sP0LVslEv/gW98JxBO
         lUhjj0LCZgiKI8ToYA2PbyDu7cB5cDoLyZhIl9bs4oBI8LcNPBL5HEuZJOv+vQGOcTH6
         7DhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=XXtPKRU/xVeBR4eN7h6KkoP1u0xs1Ws3L4GoPNuwcPw=;
        b=DjbqT0jM09MiJCsbPqbi2PuueLDuYnUGGVzrCHKiRdKJINcV4CB5gSWEaNZK8r2msC
         4vPx5rszt8nGQr+jpNnjLSWXjaJl91dgOHFgKqllPWPvnIVEoSZjILXwQEnxuqfKVhTy
         OXRSizEneu/19PTu+POKLD6vr0iECO6deKtusLA3uaaQ73wmCRENamxEsUs6igrVlg6K
         lLGnhoPwpF+V0yn4zIgw7dc0Zdl0jgxWfiJYWA0VrM7jnU2KYwXvRYO+yj8FIoP+WdIY
         H5tJzvWRl0gr8Z0Vvsab3c7X6BJSxcsN2NSgzfhnF0t2CgJCqCGOdkx+P5GfsFD2D6fx
         pTNA==
X-Gm-Message-State: ACgBeo2HVfRDEXuxCDWhb9RsU6keCDE0Mzl0MDbKZdmrEbJoSG1qsavZ
        TbOf67UW2e5bvWJ5zDvtRRk=
X-Google-Smtp-Source: AA6agR60NqIO9o3G9V73LSCtoI7BHnt0NPnu7i9uVGXsePm+kvnoPAkhbUEaVY7QVZLDGtlLQjdrhw==
X-Received: by 2002:a17:902:eac2:b0:16d:cce2:e5c6 with SMTP id p2-20020a170902eac200b0016dcce2e5c6mr5932298pld.149.1659690610642;
        Fri, 05 Aug 2022 02:10:10 -0700 (PDT)
Received: from Laptop-X1 ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id n7-20020a170902e54700b0016c16648213sm2592971plf.20.2022.08.05.02.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 02:10:10 -0700 (PDT)
Date:   Fri, 5 Aug 2022 17:10:04 +0800
From:   Hangbin Liu <liuhangbin@gmail.com>
To:     Quentin Monnet <quentin@isovalent.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jesper Dangaard Brouer <jbrouer@redhat.com>,
        Yauheni Kaliuta <ykaliuta@redhat.com>,
        Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Subject: Re: How about adding a name for bpftool self created maps?
Message-ID: <YuzebJdw6GJ9CVLz@Laptop-X1>
References: <YrEoRyty7decoMhh@Laptop-X1>
 <CACdoK4JrrVoMjvwQusdpYOO5gDqZDKky2QZqyb08p+2R1186Gw@mail.gmail.com>
 <YutngHf+k4BGjkxf@Laptop-X1>
 <91477d69-5fe6-5815-3bba-f63764bd61e3@isovalent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91477d69-5fe6-5815-3bba-f63764bd61e3@isovalent.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Aug 04, 2022 at 11:01:48AM +0100, Quentin Monnet wrote:
> Hi! It would look much cleaner to have something specific to map names.
> It does not have to be a dedicated probe in my opinion, maybe we can
> just try loading with a name and retry if this fails with -EINVAL (a bit
> like we retry with another prog type in bpf_object__probe_loading(), if
> the first one fails). Something like this (not tested):
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 50d41815f431..abcafdf8ae7e 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -4430,7 +4430,10 @@ static int probe_kern_global_data(void)
>  	};
>  	int ret, map, insn_cnt = ARRAY_SIZE(insns);
>  
> -	map = bpf_map_create(BPF_MAP_TYPE_ARRAY, NULL, sizeof(int), 32,  1, NULL);
> +	map = bpf_map_create(BPF_MAP_TYPE_ARRAY, "global_data", sizeof(int), 32, 1, NULL);
> +	if (map < 0 && errno == EINVAL)
> +		/* Retry without name */
> +		map = bpf_map_create(BPF_MAP_TYPE_ARRAY, NULL, sizeof(int), 32, 1, NULL);
>  	if (map < 0) {
>  		ret = -errno;
>  		cp = libbpf_strerror_r(ret, errmsg, sizeof(errmsg));
> 
> (Maybe with a small wrapper, given that we'd also need this in
> probe_prog_bind_map() and probe_kern_array_mmap() as well.)

Ah, this looks more clean and easier.

> 
> > And I also have a question about function probe_kern_prog_name(). I only
> > saw it created a prog with name "test". But I didn't find the function check
> > if the prog are really has name "test". If a old kernel doesn't support prog
> > name, I think it will just ignore the name field. No?
> 
> No, "if (CHECK_ATTR(BPF_PROG_LOAD))" should fail in bpf_prog_load() in
> kernel/bpf/syscall.c, and the syscall should fail with -EINVAL.
> 
> If older kernels simply ignored the "name" field for programs and maps,
> we wouldn't have to probe or retry for the current case in the first
> place :).

Thanks for the explanation. I will try add a wrapper first.

Regards
Hangbin
