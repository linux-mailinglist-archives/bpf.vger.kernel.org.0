Return-Path: <bpf+bounces-60803-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58665ADC42F
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 10:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F153A3B4D9F
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 08:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0B028ECE5;
	Tue, 17 Jun 2025 08:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AKQGYg0Q"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BE51514F6
	for <bpf@vger.kernel.org>; Tue, 17 Jun 2025 08:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750147402; cv=none; b=IV6YzUCaO6aUxtcaXRWrgiudbP20SNE0vHKs8Y0hBHWewGhaw0XmXcy94zdsXeDGldUjudCXVReX1sxGyKthDMVm5cszd6WYXOi20UcPiObs72A9lw1FLSGOko7yQyFaqxfGTi8W3Z1TG3sqbjMASAOWYPxf69htUoqpkH7CY4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750147402; c=relaxed/simple;
	bh=bA/s+nEWNrj//fK7D5RkLh1+Yz6YKukh9Y35BfxnfN0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nLOM3UNaEQd3A2CXBnEHjYPdl13e/Sstv9/L+ddx+Id87YwQ00+htcPm5wXo6hV2K1fQZCiNRddgZ/8Vzrwfgufu751hsYToJGx2FPfiKh8ytfavKtYdyfRJuRQmijs19Q1ngc1ixSL5J0+t8qeaoLO9CzAgJXYtEqKn1csJhR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AKQGYg0Q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750147399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I9M5qb9uvgcmFrvNHUSO6JPSDEu8M+uViPg0NcUfDQc=;
	b=AKQGYg0QvPbo1k9p45N+K5suBHahoGGtwKhAy1LB/+qLp0c/oMHIRjosBeG1D6CsQ3wIJa
	UKbDdZtSBNvqiYtFY6tCgqQkMKoNwx4IoDjPPPcKq9RRtIXlI0Yw26z/u4SRbAjEqisbcr
	IQUq2RrNo/jTICzDboFTGoOZWWlb9i8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-UvuEHZm_NpSeZOMW5qLv8w-1; Tue, 17 Jun 2025 04:03:17 -0400
X-MC-Unique: UvuEHZm_NpSeZOMW5qLv8w-1
X-Mimecast-MFC-AGG-ID: UvuEHZm_NpSeZOMW5qLv8w_1750147397
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-452ff9e054eso28128835e9.2
        for <bpf@vger.kernel.org>; Tue, 17 Jun 2025 01:03:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750147396; x=1750752196;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I9M5qb9uvgcmFrvNHUSO6JPSDEu8M+uViPg0NcUfDQc=;
        b=H1IHw7gcpM7hVNC/WwxJmG0r3myJ0P59qaakHIttdBfq1wi92ijyVZtMINrIsieK6E
         D/WcpmFBRbYaHYMqbt2euATaob5p2rOHzs/FVI5OON+hddATUCLY7IDqlDN7FGvI4jeD
         31w9nW8hCzl6zA+iltkLx9+X47fp7MAPPCvO4HBojXac2Zhm/bezBiELXVaKO81p1RSS
         LhZLn2/uBpicu+rRh3L8OvIMaHZbdzmCWCO+bL5syJ3waiT5VqP6yPMwDpskyGtnlfbj
         uMIJ+C70RFHzM3/wE2idzCD49g2rb2cVbTvl5buFn+aJ61gP7cssNFUTLI53YEPzwgY5
         js9g==
X-Forwarded-Encrypted: i=1; AJvYcCViX/pOdiLxOmheL/1AmfADOG0G4bWKjrlWbtB1mtiMKyt0gIuwJqsClE6xUS7Jcgfy/1A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnV1d+TqBnU4ZkYTkom0bm+9rLUHxsR5+mWdRnCxUtBya9ZFFg
	iHktGVYTY4pimgdh0wufbG3LJ56fot7Gy/EijEqTqKbTCGd6lxDA33lTf3qYoKVNSg7AukQCO6W
	FccTTnHbonVD6V83U/wzJN1G5c3yD1FOzN6o9ydKO6PTlvN0g858R7w==
X-Gm-Gg: ASbGncsPsfvc1DFeG2IITuFXST93eSkvyWVpAtK4O/uywbUtb/TDQHqU/Z8ZdSYoadW
	AvG8u7H7nbiZt2W9IvDaNEyS4t4joIp+lY2Ea0Sv9eKl24xXULGgvO3Nm994fDWshhUO4siANcJ
	CH3gcUIGK92+SOYJRxbjvvog6Xb+oUiBSFfIiL0K3BzhLW2N0ryb8q3mBSvxzY1jHaU7LZ6UkGU
	W+UfptIDMYYyvKtLl5zGKbYLuXKVByjzS5sjyr2UyX5L2EpxP8OgRaW5LIL5NeIF3myXFasOyGz
	s2e0tTxgfYyfYiZrrnAyTgmu3wuOYmzWPTwQrAQu3Wd8M5vJTJak8xWHye97AfTEaCRU2Q==
