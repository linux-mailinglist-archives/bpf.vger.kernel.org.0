Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0C714CB2F1
	for <lists+bpf@lfdr.de>; Thu,  3 Mar 2022 00:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbiCBXuM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Mar 2022 18:50:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiCBXuL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Mar 2022 18:50:11 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5447C241B71
        for <bpf@vger.kernel.org>; Wed,  2 Mar 2022 15:49:25 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id u16so3283264pfg.12
        for <bpf@vger.kernel.org>; Wed, 02 Mar 2022 15:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ko8Es7ZJtjVO3NP/5pMNlDyCEfQwQh9f4P4oN5F0HKc=;
        b=SIwBw7VfRJCPINYHm+4ZQG49baQ2QQzZw/6oLDNyfJbsP9VSKSJOgcutBtl16/ONib
         v9rVLRHi1UvEC36pENc5cBM3B7nY9MX4zH6RFSX3jC9SmRri966+OUPOmKZHarWV3Uw0
         5M649Cn8MRv7IH2ezL4bOPwsoTljQ9kPDox+ra0Q7Fc26uWpFdqC6AzT2ff5Q94OzdD4
         2WtpNX+5It8m70KrT/+9QeISFJMJhn5mNKT8SF7dZ59a1SOAQZFfbGuoTfiKkc8opyl8
         2kztRDiMntQneVxCc7xuOBUohDiYmapFs85wlPgaCOFFz4Mn9mJ2I6Ti43JEgZjke2CW
         ft2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ko8Es7ZJtjVO3NP/5pMNlDyCEfQwQh9f4P4oN5F0HKc=;
        b=Jozd51cYlrViH9BwO3BK2pMaOja4HduYWAaDfw7Eu1jiZuetzXlTPpQ2m5eYCyA1pm
         +nINYbm89y1MJaa2wgZYBM3u55LezSVtW9g1p8UBTDdjbICgOH/sM7R/AokUecTP0/FH
         R0b63hgHk2/7dqR9nHR8pEr5GWuq426mI+EXn4op6eYKDOi2k+aCoYJCjDeA8zjJebwN
         Us+uSIXNbTEcJsS7afRb/smegss14sRHcDKhM9tfVsRcQF2dtfU+2deqWK2T0gxeu81k
         jfpd1F2lFnM5+b7Cf/U/lANFQ9b4GvYWNDUl8k0/ROSRCUJV+REvh4msABokO9W5/NyS
         Y1gQ==
X-Gm-Message-State: AOAM531rC99WWl+w+mjU1HFcdCQNevM0x1QqZtNm4Mnh42FVOk/JHpEx
        oZyFYFmgn2NgJLtJ/TqTGOIJ+S9iIvq7FLuz4qe3b63RhqU=
X-Google-Smtp-Source: ABdhPJxkdMgxHAjuiogfMST1u3t0aIc/vYODaa/J5QdPoKTjpSqgeZq2FVS4GEx8TicBrzyXEefoxDhkr/5SN1LAYsk=
X-Received: by 2002:a05:6a00:1146:b0:4c9:ede0:725a with SMTP id
 b6-20020a056a00114600b004c9ede0725amr35832067pfm.35.1646263246087; Wed, 02
 Mar 2022 15:20:46 -0800 (PST)
MIME-Version: 1.0
References: <20220301065745.1634848-7-memxor@gmail.com> <202203011937.wMLpkfU3-lkp@intel.com>
 <20220301115722.jjklznmjsbnkdsf2@apollo.legion> <CAADnVQL-sSMacA8S-gvKTAz-CAdTaDgX=4ZZrwFL=zZKYC0-Aw@mail.gmail.com>
 <20220302231401.bvtffkq3oz7g4mxj@apollo.legion>
In-Reply-To: <20220302231401.bvtffkq3oz7g4mxj@apollo.legion>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 2 Mar 2022 15:20:34 -0800
Message-ID: <CAADnVQJucT4+Q7Yu=vcR0b+a1bkZv024UEm9Z=24gt_NrV1KVA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 6/6] selftests/bpf: Add tests for kfunc
 register offset checks
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     kernel test robot <lkp@intel.com>, bpf <bpf@vger.kernel.org>,
        llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 2, 2022 at 3:14 PM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>
> On Thu, Mar 03, 2022 at 04:17:25AM IST, Alexei Starovoitov wrote:
> > On Tue, Mar 1, 2022 at 3:57 AM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
> > >
> > > On Tue, Mar 01, 2022 at 05:10:31PM IST, kernel test robot wrote:
> > > > Hi Kumar,
> > > >
> > > > Thank you for the patch! Perhaps something to improve:
> > > >
> > > > [auto build test WARNING on bpf-next/master]
> > > >
> > > > url:    https://github.com/0day-ci/linux/commits/Kumar-Kartikeya-Dwivedi/Fixes-for-bad-PTR_TO_BTF_ID-offset/20220301-150010
> > > > base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
> > > > config: s390-randconfig-r021-20220301 (https://download.01.org/0day-ci/archive/20220301/202203011937.wMLpkfU3-lkp@intel.com/config)
> > > > compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
> > >
> > > The same warning is emitted on clang for all existing definitions, so I can
> > > respin with a fix for the warning like we do for GCC, otherwise it can also
> > > be a follow up patch.
> >
> > Separate patch is fine.
> > How do you plan on fixing it?
> > What is __diag_ignore equivalent for clang?
>
> Hmm, looks like I'll have to add those in include/linux/compiler-clang.h. Quick
> local testing suggests it will work with _Pragma("clang diagnostic ignored ...").

Make a generic llvm/gcc #define for
__diag_ignore(GCC, 8, "-Wmissing-prototypes" ?
We need it in two places so far.
