Return-Path: <bpf+bounces-36843-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0665594E1C0
	for <lists+bpf@lfdr.de>; Sun, 11 Aug 2024 17:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0243BB20E99
	for <lists+bpf@lfdr.de>; Sun, 11 Aug 2024 15:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E390714A0B3;
	Sun, 11 Aug 2024 15:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MlZPxKrM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D13B64E;
	Sun, 11 Aug 2024 15:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723388630; cv=none; b=D/CTZDcUoPTU0QrzC5BFZBm2AI+RJJOP9ck4W9+IqoFZfTQAc+rtZbSlK4QsvzWXsKxsWeY7ENnUP7/uJt/A7N+7M02nfjdjtPGvtnGaZrrTMg/YtGxWUccRxg2788TpxwHjl6TbEQ4yDDHLB6/tSrjrebyPCuHlwL7YtbSeJ8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723388630; c=relaxed/simple;
	bh=t56VbpVtJ+Zdlnja/qi8vfMVnThbtLYAwjUZlQMKN0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ww25z070e2T8i0TaCiVgFRKyvAa94LJf1MtLtU3tOvq0diOFxh5o3v6A6/c8ubeNXl7Mo9aJw8dKQs3ZCrMacCo2PtiUzJrWEYHiocjxmm9ImW3FsqYK9v/rIHE4Py9MAGSscFeHjv228GIJSprL3IuUR+28hL/QowEIsJkuPv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MlZPxKrM; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4281faefea9so25949225e9.2;
        Sun, 11 Aug 2024 08:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723388627; x=1723993427; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BLQEJ+WX0ldiAMY/HSIi4WEWR2xNDc8YrU3kn4DHc6g=;
        b=MlZPxKrM9vhx1Bxa/4lxoTv/PEzhSfe0K4uYHbfF3wD4z8wv262Oc64t94pJVzE67r
         aQGKbtrXB3g5bx/zxDqfmhgh5sA2fwKaSIAKV2xBzKwMokW2fPpagQCNTXZF8B2vo3Fk
         SSJXTUgfS++wsclf9BtgWW3Rr6MlzUUhAVGQmAm5iug5ONTAvEEmgQez1n3p2mMMls1q
         4cp6yEG7I6zE+T/esGv8pmlx+t5k2FpCHs9C7cIHXXXmaTbGOQt8yNgUki75XnXg/Bs7
         nUeppUoVVTJ1AVDLf47hru0OTECGzCCMBCNBxHifyTEbG53U6Dw79yzUVK/mgMltYJcu
         7Oqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723388627; x=1723993427;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BLQEJ+WX0ldiAMY/HSIi4WEWR2xNDc8YrU3kn4DHc6g=;
        b=cElpbXoS4rx4UG6Q44/ZeAc1co2QIALyD1Yi2ZEg7XMwmsCITM21FcTxp1mKws5vlD
         xlrY7g/ER+8PNKjyuDxdfC3QnMlmSTJhaSJzsDVZCvlWwsl6TYPwgFXwDab4PHwxsnTM
         qdj1bdOnRfGlnIQ1V/Z+0ims8gwdMHB/7M8epuEyg+X8ApAlpOc/gjTf3qWnkjTeO3vw
         tzfJAyzLTOIUsFDTErdMar+c/wJLa7yc7KBNnp0ZLS1uS0oyZqS9Rz+r+wo9bzHdXUNe
         ANNTeRnA+FKcUI72quYLuETZokrwJPxjisVgBuRL4dqWi+OdQpSv5tVfZzCEWvN/IIwx
         rV9A==
X-Forwarded-Encrypted: i=1; AJvYcCVUyC4LzQNwra/H2RdPE4GTPB8x0QO+FAOUO+e/8KHnhgJekb/C929YWq/JKFbu36TZSr93KYqq1ZZok1OLULLh5AclPzGMHo9BlUvLzdWUwyy1wY0hKe7Kb8IN/6wWeWYO
X-Gm-Message-State: AOJu0Yxpwh1tDuFZq3VkdggEdaKvOjiwZi4cFIOnhuxRa20cRLuRN3Yc
	7ZhzN11e+klcIbMlfP2YmBGNNbb230VGhvWmBmiBpTL0BjOk88AX
