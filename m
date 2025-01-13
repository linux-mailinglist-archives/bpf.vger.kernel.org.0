Return-Path: <bpf+bounces-48660-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5558A0ACC2
	for <lists+bpf@lfdr.de>; Mon, 13 Jan 2025 01:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 396A37A2BD6
	for <lists+bpf@lfdr.de>; Mon, 13 Jan 2025 00:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E19D523DE;
	Mon, 13 Jan 2025 00:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cGgbedJv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D294136A;
	Mon, 13 Jan 2025 00:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736727135; cv=none; b=h1T7+lsxPqdfbu8lxWWnOhMnN9UGe1vpE5gwY3xPTKM1Pba+QyifGk8U7dXJplsy1UrPKn+07HVVfMhZ5EenIols19CoqrzFM966GGYHEtVRG5vwMNNm6XTRYsDpC77PSJQqPKARyskMHz9eTuSKPDUXyDKHtiXVnDeiUMYYqC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736727135; c=relaxed/simple;
	bh=TMlTbizgnR+xTCZnuoTxQWuoOkPGbMGynCYA2mYCmRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gc0t6fej90IPcI18hPttf9d/O5vYggwFztBxMyQgzbH3rBOVMBGqKsf2GeO7cfMdS8WsEFPXrVqpqzMn5n7AfwxDWdRX9cFUr+vs2hX/H1sthlHsKvmcvrRFAmSk1VN35/350aQ9m0kJc0lLWaX+I6R1kBz6KOarxqHnghPYa68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cGgbedJv; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-84a012f7232so154195739f.0;
        Sun, 12 Jan 2025 16:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736727133; x=1737331933; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9cnJ53oIhTglfaz80ugv/pgKzPSiLe7spK70sPzYX4E=;
        b=cGgbedJvacOENm1BrxBDlMuoqjyecYNCEX8HVP6dmE6w/H2SyRV6MFC5rAYRBOlHBQ
         VWNd+x9qJUxEclYQHF77HcPJIlkTyBj84C6KReDNhIoDFWfmP9EDud6JWYx+DaOJDj+6
         ssMDWcYlTifLgSfZtvNgpqJegIpBfjdqa++A8xGQqq57UOSnq1bsn6rkYt/VSyYjWZ6o
         GN+lsEhX+Zg32EpQHvtGaRON5mTqx3aR3D1P/yFY0Cpq/RTK+kmkpPHRGEkQy0g7aQSZ
         NvWv4uSEMshGDWSKBJ0+HJZKjjMeDJKfkTs3yZRnVWea6wmmhwgTDEPSMTj6xdAp/vtA
         AVCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736727133; x=1737331933;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9cnJ53oIhTglfaz80ugv/pgKzPSiLe7spK70sPzYX4E=;
        b=VCnW/ntp1Q1KZDZQeExxVBc2ku+36iqbociNfbcpMxeDE/ipF/CRCI6Q5mXM3ibl/+
         4ntHaevULmXJI7YEOSI2SETS3muBCuiBe9tnjU7+ViYjQJmgjElVTdEacHJG61R5DKaX
         Mc3Z5f5X3XylTA8mSbz0/IAw/Tjg98XzHjH0dod1OMyiIu2CYDdCIX3aGPfyv8Nu4D/w
         4HDbGpM81t8F5lb4gm4tO74rCwR/1jN6zYp2yptCn2MHwM0A4lnLLtD5WyBR/munxNRj
         kb5ScT/a+ID2bDzMesvzUOpFYphU0++hUmzD0EiaWST1pyB8o0/p10XGAqo07e5mI9F0
         xdIg==
X-Forwarded-Encrypted: i=1; AJvYcCURfCuYbb1hDFJt9MGO4cvuhQxIfCn+NRqHPoMQrJWE+bteMv8AMpi8OYdri00ImW5Nw+I=@vger.kernel.org, AJvYcCV0qp1t0LEQy/ykr5973nafdCHYYbEkZiMxEdJ7+nSweuAF4mmlkwLGUFZkv1CQugB8pen5irRU@vger.kernel.org
X-Gm-Message-State: AOJu0YyXdPUFvKbii1reB3WwQZUHtlo5L9wOPETTDA4dGfmvEit6rce+
	7uMP7A8V4yxJGouaYBQ2wRFzUoo2n8HFxCxl6K3bSGgBny7K7LZXnuaaBJB8cg13GFB5Rlovbch
	DHmSAxdG/7LqYL05IR7ncMLkgdPw=
