Return-Path: <bpf+bounces-62686-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 279EDAFCCFD
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 16:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38FF13BF8C5
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 14:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52CAF2DF3F9;
	Tue,  8 Jul 2025 14:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MuJy7CtW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2585D1AAC9;
	Tue,  8 Jul 2025 14:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751983655; cv=none; b=WezBVnFuZvU+wBEFm3wscAnnoQFbnzl95IDd/thSd1v4IOJgFmHH52NM43wql+mVh/RXtGWdgAg9K4BUto9BGyOEBgvZ4k0kptwId143OGLwOTkVvKI+JV1Lx2cPp8xifz1sKLiOR5wHeqydhEaIKn4NNGWD3jojhfNljKx5TrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751983655; c=relaxed/simple;
	bh=XtYekU4oMBGQ/78OQFk/F8VLZO46VRiFVamzO88MDP4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ngH5szLOIJYoYZRBCjnBX3VrJhGhONu29ATH32Eprpg4yG8NyV+6ic5VfpEOQd5h45qQyD8YCJB4DxLMBbfDVoRoBBEPMTKB00+CIT7RY0Jql3K9iKDVam+LRVoZ/XIp90LE6V2GRhy0F6xsEdCMXBB2FsQMw94rYjMOCzoqV98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MuJy7CtW; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a588da60dfso2975550f8f.1;
        Tue, 08 Jul 2025 07:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751983652; x=1752588452; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZSIc7doKYl4+ejpv14AEFTkLXhEcZMi5LX6/XHVRRTs=;
        b=MuJy7CtWsJpcQOCnsyWE8dK0LSt9HyppfsGB3lTKaX53hxg+i3DJS+2eRN5hDG81e4
         uHRgiU34IALr5NrSPUpg2XmyCCMqOCe0miVjFRunq273EMWSlm4KbuJ0OWDXBj89ASV5
         mCWcDWYVq3L7US1Fy2vYP0F4okytpcFsjoeEEJKw8lE1UzIb51quKE+mmn3keIyX9nwt
         sqeylec7KUX2CEgeH9RYK6f/9402pVDovYSxMQntwkFdFSjCM4AXT8rCaOqDd9MgrkTG
         ur3dHCzOrH+K3FLoN1ROr7BzgysuU4AZewe6vrrHYa0iipLnM31dSV0Y0taD6zWjBvGU
         GV5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751983652; x=1752588452;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZSIc7doKYl4+ejpv14AEFTkLXhEcZMi5LX6/XHVRRTs=;
        b=Gw7EupNTa51LsTAJPDTdQHAkydsHAqJ1rJAmxHY9oUx1jN8YLDr9LXjAODFGx+KQyy
         nS/lJLIYPTNBipePbvmQVGJNXktHCbgUfssEsaU4zfWbWJ3WhdaOJAwChCTm8pegkj/7
         HQobieBDGiSyfo5ebWKMVWcYi45gDWUJK1Ww3i9EarJeBJdox8DAKQB/HtdgYZF5C6gw
         Kkq44QEr++hKBon9vOSlK1xoCynvgj6BGRz/OM/cNrXatY9srB2RNib2xe6+usviNrhI
         NQbV66v5Ki5+OxFeKEhHfamMwjA0WPgbB9IwnaBllXbl5iBPC8DJwWxT8zhWdizYurns
         LUFw==
X-Forwarded-Encrypted: i=1; AJvYcCU3qXxo1RfIbRN8N8Pvpvn1IBIoBNN6ZF4qFeP+br+e60M0+rbXjPRS2txofm9x+XHAnC6x1WQWxsZga0qb1NW2@vger.kernel.org, AJvYcCVYvodzsPWh4A6Wv/S6hP6csX5xxxsPWIMXzQS811+rJx9SFuOP/oOXLEbRmNhsYHISIrTNO5po@vger.kernel.org, AJvYcCWW3vlzvtqa33GQQ/NBb+OC82uv4qF8nDUlHa1wU6T9FipYOaF6rAcbNWPlRlatNRCyK0Q=@vger.kernel.org, AJvYcCWjzu/DnSY/fZOsoxFN2n6PSUBhw+1zF3PR3CC18iUlIfE3Qtcfv58BMv5Ue6iJJ5WkHJJdbzMoCbki11S+3v84JBY8@vger.kernel.org, AJvYcCWnDLvyhZvW+5BvD3+mPZABpoApCwPzcW9CmDcBx8ZK/ALvfImP/Cx0895UTu/UDJyP+Dth+dlMEDPaztCJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxeUk6fi/bfpZMFMkLHQex66HrIa/lpE/yL9ybVoHGf1qxPSGrZ
	lUynxnC27N2Gynq+98JrD3VxsGDE2r5dHNNqE+zEkTyAW2Hw4d+KdUUo
