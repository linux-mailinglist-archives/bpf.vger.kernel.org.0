Return-Path: <bpf+bounces-64142-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72CFFB0E988
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 06:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C9263ACA34
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 04:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CBD2212D67;
	Wed, 23 Jul 2025 04:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VYUXWLfy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D25E2594;
	Wed, 23 Jul 2025 04:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753244222; cv=none; b=r4XpSJWPJ+DoLmCxULNxlLbgNeiX2e5Xmn4eq03osIHZDlUjkdZ6bIMMaLR7bI2Mio3A7QFhhpoNYsyWunYUTFcf2JDLc70wwm4QwDALX4Q7gdT3WOSN4E3niKijhYfkLWUu9g6mBf4dIVLr1G8WEPI6ycaQeDEznbI8Q/EBlis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753244222; c=relaxed/simple;
	bh=rO8BKGvvMlEuijkHKs646XcLGMqSqCI7FfAGICzFfNs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eGx0uA+3vabPJAdMXlf/HO3XPn+RmLSJJ8zpto7UOYHVR65s1kqUUADJap2Di+IxBnHTi5e5fJZEYvRXu1JK4ePGG4wLMjFgHj62utNWQonoKpjlOOxbsT5Y4NvOOMqZB3j9hrqpmnTgOfMn/myb3IuVuMBjsVMoIyN+F+HLrLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VYUXWLfy; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3e28bf4a350so32749975ab.1;
        Tue, 22 Jul 2025 21:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753244220; x=1753849020; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C8oFT6sPKOg8VRT9sf+f9nquc2yr6H2/i1A3wu9QYuo=;
        b=VYUXWLfyufsctPb3sV65n25PzfX5hOQNeEx1L2u78mSgJ7uapyTh2T77sSwtlZvj0r
         oThZ19njbId2lIoYbF2KiT8mYp92FnXOl9RmHWr117u7SF69pqS14IXPfhpxdjI0ypU0
         262Tjy/YW1RKxXvVQ8p9J1n/oysVfn2C2HgsRzHbOtEmTbCuJLcUOhqK+iZ9FB36ChQi
         pn3loRbYgofYTSXiauP4OuwNpOHXKNTYQQpwVhibnexXznTLYYQ4OJhf8b1pYs+X+iiQ
         A6IVwyF+abxi/DMrgHR9sCGYoSEzyw8zAs17SFCPSBCtEhEui5V2yPx9gIvhEBP67T3K
         YH1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753244220; x=1753849020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C8oFT6sPKOg8VRT9sf+f9nquc2yr6H2/i1A3wu9QYuo=;
        b=RuMKn5XG1ksPbVIKuJ4x27NMxkiYwR1SJ6XqCMCR+a/aXFXH5aIsY9h6aXEUzh50Ct
         5a+V3med3XHYND7EjI8eOBHmqwePP2+FkQE/ifmOc96uC41gSb3n8E94LTxCCvtB7KOm
         US8Km5HWlE6W4aQcQ849Z5XsgWcJI2saabHFFw0ojtpPK08rd8Ry7z4xjjCODXze+EsG
         MSLraDX/ZsjWm58FKKAjXfvwsnTiPA7PxYbTYMnjaVWmxr8485dKCuMp4AWVzdp6BnLt
         JgpkknGhstJT+HlqxQmSApkPHYoZ41QaebTjqarbZGII0Qr2H1hJId4+RbNMh6Xb/7Ql
         w/ZA==
X-Forwarded-Encrypted: i=1; AJvYcCX9WEz+BLQjW80zeizaw3wrkqyPDCmYgElUmXs94SBz4yAwolHiiFABcNxit/sPAfWdWBo=@vger.kernel.org, AJvYcCXh0o7asUgCmQcPRhoNhIntCBYxx/qCjFGWEWCHU1p9iBJitGqZr2r19VX/hXDfHdNOvhhh+8sr@vger.kernel.org
X-Gm-Message-State: AOJu0YxpGSeTaCYKKjaltcafdKqu064fkZI0cIurcOhofO959nhcd6EL
	XCDF9YywlXtZPbRudsz1/H1Ecj5CR7bSVfARPpkQfL2Vi8T8tOrOhMHF2+CnouWImJjWZ8C2D9v
	y6/jRzpLVVYhUYW7Amg4yerHYIMWc3t8=
X-Gm-Gg: ASbGnctUUCaHFdcKWPk421hyppyzhLRpM+dDKqkRK5ZickBfBFFLNB9hTtIXtN3FU5/
	Hut0dClnEXqS/Y20nXnB2fd/hi9WQPMNUUWrlXFZ7zvGUIkRQDfLWbTnXfybWDwLcMZiKWAXMSu
	NNDAJH+hbWjNGjnk3KxGTS/61ggLVoiQHowQ7TIA7990Porxff2pVBMIb0f9mg+XpZhCd3AN+ez
	wxbdSw=
X-Google-Smtp-Source: AGHT+IHvfG4gDNwxiFwAV4bkIuvs3peWQ+Qchh4FuAeT25UrF8Y7hoMYUkFqbB0L8ENMUaL069TQE5i6aezBop5KoF4=
X-Received: by 2002:a05:6e02:3604:b0:3e2:a749:250b with SMTP id
 e9e14a558f8ab-3e32fc9ac94mr29841885ab.14.1753244220095; Tue, 22 Jul 2025
 21:17:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722135057.85386-2-kerneljasonxing@gmail.com> <202507231150.Gbhu52dL-lkp@intel.com>
In-Reply-To: <202507231150.Gbhu52dL-lkp@intel.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 23 Jul 2025 12:16:23 +0800
X-Gm-Features: Ac12FXxDJjAyfkHJ_DUda-RuAy-76P36wJK7-IwcJ40FektM2wOf1EwR8GjRFSQ
Message-ID: <CAL+tcoBj6sqKzHzmLte2uvrD4JWB=QC3U8OM0NpX2oJAyw7UmQ@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH net v2 1/2] stmmac: xsk: fix underflow
 of budget in zerocopy mode
To: kernel test robot <lkp@intel.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, bjorn@kernel.org, 
	magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, 
	jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, 
	oe-kbuild-all@lists.linux.dev, linux-stm32@st-md-mailman.stormreply.com, 
	bpf@vger.kernel.org, intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 23, 2025 at 12:10=E2=80=AFPM kernel test robot <lkp@intel.com> =
wrote:
>
> Hi Jason,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on net/main]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Jason-Xing/stmmac-=
xsk-fix-underflow-of-budget-in-zerocopy-mode/20250722-215348
> base:   net/main
> patch link:    https://lore.kernel.org/r/20250722135057.85386-2-kerneljas=
onxing%40gmail.com
> patch subject: [Intel-wired-lan] [PATCH net v2 1/2] stmmac: xsk: fix unde=
rflow of budget in zerocopy mode
> config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20250=
723/202507231150.Gbhu52dL-lkp@intel.com/config)
> compiler: alpha-linux-gcc (GCC) 15.1.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20250723/202507231150.Gbhu52dL-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202507231150.Gbhu52dL-lkp=
@intel.com/

Oops, I posted a wrong version which missed one '{' after the 'for' stateme=
nt.

Will post a correct version.

Thanks,
Jason

