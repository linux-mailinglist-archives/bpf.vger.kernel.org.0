Return-Path: <bpf+bounces-56150-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC143A92362
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 19:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30EEE7B255C
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 17:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5E6255240;
	Thu, 17 Apr 2025 17:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="qZO7cEJ6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6302550C8
	for <bpf@vger.kernel.org>; Thu, 17 Apr 2025 17:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744909588; cv=none; b=CZLs1G8yBYYWNDpgzQvkUP9+UJJJ7flUqOO6r406kNrKSJ/nYU9zIdlm/kvEezupeUYq1bCPS4AWwiLRYkR9p9ykuyznVg6zMSaIaUsfSY31A7MHBhC8FUdEBzmJiV+gicE8hqmpSqZJZ5Bs1DgpV7zrcCVUzBhyIbaTXL64dsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744909588; c=relaxed/simple;
	bh=/rayCc9ocJT3K1N38tkBInMy2zbXnfq0bzNX+4YFKNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j4GeHui/6BIA8yU5ctQBfZ/GyQdA8H3e0JtC0W+PbndYD4ix0UKlRbkKS8OG+OyvezO3R1cdGYW05M4RuZEzPgyFt4yHZmPkvOxYxt6fYvabmSdOkJkhDEi8zdBP4Sv6Ka984dpB/JmzU5IVp2AaWnj8bFteuPGbwzA1UTmTHUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=qZO7cEJ6; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7396f13b750so1175723b3a.1
        for <bpf@vger.kernel.org>; Thu, 17 Apr 2025 10:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1744909585; x=1745514385; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4xXe/XCInddH4WV/KVFfoKsdbwZ1rzQJBQUNYtkK2yw=;
        b=qZO7cEJ61kijisuzXtc7rEeQIPG/iMvwgr3lCSu75ur8oYjseyjrCQHWJz/tzP+V2y
         6Ro0qfd2V2tKD+oaGnj2Mfi0dhJF2Uac0JXx/+yyetjj2rU0T46Yh2EtJ7sNxvcrSsuY
         F6bsto+GohhwqfQoxu2bgUz/ddQcaBsrkRpz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744909585; x=1745514385;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4xXe/XCInddH4WV/KVFfoKsdbwZ1rzQJBQUNYtkK2yw=;
        b=Y4rjo1Y6+pz3wgf3o11Cx92TK/Ol9VF9nGQZh7Z6tAIRt49c0OcC62CFy/kbGEcO+n
         pFACB+EmY2jTtY0hyofjGLX7C67BW7+DW3l8jYqLSfeQrxOnYly/DVkjjp70Et/RKPt4
         YzOC8iQ/yjqHCkEvC3i27EgdB+07pDQsk6TfPrpUGmQGlXc2jmDQHPidvGyThYjoQTXE
         hrvVQvqT5TqNp3VDILLpYtUYI2NLw+9oDz1C2Ddk4gN5tumbFQJi/ltXoYK+bih+H4zd
         JC2SUT2HDVQqXqM+Fa8yudVyQaJCiQQpKQa3TuwUxwldSC3vTc+STAGmwIurnV/Yg77O
         2weg==
X-Forwarded-Encrypted: i=1; AJvYcCVTDUgtxWL3NpOC/8JlKwXERMGCHyR0zDexhw74KLNHpBv4yLDBaAv7IwvPcZz5GJUAKg8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPiyY6wCjWCx23ylnTeK6UwBbxbQBFoMOHrPMSZ2Gzqb25LL99
	sDaUQ5p+J/YwZdJREIik+oeeLyhEAfYqubMTPwax50dasAiXgNqQchKTtvPCWy4=
X-Gm-Gg: ASbGncvJ7ZZVv8LPIFTjnThrwK3pTnX7kPSotGiExZSAC+h8Mxh54ptrviOsgm+R883
	elU7B5sVU02wqgjsC1XW2U0nYUGMfGyJgD1uEPFPHyhA/RFW7KZWOZ4TCUIRqh/ru7CkJg5KC/F
	j+gRh/OnAc3tlQTX9vNyU+KkSXFhVckRIl6KTw1Wpdbs/4F6C0P1i78Tk7rsujXfp4ljNywMy1U
	hL6ZW1cSlslgF4g83f7kXLjFZ4jO1rjecXI2MxUPSS7ETA460CoOE9EEIDJYWTVInYRfAa2OBg3
	KJKl8eyYJeOqjG9re9r7BE0aKv06HJj8iIGSMFlzPUuj0q/EC108DyL/ovBGz1EZyKzyvRWGii+
	fvQtwhSm60UcpDgvQp3fxIvI=
X-Google-Smtp-Source: AGHT+IE7lJplDSFz7ARLg9Ar2ZAXnjAKyTmuyKanO9eaaZPdP2fa0Yk5XsKE81dhgmyhqhOavS+vQQ==
X-Received: by 2002:a05:6a00:710d:b0:73c:3116:cf10 with SMTP id d2e1a72fcca58-73c3116d5f5mr4731684b3a.23.1744909585513;
        Thu, 17 Apr 2025 10:06:25 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbf8bf5b9sm93861b3a.19.2025.04.17.10.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 10:06:25 -0700 (PDT)
Date: Thu, 17 Apr 2025 10:06:22 -0700
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	"open list:XDP (eXpress Data Path):Keyword:(?:b|_)xdp(?:b|_)" <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next v2 4/4] selftests: drv-net: Test that NAPI ID is
 non-zero
Message-ID: <aAE1DkYpvb1yUp5_@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	"open list:XDP (eXpress Data Path):Keyword:(?:b|_)xdp(?:b|_)" <bpf@vger.kernel.org>
References: <20250417013301.39228-1-jdamato@fastly.com>
 <20250417013301.39228-5-jdamato@fastly.com>
 <20250417064615.10aba96b@kernel.org>
 <aAEvq_oLLzboJeIB@LQ3V64L9R2>
 <20250417095310.1adbcbc8@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417095310.1adbcbc8@kernel.org>

On Thu, Apr 17, 2025 at 09:53:10AM -0700, Jakub Kicinski wrote:
> On Thu, 17 Apr 2025 09:43:23 -0700 Joe Damato wrote:
> > I think the main outstanding thing is Paolo's feedback which maybe
> > (?) is due to a Python version difference? If you have any guidance
> > on how to proceed on that, I'd appreciate it [1].
> 
> yes, it's a Python version, I made the same mistake in the past.
> Older Pythons terminate an fstring too early.
> Just switch from ' to " inside the fstring, like you would in bash
> if you wanted to quote a quote character. The two are functionally
> equivalent.

OK thanks for the details. Sorry that I am learning Python via
netdev ;)

I did this so it matches the style of the other fstring a few lines
below:

-    listen_cmd = f'{bin_remote} {cfg.addr_v['4']} {port}'
+    listen_cmd = f"{bin_remote} {cfg.addr_v['4']} {port}"

Test works and passes for me on my system, so I'll send the v3
tonight when I've hit 24 hrs.

Thanks!

