Return-Path: <bpf+bounces-52063-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1FE0A3D3D5
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 09:58:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 166F4172AB9
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 08:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35921EE035;
	Thu, 20 Feb 2025 08:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KGlSnrkM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB731EE002;
	Thu, 20 Feb 2025 08:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740041867; cv=none; b=i4ulbjCisvhZbqX3dZnKj5aMqWdDYOUwC143WpSMwZrB3b6v6tDJTYrFyEzVQ2xqblyy62NSBZ5J/6UsgYV/702XX/k1J7/jrG/rEMTPz0yqdOMNRGrtH+XvwzLANi7T6EJCll1T/96CEP32kWQTXNP1xCMRCCG5W1J73PD/Y0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740041867; c=relaxed/simple;
	bh=Xe3KW08CtnTWxDsfXEunDUYKjhgHZTGBlTQTiSWGgco=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b/qJLrwosoTKnu0hTIU9k+SvPGOYkm9n7is+8sFbVNq1ko3ICv8/l+PY5ySsSHiJKlzIbOIOMcdUdj13zvzDBZTsIBV8xrpvT59X0FxvjI5EOgYmnCCvE7pG3VeTY9dCCqbVAJ+QWJtCMqUMFRbWT9GdyLQEHfsGtcha2ZPn7qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KGlSnrkM; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3d285a447a7so2038685ab.0;
        Thu, 20 Feb 2025 00:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740041865; x=1740646665; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZJ1ukTj9LoDYtqtD5ecMxI2UxUwlSfIH76RTECIiysM=;
        b=KGlSnrkMxcQlK6ipV3DNJueHJgW1I8NrDefK66Coo4IuMVvKN/sdo2g69ce/GyVq6I
         rQRTaJWlBdfRLqeN6rmStBjswY1t6JH2NR0sWKb2HmazLbnWXyCOItTh8wkilFOrOTxB
         9Lxw1OtJF9WGIOtCfNIypTxqg+I3oXoSUadojAGkktHn0fGOKa6eoRbUrV4cS5WG7yDf
         Uz1T3F6p27eW1CeZqEt8yQYzBdL2mcdcK8We+6vjcWIxE+rFRKhkqPmNAe7yySZDi59r
         fRRfDlXW4Xp97um9XxzW3PuMusO6rHT5Oo0Gxt/kGN9D8LVwHYRX/C1xdgnPIkJ7IOqk
         KVrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740041865; x=1740646665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZJ1ukTj9LoDYtqtD5ecMxI2UxUwlSfIH76RTECIiysM=;
        b=KmokUI2XvTAbxW0UYABKxgoO1rJwwWLpMNpj0DdsLCJY/UcQnZMvdAi6mSAZPQfazb
         mNHZ/kTnzIodzy6GxYvZr55a1IIDH7e0pyF07piLGSPjwrZrgSzT/DbKa7Lw8feLGeKa
         5m6YfjSGHaWXlxZixkoU97m9krLJyHsb1+jyzVP8PGLv2B8gA2VnKNrdC5ZJ9LpTsOfy
         TFugdxYE44hmEZ2SGFj9Dz4SxYedZqF8esBDIEbahUCVx4Ka85JTK5zBR6MyQ/62T9Sg
         0iptXwKGR4yAf6y4WScomCJvPjSP6oGDqHB1SYmHXdKWcDFQxX55JEJIHsi6P4kJ2OyS
         qYWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsjRmee00VC58Bb4OxUU685+5agVpxljgX+Q6/gz8wdjpYtaTmLMIAF9VmxGZUpKUn3QfZXHDQ@vger.kernel.org, AJvYcCUwaNcHv/VhdlJS2/aBdiYGK/uwz/dLjmGBhScmdUN+sb83rQHkFM7+0pc8EdaUEAqIn+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyimTLxgbDqxZb6ClZEX3FPeKk7arHaaxnFmES/XXmppcshq/V
	XTiOJ9eOpos6s7hd7Qd5ZEY/hLT/kR03swxiLYAbQJSJJqhxEXTQLovUyJntP7anRIxOTlXxaED
	rphbFBz9g9gsdnbvZMxJPcWRNRG7AyrlZw0AdSQ==
X-Gm-Gg: ASbGnctUaR6R18eB5PE6Rk56LS6icix6dQRi/2GP8gEcKCPLY9NF/9pKEc1NXtDO0UY
	S16KqDkj5CcR8c4vhvCHcL8uNftFT19LrvthU6NEyQN34weDfPMo8LLauo6qXTlQaoRMdpDQq
X-Google-Smtp-Source: AGHT+IFqzNFKSbcp0m+sVNShsOIjZnefnBiSt3e7dTYZO4FvWSEE9vIyYmmpnmKMzyBwF8FIEZfT3i4wI6Q0Vt6JVKE=
X-Received: by 2002:a05:6e02:2686:b0:3d0:3fa2:ccfd with SMTP id
 e9e14a558f8ab-3d280771e1amr219813525ab.5.1740041864809; Thu, 20 Feb 2025
 00:57:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219081333.56378-2-kerneljasonxing@gmail.com> <202502201843.xA1qZbKX-lkp@intel.com>
In-Reply-To: <202502201843.xA1qZbKX-lkp@intel.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 20 Feb 2025 16:57:08 +0800
X-Gm-Features: AWEUYZkZEa_RTXX9eGIodABGhTE06_-yx8MFYAYIY0b_nk5Ib5cNvbHdq_7paqg
Message-ID: <CAL+tcoC9nboQ9UNeP1-g4nQKqXg+fLDu68RHjwKRx97f_iuCZQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: support TCP_RTO_MAX_MS for bpf_setsockopt
To: kernel test robot <lkp@intel.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, kuniyu@amazon.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, ykolal@fb.com, 
	oe-kbuild-all@lists.linux.dev, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 4:52=E2=80=AFPM kernel test robot <lkp@intel.com> w=
rote:
>
> Hi Jason,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on bpf-next/master]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Jason-Xing/bpf-sup=
port-TCP_RTO_MAX_MS-for-bpf_setsockopt/20250219-161637
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git =
master
> patch link:    https://lore.kernel.org/r/20250219081333.56378-2-kerneljas=
onxing%40gmail.com
> patch subject: [PATCH bpf-next v3 1/2] bpf: support TCP_RTO_MAX_MS for bp=
f_setsockopt
> config: x86_64-buildonly-randconfig-002-20250220 (https://download.01.org=
/0day-ci/archive/20250220/202502201843.xA1qZbKX-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20250220/202502201843.xA1qZbKX-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202502201843.xA1qZbKX-lkp=
@intel.com/
>
> All errors (new ones prefixed by >>):
>
>    net/core/filter.c: In function 'sol_tcp_sockopt':
> >> net/core/filter.c:5385:14: error: 'TCP_RTO_MAX_MS' undeclared (first u=
se in this function); did you mean 'TCP_RTO_MAX'?
>     5385 |         case TCP_RTO_MAX_MS:
>          |              ^~~~~~~~~~~~~~
>          |              TCP_RTO_MAX
>    net/core/filter.c:5385:14: note: each undeclared identifier is reporte=
d only once for each function it appears in

We've discussed this a few hours ago. It turned out to be the wrong
branch which this series applied to. Please try bpf-next net branch
instead :)

Thanks,
Jason

