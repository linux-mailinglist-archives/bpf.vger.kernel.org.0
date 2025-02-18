Return-Path: <bpf+bounces-51832-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7A8A39EA9
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 15:23:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 992C61888B44
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 14:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C3B26A0A0;
	Tue, 18 Feb 2025 14:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ajv+mESY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467B512E5B;
	Tue, 18 Feb 2025 14:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739888601; cv=none; b=lChK25HryHMG5vJMhbkTaKlaTZMNJIoq220RHeIprv+4kOkRp07DQht51WdiSWlwdlXsf0p/iXj4uj7ojFGO7MBLqsHzNe5F6J1s9+ZMxWOV6dyEez33E1KSnE0Jz1od8vShpH6J1rEj8taS2yDMpV39r+rlUuwpf4FqXiYAlB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739888601; c=relaxed/simple;
	bh=CONBd+6NqgjMpQ0tMshuz8FhQKq3WgC1N1AbdqysDu4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=P3rP2s66URIqSyOj4aOojQ8VaaZVDPX8ZOdnP8ezYdsLaZ6n7rIJwCq09hJHhA5OG7jLIGPEyhyHewxa42j/3DH/Z3M44LxDynhJTY7qx0jMUG5wYR4+QOHjBAQ+JqNTLSZb7S3iPvRseRCUSZn8GindN7k+mWhzVlVUTbj9gh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ajv+mESY; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7c07b65efeeso466322085a.2;
        Tue, 18 Feb 2025 06:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739888599; x=1740493399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4sYmhE+zmc3hD17FjvQKFpwXBk2uGNhwBBgdjoLl0kw=;
        b=ajv+mESYHeb58JEO7vU8WZrxL4quRrww2lLhUYZAe8aZ11EkZw7SgK5QUeM+rkzy08
         QMubOOGyd7vahcQ+vGGQb/nCm366w9aTh24qRODyS2GLEBuz2weQs2AEHF+JX4k95nF2
         S/WRv4Gc8s2ZZGGaqlyeKJYhzvhH6CaQAtzUHZRmyHLVXe8Dar7Bi//6i7rQm12AOVNK
         u4n4IV8vKqQezghddVzHHBEHSlo4GDEaELEHs306DWjJnCdGAODfYt3uA5GBN37Nvl6/
         SsFSJnTCcVRaCQK0KOuvDusKFWop8vA6+zJe9xc6TT7bqEOQepJZr6xvPPNObABD+OPI
         kuvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739888599; x=1740493399;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4sYmhE+zmc3hD17FjvQKFpwXBk2uGNhwBBgdjoLl0kw=;
        b=TpsCkU5ZK2NveU9ZkvvxjzVljDybw5+K+riZj3DTaLs5dV0yWVPfv6AgX2XqHoshSI
         cbmLsd0LL4Af4ZmGZsGmti8GTl8rCvlrfDa8/sI0+thKBYwD4aVC4yasnzhKcNIxG+CW
         cn72KaKx00w3aWymVjZ5b/6nSdRAAbdrwFjlasPyVViaxOV331lgzGdvHFFQAXUFvssL
         pgt2gjB2lZZPp1nWxjN6H2loZ+3+DbN6YTOvsvclUVUogA1pOwlb+2INLN5gpFmCKfX6
         5sP5i2DQJ/H3ngFI8zgSS1X8LkORhMczEPj5ioOaodfsl9ja0lriahhhDGReU+THhzsN
         EZkg==
X-Forwarded-Encrypted: i=1; AJvYcCXH9w0LxHYTKVgSDnT1yk1Lq611xfY7cWWh698y1MALgAko1jw6R6uc7IlxQitpslW2OxLayM4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjWpYBdMJApdkUrovF80jHdU2pX8sNdYpqSz6WdKLWsdLZyM9s
	gDL90c0JUd4NpnWz7Atk6qRJQwmDTn8FFwpabz6Z/6m3REDE8Uj7
X-Gm-Gg: ASbGnct8eXKgQ65fKe87A6OcNJB+fMN+8vSOTGnAzCDP503+CWCIgqjhyXt/I6p4RUD
	gH9p1ztGyHv/Sb7WqwpLItDZSyiK3s0tFb8rGScJTJxaNRB8Cue2AA4G1VTdzgGcfDJOt/VrsI6
	QTkFii2mD067Zav+c0Hx8Pc2Se0urmfihmia+WiG9yRWSTyfB4KugO8T23MgZGkO4n/sxtEtjyq
	MW0s50QHOBEObjVJPOsnl7X7UUBYlFHmVLI9weLcAlM6CGJLHvFFWZUkN9QWiL3GizgSCitWKPo
	v+8Sn4n5y62PsFO/yHDzsOg6OSPDp5i99jzed11qrOXOjfDynwe5aHQkqu5sKOI=
X-Google-Smtp-Source: AGHT+IF9MQRYRriydIduChjhmkSfWXF4cToCYv7SxVAFl5hot+xYbxVKlJDwimOaHcj/XKikqot4tQ==
X-Received: by 2002:a05:620a:44c7:b0:7b6:d97a:2608 with SMTP id af79cd13be357-7c08a9a6481mr1867660285a.17.1739888598993;
        Tue, 18 Feb 2025 06:23:18 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c07c6088aesm664754085a.48.2025.02.18.06.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 06:23:18 -0800 (PST)
Date: Tue, 18 Feb 2025 09:23:18 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 willemb@google.com, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 andrii@kernel.org, 
 martin.lau@linux.dev, 
 eddyz87@gmail.com, 
 song@kernel.org, 
 yonghong.song@linux.dev, 
 john.fastabend@gmail.com, 
 kpsingh@kernel.org, 
 sdf@fomichev.me, 
 haoluo@google.com, 
 jolsa@kernel.org, 
 shuah@kernel.org, 
 ykolal@fb.com
Cc: bpf@vger.kernel.org, 
 netdev@vger.kernel.org, 
 Jason Xing <kerneljasonxing@gmail.com>
Message-ID: <67b497d631344_10d6a3294bd@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250218050125.73676-6-kerneljasonxing@gmail.com>
References: <20250218050125.73676-1-kerneljasonxing@gmail.com>
 <20250218050125.73676-6-kerneljasonxing@gmail.com>
Subject: Re: [PATCH bpf-next v12 05/12] net-timestamp: prepare for isolating
 two modes of SO_TIMESTAMPING
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jason Xing wrote:
> No functional changes here. Only add test to see if the orig_skb
> matches the usage of application SO_TIMESTAMPING.
> 
> In this series, bpf timestamping and previous socket timestamping
> are implemented in the same function __skb_tstamp_tx(). To test
> the socket enables socket timestamping feature, this function
> skb_tstamp_tx_report_so_timestamping() is added.
> 
> In the next patch, another check for bpf timestamping feature
> will be introduced just like the above report function, namely,
> skb_tstamp_tx_report_bpf_timestamping(). Then users will be able
> to know the socket enables either or both of features.
> 
> Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

