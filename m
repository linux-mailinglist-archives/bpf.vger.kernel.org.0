Return-Path: <bpf+bounces-55692-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85071A84E50
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 22:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B16019A5BFC
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 20:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505EA290BBD;
	Thu, 10 Apr 2025 20:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="zp7u0iPT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4914D1FAC4A
	for <bpf@vger.kernel.org>; Thu, 10 Apr 2025 20:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744317685; cv=none; b=rEgQSQU3muLlWdiaMP5pjIN3LhmbPcEnavGt0F+rOYVoBh7DgnnPNAp0J1JLgq3LxJVueeNswom23+qbSJmhKrbm7QbaEpvtLCcDAnNu7cOzf//TAWJwTwwe+4zRgAyaahpMX6fpUj68iMh93OTNHteUVJ0s9OJSu+KYmlFod8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744317685; c=relaxed/simple;
	bh=1VfuYMsDYjXP/fHhnhem438yCG6+X0vawx4IwXjYLZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P/pQVRyHWB224o+CLkCpVjj7/82e3uNBJADO+9woBu50AUBOQxWGtJs9zKg2rp1HEyxJL/FzgCWseQSnC0x1xEy8D7bDpuDJjQPNRN+LyuRoHe336Oh1ySL6q8LYIoWCYp4K76T61AgVUuc69r01FHBz6jFZ7A/SW/TbIvOiyHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=zp7u0iPT; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6e8f8cc22bcso1342966d6.1
        for <bpf@vger.kernel.org>; Thu, 10 Apr 2025 13:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1744317683; x=1744922483; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1VfuYMsDYjXP/fHhnhem438yCG6+X0vawx4IwXjYLZA=;
        b=zp7u0iPTbmjyXgi1dvJUan1HEthMQgIPnTygh3JQCTfM112+Zf0DQ1UrMsLcjGXrSW
         2XmT8tsPl5ISgpBgCW5FQ1nLLimBnQezXfWX1mHF/+r3bMIcI3TSkXyG2oR+8yL64YlR
         wX4aVmsXiyHQg2qF6oNL4NfYBl/ylkcyJiVtemfu7PQU4J2okp5XRiF+N22UA++/U+K6
         u+ItclgwBzNHgsORQn8sybQLLviFV2XUrmsM+gieJnkIRb9ny7DBZSa+Va3/FxNQPoj7
         aSU1L5cwRQPACEEv1GpPDt2n6gLTcvHrii62It5an67ZpHkofAvfvPykV5R8RDzIGvir
         +cAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744317683; x=1744922483;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1VfuYMsDYjXP/fHhnhem438yCG6+X0vawx4IwXjYLZA=;
        b=GWAmSb9QMFr7h3AmXCHuqhj6PCuCMCQdRXfsYhymmJlLOfcT2jj9zWlhTVseHtWjtt
         kfpXZoPIGNWjg7T1DtaHDrOW7VQ/S/fvVsFhGUElBA1rXFaUIAcYZ4YpOLAmTiOknq1H
         b8dZ+4LMGh2qnmI4xlNlGeji0+02S6tuoH+p3xL9RizWMGLEqvrGUX3bz8sbH1RqMDDs
         5BN7u5OMUbyzG2d7Xoby8AyRN/rJ0K7VEsbj0I+ttacR7GVq+AJNuerFraF82EhnyITO
         TpRkqcvlKet9AMQao+5naVWRwXqY2g+jrU7wgumTa1tWL+IWcDgiNoX4mxQl//xdJbUL
         3rBA==
X-Forwarded-Encrypted: i=1; AJvYcCVGYR40vPEhnbIunVIYwgaE31BUC0bzObqEM+Fojh8S0zDGC0A0L3rCrIfLDAIdzIEaSu0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeHQQN+2ujqQ+4rXH6KmPRr7LdZW82odgrCt0nOmJstI0b1aNj
	UTuhVILW/RHrkiUhG873BdoMBgz7vRX8qpYcifxGZRACqJcYYCbajzIX3hox+8PaU/jzeOoyqVw
	lylMUJo2ys6E54WO7QMG/ACLw2AXpesGqL4bsUMIudiTeHmWVeXs=
X-Gm-Gg: ASbGncsY+DJ7xmNUqGFz0c7hYjCiTWviDamTtSBJu10f7/LKm0j8p3sMty496GCI0XU
	TfQ60cOscGrARb76ofqQeyIp0pYWtAdc2UU+LXV6sto19Ha4SCjjrIA2XCgQK3hVF8k9oSFWiqU
	/+rX7Jziqt6YBWajz1WqifyN5WyQFLs2XWBZh47TzNTekhSAjQ9vjbpc16iBY4UqiLCQ==
X-Google-Smtp-Source: AGHT+IFBlBXngPSSfXl1oYgUaFZeia9+FdGEdDZkF/oOJJJtPwRXqIpDSem5F/1LVxF8boATdv8onQUgOvspqX929R8=
X-Received: by 2002:a05:6214:2341:b0:6e4:4034:5ae8 with SMTP id
 6a1803df08f44-6f230d6cb13mr1827626d6.5.1744317683168; Thu, 10 Apr 2025
 13:41:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409182237.441532-3-jordan@jrife.io> <20250410202214.7061-1-kuniyu@amazon.com>
In-Reply-To: <20250410202214.7061-1-kuniyu@amazon.com>
From: Jordan Rife <jordan@jrife.io>
Date: Thu, 10 Apr 2025 13:41:10 -0700
X-Gm-Features: ATxdqUHVVlU7Wych9XoEDAx7bBQOWn_7AjvU5s2ITBzUq8wPn6_NmwRE46PoXIE
Message-ID: <CABi4-oijZi-=OajSPtSth7HBFUR5_QtsWtmck+v_=2Ge3H916A@mail.gmail.com>
Subject: Re: [PATCH v1 bpf-next 2/5] bpf: udp: Avoid socket skips and repeats
 during iteration
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: aditi.ghag@isovalent.com, bpf@vger.kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com
Content-Type: text/plain; charset="UTF-8"

> I'd put this before kvmalloc_array() or remove as it's obvious.

Sure, I can drop it.

> The 3rd arg is missing sizeof(*iter->batch) * ?

Agh, silly mistake. Thanks for catching this.

-Jordan

