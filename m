Return-Path: <bpf+bounces-51674-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7857A3706B
	for <lists+bpf@lfdr.de>; Sat, 15 Feb 2025 20:35:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B642188F026
	for <lists+bpf@lfdr.de>; Sat, 15 Feb 2025 19:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B991F418B;
	Sat, 15 Feb 2025 19:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gYE4gX+N"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D7478F4B;
	Sat, 15 Feb 2025 19:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739648120; cv=none; b=Tj6te9Sc3aWduBqpAd+vJy8/m8hg9KU9+WBkmp2EjoF1QDqpi5Lxa88O1S8H17CKuTP8OpXrn89U+bq2+meOw8WxKKF/oruXaGziILJ4y3Z7SR+WVzWuZx3qtox/F5TywvtCBEmEo9LSEK4Ntf0JyfInJvdUEea4JIpN/T/aaB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739648120; c=relaxed/simple;
	bh=wegczsd6XOKYBsX+gnuBTpfeKkjK6rrGqaYh464xji0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VuPzjceNuPIO9QkxZVR6XPFr7y7LpZXOe5CygnwIytwGvDOnfvNT3NkQTyrmSitCtxM1HLH1DiknSEHAVDU8z0jPSw20Pt1w/gJTrKofzegmuxpFhXZdLb5fZdEFEIlsqAFP0q5yyDgeLkdthaOyX1UenLF415njyr3t6v5WKDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gYE4gX+N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 460E8C4CEDF;
	Sat, 15 Feb 2025 19:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739648119;
	bh=wegczsd6XOKYBsX+gnuBTpfeKkjK6rrGqaYh464xji0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gYE4gX+NtdK2pFPol32q92jiM+nPigLaeycCoLF0sTktOYOhipIs4odo+wIqfjbdp
	 gLrB8HUDlTbzLSfh0YgD/aE0OKQlGL2o2SCwG0zM2heas5re/YZv8sKzHI9QF0759o
	 Q9MeoyNiAPxT+PtiShoeDaaTaizXuvu/wpSmi29Bqj6bm9d+YFxBDrXuPetTgt5kyo
	 PWaQ/VhJOZVf6GFXBV6T79MhU6xNWMPHgqsndOH2OgOobuX0Xnlu+ZYvaou6y/2QBr
	 scdsgLvhgokwn7rxzbR2uuK4JaUyBKDDqcYs5R8osptIm78XoQTucJpJmI+RXoPSi2
	 MbLaN/l92BaMg==
Date: Sat, 15 Feb 2025 11:35:17 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Amery Hung <ameryhung@gmail.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, alexei.starovoitov@gmail.com, martin.lau@kernel.org,
 edumazet@google.com, xiyou.wangcong@gmail.com, cong.wang@bytedance.com,
 jhs@mojatatu.com, sinquersw@gmail.com, toke@redhat.com, jiri@resnulli.us,
 stfomichev@gmail.com, ekarani.silvestre@ccc.ufcg.edu.br,
 yangpeihao@sjtu.edu.cn, yepeilin.cs@gmail.com, kernel-team@meta.com
Subject: Re: [PATCH bpf-next v4 15/19] bpf: net_sched: Disable attaching bpf
 qdisc to non root
Message-ID: <20250215113517.71c0553d@kernel.org>
In-Reply-To: <20250210174336.2024258-16-ameryhung@gmail.com>
References: <20250210174336.2024258-1-ameryhung@gmail.com>
	<20250210174336.2024258-16-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Feb 2025 09:43:29 -0800 Amery Hung wrote:
> Do not allow users to attach bpf qdiscs to classful qdiscs. This is to
> prevent accidentally breaking existings classful qdiscs if they rely on
> some data in the child qdisc. This restriction can potentially be lifted
> in the future. Note that, we still allow bpf qdisc to be attached to mq.

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

