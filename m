Return-Path: <bpf+bounces-64124-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B02B0E6F3
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 01:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C4D0AA176F
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 23:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E2928B4FE;
	Tue, 22 Jul 2025 23:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j2h99tzw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9154828507E;
	Tue, 22 Jul 2025 23:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753225686; cv=none; b=aAu9+bkk9TGvLczZadfVH8YUBJWL9lCTT+LBGQe5IDEQeyA62bRCSmP/OmUV/ORmqiZEbJNbmMly9KULODSmYfuHw2maL8ZUc6B4IjwVRIZnMN3yBNqiVmxs94Av9nlJu7a9A6dkyWvhxLrBeV3t/36U7suAv00zYJYtWHNcpPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753225686; c=relaxed/simple;
	bh=O3LHQGhBVBjbOH9wGcG78qMxoAou/utSnwoCYcEN85U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DSgqSTzBPpVgiGa4qyOPxhK1UywpuP/v7vrKP6dqSipNLWYOAA/vOij/4Ihog0WEUFIZFSaSONlxJ12B/whM/XW27pLGtKb9Godpszl+2T7guohnvcIW5T4teFaiUp+jxLpvFP8ymC6Vl2O4xH7lmlhMMUuZl5gIWCwrHE7deKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j2h99tzw; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-87c26c9e8d5so263152039f.0;
        Tue, 22 Jul 2025 16:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753225683; x=1753830483; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/mMoaMx1flIcD7eXqi/UL8Muxe2kEAD+s71uJxVYy2s=;
        b=j2h99tzwqD2w06AIGFKB9xxDwAzxU2jFutAIqnPfqM/wkUz+YE4hf12QatGkTeYovp
         Nrpu0VFifj+hJhyvCuJutEKIgYmnyVaVzwj77R8pNCozay/qBgi/LzrICquqOFd+uOLM
         G2tzK2/3wgYwl8hECpSTbaptlxT1d3Vv6phH/KShTZLbOPd4gjcv/MJ3u1x6tRHJBgQW
         fBkCEkjEn3gkHM9sv0UmOrFWM0bWb2Akll28ffqPI1tZibDupG6r4BjvCrizCQRRHieC
         8dJxT1RplSxOl+gV8jIqHACuiKt0v7f8YjwEDEugz+gsVTwOtR4v0qUvwwyABYZ1dtsd
         BWWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753225683; x=1753830483;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/mMoaMx1flIcD7eXqi/UL8Muxe2kEAD+s71uJxVYy2s=;
        b=oOFeDd4DRq9EuWxTwIQIWHegjRbFN08HSOA84BYmigBRvcm5/MC2R6zSh5EoYKADUP
         MJSsbsKbrHq6+j/g5rl8oelXdZyulps28hME/k6T+XbQ8z8w+twquFBixMhmi7CcBjln
         YCR/4eBSdGablyrR0Vgco8bbk/EZB6M5l0QEtKPZOALJxqvvIQaKc1uEfIXerJfIRi5A
         mShlqbEuIrhDeaaUEznN9Ac9/aHQNz4voBPffZ56OODmMlnehIFkZt4V7aZgyiij7sa2
         Br5wDBcJ6a38zcuo44E4W9YQgYMoKgTefFiTulo6QEOUQ9GzCKJdwJLlinEn3PA8d8RF
         J4Dg==
X-Forwarded-Encrypted: i=1; AJvYcCUAXuJldUs+3FU1UC8Rx4g5ZG0AufwW0wLKsE2cPkBNWlW9NhhNMwSuyxCml3DR5VIHcBU=@vger.kernel.org, AJvYcCUuMWKfv6sU/2zobBuHicPvU0IhRqSCeK94iliOZqGIbl4+U+I5NeLFmOT3TO+AUgh0jNW5qp1X@vger.kernel.org
X-Gm-Message-State: AOJu0YyouxSwnCX57725mIbqi1RB4Gv9M2enpG3+qZIS2+aRI8t7pss7
	VyolUu41EdexTaWHsz9rEu7AZzcMg+ClE2mUw5mQnaqXuThIK4Pc8ObXS1VNvwIIW4/EMZd2I7b
	7gEHRxf43XKqmlcuX2BWFAlHAqzPaHHc=
X-Gm-Gg: ASbGncvNFxUYWlRGXjP+komJ/1UAGZ6RapKN5qkY6Eyp0C04WYrZn3Z3M2uPdpL57Nx
	Oqi87uerD6ZM5BPeMnbs5/yEHcnIpZKj0if76cj8Fv8HdzuIvQ6awvx3qv3vUofBU71xyI89TCt
	TSlGBxfcZuXdnK6AD2twSvrECuNN8C6SEGTf/FlJea87dTsfiJ2VkzTwLDMDRW/MuEkmDlLwKi/
	6vyD+pD6zPw4hvJTA==
X-Google-Smtp-Source: AGHT+IExMlR5MelabTRsOc2tClv7n4gVBPnDMaSvf1Cqj6owFiytP1LId1+eNzapFTXoQP/Io+nkVOuNBDaBzXzB1Gk=
X-Received: by 2002:a05:6e02:3499:b0:3e2:c345:17f2 with SMTP id
 e9e14a558f8ab-3e32fc7fa36mr18089175ab.3.1753225683585; Tue, 22 Jul 2025
 16:08:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722135057.85386-1-kerneljasonxing@gmail.com>
In-Reply-To: <20250722135057.85386-1-kerneljasonxing@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 23 Jul 2025 07:07:27 +0800
X-Gm-Features: Ac12FXza06BuAb0W28VQl1NaN6Z6Y25KJi_4nA0fzQz21BHQq_5MVFnMh8KihHA
Message-ID: <CAL+tcoAnB+8ZLPyWQ3XsvWTa=JO1yCKWvrKVp+2WCP=kGpfSPg@mail.gmail.com>
Subject: Re: [PATCH net v2 0/2] xsk: fix underflow issues in zerocopy xmit
To: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, bjorn@kernel.org, 
	magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, 
	jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com
Cc: linux-stm32@st-md-mailman.stormreply.com, bpf@vger.kernel.org, 
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 9:51=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> Fix two underflow issues around {stmmac_xdp|igb}_xmit_zc().
>
> Jason Xing (2):
>   stmmac: xsk: fix underflow of budget in zerocopy mode
>   igb: xsk: solve underflow of nb_pkts in zerocopy mode

Willem has pointed out it's technically not underflow but the negative
overflow[1]. So I decided to send a V3 patch with this modified.

[1]: https://lore.kernel.org/all/687f9d4cf0b14_2aa7cc29443@willemb.c.google=
rs.com.notmuch/

Thanks,
Jason

