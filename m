Return-Path: <bpf+bounces-4286-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D50FE74A30F
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 19:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91071281314
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 17:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CFDDBE59;
	Thu,  6 Jul 2023 17:27:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95288F40
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 17:27:51 +0000 (UTC)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87CA01BE9
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 10:27:50 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-3a3790a0a48so865458b6e.1
        for <bpf@vger.kernel.org>; Thu, 06 Jul 2023 10:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688664470; x=1691256470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7QHS/VR07ajDiBHiAQaH4sBwoJmZUdR5Oe/340tdBJA=;
        b=jR014TIBx34PqhIfwNlZl/SjjekJltkMg1drpzGydi51tnvz8hKLC0v7cExjUF6690
         r1nfr5OFVUlR360Lp/b7zv0149q5k/u9hxoGqjUM2PoTKGjx/LXI1pbTzGiA6ZcEG4bl
         8PjBab5Kqi322RN7XLEJ2mRCI7lkGtnrSgnqiaOXIzvU6ydAg5xFIHyir+SCS3jXPLDT
         Ph7AyZ3gTQwEei/p4ocdb9TXokOwem4IXuF6UMqnaGkJJYOCWJSN5foqwVybokuZL0rq
         lVUAJgqEyIavAvWEKKInA/LQfJABHaxaQC50tRt5vrfZn/j6QXMwCBghC2cdCP+mqfnc
         qPAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688664470; x=1691256470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7QHS/VR07ajDiBHiAQaH4sBwoJmZUdR5Oe/340tdBJA=;
        b=FzI33np10uvHzhQqeBK85LgJNK3YQ1qtSlQrk+Pj+ryPjwXhgSCwkv8LhAX439AbpV
         8YTVibHOdnkXW91b67B6gzK4ZTQZ/7dTaQH5s3myx4CR0b9ssq64HwAWnO3+QlRQbjS/
         MOPmXxPIxU36PX86SX4y6rK3LQellzgjqueJr/DJ5WlYD2vO9IqaP9Oa6VVVqnCQZ+lN
         ZfsFdvZZ4tcxksC63eLdPty+BkKUufS6fFLWzv/kHZqPt8o0cD2s306st4wReji2qa8z
         v4M2xMJRkzI25acEW2xCWq48DYgacMeMmca3jgL1Gy2sHGyFOA0QWxPAW7wQIV4YmDjA
         oaKQ==
X-Gm-Message-State: ABy/qLbtFqUjak3FAva0AuD3tun/O7WBqvT/uEEKDpMU+eGUdl5+naO6
	rfE2XpicAwYlNCg/hSsMZNLS2IXBqwrpDEJ/+8T/ataghLDGC0BQX9U=
X-Google-Smtp-Source: APBJJlFIBlvITdvF2gXEv0dJNHSb23rnclHLcMLWJSjHrRYlj43avwfou8Ov/vAFOC9XZxqGtvSsG97E0OPBUAdYH1U=
X-Received: by 2002:a05:6808:b0a:b0:3a3:9f5a:c308 with SMTP id
 s10-20020a0568080b0a00b003a39f5ac308mr1965956oij.20.1688664469737; Thu, 06
 Jul 2023 10:27:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230703181226.19380-1-larysa.zaremba@intel.com>
 <20230703181226.19380-19-larysa.zaremba@intel.com> <ZKWq142tp/tI6NI3@google.com>
 <ZKbLd8brydTvSocG@lincoln>
In-Reply-To: <ZKbLd8brydTvSocG@lincoln>
From: Stanislav Fomichev <sdf@google.com>
Date: Thu, 6 Jul 2023 10:27:38 -0700
Message-ID: <CAKH8qBv9Mj6xmC9ru7oVAamaT+PLO62m4NAkOg=YS2vGpWntGQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 18/20] selftests/bpf: Use AF_INET for TX in xdp_metadata
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com, 
	jolsa@kernel.org, David Ahern <dsahern@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Jesper Dangaard Brouer <brouer@redhat.com>, 
	Anatoly Burakov <anatoly.burakov@intel.com>, Alexander Lobakin <alexandr.lobakin@intel.com>, 
	Magnus Karlsson <magnus.karlsson@gmail.com>, Maryam Tahhan <mtahhan@redhat.com>, 
	xdp-hints@xdp-project.net, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 6, 2023 at 7:15=E2=80=AFAM Larysa Zaremba <larysa.zaremba@intel=
