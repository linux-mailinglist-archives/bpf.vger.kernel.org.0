Return-Path: <bpf+bounces-69798-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 251CDBA1FEF
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 01:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2182563DB0
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 23:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B8D2E7F2A;
	Thu, 25 Sep 2025 23:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZfcHsd5O"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3204502A
	for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 23:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758843989; cv=none; b=QVzNv4nTi0gSsHDl2Aoxy6eU0T2KT+eAd8y2qSKom3p/syDonrLLIPDrePctvbKB27sthwrnid45qQs//u5t63TFPc1Er0MIduj2L7K8tPkmXz4C9qMo6ndzLda6PVhp9D6mmi6itHyzGWy58fARJd30Raywe9SR7yWcjgtBis8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758843989; c=relaxed/simple;
	bh=moIGVKSJv35h1eQY1Dqre3DNbBHiJRL/+W2+VxLIeS8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KvDwHHva8gciyUI0iGJynPeGhfLe59K19QQM1nsdv/x8eKnyTneQ9l+7PIUMHS9x+KznYfRIDnLWgBbNiacNTvAai+4RD5UV8kKjqpD9P0tVP5pxcz7qrR+j7NE062yZSv7atVw/UbCgpsKR2A3v7saf4XQUS5lsflxEawGH00I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZfcHsd5O; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-42576a07eeeso14003825ab.0
        for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 16:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758843987; x=1759448787; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=moIGVKSJv35h1eQY1Dqre3DNbBHiJRL/+W2+VxLIeS8=;
        b=ZfcHsd5OKQbITFINSzaO/90ch01Jj+hRq2KlQypoiGYwU9PmJ1wDF5bBoiH1BPS8Ep
         5RduM/FK++LdMzBNHz2BPB07jwMynTCetcGoE//wA2LORPfL8tTzlxPCCeUbFDqSP3WJ
         uUzC8gGFt3xAOssrxw80UspqL3Cxp5MC2+fjyS2qwgHHWllyvVSswaSwKZkxs1s2T7zj
         OlC+ES4lm7S+aJQkIuRfPup/bTwEhdDReQVMGFMEINj9q8jTjGei0Liep6vSKK00cNUw
         AcT4SusG6wF7kXcNCrKjy1qZyv3vn6ztva8vQLaU/a4DO0F639JPPYN2G8wPc3VYoKAM
         itCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758843987; x=1759448787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=moIGVKSJv35h1eQY1Dqre3DNbBHiJRL/+W2+VxLIeS8=;
        b=N0e1AOa00DGFNdFuJ8V2RKGnVhJX+AHq7/SAeeFfV/k3oZQj6/sIOgMJ0bRcLL4SIL
         D83mBxTNtrHhMvN+o5m1y2beCWYQgwXzXBlQGFWKbYXqpx4/f8OiEY5LtPvXUpJ22BxD
         SMyb9ExMOnqfL69ST9QfOT53JZ2a8uTlViqGRIOboDfCjengFVM9OAxSh6BFGYsI4Hh5
         oZYjR1y4jXCwCg7m2aNZyq79hnBn0KwkQwfTuO5j/q9Fp60nYD4/OjPxYN3CM3PJGmHX
         P0XeilLjBVSKobUPJcNlQeGcJ4YNJU/xfFfXZ5HlHp0xNKB5GYj/AWF6PTPpgiNZYg2h
         3b9w==
X-Gm-Message-State: AOJu0YxJY1arJhCk/5fhQ/giwntXFsFfo54Asg4RbD+i+kcVQpWD0PKs
	8uoZsxwOVx/4ZW9Dwi9/W5h3EC+9m/wI9n1gZbtHCmGDXg0T8zSPNAkDEjGmANm491Ya/kKEZNr
	USpPbgkB7PrrtwJ6/HtzI0DTxSh8brJ4=
X-Gm-Gg: ASbGncu7tHo0cVjS5K+Kx7j+r4aONl0boS1Np23MOzKIdVbO2bGoZc3v9CL0XrIYOWk
	rynN4KalPM143V+UiY13t8Yds3m0VebYrubuaImGfMGAAEtSPHWhQTjwz1rHwJjdn+3qvEiKdiz
	v/zzXNZv4t3i/96RAGgyHyneuHdX9tdSZf+uEnYVW29UH+GPYkepjvCr6nIapsNhq9SyBI/eP9w
	jsSBXo=
X-Google-Smtp-Source: AGHT+IHLqsE+3y/UsQQZBwtr5q1M0rDO1E+pId634vMyngEZ1jv+FbdsBt/YYib1qSYyyUGKOV3FLS6exLbDvkFNL/U=
X-Received: by 2002:a92:ca05:0:b0:427:47aa:2b52 with SMTP id
 e9e14a558f8ab-42747aa2b7dmr7776345ab.27.1758843986838; Thu, 25 Sep 2025
 16:46:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925160009.2474816-1-maciej.fijalkowski@intel.com> <20250925160009.2474816-2-maciej.fijalkowski@intel.com>
In-Reply-To: <20250925160009.2474816-2-maciej.fijalkowski@intel.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 26 Sep 2025 07:45:50 +0800
X-Gm-Features: AS18NWDdH_cfRGCAWU3rjffBik6a-6UwrKWN2NTW7DrXIHmNTbrnVDl9daAFYts
Message-ID: <CAL+tcoCnaL_PBDqWrQzMbUXHfXk_DAYvZ46Zn2X9Pot8iShrOw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/3] xsk: avoid overwriting skb fields for
 multi-buffer traffic
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, netdev@vger.kernel.org, magnus.karlsson@intel.com, 
	stfomichev@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 12:00=E2=80=AFAM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> We are unnecessarily setting a bunch of skb fields per each processed
> descriptor, which is redundant for fragmented frames.
>
> Let us set these respective members for first fragment only. To address
> both paths that we have within xsk_build_skb(), move assignments onto
> xsk_set_destructor_arg() and rename it to xsk_skb_init_misc().
>
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Thanks,
Jason

