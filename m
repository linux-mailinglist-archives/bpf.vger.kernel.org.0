Return-Path: <bpf+bounces-63196-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4865B03FFE
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 15:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C07E167538
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 13:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E306246BC7;
	Mon, 14 Jul 2025 13:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uk1buSPL"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724AB2367B1
	for <bpf@vger.kernel.org>; Mon, 14 Jul 2025 13:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752499833; cv=none; b=AYTl1FsKTKWOOOkCYAMHscJzadjAv+GG4khWBuzVoOQ6iO0zHpDZ8o/mmSD5Zh3Gg9dmDFVtSohWr8ZHBM8VibrdGKWKwqFCgkRp5bwdQ0J1dZM6fmN3M7zmaHmOxcJRIY9Z6jpLTri+rns5+0pzOqV/E06mAwiZLIlbSBnxUso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752499833; c=relaxed/simple;
	bh=jE2PjP+eUyYjMNAeVnNr5q6iOIuN3tAeEx+RGEXiP+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=e45S/dWlcNb2MO/sT0PO3rX5hAYeaYn+BeVSWiEpXrpkUodw9Uaa/2deBAm/PKA6AS+bNovr9CBcLKLY4+NUOE7ubqWb+zP2lzFHjg36H4sWn8XJco2qnwTbykuVfDLyuR3mukWDJvV2Yw4MBkix/Je8fAzTzPDQeo3ukzbUSdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Uk1buSPL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752499829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+zrHqcWkaADA2V8M40rY+/BG8BMVb7igefIEkGbRiek=;
	b=Uk1buSPL1wF+9tQsmc1DLwMIBaNo9l9yizWJ2bMhGhyMJXSUHm/fal6HlxXCvXZBA0Zt1I
	ncUf3oHzYX7iK7654LeR5s1xPrlDKXuMNamc1W9I+y+RysKFidb8GRYafxwTXdrl3CslFw
	VhK+2Bm2Cm4mFAruQ0N41E1KEl2759U=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-wabJpyjhMZy8G8le4uE3Eg-1; Mon, 14 Jul 2025 09:30:27 -0400
X-MC-Unique: wabJpyjhMZy8G8le4uE3Eg-1
X-Mimecast-MFC-AGG-ID: wabJpyjhMZy8G8le4uE3Eg_1752499826
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a4e713e05bso1891506f8f.3
        for <bpf@vger.kernel.org>; Mon, 14 Jul 2025 06:30:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752499826; x=1753104626;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+zrHqcWkaADA2V8M40rY+/BG8BMVb7igefIEkGbRiek=;
        b=qYYe2nRZP1tocsSReH9swJXLOqu28j9gLTr7jUNwEOa7oatrXsiFSzyMawqKyfZULp
         rib9daZUuV7mmsR4YmujsKKHIhGKaHKDsejx36BJjqI/U4lMJVtDeYn5O2OImMmjNIcW
         5kAI74qw37PjPLg9NdnutqKo4EFes2iSjt0HqnR6wDh8xQQzL9y2yNDJrqOoHDlmfeB0
         CMCdM+EGwsDY5PPBFwn0bQNH/pqyK8BKwT0B+eeGG5pZ/8l7CJNttJJGBNGfkbbQXhq5
         jA5P9iOPPEmThmZT6iZGtvxjoQXTb1iuJPcwJpQUZdsZPYJVHQz2eKR9OQ/ywkGLixwa
         NAwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdnc9A73ssYnuJNWxFwH+3WiV07ESprz2xaQoLm7BqSVi3c+TRUXwMFm3m9NOV9KkIuI8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS4R9l5T1SCMxF7EdrfQjCTPkN92zoOOjFZ/C+1JLZSob+tAtz
	QFT4wRc71Slnvb2EAgivuug4rD1RAlv6+sqYttRJLNu1Iukf0KaMiatuMnMDviYlTZlUOB3T0w1
	QFy/uJ1221kxy4JLeLzOfCP7j/1jEcS+DLpdy3a/Pbx4fakOXtXPQuA==
X-Gm-Gg: ASbGncvddm2HeqFZXhrS4FFjsQl6cU3RcMI52dnylsIOdW/DOq1Z1XJwIgaJ3YZtEUT
	NGEhRC2j9IsJcxClqHvntU3NgYIiXEt3G54vXJStY7AmTJNXM1aNWD98vpCHAHjL62GST0VfGk4
	2S6fzuKC7NTuyFeDa2Y4+xW9YWYdvY9FHt7ssZ54O1oiwROSgjCcCbVi/lYUYu0tAKxrMjMRWDx
	iHs+Vzsdnjty2P0QSZcNHNEUikadLosCI/uET1NJ/75BqSRTsObCfIwy716RfNhiPzcKk412MJF
	99/uAlgVfsBQUcMbgHXIqZDf5asjbJgeBtk95+TeJDc=
X-Received: by 2002:a05:6000:1a86:b0:3a4:eda1:6c39 with SMTP id ffacd0b85a97d-3b5f2dc216dmr9064716f8f.13.1752499826083;
        Mon, 14 Jul 2025 06:30:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFaTEcDjTABy5Z9QcNaN67akhbYxVRmsOC1nK6NjQhL0rqHS1s4JU+e5aThLy1SFXDe8sLSA==
X-Received: by 2002:a05:6000:1a86:b0:3a4:eda1:6c39 with SMTP id ffacd0b85a97d-3b5f2dc216dmr9064691f8f.13.1752499825633;
        Mon, 14 Jul 2025 06:30:25 -0700 (PDT)
Received: from [192.168.0.115] ([212.105.155.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4560ddf5e0esm67383545e9.18.2025.07.14.06.30.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 06:30:25 -0700 (PDT)
Message-ID: <dcf822ea-9dd1-47f5-8b2f-9c98013b1499@redhat.com>
Date: Mon, 14 Jul 2025 15:30:22 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 net-next 08/15] tcp: accecn: add AccECN rx byte
 counters
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
References: <20250704085345.46530-1-chia-yu.chang@nokia-bell-labs.com>
 <20250704085345.46530-9-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250704085345.46530-9-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

n 7/4/25 10:53 AM, chia-yu.chang@nokia-bell-labs.com wrote:
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 61b103633da4..0d8e1a676dad 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -971,6 +971,9 @@ static inline u32 tcp_rsk_tsval(const struct tcp_request_sock *treq)
>   * See draft-ietf-tcpm-accurate-ecn for the latest values.
>   */
>  #define TCP_ACCECN_CEP_INIT_OFFSET 5
> +#define TCP_ACCECN_E1B_INIT_OFFSET 1
> +#define TCP_ACCECN_E0B_INIT_OFFSET 1
> +#define TCP_ACCECN_CEB_INIT_OFFSET 0

It looks like the definitions above are not used in this patch. I
suggest moving the definition in 'tcp: accecn: AccECN option'

Otherwise the code LGTM, but I still have some doubts WRT the
significant increase of the hotpath data.

/P



