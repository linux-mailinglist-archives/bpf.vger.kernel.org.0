Return-Path: <bpf+bounces-53659-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD0CA57F6D
	for <lists+bpf@lfdr.de>; Sat,  8 Mar 2025 23:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED483189288D
	for <lists+bpf@lfdr.de>; Sat,  8 Mar 2025 22:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD4620E020;
	Sat,  8 Mar 2025 22:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KVjMi79e"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5071917F1;
	Sat,  8 Mar 2025 22:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741474760; cv=none; b=Lh3R2HkPuTBQW5x4HVesJ2bK9YSldPoZah/lmL2whqr331sOUUWing9g1blAOvhsLTShEdDVK8gwA5JXNPpo70YMZoTCI2b0FaEXRfpiANBeItrD2Jx+qzVQssnUhK7Q98wIbNMaXpegTP5NfuPAAjVcB0dKAMktnBmTstTbt90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741474760; c=relaxed/simple;
	bh=sB92SeEGQyAF6SE8thv+CqiWBDawmX2AqAiWf8yf61s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=thSSiPe3EXRQa4Cqv71TvOxHyQOIaIxw4e+kdknZkmelY3SEG6Ba2iOKWWgynZaRsY0JDodGJd95aSuT7rO25tI/6k9TZfFTAZt8HehfvhzMBGxsljyUaa5K4rkn/FKGdboygXQlpfyE90XA8Kns4L/75PUeR6QeKqQa3A9vX/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KVjMi79e; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-223a7065ff8so36672085ad.0;
        Sat, 08 Mar 2025 14:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741474757; x=1742079557; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cxiW8EN6R1blDN9h6UwBVZwoRhC3HKbW+f3lztUaYME=;
        b=KVjMi79eFVGqE2z+okvkGcF273EmGFEoo+DTx0LURvke3CN6BRMmcqWQCtZPzBduJK
         HPUKTPBu9CAPVykZXH+P1Ef6ut2oJofSJg0CvLZ5KLlMeSwyaeODpei5b4gxDbGF3B42
         yVkUIcov0G5u6cucBsfpPp4jQMV7NROAEUDpd/NE7HZf+aqfi9z3sPKzIHpBWdKtenEv
         wV3EkonyJmY8rlnDoSsd0gXmYYCsAjani5AOFyVXHkK/brk+MocfeIqTYC3iSqNIM9C9
         sOQ5aDuOfJlm0Q4suzZX0aGFh6P7gzubelXLeyCxdXrO2JRANfRy0+JnbPg8sjxvNvmS
         hPfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741474757; x=1742079557;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cxiW8EN6R1blDN9h6UwBVZwoRhC3HKbW+f3lztUaYME=;
        b=hDcIeRd6wYMVWz9IVF7iDSaoikaEGUW7spuHuPQwvkRhypKZl2JUHa/cQMlW54rgXT
         l9STtdn1XzT/Bz4aaJoHrCFYXVHjNELJ5V4RMqiCMBdApbGXnXmWu4HDzKHJxo8Us2ps
         zpynySTL+mRdeuM2IZirCM+cdM4DK/bThXwi5sJ533HG1WfFyJMJSgctBdYagN6YEUWb
         1SrErjETq/teWeuGcDI0dtvkMKwg+7lYmUh/x5Pj1gaQERd1ZzNQOCnQRkViHInk+1Rx
         YV9oS6lCrLHvtqCUpMG3JXL+op5ZwwQ+Wg+GNYxsNrnMgg7Jbk/OzTxxN1qfC7bwX54e
         9Cxw==
