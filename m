Return-Path: <bpf+bounces-57547-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9B0AACC6C
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 19:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75F873B2416
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 17:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8DD285407;
	Tue,  6 May 2025 17:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fHFFmOnB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72638284B48;
	Tue,  6 May 2025 17:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746553391; cv=none; b=HAA3sM4STY9qsTr1NhMyK5/nWbkZ+Xs3pDRI7t9mgtPSadT2EQlBFhZz6UjZrKVPGQeH6zcFJdJMMSLnCcVQeWH0+3ww+s+exO7FlG2wUnE4Y9hYbn5wonfvyVS+KPER3e8ZVgu7D5ApDsW2iaohNsCHiDA4iJ5O4e52RgQaknY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746553391; c=relaxed/simple;
	bh=Hg3i1/Dgpmc7f7I9xyrZ9JyjrIP1ElLmSV14h12iBzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dy7l5rej2txwkfCnQsCWVXHJ5zlzbJlYSeY7yP+R9KzplwayPyU4CjlKAlX+Jef0YUTve/mhkGLqO6N/ZuSRJrWH/1JwZRL7+l0pFaa9kp21eUzGyosieyrW2X3qbmU5xIR120ygAsneYW+PYE2KgnuYmnVFrSdRH2VP+/9k0zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fHFFmOnB; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7fd581c2bf4so5060851a12.3;
        Tue, 06 May 2025 10:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746553390; x=1747158190; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BfaHHa4q4FToctVtAIBViuQx63lc1BUk3cDHNQGXtnU=;
        b=fHFFmOnBipb63Rl2SYRcNshPYexm0Nun765ul5KD3uUhKJxFZEojvhar2J+PYZhH8c
         KGhOICWHpJ1/lo/snxoQwn75RBKyhWdWkWreyuq6hda523gXWf8RLgehQA3fmWSV90jL
         SFXuhQktQZkL6DLsWOckD675oz/zxSkr+qobHukQpkTpIb7KmCXRBUXMItmOjPJ/JTGZ
         sJOdVMCUGt7iggzMuCs870lB7r/nq/D3+poZwGR7jcowzkjk5p7wwnMPxEc0HPIH0RpD
         86nVuXLQuHsgrhdMaBxpgY8JQpFxc1fdqD/B+7h9d+2vaN3Z0IfH6z1aftQM5UH090Fo
         Prlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746553390; x=1747158190;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BfaHHa4q4FToctVtAIBViuQx63lc1BUk3cDHNQGXtnU=;
        b=JPIBslRzjVFPCbCP3QKjkZOJtY39oAraMjhCNQC12K0QVmkDpFkyzSSaE5Y2z2hS2t
         fUBieoPn/gLhzRfPBOOqMOTk94GDIprWfh58mnI5iFGPM9PasoSz/xmIKsNSDQMTlIcT
         mmENUbKBHgeul8TC1nN9YbNJXir9J1zN1W1ZrepHbyM/VzuPhbbsGhurUS1sk0mCEI9G
         FmVoCtSJd6be5vN7bzLaLFHSz4OL86PRG+XLbdo3Dv0CVYGWo0L1Uewa6c50syXunegM
         5lKV1o5TwTLNNrJ73rQ2ntdP2027ftFumphiM+ldEwC0APgVUadbpB2r2PUxg3PGZ7qz
         XfYw==
X-Forwarded-Encrypted: i=1; AJvYcCVAQJTwK5HhJKE91KhDbH305KYgvlG3Q1oPEfWCzOQ7/GUXJD51myfE3gH2uDOX2DRfRnxPnvEh@vger.kernel.org, AJvYcCVOtQiemyo0uPNXJcoVRH3PhPq8+JwAbMATaY9n6jprv3eZYTGBultfijffUDCNcYphfCg=@vger.kernel.org, AJvYcCXuIz6oAnnafhxpTsVCZBBcP2V66Yelj88+LfIPVeraWsN1DEss3C8+O0WRx0RI7qg5ucoQBeBPxljcMAHR@vger.kernel.org
X-Gm-Message-State: AOJu0YypUpmNy+Jyv4UQBAzcHHChss/RcolfESNCJJFc4hFrw4nX80O3
	7VHE52D0gZ20NL2XgcIAYD4PGu66u5HJE5eyKQvbp8zG2WjvfAo=
X-Gm-Gg: ASbGncufkqWMJHK5gQ6W+ZXM+f5MKqLDC3Tl7mL1nOwt0hNeULPyqbbOkoYH1tDlmRm
	7T+fKtC3ep20KAl/Befi1FZq8eEBg9b9Vh6v5NZgno0c/Jpn6aVMmuALOdcrou1kW5TEOUd9rd1
	wHH7w2oaXqlWZS3JZW936tKtiNSRlo6Rvd0PNcVv/7CJAM2SL94uqZ3y+MHUztdAnEimoM12Fjt
	FiWT/jo4JwrVzrASl3bR7ywAT4upW6IaPX3sEVitpUR3qmmxp/WWqQFuTr1aknOeLyiR+wK9hYe
	jacuMfoZsMJFSCwmygMgB2hOii+JbXth/zo4uL+0vPbDWokol13308hLHObezRN4npHBK/yRHEg
	=
X-Google-Smtp-Source: AGHT+IGpFEDMzKGYQpT3fzc2VEPq2xStuHYj9Yb2b5U3WbgJTKjjMDEC5WcxnZx9AFDlutE8YxoLZw==
X-Received: by 2002:a05:6a20:e68f:b0:1f3:33c2:29c5 with SMTP id adf61e73a8af0-2148b316c04mr167061637.7.1746553389612;
        Tue, 06 May 2025 10:43:09 -0700 (PDT)
Received: from localhost (c-73-170-40-124.hsd1.ca.comcast.net. [73.170.40.124])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-740650a6081sm7938333b3a.139.2025.05.06.10.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 10:43:09 -0700 (PDT)
Date: Tue, 6 May 2025 10:43:08 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jon Kohler <jon@nutanix.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH net-next v3] xdp: Add helpers for head length, headroom,
 and metadata length
Message-ID: <aBpKLNPct95KdADM@mini-arch>
References: <20250506125242.2685182-1-jon@nutanix.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250506125242.2685182-1-jon@nutanix.com>

On 05/06, Jon Kohler wrote:
> Introduce new XDP helpers:
> - xdp_headlen: Similar to skb_headlen
> - xdp_headroom: Similar to skb_headroom
> - xdp_metadata_len: Similar to skb_metadata_len
> 
> Integrate these helpers into tap, tun, and XDP implementation to start.
> 
> No functional changes introduced.
> 
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Jon Kohler <jon@nutanix.com>
> ---
> v2->v3: Integrate feedback from Stanislav
> https://patchwork.kernel.org/project/netdevbpf/patch/20250430201120.1794658-1-jon@nutanix.com/

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

Thanks!

