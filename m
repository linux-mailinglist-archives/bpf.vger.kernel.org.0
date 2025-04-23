Return-Path: <bpf+bounces-56496-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96046A9910B
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 17:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 195D91B86587
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 15:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A14328C5D0;
	Wed, 23 Apr 2025 15:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WqMHKsDn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0715028B4EA;
	Wed, 23 Apr 2025 15:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745420986; cv=none; b=OhVLC7zmB6OI4AR4X/9KidhARF9/5Sx98dGQRhw9engUWapbpkxceQoWdM6nog4xPVtJE5gV2voZCdYzv+y7TiiEDTFRgg7vFWjt0nI9ASHzzAMkaClXJAsVdhcdPbqybAyPAwqI4C99mGhXx40C1idpZoy3kqtlR5DGuvNFz7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745420986; c=relaxed/simple;
	bh=mJ2QmQEFlcsiPq05OXibmnIZMX98xAun/0Bd8vQ8h74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s8xG9TzH44upn+Eizpj2o8RZtfD1FzN1oPaQL2fGSzjiIt6qCtlsErtNo+EpCinz8gd9N0tAkCavddQFuWRruR1e5AJ/fmwSFJShvPNqUsG9vZgAHgbWp2IWzd/UQScCXTNbeSPsZK8aegQXvibGv7ZDjhxZlT/YRIM82lAQQHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WqMHKsDn; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-af91fc1fa90so5603365a12.0;
        Wed, 23 Apr 2025 08:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745420984; x=1746025784; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o3rPa8I79belhuSJBW7U9rJoyeLMEN3HyUU1cJZksbU=;
        b=WqMHKsDnPB6Yia8cqHkWNOwLt+Vi7z9CpFf0JEe4TFoMwAdyW+7vLOYjz+fvSbEZ01
         2g8aD12rSKYutKn3NlUEKtab4366zga36SEtO3DSDj8dRVVeno1m+Bw5Go+40Wm1AB+A
         3Y7Cv8HkjNUWrnUtAzrFNgk1dg4SvFxSWUVqSyyU75CsgIlqBXyPTSnvMIDi68BmuIJG
         Pmxpn53Lksd/Vv8wNl5jOB7ibVs4LYcYm+iOz6Dc5tydI3E1031sZTFNOjcHBWzjyT7U
         jVj2gf8joMA0mdwHHBwhO98GQkQfNYYobMI3ihBZP8hXtGVWc6M1dniX2lV5B4y6ZIh6
         MOXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745420984; x=1746025784;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o3rPa8I79belhuSJBW7U9rJoyeLMEN3HyUU1cJZksbU=;
        b=F7P+rjabqdMLPt8fr5e6/c90KueBuiTP6DJQGN/nGEUxpZ+tMuAaUOACVwG+5GU5VI
         kmZ2+kYEPqyLm2eWD16TiC9Qtemc8cCcEaUgfa47f/sXpSM28HusTXZZ60FBU9A/M3XR
         AqFk+Io4jODygwHmW32IM2I6YeCTT2RYazvoY2T5YHXBr7TXTfns7+RbJwLE1TEFcWvS
         Enw3uTAMUvfUBoT0QCOKyW+MieqxjAtrFNXeQ392j7zdAw2W9azK93EwcjmiTl3XgN5a
         JNrWxPNWv5AFSp5giYjk2dE/QWaJBqEe00Ze8fFpo4g+xTWHCHaBGSc6Refij5GWgrLO
         JvTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZ85cB57og0wNiPBC9IvTdtTNlYc3NSsPpRH26WFFbyXexUeI2DlUJsVOHp8kmuP4f/eY=@vger.kernel.org, AJvYcCXBXqbQdDtQ0r4e+nkWaRu+U+tdNaXNPKCbPFOFm6dFclLd9y9LC6CgZWxktuSkhjsiov/XS82Z@vger.kernel.org
X-Gm-Message-State: AOJu0YzWtQB/R0dibZ8FxgE6LII/oBYAtK6LRYqyLeRBnHmqExwX+YSq
	E4JQwrozTankebjLTxC3xYsLLKFQ2qjKL+Sjn9SeLk7LbflXeXU=
