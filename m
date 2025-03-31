Return-Path: <bpf+bounces-54977-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE27A76AA3
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 17:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94C567A13D7
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 15:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4BB722173C;
	Mon, 31 Mar 2025 15:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TBLExL2i"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8AB213E6A;
	Mon, 31 Mar 2025 15:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743434547; cv=none; b=sAJ/ae8Vb2yrBvbEW1FIow/uaSYx4Tu2VURo/OP1nlByR/xGSTfQRYHUoCwSgYis77elVnUuYbQUnlYj6Ompsc4Wg9ha7KizuSrz2Trob9O9aozX0M3mhR9VMlEtsj22HVi0sBbkAnMzmmE0Ad0AlEyR28jmwaV8YMpIIrVinmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743434547; c=relaxed/simple;
	bh=w4FKHA0anMKrh0e3i1HLRk37hU4Z/VK/ffHTy5oGwnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KUQEW19f53718QB+lybuy/g/rk/ouylbBWt6oyHkIBpWprqMtHi1TDQMbHMdD2oocZrs0raNjiyE6NuaJW7uTYy9h0Nl2+AYT4Cpd/2e1zfVsNOlqECWcrpqNEt73Zp6COm91xJ+JuRL5q+fLYP617DBnUazX5So9haP6b50vJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TBLExL2i; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2ff69365e1dso6002388a91.3;
        Mon, 31 Mar 2025 08:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743434545; x=1744039345; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z8kHRV4D1blEw8Z5EgHS57iPCad16rDsewn8MF9vi3Q=;
        b=TBLExL2iXAbEGJambbdJhcM4M53gGJhFf7IAWt8AhEpSzecm9oecX6X+9b1KDfYmCA
         4yYGg36SjeP0ONeye+tjpW1Otpup7swOtzVHhitS+CezHiWJxyyUlNm0RGsptLvCmsTn
         ZQORkoAHSMe1JlAk+i5VEBHboVzf7i0ZN8KptNasvWD1udCoSQrrmRypwNpMv0N0Lo3g
         Br7ch2xxXDehFQkuVn5hC0z5nms1ZuPiHVDtqD/HYm5Xu6umHuBHF2aqbLZy3dMqcPjX
         rQq5yHoyI6gvlKt+zNhzCM0atMKRFTgdZBS24QA5spECq4MCUrgXlDfKHcRkhmzh1PDg
         hQ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743434545; x=1744039345;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z8kHRV4D1blEw8Z5EgHS57iPCad16rDsewn8MF9vi3Q=;
        b=q9KVkeyL9pLhpG1reG7TuYjtanmnyoz6frhGg71fvPOIKToWbXQB0g5OlrD2xckvLv
         P/0picU+tTHQpuDzZjePGOoR4iKCCwYFmiox+LmcEr3yLi5COKm7WRnmEsGToWrvJriI
         D54zy3XGVZhmPyP2PWas7a6+LJess7HA254AD2zkSKJnlzyImQ0UkokQFiUlNQVx6pc7
         mqKJ0/8/wGz6d8WDtwIQ6f26jzffVd1/2nA23Avq7dRCHLFNaFFuoUv8TgsObEnfaiNS
         42eK0X66hnZQxxgU3g/rNlZzmL8oRuxLrRZudwuQnEHvq6wX+Bn0ctVb4xf0Y6pqSQIl
         CVDA==
X-Forwarded-Encrypted: i=1; AJvYcCUJgfHgoZd0wnYwVR9927mWf2p1cAcqmg80q6PakyneCNZ0GjMyO6Y96o+E2A7trGzcMcHOCBamJmUlrnAB@vger.kernel.org, AJvYcCUM/69x/JgbHyqxGcvBpY+F1PLXgrO0DDVFYK6f5vBLMRlQ3JRBr3ZhhO1nphU41vUTOeE=@vger.kernel.org, AJvYcCWPCVcLWTlV1ZC5AH5REd4dxBHBkAT+zgq7d91pRbduyyoSE45TmQbObegm8X+yNcCPhTIWeqPN@vger.kernel.org
X-Gm-Message-State: AOJu0Yz499E8YPB67Oi/CeK6p0hASrRUoVtb2oqD01MZ6WggfnTcbr1Q
	SInAvBt1PLo6ORhsEknmJnI7XMG/JD4LocYLoYradaWQWIsTsPw6zuyk
X-Gm-Gg: ASbGncvKskPbjfcw19wlCadhKIb/YzzCxC7HrOI43aHSWH50RvvMYHkP/0kXC2dh3B0
	PzTNMrcJkOAE+jEVYoITY+mMV+W9FhAveQikRiuZTr5p5CMFxXkmF6F9fpv2cbK/JNEKkcaKdDw
	GccsrTnN6IWaqFl8CKqRS4bkv0vPUzHQulJABu9bEFAKffIVshoVGHlEYcy6SuQBj8j0VWU5N1H
	mBznUTyCJZ5UfNfuBBw82HrmJyhiuPQOaSB10k9mO8iX1U4V84899ELrQdVr589Ry8fcrR++JBJ
	cPKIke91KZiMrHs0Di+uNG1KhJ4x2Gd26Yh7Lc+fBNSi
X-Google-Smtp-Source: AGHT+IE8+4eupeE2NGK/U3jWJ3Gg10N3UWQlFKfezMmp/E0AIxLwJgjIRW/MrxT/PjXZK1WP5aSKgQ==
X-Received: by 2002:a17:90b:1648:b0:301:1d03:93cd with SMTP id 98e67ed59e1d1-3053214bfcamr14758556a91.24.1743434545096;
        Mon, 31 Mar 2025 08:22:25 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-30516d62c57sm7348400a91.28.2025.03.31.08.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 08:22:24 -0700 (PDT)
Date: Mon, 31 Mar 2025 08:22:23 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Wang Liang <wangliang74@huawei.com>
Cc: bjorn@kernel.org, magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, ast@kernel.org,
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
	yuehaibing@huawei.com, zhangchangzhong@huawei.com,
	netdev@vger.kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] xsk: correct tx_ring_empty_descs count statistics
Message-ID: <Z-qzLyGKskaqgFh5@mini-arch>
References: <20250329061548.1357925-1-wangliang74@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250329061548.1357925-1-wangliang74@huawei.com>

On 03/29, Wang Liang wrote:
> The tx_ring_empty_descs count may be incorrect, when set the XDP_TX_RING
> option but do not reserve tx ring. Because xsk_poll() try to wakeup the
> driver by calling xsk_generic_xmit() for non-zero-copy mode. So the
> tx_ring_empty_descs count increases once the xsk_poll()is called:
> 
>   xsk_poll
>     xsk_generic_xmit
>       __xsk_generic_xmit
>         xskq_cons_peek_desc
>           xskq_cons_read_desc
>             q->queue_empty_descs++;
> 
> To avoid this count error, add check for tx descs before send msg in poll.
> 
> Fixes: df551058f7a3 ("xsk: Fix crash in poll when device does not support ndo_xsk_wakeup")
> Signed-off-by: Wang Liang <wangliang74@huawei.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

