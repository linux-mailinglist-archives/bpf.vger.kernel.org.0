Return-Path: <bpf+bounces-79240-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5130D30903
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 12:42:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E6E130EF9B1
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 11:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC8937998F;
	Fri, 16 Jan 2026 11:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CXWcJpKc"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2982337B8C
	for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 11:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768563545; cv=none; b=P3wyplQ1xBFtP9sIauI/tOIZkvkzmKyEGPkfESpbEJq4aEVUXmlBhA3sJKDyCA4KSWUw2k33GA5+6so0R7awhnumb3Z83L2/cYlQs8xvEdp8Hd31QOJx0kbBsJm982VEJJls/VWPNwJwX+CkSYcNaW4OsQcjfS5nwmT6on6h5Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768563545; c=relaxed/simple;
	bh=tgJim6hB1zWMV8KvYyrCnvmxAJ5H9/5bCqGIpPk10lI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FDVIjsIOCrv/+UdTwBJl23iB/RSEPEFczM3BN9K3qvvO7WIYX11irxFY07olYTO/dg6+69Xbfp5LwTHyvwYyq2S/NljbodOoi2KHGQTVYmtrmvBrQqVWUR7UUOprO9ztE1QNK+LyjMlfy1pb+C88RE04el0mxha+wRoV3ulpcLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CXWcJpKc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768563543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tgJim6hB1zWMV8KvYyrCnvmxAJ5H9/5bCqGIpPk10lI=;
	b=CXWcJpKc2yxJzLhD6TaE2T92ozkcx6xv5LL+nDshA8tnUl7AHO4B6VENl3Yxwk9nOt2Xg0
	yjATNNPl8M34ln1y6XjEVspEjfAZWstLHG0ouF4xRCiyESOxKZEMscJ+fGFS1Vq0R2p0Ke
	Cot869MAxxHKj8VipwYqJv4AQTGwjBU=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-09YAFWpCMpONik5rGp6u-w-1; Fri, 16 Jan 2026 06:39:01 -0500
X-MC-Unique: 09YAFWpCMpONik5rGp6u-w-1
X-Mimecast-MFC-AGG-ID: 09YAFWpCMpONik5rGp6u-w_1768563540
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-38310a79f92so11479161fa.3
        for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 03:39:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768563540; x=1769168340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tgJim6hB1zWMV8KvYyrCnvmxAJ5H9/5bCqGIpPk10lI=;
        b=qLXuQx+B39/2RAqxX0LXwEscQLY/hMhxBsbO/sU70gZcDY3G/Rlb9D63/ndSnk1I80
         Zn77ArTJXvdKCDF1djQ1NYWOwmBTnzbrK+i6yveuhqAIni3uJOxyCTpqylmYZvLvtmO0
         uPuvHWGfhfGDE7n02mEbcucDsAd5rKlcUfc1byzr0bYncVzbt+N2mqDGc7DvCZ/sIMuV
         9XJgKB16PME0H5f9xohTg9h/tWqQIGM541gu/BZsoy3tdKAP0jFMiU58wOEdbqmmcq3B
         4ueN9teNt+UGENEObWY9QwT0EpFJJv6fnVFVHsCKmiqBbeg9uQfMJEzWouk25vz7Uzfr
         UCkw==
X-Forwarded-Encrypted: i=1; AJvYcCWBeLKxS0Aubqqh7TzdzRF72VuagcfCw3U+tKwla4s4B2C7JVkqJuGHQYvdVRAVfmUscHA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTXlMscd+wm6AGjA1LxI2hlXu9Ghd9sYlk5wPU075hzeUcq6Bj
	mMvxpKpAVrqRr0xxVni9+jpx55B2W6RmdBwMyVZdU+bZSAnpMmJIHOyHhSFbmL0mSh4aibkTAFQ
	+DUaXxlaKGPtQuRf4esZ8JSaDEHNw6d8JVQtycHm1QeYZoI1FZV7ozDtWOxb6Z+9ApxT44XrmeU
	LZiE8Fo6DJb+aY5cfLKYhuTt4lxZ/K
X-Gm-Gg: AY/fxX7LAc1tHdwPVJNjK3xNNx5X5mCANeY6EqpUT8e3A73jHaX3Buz1vjdD4cBioXH
	6wyvrorqaElogPsZaz88IuIdv9cXPs7uAPuIlqqR6xr9ietPGh/F6JgV5Tnh/EnjP9IrahH/h9h
	h84yPGgFzxdMseOQmJ5hWzc4mI8uAPf5E5BcYM/fJSQQd0Sj7x4Lt4KZRaZ7i9yvjUaz5S31mgo
	mLF5jTJFTsb+8fqSxWnd5O2FTNf0b8NO3jfDbgcmGFYSBf3AkTEGaiItzdqkOFNll97Rg==
X-Received: by 2002:a2e:b88b:0:b0:383:5ba0:946b with SMTP id 38308e7fff4ca-383841473e5mr8403451fa.6.1768563540261;
        Fri, 16 Jan 2026 03:39:00 -0800 (PST)
X-Received: by 2002:a2e:b88b:0:b0:383:5ba0:946b with SMTP id
 38308e7fff4ca-383841473e5mr8403251fa.6.1768563539835; Fri, 16 Jan 2026
 03:38:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115163650.118910-1-wander@redhat.com> <20260115163650.118910-4-wander@redhat.com>
 <CADDUTFzD6WTg8=b+4v+Rw_LAi7MmmVPPVqoSws9rZYksd5dn_w@mail.gmail.com>
In-Reply-To: <CADDUTFzD6WTg8=b+4v+Rw_LAi7MmmVPPVqoSws9rZYksd5dn_w@mail.gmail.com>
From: Wander Lairson Costa <wander@redhat.com>
Date: Fri, 16 Jan 2026 08:38:48 -0300
X-Gm-Features: AZwV_QhPKPQvt7QplWF66df9610d4G1tzMhTbMFKHRmJT44PCxmqz3w_KIgAD2o
Message-ID: <CAAq0SUnszAF8HXK6Knve+V-r97otAxN2FnM-8mNt4Pvh79pFug@mail.gmail.com>
Subject: Re: [PATCH v3 03/18] rtla: Simplify argument parsing
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Tomas Glozar <tglozar@redhat.com>, 
	Crystal Wood <crwood@redhat.com>, Ivan Pravdin <ipravdin.official@gmail.com>, 
	John Kacur <jkacur@redhat.com>, Haiyong Sun <sunhaiyong@loongson.cn>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Daniel Wagner <dwagner@suse.de>, 
	Daniel Bristot de Oliveira <bristot@kernel.org>, 
	"open list:Real-time Linux Analysis (RTLA) tools" <linux-trace-kernel@vger.kernel.org>, 
	"open list:Real-time Linux Analysis (RTLA) tools" <linux-kernel@vger.kernel.org>, 
	"open list:BPF [MISC]:Keyword:(?:b|_)bpf(?:b|_)" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2026 at 6:47=E2=80=AFPM Costa Shulyupin <costa.shul@redhat.=
com> wrote:
>
> On Thu, 15 Jan 2026 at 19:25, Wander Lairson Costa <wander@redhat.com> wr=
ote:
> > To simplify and improve the robustness of argument parsing, introduce a
> > new extract_arg() helper macro. This macro extracts the value from a
> > "key=3Dvalue" pair, making the code more concise and readable.
>
> Would you consider using getsubopt?
>

That's a good idea. But I would like to defer this to a following up patch.

> Costa
>