X-Gm-Gg: ASbGncvb9np/TJy/L4EbSWAkVUKHSATgtLX2hHTpHjXbfNOhpTrk5pSsUhZqhzGhWp5
	zi96mQIMd5kzFXMAPMnmthhShmV0lgDr+LRj0NUbgSSMz6ffeK4pESAgzStUplYI3S7Blh96AJm
	nsQfNTGmpQnjaFzERncU9RyfLDokoACb7+ocPoV0kfWKuHzQ9PF+4mVHq3j0erA0qrvkPS+kTo8
	PxOalJw0QxfZ3CxDoqmkuzMq4wKxRrtWW7SGVViS31DcpJczweuYqYhd0MAbROPTMwGKu8X2tf6
	YktHH/TZZ72dx9aEISbzuxETzKcPg1SXUJMyT4yUBH7Q+tF7OF0=
X-Google-Smtp-Source: AGHT+IGDspR2tsBX6soJVLkGe7DCaFNIoklaYxrABWOUxQL+LlWLIVvZIQPHa6SnLAOOMJoa4Oo2Hw==
X-Received: by 2002:a17:90b:2b8c:b0:2ee:c91a:acf7 with SMTP id 98e67ed59e1d1-3087bb41235mr28667893a91.4.1745420983963;
        Wed, 23 Apr 2025 08:09:43 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-309dfa28376sm1730423a91.25.2025.04.23.08.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 08:09:43 -0700 (PDT)
Date: Wed, 23 Apr 2025 08:09:42 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>, bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next] bpf: Allow XDP dev bounded program to perform
 XDP_REDIRECT into maps
Message-ID: <aAkCtq4pEi2cTKV3@mini-arch>
References: <20250422-xdp-prog-bound-fix-v1-1-0b581fa186fe@kernel.org>
 <aAgdECkTiP-po7HP@mini-arch>
 <aAi80as6PpOeuWJU@lore-desk>
 <aAj6IBZ4hsUS12f4@mini-arch>
 <aAj_ELYjc7cFDjSG@lore-desk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aAj_ELYjc7cFDjSG@lore-desk>

