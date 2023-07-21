Return-Path: <bpf+bounces-5640-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 673F675CFF4
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 18:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 984C71C21743
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 16:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A27D200AD;
	Fri, 21 Jul 2023 16:44:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC6C200A4
	for <bpf@vger.kernel.org>; Fri, 21 Jul 2023 16:44:39 +0000 (UTC)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD4010E
	for <bpf@vger.kernel.org>; Fri, 21 Jul 2023 09:44:29 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-783698a37beso97323239f.0
        for <bpf@vger.kernel.org>; Fri, 21 Jul 2023 09:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689957869; x=1690562669;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V4OProLwa1HBsCbSYEasskJSriVq6OZzQbg8GckWVaw=;
        b=mPrQK5Y3TwhUK0ThN4Jk2VHYg6uJxld5kkrt77HnmDbGjnA/6+yVY1PMnYBViHNexJ
         yBcdUFmia72m/UkL0qM2PuGiK6/tNarHCQ88f138vL1b6HdiC9T0kKFzKtblVMjcQJ6F
         aSTJj/So3ncOWlKabQiDB3Z2M0OFnse0LemYP+nGIUb1F/bNryeQmVVsZg/KBDVuJvNS
         n7LwAGwSUGyaTJDy0ikdvFhFKevCNonJDgiiFTDrvAIMnbGbAPRVFcVWTvJFzNPF3XQn
         yuFkjhSIWWfJOyov7ztZg4apNm8mclf9Qhz41oK80SaLFOh+khEaCjpeTjQHv2nLzb7K
         v3Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689957869; x=1690562669;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V4OProLwa1HBsCbSYEasskJSriVq6OZzQbg8GckWVaw=;
        b=Uev7wFjLyQVZiQ/tzMulTW7ljY0o7p6ei8l/O4RZQhdj7nYvXvq1yrtxuqoteQovC5
         URr+sIAhFYICPhqYFLpnjQ1TXP5cpuM4OhynJ1QMnQDOC0t6/ibx8p55dVFfjn706SGT
         M2trIsj/sYNScWr4inBjJh+Xuve2eQnj8zbl48iiDSrEWJ29Wp6fO0+z8Mr8UUwiWbE6
         l95rlk5cAnyMCZQzKXqt+Zy1ToXUkB+AgcvmCNuSy8yc5HC1x/VuPr4DaDkerjDq9Xvu
         wclBBj7m8OKsA8ZaDceF3xSwOdFtcl/WQcq4/W0s5GUcuchC1sDrGPAEPrK4cJbgt2SB
         JMDQ==
X-Gm-Message-State: ABy/qLYTM+b4vbn4Yffc36YCBKI1jqvavRUMOw0lOLS8GGF0Ljdf6dWC
	y9s26m7DkvRtCKegreuFjHVWpYFcj1tb01GgUy2Cvg==
X-Google-Smtp-Source: APBJJlHiHToCKJWM9rth8/IfAfW5ySm0aJOdUu3O0OXip58+wsj8VD+/EygYvpU+NnZ1V7pWWzJXxib5ErH3P1cA63Q=
X-Received: by 2002:a05:6e02:1d88:b0:348:90c2:ba0a with SMTP id
 h8-20020a056e021d8800b0034890c2ba0amr502473ila.32.1689957868798; Fri, 21 Jul
 2023 09:44:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230719183734.21681-1-larysa.zaremba@intel.com>
 <20230719183734.21681-21-larysa.zaremba@intel.com> <ZLmxt3744Q1e42pT@google.com>
 <ZLo29C1kpx99+u6G@lincoln>
In-Reply-To: <ZLo29C1kpx99+u6G@lincoln>
From: Stanislav Fomichev <sdf@google.com>
Date: Fri, 21 Jul 2023 09:44:17 -0700
Message-ID: <CAKH8qBtqCnewzcn_rfgNYPYD3oWSaDbf0ws6bDKL3H6gK7x6cg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 20/21] selftests/bpf: Check VLAN tag and proto
 in xdp_metadata
To: "Zaremba, Larysa" <larysa.zaremba@intel.com>
Cc: "bpf@vger.kernel.org" <bpf@vger.kernel.org>, "ast@kernel.org" <ast@kernel.org>, 
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "andrii@kernel.org" <andrii@kernel.org>, 
	"martin.lau@linux.dev" <martin.lau@linux.dev>, "song@kernel.org" <song@kernel.org>, "yhs@fb.com" <yhs@fb.com>, 
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "kpsingh@kernel.org" <kpsingh@kernel.org>, 
	"haoluo@google.com" <haoluo@google.com>, "jolsa@kernel.org" <jolsa@kernel.org>, David Ahern <dsahern@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, Willem de Bruijn <willemb@google.com>, 
	"Brouer, Jesper" <brouer@redhat.com>, "Burakov, Anatoly" <anatoly.burakov@intel.com>, 
	"Lobakin, Aleksander" <aleksander.lobakin@intel.com>, Magnus Karlsson <magnus.karlsson@gmail.com>, 
	"Tahhan, Maryam" <mtahhan@redhat.com>, 
	"xdp-hints@xdp-project.net" <xdp-hints@xdp-project.net>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 21, 2023 at 12:47=E2=80=AFAM Zaremba, Larysa
