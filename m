Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC63A62C8EB
	for <lists+bpf@lfdr.de>; Wed, 16 Nov 2022 20:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234181AbiKPT0m (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Nov 2022 14:26:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234154AbiKPT0l (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Nov 2022 14:26:41 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96DAA58BE5
        for <bpf@vger.kernel.org>; Wed, 16 Nov 2022 11:26:40 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id w23so10925273ply.12
        for <bpf@vger.kernel.org>; Wed, 16 Nov 2022 11:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RijC22/SdwWwg/bVfJzaGWhRZ22gyvsY9MCYb3HpSxY=;
        b=WQddw7AQUG58WBNwtzFfChA6jc5qW8cC0yityyraiaiSt71wJQ8GsDoEZOoBRmp3MZ
         Tr4YLCLhGsNc5wqaWjb5aC2QDWh87piwicrRRhdh1w7X76luhS02KBieKcG7DA9wLjYV
         RJCn/iGsRHkslnIFGtBC6En/Ibg/VOzx/fJk8opvWY7TBSTEnvszEcMzsu8nvprRIeKx
         ANOb9Uf3699OL/Jhrf06cezPYP4/YfF9EcyBAeZOslsDiRRD4uiBgoJsMiYohqNIMf8m
         qCP1Cg2XQFTecvrA/bqnWnWg3oaHrlc1aVM+wA76XwYw9gAxiL5+uswFoVbxZQzp42JR
         XWfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RijC22/SdwWwg/bVfJzaGWhRZ22gyvsY9MCYb3HpSxY=;
        b=2Tlr2dAfi33U7rY9o9LOuBrNZ/8sdkpNHXRhJSNZQIDUjt7jK3QVtlCPfi0cUpsph4
         BRsuAMDDPTxTL9LawZsL0cxaV4seZifd9dNlRCVCHjQQ/S6eyagQApg4XZ4SrnUOlgTc
         si+2zr58ihtED4QBaHPsUktFZQUS+hXh2yoEoFmGJYgsR4DDhLbJcHYb2OfsbANGqipX
         M3yQiWHLJ1Jaerzx10WvpKPv6HfXjLrReYH+Tq47l2IuP/lgNSWq0UjzwJoCJ7kzlpV/
         wdNkqt4h5qX8qM9pmSTqPa0PUYUTEMF7Isw78VEff01TK4L1QK2f5+q65mKh6DULq1Ht
         JeJg==
X-Gm-Message-State: ANoB5pm2jUXWdGzTklkV60pSQ+GoT9mKBMdTJ9cJJ+ev7EuADA1pGEjD
        nXwXYSZAOPa3CjyaylL/NCCLoM/D1W0f13tr2TPy
X-Google-Smtp-Source: AA0mqf7am7h9iKe0yzgEn70nyDj/uDKD9TXuJUVccZD5sBXsE9AtUSPcexgIiBTALKY70i6fsFyrnq2E3b+srOvIGsE=
X-Received: by 2002:a17:902:be04:b0:17b:4ace:b67f with SMTP id
 r4-20020a170902be0400b0017b4aceb67fmr10827665pls.12.1668626800083; Wed, 16
 Nov 2022 11:26:40 -0800 (PST)
MIME-Version: 1.0
References: <20221115175652.3836811-1-roberto.sassu@huaweicloud.com>
 <20221115175652.3836811-3-roberto.sassu@huaweicloud.com> <CAHC9VhQjtU0DFoVGav-nBh-09QXh+X=Cf8RgJz6nAjvcyNQ-5A@mail.gmail.com>
 <dd9215b603d9ff511c5c23998b4597b0eb55f0a7.camel@huaweicloud.com>
In-Reply-To: <dd9215b603d9ff511c5c23998b4597b0eb55f0a7.camel@huaweicloud.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 16 Nov 2022 14:26:29 -0500
Message-ID: <CAHC9VhQU+L1djE2xEGx2frPBqx5OPcbxWDSEpeoFTH01+rj76g@mail.gmail.com>
Subject: Re: [RFC][PATCH 2/4] lsm: Add missing return values doc in
 lsm_hooks.h and fix formatting
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, revest@chromium.org,
        jackmanb@chromium.org, jmorris@namei.org, serge@hallyn.com,
        bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 16, 2022 at 3:07 AM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> On Tue, 2022-11-15 at 21:23 -0500, Paul Moore wrote:
> > On Tue, Nov 15, 2022 at 12:57 PM Roberto Sassu
> > <roberto.sassu@huaweicloud.com> wrote:
> > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > >
> > > Ensure that for non-void LSM hooks there is a description of the return
> > > values. Also replace spaces with tab for indentation, remove empty lines
> > > between the hook description and the list of parameters and add the period
> > > at the end of the parameter description.
> > >
> > > Finally, replace the description of the sb_parse_opts_str hook, which was
> > > removed with commit 757cbe597fe8 ("LSM: new method: ->sb_add_mnt_opt()"),
> > > with one for the new hook sb_add_mnt_opt.
> > >
> > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > ---
> > >  include/linux/lsm_hooks.h | 123 ++++++++++++++++++++++++++------------
> > >  1 file changed, 86 insertions(+), 37 deletions(-)
> >
> > ...
> >
> > > diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> > > index f40b82ca91e7..c0c570b7eabd 100644
> > > --- a/include/linux/lsm_hooks.h
> > > +++ b/include/linux/lsm_hooks.h
> > > @@ -176,18 +183,22 @@
> > >   *     Set the security relevant mount options used for a superblock
> > >   *     @sb the superblock to set security mount options for
> > >   *     @opts binary data structure containing all lsm mount data
> > > + *     Return 0 on success, error on failure.
> > >   * @sb_clone_mnt_opts:
> > >   *     Copy all security options from a given superblock to another
> > >   *     @oldsb old superblock which contain information to clone
> > >   *     @newsb new superblock which needs filled in
> > > - * @sb_parse_opts_str:
> > > - *     Parse a string of security data filling in the opts structure
> > > - *     @options string containing all mount options known by the LSM
> > > - *     @opts binary data structure usable by the LSM
> > > + *     Return 0 on success, error on failure.
> > > + * @add_mnt_opt:
> > > + *     Add a new mount option @option with value @val and length @len to the
> > > + *     existing mount options @mnt_opts.
> > > + *     Return 0 if the option was successfully added, a negative value
> > > + *     otherwise.
> >
> > I really appreciate the effort to improve the LSM hook comments/docs,
> > but the "sb_add_mnt_opt" hook was removed in 52f982f00b22
> > ("security,selinux: remove security_add_mnt_opt()").
>
> Right, sorry, didn't notice.

No problem.  I just wanted to make it clear that I really like this
patch, and if you can fix the above and double-check the others I'll
gladly merge this.  As a general rule I *love* doc improvements :)

-- 
paul-moore.com
