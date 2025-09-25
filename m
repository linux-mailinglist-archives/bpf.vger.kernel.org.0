Return-Path: <bpf+bounces-69689-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 611ECB9E9A1
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 12:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43B561BC6C6B
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 10:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310132EA468;
	Thu, 25 Sep 2025 10:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="USxf87E4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E112E9ED2
	for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 10:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758795535; cv=none; b=UArSyX9MVL9cUGErklt9c6LWuS+kFbS0iNjbwuGzWr5C6FCyIOC9omI7Cvg6nZDwWF/JkTGkcAejUMVCQWthMhqwmik6uy16A7j7Mj/aPZkHOpjg+MHoLqFJFf6Vt4J96DubytCcnjPEdbERGOMkm7rpl0pAZZNRQhZBgxWquLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758795535; c=relaxed/simple;
	bh=0szZ/1t2vF723fTx+0uYOJw7RgMxwYGlCm1Nqaxh6Dg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=McNlmjpa7H2Jqwn6NJB9NzsJFreAhF4JdyDba8nnCs3cum+XgFT8lG8n36IQ5RRD+4DB73bXmyhUJ82u4xLTgdt5Hlxh2rROdM/fFyGjBIj2m9IishFIcZ1W+bEGXI/icQe33IRCOpeaW32gfQOZBrMsEOxvmALy51MhTVtl6TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=USxf87E4; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-62f0702ef0dso3833986a12.1
        for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 03:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1758795532; x=1759400332; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=opLUmUG+lsRAbSy1R5a7UUs1ZFkf867TQlaVzzmhmQI=;
        b=USxf87E4a3wTPwlQzSRSmfEXT1sLetG19ySjUwclrh0qTKXbdaU9jd8qe66cTEFrtP
         O9UGT5VYl6Y23dmY+p/PBSsXThAwFZa0DX7KGCGYPpQSP2NKshcaPNCOorZvY/pid57D
         uciVqr55gTbLgzDUUKU6g+kAUfjPki2ii59/JLcvloX/SAqVezNrg5ifnb+6KhgdB8go
         Da3sb6Xvimh2VUYGRIqDI9kKs4GjtQdWaSohKjpfkeq1Aj6lOlE3wqlAGYojXHJ8IBvT
         6aLFlQ2h61v7IvSoLXpAp1U/yxd76FHgEs0tn5Id8GOjhDn2kCiGlk8wVVARiKtB3hjH
         /x4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758795532; x=1759400332;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=opLUmUG+lsRAbSy1R5a7UUs1ZFkf867TQlaVzzmhmQI=;
        b=H8UUewWAoDp3Uf0lCqyUvl2PoGXEMDa9kZAUOODIE1PuTAizaJjcCLhoP8bs8dIZto
         wasK8MPVFp5NdU5VDJfeKysZ+HGLclQTo701qQBA79/BNZ/ZZX/ikL2cl82R51rWzNd+
         Bpo8b7WC/XNHVowwdMAaTRDBPmTEFB0y88LHaKXv9uUZg/nwgAGpKlGp6eJw1j928Fye
         4J/pHjXS4ldtRIBy7ALNIbpNq1D2xwIlyIrUsHdHfA3vOWGlpKC5uVNjFcLDWQFZQCcm
         9IYb75F8wmASX9XhOO0L9sCSjFcWArwlfALGdlKkr1AUZVxsybqLT9aMdsEKh0MvreqF
         14oA==
X-Forwarded-Encrypted: i=1; AJvYcCXnMoUEdqflejY5m9jilrlpweOP4OeuiDzo2xoTjMtECgKRSG5mdCWnihPuukDBkP2hHZg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8y7DYSGBQUt5QuiJztsnHT5v/yodZBfdl2kmPL8a0+PVw6Dbf
	2tP36SkL99MaqtUGYdp69+u6c9g0Kut/FcJvNRavmZX/4EcoGSOE1RsjFGe2nD8ncuY=
