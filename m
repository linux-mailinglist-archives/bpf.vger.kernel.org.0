Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0B7955885A
	for <lists+bpf@lfdr.de>; Thu, 23 Jun 2022 21:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbiFWTIq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Jun 2022 15:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbiFWTIb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Jun 2022 15:08:31 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0550CC09E8
        for <bpf@vger.kernel.org>; Thu, 23 Jun 2022 11:14:02 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 5E63B240109
        for <bpf@vger.kernel.org>; Thu, 23 Jun 2022 20:13:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1656008037; bh=7NGexCvEpaJ1d1NesaP+IAjVdlFwV5x09giYdtdsFro=;
        h=Date:From:To:Cc:Subject:From;
        b=fj4ZDwclKgHEcHuRSXZeD2klcDniQVm8ywJvc2WX6OOX/TGbzh+Z9G7oYkJ/YjKaW
         EvUb1duyE5XmE9ZCmPAFyP/rcPBF6lpRUJPHZyDVVhSbojrmqY8EMoIq6ZOWUA79mi
         GNGiCWvR17TbXddW3dB4iNrZuclkWnIbe/LyfGaoJJNRHZf3xrSbA8Rsw+s/MFKFHm
         W0QWn8bH5jDyTdrE6kcqyJD1qIHBZKAvbUlNrCcdYybbbTeIobSOq4CExW5proCSa/
         77QFfgfttBkCAus1t/DE7cUySgPHWN8bzQ9eB9jh6nRc6VzRzTvvKgP86ZK1Od++Xk
         FUpmBF637gNww==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4LTT0B4yyqz6tpD;
        Thu, 23 Jun 2022 20:13:46 +0200 (CEST)
Date:   Thu, 23 Jun 2022 18:13:43 +0000
From:   Daniel =?utf-8?Q?M=C3=BCller?= <deso@posteo.net>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 1/2] libbpf: Move core "types_are_compat" logic
 into relo_core.c
Message-ID: <20220623181343.hgopdj2v3ejfmojq@muellerd-fedora-MJ0AC3F3>
References: <20220622173506.860578-1-deso@posteo.net>
 <20220622173506.860578-2-deso@posteo.net>
 <CAEf4Bzbe-r+G00Zy-wTFE+Y765BtmaTNHYdjoXc91XNwzuJWWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bzbe-r+G00Zy-wTFE+Y765BtmaTNHYdjoXc91XNwzuJWWQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jun 22, 2022 at 09:15:01PM -0700, Andrii Nakryiko wrote:
> On Wed, Jun 22, 2022 at 10:35 AM Daniel Müller <deso@posteo.net> wrote:
> >
> > This change merges the two existing implementations of the
> > bpf_core_types_are_compat() function into relo_core.c, inheriting the
> > recursion tracking from the kernel and the usage of
> > btf_kind_core_compat() from libbpf. The kernel is left untouched and
> > will be adjusted subsequently.
> >
> > Signed-off-by: Daniel Müller <deso@posteo.net>
> > ---
> 
> I don't feel very strongly about this, but given we are consolidating
> kernel and libbpf code, I think it makes sense to do it in one patch.

Sure.


> >  tools/lib/bpf/libbpf.c    | 72 +-----------------------------------
> >  tools/lib/bpf/relo_core.c | 78 +++++++++++++++++++++++++++++++++++++++
> >  tools/lib/bpf/relo_core.h |  2 +
> >  3 files changed, 81 insertions(+), 71 deletions(-)
> >
> 
> [...]
> 
> > -       default:
> > -               pr_warn("unexpected kind %s relocated, local [%d], target [%d]\n",
> > -                       btf_kind_str(local_type), local_id, targ_id);
> > -               return 0;
> > -       }
> > +       return bpf_core_types_are_compat_recur(local_btf, local_id, targ_btf, targ_id, INT_MAX);
> 
> INT_MAX seems like an overkill, let's just hard-code 32 just like we
> have for a local recursion limit here?

Okay.

> >  }
> >
> 
> [...]
> 
> >  /*
> >   * Turn bpf_core_relo into a low- and high-level spec representation,
> >   * validating correctness along the way, as well as calculating resulting
> > diff --git a/tools/lib/bpf/relo_core.h b/tools/lib/bpf/relo_core.h
> > index 7df0da0..b8998f 100644
> > --- a/tools/lib/bpf/relo_core.h
> > +++ b/tools/lib/bpf/relo_core.h
> > @@ -68,6 +68,8 @@ struct bpf_core_relo_res {
> >         __u32 new_type_id;
> >  };
> >
> > +int bpf_core_types_are_compat_recur(const struct btf *local_btf, __u32 local_id,
> > +                                   const struct btf *targ_btf, __u32 targ_id, int level);
> 
> Just leave it called __bpf_core_types_are_compat like in kernel, it is
> clearly an "internal" version of bpf_core_types_are_compat(), so it's
> more proper naming convention.

Sounds good.

[...]

Thanks,
Daniel
