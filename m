Return-Path: <bpf+bounces-50456-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0365AA27E20
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 23:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90CAE166D83
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 22:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D55204F97;
	Tue,  4 Feb 2025 22:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="msbEOqiy"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D2B21ADA3;
	Tue,  4 Feb 2025 22:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738707535; cv=none; b=c+GbJ+ymVPlRliCnPH4NK6ZCP8Bi74/jYffZ5uC69ay/fQ1Y21HcxtKnYO+TSTOib4dZ3qM/zrCH7qaVcJofCzhTJzHk0XoiiAXXHEOvNcuh/5AuX/ifDFCNFnanGs+69V0alxOqhmD8s/o2OMz57IzbCMywbwocLCs1PAJkuOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738707535; c=relaxed/simple;
	bh=xi52YlCiURIzYt7oiiVPCmGs1xaM0138JGjoEXB0VmA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WU3N70hqTRrC1c0fVqEif07M5KL3ZnN47hVj7k2btL8yHAOIM47Bu3IwVk5Z5XhAaC5QDyhGxhqtKLBSGQ7edlb9TjxzV7//+Br6Ir6IKG5+bS4ghHm5UQrdwMf1Xqii8Og1KbOwEdkNz3s+tQCph8msRAVmlfH9B69ULiEqbUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=msbEOqiy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 643CCC4AF0D;
	Tue,  4 Feb 2025 22:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738707533;
	bh=xi52YlCiURIzYt7oiiVPCmGs1xaM0138JGjoEXB0VmA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=msbEOqiy+ou9MOC6AeV1xMv/m5svo19dMbeofq9kr9OHhgo/S2eTt9lMnHrtMKzdl
	 VKeA1FHWYDpONMh2DT/HGCXMb1Cz7NoiCDXwURjGNLlPApogfzUEGSL884MFIys2DU
	 Fe2MJANKbHwqk0atFce7uP90GHQW3PaIM6m+lPIrYjQL/KvClZ6exBNLzmoh1tKJqB
	 fCWd3PfcqO6OSpVnwh24+F4TfCqmNvIN0EvpH4KYB2aVwjVyfF7iptxlb70iVM7Ead
	 /XZaeW6OiyLkxYacqwkPddjnwLGkTSPjStDEQn5Z1b6MfyunqGd4z4GRWuydLKD6/x
	 PQxoo2qUNJ9wg==
Date: Tue, 4 Feb 2025 14:18:51 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Amery Hung <ameryhung@gmail.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, alexei.starovoitov@gmail.com, martin.lau@kernel.org,
 edumazet@google.com, xiyou.wangcong@gmail.com, cong.wang@bytedance.com,
 jhs@mojatatu.com, sinquersw@gmail.com, toke@redhat.com, jiri@resnulli.us,
 stfomichev@gmail.com, ekarani.silvestre@ccc.ufcg.edu.br,
 yangpeihao@sjtu.edu.cn, yepeilin.cs@gmail.com, ming.lei@redhat.com,
 kernel-team@meta.com
Subject: Re: [PATCH bpf-next v3 08/18] bpf: net_sched: Support
 implementation of Qdisc_ops in bpf
Message-ID: <20250204141851.522ae938@kernel.org>
In-Reply-To: <20250131192912.133796-9-ameryhung@gmail.com>
References: <20250131192912.133796-1-ameryhung@gmail.com>
	<20250131192912.133796-9-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 31 Jan 2025 11:28:47 -0800 Amery Hung wrote:
> +		if (new &&
> +		    !(parent->flags & TCQ_F_MQROOT) &&
> +		    new->ops->owner == BPF_MODULE_OWNER) {
> +			NL_SET_ERR_MSG(extack, "BPF qdisc not supported on a non root");
> +			return -EINVAL;
> +		}

This check should live in bpf_qdisc.c

