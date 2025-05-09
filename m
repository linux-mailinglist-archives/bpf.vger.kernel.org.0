Return-Path: <bpf+bounces-57918-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A47AB1D67
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 21:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3A52527662
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 19:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211FF25DCFD;
	Fri,  9 May 2025 19:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xqa2ea0v"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B5C25DB18
	for <bpf@vger.kernel.org>; Fri,  9 May 2025 19:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746819467; cv=none; b=ql+LyfbdRDtr71G2Sz3lpHCfIoBjh1G8661KWKWtq2qIAUEaEdWNYv3XDkcnVqPu3X44hhiXhjsNlrNRNuGhKgDr5IkmylsaEx7aW1oZXJIKrE5hnS/ZJ9j89CjNtE1jDwnGvyw+3VmhEX/JZhlDvzEBwFIw/84fqgCu8MVMWdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746819467; c=relaxed/simple;
	bh=Yggcyz0nm38ORE7Pw5+aLMHNRo5YKEAuKsZEv/8jx3c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HcHkEme8wilad+1k8ZrouVtUiaer4AWU0+oQJz0hCXm2Fu+C8SpmCRaEWTUbin+X9CPX+QUnB0mAfV3CJ+FBd/EljTO436XaxqAOT23PLtd1C/HSBe/lm+Ad9Yo2ke3KBPE5htR5b034/VnYjr+/vBfcQYdl1EGCFZ2KaZnqNr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xqa2ea0v; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7376e311086so3660812b3a.3
        for <bpf@vger.kernel.org>; Fri, 09 May 2025 12:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746819465; x=1747424265; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Yggcyz0nm38ORE7Pw5+aLMHNRo5YKEAuKsZEv/8jx3c=;
        b=Xqa2ea0vmTXd+p0cxzHLLWfwekRwbozeu63vPtPEgto1TLtYTbXYiXGKH/r8Y42PLz
         i93WxDGzoksBW3kg67244VnAAGueGTmPx8T8MiqDnT0aKnjU9bVc1L1eRq8aMqiMnV8q
         hb0FwxYK0Nw9b4bZxX4BJBMzP9oMu6qOuPuua+Y5AfnnD6SnrUaiU2TyLQgqTNSl+lq6
         nZDN8zT9dx0dQRAbjxolgFE8qmxUetOECBrqT5/zXD2IiHCT53ABt/YPw4ka+sF2Xa6Q
         fFx2u9GIlF9RxWopzsfjarvH80givseVAfiS4xFGRe1i/wVLP5wsKfikrI/6d+cdK+oy
         sKdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746819465; x=1747424265;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yggcyz0nm38ORE7Pw5+aLMHNRo5YKEAuKsZEv/8jx3c=;
        b=bEm+k/A5/YlzvHjBEIJlbRPfSb09mEIjk8W0rn7WN8ArnywewRrDy0OApHeqKmqeNz
         w7DfeITP/6cjjy+nCpWgv1CG6SlkobsuontAMtpmg9soOmMdQ+Y+ty/3W3ogkWaETb2v
         UQBmFmIe2kkhKHdaT2q8Pop2Mxmki8ImcsBkzLiR+WtmX7IUQevLGPekAbL8Gj0y8DHk
         lLmbZgPfo8X2gFwL23FUv61hDhcc41FFae82HgVeO+ay0KdmMm2IGWecXyzltZi4xaUQ
         v/UmhC23cSUfeOSh8Jas1mF4XvNyFiej8uk5yEcOC+tNGJwDUKMtHSbFlFJpeX5S4XX3
         iI3g==
X-Forwarded-Encrypted: i=1; AJvYcCW30PkhXjygGiwo9Axhk84tKMsmQbLdf3o4Z8sRhWq8OQ+oW/QfyK+j7v+Cwpxz4LKWdMg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNT/F2wnSQ35OZALaCDXRAuMGK0TzKTas7UvWm1SD2l5BqEzxY
	Jp/LrF69Hupj+2kB4UzQAH1caNgFCx9cdf/zOLFJZA2GaZnzcD5L
X-Gm-Gg: ASbGnct/WvGCV8WGorKavIoXxZnTne9urjWhaPLgEH/rBnIqycjDl6hWgIlG/24mkTw
	706ySzIIwTQGahh/WsGytc67F0/vI2sZ+CFYVKgER2xuqRn79b2gY0QRefu3MjJOSPH61eHMmji
	nD5mAn7krXOEue0AMzcjQub10AN3MmoV+pX0eccqrQ2LvWSUY9LRitJ6bYG5P/pjzcOw7u4S5Ui
	ZB+9ZBu8vtVrQ8N3DnZxPwhAi4WvB/eyOH7NizQkPBfPFAklM0XtvuMYnbh++4r3woE0y1PomSy
	RHKHAjGFoGQte+PVIoNheK+MhTL5F9TIUhePYhOI1dUdv6MYwB+9AsR26Q==
X-Google-Smtp-Source: AGHT+IG6Zveedr8E6TcLYgahXL8Cr7AimTI4daD9QRfsuongOwqo5lMBPj96MWfZOehvLJf8e0Io+A==
X-Received: by 2002:a05:6a20:9188:b0:1f5:67e2:7790 with SMTP id adf61e73a8af0-215abbbbf84mr6057464637.17.1746819465394;
        Fri, 09 May 2025 12:37:45 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74237704990sm2136415b3a.3.2025.05.09.12.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 12:37:45 -0700 (PDT)
Message-ID: <b935ce37b92c42ef246043030dee3b2a70de7e20.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 10/11] bpftool: Add support for dumping
 streams
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>, 
 Quentin Monnet	 <qmo@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko	 <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Martin KaFai Lau	 <martin.lau@kernel.org>, Emil
 Tsalapatis <emil@etsalapatis.com>, Barret Rhoden	 <brho@google.com>, Matt
 Bobrowski <mattbobrowski@google.com>, kkd@meta.com,  Kernel Team
 <kernel-team@meta.com>
Date: Fri, 09 May 2025 12:37:42 -0700
In-Reply-To: <CAADnVQLOjzmhf1d81Nr9n0zXL1hj7CGeG5_8BySuNY0HxYanSg@mail.gmail.com>
References: <20250507171720.1958296-1-memxor@gmail.com>
	 <20250507171720.1958296-11-memxor@gmail.com>
	 <04332abfa1e08376c10c2830373638d545fba180.camel@gmail.com>
	 <CAADnVQKN2S=yb_7NUO8bsu+7CxnaGyTML6gKcPS61EnCZtvG5g@mail.gmail.com>
	 <9f417b403ef541af5bc8497897e4fbf88bd4023f.camel@gmail.com>
	 <CAADnVQLOjzmhf1d81Nr9n0zXL1hj7CGeG5_8BySuNY0HxYanSg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-05-09 at 11:48 -0700, Alexei Starovoitov wrote:

[...]

> yeah. Ideally the user would just 'cat /sys/.../stdout',
> but we don't auto create pseudo files when progs are loaded.
> Maybe we should.
> 'bpftool prog show' will become 'ls' in some directory.

From the end user point of view, I think this is the simplest
interface possible.


