Return-Path: <bpf+bounces-73811-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFDDC3A798
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 12:11:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EB245500E2C
	for <lists+bpf@lfdr.de>; Thu,  6 Nov 2025 11:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D8C2F363B;
	Thu,  6 Nov 2025 11:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AqSJ4q3h";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="IJJseeHQ"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3952C08BC
	for <bpf@vger.kernel.org>; Thu,  6 Nov 2025 11:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762427176; cv=none; b=qfpsgI+MWl3OC5Eybvjl8y4/k9WM+onYm8mvXYpf7pKU6ZcIM+RosGEFH1bSoWppiAaTwH2sfbJ4XkuXKdvHRE6ol0h+QhUmuX3s2pQvSoJWyKGzUin5e2AeCSrp1eZuxvv7njQBGwpp0/JGbs42VFJuwyX5bIIVioAGkJRs1CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762427176; c=relaxed/simple;
	bh=j3hl+Kd7/n7v8BB6LvuqjtP+7XFRDVSiKP7+HyaKGvs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LvWG2g9LRv810jA2u16xMzsAmhZa1efzi2LH63Yvp0o0ff1ksiUPBtlCe5XX2gi2HLVuAv1dTa7iD089bcAI/YmKjE6CmPn5oEDQCDNnr0XeK4/atG3kn2RcKnU5a/uDismNT1MHwFqlort14Aeoyh80QQVubZMF2HsEXigjB4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AqSJ4q3h; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=IJJseeHQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762427172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uG06GFhvhg2/GhoIc3ckFZLsP4kGe20aTOFoVqJytmg=;
	b=AqSJ4q3hrAd2xAaBCH94e1IKUPE/heidf2ihw823qN16nvSWsa8bLotUsVkGXVc9Mc3kQP
	fGndKTxPNZUqne1XwvOg8U3zeBKx6zBPTjK2X5RMZfo5WzlFqrCv3xl1LxAMPQYShflXnC
	V18ljAx6nxeu9ceJVCGROIozBCpC6V4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-3-ZIRH_vPJOMKsln4gmML7XA-1; Thu, 06 Nov 2025 06:06:11 -0500
X-MC-Unique: ZIRH_vPJOMKsln4gmML7XA-1
X-Mimecast-MFC-AGG-ID: ZIRH_vPJOMKsln4gmML7XA_1762427170
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-429cd08586cso497894f8f.3
        for <bpf@vger.kernel.org>; Thu, 06 Nov 2025 03:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762427170; x=1763031970; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uG06GFhvhg2/GhoIc3ckFZLsP4kGe20aTOFoVqJytmg=;
        b=IJJseeHQPmvSp/LV9bOZmLSCO+7DDh2k773X/2UJojPF4tKY03iKMbWR1V+7G9mdHz
         2i5DTythTk1ZJXiV/2Q4NMq53KE3y6jQE1ipd16U7BbPqaYMRTPu2Vo8JsJtQ8WHx29N
         Kg6hQACf2i3Cg3FtHhUVO72pRxq1mJIANHjRLdV59XgWVEJPtpJkXHK8Kpb2/CDxrZoB
         zNRmm6Gd9rXH+REX9ULilJP/RVZuUIuzGzs2Fe3uZY44Hp5ifGHa25gz8RyEGIirloI3
         wl12cnAj+cWUPgYct8gAyzlX8FWRq0uFG5qSL8Nf1VyLP1BTefOmymLxlvr5uXoDb7MN
         R0cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762427170; x=1763031970;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uG06GFhvhg2/GhoIc3ckFZLsP4kGe20aTOFoVqJytmg=;
        b=d+3InEkvV9pXQ7xf7YM0bI/fSy6bcH8j0TM76cO2qd3a7005rqrWOiZxnbJIjVZMrK
         DMS3yV/5ZzzDQz2ojyJqTlO2jIqcE5fKYHQatHivigXAIHPJfexUYtfsngCNZII5p4Jz
         9vuKLAf8F3qWiEe2VRydxyk30eXQP6gzZAMvRMrETtG23rbK6WroniMsywh29BeDBaor
         jIHjigR+89SOCvmvdR+fhTMElOPlXgsrvUndkTTMz5Rx0rF4p3K6VdBzab1LYXTpnVNJ
         jHQMNN6ZRedssgAj0MgICMfZzFKJZ/uHdUmC6Kh7+zkJ5AACrRoNePUGtk3xYdsoGYhR
         8Pew==
