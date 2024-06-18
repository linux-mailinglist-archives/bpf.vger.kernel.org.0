Return-Path: <bpf+bounces-32409-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA2590D634
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 16:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 801A11C22582
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 14:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B7D153808;
	Tue, 18 Jun 2024 14:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QYTsAoPN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B50E14EC53
	for <bpf@vger.kernel.org>; Tue, 18 Jun 2024 14:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718722174; cv=none; b=AY+cow2jbAldmD3BRyS5U0pzpoCe+zZk3MntjVzEHm4aKnmfvbLmAgC2W+4pa/fNWnaYQTPx/9jp4Es7Yc/2rUow2CYMgkYC1tE1L4NbwW6hdJEDkSMxZM/rYIVvCB/gHD4tZt9GcqPM59Vv8BcuI0XAB5bCaS2mJ5uawfhD5jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718722174; c=relaxed/simple;
	bh=C9hqSTGvMVbL0dDjMjl6s/vq07dKxRgXZkPRd3ns2YE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BewA0XRGf0eC+pWnrmKfyIhkp0+UoWD0lfdekHuOYo7JjFobPEjpCV008V2pdQSnc4DeYG0IFo7rLqikxVgXWivV0SnfRCRl5Txn+LmltYV2RkQ7XvsjOCdevu5eb2IS3msGXihWfDffnGIlBKFjpo44uyU72OREjNLzozkRXL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QYTsAoPN; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-35f2d723ef0so4673614f8f.1
        for <bpf@vger.kernel.org>; Tue, 18 Jun 2024 07:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718722170; x=1719326970; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QqCSehTywUbdinyS1VSJf8CsGxImjeg52RwkLRKBR8M=;
        b=QYTsAoPNJkhdKyMqGpThMHqJICH7K/eLAG6KEgUxvgRx78Ze+eivN6Qv1kpq+TxI2Q
         Vn1onLY4iD2v9QI74/oA61knYQfESX6TJD7WsIMcxCGXWRp402CKe72mqIlawqtHbCoW
         wI52GpKGxz6KxETwXjZfK/PLRBZc9dspiju6tcPLLZMQLy6/iiNCsnYfhZypKOEBh0n4
         Qw3FGnoSwwKIFylr8CWZi4Aq8r6uiT06L7EOyWI4+u8jAt0ZZX+au0AK5Qki6m9egjXj
         G7W0QGEIfPUEJBWiwhG67JvHEUpfSOy3/ifWYE//gPIInue7tk4pCGz2bnZAHvx5xSlS
         qVvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718722170; x=1719326970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QqCSehTywUbdinyS1VSJf8CsGxImjeg52RwkLRKBR8M=;
        b=fJmEsTEGHnLjWLg5jwyW7J7WGuW5twX74Lgk7s7XGrD6nMcrAUAJ3MJQ0Nxyj5iN6i
         acOpNHMD7lmYjlvt3kYG79KhyRFAzuyS1OHA5bqCOIAd/YoRGqBiUjTm6eDu1wLibP3s
         rOg9Og3jLcqi6uRGAbs92Pish9QcNOTsutHzJ3zBohUl0+mgkfuoXQR7ywGpGxOLNGtd
         q3D5omjSzrSCSs8S9AHklLhhSzVsCMi29SNO+K87t8RuJAclxH8nEs+dgdA671FbCxyy
         /fOx1NjRaYbPa6xMsL6/9F6jp1TEnTnT9RPEzkM5xARL3Yia2Q+meeaemC1gzJ2QQGdM
         pyWQ==
X-Gm-Message-State: AOJu0Yz3CfHj9/N2e/e/grntNxl6YfS+BNDhfJr6ni0MfW2eNW8tDJkW
	gg2ksX8qTRYPosJjDLptd839vREGhoeDWpeE7d0Pkm8YdfTtlUj7KmqDsB2TUK93fBA2hAVpsGf
	hiTLWWdBhENJhiatHKS0PafFwzQk=
X-Google-Smtp-Source: AGHT+IGNGyiHR5ERlKdy3RB+H4nV5RPK52+deMJQ0y2JvTeFBlJgxVW8xIu698HIuv6JP7sZjy/a89wggL4veSk3vcA=
X-Received: by 2002:a05:6000:cc4:b0:35f:1d40:82fa with SMTP id
 ffacd0b85a97d-3607a743affmr9417259f8f.18.1718722170184; Tue, 18 Jun 2024
 07:49:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617171812.76634-1-alexei.starovoitov@gmail.com> <202406181248.u80sRLXy-lkp@intel.com>
In-Reply-To: <202406181248.u80sRLXy-lkp@intel.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 18 Jun 2024 07:49:18 -0700
Message-ID: <CAADnVQK0fLbhqRuLDEVj3dPpg46xR0KRmty0hJNQ2G04yeAKLw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf] bpf: Fix remap of arena.
To: kernel test robot <lkp@intel.com>
Cc: bpf <bpf@vger.kernel.org>, oe-kbuild-all@lists.linux.dev, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Eddy Z <eddyz87@gmail.com>, 
	Pengfei Xu <pengfei.xu@intel.com>, Barret Rhoden <brho@google.com>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 9:43=E2=80=AFPM kernel test robot <lkp@intel.com> w=
rote:
>
> Hi Alexei,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on bpf/master]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Alexei-Starovoitov=
/bpf-Fix-remap-of-arena/20240618-012054
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git maste=
r
> patch link:    https://lore.kernel.org/r/20240617171812.76634-1-alexei.st=
arovoitov%40gmail.com
> patch subject: [PATCH v2 bpf] bpf: Fix remap of arena.
> config: x86_64-rhel-8.3 (https://download.01.org/0day-ci/archive/20240618=
/202406181248.u80sRLXy-lkp@intel.com/config)
> compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20240618/202406181248.u80sRLXy-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202406181248.u80sRLXy-lkp=
@intel.com/
>
> All warnings (new ones prefixed by >>):
>
>    kernel/bpf/arena.c: In function 'arena_vm_open':
> >> kernel/bpf/arena.c:235:27: warning: unused variable 'arena' [-Wunused-=
variable]
>      235 |         struct bpf_arena *arena =3D container_of(map, struct b=
pf_arena, map);
>          |                           ^~~~~

Daniel or Andrii,
could you please remove this line while applying?

