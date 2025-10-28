Return-Path: <bpf+bounces-72525-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A0CC3C14834
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 13:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 817D04E4383
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 12:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA5432A3F2;
	Tue, 28 Oct 2025 12:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WZUujFpr"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4B9329C66
	for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 12:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761653048; cv=none; b=kl/ohsysUs9hEZ+rQbMv+VIUU4ASURfRY57VkGNRU5utGo8H03zdyZ7mOFy+/9Gycu7PDaXnT2gz1UufJsLO1WCWhVZuEPn7FdQI1nsiYM39apsrC0aFL+MCElF1/CH9yDos2uHnvjR8k7HyAHRNdlwqs/H7wOLPnu7Fo8Kix0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761653048; c=relaxed/simple;
	bh=WskojuOBnwIjjigUBWEDMhf7Assmbp3QvliKc3R2txY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CKwXkEShj/1Hb9OtK7hk6dENDJVTIuMQTJ5ZA8eEQQJSGad+QUga89/tiYdGSycjRYTBagt4Zaoqx3EvR8XUgxFEYcDymN0ZXMVpIq3lNkcomn99Ndi5CMGHANWg2693zreVF7RjOigLt/YPdpcgJzAUsjcQgjRHyWlAS7IYpZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WZUujFpr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761653045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5xM3wpdALZDN/yyL3dIoanvrY9zgAvQNamISjAjH9Xc=;
	b=WZUujFprFltBAHWa/3RUOrFpHOGs5hftJAQhOX+RXUTrm9SWj2PoB6OtQTaDtVaKZcRLfo
	4euzIHSFpJ6PH5dm0wxnu9RJ+yyKUW2+UpHGDtaYRLj/IX9p9JRWwh9V5IsSJafzwdZFPi
	m0HvcFAmK8v4tn+NbShXss/u1xumthk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-5c8XUjXhOQeiU18sYiVUUA-1; Tue, 28 Oct 2025 08:04:03 -0400
X-MC-Unique: 5c8XUjXhOQeiU18sYiVUUA-1
X-Mimecast-MFC-AGG-ID: 5c8XUjXhOQeiU18sYiVUUA_1761653043
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-475da25c4c4so17805765e9.0
        for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 05:04:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761653042; x=1762257842;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5xM3wpdALZDN/yyL3dIoanvrY9zgAvQNamISjAjH9Xc=;
        b=eCGuwMNSVZldciV6Hm5EeGSPcNanl/43xjsK2ucHh4Nwt8Kc5oBFq/S/g6l3zJjWEE
         WwoNdWyofO5w8JIvUxquwhkKscJU7l+QjlMVH+Chk2+opziF95P9okw9i6M9gVGPwaGm
         xs/m1Kx7dBiMSbcCwyxAzfFUhYpGVUOVACwIgTY3MnJLv23ziMH5mOfYwkXwW0hTo8zv
         BDeo6uWZZmbBav0g9LVx+Gcy6MxMvxQGzyPzByuSLnMeyoiLrIMx4nZz3yaFnhUVw802
         OlhpmYLIYpDQd9tCdWQwieIKQIbifVlfREy9eaf31K6qLxFs7ku+PCcrrec1+H1VxG4K
         7kNg==
X-Forwarded-Encrypted: i=1; AJvYcCWPcL09hSf8BQkWIIKz3CdrcBMJ1tHfwtGt7sQSxk2yz9JfBf86JVDLolOl8ajQwbdiNKU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3Kmev7ybqmfCJC1QlNCeKBPIVgdTvQ21YYG8DrIFEwJCVa3zd
	v1FaPaJkwAP7XrCCQmqLtpAmcz6/x4Zs2L0pRl6GFm0XP9LFhTXY0ECj1ynvUuGdZfzA8YHCsTV
	Vn1oul2eGL42EY1mi2ij/LUAKWF02ydIKqHS8ANAj8blFGpj0ldxVlQ==
X-Gm-Gg: ASbGncuNRTh092nrUOrTlOMuU7t2QfKHLKT62rgDhA1PNn12N0ufzTy+7IyOxF19sbE
	DOsrmkFk0zC4aSFxfW+GwlXIn19bUss057LwZSkMIkV/1Yi0NiGKMQiG8gakhhvgMraucXMc7Sh
	wwKzwRrpotsjqcF1uElOAoFq1d9Wo7ADcxL4EAnjOQxeH0naefz0dv8F2wrArQs9lixg4kgTEyG
	+UblfVSGztjGbWM2cjOcuy2J9at6ab+LEoE6I480omc16wnZ43S32/TnNKnZX1jKJXgPRtzGS+S
	RK36ylmNMR6x5hFyV9UohCePKoDFflsFE8CvjSPxEtIx6PwRx8rTuwUPziLPY68gnLKtUroNDJW
	Sy9LuhBOENxIBQ0wQR1H1mHdDvv7myn2ocRTYwrvSaWQk2K8=
X-Received: by 2002:a05:600c:45d1:b0:46f:c55a:5a8d with SMTP id 5b1f17b1804b1-47717df9d11mr30659275e9.4.1761653042564;
        Tue, 28 Oct 2025 05:04:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6BMjF+yCSS1WwGmhw2kl9y9f0ddjV6c/A0RrHdROCvFXSSyoxTUbY0rSmrFqSolRY/cH10g==
X-Received: by 2002:a05:600c:45d1:b0:46f:c55a:5a8d with SMTP id 5b1f17b1804b1-47717df9d11mr30658905e9.4.1761653042071;
        Tue, 28 Oct 2025 05:04:02 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd035dc2sm196120995e9.5.2025.10.28.05.03.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 05:04:01 -0700 (PDT)
Message-ID: <c5021188-593c-431c-bf01-6775f5b2b2ed@redhat.com>
Date: Tue, 28 Oct 2025 13:03:58 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 2/3] bpf,sockmap: disallow MPTCP sockets from
 sockmap
To: Jiayuan Chen <jiayuan.chen@linux.dev>, mptcp@lists.linux.dev
Cc: stable@vger.kernel.org, Jakub Sitnicki <jakub@cloudflare.com>,
 John Fastabend <john.fastabend@gmail.com>, Eric Dumazet
 <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 Willem de Bruijn <willemb@google.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Matthieu Baerts <matttbe@kernel.org>,
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Florian Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20251023125450.105859-1-jiayuan.chen@linux.dev>
 <20251023125450.105859-3-jiayuan.chen@linux.dev>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251023125450.105859-3-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/23/25 2:54 PM, Jiayuan Chen wrote:
> MPTCP creates subflows for data transmission, and these sockets should not
> be added to sockmap because MPTCP sets specialized data_ready handlers
> that would be overridden by sockmap.
> 
> Additionally, for the parent socket of MPTCP subflows (plain TCP socket),
> MPTCP sk requires specific protocol handling that conflicts with sockmap's
> operation(mptcp_prot).
> 
> This patch adds proper checks to reject MPTCP subflows and their parent
> sockets from being added to sockmap, while preserving compatibility with
> reuseport functionality for listening MPTCP sockets.

It's unclear to me why that is safe. sockmap is going to change the
listener msk proto ops.

The listener could disconnect and create an egress connection, still
using the wrong ops.

I think sockmap should always be prevented for mptcp socket, or at least
a solid explanation of why such exception is safe should be included in
the commit message.

Note that the first option allows for solving the issue entirely in the
mptcp code, setting dummy/noop psock_update_sk_prot for mptcp sockets
and mptcp subflows.

/P


