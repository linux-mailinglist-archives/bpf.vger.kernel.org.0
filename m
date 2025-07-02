Return-Path: <bpf+bounces-62089-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F21AF0FE0
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 11:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD7DF4A04DC
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 09:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866BF246767;
	Wed,  2 Jul 2025 09:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Vlccg2bY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5F02459F6
	for <bpf@vger.kernel.org>; Wed,  2 Jul 2025 09:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751448275; cv=none; b=j8/xwkWcXJ4+bKXmRpI3KbIjZkqOCeNMgh9uazC0nL9Oxz2hLlQK5nFpdRsFGxHky2Xv23vAQg6buGWB6JMv/PjHJVW5Itdt4Q0gNyNg4LBwL8EKfidyBXk0B2i/X0DhWTPDTSXArkROT1uHL8fHUcy/5nDeiGAFsACgf7r4UIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751448275; c=relaxed/simple;
	bh=s2/pkGo1KgPXhul1pIkhh9thlM4yY0+G3/Erua3W2FY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kESpJwX7lPGfKRG4RL8pSrAL2R6O95RnFYtfkLRqlTInI+caF7EI7EL/XqL4W5CQ/I0y0ePfFparRllEZUViYJfIh5eDOwwskNjjifJPQ+pep9YqMMnwSwcBk1w9bUN97/v+D/3kcJyN3SaKY+usuWnxk+ep5a9WAVRf4/ctauw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Vlccg2bY; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6077dea37easo7452563a12.3
        for <bpf@vger.kernel.org>; Wed, 02 Jul 2025 02:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1751448271; x=1752053071; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=s2/pkGo1KgPXhul1pIkhh9thlM4yY0+G3/Erua3W2FY=;
        b=Vlccg2bYdFI2kVVc+2n6hm8m3ajYSFHVr0TMaERxDcYaO3JLeOpS0Dm1EEpcpdAj6b
         Fznoh68S8rTyCzaZOB94DmzLLNsSOnP9Y2zK8GUM/7nUucSt2qcIsnXQKIV+rLBGHQNN
         d4TwuQqzc0NfUJ57s0jUHIUiwtMqE35U91xIjR8ds5I3bQSqFXCSbUhp+ZYBH6Er2DWq
         vxH8e+2w/dN8PvQQ1E18phwUVll/DPdRRQ7NY67Ik4wgLnSyr2SYebXtSHgaLUmyem1O
         iTo9Z7ZumJrvSozw+mDFULc2LBZAgPffS5jVphnr9WAoNVSS0/kacHw/KsYcrzStgIEU
         4kHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751448271; x=1752053071;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s2/pkGo1KgPXhul1pIkhh9thlM4yY0+G3/Erua3W2FY=;
        b=nv1VSxCrvWWH7Qj93RkDPK20kmpb5TOxibNy1SkNWg9YaFbRPEUmd9oFzfnevzwjQF
         GgFc2xrr3R7P+qISTp5HisWwEbLhHQQPhHTjMsbYeUdYee1UHr6X7ieLNx14iAinpgqN
         e6kwV0dgqCOOz9GwXawZG6/19TIs/DiXtH36C4Uwv6DCXGGsca/Q+GX7hl5oEAvx8OVr
         5/GBiHQY+j0JMhtARtZvrivYlkbg6UyJxJX+1Yg63u2aDcPov8E+OQh9bOPQZO/xJbEC
         e0rrNQRgRi86m+AjVr1Hqn+KSDR0ezdkJSlxR73urc8oJPGvVrVy7fDkBSXsUr3QbPE+
         Dc8w==
X-Forwarded-Encrypted: i=1; AJvYcCWF5eMMU2IdiAgEGFV4E3rChcx0wAFRFQyDh0czd+A3AHtIXdgt06mRpEz6gNdqR1k2RZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpBYHqnZWdSCUXacRX+EwfOk71E5e1Pof+G86psYMnRA+VWjo2
	pCUlyVczMQjHzQjWnyr1/pwtpUAP7TvZKlHJMr8J6jR5ASNMLpJad2P+qbw3+z3hkfk=
X-Gm-Gg: ASbGncujsKzlxFS08kBLcg0VFbwAFh0zY5/OiOWtx+uerRLtJ7lCD8c2WJZMqbw8ooH
	S4KoDU5c1DS6r3rXl7hHntwz4YGpYLbWlu91iE4hf4o/C/6FkNrgGiesuCoy2mlntPLHdytEMLl
	5lfgLwnkh7OIcGsjWzYrn6NhfhZMXAlmfBXMDbv83u7Hqeq7cEF8Sm1ghAUEj6OgA7HltUKFKUe
	9Xig5zNALCoyxVZMDxjgTwrT3bHgqeZJaawnJaXWqht+9EmioMpfGmfguPNrQjsM0JGmUmGTIPz
	j3zREgbFqzVuPKGR8gMend+aJwXI5QE0F6ZYrDGFYfLugdVoYObuVsYqiPw7EdLvQQ==
X-Google-Smtp-Source: AGHT+IFV41hFF3U+zliks32cLXq2NSxbarTe0yBpA+bLAmYsFPnGmaGaHYM3ptii1H62tsI00pRSBQ==
X-Received: by 2002:a50:fe87:0:b0:606:d25c:c779 with SMTP id 4fb4d7f45d1cf-60e52e3c340mr1632001a12.34.1751448271494;
        Wed, 02 Jul 2025 02:24:31 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:e7])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60c8319fd60sm8692843a12.38.2025.07.02.02.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 02:24:30 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org,  bpf@vger.kernel.org,  john.fastabend@gmail.com,
  zijianzhang@bytedance.com,  zhoufeng.zf@bytedance.com,  Cong Wang
 <cong.wang@bytedance.com>
Subject: Re: [Patch bpf-next v4 1/4] skmsg: rename sk_msg_alloc() to
 sk_msg_expand()
In-Reply-To: <20250701011201.235392-2-xiyou.wangcong@gmail.com> (Cong Wang's
	message of "Mon, 30 Jun 2025 18:11:58 -0700")
References: <20250701011201.235392-1-xiyou.wangcong@gmail.com>
	<20250701011201.235392-2-xiyou.wangcong@gmail.com>
Date: Wed, 02 Jul 2025 11:24:29 +0200
Message-ID: <8734bfndwy.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Jun 30, 2025 at 06:11 PM -07, Cong Wang wrote:
> From: Cong Wang <cong.wang@bytedance.com>
>
> The name sk_msg_alloc is misleading, that function does not allocate
> sk_msg at all, it simply refills sock page frags. Rename it to
> sk_msg_expand() to better reflect what it actually does.
>
> Reviewed-by: John Fastabend <john.fastabend@gmail.com>
> Signed-off-by: Cong Wang <cong.wang@bytedance.com>
> ---

Nit: If there happens to be another iteration, might as well add a doc
comment while at it.

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