.com> wrote:
>
> On Wed, Jul 05, 2023 at 10:39:35AM -0700, Stanislav Fomichev wrote:
> > On 07/03, Larysa Zaremba wrote:
> > > The easiest way to simulate stripped VLAN tag in veth is to send a pa=
cket
> > > from VLAN interface, attached to veth. Unfortunately, this approach i=
s
> > > incompatible with AF_XDP on TX side, because VLAN interfaces do not h=
ave
> > > such feature.
> > >
> > > Replace AF_XDP packet generation with sending the same datagram via
> > > AF_INET socket.
> > >
> > > This does not change the packet contents or hints values with one not=
able
> > > exception: rx_hash_type, which previously was expected to be 0, now i=
s
> > > expected be at least XDP_RSS_TYPE_L4.
> > >
> > > Also, usage of AF_INET requires a little more complicated namespace s=
etup,
> > > therefore open_netns() helper function is divided into smaller reusab=
le
> > > pieces.
> >
> > Ack, it's probably OK for now, but, FYI, I'm trying to extend this part
> > with TX metadata:
> > https://lore.kernel.org/bpf/20230621170244.1283336-10-sdf@google.com/
> >
> > So probably long-term I'll switch it back to AF_XDP but will add
> > support for requesting vlan TX "offload" from the veth.
> >
>
> My bad for not reading your series. Amazing work as always!
>
> So, 'requesting vlan TX "offload"' with new hints capabilities? This woul=
d be
> pretty neat.
>
> But you think AF_INET TX is worth keeping for now, until TX hints are mat=
ure?
>
> > > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > > ---
> > >  tools/testing/selftests/bpf/network_helpers.c |  37 +++-
> > >  tools/testing/selftests/bpf/network_helpers.h |   3 +
> > >  .../selftests/bpf/prog_tests/xdp_metadata.c   | 175 +++++++---------=
--
> > >  3 files changed, 98 insertions(+), 117 deletions(-)
> > >
> > > diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/te=
sting/selftests/bpf/network_helpers.c
> > > index a105c0cd008a..19463230ece5 100644
> > > --- a/tools/testing/selftests/bpf/network_helpers.c
> > > +++ b/tools/testing/selftests/bpf/network_helpers.c
> > > @@ -386,28 +386,51 @@ char *ping_command(int family)
> > >     return "ping";
> > >  }
> > >
> > > +int get_cur_netns(void)
> > > +{
> > > +   int nsfd;
> > > +
> > > +   nsfd =3D open("/proc/self/ns/net", O_RDONLY);
> > > +   ASSERT_GE(nsfd, 0, "open /proc/self/ns/net");
> > > +   return nsfd;
> > > +}
> > > +
> > > +int get_netns(const char *name)
> > > +{
> > > +   char nspath[PATH_MAX];
> > > +   int nsfd;
> > > +
> > > +   snprintf(nspath, sizeof(nspath), "%s/%s", "/var/run/netns", name)=
;
> > > +   nsfd =3D open(nspath, O_RDONLY | O_CLOEXEC);
> > > +   ASSERT_GE(nsfd, 0, "open /proc/self/ns/net");
> > > +   return nsfd;
> > > +}
> > > +
> > > +int set_netns(int netns_fd)
> > > +{
> > > +   return setns(netns_fd, CLONE_NEWNET);
> > > +}
> >
> > We have open_netns/close_netns in network_helpers.h that provide simila=
r
> > functionality, let's use them instead?
> >
>
> I have divided open_netns() into smaller pieces (see below), because the =
code I
> have added into xdp_metadata looked better with those smaller pieces (I h=
ad to
> switch namespace several times).

Forgot to reply to this part. I missed the fact that you're extending
network_helpers, sorry.
But why do we need extra namespaces at all?

