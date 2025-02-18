Return-Path: <bpf+bounces-51836-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD2EA39EB6
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 15:25:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F23D188C9A5
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 14:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEBA226A0B9;
	Tue, 18 Feb 2025 14:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Da2Nc6bb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF82269D1C;
	Tue, 18 Feb 2025 14:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739888645; cv=none; b=VGt/eBlrHJcBIco2I1wMiREERV0CEOg81MoMe2j/NKU7CMBtbFkBIpAWqLGMsxE4YyulAES5gPZ2akiz8sTLvlEe9Wre/RtnslLikKurLJkv5o+TwuSIwefkRIiO+m16c3zVZ2+TofDSJXKjnSk+msYsZYvFUXnxpOE9vZ+in/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739888645; c=relaxed/simple;
	bh=S9GJzSJV+e+lzq5//oZgjRLAd3Uoe3V161SPrEooQ9o=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=B6pmQj/K8/WIOncIqGr8nzMFyDEvM0neUlFFw9oEhOu6WJCJ4ql227KjRl3QJP+YE67RCt2MTEPNc/QaZhJI7OvPA2nYT83B7lkAYQOOupRiOf0JJSa/w/ZuL2VZ4zfpJAVK1AEonTTQ+r2dIQAz+BnHZwdYoBU0u5pYoOjwmS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Da2Nc6bb; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7c07838973eso526171185a.2;
        Tue, 18 Feb 2025 06:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739888643; x=1740493443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8MINWkjwvZwn0oEsw5XfTgUouZb2LDtYSR0rI0SQbAg=;
        b=Da2Nc6bbomf86sNqfBg/uW9eZi3mJ6x2sv+10iZ70/UVbAtFIgJfDWl9iai3doWoq3
         qonUABGXjl4dPyyWTwrlxs3mNwmj0Dk5X4dEZaQTxb2hdq0Den8eEGDgauHl2Ql755Rf
         eTDQyatrDStZPGiyDUleEIfghRMyc+DRHhn13K+DYYQh8BAycT6jDUsG9y6YMYwuZR0S
         EWbbAFdYf1Aj5SpIFmSVRpG9+IsQY9q70VRzfVKE4jNwFkcubCdK34uvnMb9E55NH0JG
         MzkYZoMHDIcw/Eo/gBD5mWAyBRacrTr6knJpyh4leO/GEk4276vh3aOu1Ty7mnoWJ6gF
         E4ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739888643; x=1740493443;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8MINWkjwvZwn0oEsw5XfTgUouZb2LDtYSR0rI0SQbAg=;
        b=D+1RiPooyVRryJV+2EASRR8OGtJbIsxgW3WrJwDgaZ8uhFQv58kw13dUbKlP650rme
         AHLTS2lYAel/uOMrtWb+4evBccJXL2VsU0jkn70oKY01tEpdB8dhqt6lREIe3Ay3hDW0
         fHDzRPr+I986Ks/XmI4NJ3xCffbfXIdJBykPyuV0U/hqlqMsAaC8ohvQyFjBX18RDfKT
         L0qXSpdVDqDBSVNLOGTW5otQBq8WMND0klepX0ZmAK1RsIV/BSpF9R5IQ6uAWcHCXdU5
         TFc8iJGpEHgZdXCe1R5qPdqVdrtbnVmI0xo71Scj8pJkvswpBqE/hEFEyX2lOOpBQPld
         hI5A==
X-Forwarded-Encrypted: i=1; AJvYcCWhgfNmH0krT3ZZm/AgGbdPtut2yOZPIkPPsAjtgK+LTF1y9c+hOa+p9G7lS7Zx0q73lx2J6jk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ3tOkfQ7H4yAwjF4Oxcs2fUEG4v2RaXQTBr/cPI9QfWQX9J92
	mL3uoZ5qgKquytKmStn6tujPtiAMLhflPDJwLQyyj8SIbmO0pixW
X-Gm-Gg: ASbGnctn6jCiaaHwDVPfUgJqhNr4+RhsAlpwcu3iaXandU9+ye6fHuX/yg6UdIMUHD5
	Ftd5afQriVLtv8D7Kc5pYAHfAwwc2LnQ8GCAz4O0fSeT1sgQvRV4Vd5pcqLksFeKP3WoQQgmh0+
	SiNwwy28dhQ8PeKr6LqnurGTApRLOC8JuRaXBtfqnuVYR/7p35l1WEZcZmMPIGFyWAzjeRQZzgj
	TBfbczHlS2S6IWu91/m1CZPQ625stnp8HD7QeTbtfrsbgz/zmYtpUhdhJ9w7G056pXScOzDOZJF
	3dIvnErYdJ56cg8UPSRxv9fQEbCQwvW6invLvVrLp0SPaCqsC55fCwBbRYxTVts=
X-Google-Smtp-Source: AGHT+IHamZbuqu5dTg13gMGFMJOT6GnTnOJEbpakoaz6x701iTmONq51Fo1lZrFX9k55ewA67LeF4A==
X-Received: by 2002:a05:620a:45a4:b0:7c0:a843:6aed with SMTP id af79cd13be357-7c0a852ba77mr631803585a.1.1739888642911;
        Tue, 18 Feb 2025 06:24:02 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0ade609easm84872285a.69.2025.02.18.06.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 06:24:02 -0800 (PST)
Date: Tue, 18 Feb 2025 09:24:02 -0500
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
Message-ID: <67b498022aba2_10d6a32944b@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250218050125.73676-10-kerneljasonxing@gmail.com>
References: <20250218050125.73676-1-kerneljasonxing@gmail.com>
 <20250218050125.73676-10-kerneljasonxing@gmail.com>
Subject: Re: [PATCH bpf-next v12 09/12] bpf: add BPF_SOCK_OPS_TS_ACK_OPT_CB
 callback
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
> Support the ACK case for bpf timestamping.
> 
> Add a new sock_ops callback, BPF_SOCK_OPS_TS_ACK_OPT_CB. This
> callback will occur at the same timestamping point as the user
> space's SCM_TSTAMP_ACK. The BPF program can use it to get the
> same SCM_TSTAMP_ACK timestamp without modifying the user-space
> application.
> 
> This patch extends txstamp_ack to two bits: 1 stands for
> SO_TIMESTAMPING mode, 2 bpf extension.
> 
> Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

