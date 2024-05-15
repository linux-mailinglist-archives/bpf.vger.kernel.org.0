Return-Path: <bpf+bounces-29772-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 522A08C69A1
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 17:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7448B21BCB
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 15:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71DCF155A4E;
	Wed, 15 May 2024 15:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IzYYOYD7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f66.google.com (mail-lf1-f66.google.com [209.85.167.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B6915574D;
	Wed, 15 May 2024 15:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715786819; cv=none; b=EGGRiNJPg7Wy6ba6XJSUgGoEIDOjySjA885fL+qK2lHNybezWVwGQvZy2BgQUiTka4Fml1o2bSN3v2bzK1qWmGdqUeYADssQAf166+W/kLR/9VPRSFPvZaAJDG1KOz/TIgqvlcpNuNT5rRTtdXz2LLftNGciUx0RsfX2p1MqfM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715786819; c=relaxed/simple;
	bh=85I2Ogb/APtmNidN/wmWTf+pvmq6bjY59wnXmqevuWw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dbr7UwB1wAelogQ2wDYCO31WCveZSndLH7zERj2xYPWMgMUWKrL7hyhGREPDx50JqNqoF0qrOm+qHTY06TJnCIeDntYKTPTinpkt3exANv6zbnZwcu0h26fUTCgeI+5BIfTqKsvR1nDxTOAihmi3ufuOzgR6uO2qvg7FYx5oXDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IzYYOYD7; arc=none smtp.client-ip=209.85.167.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f66.google.com with SMTP id 2adb3069b0e04-520f9d559f6so8326401e87.3;
        Wed, 15 May 2024 08:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715786815; x=1716391615; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=85I2Ogb/APtmNidN/wmWTf+pvmq6bjY59wnXmqevuWw=;
        b=IzYYOYD7xBy4xvhveyxRkS1OtEUVSxApH50ZbPo2OgaKybT/3E5hhVLY0ClptqksWZ
         hyKOUGT/7+FaImWeGZ4byDetCGVg4bF6F2GGEHESHC4SBq3iei29zr/EN3ilINKGOfVU
         ghu1+e2aXTWSJRWhKn+DKejWfSkLH+YJxvhmre2HFRaX/AXaohaxfMRM6xGLIoamXCGz
         lPtLi8MzZNLVRRLbB1eqDdyMW5mwFyDag/UgYo0lyC0pv9FluZOTSRxNU6DJvywavDWe
         uY1rg7A798evWBNOQmBhHIlUwpR91QvL0IHJNbR7cPrD0oGPACyZHKmpA7J0By67FNxv
         j0aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715786815; x=1716391615;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=85I2Ogb/APtmNidN/wmWTf+pvmq6bjY59wnXmqevuWw=;
        b=u8URtkmLhWHI+GpFx3GliHSfeXqIHRCeFS4dct8188AuTFNFOt8H/WNmh2fGISKQEI
         bH5KuTkGhY5IrXS3fngu1GXGaN4fdTRHp5NqyT1zpSobdryOg4OLOD+fk0tvu3K2pZu0
         Hg5U9H5gQ3rpUzvezpgd5np8hAvcOsij2n1zo8yJs40cL2125t2jmrRrcZYZhOHPAM2Y
         O5bEVNJcgAVBLTQv/Ht+8XfqCcIZHjfo1TmBu9vxAsY5hqZdpz3n+rE/Q8gVFa3Oxkdt
         vfgi7mWyS8EvZ6Q3LayrqH3HQdvTD1oNG0Odb7ESgfu2uHml23hsHQmcReFknZIuG5q7
         nKfw==
X-Forwarded-Encrypted: i=1; AJvYcCVXJvnc/TpDWRcBHD+QGzkAVRUPquVRHPrw5Fi9e4QVFsXd/ePvJqymC4VyiF7Pg89lZRhHMFDEH14UhF3MTAnyJx/M
X-Gm-Message-State: AOJu0YxCoDaJZNjEdwvwCEVAGNmUG8vh0z75TvKW1ef8srNSsbQLxXAv
	vwS78FEAf5x9Fz03NRKXIP2Z4cIuXu9MQm9xeD4fnbZ2s2hAkXzxSY/h+xwYASAkjuOPm89uNLZ
	WJrrorkpFo6qRgxerBABbsL3XyLCl3JYrv+8=
X-Google-Smtp-Source: AGHT+IEAWBnVNdW0B7Pcnsyup6hRL1fHkAu0Vd4B7zPlexKRnbsNWQE5l5NcE/Ntusu+cVm39zby+GhSV26CFOdhCtA=
X-Received: by 2002:a05:6512:23a7:b0:523:48f2:e3fd with SMTP id
 2adb3069b0e04-52348f2e4f3mr6838376e87.16.1715786815191; Wed, 15 May 2024
 08:26:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240515062440.846086-1-andrii@kernel.org> <20240515062440.846086-2-andrii@kernel.org>
In-Reply-To: <20240515062440.846086-2-andrii@kernel.org>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 15 May 2024 17:26:17 +0200
Message-ID: <CAP01T75TwjxmBCE5kNNNjW+m+Qfa6yRK+HxXpwtfa1XjLvqfug@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] selftests/bpf: add more variations of
 map-in-map situations
To: Andrii Nakryiko <andrii@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, torvalds@linux-foundation.org, 
	Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 15 May 2024 at 08:25, Andrii Nakryiko <andrii@kernel.org> wrote:
>
> Add test cases validating usage of PERCPU_ARRAY and PERCPU_HASH maps as
> inner maps.
>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

