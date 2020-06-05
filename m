Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88B361EFBE5
	for <lists+bpf@lfdr.de>; Fri,  5 Jun 2020 16:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbgFEOxz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Jun 2020 10:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727839AbgFEOxy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Jun 2020 10:53:54 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E35CC08C5C2
        for <bpf@vger.kernel.org>; Fri,  5 Jun 2020 07:53:53 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id o15so10397396ejm.12
        for <bpf@vger.kernel.org>; Fri, 05 Jun 2020 07:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=aYBimq73plyo4JsuWnszJuZkFsHKcX8NbkajF0wTUdY=;
        b=AAZ1bY0TljnBJAy+XO1rlODzdla4ORRMxpvo4XKlQ/10mqD/2fBJhV/EaqdYQlXaU+
         TtV1wQ1lxmjQCgaNVo7yLM6do7Fs8myFZonjqUhqw7fS8i0U83StuKW2oG3glxpoCInT
         cmJx7ZrvEpTfvt7boODw2xV6cUZzhxexmlWys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=aYBimq73plyo4JsuWnszJuZkFsHKcX8NbkajF0wTUdY=;
        b=OJ+7aJ8lgA8xPwMH309mGt54IFAKz8ji/ELeJATAgfkKg58FgmomqBWTb5QutGa65I
         0w/Bg/pjjy9yr8QideJLcuQSZVModfWRlADAGKZQMb6R+lGkrLJbEoqK0FGhSsCmBh1e
         VVLnEqs/Xu7Xef6cMoMoqbuu25v/M7DhLNs4BzI7BuMoT1XSaPEIvD7lq7PkwYGoFjzs
         YAqFJLULCUQfwhPeFtcu1eHolyBmpCkjAMxAFvYq3vpvRkwU7D6x9C5sP0OIRy95k1Kk
         oG+VaZUZ6Brao3tafac3eXI3owK1IAB2SB9lSiwGz9+Zs4+5w1UDkPIZZceuGF0LJAT4
         tNCg==
X-Gm-Message-State: AOAM5320Ql9cT5dumrG7cl24dVnxqKAZvoIZPJ2wisqubNN9rHu+7XrV
        nyt+SIAqujAq/xxotfofXGQsG3PQHRU=
X-Google-Smtp-Source: ABdhPJziqxQ+oI9F47MW4cxr3WqzrNiTTLvNbvA6GNdFFy/hB/ZVLZFBaEYRJnfqtGIOuLKkI2+ABg==
X-Received: by 2002:a17:906:3bd7:: with SMTP id v23mr8527519ejf.299.1591368832101;
        Fri, 05 Jun 2020 07:53:52 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id b24sm5046651edw.70.2020.06.05.07.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 07:53:51 -0700 (PDT)
References: <20200605124011.71043-1-wangli09@kuaishou.com>
User-agent: mu4e 1.1.0; emacs 26.3
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Wang Li <wangli8850@gmail.com>
Cc:     bpf@vger.kernel.org, daniel@iogearbox.net,
        Wang Li <wangli09@kuaishou.com>,
        huangxuesen <huangxuesen@kuaishou.com>,
        yangxingwu <yangxingwu@kuaishou.com>
Subject: Re: [PATCH] bpf: export the net namespace for bpf_sock_ops
In-reply-to: <20200605124011.71043-1-wangli09@kuaishou.com>
Date:   Fri, 05 Jun 2020 16:53:50 +0200
Message-ID: <875zc536o1.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jun 05, 2020 at 02:40 PM CEST, Wang Li wrote:
> Sometimes we need net namespace as part of the key for BPF_MAP_TYPE_SOCKHASH to
> distinguish the connections with same five-tuples, for example when we do the
> sock_map acceleration for the proxy that uses 127.0.0.1 to 127.0.0.1 connections
> in different containers on same node.
> And we export the netns inum instead of the real pointer of struct net to avoid
> the potential security issue.
>
> Signed-off-by: Wang Li <wangli09@kuaishou.com>
> Signed-off-by: huangxuesen <huangxuesen@kuaishou.com>
> Signed-off-by: yangxingwu <yangxingwu@kuaishou.com>
> ---
>  include/uapi/linux/bpf.h       |  2 ++
>  net/core/filter.c              | 17 +++++++++++++++++
>  tools/include/uapi/linux/bpf.h |  2 ++
>  3 files changed, 21 insertions(+)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index c65b374a5090..0fe7e459f023 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -3947,6 +3947,8 @@ struct bpf_sock_ops {
>  				 * there is a full socket. If not, the
>  				 * fields read as zero.
>  				 */
> +	__u32 netns_inum;	/* The net namespace this sock belongs to */
> +

In uapi/linux/bpf.h we have a field `netns_ino` for storing net
namespace inode number in a couple structs (bpf_prog_info,
bpf_map_info). Would be nice to keep the naming constent.

>  	__u32 snd_cwnd;
>  	__u32 srtt_us;		/* Averaged RTT << 3 in usecs */
>  	__u32 bpf_sock_ops_cb_flags; /* flags defined in uapi/linux/tcp.h */
> diff --git a/net/core/filter.c b/net/core/filter.c
> index d01a244b5087..bfe448ace25f 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -8450,6 +8450,23 @@ static u32 sock_ops_convert_ctx_access(enum bpf_access_type type,
>  					       is_fullsock));
>  		break;
>
> +	case offsetof(struct bpf_sock_ops, netns_inum):
> +#ifdef CONFIG_NET_NS
> +		*insn++ = BPF_LDX_MEM(BPF_FIELD_SIZEOF(
> +						struct bpf_sock_ops_kern, sk),
> +				      si->dst_reg, si->src_reg,
> +				      offsetof(struct bpf_sock_ops_kern, sk));
> +		*insn++ = BPF_LDX_MEM(BPF_FIELD_SIZEOF(
> +						struct sock_common, skc_net),
> +				      si->dst_reg, si->dst_reg,
> +				      offsetof(struct sock_common, skc_net));
> +		*insn++ = BPF_LDX_MEM(BPF_W, si->dst_reg, si->dst_reg,
> +				      offsetof(struct net, ns.inum));
> +#else
> +		*insn++ = BPF_MOV32_IMM(si->dst_reg, 0);
> +#endif
> +		break;
> +
>  	case offsetof(struct bpf_sock_ops, state):
>  		BUILD_BUG_ON(sizeof_field(struct sock_common, skc_state) != 1);
>
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index c65b374a5090..0fe7e459f023 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -3947,6 +3947,8 @@ struct bpf_sock_ops {
>  				 * there is a full socket. If not, the
>  				 * fields read as zero.
>  				 */
> +	__u32 netns_inum;	/* The net namespace this sock belongs to */
> +
>  	__u32 snd_cwnd;
>  	__u32 srtt_us;		/* Averaged RTT << 3 in usecs */
>  	__u32 bpf_sock_ops_cb_flags; /* flags defined in uapi/linux/tcp.h */
