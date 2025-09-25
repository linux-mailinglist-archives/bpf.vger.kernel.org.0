Return-Path: <bpf+bounces-69684-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F4EB9E80F
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 11:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1857425B5B
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 09:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66888279DC9;
	Thu, 25 Sep 2025 09:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="LU6oAXxM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D1827979A
	for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 09:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758793869; cv=none; b=B+jI8DZo1S7iJoQimmNdkX1MHxW3RTFAcWonpErk0Gj7Z71u8FbEL6oKbapf/TXXk4EyACrl7QcpMIWle8rBcElM6uem7HYQu+E3Qk9v5df7LMmEQgUk2ZMPfDO3cKjwixlXuTNXXioUDHIQXd9/7lrKEZX12IVa3kIQ4WerU0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758793869; c=relaxed/simple;
	bh=ZmkFbEfQivCqBMVs45gL6yXtOiKwXDMn9AvVAlKM2NA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YGxVZ4Z7O7qGdtEtt2Wo0TBYjbSCJQCdYdhQfyyme9fPUXWxLXQVVHISpIOJj/eFJIZI0MoRn089Wa7rjiQJfxDJRXjQi8axLkO5Vqb/qMLnFyzsgDzih4ItPXIN4XO5fUyygw7SAVm4gXum21BLVRDgLBJqF1vauIZnnRqK/xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=LU6oAXxM; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b2e66a300cbso146276366b.3
        for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 02:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1758793867; x=1759398667; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZmkFbEfQivCqBMVs45gL6yXtOiKwXDMn9AvVAlKM2NA=;
        b=LU6oAXxM646knKdDRetHDdvY5uXOb4M4EZgpP8OGwWE5C5MTxEB/SMWkDEpO1K4WXU
         peE6mvythlUU1n6naOwG9r0orSbpuEn5pM7wOOIdJYTM9IxUNWeS+E7Bx2LVA6CwQ+Uv
         ZC00HEdLuz90PmjEf0YdItWdhcNXN6xpANEXnChhMndyO1JJiAZEfPUymK/GBIiPvObO
         7YaYlZFrC4zBQTEfcv2fuNk1UcsyE3+9GQApNA+/ual1fCWG8fsGOHMNbvGLjVFhY5F+
         5Fg5ToleSGmSB6IyYPql3RFwYnondio1r6BuuHmuPVoTPZJ6P/TX/a8MkD9wRz+KFCZo
         agaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758793867; x=1759398667;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZmkFbEfQivCqBMVs45gL6yXtOiKwXDMn9AvVAlKM2NA=;
        b=SYdIWWG5s+SaaDlSb1X9HwWP/2uY+3xGiRiIw2ik0vB9aCuWIZ0OBlvyC0BfXxfsJ9
         3db0/VX1LBU2QM5x5djpeXqNYA/o/vEG08t0UfMa+KQg/a8CQaSPa9jD2WrFoJRmRje3
         GT/5ymbkhwHG+klgs0Rmiysihsan1lY48hM0NXqRh+EmDO7U87nQr/vqvD8wNk+5jwF/
         u2l0QvuNImatzVicNprk/iDANOWsmixK0FhNJOMPaFBLkx6n6B/JeXdtIF4WDUfwKefj
         IKL52qgg2Haq1cilaJt90zSdvyO+AToPMBGVcSYJEci9iROZTUO1xyNc+u5otiKfHXqC
         5CGQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2UhYRHqjpwJel8jtTBrw6WuMjWqEb0VQ41U6OXcLMIeiSeEs4roMNCGTBigNimINKFpE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYQPhp6WmsWZDduqSENfldrsnYRb88KTz6J5dnff65hD6sjc4D
	MTzZcFNxcfNPxMH9sXZddC6qq5kaxGxMYNATiiBwlbHHL4qdiYs1lCCW66gBfdgauPo=
