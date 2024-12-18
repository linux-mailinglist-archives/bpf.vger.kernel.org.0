Return-Path: <bpf+bounces-47204-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68CEB9F5F5F
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 08:34:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A781A188D833
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 07:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4000A15C15C;
	Wed, 18 Dec 2024 07:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Jl+Mx6Nz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7C6157484
	for <bpf@vger.kernel.org>; Wed, 18 Dec 2024 07:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734507235; cv=none; b=M85yUdmLmnxYxamehKOqsvCM6VAR4t37OrKstu0V7qjOCaJcYrm6TFphr3Kd8PvVw0QyrElcwxbmqQSO/v2PGm6CxlUvZJ9TjB4J0QOrNqZmh8u46AbMN1xHw/gvhP45Jdg+NUNWPwrAtwLMibV69MfrUAh7bX9EZ6QwmUYB6ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734507235; c=relaxed/simple;
	bh=NKOdkyToNe5JqmJkJwJJWZfF510FDZ1gEyTp6YhNOtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=finNqNkySQcXVDjDnXPSCtf+N4NdwFRsiYzCQ7OvfVF4KardNg7eoT0MKKNexdRgUVU47QUTYpVaic4HpqwhhX+yVy9qL439xKoyUAv9By6UfdKgTN8IBrLHVQaG4TIdR9igt89d3eG5E+mAq9MES3xIZSgx6tTi73inynwHQGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Jl+Mx6Nz; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4362f61757fso48236965e9.2
        for <bpf@vger.kernel.org>; Tue, 17 Dec 2024 23:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734507232; x=1735112032; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hKXnl+eroHLn9q2kYpv3U2QMqSb3GEqFcjU9cmziuPw=;
        b=Jl+Mx6NzECNFdq+R4fyE+LSK5QzEnnl1f+dmMjvVelP08hppXJeZfEsOC8/Eqg4qAY
         LXktAyUOOcLdiA0rGtb4bzgbUUAvf//lZPgSbpfYDumOv88cTnKwxr0VRTpGeRLe+S+H
         cvc0pHgN3YLjPz4/vA0cTwgqbMGQnPEsyheM2OdcTQ4yb3rFu9IqWKIw10zVq4xbl8DR
         AcVJGCRQW0hfcjZEci+/GeYqSkywQkvcGNRoNDMd7S/WC3ZFLDkZVvR4lHST0iGmssl2
         MVPQ0fuUy8gFEUAELyyQMazDqA5Yz3TBaLglsSU1SYqsXDF0R5JEt4dU9wQWWnHRU5sE
         9KAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734507232; x=1735112032;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hKXnl+eroHLn9q2kYpv3U2QMqSb3GEqFcjU9cmziuPw=;
        b=k+cKQZLUKPcsZWNRguhGMQPTXuBSGy0ymZMUrx0hxNeeyBJdJrT5tbfYjE2ZCn5Ucs
         7TJx2JBhqSH3rdGhoU9CNiPMgDb3Sic0Qgy0R4UlifnDQhi3cO4Xmlah0MtQZwKcHmou
         FzLGLaZj2F0yMz8j155NORkRBOSmjnUAU2NUy4X0vAM5inYunfYcnC/+4FKlWmPwqoUO
         F9bYFP7pjq/07Un7SRMjfmOhkZpeaZAv4Wae4ZA5NMfjT7VKFz9TOVgUcXRFMiJF+Cza
         gzqACkms4SFpN1Q8XIj+WaAFNEilccsu4DAXZ+r0rw/I0ZPrCN1kSAw6RMkof6XFunqY
         2hqQ==
X-Gm-Message-State: AOJu0Yz74UiAZjbb9xXTtAsILxeGRBBSVW9efDREtZsfo0geOuMBPwcn
	DfZYnkTPMHN7J4BoOtInNOoFqJBePfLxMtGx82MNJ1B4znLsrBW4Q8IqDQYBP1O/42lQA3+HzJF
	mRiA=
X-Gm-Gg: ASbGnctZ6o3GhfXBZxyEuZ34VCs/uXUQSEZnViR2TOzH0p/naLAQALyjkWA+TFIfTpM
	5SjO+YqwDWS2ye9gAvCu/Gc68xHCJe/zl83B2POu+31qvWZkW8bZ9STPE67dRMa2k/5HoNY50WP
	vEf+8QNijqpCObIcCZLxO+oB4YbWfasFBhjTAo1IaEp52sbZZeex6PPOycEVCDqTXcPGGFcrb6E
	wHYy8BQdrsKRCf7mQWTYxSrBDD9kOw/GYTslq6mjgxFn+a6ZRY3
X-Google-Smtp-Source: AGHT+IH/EfLQIKLctgCYs29yNiuUXhyg3l0bKaBhgWmPlyZzd/yRQdnuwdjuh4C31/lZbij9qTgbZw==
X-Received: by 2002:a05:6000:79a:b0:385:ef39:6cf7 with SMTP id ffacd0b85a97d-388e4d647fcmr1376099f8f.32.1734507232026;
        Tue, 17 Dec 2024 23:33:52 -0800 (PST)
Received: from u94a ([2401:e180:8863:7234:db39:d989:bb90:49df])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e72111sm69539315ad.271.2024.12.17.23.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 23:33:48 -0800 (PST)
Date: Wed, 18 Dec 2024 15:33:40 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, stable <stable@vger.kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kui-Feng Lee <thinker.li@gmail.com>
Subject: Re: [BUG stable 6.6] kernel crash in BPF selftests dummy_st_ops
Message-ID: <d6fyo5m3usi3l27kwr2jylfpg5xy2cge63loeou2t62svvj4ll@2fciyxukdntw>
References: <ffsmmoqcc7yru7yc6sykdwfnad5phgddl5wysq4bw3mwdaiixx@znzt4ucmf37g>
 <CAADnVQJXEmy4v6z8eYYPtgApWvv4LGgYExsFvbVPBe6BN9xAeQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJXEmy4v6z8eYYPtgApWvv4LGgYExsFvbVPBe6BN9xAeQ@mail.gmail.com>

On Tue, Dec 17, 2024 at 11:27:33PM -0800, Alexei Starovoitov wrote:
> On Tue, Dec 17, 2024 at 11:02 PM Shung-Hsi Yu <shung-hsi.yu@suse.com> wrote:
> >
> > (Maybe a good first-timer bug if anyone wants to try contributing during
> > the holiday seasons)
> >
> > The stable v6.6 kernel currently runs into kernel panic when running the
> 
> Does it repro with the latest kernel?

No, doesn't happen on the latest kernel.

> If not, please make an effort and figure out which patch is missing in 6.6.

I'm optimistically hoping this report would persuade someone reading the
mailing list into to do the work :)

But if that doesn't happen I'll look into it and have it fixed.

Shung-Hsi

