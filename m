Return-Path: <bpf+bounces-3570-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D964273FE89
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 16:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 167231C20B37
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 14:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E3218B1B;
	Tue, 27 Jun 2023 14:41:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A902017FF3;
	Tue, 27 Jun 2023 14:41:59 +0000 (UTC)
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E3610B;
	Tue, 27 Jun 2023 07:41:30 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 1820B32009DC;
	Tue, 27 Jun 2023 10:40:49 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 27 Jun 2023 10:40:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1687876848; x=1687963248; bh=23
	LSfnpCQSe9sALS5XMkK+l/AjvMu+sZbMvi4s8ol+c=; b=ISuPOdcKmEqpTwJ9xM
	fGBXDSQnObV1Lwts3ulXa1WXQgL1ztK9olS1PUWAhdX7yx49bviO1So2rGcIpRMi
	nS/+DbzsvXL5eRVGvr7AbddfDi/kpZZCA5cIa9XMGAoq9O+vfyjNODw6hZGzy/lb
	FXKowP1v7pGJkRdOvFXykLrwPFgLZ27B+1J9zOrnDUJwFyXgyDzwiZbDU3pwZts5
	QocC1vruVEUOHYR//PJqZLdXGIj+LUWT1etqkX6eDcvDlBJF390VxTYXKC809RHJ
	xeQ6efhiYbEGsXGNQPl5sKxMYg8DACWT1JdZCIXRxf0HcvsNfaBcd+ciD1cbZhR8
	QRhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1687876848; x=1687963248; bh=23LSfnpCQSe9s
	ALS5XMkK+l/AjvMu+sZbMvi4s8ol+c=; b=J9HwwN5jSMhgwGSMGKdEvqYHq126L
	1bo6d5jO2QeNSwe7rfPu8PegcrqmtVXcRQNac5o0osGV63e0sKyOjnSTtxRJ8RAW
	xhfFlmXs0g0AKWLfrmJ8pWYzx6zwDV1Lj39yFJP+FTReFtsEQNVYVCwwUzjXPi/A
	W5dtwrOsUgJYeIOnqBckQpio1plaIFYhbsxCcxAsJWasDNjo5RsXYq1sM5kBC2LC
	yR5oEzxA3tsADfmt0IDRSdzZVePfG/5vxa5zuLyYUZcglSSjkpnNXO6Dx9t+dr+s
	3yi/iILtVGmU5OMDDO6pB/P6h4HsBeDk7KuaWDEuK/AORj9toEk7z6l+Q==
X-ME-Sender: <xms:8PSaZHt235UF0UoNkomJtQPzGUHsIpZsFye7iklENBMTl-g-VWk7hg>
    <xme:8PSaZIcQ8r9fVLtJAuL2x_uMNKkFC3r7_wZSVDAsApgAEEcSlBNgfF5a_IQ0XWekx
    krTQvwy3JsNNakZ0Q>
X-ME-Received: <xmr:8PSaZKyrvnqOMvERwXsX8ew8tLTPtjx3-KuyPUEXh92ct-UQZqpzcP32FYz583FYo6DmlTK5sQ3jfS_gyfnd_BRSMLHl2qvgSMdW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrtddtgdefjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
    hrlhcuvffnffculdefhedmnecujfgurhepfffhvfevuffkfhggtggujgesthdtsfdttddt
    vdenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqeenuc
    ggtffrrghtthgvrhhnpedvfeekteduudefieegtdehfeffkeeuudekheduffduffffgfeg
    iedttefgvdfhvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:8PSaZGMM30BFXwS0gx_iyWrBQG0DFBCUNVFav1PWPPkkfIGAvkf4qw>
    <xmx:8PSaZH_8oIXddZ4i_6HOyuluC5K0UljOJusM9aE_8DPWy-hXbtvnJg>
    <xmx:8PSaZGU4YPBOQEQQTUnfBb4WOotHY10OyEYdByUXUjcwfzYErzgBdg>
    <xmx:8PSaZKZlr4bh8LCKP_1EfKJRp7KG27WOhqSxFQ16KKHgXBrmXg1Jrw>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Jun 2023 10:40:47 -0400 (EDT)
Date: Tue, 27 Jun 2023 08:40:46 -0600
From: Daniel Xu <dxu@dxuuu.xyz>
To: Florian Westphal <fw@strlen.de>
Cc: bpf@vger.kernel.org, qde@naccy.de, netdev@vger.kernel.org, 
	andrii.nakryiko@gmail.com
