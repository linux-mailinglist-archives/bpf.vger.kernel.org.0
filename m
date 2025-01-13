Return-Path: <bpf+bounces-48669-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50FA2A0B024
	for <lists+bpf@lfdr.de>; Mon, 13 Jan 2025 08:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6897C16033F
	for <lists+bpf@lfdr.de>; Mon, 13 Jan 2025 07:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD55C231C8A;
	Mon, 13 Jan 2025 07:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H8KtvXyb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA74418CBFE;
	Mon, 13 Jan 2025 07:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736753584; cv=none; b=MsKPMXAGl8lfxPtocuHa6vmtP8Zj5dx184EB5KNGAZjqeCdGV9hC0ceiKCHy01W7Jgb+v2nvPhkKiA4JpaS5N/EW6inPnCk0GJg8+PmMsfypIWDEUnzkGWlgLYsHQCBLKFiI9aMvzU8yQtkUXYtRACRRfeiFVnpH4msT4hbwxLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736753584; c=relaxed/simple;
	bh=Ge9TQil3ArmbLEzK2INJ9sl90M8s9I7H7IASo1Au5qE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WbPOo0WG8qyeod01hYmcFTF3jQbdBlmKzWJzTHTufDxyQZ2uGZeK2g2YKwkp+xMKGK/iGejM+/giTb4VvFvvNbk/uWRPrJ1zNrPiPub9pZ0XW2AsfHeX9Ne1z/SUyfxUm1QL+W+6dwqsHfXs0dqTd8sjakt+/5X/zBsLFcpoz/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H8KtvXyb; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-84cdacbc373so130830639f.1;
        Sun, 12 Jan 2025 23:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736753582; x=1737358382; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=arj+ofbfvLi3WuyU/a3nyYwlbHlastVq5NJMCKrVWwg=;
        b=H8KtvXybjJ7rt8G7RiWvM0GB2Q1dGjogjBfSSTC3OyEK4y4oX2Iy/9nx6P8jjT5mZe
         YcLGteOdtg9SJ1WbFkYE+3EkCyYFuL+bfmgHPlzSAHT9UK3GBj1FmEkwiTpY2CytgX9X
         Camd4vK15K5O4Pr7bNW1W9X1RQTWLAjuNPiJxAyauOGb3/bE+LbspsuRjGjLnZjSHACN
         8Z8HoSn7I53lVfu5RTBRphvR2tM9gpYosYOg13j0t3jCUcI8HytHqPy8yeAQ1H5puKjq
         v5HTpzdtP8fJmh1babqt5LJcEo7p6Dq1l6M94hsGPTo8ydFQw8kdWnkaPuEmWT+S9nZD
         8Irw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736753582; x=1737358382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=arj+ofbfvLi3WuyU/a3nyYwlbHlastVq5NJMCKrVWwg=;
        b=voVDFzs91Cio+hc2s3H+lzk8SbQY5hs6yT3tA9rFfYrVnCwjrFbZJ8jGAcnpnQ5BL9
         8jp8jsDxi/oCsK0cbOLLV38mUICepi7yn8C/lAfJTqkpReKJtTclQ1nqtqJGcbxtX6Li
         FsQJuR1QF2Ts/Q6COp6ROMEdTX7P6y96GEQu8id1qjZe5E9Ueu4ianhwrjM8rKUpEVk9
         VhcgP6S1Nt77UypsT+CxM3QEQ/MAGFAV22DR0DK7abQ/QJWySz8y/VVwhEej7qdM8mcX
         2+xFmKR85LjXat5W6v8wwuqKtPMRyX6jjhp52EofCyT/kMj4HlrE0eJ81COrzst89ehV
         o7AA==
X-Forwarded-Encrypted: i=1; AJvYcCUltKjt0XLFITuKdEiMAwJH6DtKfJ+Qe3w0pmIcinYMYzGyT12bAHMGFzGr3wokIzjJ3Fk=@vger.kernel.org, AJvYcCXNdFdEWVYgIPPT29sYMAy76Fja7q7jtMlWvGEZsAcemhgST2zZVbKNaygogFTavPqN3quHPyus@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu7Im+S9ti++dS07vZ7Xc7EjcQObpV05LXG7q25n604mESbdxI
	ky3zhrpbfUc/IJ7zQpg04JlHSbzGWlMlzGyX3bSw6p1GaZJCgUMAipsOkvUIC44QojlbQrQmC64
	H8Goq10DVzNk6MXAJ/ZvEv2TOEpQ=
