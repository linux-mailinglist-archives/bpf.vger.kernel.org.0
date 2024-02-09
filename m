Return-Path: <bpf+bounces-21568-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4610D84EE6D
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 01:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D62A28A6E0
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 00:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D6C7FF;
	Fri,  9 Feb 2024 00:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kwZ46+gg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1220136E
	for <bpf@vger.kernel.org>; Fri,  9 Feb 2024 00:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707439390; cv=none; b=UTrW4QbTpC3j3iPoyCXToQ+HVtSWfG/RD0a6tWvpDi2EBBvANL1bitkGFyIKOJCO2/oEDx+XEK07vtxfSNtRKNpy7Tc6v2NdZuqP9PSxcsCB7sP2NzkCIbBHb4NKWxE+GQW4L0GSqTgioqr6IYrWAv997CG+RTJB/Yxr3yAkImg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707439390; c=relaxed/simple;
	bh=2oAnO/g2tacYgXjulh1LaEWxa3FD8yP3GFfq3RtHp1Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CDNA55hya3HVJG/ghWezGj2CAba9d7RBDl+TERsORmYBh53oHiZKEUzYBuOCnDoUuNcWxFrduhi7plLxJftnpcGp3761rkBZYI2vByujfv0+0/NiGlM7D7/98LdG+tNr9lIIGOoiPu/3U2CBPDPy5LsyuEh2gfr5FCM+Af46qM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kwZ46+gg; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1d9f3136c74so12451365ad.0
        for <bpf@vger.kernel.org>; Thu, 08 Feb 2024 16:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707439388; x=1708044188; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RoO/AYczjRmfK2y8baMVNsK+Qib8OGiIWBRfrTnSMC0=;
        b=kwZ46+ggv4uU1SrG73Hng0g5SQ/dtXSNpFuqQZ5oLiq+Y6FXzYYq/427qtFf5G6Kkx
         aXm8PvZiY66EHr3/ruAGwlFI21+9JUkedT//yvn7Fkm7Ow3dNVIQOluIZgVzxTfWaUbN
         0HE/3ezEqFXtGM1xi8AQjsV7M7iLhHzriepqXud6QKD1nVHuJWPX5PaWRJZB2SBKLyU/
         3LCXcNb0RtTk0+eJQVe1cPv7aOTuQ3Nh58rwPuw13iHukTvWxTc5bFRA5C4WNU+UqFrA
         OTqS8bIfetihF4PAahoQtEoatEHk5LX4BuSjsa/gB4RgoEhpVf6WsYJb3Z/m54XjJp2q
         pquw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707439388; x=1708044188;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RoO/AYczjRmfK2y8baMVNsK+Qib8OGiIWBRfrTnSMC0=;
        b=Jr8Ioxu0olVEpPw1W+OkrTnLEPQeUEd72pYZb/VPDh1RNFAgL6dJO0PSwm00hdetzC
         LlLAttI8He/m6PaLJHb0uzOUBB8m7up6BqaImcfQY7OPnlEX+VHVV6lC/HKBy6Sh91Zq
         B0hpZlTip/2MfhCPTukghNbD2NneA/fpnFbOqtn05mLq1CZgjbNeNwfvLdBpD5FZmd+Q
         /OXWIyIjv4jclco5Cml20Zw+WvNoDdKsNHk96eQL/r59w8uQkNgXPau6zdkUQDLnVgR7
         gT9jlOg950L55zs5jWEXeHbZRHTWVcODVGUQ+ws2Xu+sLdem+lBSuay3hMKu62/n5Sm7
         Fzrg==
X-Gm-Message-State: AOJu0YwX3B+zL4UHZpsdO/v8x+xvwyTpeoS+nqFQYie5P4qIWnJXzrY8
	w7yt5TkfzC5+HBD5mMPY7XylF3zLzl3D6/d1GmaoKYhqtXD80e2nT311D6nBHavD/Q==
X-Google-Smtp-Source: AGHT+IFZnd8udM0KilTMMSVGa4jLpsB3x5qs3wwE4l4I4E77leqDdXNGCu6+M+9voS/U12Rl58Qj77M=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:903:2349:b0:1d9:3baa:ef64 with SMTP id
 c9-20020a170903234900b001d93baaef64mr146plh.3.1707439388220; Thu, 08 Feb 2024
 16:43:08 -0800 (PST)
Date: Thu, 8 Feb 2024 16:43:06 -0800
In-Reply-To: <ngc7klapduckb67tsymb3blu2wlmdsjo4pa4gbaivgxezbwzxp@v7akqu7gbwl4>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <ngc7klapduckb67tsymb3blu2wlmdsjo4pa4gbaivgxezbwzxp@v7akqu7gbwl4>
Message-ID: <ZcV1GgitdBUIcKJT@google.com>
Subject: Re: [PATCH] net: remove check before __cgroup_bpf_run_filter_skb
From: Stanislav Fomichev <sdf@google.com>
To: Oliver Crumrine <ozlinuxc@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, haoluo@google.com, 
	jolsa@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On 02/08, Oliver Crumrine wrote:
> Checking if __sk is a full socket in macro 
> BPF_CGROUP_RUN_PROG_INET_EGRESS is redundant, as the same check is 
> done in function __cgroup_bpf_run_filter_skb, called as part of the 
> macro.

The check is here to make sure we only run this hook on non-req sockets.
Dropping it would mean we'd be running the hook on the listeners
instead. I don't think we want that.

