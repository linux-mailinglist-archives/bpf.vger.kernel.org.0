Return-Path: <bpf+bounces-71721-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 28EF3BFC14A
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 15:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6ACB556103B
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 13:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A988F347BC5;
	Wed, 22 Oct 2025 13:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="GolNBY6i"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD2F347BA6
	for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 13:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761138132; cv=none; b=eJubsFRm7MpOzi4nRvQzev0GzUJY83Br3H6nbk6eiBv1PgXiSAqJbtUu+iC4Wj5DE8GdJD3jcZ0aQtRwhsEgtv2tOTBuZh5Df066DGfuCYKz/pekwWvZu4ozFknFgdSPLCJdjuq4KeJX6pU1TO4dj0mw/4E9N0iN5VxJefAxK6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761138132; c=relaxed/simple;
	bh=J4bzJ23ONa1cJ6MhJY2CDuBayp00O+xQJEqCe6UxO9E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r8cAsx2D8LDAfYzJs/frMCCF2WOHAHeynA2CMIkW+Djf/McEYS1rWuSG5BYjMohRfYQRXnTnREce1+STJP0rol/VKh6VYIcbpNkNTLoieTt7sUTh5bReqLAURhAWHuha6NbTD2Vk/t8gihEZrAE5R/9/eaQfMuTYSWnITy8XcY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=GolNBY6i; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-63e11cfb4a9so2763228a12.2
        for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 06:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1761138129; x=1761742929; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sNgKKD/T+Yc6OYPm+3YKTinvWNdIUbP6kbhFhE9V8vs=;
        b=GolNBY6iigj9F0H/6ZiNxWrem547hs2RV++Ngqddy0UsKPYkN+DI1O/Yev7iC5BfEV
         kQG4tbUWVDH44eUIUu0+Jc8vUFkgzdRI03bpQEOE22wCqZuHbUg+GYhcN2oR9Uj2mdiM
         GW0kDy7uHQAVUSYMgEdftsEYQRNgR1izHXn08etgPxOP4BG6PJQso3QXRa6Jf0wc79R3
         tVkXZNW0SkpA9C56QSTIiiguvS5INUpTB7d6Tbz12YqipJtqyVng/kN5cMSxa2QfBYXA
         mCj++6DPkPu0+dOoU+G0FGzRwDlVkGP13U6gOob4nK8cnqtPzEZsy7mhygVRsREjs3B9
         vvPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761138129; x=1761742929;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sNgKKD/T+Yc6OYPm+3YKTinvWNdIUbP6kbhFhE9V8vs=;
        b=ZR7zJxh4dLe3eD/Qp9fJ1HDeEtbWgxFjl+Kh6vKF4q6+YsnsxobwAJaATWGDt2750K
         wQrBeZccpPgZ3IUxFbKwaJgiuxkw2QViEkdpR5spcqG73UGyIRqS0lSo6BXW74fYNiXo
         ZlyE9GzCvZBlmMRngi5WukASLfi/ZsmmIMtNxNB8Hp7026vCSYGVLFkPuqGkmW+N4m0V
         lIdXn1hyvgz61sh25h7916L8JAG4vsWsxPBBtnhXZtwEdsMo9z0BpamGRUSf2pnYSg4I
         8/n2OC4rtDGJZxvuf6X1Gq1U/TWbyKSrHE39Q46U9ZTI4lj5G4ts4rKga0tIbrccjBIb
         Kp2g==
X-Gm-Message-State: AOJu0YydaFwQKoShINlwgGQTb3FFoPwFtOpfsv/1hV4omi0PQPfsYoJm
	YotusOJY9Q+HBx8oYRWeTEilid+T9UO0Q+5OoQKy9fvR4bXNn7sVzz2FTYBwMmo7rxs=
X-Gm-Gg: ASbGncvA+XrSGngPcSO7kNRQrXZhAv49op+KxyQZh3dPzz1Ahxk7z66Baz+o1+5MPEc
	hNYtLM5RFWLcKus4ura6rTdnYMgziLmYJDoPbUaAq8Pwp2NXiWJyNLYPG2SBUJv9QIL1H1/Qrm7
	PzQfPhhn4PfyhTRHKlw+u+I0snFqmfqaX1VINL0z1deSHf+7CfU2QFPiG7BZbs6IS8Sz2ApPPs0
	SkpjtT16H5G1isHFePURu9e81t4MY8OjFOclXHfhtdEMvtOmR/PF84Iqefa8cqjAdYNurgJRLh4
	ffuRKXIr1n8WCQZaxaljVPyxNB5wE8AXQLZkKy80mH/0jaz0LGh6h0TyzHscB6h0BeFqel2O14V
	+oA9BdjSGl6m02P6Yvf01sZxpiJpuKFej/iTmJiNVKmHPdVzKo/0uZ6ABsfus5oU8D+lSIPsyr/
	YwRBT9JogYUAG03t/1dB4whjSz331wtQWG1WTd3DfLmt0=
X-Google-Smtp-Source: AGHT+IEmDf3z7baqtJNOanSoKJrBR4id4w5eO7NfPmBVAbnBWFCXxiHXsuxzHw5uOJtjJe4KS3Ch+g==
X-Received: by 2002:a05:6402:210d:b0:63e:1e6a:5a88 with SMTP id 4fb4d7f45d1cf-63e1e6a5f89mr2575448a12.24.1761138128754;
        Wed, 22 Oct 2025 06:02:08 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63c4949bfd3sm11854405a12.41.2025.10.22.06.02.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 06:02:08 -0700 (PDT)
Message-ID: <8371b864-33f3-418c-aa5a-d1c4cfaba78e@blackwall.org>
Date: Wed, 22 Oct 2025 16:02:07 +0300
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 12/15] netkit: Document fast vs slowpath
 members via macros
To: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, dw@davidwei.uk,
 toke@redhat.com, yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
References: <20251020162355.136118-1-daniel@iogearbox.net>
 <20251020162355.136118-13-daniel@iogearbox.net>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20251020162355.136118-13-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/20/25 19:23, Daniel Borkmann wrote:
> Instead of a comment, just use two cachline groups to document the intent
> for members often accessed in fast or slow path.
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Co-developed-by: David Wei <dw@davidwei.uk>
> Signed-off-by: David Wei <dw@davidwei.uk>
> ---
>  drivers/net/netkit.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
> index e3a2445d83fc..96734828bfb8 100644
> --- a/drivers/net/netkit.c
> +++ b/drivers/net/netkit.c
> @@ -16,18 +16,20 @@
>  #define DRV_NAME "netkit"
>  
>  struct netkit {
> -	/* Needed in fast-path */
> +	__cacheline_group_begin(netkit_fastpath);
>  	struct net_device __rcu *peer;
>  	struct bpf_mprog_entry __rcu *active;
>  	enum netkit_action policy;
>  	enum netkit_scrub scrub;
>  	struct bpf_mprog_bundle	bundle;
> +	__cacheline_group_end(netkit_fastpath);
>  
> -	/* Needed in slow-path */
> +	__cacheline_group_begin(netkit_slowpath);
>  	enum netkit_mode mode;
>  	enum netkit_pairing pair;
>  	bool primary;
>  	u32 headroom;
> +	__cacheline_group_end(netkit_slowpath);
>  };
>  
>  struct netkit_link {

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


