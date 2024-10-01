Return-Path: <bpf+bounces-40668-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 890F498BDEE
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 15:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 396171F22D9E
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 13:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25EE51C460C;
	Tue,  1 Oct 2024 13:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ik5o/jil"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29E11A00ED
	for <bpf@vger.kernel.org>; Tue,  1 Oct 2024 13:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727789772; cv=none; b=UgiSeIJ0RwmEFgUOKxRS1ULObGpHmG+/XZeFmoQaH6R4WbEIJq1/czpM/LtSrtjdUmAr6dzpIyuykFY8LfdE+M65wz9DdjB+fXtThKQ+FTkrmasfirIiHXaFXq8fI6z5ohzPT2M8gDxrsuBBK54Z3dot40mcVn2oDarE8rZQ8vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727789772; c=relaxed/simple;
	bh=wtgdWxHRRyAusLetff81acFBywcjMIZGjVm2DpCtpDA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hFrNgI2LFMVi4eveg5SkrUX4sbtdvvmzjiuAmRPSY21QJMAtOIdqiPH+cnISqiHb3bKWNKs8/ghAw4GTHoCLViLmBE4WH7+G3nX1er1BOMVTcbwExw37D/GXQcT3P3RIMIsTzyqKOfIOFO3Aa3fF8irxfTOGK2fKeHf9xsBiRb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ik5o/jil; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F276AC4CEC6;
	Tue,  1 Oct 2024 13:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727789772;
	bh=wtgdWxHRRyAusLetff81acFBywcjMIZGjVm2DpCtpDA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Ik5o/jilWIj+oUjt7QbdDgPwIP5KgNYohFfWHmtOFTCqNva3HvPWdir63aDE1CMQj
	 ZaZJ9YgKeKmPV/30oVMPCOmu5OQ3Y1ewnb9CC/g2DKTLek1dcq6Uf3smYs9SS0HvWX
	 C2lBXqzH3CA1SVKvojyNgxSMaVck9t00FZhTmX8mCZBQqaGDukUSSIvixSRpUVqTI1
	 CjumGBp1qMp+nKra33kHBp/wmNK0wgT9tc/MALw2S5NQHaYYMgVqsYo6Ks1FH6vx4E
	 cqm7jI2waecchoYyYawBAFIt+aTmlFOSgq9pCr3OWytmit/0JhWUlrpz7Az8y4buzU
	 G65nktS5oNU8A==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 861CF1580117; Tue, 01 Oct 2024 15:36:09 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To: Yury Vostrikov <mon@unformed.ru>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>
Cc: bpf@vger.kernel.org
Subject: Re: NULL pointer deref inside xdp_do_flush due to
 bpf_net_ctx_get_all_used_flush_lists
In-Reply-To: <5627f6d1-5491-4462-9d75-bc0612c26a22@app.fastmail.com>
References: <5627f6d1-5491-4462-9d75-bc0612c26a22@app.fastmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 01 Oct 2024 15:36:09 +0200
Message-ID: <875xqcq71y.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Yury Vostrikov" <mon@unformed.ru> writes:

> Hi,
>
> I stumbled upon a NULL pointer derefence inside BPF code. The triggering condition is 
> message from OOM killer + netconsole. The crash happens at 
>
> 	u32 kern_flags = bpf_net_ctx->ri.kern_flags;
>
> line of bpf_net_ctx_get_all_used_flush_lists() function. bpf_net_ctx is NULL here. With trivial fix
>
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index 7d7578a8eac1..cba16bf307f7 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -844,6 +844,9 @@ static inline void bpf_net_ctx_get_all_used_flush_lists(struct list_head **lh_ma
>                                                         struct list_head **lh_xsk)
>  {
>         struct bpf_net_context *bpf_net_ctx = bpf_net_ctx_get();
> +       WARN_ON(bpf_net_ctx == NULL);
> +       if (bpf_net_ctx == NULL)
> +               return;
>         u32 kern_flags = bpf_net_ctx->ri.kern_flags;
>         struct list_head *lh;
>  
> I get the following backtrace instead of crash:

[...]

> [  177.216474]  efx_poll+0x178/0x380 [sfc_siena]

Looks like the sfc driver is missing the context setup stuff entirely...

-Toke

