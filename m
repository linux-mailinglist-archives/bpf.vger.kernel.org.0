Return-Path: <bpf+bounces-54845-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CDA5A744E0
	for <lists+bpf@lfdr.de>; Fri, 28 Mar 2025 09:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 598A0177FA8
	for <lists+bpf@lfdr.de>; Fri, 28 Mar 2025 08:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B43212B2E;
	Fri, 28 Mar 2025 08:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VIxcRODd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF414C2C8
	for <bpf@vger.kernel.org>; Fri, 28 Mar 2025 08:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743148932; cv=none; b=bCkMPSZ+AHSE8t4EhBtB3CAr5/zJNScM+WdJjK6Ctxc4HU+CkCdadvk3+CQ2RouUb6yuh4ZrHcMJ9f90zAg+8RL4zdkcghnv2R9xkzjH8jNnNwfHjI/hMXfV7/kJUw/NepWgvoX+KmBXBrYBzOwIOqbLqctq8/Bn3fJsiz6Uv80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743148932; c=relaxed/simple;
	bh=z2YDe1OU3wrVgPNLV8ZOOArWU+bI010amQn+oFWZ0So=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZUDIyq2TdmY0HbQbh5nqjvQmGPK3hnJ5H6RFT5ZmqKBEaURosOCSKRGcKbunm+DDRSA31rjglyAJ3+KlXs/kJe+ws69IlKgNFIMPPyscozz3n9SCHl5bZyhoo07axpd635BT+WbE6Ypg8BaAz41gxFsMHQh0N8/Uvc2CAQ6LlCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VIxcRODd; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3914bc3e01aso1033771f8f.2
        for <bpf@vger.kernel.org>; Fri, 28 Mar 2025 01:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743148929; x=1743753729; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aSnI14BbYG44AW/1FazNe/GgOwu32Ov8br248K1Kr2c=;
        b=VIxcRODdnhJqwpyGIGtCbjqCAkR6z3CTNGO2EWhYM/vZtXyCN3G0HyIm/oMvaC3vfw
         fL1Tm6CKC4SRSWsrirQB6hCuekGGU+cZQ3iOca5P9Z2OYlfAJ7peQtLgb2Tf403Jk7N/
         3gHlYAxWlRlh6yn8lPkAHm/plMnwNbUQ3TzGQ5OfwQxMrZyLD5CKExxhJ0eE1L0IMRMh
         u4IAcEMZvlaj6qcfW1U9xt8TM/KLYguV1R9ili80ULJAehvgUVBzetTrReA910DcQpSn
         vZ0q/EfbrwcG+qUFrcxqCG+aNY+rUVfmTrkcIfS6limM/QA3rjy/hE4JdEmnI6O/SCB4
         1R9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743148929; x=1743753729;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aSnI14BbYG44AW/1FazNe/GgOwu32Ov8br248K1Kr2c=;
        b=lgx0FZuZF/S/D7t8jLZbdLXCkP/FniCe5mHRK1gm7RDbZHQCT3chJ6DcpmkmZzCw1X
         olzldjWJTcJIvSZR/Y3EPMFi/eD4z2xbnUkrfdL6nYRyxCybOGPSdsDkgqkEECjGRzr+
         +LC04gWnlB2mrUV8IUl+S/dJaInCdul8EdRADnP3JtgJOMLEDD+Oc1SyYKnMd0oIkKuf
         OSjdSfhc+3jADlG+GL5xPOMFlHebbrjbrzF5V/exTmbFUzXAXqhFOqEZE0lCJuO/Y78P
         LGgVbPrGhvWNj+dEhCmr9wLf4Q545edOaz8PvbnR+G6kzlEiavy5eUmUHh54i+LI8n3p
         JhoA==
X-Forwarded-Encrypted: i=1; AJvYcCXqBYKwblPTdy8VIvumdGMEJYkD3Bd8qbQMd2wje6ZETxFTxxy1FLGJUfjO0PMZ0KOaX3s=@vger.kernel.org
X-Gm-Message-State: AOJu0YycWDloSUeDG680I+kQxkYa2SOY0n0klZWm9zt1VYXXOFWT+tMv
	G8CJ3m7o9xSqy4AxpGFLrRt+i12/bhrYd1YG0r6BleoFKpnjl4EdSznfwmpMVms=
