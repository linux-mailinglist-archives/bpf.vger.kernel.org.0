Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 303496A8D09
	for <lists+bpf@lfdr.de>; Fri,  3 Mar 2023 00:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjCBXaG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Mar 2023 18:30:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjCBXaG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Mar 2023 18:30:06 -0500
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D8F031E08
        for <bpf@vger.kernel.org>; Thu,  2 Mar 2023 15:29:32 -0800 (PST)
Received: by mail-qt1-f174.google.com with SMTP id c18so1135176qte.5
        for <bpf@vger.kernel.org>; Thu, 02 Mar 2023 15:29:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677799767;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4bJWFiYgIDoi4kgxxj4csexG5LyekVepEYy3dL9UGgg=;
        b=kBpkNMUTgz6o3X3K4jGTH+rZOLcdfzJxCAbcejOJjf57MGnRbONKITGKHEM4kVBFKg
         VYzGVghOXnN4vwJId1EtXJl91m4/MPJqoJCy5JzDSYn7zNGR+zAvrx+2Agv7NrgyYInM
         BCDQdUCxyvgRaJK2xc0lxOB9r5s0N4OFNdNyeR2f5kXcpb9STAjGCPwaoqOVoJG1MOxz
         3XerNGl4on9RIkWk93EO6PUAjCv1tC8Gc35pgVTaqz7zHenGM9FLx1a9Ecu/jUtBpEhT
         FTcVajCyL1UinXInAFqgv8CjL4Erujg5B8c0Sx1/tmZzGOK6Pdtpu4jkBmQTnHAm1yX9
         1pFg==
X-Gm-Message-State: AO0yUKWTf6E5fcqv1uYcBSX9/XrghV1uFFLY2yk0VBvibgWu9LZvKZHl
        12o3xKb+BPOhFRTZGaq1RZACCEYRMNHISAMk
X-Google-Smtp-Source: AK7set9XVC60ivNtmsaavECp06mxzrFUCRRb2RvpCsOP7UUWt1B5a7NX8lkpzRQCd9JNjGXIIN9ACw==
X-Received: by 2002:a05:622a:11d6:b0:3bf:d35d:98bb with SMTP id n22-20020a05622a11d600b003bfd35d98bbmr21303242qtk.56.1677799766860;
        Thu, 02 Mar 2023 15:29:26 -0800 (PST)
Received: from maniforge ([2620:10d:c091:480::1:5ba])
        by smtp.gmail.com with ESMTPSA id q17-20020ac84111000000b003bfa52112f9sm672861qtl.4.2023.03.02.15.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 15:29:25 -0800 (PST)
Date:   Thu, 2 Mar 2023 17:29:23 -0600
From:   David Vernet <void@manifault.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Dave Marchevsky <davemarchevsky@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH bpf-next] selftests/bpf: Add -Wuninitialized flag to bpf
 prog flags
Message-ID: <ZAExU+aiCmOt2Flp@maniforge>
References: <20230302231924.344383-1-davemarchevsky@fb.com>
 <CAADnVQJV_yQ23EeFuuHC+AvoxgVLVKZvaYkWfzhk=z3kxWHmHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJV_yQ23EeFuuHC+AvoxgVLVKZvaYkWfzhk=z3kxWHmHA@mail.gmail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 02, 2023 at 03:23:22PM -0800, Alexei Starovoitov wrote:
> On Thu, Mar 2, 2023 at 3:19 PM Dave Marchevsky <davemarchevsky@fb.com> wrote:
> >
> > --- a/tools/testing/selftests/bpf/progs/rbtree_fail.c
> > +++ b/tools/testing/selftests/bpf/progs/rbtree_fail.c
> > @@ -232,8 +232,9 @@ long rbtree_api_first_release_unlock_escape(void *ctx)
> >
> >         bpf_spin_lock(&glock);
> >         res = bpf_rbtree_first(&groot);
> > -       if (res)
> > -               n = container_of(res, struct node_data, node);
> > +       if (!res)
> > +               return -1;
> 
> The verifier cannot be ok with this return... I hope...

This is a negative testcase which correctly fails, though the error
message wasn't what I was expecting to see:

__failure __msg("rbtree_remove node input must be non-owning ref")

Something about the lock still being held seems much more intuitive.

> 
> > +       n = container_of(res, struct node_data, node);
> >         bpf_spin_unlock(&glock);