X-Gm-Gg: ASbGncsBxEDGZ4OHIZHwRu0VDw+e6RobbCu0CyHKHJZirOhIxgm6mhxHY0inmwEVZFU
	LZTmt5x2q7v4azu4442mVThK7Va1B8yRilfYahA==
X-Google-Smtp-Source: AGHT+IFXhkXK5r5EvkPMzbE0zcn8NMoLy/WtF0Yy+V0yYASPieWue1Uuk4AcZscypNNxroDOUAi2uekyOpa+qD2R+OU=
X-Received: by 2002:a05:6e02:160e:b0:3a7:d7dd:e709 with SMTP id
 e9e14a558f8ab-3ce3a878004mr148298155ab.7.1736753581731; Sun, 12 Jan 2025
 23:33:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250112113748.73504-2-kerneljasonxing@gmail.com>
 <202501122252.dqEPb1Wd-lkp@intel.com> <CAL+tcoCvO8xapF55_TKj-rs8jJvSRRQ=EQHiZZvrwSPYoVFc_w@mail.gmail.com>
In-Reply-To: <CAL+tcoCvO8xapF55_TKj-rs8jJvSRRQ=EQHiZZvrwSPYoVFc_w@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 13 Jan 2025 15:32:25 +0800
X-Gm-Features: AbW1kvaE9itCTzXOypNRU44YXj2F2bc0OlU5qI2bwo9NzvpoqYhcRdZZ9tFKiRY
Message-ID: <CAL+tcoDajZCtWSb74AJ=w6fVLAQRBbAFtU683PV7sqo3uHaDaQ@mail.gmail.com>
Subject: Re: [PATCH net-next v5 01/15] net-timestamp: add support for bpf_setsockopt()
To: kernel test robot <lkp@intel.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com, 
	willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, horms@kernel.org, 
	oe-kbuild-all@lists.linux.dev, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 13, 2025 at 8:11=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> Thanks for the report.
>
> On Sun, Jan 12, 2025 at 10:50=E2=80=AFPM kernel test robot <lkp@intel.com=
> wrote:
> >
> > Hi Jason,
> >
> > kernel test robot noticed the following build warnings:
> >
> > [auto build test WARNING on net-next/main]
> >
> > url:    https://github.com/intel-lab-lkp/linux/commits/Jason-Xing/net-t=
imestamp-add-support-for-bpf_setsockopt/20250112-194115
> > base:   net-next/main
> > patch link:    https://lore.kernel.org/r/20250112113748.73504-2-kernelj=
asonxing%40gmail.com
> > patch subject: [PATCH net-next v5 01/15] net-timestamp: add support for=
 bpf_setsockopt()
> > config: i386-buildonly-randconfig-005-20250112 (https://download.01.org=
/0day-ci/archive/20250112/202501122252.dqEPb1Wd-lkp@intel.com/config)
> > compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> > reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/arc=
hive/20250112/202501122252.dqEPb1Wd-lkp@intel.com/reproduce)
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new ve=
rsion of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202501122252.dqEPb1Wd-l=
kp@intel.com/
> >
> > All warnings (new ones prefixed by >>):
> >
> >    net/core/filter.c: In function 'sk_bpf_set_cb_flags':
> >    net/core/filter.c:5237:11: error: 'struct sock' has no member named =
'sk_bpf_cb_flags'
> >     5237 |         sk->sk_bpf_cb_flags =3D sk_bpf_cb_flags;
> >          |           ^~
>
> Strange. In this series, I've already ensured that the caller of
> sk_bpf_set_cb_flags is protected under CONFIG_BPF_SYSCALL, which is
> the same as sk_bpf_cb_flags.
>
> I wonder how it accesses the sk_bpf_cb_flags field if the function it
> belongs to is not used, see more details as below (like "defined but
> not used").

Well, I still can't figure out how it happened. In the next respin, I
will try "#ifdef CONFIG_BPF" which bpf_sock_ops_cb_flags uses.

Thanks,
Jason