X-Gm-Gg: ASbGncubAi0QSsIB7yKv3T+4eutabMtxPFCx6cPuDpvN84SzYDxQNAruSXlaXFrKlAS
	GzBLWH7qE7jfDQc6Zd79lxYMOjtzWoUyCpiP3Hw==
X-Google-Smtp-Source: AGHT+IGk8dqDNQZ+mjNd6puxoUiqimP8vd2vEum9Ue7CkZ1G4OHaDEjH5RRs6SCz0wf9/v01BbY3JYfjAXvcG/l1jwk=
X-Received: by 2002:a05:6e02:1a8a:b0:3cd:d14c:be69 with SMTP id
 e9e14a558f8ab-3ce4b212f1dmr96833635ab.11.1736727133078; Sun, 12 Jan 2025
 16:12:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250112113748.73504-2-kerneljasonxing@gmail.com> <202501122252.dqEPb1Wd-lkp@intel.com>
In-Reply-To: <202501122252.dqEPb1Wd-lkp@intel.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 13 Jan 2025 08:11:37 +0800
X-Gm-Features: AbW1kvbp1NkkMKbd-_UYgUVRy7aU5R7K_OeYQ0U2gfRHv-CnaHRd4pm1sdL37Sw
Message-ID: <CAL+tcoCvO8xapF55_TKj-rs8jJvSRRQ=EQHiZZvrwSPYoVFc_w@mail.gmail.com>
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

Thanks for the report.

On Sun, Jan 12, 2025 at 10:50=E2=80=AFPM kernel test robot <lkp@intel.com> =
wrote:
>
> Hi Jason,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on net-next/main]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Jason-Xing/net-tim=
estamp-add-support-for-bpf_setsockopt/20250112-194115
> base:   net-next/main
> patch link:    https://lore.kernel.org/r/20250112113748.73504-2-kerneljas=
onxing%40gmail.com
> patch subject: [PATCH net-next v5 01/15] net-timestamp: add support for b=
pf_setsockopt()
> config: i386-buildonly-randconfig-005-20250112 (https://download.01.org/0=
day-ci/archive/20250112/202501122252.dqEPb1Wd-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20250112/202501122252.dqEPb1Wd-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202501122252.dqEPb1Wd-lkp=
@intel.com/
>
> All warnings (new ones prefixed by >>):
>
>    net/core/filter.c: In function 'sk_bpf_set_cb_flags':
>    net/core/filter.c:5237:11: error: 'struct sock' has no member named 's=
k_bpf_cb_flags'
>     5237 |         sk->sk_bpf_cb_flags =3D sk_bpf_cb_flags;
>          |           ^~

Strange. In this series, I've already ensured that the caller of
sk_bpf_set_cb_flags is protected under CONFIG_BPF_SYSCALL, which is
the same as sk_bpf_cb_flags.

I wonder how it accesses the sk_bpf_cb_flags field if the function it
belongs to is not used, see more details as below (like "defined but
not used").

Thanks,
Jason

>    net/core/filter.c: At top level:
> >> net/core/filter.c:5225:12: warning: 'sk_bpf_set_cb_flags' defined but =
not used [-Wunused-function]
>     5225 | static int sk_bpf_set_cb_flags(struct sock *sk, char *optval, =
bool getopt)
>          |            ^~~~~~~~~~~~~~~~~~~
>
>
> vim +/sk_bpf_set_cb_flags +5225 net/core/filter.c
>
>   5224
> > 5225  static int sk_bpf_set_cb_flags(struct sock *sk, char *optval, boo=
l getopt)
>   5226  {
>   5227          u32 sk_bpf_cb_flags;
>   5228
>   5229          if (getopt)
>   5230                  return -EINVAL;
>   5231
>   5232          sk_bpf_cb_flags =3D *(u32 *)optval;
>   5233
>   5234          if (sk_bpf_cb_flags & ~SK_BPF_CB_MASK)
>   5235                  return -EINVAL;
>   5236
> > 5237          sk->sk_bpf_cb_flags =3D sk_bpf_cb_flags;
>   5238
>   5239          return 0;
>   5240  }
>   5241
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

