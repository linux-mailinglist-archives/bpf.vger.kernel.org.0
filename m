Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 050304CB286
	for <lists+bpf@lfdr.de>; Wed,  2 Mar 2022 23:47:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbiCBWsj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Mar 2022 17:48:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiCBWsi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Mar 2022 17:48:38 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6815927B0E
        for <bpf@vger.kernel.org>; Wed,  2 Mar 2022 14:47:43 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id v4so3095415pjh.2
        for <bpf@vger.kernel.org>; Wed, 02 Mar 2022 14:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MXwMgtp7aGEPftELBgU0R9BW5PS1bdwaZuOl3PeKffE=;
        b=AzeIDbYGU2d70QwtB9OxBXk29BbHNhJ18jUJKXFdS0hEXmD69ERbiMhaiwtqluqy4T
         kvB6opMLayDp0v5Fldmk5ZH7RpfoKR0TrWDQZeZ5ReuwuRDUG8XodbS0jK/g7KMtKYK+
         GWYxNKVggS5rYXrLuFnA0CeqiT20AMkbelfsCybd4WEDgBvRPUjpC0lk/1ich5HwoaAk
         xn+VhJio0M+ZoNi+izLxM28d54rIAkxMoiUehJWQCcmPMF0W1IMD8C/MNY2POSlrHNoo
         6qdxJfhhdu1Std0lzRjosLurnUpZn1ThPWJ4dcbtJcqb6AitglZl5QXHd9DSa5VT4cXU
         Jf0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MXwMgtp7aGEPftELBgU0R9BW5PS1bdwaZuOl3PeKffE=;
        b=qo5gnWEUXcEvLEIcz0zhO5RqZ43ewtlpoBp+wQtxQ3ybvhGBB0umpdWgDsSHmHqke2
         kh309KTHi1cEJCHZP4/tP6TEmLmGvx8hliAakrh/j+0W/VfV1yX0nTuDfg4Ggz6aTYcf
         eYV6dKZBkm+8oMK019J80zwBCdR/epRUSt71ydu5+HD1MQrwwAQ89iG+pHsWCTD2aUnx
         xdkQUMTz7eB+UuuMZ+q/5wdrdeAni9vJWa4VYPfD66285viQ00LCUV4+TqETbr0aLGqQ
         qQY6gzVOgkMrEQkRdhD/uXbk/tDSqPhYzfmIb+lyFJdK2qglZpL4au2QYE90WGA3Kj7J
         Zq/Q==
X-Gm-Message-State: AOAM5318aeWsA/1leC2NP8qfPqtLXmsu/71w/nRb4WFmvA9HUrg4ziWd
        NEyYPZllsiWBL+JQfH3lVMbx0wrq2LSUTkqAcaI=
X-Google-Smtp-Source: ABdhPJyOepaybsFAjIqZBxBAS7LOzKn/LEr98q2LFGXsGjk+ATwurexPlAX6WWWEw4pqyyPpBhxOlZ5fxOKG5yZB2/o=
X-Received: by 2002:a17:90b:1a81:b0:1bc:c3e5:27b2 with SMTP id
 ng1-20020a17090b1a8100b001bcc3e527b2mr2146407pjb.20.1646261257086; Wed, 02
 Mar 2022 14:47:37 -0800 (PST)
MIME-Version: 1.0
References: <20220301065745.1634848-7-memxor@gmail.com> <202203011937.wMLpkfU3-lkp@intel.com>
 <20220301115722.jjklznmjsbnkdsf2@apollo.legion>
In-Reply-To: <20220301115722.jjklznmjsbnkdsf2@apollo.legion>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 2 Mar 2022 14:47:25 -0800
Message-ID: <CAADnVQL-sSMacA8S-gvKTAz-CAdTaDgX=4ZZrwFL=zZKYC0-Aw@mail.gmail.com>
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

On Tue, Mar 1, 2022 at 3:57 AM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>
> On Tue, Mar 01, 2022 at 05:10:31PM IST, kernel test robot wrote:
> > Hi Kumar,
> >
> > Thank you for the patch! Perhaps something to improve:
> >
> > [auto build test WARNING on bpf-next/master]
> >
> > url:    https://github.com/0day-ci/linux/commits/Kumar-Kartikeya-Dwivedi/Fixes-for-bad-PTR_TO_BTF_ID-offset/20220301-150010
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
> > config: s390-randconfig-r021-20220301 (https://download.01.org/0day-ci/archive/20220301/202203011937.wMLpkfU3-lkp@intel.com/config)
> > compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
>
> The same warning is emitted on clang for all existing definitions, so I can
> respin with a fix for the warning like we do for GCC, otherwise it can also
> be a follow up patch.

Separate patch is fine.
How do you plan on fixing it?
What is __diag_ignore equivalent for clang?
