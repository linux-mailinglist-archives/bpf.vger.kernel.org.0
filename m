Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA4DE6DFACF
	for <lists+bpf@lfdr.de>; Wed, 12 Apr 2023 18:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjDLQGr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Apr 2023 12:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjDLQGq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Apr 2023 12:06:46 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA3BCF
        for <bpf@vger.kernel.org>; Wed, 12 Apr 2023 09:06:45 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-54f69fb5cafso62671337b3.12
        for <bpf@vger.kernel.org>; Wed, 12 Apr 2023 09:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681315604;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qOZ3tRdzr0hGyj65SmYqR8EOiBJrMHU9wHV0sWwy2Pc=;
        b=dMmMg50RH6pfkUoOxPzCVX7IU5ikGtbDFWmi2r45KgXj3VCwZ1lQFQ0bIIx1lIKc50
         d1WFq5ChEvU+YNUSCURdJK2alRsAFNduI2SihG0yD1+2CBU/p3WMVxRopmIfzG55ooVv
         HzaorBxvGSvBalSCOiMk8iBKIJL3W2uYkrjRACRJWafTyIaGMdzo01QjKtqsqFxFHv20
         +fVbNuhtLK3PsF1eFNMHGRfbPXvGJL/j8HAohE2fRqQTs74Y48KXU7jHNwIVkJze/8GX
         cEgdk9j0CRkn9iMUPQquIVeBv+4ewh6v/U8cBwSst+bZ2H2Ou1yJa8aOjt7VEPELxbY6
         q6Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681315604;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qOZ3tRdzr0hGyj65SmYqR8EOiBJrMHU9wHV0sWwy2Pc=;
        b=5RRDB5ZpcU9zLqrEOO+w0+zzqNEiCTiBubvO//wDQQKgD4n/WdPSN/TFlZCku+687h
         K5wgA788RQt5ybnC5d+MILBmBS78xm7ESpvlRQDPxYMWdn4PHo2cZG0DeFpNl3hMra47
         0dDXyVoG5Ddu6T6kkFyJGs+HuWs3vr533pHALAlvfxHiGwlggtPRvcwnQGxSrwodHuuz
         1eO1BZp/BrLhJln2nWiGJUiEk7w1+QYuYfjmIYyRgzsUxCpRLgdYaQ6E5cozkqgKMR9n
         kpfQiqIgrQXuWTCVjhBQD+ZTwDOzEWypb9T+Do2FUyROGvzZMAqmvmYlKF1GL35I3nBN
         8qjA==
X-Gm-Message-State: AAQBX9dGNETmg7XIuYWpNmpC+aNOT4JZIOOUOZxy0xrYL7MVt4YSAkli
        HFbIDPezsir30Uet5im+CpVAyFk=
X-Google-Smtp-Source: AKy350alO6Bi7nwBbBUyvXEpvPDdFjOYyG+3EN768sevyKcN5qXz8S1F1xuMmrr51w4VCv+w61ymJ58=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a25:d988:0:b0:997:c919:4484 with SMTP id
 q130-20020a25d988000000b00997c9194484mr7803210ybg.6.1681315604689; Wed, 12
 Apr 2023 09:06:44 -0700 (PDT)
Date:   Wed, 12 Apr 2023 09:06:42 -0700
In-Reply-To: <402a3c73-d26d-3619-d69a-c90eb3f0e9ee@redhat.com>
Mime-Version: 1.0
References: <168098183268.96582.7852359418481981062.stgit@firesoul>
 <168098188134.96582.7870014252568928901.stgit@firesoul> <CAKH8qBu2ieR+puSkF30-df3YikOvDZErxc2qjjVXPPAvCecihA@mail.gmail.com>
 <402a3c73-d26d-3619-d69a-c90eb3f0e9ee@redhat.com>
Message-ID: <ZDbXEqQc3MpKPmGv@google.com>
Subject: Re: [PATCH bpf V7 1/7] selftests/bpf: xdp_hw_metadata default disable bpf_printk
From:   Stanislav Fomichev <sdf@google.com>
To:     Jesper Dangaard Brouer <jbrouer@redhat.com>
Cc:     brouer@redhat.com, bpf@vger.kernel.org,
        "Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?=" <toke@redhat.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        martin.lau@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        alexandr.lobakin@intel.com, larysa.zaremba@intel.com,
        xdp-hints@xdp-project.net, anthony.l.nguyen@intel.com,
        yoong.siang.song@intel.com, boon.leong.ong@intel.com,
        intel-wired-lan@lists.osuosl.org, pabeni@redhat.com,
        jesse.brandeburg@intel.com, kuba@kernel.org, edumazet@google.com,
        john.fastabend@gmail.com, hawk@kernel.org, davem@davemloft.net,
        tariqt@nvidia.com, saeedm@nvidia.com, leon@kernel.org,
        linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 04/12, Jesper Dangaard Brouer wrote:
>=20
> On 12/04/2023 00.42, Stanislav Fomichev wrote:
> > On Sat, Apr 8, 2023 at 12:24=E2=80=AFPM Jesper Dangaard Brouer
> > <brouer@redhat.com> wrote:
> > >=20
> > > The tool xdp_hw_metadata can be used by driver developers
> > > implementing XDP-hints kfuncs.  The tool transfers the
> > > XDP-hints via metadata information to an AF_XDP userspace
> > > process. When everything works the bpf_printk calls are
> > > unncesssary.  Thus, disable bpf_printk by default, but
> > > make it easy to reenable for driver developers to use
> > > when debugging their driver implementation.
> > >=20
> > > This also converts bpf_printk "forwarding UDP:9091 to AF_XDP"
> > > into a code comment.  The bpf_printk's that are important
> > > to the driver developers is when bpf_xdp_adjust_meta fails.
> > > The likely mistake from driver developers is expected to
> > > be that they didn't implement XDP metadata adjust support.
> > >=20
> > > Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
> > > ---
> > >   .../testing/selftests/bpf/progs/xdp_hw_metadata.c  |   16 +++++++++=
+++++--
> > >   1 file changed, 14 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c b/to=
ols/testing/selftests/bpf/progs/xdp_hw_metadata.c
> > > index 4c55b4d79d3d..980eb60d8e5b 100644
> > > --- a/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
> > > +++ b/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
> > > @@ -5,6 +5,19 @@
> > >   #include <bpf/bpf_helpers.h>
> > >   #include <bpf/bpf_endian.h>
> > >=20
> > > +/* Per default below bpf_printk() calls are disabled.  Can be
> > > + * reenabled manually for convenience by XDP-hints driver developer,
> > > + * when troublshooting the drivers kfuncs implementation details.
> > > + *
> > > + * Remember BPF-prog bpf_printk info output can be access via:
> > > + *  /sys/kernel/debug/tracing/trace_pipe
> > > + */
> > > +//#define DEBUG        1
> > > +#ifndef DEBUG
> > > +#undef  bpf_printk
> > > +#define bpf_printk(fmt, ...) ({})
> > > +#endif
> >=20
> > Are you planning to eventually do somethike similar to what I've
> > mentioned in [0]? If not, should I try to send a patch?
>=20
> See next patch:
>  - [PATCH bpf V7 2/7] selftests/bpf: Add counters to xdp_hw_metadata
>=20
> where I add these counters :-)

Oh, nice, let me take a look. I was assuming v7 is mostly the same as
v6..
=20
> >=20
> > 0: https://lore.kernel.org/netdev/CAKH8qBupRYEg+SPMTMb4h532GESG7P1QdaFJ=
-+zrbARVN9xrdA@mail.gmail.com/
> >=20
>=20
