Return-Path: <bpf+bounces-41860-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 971B299C974
	for <lists+bpf@lfdr.de>; Mon, 14 Oct 2024 13:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB745B272A4
	for <lists+bpf@lfdr.de>; Mon, 14 Oct 2024 11:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A291A00CB;
	Mon, 14 Oct 2024 11:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siteground.com header.i=@siteground.com header.b="IAxYDw2z"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB70E19F436
	for <bpf@vger.kernel.org>; Mon, 14 Oct 2024 11:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728906377; cv=none; b=UIsYkVvPllX5siJiI0CiRrzNVFWiulG01g9WBPv4ZPWgxeftKhYM1plbB2RT97sfsQotiOC8pK6sne1AcX05HOmRtSmPC/BKV7/omZkC3hp9rTJS1HvilQkapn+NthhQMEs7UKDnGU57nNpnibVRxT1LoeI/s3p7uXTFeEGQt4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728906377; c=relaxed/simple;
	bh=Ufbhxls916s8ce5V84sMcLFlok5d5URX7puNHEe+AQA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uCXSdbqWPdKb7K908WdfdMy8iTZpIvPiARrC5BsbuwvtZeBWjiaXVSDP+qAIypiV8PaDhYAU5MvQ9z4K4TQOM/1dYzycVRrCelBWsjDnDI0UR+xVE4yahGDslNiYWrFTnY2F/1xc76zdDpRf0h5+nfEV3F/Y5HLhL0bvJUSQAoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=siteground.com; spf=pass smtp.mailfrom=siteground.com; dkim=pass (1024-bit key) header.d=siteground.com header.i=@siteground.com header.b=IAxYDw2z; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=siteground.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siteground.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2fb51e00c05so8119361fa.0
        for <bpf@vger.kernel.org>; Mon, 14 Oct 2024 04:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=siteground.com; s=google; t=1728906374; x=1729511174; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ufbhxls916s8ce5V84sMcLFlok5d5URX7puNHEe+AQA=;
        b=IAxYDw2zD0ESO4d9FXMZXDtNz9dCZKrZ2s6xqcbVVsqMEIYu5cr5AsfQC2BqsiTy2R
         x0O4MGxcNlCv/k9qwmdJyqMYy+/rrO7z0umSp73KK21NqglhNe0nMy/TG3zbGQWc0FOx
         Ash86tnUBCPWurY7bw1TC28wT8Gc87rPXFJNc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728906374; x=1729511174;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ufbhxls916s8ce5V84sMcLFlok5d5URX7puNHEe+AQA=;
        b=lOgcXNYpKNSvmL9x0ZBzlLdHRQGzL0bN8hkx0+zoAyaV5uZc0kXGN9/OG/P3mIhrCe
         SFiIq5W4d+A1ZAd8C6eoOfKC8JeVuKbQOzaiHGQ4uco6NpjmLF+YtUdAb4Nafvjt0H7V
         haKbFDvrSR80QWsTPXggHo2aRkYWuJHK2+2LcOqu722SSP+put5EEIV9U3TkXuWN9Eft
         IZcdQ3FJtTcfq4P+FVetfLBnlxih555/AnfZlkT2t5kCiEIteXUtVXSQbQEa0MToykNT
         Du3nIiAyDswSicjFiF3eNK/kgr9T6iwOHtieD810NaoTvTbA90D0A5Qg1+SK/pyDAg0V
         tPvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZxIXb1dVIGTJ0GOjMQs22kiBiXx+PC0+Lvfotw8pQ9U+n/xK8GW1y0pE7V/K+EDnRVfc=@vger.kernel.org
X-Gm-Message-State: AOJu0YybA8UcCWMwmpDw0dLQxM+sLE1nDLjUrhg9XQh5AvKSb93+lBsd
	gNoJOK5vFLn5rHU/KCks3xG6YbTiI6adRPrMitzEelRYpNYckKvlE4jZc5Un8pGvcrjn5FfUAIu
	uWqBw0uarcNSmhaqIYqGEVbO6qMZHtky0bmcISg==
X-Google-Smtp-Source: AGHT+IFR27dwPVjznT0huyzxtiWkHpYZLJEEO9aR27FSY6TpOWExqKyTxpuCYW5l6JH1Ev9ETuDDUXb7XAcGC3r4nt4=
X-Received: by 2002:a2e:460a:0:b0:2fa:d604:e519 with SMTP id
 38308e7fff4ca-2fb3f194e5fmr27820841fa.11.1728906373802; Mon, 14 Oct 2024
 04:46:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014105541.91184-1-dimitar.kanaliev@siteground.com> <20241014105541.91184-3-dimitar.kanaliev@siteground.com>
In-Reply-To: <20241014105541.91184-3-dimitar.kanaliev@siteground.com>
From: Dimitar Kanaliev <dimitar.kanaliev@siteground.com>
Date: Mon, 14 Oct 2024 14:46:02 +0300
Message-ID: <CAHx3w9KdXAvgUtFBgcJU_Ty1eF6yd9CNkDvvgA2p7X5P+QrY0g@mail.gmail.com>
Subject: Re: [PATCH 2/3] selftests/bpf: Add test for truncation after sign
 extension in coerce_reg_to_size_sx()
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shung-Hsi Yu <shung-hsi.yu@suse.com>
Content-Type: text/plain; charset="UTF-8"

cpuv4 tests are defined outside of the v4 conditional block, which
caused the CI to fail.

pw-bot: cr

