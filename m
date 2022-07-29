Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 862C158547E
	for <lists+bpf@lfdr.de>; Fri, 29 Jul 2022 19:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237880AbiG2RaB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 Jul 2022 13:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236725AbiG2RaA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 Jul 2022 13:30:00 -0400
Received: from mailrelay.tu-berlin.de (mailrelay.tu-berlin.de [130.149.7.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903FB2ED64
        for <bpf@vger.kernel.org>; Fri, 29 Jul 2022 10:29:58 -0700 (PDT)
Received: from SPMA-01.tubit.win.tu-berlin.de (localhost.localdomain [127.0.0.1])
        by localhost (Email Security Appliance) with SMTP id 1B39C7DEAC6_2E41915B;
        Fri, 29 Jul 2022 17:29:57 +0000 (GMT)
Received: from mail.tu-berlin.de (postcard.tu-berlin.de [141.23.12.142])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "exchange.tu-berlin.de", Issuer "DFN-Verein Global Issuing CA" (verified OK))
        by SPMA-01.tubit.win.tu-berlin.de (Sophos Email Appliance) with ESMTPS id 637B57DEAC2_2E41914F;
        Fri, 29 Jul 2022 17:29:56 +0000 (GMT)
Message-ID: <a636d985cea1d3975062390724fdd015b0934763.camel@mailbox.tu-berlin.de>
Subject: Re: [RFC PATCH bpf-next] bpftool: Mark generated skeleton headers
 as system headers
From:   =?ISO-8859-1?Q?J=F6rn-Thorben?= Hinz <jthinz@mailbox.tu-berlin.de>
To:     Quentin Monnet <quentin@isovalent.com>, Yonghong Song <yhs@fb.com>,
        <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        "Martin KaFai Lau" <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        "Stanislav Fomichev" <sdf@google.com>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>
Date:   Fri, 29 Jul 2022 19:29:54 +0200
In-Reply-To: <31673eca-ec46-35b2-9172-4156d985b621@isovalent.com>
References: <20220728165644.660530-1-jthinz@mailbox.tu-berlin.de>
         <7d4af6b4-f4da-f004-48a1-e408d8615ee8@fb.com>
         <31673eca-ec46-35b2-9172-4156d985b621@isovalent.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SASI-RCODE: 200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=campus.tu-berlin.de; h=message-id:subject:from:to:cc:date:in-reply-to:references:content-type:mime-version:content-transfer-encoding; s=dkim-tub; bh=4/lQ4Wfk45J1KW7FNdxYSTQDTvdGGYYyXOXOxa30lVI=; b=jNRcBGm5jXwEyL8NQBQpLl//hwvwFlsx6XJc3t0e5TgjE3D+vRFvfN0k2TIsVwIReynG7qpKQfWeOjbamvUurKFO1o2YeW/pj7T/KrY+7zDtTUaOgv69D8zXU5jJccPWxYCwYffVT5654s4JYiRL82bPMN1Jpj5UNFPIieTjGx0=
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 2022-07-29 at 11:12 +0100, Quentin Monnet wrote:
> On 28/07/2022 19:25, Yonghong Song wrote:
> > 
> > 
> > On 7/28/22 9:56 AM, Jörn-Thorben Hinz wrote:
> > > Hi,
> > > 
> > > after compiling a skeleton-using program with -pedantic once and
> > > stumbling across a tiniest incorrectness in skeletons with it[1],
> > > I was
> > > debating whether it makes sense to suppress warnings from
> > > skeleton
> > > headers.
> > > 
> > > Happy about comments about this. This change might be too
> > > suppressive
> > > towards warnings and maybe ignoring only -Woverlength-strings
> > > directly
> > > in OBJ_NAME__elf_bytes() be a better idea. Or keep all warnings
> > > from
> > > skeletons available as-is to have them more visible in and around
> > > bpftool’s development.
> > 
> > This is my 2cents. As you mentioned, skeleton file are per program
> > and not in system header file directory. I would like not to mark
> > these header files as system files. Since different program will
> > generate different skeleton headers, suppressing warnings
> > will prevent from catching potential issues in certain cases.
> > 
> > Also, since the warning is triggered by extra user flags like -
> > pedantic
> > when building bpftool, user can also add -Wno-overlength-strings
> > in the extra user flags.
> 
> I agree with Yonghong, I don't think it's a good idea to mark the
> whole
> file as a system header. I would maybe consider the other solution
> where
> we can disable the warning locally in the skeleton, just around
> OBJ_NAME__elf_bytes() as you suggested.
That was my first attempt. But, after a second look, -Wsign-conversion,
-Wcast-qual, and -Wreserved-id-macro would also show a warning for a
skeleton header. That’s why I switched to the `GCC system_header`.
Ignoring these four warnings for the whole header would also be an
alternative. Doing that for all of them only at the place where they
are triggered might become less pretty.

Please also see my longer answer to Yonghong.

> Although I suppose we'd need
> several pragmas if we want to silence it for GCC and clang, for
> example?
> It looks like your patch was only addressing GCC?
It is only explicitly mentioned for `GCC diagnostic …` in [1], but
clang seems to support the `GCC system_header` for compatibility, too.
So both are covered by using GCC’s pragmas here.

[1]
https://clang.llvm.org/docs/UsersManual.html#controlling-diagnostics-via-pragmas
(also the following subsection)

> 
> Thanks for the contribution,
Thanks for your reply!

> Quentin

