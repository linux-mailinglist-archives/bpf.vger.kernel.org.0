Return-Path: <bpf+bounces-40660-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CD998BC28
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 14:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E23691F235AA
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 12:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879BC1C244D;
	Tue,  1 Oct 2024 12:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Nqa/LQcH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE7E18C358
	for <bpf@vger.kernel.org>; Tue,  1 Oct 2024 12:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727786007; cv=none; b=NkRdYORpHuY5/f1JnMxJ41WSuDV6Xn286B6rpSjcO9sVSPaELwGHRLvbxZMQrUvcElhewLZA5L8779eS0eULKO4y6lHay7XOqoKI6L6s5WhifAMGNu1YkcaNuKPPdO+cPHubTtry6sRTammZqckaMgigkWynPYONTJqFkGXRzpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727786007; c=relaxed/simple;
	bh=I7RQBSv1UNlfIghizhAjSFudD/6JcPfbuB6YrXtMPPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PgklIFGXTDLpC9bL+N2nOID4YZmu7e/3wOe7J9kWAKfa+7LqJLI/1AVJde5oXqrb0T3z6fZ9mpvOVfbHNqiK6or3FpZVDxcxc54t2vroY7h5B0aBlJPihJNqRbT9LGR0MbTsqcu3IW25yefAeYMJ6pBxYNHHYySU5rwE7IBJM9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Nqa/LQcH; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2fac63abf63so24659901fa.1
        for <bpf@vger.kernel.org>; Tue, 01 Oct 2024 05:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1727786003; x=1728390803; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8Q2/tpX6A+jOvEwlvciOUOXvtlFoY1JzRJ0VwVeAOGo=;
        b=Nqa/LQcHVXu9Y77MJFPrWUdq6y4PtWBGF/AxQqDcbRSo2sJ/VRAGnYAhKw8Mmehfa/
         7FN9MWnwpsN/ixm6EEWYEDDSHG4kguUJl8Ed8KM1Z0uLHzQIaxEbT8KdTXRqm/yS8/FB
         KkV70y+1AdDtCcJqiBWrBiZE+3GbXa4EIYTlbHRivX/20oph3+AI3mUxTQcQ2iDV4lha
         XMhgIJTVR1cqMDT5gO+H/gEUHQTMSf1F/Yxi0if8fbxFThsW41PeluLDASAY31bVhsYV
         vf6VHIVhzsGfGJOw+EwZnvUDtw/k5JeVTswPH488QtHvoMelPiLVlrbeO3tFpfWohti+
         i6Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727786003; x=1728390803;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Q2/tpX6A+jOvEwlvciOUOXvtlFoY1JzRJ0VwVeAOGo=;
        b=gxjWoOFTaQoE7E7MYoWYqImutaBkxunU4g2RX8YGp2wU83yVKTb8nl88FC36q8ugbF
         TFROAFZgOybtzFtBazYugNXs4PxY5g8/wHOHNNlopq8CcH2wTLdyEGjCtxUWZjmWP1M6
         muBOtPBziP0vVhzz7z1/6BYU/wffiFEwee4OPVwGkCVlzoJ7N0GzvmtjVkeZZvGF1rT8
         7eEvt1FjP56yGnbNq5+ScZQrOCyty25l88ing5KpvCsXgAHIhCyzdAfYOKTjFx/Mwr7U
         xyeWuRFa5rMDFlcFwsh8Yu+sD0OUKGHw3bmCe5MgVishbRlNMHn/muUNguqYb49Rvo/H
         jepw==
X-Gm-Message-State: AOJu0Yziae7/2xiBL2flQuuXmJetolD1vuNbUvd2dmW4qzCASEP8eBnt
	BMHHlGl23aXgzErreegI7pp57DYnZ85yX8RcpL+CK7eNv0CnTDnJFLvs8GLXvzruJuvj5bhiO2H
	gGgI=
X-Google-Smtp-Source: AGHT+IFmvmnlQDJcTPhGm6w5TFtkgeoHlz+g4iRKij4Ac37C3B4n66mGcCxKa4IUSfP4b6Gz198GSA==
X-Received: by 2002:a05:651c:1992:b0:2fa:cf5b:1ea7 with SMTP id 38308e7fff4ca-2facf5b20cfmr40229301fa.6.1727786002672;
        Tue, 01 Oct 2024 05:33:22 -0700 (PDT)
Received: from u94a (2001-b011-fa04-10f6-b2dc-efff-fee8-7e7a.dynamic-ip6.hinet.net. [2001:b011:fa04:10f6:b2dc:efff:fee8:7e7a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b26498b68sm7921885b3a.21.2024.10.01.05.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 05:33:22 -0700 (PDT)
Date: Tue, 1 Oct 2024 20:33:15 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org
Subject: Re: Good first-time BPF tasks
Message-ID: <a4s3w6garvjd3geuhcoegnys2jvodvw2snhwxn42d2or3rdqq7@qhorx2biebjk>
References: <3xru56ozvb4mrphuqt53tvbsiv3n3wfcknme663zcxefayx3re@oq5xnb3o3fec>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3xru56ozvb4mrphuqt53tvbsiv3n3wfcknme663zcxefayx3re@oq5xnb3o3fec>

On Sun, Sep 22, 2024 at 02:41:08AM GMT, Shung-Hsi Yu wrote:
> A topic that came up several times off-list at LPC was how to start
> contributing to the BPF subsystem. One of the thing that would probably help
> is to have a list of todos that are nice to have and can be implemented in a
> relatively self-contained set of patches. Here's things that I've gathered.
> 
> On the more concrete task sides (easy to hard):
> 
> - Check return value of btf__align_of() in btf_dump_emit_struct_def()
> - Replace open-coded & PTR_MAYBE_NULL checks with type_may_be_null()
> - Implement tnum_scast(), and use that to simply var_off induction in
>   coerce_reg_to_size_sx()

This one is being worked on as well.

Unrelate to above, but on the verifier side I also vaguely recall there
was some discussion where Alexei suggests getting rid of insn_idx as a
function parameter (when 'struct bpf_insn *' was already passed
perhaps?). But I can't seem to find the exact discussion on that.

...
> - Better error message when BTF generation failed, or at least fail earlier
> - Refactor to use list_head to create a linked-list of bpf_verifier_state
>   instead of using bpf_verifier_state_list
> 
> On the more general side of things:
> 
> - Improve the documentation
>   - add the missing pieces (e.g. document all BPF_PROG_TYPE_*)
>   - update the out-date part (admittedly quite hard)
> - Improve the BPF selftests coverage
>   - add test for fixes that have been merged but does not come with a
>     corresponding test case to prevent regression
...

