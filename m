Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2975955C54A
	for <lists+bpf@lfdr.de>; Tue, 28 Jun 2022 14:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239697AbiF0VDR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Jun 2022 17:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239552AbiF0VDQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Jun 2022 17:03:16 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D7E95A4
        for <bpf@vger.kernel.org>; Mon, 27 Jun 2022 14:03:14 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 605FA24002B
        for <bpf@vger.kernel.org>; Mon, 27 Jun 2022 23:03:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1656363792; bh=HqEt3JocDOoIj8AR1A/bgUhuSgJZfF8rePxmyyMXxYU=;
        h=Date:From:To:Cc:Subject:From;
        b=Lg9b229FT2C7blnqR6s6MQ9bnL0FQ3DZjoAjYa0BNe+HcaLmg91FmjROHfxeGTs2o
         6NS7dbY6Zn1U8ddsSJkx35jUM+yjK6oJN5gCLfxSE+ufKVWa3mI7Jt8yGnLsBVFspk
         A/jsjCEUwt+VSmro2L3f2cdwZOCHTMTKTL8r4VFOriFesYi/kXuBHTbYdGrEaidBbC
         Avt9diboKy4R5hWlVUVWxsxeRXgjZkHW+ip2jVMcTucQ2gFQL743rCmtp1iiRxyuuP
         7cbATc3JTcUvcS+uCdCFI5ljxcH1rA7nuCJkTA9Bsl9yO9/PjwTpFZBpO1xK2M8Oqp
         MayA2vKgaahOw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4LX0Ym4Ymfz6tqy;
        Mon, 27 Jun 2022 23:03:08 +0200 (CEST)
Date:   Mon, 27 Jun 2022 21:03:05 +0000
From:   Daniel =?utf-8?Q?M=C3=BCller?= <deso@posteo.net>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Joanne Koong <joannelkoong@gmail.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 3/7] bpf: Add type match support
Message-ID: <20220627210305.ugktft5q35fnjpou@muellerd-fedora-MJ0AC3F3>
References: <20220620231713.2143355-1-deso@posteo.net>
 <20220620231713.2143355-4-deso@posteo.net>
 <CAJnrk1YL9E2GJN+8Gnr9Db=yAHDOm2nwLb_LUQTEuStkm1jHEg@mail.gmail.com>
 <20220622172224.4curfsv7h7gfjwh5@muellerd-fedora-MJ0AC3F3>
 <CAEf4BzbyU-W8a3fzZoy7DDb=DtqdfGM2U3YpgYaS+EqHWZ0qag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzbyU-W8a3fzZoy7DDb=DtqdfGM2U3YpgYaS+EqHWZ0qag@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jun 24, 2022 at 02:09:33PM -0700, Andrii Nakryiko wrote:
> On Wed, Jun 22, 2022 at 10:22 AM Daniel Müller <deso@posteo.net> wrote:
> >
> > On Tue, Jun 21, 2022 at 12:41:22PM -0700, Joanne Koong wrote:
> > > Do BTF_KIND_FLOAT and BTF_KIND_TYPEDEF need to be checked as well?
> >
> > Lack of BTF_KIND_TYPEDEF is a good question. I don't know why it's missing from
> > bpf_core_types_are_compat() as well, which I took as a template. I will do some
> > testing to better understand if we can hit this case or whether there is some
> > magic going on that would have resolved typedefs already at this point (which is
> > my suspicion).
> > My understanding why we don't cover floats is because we do not allow floating
> > point operations in kernel code (right?).
> 
> FLOAT is an omission, we need to add it (kernel types do have floats).

[...]

Thanks for clarifying. Let's leave FLOAT support for follow-on changes, though,
and not bloat this patch set unnecessarily. It's not currently support by the
existing libbpf/kernel checks or by bpftool's BTF minimization logic from what I
can tell -- preferably all of which would need to be updated, tests be added,
etc. This is entirely orthogonal to what is being added here from my
perspective.

Thanks,
Daniel
