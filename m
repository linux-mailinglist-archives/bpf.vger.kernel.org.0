Return-Path: <bpf+bounces-69451-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64250B96BD1
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 18:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C0BE3BBCC2
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 16:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F166431282D;
	Tue, 23 Sep 2025 16:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="jMbavm5V"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365CE30F943
	for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 16:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758643598; cv=none; b=MmGbr7T8COQBaiLHXhrgQ/CvuSrL+EoVwhWyQYkEvqrfiFsIV0VHICmWxfu8ObVYOqNvydjNw2zZhBkJ7kpYEbDHbY0DdDSXVf9reqdciVer9bldozK6YHl3bAk7zlbMfsQP2q2/wqUqGt15Xymnadx7ZhORZApQI/JgVpMJzMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758643598; c=relaxed/simple;
	bh=FVRF2MWvLEs/zklW95PhZwQh5yuXlKRQsTs+dtNDZvg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HGugS+fo94huswmTTSvZzRtsq/jAqACrMdPVJzLcQ+pUy4NMLrKtQFYkB9aNbNkrTUAGmFBwQ8AInmllCGZRrcLgo1zMT3qAbK7Aq1hvOMYYyKMQvZ7Gha5k1RcKbSOtjqiuYG8KqBODMY7Nw1Cuh2ZupEIAT0PK6RBTKISv9Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=jMbavm5V; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b4755f37c3eso5352467a12.3
        for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 09:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1758643596; x=1759248396; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bd4hQN+qvWGihEbtKGP8wbOZONU9V326xl4tL+0chGM=;
        b=jMbavm5VmHLQOwpYJtbUGlbUIrNa1CKZTN+ldN/SwRS4p0IXHm6su0aIzqzoFKhMRm
         mPmxgri+NEjLlPIN7GopbGVIRkbEUTwZ7FOovzU/72i5Rhnq/w1hodnmD9hkFFGKsKp4
         wMorWx1udJJ28qVB0SbAzgVTesWTXjKV0eYUTp4+RtVRvNrR/IwsGuP1UsnWGFwNbVnr
         2v6/TfOVAy4vKmzCpmagMZTLz2prCM1VzQd+Yeh4tUbZgKTyKXVb04GrHgCAm0Y0DoAf
         bqc5yivv2+8d7TlilZzyiaiBrOg9+rCMLyFjfvDThjrUpZtACM7zqEz7vwvLgSvcRkMS
         rrYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758643596; x=1759248396;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bd4hQN+qvWGihEbtKGP8wbOZONU9V326xl4tL+0chGM=;
        b=pSseqJZgPnN0ROUOc3OgQMyxUEZf9CAUdfPZCS5tlZGCqQsfXWyqFIwDjxQwGm+nLz
         JUd/vf8ZHlvVP3NbYGvgngxDpSS/LmG9J+r3xjXvkl/pLar32FYL6uSBGmwTHGMQ/wUM
         2XT1nWwbgCu+GUTdue7lJR55wrsgRImJx/qqi5cBNmuKpnibIc/tKu+cRAc+aVjWvKsy
         d0w0zKEJDtITLJZ4THCI8E/S98FRN3nwzI1AzZBgYGU6oi5qLkkQ3z3DzRRYGZSP+5Wh
         6jTdJ2dnFyk7+U6pSzrgb/tvFXzd/I83owEDaQo4pl8uKhZTQ6jLrlj2f/4M7DcZ7vBr
         VJkA==
X-Forwarded-Encrypted: i=1; AJvYcCVAXDVvJIW92hJSNL5Ii8TaKZ3NxyzADL5gvdr4V51EE0+jR4i0NzPeHD4KSTgjT95R53I=@vger.kernel.org
X-Gm-Message-State: AOJu0YylYJQ37E3kcI0blckuJxem/x5gnE7U8UQNzvCdnVwVgAv+iehj
	knP5iIERxp8ZxAbhGiDRBg0ZLoHy5xM7ECgha//2k3owXA+vfF9UlD30guCsZ8Qr1DU=
X-Gm-Gg: ASbGnctD4q+PsPJoGQGH5N3djWVwaxqFDHmEXl6X8lhqOrwesAC7nwY+EFVmP6o0pQH
	KNNr+Ur2frXGmpRHU4arDZLjNYPVa20l6U61AGWbxXf22BbAKp5Y7vcZVZ1ImqLw+4443fsKH04
	w1pFFsQjB+effsVUWXDsx5YtK/2lbPGv2A7aQ4RT6Ip4qVSos9skvOpfJ/yW6p+qHs/ywDG9UgQ
	H/+p8RhTJoydJy83+DDcdQ9ulOUDrEumc9uCTzIvxYIxSb/zMKWg6+/F6dccs8chPBjoInT+Nj+
	+VogrKn+XChTANO3q9ivqOyq7MCI8iKdo/9zWSyq3EnnBH6XDkT9doqApZx3Uu+KaqGxShW6OyV
	HygdkcUBP9dDnlKWz9i44F155S5px1PdiXhSFFRUISakuT265IczjmecVb0UexYTAZ0XBvDiOPa
	E=
X-Google-Smtp-Source: AGHT+IGRbk4Hm1+Nv1zaxM0HUJGGlc91y96fYXRJcIPKNHCjlQw1SVCwLkTWUxAkA50cTLP1QrcvZw==
X-Received: by 2002:a17:902:da8f:b0:269:6ed4:1b0c with SMTP id d9443c01a7336-27cc2008c56mr47908505ad.16.1758643596262;
        Tue, 23 Sep 2025 09:06:36 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1156:1:ce1:3e76:c55d:88cf? ([2620:10d:c090:500::7:1c14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698016b675sm161802535ad.36.2025.09.23.09.06.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 09:06:35 -0700 (PDT)
Message-ID: <bc473610-4a3b-46a4-b875-df945032a909@davidwei.uk>
Date: Tue, 23 Sep 2025 09:06:34 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 05/20] net, ynl: Implement
 netdev_nl_bind_queue_doit
To: Jakub Kicinski <kuba@kernel.org>,
 Stanislav Fomichev <stfomichev@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, davem@davemloft.net, razor@blackwall.org,
 pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com
References: <20250919213153.103606-1-daniel@iogearbox.net>
 <20250919213153.103606-6-daniel@iogearbox.net> <aNF0G6UyjYCJIEO5@mini-arch>
 <20250922182651.2a009988@kernel.org>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20250922182651.2a009988@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-09-22 18:26, Jakub Kicinski wrote:
> On Mon, 22 Sep 2025 09:06:51 -0700 Stanislav Fomichev wrote:
>>> +	priv = genl_sk_priv_get(&netdev_nl_family, NETLINK_CB(skb).sk);
>>> +	if (IS_ERR(priv))
>>> +		return PTR_ERR(priv);
>>
>> Why do you need genl_sk_priv_get and mutex_lock?
> 
> +1
> 
> Also you're taking the instance lock on two netdev instances,
> how will this not deadlock? :$

Yeah... Sorry, we'll need to rethink locking in this function.

