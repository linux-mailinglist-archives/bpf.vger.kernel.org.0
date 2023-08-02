Return-Path: <bpf+bounces-6674-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A6B776C35F
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 05:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8F522816E4
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 03:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D152EA9;
	Wed,  2 Aug 2023 03:11:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63884A40;
	Wed,  2 Aug 2023 03:11:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B35ECC433C7;
	Wed,  2 Aug 2023 03:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690945915;
	bh=CmnnK8zYiKsDq01pvQjYDCtHkb9Ykb+uLjbwu09/f7w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Bjgw1CRkvVnBkwtqI5QggkmFgWCnpmhUBmeQYZj3K9G6FaL/tdboIAw4BleOzEDgx
	 +JMOrQigXpIR2CYSJSBRFNVperwZtrCkocu0lhb1a8JgnVRS0DsbFXTnD7syHIKXqn
	 l3mUxaMiVCr8U3p9hG7GeHG+iN5caLLmxptkm9Xxfc7TKN/PsMPjC6esVxUc9aovcH
	 hKI9JcrbA42lA0ci1BQAPtaX5a0oFdgtUcZKi67ZY8tiwmGqfcJ1iI5Dn22U+uz7oA
	 WqFsOBMSU02fxxlx+C62MzhuW/ySRbxJi0ImUCdD/gMGr3BOEJm8nVYbUNK30o94BH
	 W4R5S2+ee8rSQ==
Date: Tue, 1 Aug 2023 20:11:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Network Development
 <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, Jesper Dangaard Brouer
 <hawk@kernel.org>, Amritha Nambiar <amritha.nambiar@intel.com>, Alexander
 Lobakin <aleksander.lobakin@intel.com>
Subject: Re: [PATCH bpf-next 0/3] net: struct netdev_rx_queue and xdp.h
 reshuffling
Message-ID: <20230801201153.0b81d551@kernel.org>
In-Reply-To: <CAADnVQJdA25VBE+7Erw7-beL4+=fy1KtRA3ojN0o1yUztnyjjw@mail.gmail.com>
References: <20230802003246.2153774-1-kuba@kernel.org>
	<CAADnVQJdA25VBE+7Erw7-beL4+=fy1KtRA3ojN0o1yUztnyjjw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 1 Aug 2023 19:31:25 -0700 Alexei Starovoitov wrote:
> Especially considering that targeting bpf-next will exercise BPF CI...
> and it's not happy at the moment:
> ../net/netfilter/nf_conntrack_bpf.c: In function =E2=80=98bpf_xdp_ct_allo=
c=E2=80=99:
> ../net/netfilter/nf_conntrack_bpf.c:258:44: error: dereferencing
> pointer to incomplete type =E2=80=98struct xdp_buff=E2=80=99
> 258 | nfct =3D __bpf_nf_ct_alloc_entry(dev_net(ctx->rxq->dev),
> bpf_tuple, tuple__sz,
> |

ugh, will fix. allmodconfig apparently doesn't enable all of BPF :(