X-Received: by 2002:a05:600c:6989:b0:453:9b3:5b65 with SMTP id 5b1f17b1804b1-4533ca502ecmr118289885e9.8.1750147396395;
        Tue, 17 Jun 2025 01:03:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGa5hb12hxOI7NI9LM+Gy/ttziKvFk+cYltrEgu8xSQyQCrypOS1hOsZRqs2NvczVsDJZBItw==
X-Received: by 2002:a05:600c:6989:b0:453:9b3:5b65 with SMTP id 5b1f17b1804b1-4533ca502ecmr118289205e9.8.1750147395893;
        Tue, 17 Jun 2025 01:03:15 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2448:cb10:3ac6:72af:52e3:719a? ([2a0d:3344:2448:cb10:3ac6:72af:52e3:719a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e16a097sm172162895e9.33.2025.06.17.01.03.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jun 2025 01:03:15 -0700 (PDT)
Message-ID: <8ff9ee00-1bb6-4558-b2a7-c0ee59badb12@redhat.com>
Date: Tue, 17 Jun 2025 10:03:10 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 net-next 04/15] tcp: AccECN core
To: chia-yu.chang@nokia-bell-labs.com, edumazet@google.com,
 linux-doc@vger.kernel.org, corbet@lwn.net, horms@kernel.org,
 dsahern@kernel.org, kuniyu@amazon.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com,
 kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, andrew+netdev@lunn.ch,
 donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
 ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com
Cc: Olivier Tilmans <olivier.tilmans@nokia.com>
References: <20250610125314.18557-1-chia-yu.chang@nokia-bell-labs.com>
 <20250610125314.18557-5-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250610125314.18557-5-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/10/25 2:53 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Ilpo Järvinen <ij@kernel.org>
> 
> This change implements Accurate ECN without negotiation and
> AccECN Option (that will be added by later changes). Based on
> AccECN specifications:
>   https://tools.ietf.org/id/draft-ietf-tcpm-accurate-ecn-28.txt
> 
> Accurate ECN allows feeding back the number of CE (congestion
> experienced) marks accurately to the sender in contrast to
> RFC3168 ECN that can only signal one marks-seen-yes/no per RTT.
> Congestion control algorithms can take advantage of the accurate
> ECN information to fine-tune their congestion response to avoid
> drastic rate reduction when only mild congestion is encountered.
> 
> With Accurate ECN, tp->received_ce (r.cep in AccECN spec) keeps
> track of how many segments have arrived with a CE mark. Accurate
> ECN uses ACE field (ECE, CWR, AE) to communicate the value back
> to the sender which updates tp->delivered_ce (s.cep) based on the
> feedback. This signalling channel is lossy when ACE field overflow
> occurs.
> 
> Conservative strategy is selected here to deal with the ACE
> overflow, however, some strategies using the AccECN option later
> in the overall patchset mitigate against false overflows detected.
> 
> The ACE field values on the wire are offset by
> TCP_ACCECN_CEP_INIT_OFFSET. Delivered_ce/received_ce count the
> real CE marks rather than forcing all downstream users to adapt
> to the wire offset.
> 
> This patch uses the first 1-byte hole and the last 4-byte hole of
> the tcp_sock_write_txrx for 'received_ce_pending' and 'received_ce'.
> Also, the group size of tcp_sock_write_txrx is increased from
> 91 + 4 to 95 + 4 due to the new u32 received_ce member. Below are
> the trimmed pahole outcomes before and after this patch.

AFAICS 'received_ce' fills the existing 4 bytes hole, so
tcp_sock_write_txrx size should be now (95 + 0), am I missreading something?

> @@ -384,17 +387,16 @@ static void tcp_data_ecn_check(struct sock *sk, const struct sk_buff *skb)
>  		if (tcp_ca_needs_ecn(sk))
>  			tcp_ca_event(sk, CA_EVENT_ECN_IS_CE);
>  
> -		if (!(tp->ecn_flags & TCP_ECN_DEMAND_CWR)) {
> +		if (!(tp->ecn_flags & TCP_ECN_DEMAND_CWR) &&
> +		    tcp_ecn_mode_rfc3168(tp)) {
>  			/* Better not delay acks, sender can have a very low cwnd */
>  			tcp_enter_quickack_mode(sk, 2);
>  			tp->ecn_flags |= TCP_ECN_DEMAND_CWR;
>  		}
> -		tp->ecn_flags |= TCP_ECN_SEEN;

It's not clear why you need to move this statement earlier in the code
path even for ecn_mode_rfc3168(). Either a comment or

		if (!tcp_ecn_mode_rfc3168(tp))
			break;

a few lines aboved could help.

>  		break;
>  	default:
>  		if (tcp_ca_needs_ecn(sk))
>  			tcp_ca_event(sk, CA_EVENT_ECN_NO_CE);
> -		tp->ecn_flags |= TCP_ECN_SEEN;

Same here.

Thanks,

Paolo


