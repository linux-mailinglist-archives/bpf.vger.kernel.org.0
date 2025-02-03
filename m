Return-Path: <bpf+bounces-50310-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAFCFA2511A
	for <lists+bpf@lfdr.de>; Mon,  3 Feb 2025 02:39:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6689E3A4F67
	for <lists+bpf@lfdr.de>; Mon,  3 Feb 2025 01:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B399517C8B;
	Mon,  3 Feb 2025 01:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gRAtWn+d"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A4C35944;
	Mon,  3 Feb 2025 01:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738546789; cv=none; b=ETLaqen7cetnAEBpu45Wn+QmrRvsHWZr1Mdguaz0g/hqTJ7L4tg5rnDZJStV7lni66NjFEpfrzrW8+6BiG3nd+Nunhb8ad5rkdfN16hWAkR3cOlF5Yr7Mg2e3X2AhGAm+UYrIMZ/7vNtDQPD4oIaMNydw6HsTsGmgvwhpAdMbxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738546789; c=relaxed/simple;
	bh=/y6k81+zaNnSlojA9+tv0fGOmgCbPw3lTMpWbqBXuBc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Zhhi4rpKyv4Sxea41KvbSFdIzzJvVWmwEOCiW1mpSVryNB3kcJg+Ts/Zb44lkIQrX3poDgfBlCb/nIolxyGs6AWAluHzj3knAqJElp7hx1HRJtwq4t0Ndxtl7YO/oFgfvwNMvFRmHmECJ8aA4KHzvOw+XV30y39ovKvJo2JsTwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gRAtWn+d; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7be49f6b331so368070685a.1;
        Sun, 02 Feb 2025 17:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738546786; x=1739151586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rOWzjSFyTHIcf6LMOu1NrdiYYI4JP58h04qND62AjuQ=;
        b=gRAtWn+d0QLBTVwqMWfJZBRy6MnuuWsqSeSmGd48DTU5BypVkiB02222u+Rs/Pjjvg
         TDDiUfyI5G8FMaa73LOH3D1QOzAjPFteLT/rVI+3a+w6JeBbcGxQaAq+raQy8UOKT86m
         LyAensybshkcBMrksGNV5yjqYknZbTquzr8V7NELRzArs+2cLkcUg650yRbcL3TPJiGd
         Vm1u/9Q2r9IZD4w00Nf/e+UaakRqXHBbTQQAttgDTGBwvm65pEnzpISgc2Fftzooy4H2
         koJjI+8M4cG4NFj0cGySXxWNP7bHbj3tY3aqZp21r1l+EHOKZbPlhwhUWbWCnakY/Ddl
         n2+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738546786; x=1739151586;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rOWzjSFyTHIcf6LMOu1NrdiYYI4JP58h04qND62AjuQ=;
        b=gpQHJIJ53QhpIqkXvbAgJsL2I6zPVa5/n5tKmbENsQekKuVloRJ7Gsf5QeQd1Mr/h5
         AaY/+jJAy4KBYQ3mqtB82gFcxiwc4qDaTtAlRCa/pux0xvV1DZRsDek3DlgPh+mwQi4w
         lZQEj/SFjgahXX5B6gjcYzaCfifwpjFHCgqHdbOOkqbb0mz2wipWiNz1+4JAfQrRTfO+
         6iexeanc8Ek6CTpibV70L4+qXKZqLyf1Kn0qMhJwqqeAfsMk+/SWlXXm0gpaXlGD5eDc
         V2cRgVPDOJsgla7MZAqV6y7y7ehYipchTcpL8NUPAS7SamfKbBtSfvoxWSjsp/hgUMFt
         LHRg==
