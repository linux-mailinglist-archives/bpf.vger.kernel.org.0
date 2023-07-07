Return-Path: <bpf+bounces-4442-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61CBC74B545
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 18:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CFEB2817D4
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 16:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC1711181;
	Fri,  7 Jul 2023 16:49:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920DC10970
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 16:49:59 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA947213F
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 09:49:54 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5707177ff8aso22935437b3.2
        for <bpf@vger.kernel.org>; Fri, 07 Jul 2023 09:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688748594; x=1691340594;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3lCnKLZ8WnG1mWC3vUm5YK5y7ARdy6Q9MhmfW4z3qkA=;
        b=0M/DSAFvBjjl75e5gZVjeSpGVXeKEyIVdE7Ii1iPkW1eHDCFsV1fwZoKNxdry0otNw
         8/0M/QVJdhkGB3GsabSS2Vdf5T0pO+KqI3VhC8KlRg3d3DdDkzTMtTO1y2FA41J+cpRr
         De0GsIaE7gFDTktkCk1u0JS87b/FulVVqNJsulKuZwEfWpNtTFm0Pr5gYL3CYDHvJhwr
         MU33BvuNnYrlU072zlXj1anHOgcrvPw35w+Nv7q4X3GUI7h8aYhLCHQFRp5G2AfCIr1e
         nbznV6p0xU59RAFhSe2AXllr7y16dRKAmBIQwgE4yrAQWaap3Ah/EItPFUoFHI5g+p+x
         g8Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688748594; x=1691340594;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3lCnKLZ8WnG1mWC3vUm5YK5y7ARdy6Q9MhmfW4z3qkA=;
        b=Oa0PlLutbCBZFBpvSMUsD6MOHnm8xVw9Af3GGU5m03uDzewGGXp+bnxRYh6N8D+ZvH
         fsthHmjSOB1LpNCL95eGAMSJU+gzWe/2RqXxod3JzIqZplw6P9Sxq6CTXpeiiCyw6LZy
         4QeuJRNNf9WZtmuBZUQurIXdmqbGHeqdWOcpd+IfWdcL2NpRdzExh+UlvOiSLD7w0wUY
         k8hQUUu9DiUgN13IsvTvOcIkbLUAYCsXEYKXT+WqS7HJnEIbfoVbr8NFDACPMS/B59Sq
         6Y6fvPZG2fBqth4rtrr0KmQUzdo/XkIzr8FBfficmoVwuvPdsALUPO/L9yEFtDpV3dNf
         waZA==
X-Gm-Message-State: ABy/qLbfX+R3C9b9gzJMfVa+CWVt2Ovx9lcnrb3soMHQTmW5qNqDDybM
	aZosbB8wolozAllVBoYLaLAb7tw=
X-Google-Smtp-Source: APBJJlG2ROezXuZKgHn5LG9SdQVx8FlVOt1BXen3wzVspLsYi47Fw04h9z+NQKq9iiuFwteih3PKNfo=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6902:508:b0:c4b:6ed6:6147 with SMTP id
 x8-20020a056902050800b00c4b6ed66147mr59031ybs.9.1688748593984; Fri, 07 Jul
 2023 09:49:53 -0700 (PDT)
Date: Fri, 7 Jul 2023 09:49:51 -0700
In-Reply-To: <ZKfN0AZ9rLDhxsB3@lincoln>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230703181226.19380-1-larysa.zaremba@intel.com>
 <20230703181226.19380-19-larysa.zaremba@intel.com> <ZKWq142tp/tI6NI3@google.com>
 <ZKbLd8brydTvSocG@lincoln> <CAKH8qBv9Mj6xmC9ru7oVAamaT+PLO62m4NAkOg=YS2vGpWntGQ@mail.gmail.com>
 <ZKfN0AZ9rLDhxsB3@lincoln>
Message-ID: <ZKhCL/YMo8dv4lqd@google.com>
Subject: Re: [PATCH bpf-next v2 18/20] selftests/bpf: Use AF_INET for TX in xdp_metadata
From: Stanislav Fomichev <sdf@google.com>
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com, 
	jolsa@kernel.org, David Ahern <dsahern@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Jesper Dangaard Brouer <brouer@redhat.com>, 
	Anatoly Burakov <anatoly.burakov@intel.com>, Alexander Lobakin <alexandr.lobakin@intel.com>, 
	Magnus Karlsson <magnus.karlsson@gmail.com>, Maryam Tahhan <mtahhan@redhat.com>, 
	xdp-hints@xdp-project.net, netdev@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 07/07, Larysa Zaremba wrote:
