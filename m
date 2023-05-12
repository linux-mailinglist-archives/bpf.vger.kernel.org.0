Return-Path: <bpf+bounces-448-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28DD0700EE7
	for <lists+bpf@lfdr.de>; Fri, 12 May 2023 20:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EFD81C213C4
	for <lists+bpf@lfdr.de>; Fri, 12 May 2023 18:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37AB23D4F;
	Fri, 12 May 2023 18:34:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB7123D40
	for <bpf@vger.kernel.org>; Fri, 12 May 2023 18:34:08 +0000 (UTC)
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA8FE7695
	for <bpf@vger.kernel.org>; Fri, 12 May 2023 11:33:39 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-643fdfb437aso36935394b3a.0
        for <bpf@vger.kernel.org>; Fri, 12 May 2023 11:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683916416; x=1686508416;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5+exEN8RF1B40fPaxoi0k2T6E5J3rfhVEZNB9EwpzSM=;
        b=2ytWwJWpT3Nf+cnrsDcHH5KcIuij7GP+ouRdzIMCILh4WRZNrgSQNN19FSJ6vu+wm/
         g0+G/4bQvlOFdtBGD5dHnfuOdk5TdxYByrmDF/2aFlZR2UBLds/mJtqx7rVI/xdWNV8a
         A1sQZ3OALNJkgExEqH3hNisJlOeCU6VF+0abfQro0LL+7l/tUtTnsvTbjzSn/CFfEHbY
         JftijlPqjlutp/AJ42j6ITeno9LWWA0lSoxJy/tp7dLa+Ew/jHMGV8EWdRRN483nrDsw
         9YTIf9wrfY8U9jS72O3GInOWIoyv2ASsoGVZklk/M7us4MtfGa8fvueuzWf/66l5Ffps
         ZvDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683916416; x=1686508416;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5+exEN8RF1B40fPaxoi0k2T6E5J3rfhVEZNB9EwpzSM=;
        b=Pyg3HH8qnyesDZhY+aNwshKhwl8S4xew0mLzdrC4jmv9bndX2OnUKueXyfWbXoDNrz
         jsVbtm5JJjtzuSnEaiSp++aJV9JZK/MyUSp8HmpOSQshEoBewICGSNQgYVM2sHbvaKXk
         4Y+q9FRp6Y/BK0z8k327EvqOYYoNMFbbJm/JcZFDmMdkXRLU1VA8uD+jo4OAmuOBvtBF
         TOQXulup3kVzwBXAGLhXg4qlYq5N82tYn9fC+ZQHjti8dOfZNex6AGoGfn2v98c9xB3S
         DUxRAvjhHZorRtvyTWwqTjPRn689bL0+pBXacZ0zlGW3JKusiycN7L3TftuidANVn3dz
         5S9w==
X-Gm-Message-State: AC+VfDzR1sB9h4L1FDnbR59D0lL0iCEl88UpIj4YA9MVbQ4MHQTWPas4
	bBngDgjwDJRGcRQXJ3i9aszEMe4=
X-Google-Smtp-Source: ACHHUZ6izS/sXksepkikL2WJhUgl6hDj55lJDgbldJSMaJRr8WAp/vT3O0/iHqJ2+q6vfS70QyzAspA=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:90b:23c8:b0:250:2099:783 with SMTP id
 md8-20020a17090b23c800b0025020990783mr8403658pjb.2.1683916415913; Fri, 12 May
 2023 11:33:35 -0700 (PDT)
Date: Fri, 12 May 2023 11:33:34 -0700
In-Reply-To: <20230512152607.992209-14-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230512152607.992209-1-larysa.zaremba@intel.com> <20230512152607.992209-14-larysa.zaremba@intel.com>
Message-ID: <ZF6GfoZVgKX78bpq@google.com>
Subject: Re: [PATCH RESEND bpf-next 13/15] selftests/bpf: Allow VLAN packets
 in xdp_hw_metadata
From: Stanislav Fomichev <sdf@google.com>
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Jiri Olsa <jolsa@kernel.org>, Jesse Brandeburg <jesse.brandeburg@intel.com>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Anatoly Burakov <anatoly.burakov@intel.com>, 
	Jesper Dangaard Brouer <brouer@redhat.com>, Alexander Lobakin <alexandr.lobakin@intel.com>, 
	Magnus Karlsson <magnus.karlsson@gmail.com>, Maryam Tahhan <mtahhan@redhat.com>, 
	xdp-hints@xdp-project.net, netdev@vger.kernel.org, 
	intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 05/12, Larysa Zaremba wrote:
> Make VLAN c-tag and s-tag XDP hint testing more convenient
> by not skipping VLAN-ed packets.
> 
> Allow both 802.1ad and 802.1Q headers.

Can we also extend non-hw test? That should require adding metadata
handlers to veth to extract relevant parts from skb + update ip link
commands to add vlan id. Should be relatively easy to do?

> 
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> ---
>  tools/testing/selftests/bpf/progs/xdp_hw_metadata.c | 9 ++++++++-
>  tools/testing/selftests/bpf/xdp_metadata.h          | 8 ++++++++
>  2 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c b/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
> index b2dfd7066c6e..f95f82a8b449 100644
> --- a/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
> +++ b/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
> @@ -26,15 +26,22 @@ int rx(struct xdp_md *ctx)
>  {
>  	void *data, *data_meta, *data_end;
>  	struct ipv6hdr *ip6h = NULL;
> -	struct ethhdr *eth = NULL;
>  	struct udphdr *udp = NULL;
>  	struct iphdr *iph = NULL;
>  	struct xdp_meta *meta;
> +	struct ethhdr *eth;
>  	int err;
>  
>  	data = (void *)(long)ctx->data;
>  	data_end = (void *)(long)ctx->data_end;
>  	eth = data;
> +
> +	if (eth + 1 < data_end && eth->h_proto == bpf_htons(ETH_P_8021AD))
> +		eth = (void *)eth + sizeof(struct vlan_hdr);
> +
> +	if (eth + 1 < data_end && eth->h_proto == bpf_htons(ETH_P_8021Q))
> +		eth = (void *)eth + sizeof(struct vlan_hdr);
> +
>  	if (eth + 1 < data_end) {
>  		if (eth->h_proto == bpf_htons(ETH_P_IP)) {
>  			iph = (void *)(eth + 1);
> diff --git a/tools/testing/selftests/bpf/xdp_metadata.h b/tools/testing/selftests/bpf/xdp_metadata.h
> index 938a729bd307..6664893c2c77 100644
> --- a/tools/testing/selftests/bpf/xdp_metadata.h
> +++ b/tools/testing/selftests/bpf/xdp_metadata.h
> @@ -9,6 +9,14 @@
>  #define ETH_P_IPV6 0x86DD
>  #endif
>  
> +#ifndef ETH_P_8021Q
> +#define ETH_P_8021Q 0x8100
> +#endif
> +
> +#ifndef ETH_P_8021AD
> +#define ETH_P_8021AD 0x88A8
> +#endif
> +
>  struct xdp_meta {
>  	__u64 rx_timestamp;
>  	__u64 xdp_timestamp;
> -- 
> 2.35.3
> 