X-Forwarded-Encrypted: i=1; AJvYcCUXk26kJGd1ZAOgKMn//RJnuUjrVzaDHb1Re+xcd85dIJKto8ehgN96Wo79z5lIyORk1SA=@vger.kernel.org, AJvYcCUjRX++ljFZJbEt35z94U3x6fWHZdB4qCt9iJ4/IxbqVA1qMIoDy0VeTM/m/2Ukp5rOSC7iTe8p@vger.kernel.org, AJvYcCWh4BfoxAiw9rclvsBWeySJ5hrTt0t5Ymdi1QS9YJ2hSLX7fMp5n6IZR5QoKV7pNk06f1LOgwEOpXVVOsTj@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx4aiQTTFMZy/8A3OlE3Vm7W62tbrl4113tpMoeJGPikm2c0YF
	BkMwjk/5hkSUgsGxO1IxNJbWxNLvbdjeL92XFG7syQgP2tlFarA=
X-Gm-Gg: ASbGnctKVqPUEkNaOy83EbqTly8AsqB5Ey7VKF8y+mjKNWAqbNPq1UOF9xoQKwZcSV1
	Oxwr3tSfxmRXCrt83JPuE+qsKrOPLvCTCk0iNQAc2rnzlQ031CGBKxwVMl59xTrKnJgeuq1OBKK
	ZHDfSw7hRalj1q85Brt6sCGbmvPJWEsiTOK166MwAK0ZRt0T5XmzMQT2n/hlQGytch6E79jAlp8
	3Jt5In8CwzbW5UsSbZZnfgThEULMfPPTCHAanSZyTOIsy8NFjPuw3g2UDH3goqat6L/JrUuUWLV
	0B45oChukv47pBbDMOMBXj3KPYtMbnTdxMw+ansBWTe/
X-Google-Smtp-Source: AGHT+IFXzplSe4u+mbhEwrQ0KQ0Y1/Cj83mGXAf+vM2k299VHADZTlmvLLleGjG1OdzkIjpjb5uYiw==
X-Received: by 2002:a17:902:ce0a:b0:220:c143:90a0 with SMTP id d9443c01a7336-2242889f501mr160867805ad.24.1741474757155;
        Sat, 08 Mar 2025 14:59:17 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-224109dd627sm51945745ad.50.2025.03.08.14.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Mar 2025 14:59:16 -0800 (PST)
Date: Sat, 8 Mar 2025 14:59:15 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Kohei Enju <enjuk@amazon.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Kohei Enju <kohei.enju@gmail.com>
Subject: Re: [PATCH net-next v1] dev: remove netdev_lock() and
 netdev_lock_ops() in register_netdevice().
Message-ID: <Z8zLwzMl1wU6va7d@mini-arch>
References: <20250308203835.60633-2-enjuk@amazon.com>
 <20250308131813.4f8c8f0d@kernel.org>
 <20250308144142.4f68c0be@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250308144142.4f68c0be@kernel.org>

On 03/08, Jakub Kicinski wrote:
> On Sat, 8 Mar 2025 13:18:13 -0800 Jakub Kicinski wrote:
> > On Sun, 9 Mar 2025 05:37:18 +0900 Kohei Enju wrote:
> > > Both netdev_lock() and netdev_lock_ops() are called before
> > > list_netdevice() in register_netdevice().
> > > No other context can access the struct net_device, so we don't need these
> > > locks in this context.  
> > 
> > Doesn't sysfs get registered earlier?
> > I'm afraid not being able to take the lock from the registration
> > path ties our hands too much. Maybe we need to make a more serious
> > attempt at letting the caller take the lock?
> 
> Looking closer at the report - we are violating the contract that only
> drivers which opted in get their ops called under the instance lock.
> iavf had a similar problem but it had to opt in. WiFi doesn't.
> 
> Maybe we can bring the address semaphore back?
> We just need to take it before the ops lock in do_setlink.
> A bit ugly but would work?

I remember I was having another lockdep circular report with the addr
sema, but maybe moving it before the ops lock fill fix it not sure.

But coming back to "No other context can access the struct net_device,
so we don't need these locks in this context.". What if we move
netdev_set_addr_lockdep_class() call down a bit? Right before list_netdevice
happens. Will it help with the lockdep?

