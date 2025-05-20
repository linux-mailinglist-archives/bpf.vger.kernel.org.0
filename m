Return-Path: <bpf+bounces-58542-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7DD2ABD40A
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 12:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 431C24A1514
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 10:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E29C26A0ED;
	Tue, 20 May 2025 10:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bRHDLVp+"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D9D267711
	for <bpf@vger.kernel.org>; Tue, 20 May 2025 10:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747735211; cv=none; b=f8c4ljY8PB4xyqvMIBz+rL94CUTOr1AsKZ0IZ/E7x518/dVJnH9wOS/PJdRXFgG7BwzwoG6QI2WKOuDYNfRUHE7bSjsg9Zssgfsy/3gPi4sHvLM4AxfgV5zjCZlmYSem40eBPVYr5XHP7EEjsL9THzCRrTG1pILOWFOkojuxqFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747735211; c=relaxed/simple;
	bh=V35LW/nQwrBSZ0SSHfv5/VHFhKk+U/HLriCmAgR3ptw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IQpOJiZPo9/z1ceSddOwLaV1dr2ma2F0oat9BQ1eTo4j7wbpV9J5NuV3OfQ+RtWadr7/Gh/ivTFpoqIjeQPbUYdTH9NcEFJaO77LCY9agTushjQm7OoZiN151G/eUdwG50XnzqKnBgvBFE8CIxrzPX9NYpr9nFPl/xvSUi7QykY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bRHDLVp+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747735208;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ovy79HPIsx1vRVu32FicMB6OR/2LefEMThzMtPSO4mM=;
	b=bRHDLVp+9ZUDCQcWUx1XZZritF+MXQDIwhEoddoxgX3Q6XpmlJqyP6YckQMri+VyY5OX16
	W7C90IeQ3BNK6sORYjCN5vnikQm9lDaKAOdB5bvVfuP0qiYdbhU0DbNRi7/QHuvePWhLFk
	NvCM927oz9NvI4/JniH6Uh2oiyAlLks=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-o7UymFzOOkug90PKTYCmiA-1; Tue, 20 May 2025 06:00:07 -0400
X-MC-Unique: o7UymFzOOkug90PKTYCmiA-1
X-Mimecast-MFC-AGG-ID: o7UymFzOOkug90PKTYCmiA_1747735206
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a376da334dso893839f8f.0
        for <bpf@vger.kernel.org>; Tue, 20 May 2025 03:00:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747735206; x=1748340006;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ovy79HPIsx1vRVu32FicMB6OR/2LefEMThzMtPSO4mM=;
        b=UPJcEwVG/ZbGF2YEUOB0cArzJZ+0MEO6wrx5/ERhA6XSftnI6K/PQSaKAG6xxAqoeY
         D+nAvRFBFKzBfY2wl99zi+FDTqIAjIxtzZNsUzQywdwN+Z+fQVM1AUxsetnyRKh1fXgv
         PJzj6yXqlkN4IQTp/AthspDRjJ/hgchdUMwGhHnmVqSGnjnxdi9ZNLZ6ZFlm8ZuGhm1t
         Q47j1mtYuGvpeSQ/1+J54onFbwciIUwZRLOri5c+/UdBaTW02PIQjh59F/K7hpcFwcqy
         d9F0Rfe4BHzK6wDCHrz47osV7LHpr20qKCiOBBcbQKpY1VEe/dOagoSMyjkoXm1X1GEA
         y9KA==
X-Forwarded-Encrypted: i=1; AJvYcCXb5M9z6AlZSvkCmgnrWz5tX1RCmW/rtP6mzxbZB5uSg04/8J+JaB+uWkIADqkHlyxn5G0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJnaSIdfLUNspSQERjfz/vZdMWlnySna3IkIqiMfZ0KTbItH9O
	i7ye0sCCmktnlISOAsANY7n7L0ogj5Dr8YOdXrqsPQniWRhhEJCACQ49yKOX2DdBlxxu9VG68OV
	Yq+A+53H4jmAJg9Xb8rFbONzFxx6wlBHaEAwK0T/3ARD+Gnojxpw+9A==
X-Gm-Gg: ASbGncspbigdkSuVW84lDj+nPCMz5UGbGbkEAjiF71rO3DuildshqFOE9Z/67IXSHb0
	Z8KZT0zqYnGu9esfDHYAyLJdPqKCrgKCRBSVrTlnIO3T/H0wWOMx/CScicvZCBx44FYM03c41yV
	lTDtS6wiNuCUyk2YNS5BelfLCi0ie7rQcJ4MXSsz0BcWMAI/5FlF7JqyIm031onOeJoZj/SXfUD
	gsHNXSlfeeQ6St0jk1+Yj0OHmJqvyHXhh+a/XaOZJq9EksoZ96uiumT2FFI2k7moIV2tTj+91G5
	Qeodfv0NKTnOMAwa5Ij8XhWU6eZyoIc7D+qw8LDHiP6L7QEOLgKO58ERD0s=
