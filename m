Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A81E55897C3
	for <lists+bpf@lfdr.de>; Thu,  4 Aug 2022 08:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbiHDGac (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Aug 2022 02:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbiHDGab (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Aug 2022 02:30:31 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0EBACE24
        for <bpf@vger.kernel.org>; Wed,  3 Aug 2022 23:30:30 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id o5-20020a17090a3d4500b001ef76490983so4532321pjf.2
        for <bpf@vger.kernel.org>; Wed, 03 Aug 2022 23:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=NVH1Rs7A0/bKqmT9u0RQNAoz8Y/3a/bqyAwoNYUWb6Y=;
        b=e7h5au89tORs3SkSBEpiGYpRfH+MgpmNORaXn3zEJ08yGIVZ5gPr/8t3cDDWaF6P/i
         NMnF0xgSMN1gqaDuqVoRhCs1VfSGSFgpyytTa51WDgN8C1k33uayyQ9DMSKtIrcK00BE
         nEm3/ZLGnuWgEBJzrOGIvT2sNR4b5QfNsrHjTBwM1F188Cc19+DkHql178lJwcIXL0kG
         tkr31t0M8SVRQZLAdEGOCnqHlRhzYTUC3x1dHpQx9ALwdr020y9FgF5gCeTmgqrqyI15
         3y1EDluW64YBY07shQVwwAxhgDygNJEhoaWI1aw2X36hdKClFnYQ7sNXha80FGvHasCi
         P7qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=NVH1Rs7A0/bKqmT9u0RQNAoz8Y/3a/bqyAwoNYUWb6Y=;
        b=pVLUgrh+XI2VRPuvJ+RdYScZKUsiT5EgGi5xqE07bSLQ6x9kQmqSHXSLcsnYorB0D+
         LsC2/+XQLr+X11T9aMUaWqCKF/u/zY29nvnVM4DTJUsNfbmEloqSdTuE9WW0EXNS1CUf
         LRyE43X+qPoJjlA/1Aj21mUJUy4fWdn7jogrfbJ9zDp7AbREtIgeAqYjGhkgZ4oMNUD+
         7y1aMqUQmw45lTCpC6F8zsE350/MeEjPz/NEyxI7+aJmhj/g+BdOzlKUvDXQoOrgFa8M
         jXIe/iavcrXTz8aXTleOB0zTPIWnlihx7feZ+BEfWTWltua2go9HvjOYItB2GQKekY37
         L9EA==
X-Gm-Message-State: ACgBeo2ILJo2s3CkdTS7fJYgAdBP6G93Bfe+kfu//Ui/F9pdUghsLEua
        Zq17JwlwqbmTW5SPKqRScac=
X-Google-Smtp-Source: AA6agR4NiAoHP6nCdbSkIaFWCdDBupaZDnxzaAnu8OzameAwFGZT32U1w1yQgc+hR6wtsEKegtEGrw==
X-Received: by 2002:a17:90a:b391:b0:1f3:6c3:392c with SMTP id e17-20020a17090ab39100b001f306c3392cmr8779904pjr.166.1659594630081;
        Wed, 03 Aug 2022 23:30:30 -0700 (PDT)
Received: from Laptop-X1 ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id e12-20020a170902784c00b0016d6d1b610fsm3143241pln.98.2022.08.03.23.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 23:30:29 -0700 (PDT)
Date:   Thu, 4 Aug 2022 14:30:24 +0800
From:   Hangbin Liu <liuhangbin@gmail.com>
To:     Quentin Monnet <quentin@isovalent.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jesper Dangaard Brouer <jbrouer@redhat.com>,
        Yauheni Kaliuta <ykaliuta@redhat.com>,
        Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Subject: Re: How about adding a name for bpftool self created maps?
Message-ID: <YutngHf+k4BGjkxf@Laptop-X1>
References: <YrEoRyty7decoMhh@Laptop-X1>
 <CACdoK4JrrVoMjvwQusdpYOO5gDqZDKky2QZqyb08p+2R1186Gw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACdoK4JrrVoMjvwQusdpYOO5gDqZDKky2QZqyb08p+2R1186Gw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jun 21, 2022 at 10:28:27PM +0100, Quentin Monnet wrote:
> Hi Hangbin,
> 
> No plan currently. Adding names has been suggested before, but it's
> not compatible with some older kernels that don't support map names
> [0]. Maybe one solution would be to probe the kernel for map name
> support, and to add a name if supported.

Hi Quentin,

I looked into this issue this week. And I have some questions.
Can we just use the probe_kern_prog_name() function directly? e.g.

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index e89cc9c885b3..f7d1580cd54e 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -4476,7 +4476,10 @@ static int probe_kern_global_data(void)
        };
        int ret, map, insn_cnt = ARRAY_SIZE(insns);

-       map = bpf_map_create(BPF_MAP_TYPE_ARRAY, NULL, sizeof(int), 32, 1, NULL);
+       if (probe_kern_prog_name() > 0)
+               map = bpf_map_create(BPF_MAP_TYPE_ARRAY, "global_data", sizeof(int), 32, 1, NULL);
+       else
+               map = bpf_map_create(BPF_MAP_TYPE_ARRAY, NULL, sizeof(int), 32, 1, NULL);
        if (map < 0) {
                ret = -errno;
                cp = libbpf_strerror_r(ret, errmsg, sizeof(errmsg));

I know the map name and prog name supports are not in the same patch. But they are
added to kernel in one patch series. I doubt any one will backport them separately.

And I also have a question about function probe_kern_prog_name(). I only
saw it created a prog with name "test". But I didn't find the function check
if the prog are really has name "test". If a old kernel doesn't support prog
name, I think it will just ignore the name field. No?

Another way I think we can use to probe if kernel supports map name is try
to attach a kprobe/bpf_obj_name_cpy. If attach success, the kernel should support
the prog/map name. WDYT?

Thanks
Hangbin