X-Forwarded-Encrypted: i=1; AJvYcCVka8FRPCAxyZfD60SiJwVVT4pmElrpECQ4RQfq4ljLAC6IhAux7b5WP7mAG9/vgQGv+j0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjJ+Km/4CyustBEnG+9AwtQNxmN42fwxhJmIOSPGXzWzny2iPw
	1p5WT8sHI82VSqr8o0iTjfk351wUlAZqIGD21xYcQ6V7YcLBlX4UjJJi+U0UXGUtX0oxFKqPwvV
	J9AOLGjpZy/0qDUFPl+esv4Gi2FSIoMcvZbYrW4+q0FalqTPB79wHiQ==
X-Gm-Gg: ASbGncubW0pk8jbwO6OAGAmsr8MoxJTpyVwL3hhAoo8oAGtwfpAJWaNEk/ps2NxhkOy
	wgur8EbYOwOL+c3qXc0BYgxwvPWFUoWCHAE/k4eDoU4cJQ6+wswjigTEluoiqxW9QchE9zkMDLD
	x2ElHnQZNq476JF03wLsUACgVceluGrw8dwRaMvKc5mPC1WYlL+u2WC+TzobTLFRMX30TZ/Z+ZJ
	6OsMAGpm0qBuDdssMkKlXn9QJ9btR3dn0ERth8cEJET6cVex154nw1V9WZDX2PdooLZ0iDbxIL6
	xwsrj9M8mlQSvFSZ9KMwZoosGXNSgd22XtTlNzDUczMYVDZzVJF2CWAGptu8q+VRfxE2O/rBpFX
	O8w==
X-Received: by 2002:a05:6000:2906:b0:429:cab5:7852 with SMTP id ffacd0b85a97d-429e333cde0mr5731273f8f.55.1762427170042;
        Thu, 06 Nov 2025 03:06:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGTtI8vYgnO1RGwmVN+jHUiMzYwpB1QH1SDyUcEnFBvLnN6YC5pja1tLsRgCwJnde/PfJVqIw==
X-Received: by 2002:a05:6000:2906:b0:429:cab5:7852 with SMTP id ffacd0b85a97d-429e333cde0mr5731215f8f.55.1762427169550;
        Thu, 06 Nov 2025 03:06:09 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.83])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb4771f4sm4333146f8f.22.2025.11.06.03.06.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 03:06:09 -0800 (PST)
Message-ID: <f98d3cab-7668-4cf0-87bf-cd96ca5f7a5b@redhat.com>
Date: Thu, 6 Nov 2025 12:06:06 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 03/14] net: update commnets for
 SKB_GSO_TCP_ECN and SKB_GSO_TCP_ACCECN
To: chia-yu.chang@nokia-bell-labs.com, edumazet@google.com, parav@nvidia.com,
 linux-doc@vger.kernel.org, corbet@lwn.net, horms@kernel.org,
 dsahern@kernel.org, kuniyu@google.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com,
 kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, andrew+netdev@lunn.ch,
 donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
 ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com
References: <20251030143435.13003-1-chia-yu.chang@nokia-bell-labs.com>
 <20251030143435.13003-4-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251030143435.13003-4-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/30/25 3:34 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> 
> No functional changes.
> 
> Co-developed-by: Ilpo Järvinen <ij@kernel.org>
> Signed-off-by: Ilpo Järvinen <ij@kernel.org>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> ---
>  include/linux/skbuff.h | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index a7cc3d1f4fd1..74d6a209e203 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -671,7 +671,12 @@ enum {
>  	/* This indicates the skb is from an untrusted source. */
>  	SKB_GSO_DODGY = 1 << 1,
>  
> -	/* This indicates the tcp segment has CWR set. */
> +	/* For Tx, this indicates the first TCP segment has CWR set, and any
> +	 * subsequent segment in the same skb has CWR cleared. This cannot be
> +	 * used on Rx, because the connection to which the segment belongs is
> +	 * not tracked to use RFC3168 or Accurate ECN, and using RFC3168 ECN
> +	 * offload may corrupt AccECN signal of AccECN segments.
> +	 */

The intended difference between RX and TX sounds bad to me; I think it
conflicts with the basic GRO design goal of making aggregated and
re-segmented traffic indistinguishable from the original stream. Also
what about forwarded packet?

/P