X-Gm-Gg: ASbGncvsjyG6DIzoV9IFQ/4ebLAFja3+fDJVYmvlqHZiug2LMaPJDtKCRF7e3eCvll7
	LhqcgrLoF32NvRaqoTCsiDJ7uLaNasGNJgTferpdIzB3jLc8Omr9ElUWlCYtyWONo/RAr7dCMUF
	JS2kC/7woTRnOn9zb1i0YFLJD269SqZWGGXM+hRQPisxZFEM9HpAzb48juB2YclO1l+TE5LVzaU
	3WI/FpONGLSXNZTT+SQXV6d+ONBja95VFrA7yeBg2lEu4ihdlqSi2Lo8tt+7y3vdn9aKc+2aL0D
	O6HTRIN60YKK993upUp8PEh9XFxhzgZHRvEfZGsvEAilragciosmaeZh9Qq4y3be6s1EUI3UTQv
	Tf+012IgO3ca65oo=
X-Google-Smtp-Source: AGHT+IGEVGUv7B9GwkQ2/AJ6K1sBRZgNTUuhBCswgHVtL42XXaKHIxqK5bg7kju7asdvwIL8eCRs8w==
X-Received: by 2002:a17:907:1c8d:b0:b33:671:8a58 with SMTP id a640c23a62f3a-b34bd440633mr294373466b.37.1758793866605;
        Thu, 25 Sep 2025 02:51:06 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac6:d677:295f::41f:5e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b353f8686e6sm131994066b.38.2025.09.25.02.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 02:51:05 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Donald Hunter <donald.hunter@gmail.com>,  Jakub Kicinski
 <kuba@kernel.org>,  "David S. Miller" <davem@davemloft.net>,  Eric Dumazet
 <edumazet@google.com>,  Paolo Abeni <pabeni@redhat.com>,  Simon Horman
 <horms@kernel.org>,  Alexei Starovoitov <ast@kernel.org>,  Daniel Borkmann
 <daniel@iogearbox.net>,  Jesper Dangaard Brouer <hawk@kernel.org>,  John
 Fastabend <john.fastabend@gmail.com>,  Stanislav Fomichev
 <sdf@fomichev.me>,  Andrew Lunn <andrew+netdev@lunn.ch>,  Tony Nguyen
 <anthony.l.nguyen@intel.com>,  Przemek Kitszel
 <przemyslaw.kitszel@intel.com>,  Alexander Lobakin
 <aleksander.lobakin@intel.com>,  Andrii Nakryiko <andrii@kernel.org>,
  Martin KaFai Lau <martin.lau@linux.dev>,  Eduard Zingerman
 <eddyz87@gmail.com>,  Song Liu <song@kernel.org>,  Yonghong Song
 <yonghong.song@linux.dev>,  KP Singh <kpsingh@kernel.org>,  Hao Luo
 <haoluo@google.com>,  Jiri Olsa <jolsa@kernel.org>,  Shuah Khan
 <shuah@kernel.org>,  Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
  netdev@vger.kernel.org,  bpf@vger.kernel.org,
  intel-wired-lan@lists.osuosl.org,  linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC bpf-next v2 0/5] Add the the capability to load HW
 RX checsum in eBPF programs
In-Reply-To: <20250925-bpf-xdp-meta-rxcksum-v2-0-6b3fe987ce91@kernel.org>
	(Lorenzo Bianconi's message of "Thu, 25 Sep 2025 11:30:32 +0200")
References: <20250925-bpf-xdp-meta-rxcksum-v2-0-6b3fe987ce91@kernel.org>
Date: Thu, 25 Sep 2025 11:51:04 +0200
Message-ID: <87bjmy508n.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Sep 25, 2025 at 11:30 AM +02, Lorenzo Bianconi wrote:
> Introduce bpf_xdp_metadata_rx_checksum() kfunc in order to load the HW
> RX cheksum results in the eBPF program binded to the NIC.
> Implement xmo_rx_checksum callback for veth and ice drivers.

What are going to do with HW RX checksum once XDP prog can access it?

