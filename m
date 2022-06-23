Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2AD2558917
	for <lists+bpf@lfdr.de>; Thu, 23 Jun 2022 21:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbiFWTf5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Jun 2022 15:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbiFWTfj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Jun 2022 15:35:39 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4353181529
        for <bpf@vger.kernel.org>; Thu, 23 Jun 2022 12:19:29 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 309EB240026
        for <bpf@vger.kernel.org>; Thu, 23 Jun 2022 21:19:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1656011967; bh=Pvq7nRqbAv9VUBkdDHUyFMWBdOO49O8Ni8RIvyVwzmE=;
        h=Date:From:To:Cc:Subject:From;
        b=iW16rYfmRw35ae9dJJRjB3yRxUuUUxgrbETsPI0a4hVVCLTmk9XRW2ot+P8GEHwzz
         jTvf5i6ECc5z6C2CpgMTrZOsTC3mCuFx3QRXZ4Y0nH+xLYs31DIKHz5o7YSbyjsgX9
         SVyEanewe0xQI/Gz1VUIbjJo58RrIOjjh8J4npYaeFpSmpaRBS44HxVNeQbBmxBNoX
         HP4GtE5mjMbpfFBTeGfTwf2PQw39p3IWoxfw62ZAyKBB285AMATYMesnektBngWaLf
         //PxDWsMvoBpBgPEkIPah2At+gt1lwNAbMDbE9I7g6hec4CKT+BVDQ6NGg7kNJdTXb
         25tcjEXf+n3RQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4LTVRl2f9Rz6tmb;
        Thu, 23 Jun 2022 21:19:13 +0200 (CEST)
Date:   Thu, 23 Jun 2022 19:19:03 +0000
From:   Daniel =?utf-8?Q?M=C3=BCller?= <deso@posteo.net>
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
Subject: Re: [PATCH bpf-next 3/7] bpf: Add type match support
Message-ID: <20220623191903.aqbwogthn3ap2c7i@muellerd-fedora-MJ0AC3F3>
References: <20220620231713.2143355-1-deso@posteo.net>
 <20220620231713.2143355-4-deso@posteo.net>
 <CAJnrk1YL9E2GJN+8Gnr9Db=yAHDOm2nwLb_LUQTEuStkm1jHEg@mail.gmail.com>
 <20220622172224.4curfsv7h7gfjwh5@muellerd-fedora-MJ0AC3F3>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220622172224.4curfsv7h7gfjwh5@muellerd-fedora-MJ0AC3F3>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jun 22, 2022 at 05:22:24PM +0000, Daniel Müller wrote:
> On Tue, Jun 21, 2022 at 12:41:22PM -0700, Joanne Koong wrote:
> >  On Mon, Jun 20, 2022 at 4:25 PM Daniel Müller <deso@posteo.net> wrote:
[...]
> > > +       case BTF_KIND_FUNC_PROTO: {
> > > +               struct btf_param *local_p = btf_params(local_t);
> > > +               struct btf_param *targ_p = btf_params(targ_t);
> > > +               u16 local_vlen = btf_vlen(local_t);
> > > +               u16 targ_vlen = btf_vlen(targ_t);
> > > +               int i, err;
> > > +
> > > +               if (local_k != btf_kind(targ_t))
> > > +                       return 0;
> > > +
> > > +               if (local_vlen != targ_vlen)
> > > +                       return 0;
> > > +
> > > +               for (i = 0; i < local_vlen; i++, local_p++, targ_p++) {
> > > +                       err = __bpf_core_types_match(local_btf, local_p->type, targ_btf,
> > > +                                                    targ_p->type, level - 1);
> > > +                       if (err <= 0)
> > > +                               return err;
> > > +               }
> > > +
> > > +               /* tail recurse for return type check */
> > > +               local_id = local_t->type;
> > > +               targ_id = targ_t->type;
> > > +               goto recur;
> > > +       }
> > > +       default:
> > Do BTF_KIND_FLOAT and BTF_KIND_TYPEDEF need to be checked as well?
> 
> Lack of BTF_KIND_TYPEDEF is a good question. I don't know why it's missing from
> bpf_core_types_are_compat() as well, which I took as a template. I will do some
> testing to better understand if we can hit this case or whether there is some
> magic going on that would have resolved typedefs already at this point (which is
> my suspicion).
> My understanding why we don't cover floats is because we do not allow floating
> point operations in kernel code (right?).

So typedefs are all skipped by the logic, see calls to btf_type_skip_modifiers
at the top of the function. That's why we don't need to handle them explicitly.

I should have a revised version addressing the other points up shortly.

Daniel
