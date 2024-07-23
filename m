Return-Path: <bpf+bounces-35382-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E2F939E27
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 11:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A04EB281089
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 09:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688E614E2E1;
	Tue, 23 Jul 2024 09:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MgUVIOMQ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDB414D719;
	Tue, 23 Jul 2024 09:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721727903; cv=none; b=qRLsY8/5xDR3sq5IuW96buzCuogXpOFZ+iVCgroFflBysyoTad4dBJOMQtjs0DCg72BwvZ1xxo8Gb9ZbANMik44+uJcx3/5VlC5e8N+CwdpectRkxk5CPYgK42gw/y4Veji2dNYp0z0z9GS9OEEz0IWlsgAs2Xj2rS6oM769cTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721727903; c=relaxed/simple;
	bh=m2xIF4fhCBY1NEj1DmL5PlDA+40D/gQnfchARP//8hU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YwPJmMCGKKSKHE25MOfJl+Cpvvs25cMRm+cx5QJc8Ti6APpyw2EjK6rwzsMPF85vaW8ks138igAKRnjvqPEuiFCOkOsXVtKKK8y2vuprdGulWvtuf1idtEgnYIq0sNGUBJ/sRvs9G232FnG/dHVixlOFJppL7V/9oaKwrkLLIYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MgUVIOMQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB46AC4AF0A;
	Tue, 23 Jul 2024 09:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721727902;
	bh=m2xIF4fhCBY1NEj1DmL5PlDA+40D/gQnfchARP//8hU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MgUVIOMQPx3yyGwGMBe5VIxv/dZli+U+vY2bi9PCgzQdo+o6HA0pHPUsvKqW54gMc
	 duhAbug02xyWTbU3xYA+UuLpi2aeJKrqGxME01PzI3KaN+rlsM9DrChXD9hC35SG4Y
	 pYFfEhAcO10Ee470SCDb5zc4bzOSMKaanmhoZhdsIF3fNIOYAHena0DxCVZ6dmvu9v
	 JnjiwCnkKt+5Zw3uXm+akZKTF0joGIjHkG2JMKzXjLL+PyNBsyWUoV7NY3JA7wZEcB
	 yVJg1/NDXo591Ag/+D9VawzNrlSPAopahM2B5WO+gqZCbJoDOjf2F90ACM8z4pQEiO
	 XgM9ZuBKnbHEA==
Date: Tue, 23 Jul 2024 10:44:58 +0100
From: Simon Horman <horms@kernel.org>
To: Artem Savkov <asavkov@redhat.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v3] selftests/bpf: fix compilation failure when
 CONFIG_NET_FOU!=y
Message-ID: <20240723094458.GC24657@kernel.org>
References: <CAADnVQKE1Xmjhx3Xwdidmmn=BGzjgc89i+UMhHR7=6HupPQZSA@mail.gmail.com>
 <20240723071031.3389423-1-asavkov@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240723071031.3389423-1-asavkov@redhat.com>

On Tue, Jul 23, 2024 at 09:10:31AM +0200, Artem Savkov wrote:
> Without CONFIG_NET_FOU bpf selftests are unable to build because of
> missing definitions. Add ___local versions of struct bpf_fou_encap and
> enum bpf_fou_encap_type to fix the issue.
> 
> Signed-off-by: Artem Savkov <asavkov@redhat.com>
> 
> ---
> v3: swith from using BPF_NO_KFUNC_PROTOTYPES to casting to keep kfunc
> prototype intact.
> 
> v2: added BPF_NO_KFUNC_PROTOTYPES define to avoid issues when
> CONFIG_NET_FOU is set.
> ---
>  .../selftests/bpf/progs/test_tunnel_kern.c    | 26 ++++++++++++++-----
>  1 file changed, 20 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> index 3f5abcf3ff136..fcff3010d8a60 100644
> --- a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> +++ b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> @@ -26,6 +26,18 @@
>   */
>  #define ASSIGNED_ADDR_VETH1 0xac1001c8
>  
> +struct bpf_fou_encap___local {
> +       __be16 sport;
> +       __be16 dport;
> +};
> +
> +enum bpf_fou_encap_type___local {
> +       FOU_BPF_ENCAP_FOU___local,
> +       FOU_BPF_ENCAP_GUE___local,
> +};

nit: The above use spaces rather than tabs for indentation.