X-Gm-Gg: ASbGnctZRflWf8wOkiu10XM9RffWYOVOH11BbfD8rHz2VSW5ZPmx0YDzPlGQpSX4MG7
	KZ1e7EoyCcQ9UooVPU1r+IqehnaPcOAuSKxsVNRg4OnSH6mJU/v+6jcIJ4QrNJ2QqDDHeHMpmG2
	0W7kCiLAair+97CImDVfetEqPsdipTmg7DJ1ZN+9DwfPHfgvusErLZ0cRpj2ENbadiUzoXj0mnE
	h2gt3l1w1kXoCFzCJyRgigApfTzKrsVswM7PIfyr/y6RWxzqKb13jGyZYHnucfuI/N1oB30OJWO
	9gMBRKq3Wl8m8rwnOhHrHJ2oMotqoWP9cMDbXsEDCB/ceuPxKwbCGydx50gBc0WG5aWuee+LYyh
	oz6ApNsmO9Ndi3XcKloG+Kqh0NA==
X-Google-Smtp-Source: AGHT+IFhft95WME5prTDF0IZI8kkYS3aAO32jFFFBf65s/9jPTkMU0F9cjZ8kCcS0fWYH8vfDPruLQ==
X-Received: by 2002:a17:906:6a02:b0:b35:cc60:9fd1 with SMTP id a640c23a62f3a-b35cc7000a9mr165718466b.18.1758795532196;
        Thu, 25 Sep 2025 03:18:52 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac6:d677:295f::41f:5e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b35446f758csm139119666b.53.2025.09.25.03.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 03:18:51 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
Cc: davem@davemloft.net,  edumazet@google.com,  kuba@kernel.org,
  pabeni@redhat.com,  donald.hunter@gmail.com,  andrew+netdev@lunn.ch,
  ast@kernel.org,  daniel@iogearbox.net,  hawk@kernel.org,
  john.fastabend@gmail.com,  matttbe@kernel.org,  chuck.lever@oracle.com,
  jdamato@fastly.com,  skhawaja@google.com,  dw@davidwei.uk,
  mkarsten@uwaterloo.ca,  yoong.siang.song@intel.com,
  david.hunter.linux@gmail.com,  skhan@linuxfoundation.org,
  horms@kernel.org,  sdf@fomichev.me,  netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org,  bpf@vger.kernel.org,
  linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH RFC 0/4] Add XDP RX queue index metadata via kfuncs
In-Reply-To: <0cddb596-a70b-48d4-9d8e-c6cb76abd9d2@gmail.com> (Mehdi Ben Hadj
	Khelifa's message of "Thu, 25 Sep 2025 11:54:59 +0100")
References: <20250923210026.3870-1-mehdi.benhadjkhelifa@gmail.com>
	<87h5wq50l0.fsf@cloudflare.com>
	<0cddb596-a70b-48d4-9d8e-c6cb76abd9d2@gmail.com>
Date: Thu, 25 Sep 2025 12:18:50 +0200
Message-ID: <87348a4yyd.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Sep 25, 2025 at 11:54 AM +01, Mehdi Ben Hadj Khelifa wrote:
> On 9/25/25 10:43 AM, Jakub Sitnicki wrote:
>> On Tue, Sep 23, 2025 at 10:00 PM +01, Mehdi Ben Hadj Khelifa wrote:
>>>   This patch series is intended to make a base for setting
>>>   queue_index in the xdp_rxq_info struct in bpf/cpumap.c to
>>>   the right index. Although that part I still didn't figure
>>>   out yet,I m searching for my guidance to do that as well
>>>   as for the correctness of the patches in this series.
>> What is the use case/movtivation behind this work?
>
> The goal of the work is to have xdp programs have the correct packet RX queue
> index after being redirected through cpumap because currently the queue_index
> gets unset or more accurately set to 0 as a default in xdp_rxq_info. This is my
> current understanding.I still have to know how I can propogate that HW hint from
> the NICs to the function where I need it.

This explains what this series does, the desired end state of
information passing, but not why is does it - how that information is
going to be consumed? To what end?

I'd start by figuring that part out. Otherwise you're just proposing
adding code that serves no actual purpose.

