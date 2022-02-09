Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5E464AE686
	for <lists+bpf@lfdr.de>; Wed,  9 Feb 2022 03:39:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238072AbiBICjV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Feb 2022 21:39:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241624AbiBIBAE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Feb 2022 20:00:04 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F0BC061576
        for <bpf@vger.kernel.org>; Tue,  8 Feb 2022 17:00:02 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id a39so588893pfx.7
        for <bpf@vger.kernel.org>; Tue, 08 Feb 2022 17:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FNyK/Yg2ceJAs3bwKtsz0CaulH5OYozmnJwt0yar5z0=;
        b=oVzcCuywFDuZ2puv9r4H34mXMYDfmJCzP+kuYegGSbzjd9HWZo8+4SCLduvQaMw6B5
         H4jV2Hh7mgl/LzAUHyoOWW+aDn5FB28bsPhsJbX9C5ruDuMKHC5UvfwZfkra0U/XgYPE
         hhI7qQ+riK83u7Sq5il8hHvtTN2i1YChDCr9kwe4/HmhtH91qPkt+XIQLrptrnFgDm6E
         SQFsqKeBPoJtnZTL7Z1j3VojD2p6n7tFqtyoPacPM2kkfE5VbHQcoAYy7PyI+XPbSDP9
         wg7iousP7p9tyPmhJKGbVbDR5Zn2SyzV9r5sUcHTob31Vo4I8i6nifG6DdT00HWZX81X
         L5BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FNyK/Yg2ceJAs3bwKtsz0CaulH5OYozmnJwt0yar5z0=;
        b=rmr/s9cJt2phH+NmO46gfbXUKZ8kXGkUnPjY8ZOLvDYrHG+bTeyFJK+l2PgIQqx1Rr
         l8rSQ60ZU7D6FvB66rPRGTn72QOHx41zCxEtMgWE1XWUHpuVyqQTuNj4eujS3YmMtLP7
         wpEpz+kZ4LNVDsM9P8G0F/bnSTfNB/oScScsbdLt9p3y/Hz/s7Hht9YSuYN43bw5nUH1
         MjL7vKGA5UzJJld9wu62g+V1P0HQnKtodoaURf2hUw0evufP21WNFKjac1SdQkXexSRZ
         g6IgpJCOgMjA1EMTnPYgHHzu4fmiXL8ihOHZDM+lXpGvhXtMx75/6of4ihBkZ4amxC0G
         2gag==
X-Gm-Message-State: AOAM531vO2ragfMZyNgON0EYSP7FelTn9WkS+eKp1ApDnMVJ7xdvggoz
        e+awANcJ4SPjn5XgypI1iMg=
X-Google-Smtp-Source: ABdhPJxZAYgYiMl/vjEnbyP0mxhVbQFtMIMW3rvyTZuH50EgV8t1CSKH+EpiG1vlXy7AAMvLo7jMpQ==
X-Received: by 2002:a62:1ace:: with SMTP id a197mr5960390pfa.63.1644368401787;
        Tue, 08 Feb 2022 17:00:01 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:cbf])
        by smtp.gmail.com with ESMTPSA id w12sm5992846pgl.64.2022.02.08.17.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 17:00:01 -0800 (PST)
Date:   Tue, 8 Feb 2022 16:59:59 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     davem@davemloft.net, daniel@iogearbox.net, andrii@kernel.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 bpf-next 5/5] bpf: Convert bpf_preload.ko to use light
 skeleton.
Message-ID: <20220209005959.lj5xfgzouuvjum4j@ast-mbp.dhcp.thefacebook.com>
References: <20220208191306.6136-1-alexei.starovoitov@gmail.com>
 <20220208191306.6136-6-alexei.starovoitov@gmail.com>
 <9ec1f118-4e71-f78b-20d4-a4c49904e2a8@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ec1f118-4e71-f78b-20d4-a4c49904e2a8@fb.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 08, 2022 at 04:53:38PM -0800, Yonghong Song wrote:
> > -	err = fork_usermode_driver(&umd_ops.info);
> > +	skel = iterators_bpf__open();
> > +	if (!skel)
> > +		return -ENOMEM;
> > +	err = iterators_bpf__load(skel);
> >   	if (err)
> 
> We can do iterators_bpf__open_and_load here, right?

Right. It does __open and __load separately, so it's easier
to insert debug printk and adjust rodata for testing.
