Return-Path: <bpf+bounces-62302-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E72E0AF7CD9
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 17:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAAB6189F8F1
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 15:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2859A223DDA;
	Thu,  3 Jul 2025 15:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DXRhIsGl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5205015442C;
	Thu,  3 Jul 2025 15:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751557544; cv=none; b=IPEEwtmSZdz574W5He1VcXWfgKuQymLgu3OsP1E0pJX6Oxkbjc3ji3HcLO5W701z2gplvAqSxHI+ZOK805N/xwVt6B6FfN+syhabwb7iBiZCJSvTPnNeKtV4mt9zy69q7PXPouP/qZ/42z+boh8HZL6FaJX/4L9Yg4TxJ6SSbEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751557544; c=relaxed/simple;
	bh=B4b0kUuEjon5XOa23JF9K1NBKswSf8lTWDTqSa7MjrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CXw1Om9TGR9atzz/Pqrs643vTABiiF1+7Ee0lT3oUtvjtnut9oks1O6GCXEzLbiU0GVp5EHu0ekdtr/BzP0tLmsD4PUnOGbgZmGBjf3fYqwC9gAVbcFhPXtVOhx98asqk+jXCffy7naZ9haENdO1ouN6jEyNtjnVoiP2Wrr5J5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DXRhIsGl; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-234fcadde3eso1444255ad.0;
        Thu, 03 Jul 2025 08:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751557542; x=1752162342; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=apvgKhqbhIeQSWj/GeqqU7jgRMkREW+i0TOLDo5OJPc=;
        b=DXRhIsGl5zA8+nZ3tlUhPbuD1zbr62lWpswx5cpV8SzJmuVZNHbj7POJAwzqrpSeNl
         ck7OIyvhMWPKofiL62/ndLloQsdyhkZEoYKL7v8szObZmc1FmRqPU7h8EiPzYhIBO2qk
         D5jQUnZTnqKe2/TuLjcOaezWbyZc/q1NVqWFIa7hbEISN3C3iufPvVBZVs8Spt0HCwRq
         BoAzdR3Gak7XQDtBieRMMK0i0a9fvBPELjeztMZBsrbBl9Ftf3pd+7YRVIkkDY00sz7u
         RTyqBbjWYVrLseGCHlJLu4AcZWV1MG88cV1ycXDga2SIRxOTZfzr3RvPOj18hAY+rRJu
         oGVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751557542; x=1752162342;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=apvgKhqbhIeQSWj/GeqqU7jgRMkREW+i0TOLDo5OJPc=;
        b=rW27PWauQmttN+Oad+DyWpmpdjSKaF/C/1gUR1i9vXFIHROHC04r1gsRA3YAQj/0WL
         QJx7+wLr5BkszjLcfZQJCgixrcvRJMoqfVuI0wkvX4MtbWLAPMza6SiIH6X2oYg1+ebX
         oZqsUTUN90MfzcDptDWTDPvIpWs2IgamSvz36fVenSH+qXG87Wzn50MfHeOph9HNcCyP
         F3+p/qxJ7sQgkHeSvOnpFGCCGJQ/o5LD+jYmXEoODo2hQvTp7/F2E+48cTs+VxEHBUUY
         2J8Q//9xBif8w3tgj9yt3+hLUXK2MHCIprkZA/GXie6ov4jHaAOh2TX/W1NSQACw2Uj3
         N2zA==
X-Forwarded-Encrypted: i=1; AJvYcCUjrwStrNLzC5osDV1a2gp0raWs9109/QJ91AqtgIce5bMoxSjP6EiD8O9pow7tyJr7olrazvwo@vger.kernel.org, AJvYcCWyWxwXYhgnHdYZsaLeiMrHYtkTKejSRoeXvcRGEWL4/QyPN0fGaLf9jDizQTQZ8zN6v98=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo9tkQ+eXOhfshR0Dx5i7nNMYj5csbABSpz5b0s/1ucsdiyPny
	AuvnUBCVL3XE80dkBp0glaeLbxIMZB6NpzZG9kzrMOMegf76iQz5qZI=
X-Gm-Gg: ASbGncvOZoppiovd10TxIv3ha8mcHzOZ6086zu80JIxQMZyl+bMZTksJk1PeYTY2OCb
	Mzaey5DM3bDxS2IAC279M6xn//1BBkYojcTLe3Xd5rEHSfYiKcOyQyX1UJRvgN7dNSER6pQABYL
	lQIii8g8M8Pvj6tVcxu2tt+AjcLkH1ODljficnDqvDi156F2ebSnbOAcGCx0eNsjaNwXie4cHgu
	PsfbcyqDCXPlYWaWT+rpLhEMwlUwME2howNmXQLPvF4HWFBzerfhtVIa5MY9MfrDYcuqoHsYP39
	fW59Rr1NRDCawBnNsTVImCx2fMVPFNcIyFZgylwenp2Ci98PUMuiaari4RS3M/BT8BLebgZuiT1
	pazrE44uoFoRckR6RFsphMA4=
X-Google-Smtp-Source: AGHT+IHYWc3ZNs1U6ZB0yHLJhTKqj9MJo1gejhHOUamBkn5U1DG28u4VkMgLU8m4OSt8+ztasBLD7A==
X-Received: by 2002:a17:903:2445:b0:236:94ac:cc1a with SMTP id d9443c01a7336-23c6e58aafbmr84347045ad.27.1751557542624;
        Thu, 03 Jul 2025 08:45:42 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23acb3bbf9esm157644005ad.191.2025.07.03.08.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 08:45:42 -0700 (PDT)
Date: Thu, 3 Jul 2025 08:45:41 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com,
	sdf@fomichev.me, ast@kernel.org, daniel@iogearbox.net,
	hawk@kernel.org, john.fastabend@gmail.com, joe@dama.to,
	willemdebruijn.kernel@gmail.com, bpf@vger.kernel.org,
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next v6 2/2] selftests/bpf: add a new test to check
 the consumer update case
Message-ID: <aGalpZSYcTMov4X0@mini-arch>
References: <20250703141712.33190-1-kerneljasonxing@gmail.com>
 <20250703141712.33190-3-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250703141712.33190-3-kerneljasonxing@gmail.com>

On 07/03, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> The subtest sends 33 packets at one time on purpose to see if xsk
> exitting __xsk_generic_xmit() updates the global consumer of tx queue
> when reaching the max loop (max_tx_budget, 32 by default). The number 33
> can avoid xskq_cons_peek_desc() updates the consumer when it's about to
> quit sending, to accurately check if the issue that the first patch
> resolves remains. The new case will not check this issue in zero copy
> mode.
> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
> v6
> Link: https://lore.kernel.org/all/20250702112815.50746-1-kerneljasonxing@gmail.com/
> 1. filter out and skip TEST_MODE_ZC test.

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

