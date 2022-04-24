Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12AE550D574
	for <lists+bpf@lfdr.de>; Sun, 24 Apr 2022 23:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239695AbiDXV7x (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 24 Apr 2022 17:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239689AbiDXV7u (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 24 Apr 2022 17:59:50 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C148393E1
        for <bpf@vger.kernel.org>; Sun, 24 Apr 2022 14:56:48 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id d15so8500138plh.2
        for <bpf@vger.kernel.org>; Sun, 24 Apr 2022 14:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JVID5G8iJ2HDVlxeOqepbMha9VF/3Aa0TyqeaiqkCv8=;
        b=aF1OYFpfvKfRgbOLFTQwzmO42RQDaUhlUHGF002LIAsFcLWYGiMB7ToDyG92qeVKWN
         vO9jRXovC3jmiHyGPgzHmv7/ieQhwPKSQ3DGDbIiyyeS8WbCdmgKZOqHuqDHS6/SHxSu
         F2/KB39LCuLNgcAwBSJqolFh7NwDJV3DzHc4hbDy0XYybCft5pmXz9DEJAa5NGvrwtx5
         2Rc1i5bA2uakdKa9On6ueIWipwPLE0uDbbw1tDxkiznMD6lg8O+q3jKT8Ocu3gxE3N3S
         UWNSGhbpi3mT2wofUvdJ3dYDfde9tnrn52UA4H9sulwKfzhcQWgfCpHQFiZbnWwpggun
         4RBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JVID5G8iJ2HDVlxeOqepbMha9VF/3Aa0TyqeaiqkCv8=;
        b=lOCFBWqCNY/yJ9MZV7zHWmZpV9P0ageKiG5zqw2+Ccj9nRSrpJeg8GUzZYCVbVjKzH
         EPejuqjANk8vyc3fRk+BIgvG6AZqrQg/xP9JyfwftQ3e76GCug+2NuttitBZyaHMVCuh
         xBOCzgmcA3uJMxgPoI/BTC74lbMceH3GZ8fz38E+tPN1LwtaOLYzhpAVxs0XJVDYm+vO
         yaMNlyxPg3e3eLsRD8Z5gvSg4Xyz1YOKGu0HF3o1zjgr3IAtwyDl3DVdYxuIUv+WykI9
         A6EwFiiAL2diEqzB3yGoOeYgdNVu088I1VJvNj2yVEL2ngx9WK0SKxRz9zinS3Vun7XU
         TH+g==
X-Gm-Message-State: AOAM533fnFTKCSL6GyWflcQtbGg23tX7mTWhv9BGgsF4h9mMWu6x3JHs
        c/ToZMLJYx/yfxwVkcjA9FQ=
X-Google-Smtp-Source: ABdhPJyhuiSmu9K2VZu0fhxOgHEhxcxvR7s4ZGWMkSdNAakvr/vdP2jzwjrbvhG1WSwJLcTTsR6reA==
X-Received: by 2002:a17:903:94:b0:15c:f928:a373 with SMTP id o20-20020a170903009400b0015cf928a373mr6116498pld.26.1650837408060;
        Sun, 24 Apr 2022 14:56:48 -0700 (PDT)
Received: from localhost ([157.49.66.127])
        by smtp.gmail.com with ESMTPSA id e6-20020a17090a77c600b001cd4989fedcsm12667862pjs.40.2022.04.24.14.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 14:56:47 -0700 (PDT)
Date:   Mon, 25 Apr 2022 03:27:05 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Joanne Koong <joannelkoong@gmail.com>,
        Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [PATCH bpf-next v5 04/13] bpf: Tag argument to be released in
 bpf_func_proto
Message-ID: <20220424215705.y62y5277nuk6kiex@apollo.legion>
References: <20220415160354.1050687-1-memxor@gmail.com>
 <20220415160354.1050687-5-memxor@gmail.com>
 <20220421041954.3hdxqu7zcxfhiecs@MBP-98dd607d3435.dhcp.thefacebook.com>
 <20220421193808.iojehohmhvrcssjb@apollo.legion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421193808.iojehohmhvrcssjb@apollo.legion>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 22, 2022 at 01:08:08AM IST, Kumar Kartikeya Dwivedi wrote:
> On Thu, Apr 21, 2022 at 09:49:54AM IST, Alexei Starovoitov wrote:
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index c802e51c4e18..97f88d06f848 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -245,6 +245,7 @@ struct bpf_call_arg_meta {
> > >  	struct bpf_map *map_ptr;
> > >  	bool raw_mode;
> > >  	bool pkt_access;
> > > +	u8 release_regno;
> > >  	int regno;
> >
> > release_regno and regno are always equal.
> > Why go with u8 instead of bool flag?
> >
>
> Didn't realise that. I will change it.
>

Actually, I think regno may not equal release_regno. It is set by by
check_stack_range_initialized only when meta->raw_mode is true, along with
meta.access_size. So I skipped this change in v6.

--
Kartikeya
