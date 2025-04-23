Return-Path: <bpf+bounces-56491-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D450A98D28
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 16:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 680F916B001
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 14:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E47427CCD7;
	Wed, 23 Apr 2025 14:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iFiWSNm7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A90149E17;
	Wed, 23 Apr 2025 14:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745418788; cv=none; b=sTxyITN750F9l9qdlDURQci1bkYzlsDefPOA0BNZolvpyJ+TsZVuRgOZ5AD7Epy2PQX06oiPGeVoLWxMi49EvZs197Ne6BFIEak8jBlMpBUYsMJgy+nao/x4f2j8T7Ek3TUrKAcXv0QygWOBQfeancjOgVLdsbAn9EEkyxUhPaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745418788; c=relaxed/simple;
	bh=6Vjv6CNYE2+vsxtYNTmfkhiexYbN+MV07B8fJlrr//g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YyyiIDeEy5yHsvl8SePpjbZpmQGO1tilFWq9vT2DTt8WeAxmEM+zjnfAGA0v39JsmeHWiGvu/2JadnlgPvPOGqm5lt6pUgMiGEzPBCUCdo5Bta05R7UtjLVv7CZnV7IT7GtChsRi5uYm6tooK56YVO+EJef1LzIcSzhmb9RVGaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iFiWSNm7; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-af6a315b491so5727910a12.1;
        Wed, 23 Apr 2025 07:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745418786; x=1746023586; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rAOksXM7Eq6BXKV/jMFIbr+hGJwQG+XC86lMB+LClnU=;
        b=iFiWSNm7+KcUuzMZjRUVktctsFUp4YHNjSKJu3q1n3ylcJjLnF0PUvt3enBQ83U89c
         YdBnxzqk4hHr/Z6ONprIDaxNqptAdrQ1Y/WTEwucBuBib+nUW+cZ+vrp+eGK9FMT1OeA
         Z1ySlnrUOig8YVM9rMErwwlg5gjGuMA1hAAvrq7ar3/aOmGJIm3O178Ej52otkjTgQ6n
         2VzIz0MCvYluRLlfXrHAPoO3A3pivbBZ1dHE7CnNGHHpRZ9jcABFTx0m0D7HJ8OYVnQC
         OQ1HGeZ/tBQZOwtd6tqpLlTit9DGwebrIAcF/86dwixfOmFqgnnpmziGJ50sxRsX3odp
         /Ntw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745418786; x=1746023586;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rAOksXM7Eq6BXKV/jMFIbr+hGJwQG+XC86lMB+LClnU=;
        b=eIKbvb4LR4Z6SKFEAjySm+o5e8uI1GQQ2hJlRftLdJsHSNHko3O8yj59LZz9ZC2mjV
         RS3pvkvVfA5rvsZaWTWWXr9nGzgf9gLwv1PG543hJjZyHb1OYLtV3lmelwfyyUH3Ht8P
         Y6hD2/fXFdjaYAE40THKyq2PS2S9XGFKsm/ATZ2hvjzjEHvxmUczWSbEydCmoUkkdp9V
         1ULl8a7osggZxESJgLHTmn2zDWqP8t8upvK54FeKEGG5j2caK1gFewEo3tU8IIrBRKjn
         6GRaOqw7wz2Qps76XD8vlJsZxxylpaqj9nhrrm4W5biQeiOGaIsGZvBpXFkIGSDV8fRo
         jhDw==
X-Forwarded-Encrypted: i=1; AJvYcCVqJ7UVLR6cxVOUX6MIJyDRNDBoaKC5IP9GUYHKXMDOs5KhuTU7LplgXqHmsKDIXBp6PgS/e6pG@vger.kernel.org, AJvYcCW7euRQZ90SQqK9TJkR3w5lrbihYfDxC1v8x06+QgZQrZu0zvJ8CQtFsukMxhECaE4ggz8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6Xa28fjuU9JgVC4OAy0VJ3gAZKVeRrUWE2b957Xk3t8Pxef5k
	l8uxwStjlbYPoGrhYxJzEueWgT8nx9XMm/rZPmM5Y8IXk+sF3FQ=
X-Gm-Gg: ASbGnctQj47LxMy9wBPXmAPAODQXD1B1fplniIFHWO8desBUnzMINI9Okp4JTExQ6NP
	FBo/afZhYoIdZstZsy68zBEXTpr0sDlcl3N+p0w5Px4KNhN6ShXvTNSuy2JQAcdWHe28ttTZD7r
	2ooNtDZ+q6cMVE/vOM8P8UGGZqKroOrqxG8Ef3p9vmIxtq0UdjbpTjbvkfdYQWaadQ6ts1Pw3Jy
	Wyu5iW3DoAcU1vnBelcKtY/hbhGmYXHk47PhfWlIyo45VNHZBaB96lJvRsWB/AS0ZwWQyut25ja
	SgnrrI8669zxEgNDNBcNoKRh+muljhige5PvSud+
X-Google-Smtp-Source: AGHT+IHcEVLy69C0sFAlwfHFc/f1+dw5mLbP02yyW2bRT+1IAb9sNcGDPBjpsKH2tKYj2MTpMd8I/w==
X-Received: by 2002:a05:6a21:1190:b0:203:ad33:1ae3 with SMTP id adf61e73a8af0-203cbc4bd8bmr29287889637.10.1745418786124;
        Wed, 23 Apr 2025 07:33:06 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73dbfaaf900sm10563475b3a.154.2025.04.23.07.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 07:33:05 -0700 (PDT)