X-Received: by 2002:a05:6000:250a:b0:3a3:7a33:c96a with SMTP id ffacd0b85a97d-3a37a33ca7dmr1495166f8f.51.1747735206415;
        Tue, 20 May 2025 03:00:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIRNWAVYHRnOH33ipWyYPABhiYG26BMzPeKKr8tdmXM1gGbvCqc/R+E0nOOiP3C8IUlUYdHw==
X-Received: by 2002:a05:6000:250a:b0:3a3:7a33:c96a with SMTP id ffacd0b85a97d-3a37a33ca7dmr1495096f8f.51.1747735205976;
        Tue, 20 May 2025 03:00:05 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:244f:5710:ef42:9a8d:40c2:f2db? ([2a0d:3344:244f:5710:ef42:9a8d:40c2:f2db])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca5a87fsm15500818f8f.29.2025.05.20.03.00.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 May 2025 03:00:05 -0700 (PDT)
Message-ID: <344a5b1e-9cfc-4a77-b55c-84fe21c89517@redhat.com>
Date: Tue, 20 May 2025 12:00:03 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 net-next 11/15] tcp: accecn: AccECN option failure
 handling
To: chia-yu.chang@nokia-bell-labs.com, linux-doc@vger.kernel.org,
 corbet@lwn.net, horms@kernel.org, dsahern@kernel.org, kuniyu@amazon.com,
 bpf@vger.kernel.org, netdev@vger.kernel.org, dave.taht@gmail.com,
 jhs@mojatatu.com, kuba@kernel.org, stephen@networkplumber.org,
 xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, andrew+netdev@lunn.ch, donald.hunter@gmail.com,
 ast@fiberby.net, liuhangbin@gmail.com, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, ij@kernel.org, ncardwell@google.com,
 koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com,
 ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
 cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
 vidhi_goel@apple.com
References: <20250514135642.11203-1-chia-yu.chang@nokia-bell-labs.com>
 <20250514135642.11203-12-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250514135642.11203-12-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/14/25 3:56 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> @@ -603,7 +614,23 @@ static bool tcp_accecn_process_option(struct tcp_sock *tp,
>  	unsigned int i;
>  	u8 *ptr;
>  
> +	if (tcp_accecn_opt_fail_recv(tp))
> +		return false;
> +
>  	if (!(flag & FLAG_SLOWPATH) || !tp->rx_opt.accecn) {
> +		if (!tp->saw_accecn_opt) {
> +			/* Too late to enable after this point due to
> +			 * potential counter wraps
> +			 */
> +			if (tp->bytes_sent >= (1 << 23) - 1) {
> +				u8 fail_mode = TCP_ACCECN_OPT_FAIL_RECV;
> +
> +				tp->saw_accecn_opt = TCP_ACCECN_OPT_FAIL_SEEN;
> +				tcp_accecn_fail_mode_set(tp, fail_mode);

Similar code above, possibly an helper could be used.

> +			}
> +			return false;
> +		}
> +
>  		if (estimate_ecnfield) {
>  			u8 ecnfield = estimate_ecnfield - 1;
>  
> @@ -619,6 +646,13 @@ static bool tcp_accecn_process_option(struct tcp_sock *tp,
>  	order1 = (ptr[0] == TCPOPT_ACCECN1);
>  	ptr += 2;
>  
> +	if (tp->saw_accecn_opt < TCP_ACCECN_OPT_COUNTER_SEEN) {
> +		tp->saw_accecn_opt = tcp_accecn_option_init(skb,
> +							    tp->rx_opt.accecn);
> +		if (tp->saw_accecn_opt == TCP_ACCECN_OPT_FAIL_SEEN)
> +			tcp_accecn_fail_mode_set(tp, TCP_ACCECN_OPT_FAIL_RECV);
> +	}
> +
>  	res = !!estimate_ecnfield;
>  	for (i = 0; i < 3; i++) {
>  		if (optlen < TCPOLEN_ACCECN_PERFIELD)
> @@ -6481,10 +6515,25 @@ static bool tcp_validate_incoming(struct sock *sk, struct sk_buff *skb,
>  	 */
>  	if (th->syn) {
>  		if (tcp_ecn_mode_accecn(tp)) {
> -			u8 opt_demand = max_t(u8, 1, tp->accecn_opt_demand);
> -
>  			accecn_reflector = true;
> -			tp->accecn_opt_demand = opt_demand;
> +			if (tp->rx_opt.accecn &&
> +			    tp->saw_accecn_opt < TCP_ACCECN_OPT_COUNTER_SEEN) {
> +				u8 offset = tp->rx_opt.accecn;
> +				u8 opt_demand;
> +				u8 saw_opt;
> +
> +				saw_opt = tcp_accecn_option_init(skb, offset);
> +				tp->saw_accecn_opt = saw_opt;
> +				if (tp->saw_accecn_opt ==
> +				    TCP_ACCECN_OPT_FAIL_SEEN) {
> +					u8 fail_mode = TCP_ACCECN_OPT_FAIL_RECV;
> +
> +					tcp_accecn_fail_mode_set(tp, fail_mode);
> +				}
> +				opt_demand = max_t(u8, 1,
> +						   tp->accecn_opt_demand);
> +				tp->accecn_opt_demand = opt_demand;
> +			}
>  		}

Too many indentation levels, please move into a separate helper

/P