On 04/23, Lorenzo Bianconi wrote:
> > On 04/23, Lorenzo Bianconi wrote:
> > > On Apr 22, Stanislav Fomichev wrote:
> > > > On 04/22, Lorenzo Bianconi wrote:
> > > > > In the current implementation if the program is bounded to a specific
> > > > > device, it will not be possible to perform XDP_REDIRECT into a DEVMAP
> > > > > or CPUMAP even if the program is not attached to the map entry. This
> > > > > seems in contrast with the explanation available in
> > > > > bpf_prog_map_compatible routine. Fix the issue taking into account
> > > > > even the attach program type and allow XDP dev bounded program to
> > > > > perform XDP_REDIRECT into maps if the attach type is not BPF_XDP_DEVMAP
> > > > > or BPF_XDP_CPUMAP.
> > > > > 
> > > > > Fixes: 3d76a4d3d4e59 ("bpf: XDP metadata RX kfuncs")
> > > > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > > > ---
> > > > >  kernel/bpf/core.c | 22 +++++++++++++++++++++-
> > > > >  1 file changed, 21 insertions(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> > > > > index ba6b6118cf504041278d05417c4212d57be6fca0..a33175efffc377edbfe281397017eb467bfbcce9 100644
> > > > > --- a/kernel/bpf/core.c
> > > > > +++ b/kernel/bpf/core.c
> > > > > @@ -2358,6 +2358,26 @@ static unsigned int __bpf_prog_ret0_warn(const void *ctx,
> > > > >  	return 0;
> > > > >  }
> > > > >  
> > > > > +static bool bpf_prog_dev_bound_map_compatible(struct bpf_map *map,
> > > > > +					      const struct bpf_prog *prog)
> > > > > +{
> > > > > +	if (!bpf_prog_is_dev_bound(prog->aux))
> > > > > +		return true;
> > > > > +
> > > > > +	if (map->map_type == BPF_MAP_TYPE_PROG_ARRAY)
> > > > > +		return false;
> > > > 
> > > > [..]
> > > > 
> > > > > +	if (map->map_type == BPF_MAP_TYPE_DEVMAP &&
> > > > > +	    prog->expected_attach_type != BPF_XDP_DEVMAP)
> > > > > +		return true;
> > > > > +
> > > > > +	if (map->map_type == BPF_MAP_TYPE_CPUMAP &&
> > > > > +	    prog->expected_attach_type != BPF_XDP_CPUMAP)
> > > > > +		return true;
> > > > 
> > > > Not sure I understand, what does it mean exactly? That it's ok to add
> > > > a dev-bound program to the dev/cpumap if the program itself is gonna
> > > > be attached only to the real device? Can you expand more on the specific
> > > > use-case?
> > > > 
> > > > The existing check makes sure that the dev-bound programs run only in the
> > > > contexts that have hw descriptors. devmap and cpumap don't satisfy
> > > > this constraint afaiu.
> > > 
> > > My use-case is to use a hw-metadata kfunc like bpf_xdp_metadata_rx_timestamp()
> > > to read hw timestamp from the NIC and then redirect the xdp_buff into a DEVMP
> > > (please note there are no programs attached to any DEVMAP entries):
> > > 
> > > extern int bpf_xdp_metadata_rx_timestamp(const struct xdp_md *ctx,
> > > 					 __u64 *timestamp) __ksym;
> > > 
> > > struct {
> > > 	__uint(type, BPF_MAP_TYPE_DEVMAP);
> > > 	__uint(key_size, sizeof(__u32));
> > > 	__uint(value_size, sizeof(struct bpf_devmap_val));
> > > 	__uint(max_entries, 1);
> > > } dev_map SEC(".maps");
> > > 
> > > SEC("xdp")
> > > int xdp_meta_redirect(struct xdp_md *ctx)
> > > {
> > > 	__u64 timestamp;
> > > 
> > > 	...
> > > 	bpf_xdp_metadata_rx_timestamp(ctx, &timestamp);
> > > 	...
> > > 
> > > 	return bpf_redirect_map(&dev_map, ctx->rx_queue_index, XDP_PASS);
> > > }
> > > 
> > > According to my understanding this is feasible just if the "xdp_meta_redirect"
> > > program is bounded to a device otherwise the program is reject with the following
> > > error at load time:
> > > 
> > > libbpf: prog 'xdp_meta_redirect': BPF program load failed: -EINVAL
> > > libbpf: prog 'xdp_meta_redirect': -- BEGIN PROG LOAD LOG --
> > > metadata kfuncs require device-bound program
> > > processed 0 insns (limit 1000000) max_states_per_insn 0 total_states 0
> > > peak_states 0 mark_read 0
> > > -- END PROG LOAD LOG --
> > > 
> > > in order to fix it:
> > > 
> > > 	...
> > > 	index = if_nametoindex(DEV); 
> > > 	bpf_program__set_ifindex(prog, index);
> > > 	bpf_program__set_flags(prog, BPF_F_XDP_DEV_BOUND_ONLY);
> > > 	...
> > > 
> > > Doing so the program load still fails for the check in bpf_prog_map_compatible():
> > > 
> > > 	bool bpf_prog_map_compatible()
> > > 	{
> > > 		...
> > > 		if (bpf_prog_is_dev_bound(aux))
> > > 			return false;
> > > 		...
> > 
> > [..]
> >  
> > > In other words, a dev-bound XDP program can't interact with a DEVMAP (or
> > > CPUMAP) even if it is not attached to a map entry.
> > > I think if the XDP program is just running in the driver NAPI context
> > > it should be doable to use a hw-metada kfunc and perform a redirect into
> > > a DEVMAP or CPUMAP, right? Am I missing something?
> > 
> > Thanks for the info! Yes, that should work. I wonder if you hit
> > bpf_prog_select_runtime->bpf_check_tail_call->bpf_prog_map_compatible
> > path? Looks like we should not do bpf_prog_is_dev_bound in that case (the rest
> > of the bpf_prog_map_compatible callers should).
> 
> yes, the issue occurs at the program load time when we run
> bpf_prog_map_compatible() following the call path you pointed out:
> 
> bpf_prog_select_runtime() -> bpf_check_tail_call() -> bpf_prog_map_compatible()
> 
> Do you mean we should get rid of the bpf_prog_is_dev_bound() check in
> bpf_prog_map_compatible() and move it in the bpf_prog_map_compatible() callers
> instead? In particular:
> 
>  - __cpu_map_load_bpf_program()
>  - __dev_map_alloc_node()
>  - prog_fd_array_get_ptr()

Maybe move existing bpf_prog_map_compatible parts (except is_dev_bound)
into some new bpf_prog_map_compatible_type helper?

bpf_prog_map_compatible() {
  if (bpf_prog_is_dev_bound)
    return false;
  return bpf_prog_map_compatible_type(...);
}

And make bpf_check_tail_call call new bpf_prog_map_compatible_type. Not
sure about the naming though (as usual)..