Date: Wed, 23 Apr 2025 07:33:04 -0700
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
Message-ID: <aAj6IBZ4hsUS12f4@mini-arch>
References: <20250422-xdp-prog-bound-fix-v1-1-0b581fa186fe@kernel.org>
 <aAgdECkTiP-po7HP@mini-arch>
 <aAi80as6PpOeuWJU@lore-desk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aAi80as6PpOeuWJU@lore-desk>

On 04/23, Lorenzo Bianconi wrote:
> On Apr 22, Stanislav Fomichev wrote:
> > On 04/22, Lorenzo Bianconi wrote:
> > > In the current implementation if the program is bounded to a specific
> > > device, it will not be possible to perform XDP_REDIRECT into a DEVMAP
> > > or CPUMAP even if the program is not attached to the map entry. This
> > > seems in contrast with the explanation available in
> > > bpf_prog_map_compatible routine. Fix the issue taking into account
> > > even the attach program type and allow XDP dev bounded program to
> > > perform XDP_REDIRECT into maps if the attach type is not BPF_XDP_DEVMAP
> > > or BPF_XDP_CPUMAP.
> > > 
> > > Fixes: 3d76a4d3d4e59 ("bpf: XDP metadata RX kfuncs")
> > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > ---
> > >  kernel/bpf/core.c | 22 +++++++++++++++++++++-
> > >  1 file changed, 21 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> > > index ba6b6118cf504041278d05417c4212d57be6fca0..a33175efffc377edbfe281397017eb467bfbcce9 100644
> > > --- a/kernel/bpf/core.c
> > > +++ b/kernel/bpf/core.c
> > > @@ -2358,6 +2358,26 @@ static unsigned int __bpf_prog_ret0_warn(const void *ctx,
> > >  	return 0;
> > >  }
> > >  
> > > +static bool bpf_prog_dev_bound_map_compatible(struct bpf_map *map,
> > > +					      const struct bpf_prog *prog)
> > > +{
> > > +	if (!bpf_prog_is_dev_bound(prog->aux))
> > > +		return true;
> > > +
> > > +	if (map->map_type == BPF_MAP_TYPE_PROG_ARRAY)
> > > +		return false;
> > 
> > [..]
> > 
> > > +	if (map->map_type == BPF_MAP_TYPE_DEVMAP &&
> > > +	    prog->expected_attach_type != BPF_XDP_DEVMAP)
> > > +		return true;
> > > +
> > > +	if (map->map_type == BPF_MAP_TYPE_CPUMAP &&
> > > +	    prog->expected_attach_type != BPF_XDP_CPUMAP)
> > > +		return true;
> > 
> > Not sure I understand, what does it mean exactly? That it's ok to add
> > a dev-bound program to the dev/cpumap if the program itself is gonna
> > be attached only to the real device? Can you expand more on the specific
> > use-case?
> > 
> > The existing check makes sure that the dev-bound programs run only in the
> > contexts that have hw descriptors. devmap and cpumap don't satisfy
> > this constraint afaiu.
> 
> My use-case is to use a hw-metadata kfunc like bpf_xdp_metadata_rx_timestamp()
> to read hw timestamp from the NIC and then redirect the xdp_buff into a DEVMP
> (please note there are no programs attached to any DEVMAP entries):
> 
> extern int bpf_xdp_metadata_rx_timestamp(const struct xdp_md *ctx,
> 					 __u64 *timestamp) __ksym;
> 
> struct {
> 	__uint(type, BPF_MAP_TYPE_DEVMAP);
> 	__uint(key_size, sizeof(__u32));
> 	__uint(value_size, sizeof(struct bpf_devmap_val));
> 	__uint(max_entries, 1);
> } dev_map SEC(".maps");
> 
> SEC("xdp")
> int xdp_meta_redirect(struct xdp_md *ctx)
> {
> 	__u64 timestamp;
> 
> 	...
> 	bpf_xdp_metadata_rx_timestamp(ctx, &timestamp);
> 	...
> 
> 	return bpf_redirect_map(&dev_map, ctx->rx_queue_index, XDP_PASS);
> }
> 
> According to my understanding this is feasible just if the "xdp_meta_redirect"
> program is bounded to a device otherwise the program is reject with the following
> error at load time:
> 
> libbpf: prog 'xdp_meta_redirect': BPF program load failed: -EINVAL
> libbpf: prog 'xdp_meta_redirect': -- BEGIN PROG LOAD LOG --
> metadata kfuncs require device-bound program
> processed 0 insns (limit 1000000) max_states_per_insn 0 total_states 0
> peak_states 0 mark_read 0
> -- END PROG LOAD LOG --
> 
> in order to fix it:
> 
> 	...
> 	index = if_nametoindex(DEV); 
> 	bpf_program__set_ifindex(prog, index);
> 	bpf_program__set_flags(prog, BPF_F_XDP_DEV_BOUND_ONLY);
> 	...
> 
> Doing so the program load still fails for the check in bpf_prog_map_compatible():
> 
> 	bool bpf_prog_map_compatible()
> 	{
> 		...
> 		if (bpf_prog_is_dev_bound(aux))
> 			return false;
> 		...

[..]
 
> In other words, a dev-bound XDP program can't interact with a DEVMAP (or
> CPUMAP) even if it is not attached to a map entry.
> I think if the XDP program is just running in the driver NAPI context
> it should be doable to use a hw-metada kfunc and perform a redirect into
> a DEVMAP or CPUMAP, right? Am I missing something?

Thanks for the info! Yes, that should work. I wonder if you hit
bpf_prog_select_runtime->bpf_check_tail_call->bpf_prog_map_compatible
path? Looks like we should not do bpf_prog_is_dev_bound in that case (the rest
of the bpf_prog_map_compatible callers should).

When doing a follow up, can you also extend tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
to cover these conditions? (redirect to empty map -> nop, adding
dev-bound program to devmap is einval).