<larysa.zaremba@intel.com> wrote:
>
> On Thu, Jul 20, 2023 at 03:14:15PM -0700, Stanislav Fomichev wrote:
> > On 07/19, Larysa Zaremba wrote:
> > > Verify, whether VLAN tag and proto are set correctly.
> > >
> > > To simulate "stripped" VLAN tag on veth, send test packet from VLAN
> > > interface.
> > >
> > > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> >
> > Acked-by: Stanislav Fomichev <sdf@google.com>
> >
> > > ---
> > >  .../selftests/bpf/prog_tests/xdp_metadata.c   | 22 +++++++++++++++++=
--
> > >  .../selftests/bpf/progs/xdp_metadata.c        |  4 ++++
> > >  2 files changed, 24 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c b/=
tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
> > > index 1877e5c6d6c7..6665cf0c59cc 100644
> > > --- a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
> > > +++ b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
> > > @@ -38,7 +38,15 @@
> > >  #define TX_MAC "00:00:00:00:00:01"
> > >  #define RX_MAC "00:00:00:00:00:02"
> > >
> > > +#define VLAN_ID 59
> > > +#define VLAN_ID_STR "59"
> >
> > I was looking whether we have some str(x) macro in the selftests,
> > but doesn't look like we have any...
> >
>
> I could add one, if you could hint me at the file, where it would need to=
 go.
> Or just add it locally for now?

Up to you. I feel like it's fine as is.

I was expecting to find something like the following in
tools/testing/selftests/bpf/testing_helpers.h:

#define __TO_STR(x) #x
#define TO_STR(x) __TO_STR(x)

We have similar patterns in:
tools/testing/selftests/bpf/sdt.h (_SDT_ARG_CONSTRAINT_STRING)
tools/testing/selftests/kvm/x86_64/smm_test.c (XSTR)
tools/tracing/rtla/src/utils.c (STR)

But nothing "generic" it seems...

> > > +#define VLAN_PROTO "802.1Q"
> > > +#define VLAN_PID htons(ETH_P_8021Q)
> > > +#define TX_NAME_VLAN TX_NAME "." VLAN_ID_STR
> > > +#define RX_NAME_VLAN RX_NAME "." VLAN_ID_STR
> > > +
> > >  #define XDP_RSS_TYPE_L4 BIT(3)
> > > +#define VLAN_VID_MASK 0xfff
> > >
> > >  struct xsk {
> > >     void *umem_area;
> > > @@ -215,6 +223,12 @@ static int verify_xsk_metadata(struct xsk *xsk)
> > >     if (!ASSERT_NEQ(meta->rx_hash_type & XDP_RSS_TYPE_L4, 0, "rx_hash=
_type"))
> > >             return -1;
> > >
> > > +   if (!ASSERT_EQ(meta->rx_vlan_tci & VLAN_VID_MASK, VLAN_ID, "rx_vl=
an_tci"))
> > > +           return -1;
> > > +
> > > +   if (!ASSERT_EQ(meta->rx_vlan_proto, VLAN_PID, "rx_vlan_proto"))
> > > +           return -1;
> > > +
> > >     xsk_ring_cons__release(&xsk->rx, 1);
> > >     refill_rx(xsk, comp_addr);
> > >
> > > @@ -248,10 +262,14 @@ void test_xdp_metadata(void)
> > >
> > >     SYS(out, "ip link set dev " TX_NAME " address " TX_MAC);
> > >     SYS(out, "ip link set dev " TX_NAME " up");
> > > -   SYS(out, "ip addr add " TX_ADDR "/" PREFIX_LEN " dev " TX_NAME);
> > > +
> > > +   SYS(out, "ip link add link " TX_NAME " " TX_NAME_VLAN
> > > +            " type vlan proto " VLAN_PROTO " id " VLAN_ID_STR);
> > > +   SYS(out, "ip link set dev " TX_NAME_VLAN " up");
> > > +   SYS(out, "ip addr add " TX_ADDR "/" PREFIX_LEN " dev " TX_NAME_VL=
AN);
> > >
> > >     /* Avoid ARP calls */
> > > -   SYS(out, "ip -4 neigh add " RX_ADDR " lladdr " RX_MAC " dev " TX_=
NAME);
> > > +   SYS(out, "ip -4 neigh add " RX_ADDR " lladdr " RX_MAC " dev " TX_=
NAME_VLAN);
> > >     close_netns(tok);
> > >
> > >     tok =3D open_netns(RX_NETNS_NAME);
> > > diff --git a/tools/testing/selftests/bpf/progs/xdp_metadata.c b/tools=
/testing/selftests/bpf/progs/xdp_metadata.c
> > > index d151d406a123..d3111649170e 100644
> > > --- a/tools/testing/selftests/bpf/progs/xdp_metadata.c
> > > +++ b/tools/testing/selftests/bpf/progs/xdp_metadata.c
> > > @@ -23,6 +23,9 @@ extern int bpf_xdp_metadata_rx_timestamp(const stru=
ct xdp_md *ctx,
> > >                                      __u64 *timestamp) __ksym;
> > >  extern int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, __u32 =
*hash,
> > >                                 enum xdp_rss_hash_type *rss_type) __k=
sym;
> > > +extern int bpf_xdp_metadata_rx_vlan_tag(const struct xdp_md *ctx,
> > > +                                   __u16 *vlan_tci,
> > > +                                   __be16 *vlan_proto) __ksym;
> > >
> > >  SEC("xdp")
> > >  int rx(struct xdp_md *ctx)
> > > @@ -57,6 +60,7 @@ int rx(struct xdp_md *ctx)
> > >             meta->rx_timestamp =3D 1;
> > >
> > >     bpf_xdp_metadata_rx_hash(ctx, &meta->rx_hash, &meta->rx_hash_type=
);
> > > +   bpf_xdp_metadata_rx_vlan_tag(ctx, &meta->rx_vlan_tci, &meta->rx_v=
lan_proto);
> > >
> > >     return bpf_redirect_map(&xsk, ctx->rx_queue_index, XDP_PASS);
> > >  }
> > > --
> > > 2.41.0
> > >
> >

