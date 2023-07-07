Return-Path: <bpf+bounces-4455-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B61C174B57A
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 18:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCC221C21028
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 16:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB2311199;
	Fri,  7 Jul 2023 16:57:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912D0D511
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 16:57:56 +0000 (UTC)
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1454E171D
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 09:57:55 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-6826902bc8dso4584558b3a.1
        for <bpf@vger.kernel.org>; Fri, 07 Jul 2023 09:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688749074; x=1691341074;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=T8kfXm2/W74B4zGPxoyUW11PQqOgj8MhgRjbVw9AImg=;
        b=mNGL9eTYdMsq+LURUt5eBgtvWnohTWqHeLUTVaVHmwEgtsySYbFd91gLrQrnBFFDgW
         IHlFTIYZcjpn26R3cv4CEAvrz1ul83FTamN/ukFEMhWUutBsVzC0zWeUs+c0yodE2PFC
         kgv04pRZ24D6NvXIxMGzevSqr8UiI9ldB7BgNMUmnkDo9WSqR0nsZK5wtg9hEvs0pzao
         a0BK2sPsDqLU009+4lDRyaM+53JRPG2yRYkFeBT/N7tAujfn5kWMa2s5C3zxYh0QvsNN
         qF0/pQjbM22JA1iHYj6UB63WK/aMYmv9VD00bzN9hp3tQgbSFQWlUz3fYJMhPdMj/m+F
         hCzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688749074; x=1691341074;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T8kfXm2/W74B4zGPxoyUW11PQqOgj8MhgRjbVw9AImg=;
        b=la7JnRGUwDvoKCMsQZKFk3fCfUE/jBJLhmxA026CAkqC9WLRmZT/4g+16b0qgxdiMS
         HrcvMWo5/3s+/jUSfiYMVIMyTRoccl5UtyXWX5bS7NxYtiy61JE2AY6XoQhNYsk+XXxH
         GLjBvwC1YZpqopiBb2tSEk9OvqgU57fk4yr9hXh4LjEObsviudxjDWCtjIM1aUac2w2z
         4M3IpLi52DAxSKjpwW5PsLN+u1n1Y3LmStzJpOuB1jPpRRl1rUkbGxcXH6561GrAEc7+
         WVW6QbcN8A1H+o5BjO39hacKjmg/rxQDAJ17A5IItoVBe4BSnDwWOfK50zV3WQmdtVIB
         /DLw==
X-Gm-Message-State: ABy/qLY7BgDd3ftJnC0bXh0R1hZ8cZepMWyNNd/+NModi4ZwOcIhrOoe
	Dk6Cl9VwGSKhAbBCGu75ExFhMBw=
X-Google-Smtp-Source: APBJJlGW5xvGodePp4EGgD63HeAi4mU4GzzBnZjwPfWwIZH5pTIeS5ZQxjYWlIQteGJJYSB5gokwIlk=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6a00:39a6:b0:676:20f8:be57 with SMTP id
 fi38-20020a056a0039a600b0067620f8be57mr8183036pfb.0.1688749074558; Fri, 07
 Jul 2023 09:57:54 -0700 (PDT)
Date: Fri, 7 Jul 2023 09:57:52 -0700
In-Reply-To: <32d67707-b831-9a98-4cb9-fcb27c8806ef@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <bd1477f2-a51e-a795-4f25-a32d6ab46530@gmail.com>
 <ZKcE+wMWGdVFSBX2@google.com> <32d67707-b831-9a98-4cb9-fcb27c8806ef@gmail.com>
Message-ID: <ZKhEEJfzCyYI7BfH@google.com>
Subject: Re: [PATCH v2] samples/bpf: Add more instructions to build
 dependencies and, configuration in README.rst
From: Stanislav Fomichev <sdf@google.com>
To: Anh Tuan Phan <tuananhlfc@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, 
	linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 07/07, Anh Tuan Phan wrote:
> 
> 
> On 7/7/23 01:16, Stanislav Fomichev wrote:
> > On 07/06, Anh Tuan Phan wrote:
> >> Update the Documentation to mention that some samples require pahole
> >> v1.16 and kernel built with CONFIG_DEBUG_INFO_BTF=y
> >>
> >> Signed-off-by: Anh Tuan Phan <tuananhlfc@gmail.com>
> >> ---
> >>  samples/bpf/README.rst | 7 +++++++
> >>  1 file changed, 7 insertions(+)
> >>
> >> diff --git a/samples/bpf/README.rst b/samples/bpf/README.rst
> >> index 57f93edd1957..631592b83d60 100644
> >> --- a/samples/bpf/README.rst
> >> +++ b/samples/bpf/README.rst
> >> @@ -14,6 +14,9 @@ Compiling requires having installed:
> >>  Note that LLVM's tool 'llc' must support target 'bpf', list version
> >>  and supported targets with command: ``llc --version``
> >>
> >> +Some samples require pahole version 1.16 as a dependency. See
> >> +https://docs.kernel.org/bpf/bpf_devel_QA.html for reference.
> >> +
> > 
> > Any reason no to add pahole 1.16 to this section above?
> >> Compiling requires having installed:
> >  * clang >= version 3.4.0
> >  * llvm >= version 3.7.1
> >  * pahole >= version 1.16
> > 
> > Although clang 3.4 probably won't get you anywhere these days. The
> > whole README seems a bit outdated :-)
> >
> 
> Put pahole requirement as your idea is better, thanks for suggestion.
> Will update it and clang version as well. For clang version, I think I
> can update min version as 11.0.0 (reference from
> https://www.kernel.org/doc/html/next/process/changes.html). Do you see
> any other potential outdated things in this document? I follow the above
> steps and it help me compile the sample code successfully.

Maybe we can reference that doc instead here? Otherwise that copy-pasted
11.0.0 will also get old. Just mention here that we need
clang/llvm/pahole to compile the samples and for specific versions
put a link to process/changes.rst
 
> >>  Clean and configuration
> >>  -----------------------
> >>
> >> @@ -28,6 +31,10 @@ Configure kernel, defconfig for instance::
> >>
> >>   make defconfig
> >>
> >> +Some samples require support for BPF Type Format (BTF). To enable it,
> >> open the
> >> +generated config file, or use menuconfig (by "make menuconfig") to
> >> enable the
> >> +following configs: CONFIG_BPF_SYSCALL and CONFIG_DEBUG_INFO_BTF.
> >> +
> > 
> > This is usually enabled by default, so why special case it here?
> > Maybe, if you want some hints about the config, we should add
> > a reference to tools/testing/selftests/bpf/config ?
> > 
> 
> The config CONFIG_DEBUG_INFO_BTF is disabled for some distros at least
> for mine. I ran "make defconfig" and it's not enabled by default so I
> think it worth to mention it here to help novice get started. I'll
> update it to reference to tools/testing/selftests/bpf/config .
> 
> >>  Kernel headers
> >>  --------------
> >>
> >> -- 
> >> 2.34.1