X-Forwarded-Encrypted: i=1; AJvYcCWUOeJ3dG8vmjdPbsMFYZTbQJIt31x2utcrXMOGz0+cK8bq8V1N86TWcMoe3VR0yBEe2yI=@vger.kernel.org, AJvYcCXBtkZItfDumpNMCHxENjC0WlDO7ugFu/oyd04yg3nOZUjK7cKvYeK3I5SxqJNSgso3f0A9BcYDCRLHR31d@vger.kernel.org
X-Gm-Message-State: AOJu0YygrUKttzYishkOjpNgvZchUtrYMVRxmUW4FGlpLAPnFq+hLa/U
	3i/hIR16sR4ReA0eACTXlhXug/ypFeRhpc4mdTQjK37za+thFbce
X-Gm-Gg: ASbGncsOf+Ak+2fhsKLLu5sa8GgdqCZQskC6LYK/JQizVO3v4/U+QNHa2rIW2QG0wt6
	prTtfohx8CBrnayUdnDFu/I3fhPBqOq9lvujZrEGYsjDg1BTQII582h8ymrkECJr421hL50aJ/I
	NXhEtI05ZtEujsQCjvrO76wHLcLD9l947R099hHPecq+9rsqNbm37/Qjc7OlzhVLhKMoLd3iLnQ
	ar6oan65UlhIeGWaHqX56KV8mbt8XDM9pAEJo4BzQh/jfSRxgDR5gHqdE8Q6dJpVRWgbN9QgF6D
	LKIbx2ERZulEd0mTTFgulYkkvmOnI0JYhUij7fFK9CDIyNCZx0brFwCf75+eJaA=
X-Google-Smtp-Source: AGHT+IGfoEhAbfzxVd2bQSUt84oOn6agnOvwoEG69chfiMNlVMXtcWns6kgBNh1e0mL2sr33I/qYbQ==
X-Received: by 2002:a05:6214:1302:b0:6d8:a5f7:f116 with SMTP id 6a1803df08f44-6e243cc11acmr301853246d6.42.1738546786498;
        Sun, 02 Feb 2025 17:39:46 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e254814405sm44826206d6.40.2025.02.02.17.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2025 17:39:45 -0800 (PST)
Date: Sun, 02 Feb 2025 20:39:45 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>, 
 Stanislav Fomichev <stfomichev@gmail.com>
Cc: netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 jasowang@redhat.com, 
 andrew+netdev@lunn.ch, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 hawk@kernel.org, 
 john.fastabend@gmail.com
Message-ID: <67a01e615bdb1_3c12af2942f@willemb.c.googlers.com.notmuch>
In-Reply-To: <67a01caec79d1_3bbd8e29416@willemb.c.googlers.com.notmuch>
References: <20250130171614.1657224-1-marcus.wichelmann@hetzner-cloud.de>
 <20250130171614.1657224-2-marcus.wichelmann@hetzner-cloud.de>
 <Z5wIZ2LAjz0wTWg5@mini-arch>
 <a1120039-b0a6-4882-be23-7ea1174f8ab7@hetzner-cloud.de>
 <67a01caec79d1_3bbd8e29416@willemb.c.googlers.com.notmuch>
Subject: Re: [PATCH 1/1] net: tun: add XDP metadata support
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

> > >> +		metasize = metasize > 0 ? metasize : 0;
> > > 
> > > Why is this part needed?
> > 
> > When an xdp_buff was initialized withouth metadata support (meta_valid
> > argument of xdp_prepare_buff is false), then data_meta == data + 1.
> > So this check makes sure that metadata was supported for the given xdp_buff
> > and metasize is not -1 (data - data_meta).
> > 
> > But you have a good point here: Because we have control over the
> > initialization of xdp_buff in the tun_build_skb function (first code path),
> > we know, that metadata is always supported for that buffer and metasize
> > is never < 0. So this check is redundant and I'll remove it.
> > 
> > But in the tun_xdp_one function (second code path), I'd prefer to keep that
> > check, as the xdp_buff is externally passed to tun_sendmsg and the tun driver
> > should probably not make assumptions about the metadata support of buffers
> > created by other drivers (e.g. vhost_net).
> > 
> > Thank you for taking a look, I hope things are more clear now.
> 
> Please use min()
> 

Err.. max.