Subject: Re: [PATCH bpf-next v3 2/2] selftests/bpf: Add
 bpf_program__attach_netfilter helper test
Message-ID: <u6qj55s3ru7pdjot2twmagnpkdizlhmfxn5345fpueikaqxbia@wnwbjhrmuud6>
References: <20230627115839.1034-1-fw@strlen.de>
 <20230627115839.1034-3-fw@strlen.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627115839.1034-3-fw@strlen.de>
X-Spam-Status: No, score=-2.6 required=5.0 tests=ANY_BOUNCE_MESSAGE,BAYES_00,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
	VBOUNCE_MESSAGE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Florian,

On Tue, Jun 27, 2023 at 01:58:39PM +0200, Florian Westphal wrote:
> Call bpf_program__attach_netfilter() with different
> protocol/hook/priority combinations.
> 
> Test fails if supposedly-illegal attachments work
> (e.g., bogus protocol family, illegal priority and so on) or if a
> should-work attachment fails.  Expected output:
> 
>  ./test_progs -t netfilter_link_attach
>  #145/1   netfilter_link_attach/netfilter link attach 0:OK
>  #145/2   netfilter_link_attach/netfilter link attach 1:OK
>  #145/3   netfilter_link_attach/netfilter link attach 2:OK
>  #145/4   netfilter_link_attach/netfilter link attach 3:OK
>  #145/5   netfilter_link_attach/netfilter link attach 4:OK
>  #145/6   netfilter_link_attach/netfilter link attach 5:OK
>  #145/7   netfilter_link_attach/netfilter link attach 6:OK
>  #145/8   netfilter_link_attach/netfilter link attach 7:OK
>  #145/9   netfilter_link_attach/netfilter link attach 8:OK
>  #145     netfilter_link_attach:OK
> 
> Signed-off-by: Florian Westphal <fw@strlen.de>
> ---
>  .../bpf/prog_tests/netfilter_link_attach.c    | 88 +++++++++++++++++++
>  .../bpf/progs/test_netfilter_link_attach.c    | 14 +++
>  2 files changed, 102 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/netfilter_link_attach.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_netfilter_link_attach.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/netfilter_link_attach.c b/tools/testing/selftests/bpf/prog_tests/netfilter_link_attach.c
> new file mode 100644
> index 000000000000..dfec6c44f81d
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/netfilter_link_attach.c
> @@ -0,0 +1,88 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +#include <netinet/in.h>
> +#include <linux/netfilter.h>
> +
> +#include "test_progs.h"
> +#include "test_netfilter_link_attach.skel.h"
> +
> +struct nf_link_test {
> +	__u32 pf;
> +	__u32 hooknum;
> +	__s32 priority;
> +	__u32 flags;
> +
> +	bool expect_success;
> +};
> +
> +struct nf_link_test nf_hook_link_tests[] = {
> +	{  },
> +	{ .pf = NFPROTO_NUMPROTO, },
> +	{ .pf = NFPROTO_IPV4, .hooknum = 42, },
> +	{ .pf = NFPROTO_IPV4, .priority = INT_MIN },
> +	{ .pf = NFPROTO_IPV4, .priority = INT_MAX },
> +	{ .pf = NFPROTO_IPV4, .flags = UINT_MAX },
> +
> +	{ .pf = NFPROTO_INET, .priority = 1, },
> +
> +	{ .pf = NFPROTO_IPV4, .priority = -10000, .expect_success = true },
> +	{ .pf = NFPROTO_IPV6, .priority = 10001, .expect_success = true },
> +};
> +
> +void test_netfilter_link_attach(void)
> +{
> +	struct test_netfilter_link_attach *skel;
> +	struct bpf_program *prog;
> +	LIBBPF_OPTS(bpf_netfilter_opts, opts);
> +	int i;
> +
> +	skel = test_netfilter_link_attach__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "test_netfilter_link_attach__open_and_load"))
> +		goto out;
> +
> +	prog = skel->progs.nf_link_attach_test;
> +	if (!ASSERT_OK_PTR(prog, "attach program"))
> +		goto out;
> +
> +	for (i = 0; i < ARRAY_SIZE(nf_hook_link_tests); i++) {
> +		struct bpf_link *link;
> +		char name[128];
> +
> +		snprintf(name, sizeof(name), "netfilter link attach %u", i);
> +
> +		if (!test__start_subtest(name))
> +			continue;

Nit: naming by index makes it a little annoying to debug failures. How
about adding a name field to struct nf_link_test?

[...]

Thanks,
Daniel

