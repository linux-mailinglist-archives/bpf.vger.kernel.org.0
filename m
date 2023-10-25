Return-Path: <bpf+bounces-13259-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9A17D729C
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 19:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4BD9B211B6
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 17:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F94030F9F;
	Wed, 25 Oct 2023 17:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rBJ0cL9N"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD742D62F
	for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 17:48:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 333F0C433C8;
	Wed, 25 Oct 2023 17:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698256133;
	bh=bo+ByBaRQViMRD/Z8LSNQSSyvlY2N8+wH0rGmClnrAI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rBJ0cL9Ne7kgGimRgHi2JdQqJf2vLIQKIus+qsHLVwB8szMExta3KFFnqvSdMZsnU
	 rsQpvBvkx3+pQRjHYNnkb04/RpnXofiPzy4hMx0V3DkdEzUvpqp0YuiXc10LxZtuKo
	 xd5iHuNwveq9peXOrqpX4m6PgCnyQzECZiPfscPwHsKV49kL99q0HJo0rZ2IWGI+c7
	 iMF4nmaNs2WceUSgCDrcjpKwHXHEDFkLVHqVgPGK9Fzs0DEt8KFQOo+e6lp91nJloV
	 XSEWTUFSz0sWxZmPFgOyfrb2SuNnLe/xKuU08rWgH89V8YC0TBtnpmtWvDa59s2b3Z
	 LJL+40GqEcsQA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id A157D4035D; Wed, 25 Oct 2023 14:48:50 -0300 (-03)
Date: Wed, 25 Oct 2023 14:48:50 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: andrii.nakryiko@gmail.com, jolsa@kernel.org, ast@kernel.org,
	daniel@iogearbox.net, eddyz87@gmail.com, martin.lau@linux.dev,
	song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
	mykolal@fb.com, bpf@vger.kernel.org
Subject: Re: [PATCH v4 dwarves 0/5] pahole, btf_encoder: support
 --btf_features
Message-ID: <ZTlVAtFw7oKaFrvl@kernel.org>
References: <20231023095726.1179529-1-alan.maguire@oracle.com>
 <ZTlTpYYVoYL0fls7@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTlTpYYVoYL0fls7@kernel.org>
X-Url: http://acmel.wordpress.com

Em Wed, Oct 25, 2023 at 02:43:02PM -0300, Arnaldo Carvalho de Melo escreveu:
> But 'bpftool bpf' doesn't like it:
 
>   $ bpftool btf dump file vmlinux.v5.19.0-rc5+.enum64 raw
>   Error: failed to load BTF from vmlinux.v5.19.0-rc5+.enum64: Invalid argument
>   $
 
> But it doesn't like it even when not using --btf_features :-\
> 
>   $ cp vmlinux.v5.19.0-rc5+ vmlinux.v5.19.0-rc5+.default_btf_encode ; pahole --btf_encode vmlinux.v5.19.0-rc5+.default_btf_encode
>   $ bpftool btf dump file vmlinux.v5.19.0-rc5+.default_btf_encode raw | wc -l
>   Error: failed to load BTF from vmlinux.v5.19.0-rc5+.default_btf_encode: Invalid argument
>   0
>   $ 
 
> I'll try to root cause this problem...

Random old bpftool on this notebook was the cause, nevermind, I'm back
testing this, sorry for the noise :-)

- Arnaldo

