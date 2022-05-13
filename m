Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBFCF5258F0
	for <lists+bpf@lfdr.de>; Fri, 13 May 2022 02:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359423AbiEMAUu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 May 2022 20:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359168AbiEMAUt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 May 2022 20:20:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A122B1C923
        for <bpf@vger.kernel.org>; Thu, 12 May 2022 17:20:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 35A14B82BCE
        for <bpf@vger.kernel.org>; Fri, 13 May 2022 00:20:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E43B7C385B8
        for <bpf@vger.kernel.org>; Fri, 13 May 2022 00:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652401242;
        bh=oSdJDCeMTngMwdRoq1ZeEVJ84wpC22I6hhXqa6YehP4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=D7mkeWqPmtP+u7cqJXOwR5HgzpW1wstEA0cZOfQ7j9RE/yRF7kiF94gxcIXXcZIo4
         N+Evk4+1URkaXj2vyR1fa+Poqqirs2NvqIyIZpgiN1FegazmSfONL9MM1SxC2pqkQV
         FGssMGq3Z66gudpr5Fny6jG3y2/MwiZjpxirLGJ+KEcx3WsUpy/ofJjoN436AWFd8t
         7JOxjU76HgE9RzAdr+LFNIDTDkjY8DIHr3mFn2gKzrEnqg7+TMNYON3mmWh6mLw49o
         +LIQOvskviC/k5jIqJBnhDgkcgmShjergOjJ9iFxvXB5oBXGmmPKBAzM0otGHngqCE
         QgvHDJ88oerdg==
Received: by mail-lf1-f54.google.com with SMTP id t25so11819083lfg.7
        for <bpf@vger.kernel.org>; Thu, 12 May 2022 17:20:42 -0700 (PDT)
X-Gm-Message-State: AOAM5308G7IONzlMllkXbL25PhQ2Rw1vHvtfolfnv+2M8yATAm3qjBms
        EekmqygKBh9kiFtL1omcknSYWTMV6dFZP2VJ63+usQ==
X-Google-Smtp-Source: ABdhPJyOzxxaIWz+eEoh70X0nx4Xt+WEqw1O7tLrPxh7UhHNbs7+iWK5hs1BAqBNUmrPyktNdhvDtwhINKtBWjn3lJ4=
X-Received: by 2002:a05:6512:1293:b0:474:d347:81a5 with SMTP id
 u19-20020a056512129300b00474d34781a5mr1579505lfs.649.1652401240944; Thu, 12
 May 2022 17:20:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220512165051.224772-1-kpsingh@kernel.org> <20220512165051.224772-2-kpsingh@kernel.org>
 <CAADnVQJwB4R=8yasfaLLftx_Ca9kg+9HKWUk1X8d2U72t-9i+A@mail.gmail.com>
In-Reply-To: <CAADnVQJwB4R=8yasfaLLftx_Ca9kg+9HKWUk1X8d2U72t-9i+A@mail.gmail.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Thu, 12 May 2022 17:20:30 -0700
X-Gmail-Original-Message-ID: <CACYkzJ7grL665nEtQue=ud9AV=dKuMucm7HYDDRx5UxNCm=Ykg@mail.gmail.com>
Message-ID: <CACYkzJ7grL665nEtQue=ud9AV=dKuMucm7HYDDRx5UxNCm=Ykg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Implement bpf_getxattr helper
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, May 12, 2022 at 10:30 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, May 12, 2022 at 9:50 AM KP Singh <kpsingh@kernel.org> wrote:
> >
> > +BPF_CALL_5(bpf_getxattr, struct user_namespace *, mnt_userns, struct dentry *,
> > +          dentry, void *, name, void *, value, size_t, value_size)
> > +{
> > +       return vfs_getxattr(mnt_userns, dentry, name, value, value_size);
> > +}
>
> It will deadlock in tracing, since it grabs all kinds of locks
> and calls lsm hooks (potentially calling other bpf progs).

I wonder if we can limit these to just sleepable LSM programs
and for sleepable hooks + programs.

> It probably should be sleepable only.

Yes, it's currently sleepable only.

> Also there is no need to make it uapi.
> kfunc is a better interface here.

Sure, let me try with kfunc, simple wrappers like
these are a good use-case for kfuncs.

> __vfs_getxattr() is probably better too,
> since vfs_getxattr() calls xattr_permission which calls
> a bunch of capable*() which will return "random values"

Agreed.



> depending on the current task, since it's called from bpf prog.