X-Google-Smtp-Source: AGHT+IGRCcyYRtOhzZaRR+hNljuWSn1EeObk0KM0LDvFEUW0jXe00dokU1umwMkyPsJJouac/jht5Q==
X-Received: by 2002:a05:600c:4f8f:b0:426:6ea8:5037 with SMTP id 5b1f17b1804b1-429c3a643bdmr46498235e9.37.1723388626791;
        Sun, 11 Aug 2024 08:03:46 -0700 (PDT)
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4f0a6d76sm5087903f8f.115.2024.08.11.08.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 08:03:45 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 2F04ABE2DE0; Sun, 11 Aug 2024 17:03:45 +0200 (CEST)
Date: Sun, 11 Aug 2024 17:03:45 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
	Akemi Yagi <toracat@elrepo.org>,
	Hardik Garg <hargar@linux.microsoft.com>,
	Quentin Monnet <qmo@kernel.org>, bpf@vger.kernel.org
Subject: Re: [PATCH 6.1 00/86] 6.1.104-rc1 review
Message-ID: <ZrjS0V-tCQ1tGkRu@eldamar.lan>
References: <20240807150039.247123516@linuxfoundation.org>
 <ZrPafx6KUuhZZsci@eldamar.lan>
 <2024081117-delusion-halved-9e9c@gregkh>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024081117-delusion-halved-9e9c@gregkh>

Hi Greg,

On Sun, Aug 11, 2024 at 12:09:30PM +0200, Greg Kroah-Hartman wrote:
> On Wed, Aug 07, 2024 at 10:35:11PM +0200, Salvatore Bonaccorso wrote:
> > Hi Greg,
> > 
> > On Wed, Aug 07, 2024 at 04:59:39PM +0200, Greg Kroah-Hartman wrote:
> > > This is the start of the stable review cycle for the 6.1.104 release.
> > > There are 86 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > > 
> > > Responses should be made by Fri, 09 Aug 2024 15:00:24 +0000.
> > > Anything received after that time might be too late.
> > 
> > 6.1.103 had the regression of bpftool not building, due to a missing
> > backport:
> > 
> > https://lore.kernel.org/stable/v8lqgl$15bq$1@ciao.gmane.io/
> > 
> > The problem is that da5f8fd1f0d3 ("bpftool: Mount bpffs when pinmaps
> > path not under the bpffs") was backported to 6.1.103 but there is no
> > defintion of create_and_mount_bpffs_dir(). 
> > 
> > it was suggested to revert the commit completely.
> 
> Thanks for this, I'll fix it up after this release.

Thanks! Note today Quentin Monnet proposed another solution by
cherry-picking two commits:

https://lore.kernel.org/stable/67bfcb8a-e00e-47b2-afe2-970a60e4a173@kernel.org/

Quoting:

> You should be able to fix the build by first cherry-picking commit
> 2a36c26fe3b8 ("bpftool: Support bpffs mountpoint as pin path for prog
> loadall"), and then commit 478a535ae54a ("bpftool: Mount bpffs on
> provided dir instead of parent dir") as you figured. Both commits have a
> minor conflict on tools/bpf/bpftool/struct_ops.c, which should be
> addressed by discarding the relevant hunk (for both commit).
> 
> Alternatively, it's also fine to revert the breaking commit. It's a
> quality of life improvement without which users may have to manually
> mount the bpffs at the location they want to pin their maps when loading
> multiple BPF programs with "bpftool prog loadall", in the unlikely event
> they're not using /sys/kernel/bpf, prior to running the bpftool command.
> It's not in use during the kernel build process or for the BPF
> selftests, so not necessary on stable branches.
> 
> I hope this helps,
> Quentin

I cannot judge which is less risky, but I will for Debian in any case
follow what will be picked (if needed to cherry-pick those in advance;
I was meaning to release another update but can now as well wait for
6.1.105 with that bpftool fix).

Regards,
Salvatore