> On Thu, Jul 06, 2023 at 10:27:38AM -0700, Stanislav Fomichev wrote:
> > On Thu, Jul 6, 2023 at 7:15=E2=80=AFAM Larysa Zaremba <larysa.zaremba@i=
ntel.com> wrote:
> > >
> > > On Wed, Jul 05, 2023 at 10:39:35AM -0700, Stanislav Fomichev wrote:
> > > > On 07/03, Larysa Zaremba wrote:
> > > > > The easiest way to simulate stripped VLAN tag in veth is to send =
a packet
> > > > > from VLAN interface, attached to veth. Unfortunately, this approa=
ch is
> > > > > incompatible with AF_XDP on TX side, because VLAN interfaces do n=
ot have
> > > > > such feature.
> > > > >
> > > > > Replace AF_XDP packet generation with sending the same datagram v=
ia
> > > > > AF_INET socket.
> > > > >
> > > > > This does not change the packet contents or hints values with one=
 notable
> > > > > exception: rx_hash_type, which previously was expected to be 0, n=
ow is
> > > > > expected be at least XDP_RSS_TYPE_L4.
> > > > >
> > > > > Also, usage of AF_INET requires a little more complicated namespa=
ce setup,
> > > > > therefore open_netns() helper function is divided into smaller re=
usable
> > > > > pieces.
> > > >
> > > > Ack, it's probably OK for now, but, FYI, I'm trying to extend this =
part
> > > > with TX metadata:
> > > > https://lore.kernel.org/bpf/20230621170244.1283336-10-sdf@google.co=
m/
> > > >
> > > > So probably long-term I'll switch it back to AF_XDP but will add
> > > > support for requesting vlan TX "offload" from the veth.
> > > >
> > >
> > > My bad for not reading your series. Amazing work as always!
> > >
> > > So, 'requesting vlan TX "offload"' with new hints capabilities? This =
would be
> > > pretty neat.
> > >
> > > But you think AF_INET TX is worth keeping for now, until TX hints are=
 mature?
> > >
> > > > > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > > > > ---
> > > > >  tools/testing/selftests/bpf/network_helpers.c |  37 +++-
> > > > >  tools/testing/selftests/bpf/network_helpers.h |   3 +
> > > > >  .../selftests/bpf/prog_tests/xdp_metadata.c   | 175 +++++++-----=
------
> > > > >  3 files changed, 98 insertions(+), 117 deletions(-)
> > > > >
> > > > > diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tool=
s/testing/selftests/bpf/network_helpers.c
> > > > > index a105c0cd008a..19463230ece5 100644
> > > > > --- a/tools/testing/selftests/bpf/network_helpers.c
> > > > > +++ b/tools/testing/selftests/bpf/network_helpers.c
> > > > > @@ -386,28 +386,51 @@ char *ping_command(int family)
> > > > >     return "ping";
> > > > >  }
> > > > >
> > > > > +int get_cur_netns(void)
> > > > > +{
> > > > > +   int nsfd;
> > > > > +
> > > > > +   nsfd =3D open("/proc/self/ns/net", O_RDONLY);
> > > > > +   ASSERT_GE(nsfd, 0, "open /proc/self/ns/net");
> > > > > +   return nsfd;
> > > > > +}
> > > > > +
> > > > > +int get_netns(const char *name)
> > > > > +{
> > > > > +   char nspath[PATH_MAX];
> > > > > +   int nsfd;
> > > > > +
> > > > > +   snprintf(nspath, sizeof(nspath), "%s/%s", "/var/run/netns", n=
ame);
> > > > > +   nsfd =3D open(nspath, O_RDONLY | O_CLOEXEC);
> > > > > +   ASSERT_GE(nsfd, 0, "open /proc/self/ns/net");
> > > > > +   return nsfd;
> > > > > +}
> > > > > +
> > > > > +int set_netns(int netns_fd)
> > > > > +{
> > > > > +   return setns(netns_fd, CLONE_NEWNET);
> > > > > +}
> > > >
> > > > We have open_netns/close_netns in network_helpers.h that provide si=
milar
> > > > functionality, let's use them instead?
> > > >
> > >
> > > I have divided open_netns() into smaller pieces (see below), because =
the code I
> > > have added into xdp_metadata looked better with those smaller pieces =
(I had to
> > > switch namespace several times).
> >=20
> > Forgot to reply to this part. I missed the fact that you're extending
> > network_helpers, sorry.
> > But why do we need extra namespaces at all?
>=20
> If veths are in the same namespace, AF_INET packets are not sent between =
them,
> so XDP is skipped. So we need 2 test namespaces: for RX and TX.

Makes sense. But let's maybe use the existing helpers to jump to/from
namespaces?

It might be a bit more verbose, but it makes it easy to annotate namespace
being/end. (compared to random jumping around with setns)

tok =3D open_netns("tx");
do_something();
close_netns(tok);

tok =3D open_netns("rx");
do_something_else();
close_netns(tok);

Should be doable?

