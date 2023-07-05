Return-Path: <bpf+bounces-4087-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B2E748AC8
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 19:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58E5F1C20B7C
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 17:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1378B13AC4;
	Wed,  5 Jul 2023 17:41:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9D4134D8
	for <bpf@vger.kernel.org>; Wed,  5 Jul 2023 17:41:53 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75FE18E
	for <bpf@vger.kernel.org>; Wed,  5 Jul 2023 10:41:52 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5704970148dso70131117b3.3
        for <bpf@vger.kernel.org>; Wed, 05 Jul 2023 10:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688578912; x=1691170912;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZysTQEzsXNfv9/zc6i6AMHbJRPjccBtGTVYt/z+7iG8=;
        b=uzeZEtL533ctpHnx6mqkgSmvRqdcyz/y9qdWulRy6xihOQGLoEfkMePrkf5iXRlzo0
         uyNWaQwzqVytE5wtFiu0+6I+aCdwaGgQU6xFR/+2udx7QtU6QywGf+zLJcJtQo4bgcCk
         /5YzSlfNx8S+p+hi1EeD1ex9RotAJudkOTYXivUvhXoFPRGS+QimXd0VBXkI8yTYP6zk
         wE027LPgVIEe2BPMzV8QYwydqoRcyrk4ax0xMS92k/Ctftcg6SJv7t3vU1PWe7yXWs4g
         aTYfMIefw3s1kckVlvLXZtWCB2JugtRLVVo+7DEhOwbRvRx26z6ElLtMgRr5Iim+aa0T
         F6Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688578912; x=1691170912;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZysTQEzsXNfv9/zc6i6AMHbJRPjccBtGTVYt/z+7iG8=;
        b=dmlsDAQuXErWZZEounoK1Q4pJiXPDt/3CVSvCBQ7iF+BkAsHU3EUDYB8kNa1e3GuNr
         2JHW9rSIyg6HeeqzDVPm4f+7xXD7Te5zRhmh2WzFeq89k+yzF6yEu81nESKsQ/9A/n/u
         ZIdKdnLoN6m2p/jKMgOrXT196wUqsUcDnTV0VEQX7DPwRrYVXjG9HokhEqKRt2rvVKFe
         XPvwuUSieOwBuZBFDQ1Cm6zC9q4rWziHk1Fcdpo7aoMC9yYo2FPkoBa3Y3bkC2rQiIFz
         0DQqn5TtiUPBJm1MaAwmuK234U4xXhYr8Yx9J/GXZtPI6F8vBFN1i/FxAe69ZnwNhnbY
         dkiw==
X-Gm-Message-State: ABy/qLY6vyF7JcDdp6CBrGSyzLtZSDgMTBFNuMjuKSKRKj7+mZ/vnl1b
	91wRFYJYRI1nmncZxXnRtfClAak=
X-Google-Smtp-Source: APBJJlErCsnDy8jvP1Va18YPs7fh1ocFLM3/DnwGzVxPoHzApFhvOsuc+5wTbgY0ayky1lip5wKeonI=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a81:8412:0:b0:577:3712:125d with SMTP id
 u18-20020a818412000000b005773712125dmr117514ywf.4.1688578911887; Wed, 05 Jul
 2023 10:41:51 -0700 (PDT)
Date: Wed, 5 Jul 2023 10:41:50 -0700
In-Reply-To: <20230703181226.19380-21-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230703181226.19380-1-larysa.zaremba@intel.com> <20230703181226.19380-21-larysa.zaremba@intel.com>
Message-ID: <ZKWrXsDmjdR705LG@google.com>
Subject: Re: [PATCH bpf-next v2 20/20] selftests/bpf: check checksum level in xdp_metadata
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
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 07/03, Larysa Zaremba wrote:
> Verify, whether kfunc in xdp_metadata test correctly returns checksum level
> of zero.
> 
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>

Acked-by: Stanislav Fomichev <sdf@google.com>

> ---
>  tools/testing/selftests/bpf/prog_tests/xdp_metadata.c | 3 +++
>  tools/testing/selftests/bpf/progs/xdp_metadata.c      | 7 +++++++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
> index 50ac9f570bc5..6c71d712932e 100644
> --- a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
> @@ -228,6 +228,9 @@ static int verify_xsk_metadata(struct xsk *xsk)
>  	if (!ASSERT_EQ(meta->rx_vlan_proto, VLAN_PID, "rx_vlan_proto"))
>  		return -1;
>  
> +	if (!ASSERT_NEQ(meta->rx_csum_lvl, 0, "rx_csum_lvl"))
> +		return -1;
> +
>  	xsk_ring_cons__release(&xsk->rx, 1);
>  	refill_rx(xsk, comp_addr);
>  
> diff --git a/tools/testing/selftests/bpf/progs/xdp_metadata.c b/tools/testing/selftests/bpf/progs/xdp_metadata.c
> index 382984a5d1c9..6f7223d581b7 100644
> --- a/tools/testing/selftests/bpf/progs/xdp_metadata.c
> +++ b/tools/testing/selftests/bpf/progs/xdp_metadata.c
> @@ -26,6 +26,8 @@ extern int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, __u32 *hash,
>  extern int bpf_xdp_metadata_rx_vlan_tag(const struct xdp_md *ctx,
>  					__u16 *vlan_tag,
>  					__be16 *vlan_proto) __ksym;
> +extern int bpf_xdp_metadata_rx_csum_lvl(const struct xdp_md *ctx,
> +					__u8 *csum_level) __ksym;
>  
>  SEC("xdp")
>  int rx(struct xdp_md *ctx)
> @@ -62,6 +64,11 @@ int rx(struct xdp_md *ctx)
>  	bpf_xdp_metadata_rx_hash(ctx, &meta->rx_hash, &meta->rx_hash_type);
>  	bpf_xdp_metadata_rx_vlan_tag(ctx, &meta->rx_vlan_tag, &meta->rx_vlan_proto);
>  
> +	/* Same as with timestamp, zero is expected */
> +	ret = bpf_xdp_metadata_rx_csum_lvl(ctx, &meta->rx_csum_lvl);
> +	if (!ret && meta->rx_csum_lvl == 0)
> +		meta->rx_csum_lvl = 1;
> +
>  	return bpf_redirect_map(&xsk, ctx->rx_queue_index, XDP_PASS);
>  }
>  
> -- 
> 2.41.0
> 