X-Gm-Gg: ASbGnctLUd8WH5xp2sUypLpkELoM8VAKtxrbsDIiNewP33SXn7Oq/xIJ1zp6Zfnpz17
	V/DJo0ZOZK4b0GFauU7I1FjdreizXG/87dvnf3VOTphUea+IL0Pr6UGLnMBlrnxrtXw0FoPP7jO
	3y/pPiFF9jGWFK+8sw7Q/izyXMdB6+lVTCO8Zoo/5axpeRBUwNSFSMwgsijDzS9U8fU4K6uP5zZ
	rAUaw9UInpMWzFlB7ka2cnRk/hxtFyVx0bQubSfayOkLXVy9RIsDM2pOTb0Ms0JiBEH71DYc3Zp
	ejDL9jlgO/v/qNMzYnVKtjogbEZ19K3iCqZM
X-Google-Smtp-Source: AGHT+IE7BIUXTEm++bnBtleQHOgNx3TWg5lr0bN0zrDUdqQkcMivqssreu4mM/+hlXW8uGO/9+dJ9Q==
X-Received: by 2002:a05:6000:5c8:b0:3b3:9cb4:43f9 with SMTP id ffacd0b85a97d-3b4964c0a82mr12629087f8f.16.1751983651897;
        Tue, 08 Jul 2025 07:07:31 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::42b7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454cd39c622sm23216175e9.10.2025.07.08.07.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 07:07:31 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 8 Jul 2025 16:07:28 +0200
To: Tao Chen <chen.dylane@linux.dev>
Cc: daniel@iogearbox.net, razor@blackwall.org, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, ast@kernel.org, andrii@kernel.org,
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
	yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	mattbobrowski@google.com, rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, horms@kernel.org,
	willemb@google.com, jakub@cloudflare.com, pablo@netfilter.org,
	kadlec@netfilter.org, hawk@kernel.org, bpf@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org
Subject: Re: [PATCH bpf-next v2 0/7] Add attach_type in bpf_link
Message-ID: <aG0mIAK_59lhRj3D@krava>
References: <20250708082228.824766-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708082228.824766-1-chen.dylane@linux.dev>

On Tue, Jul 08, 2025 at 04:22:21PM +0800, Tao Chen wrote:
> Andrii suggested moving the attach_type into bpf_link, the previous discussion
> is as follows:
> https://lore.kernel.org/bpf/CAEf4BzY7TZRjxpCJM-+LYgEqe23YFj5Uv3isb7gat2-HU4OSng@mail.gmail.com
> 
> patch1 add attach_type in bpf_link, and pass it to bpf_link_init, which
> will init the attach_type field.
> 
> patch2-7 remove the attach_type in struct bpf_xx_link, update the info
> with bpf_link attach_type.
> 
> There are some functions finally call bpf_link_init but do not have bpf_attr
> from user or do not need to init attach_type from user like bpf_raw_tracepoint_open,
> now use prog->expected_attach_type to init attach_type.
> 
> bpf_struct_ops_map_update_elem
> bpf_raw_tracepoint_open
> bpf_struct_ops_test_run
> 
> Feedback of any kind is welcome, thanks.
> 
> Tao Chen (7):
>   bpf: Add attach_type in bpf_link
>   bpf: Remove attach_type in bpf_cgroup_link
>   bpf: Remove attach_type in sockmap_link
>   bpf: Remove location field in tcx_link
>   bpf: Remove attach_type in bpf_netns_link
>   bpf: Remove attach_type in bpf_tracing_link
>   netkit: Remove location field in netkit_link

with the other comment solved

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka


> 
>  drivers/net/netkit.c           | 10 ++++-----
>  include/linux/bpf-cgroup.h     |  1 -
>  include/linux/bpf.h            | 18 +++++++++------
>  include/net/tcx.h              |  1 -
>  kernel/bpf/bpf_iter.c          |  3 ++-
>  kernel/bpf/bpf_struct_ops.c    |  5 +++--
>  kernel/bpf/cgroup.c            | 17 +++++++--------
>  kernel/bpf/net_namespace.c     |  8 +++----
>  kernel/bpf/syscall.c           | 40 ++++++++++++++++++++--------------
>  kernel/bpf/tcx.c               | 16 +++++++-------
>  kernel/bpf/trampoline.c        | 10 +++++----
>  kernel/trace/bpf_trace.c       |  4 ++--
>  net/bpf/bpf_dummy_struct_ops.c |  3 ++-
>  net/core/dev.c                 |  3 ++-
>  net/core/sock_map.c            | 13 +++++------
>  net/netfilter/nf_bpf_link.c    |  3 ++-
>  16 files changed, 83 insertions(+), 72 deletions(-)
> 
> Change list:
>  v1 -> v2:
>   - fix build error.(Jiri)
>  v1:
>   - https://lore.kernel.org/bpf/20250707153916.802802-1-chen.dylane@linux.dev
> -- 
> 2.48.1
> 

