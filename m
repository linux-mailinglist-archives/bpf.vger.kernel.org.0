Return-Path: <bpf+bounces-54898-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28950A75BFD
	for <lists+bpf@lfdr.de>; Sun, 30 Mar 2025 21:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C35B8168B25
	for <lists+bpf@lfdr.de>; Sun, 30 Mar 2025 19:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C644D1DC07D;
	Sun, 30 Mar 2025 19:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IySmcMbM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250AC1DA21
	for <bpf@vger.kernel.org>; Sun, 30 Mar 2025 19:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743363992; cv=none; b=UA74zd3S04LsHfdC6geTPF68CEcqOXuVAs8+XVcKMR/hP+R/yMO6uLYjaYkcTEix/2bOCAL01Qq1GNsf3qQdg41xho4F8InTcmi7KOkHGrblcNGTa4IeKJ57LIm7/OnlYyqHQx71rsOUeKQ/xU3Iu2jDdd4A17I5X07E5oDQP50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743363992; c=relaxed/simple;
	bh=JW4pLVj+ct38K5bj3SbyhUSkmo4opygDvPtnUnrJzSs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uZyJm2RcxVpewFx2qt8YSxLGArpKb3Fs/0Erz/Id21IHm4rIXxQ6rp4DfnPTSwUbFxi9OeYBAEMwUEMzKf2rJSayQ7s3LbD7xywKHg9vQwXeLvQlBPXR9uvuUkJW4WdPhjPtFkYZkrXQfJZCR3am/tVsTdIVf4mxoH4OgCVgryY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=IySmcMbM; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ac6ed4ab410so620626866b.1
        for <bpf@vger.kernel.org>; Sun, 30 Mar 2025 12:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1743363988; x=1743968788; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XWP300xGmUxlVAepKTUVmoU1jMKQr6oEsVT0QnPrZiA=;
        b=IySmcMbM0jQOEVaixkGWhdvn39kEyijTLiytVpz4Mkcg44NU68oJ+B/H7bDWF2WZt0
         07tV2Vq1xzm6o33mqz9Fodc+ZLf3HGsGQ4skkHq5cxWXd35aWR6f0T2OSJpUhmYiYlzb
         zBaRiAy+6RMMpszCvgsyG7l8Q/1q/7J9U/fp8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743363988; x=1743968788;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XWP300xGmUxlVAepKTUVmoU1jMKQr6oEsVT0QnPrZiA=;
        b=C++HURlIEZWhooc90eR6Z4HQcvTcJg1I8y5zeu0ls0IYZJ+SbeW2i4PdlKe3VGPuKI
         ZIVSV+OI1Cxjw0R44mDIYNDCBp76DvF9+urScyi68umCfFlpMNnZbIswoToOZpoYzQuB
         ogqNtAzMbl+srIvJ+XE/KDRU7WrKcDonFmwiRwQEOuRWAqrGEvQga+Et4EbY72IY6lV9
         G/pV4KsBAjk7h1KWo4HpwWEDgo7JLmKRzRUEdRCM1MVDEAQiYja++XxToGEzJKS0gFu5
         swF9tZH/tAuJLPPY5TTscTcC9etWhjCC+W61ejPJxJNtAQQdfZYnKjW1PzWfuZ04fSPf
         W7pw==
X-Gm-Message-State: AOJu0Yz/WGPiorID+SNSpfrjKhmr6d3x1NL2RlYCVGL2v1z9qm/Eve4x
	NgzrFUyUQcJ9ymptJP2YI3Q9oQuAl7v7wTtEAUuhyFHqtptglVV4cue3TFqivLQctPsvhlR4WRE
	5
X-Gm-Gg: ASbGncva3bUBKOTXGuhhIfTD5qJKbEs6BAlomOfRUuXFtytKF67EiApBuqVo8c91UGi
	y0VUoIxs/FkWWAQ/WUbJ6rpcSTG9Riu0rEJKpktOmHNxEUXCfPMVPFaQFTiGZOKcaBwaUiGPWi7
	na+FPUPn/SnJs7ws0dICo4rw5D5EY4MmDzCzk9/wqrhAgoEBO4z0C+aeXkMex81VWH7XEZcXqPk
	fCBxDVbGw/fR7zP8mnZrm5mdMZnn1wxTPNy2rwBngy+H4nVT3NXY0DQGij5DE78qnuaC4TuFUdu
	AwBwqpCM7TZdvkZbvjEBtNz96ROM/rOClt0osAtJ2sLIGi1FVyoKSiLeKJpNtjQrnbMW6GKwKcI
	Tv9Nn0beTQUbn9Z4OjCc=
X-Google-Smtp-Source: AGHT+IHUu/DxZI84KWtVEOYqP1tYqKMlINsZmo0qVVUJaaeFZXobIriGiXfEN6QmUkDOcgtoVhRPUg==
X-Received: by 2002:a17:907:3da9:b0:ac2:d0e6:2b99 with SMTP id a640c23a62f3a-ac738c1c898mr507650666b.36.1743363988276;
        Sun, 30 Mar 2025 12:46:28 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac71f9316a1sm470154666b.82.2025.03.30.12.46.27
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Mar 2025 12:46:27 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ac2dfdf3c38so695036266b.3
        for <bpf@vger.kernel.org>; Sun, 30 Mar 2025 12:46:27 -0700 (PDT)
X-Received: by 2002:a17:906:6a0b:b0:ac6:da00:83f4 with SMTP id
 a640c23a62f3a-ac738c6f29emr495506666b.53.1743363987160; Sun, 30 Mar 2025
 12:46:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250327144013.98005-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20250327144013.98005-1-alexei.starovoitov@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 30 Mar 2025 12:46:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgp6z1z=N3MNPor=fi--TYjngfvCgeBvxZRP0Vu9_ZdRQ@mail.gmail.com>
X-Gm-Features: AQ5f1JqS-551VNYUcekWqcfUwFz9_hX45iRYLETJAR_XguE9z1_lQyub3S9_-nU
Message-ID: <CAHk-=wgp6z1z=N3MNPor=fi--TYjngfvCgeBvxZRP0Vu9_ZdRQ@mail.gmail.com>
Subject: Re: [GIT PULL] Main BPF changes for 6.15
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 27 Mar 2025 at 07:40, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> For this merge window we're splitting BPF pull request into
> three for higher visibility: main changes, res_spin_lock,
> try_alloc_pages.

Thanks. I appreciate it. This makes it much easier for me to walk
through the changes that end up affecting what is usually non-bpf
areas.

           Linus