X-Gm-Gg: ASbGnctJ9SSBeybYMU/zkhKsbmv2QqZ4jc4BNf54z2MX31QD4eJSa3CazE8aJgtLUhh
	EKVI9SYctZHogt0wo74VOjeMVzGnXSCPhBYlUngznylbL8fzJWyh/vW10P0HbyCC/4nV0FIQ4WO
	SbASMwF/uE6G7CSXoau5F4/pBtw59ixTgJCfd4mpIjQGB4PD3Jf/LwtZkOe2z3OuQakuavSe9zr
	M3XOAR37NjfltE08M3x9HNvNC3uk0d4NbTKVG11eK5+RXXl3LvSb7xpE3z6vrtUhI6eCCfV/kOU
	wPryG09Z1HCDWiuXf9QjfasEL5XxWGzsL+L+LWcjGrn6fI0MBg==
X-Google-Smtp-Source: AGHT+IFJDzuS2myCBT8Z8eorHzwkBKAKIK4T2dNn586UW/tt61K1e2XI3JFfo+oVpAzMnbvgnYtY2g==
X-Received: by 2002:a5d:5885:0:b0:391:4999:778b with SMTP id ffacd0b85a97d-39ad17505d5mr5896059f8f.28.1743148928856;
        Fri, 28 Mar 2025 01:02:08 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-39c0b7a4482sm1795937f8f.86.2025.03.28.01.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 01:02:08 -0700 (PDT)
Date: Fri, 28 Mar 2025 11:02:05 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: "Malladi, Meghana" <m-malladi@ti.com>
Cc: Jakub Kicinski <kuba@kernel.org>, pabeni@redhat.com,
	edumazet@google.com, davem@davemloft.net, andrew+netdev@lunn.ch,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	kory.maincent@bootlin.com, javier.carrasco.cruz@gmail.com,
	diogo.ivo@siemens.com, jacob.e.keller@intel.com, horms@kernel.org,
	john.fastabend@gmail.com, hawk@kernel.org, daniel@iogearbox.net,
	ast@kernel.org, srk@ti.com, Vignesh Raghavendra <vigneshr@ti.com>,
	Roger Quadros <rogerq@kernel.org>, danishanwar@ti.com
Subject: Re: [PATCH net-next v2 3/3] net: ti: icss-iep: Fix possible NULL
 pointer dereference for perout request
Message-ID: <326ebaa2-7b8f-455c-bf22-12e95f32b71a@stanley.mountain>
References: <20250321081313.37112-1-m-malladi@ti.com>
 <20250321081313.37112-4-m-malladi@ti.com>
 <20250325104801.632ff98d@kernel.org>
 <0799d2f6-3777-45f6-a6b6-9ca3f145d611@ti.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0799d2f6-3777-45f6-a6b6-9ca3f145d611@ti.com>

On Fri, Mar 28, 2025 at 11:46:49AM +0530, Malladi, Meghana wrote:
> 
> 
> On 3/25/2025 11:18 PM, Jakub Kicinski wrote:
> > On Fri, 21 Mar 2025 13:43:13 +0530 Meghana Malladi wrote:
> > > Whenever there is a perout request from the user application,
> > > kernel receives req structure containing the configuration info
> > > for that req.
> > 
> > This doesn't really explain the condition under which the bug triggers.
> > Presumably when user request comes in req is never NULL?
> > 
> 
> You are right, I have looked into what would trigger this bug but seems like
> user request can never be NULL, but the contents inside the req can be
> invalid, but that is already being handled by the kernel. So this bug fix
> makes no sense and I will be dropping this patch for v3. Thanks.
> 

I don't remember bug reports for more than a few hours so I had to dig
this up on lore:

https://lore.kernel.org/all/7b1c7c36-363a-4085-b26c-4f210bee1df6@stanley.mountain/

This is definitely still a real bug on today's linux-next but yes, the
fix is bad.

drivers/net/ethernet/ti/icssg/icss_iep.c
   814  int icss_iep_exit(struct icss_iep *iep)
   815  {
   816          if (iep->ptp_clock) {
   817                  ptp_clock_unregister(iep->ptp_clock);
   818                  iep->ptp_clock = NULL;
   819          }
   820          icss_iep_disable(iep);
   821  
   822          if (iep->pps_enabled)
   823                  icss_iep_pps_enable(iep, false);
   824          else if (iep->perout_enabled)
   825                  icss_iep_perout_enable(iep, NULL, false);
                                                    ^^^^
A better fix probably to delete this function call instead of
turning it into a no-op.

   826  
   827          return 0;
   828  }

regards,
dan carpenter


