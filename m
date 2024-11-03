Return-Path: <bpf+bounces-43822-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 21CCA9BA34F
	for <lists+bpf@lfdr.de>; Sun,  3 Nov 2024 01:43:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB2E7B22470
	for <lists+bpf@lfdr.de>; Sun,  3 Nov 2024 00:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17EDC45009;
	Sun,  3 Nov 2024 00:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gBQCMwca"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7F3433AB;
	Sun,  3 Nov 2024 00:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730594612; cv=none; b=UAXeatAifBXwL5PZGXZAfxHQUGtjGo8EdqlIGa7fbqGjhSMIbhKnSNDBvFFZkLJFn161NwOanuqJE692J2stk5ZPmq+a6X1lBaKFDeY1pNpyW1JYRX8FbPkmKzMXb7RtG24ZhP8kLf26RwiwQQleq7fh4Mytag6AMWnKvnGJ4Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730594612; c=relaxed/simple;
	bh=qAtWbPM463R/o/W5VOjeVKaO86RSprzz940/HfhTF8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MyTNB0nwOglVy2h9CoeqXaf00KXuCjxR0jsgkqwMXA86sfjlK/e+0SmdCZ9EALePrFoIdxdGKsuQnriJ8cDjP97awiNZ4EiB6xPbMcVonbsZ8Dx4OhWTcHBiQlcZcD25bgbzL6gt8qs0oh3Zl592GDcz/ALRLkYc5kpS99bTabY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gBQCMwca; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3a4e5e574b6so9908525ab.0;
        Sat, 02 Nov 2024 17:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730594610; x=1731199410; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pGLvLkcdLFVSoeiBjlwmwM6Qi8jMcLhmzQn2byV5v2M=;
        b=gBQCMwcannbNn2c76rX69Oe+c+O3uAmXxjBa95yG8LWtAx/FHRMQF4HVPbzaGUSBpU
         lqVfkNO0ibGnoU3qJ7iS/bv0FQuhYw/hNG177NLTzqyiJ21KgIZi7pa4xDM+Nb/jHVzZ
         gu5u9qGK8/3vnkSCc1wA1wAP5ZtVHV971eawSMZXTc0MyqgKBvNpFVvXAO3hpGqUjfAD
         HWloj4pmKMQIQ4JnJ8o/axiY9LevkJiVmwAx0Y0RbNMM03naiq5Dvbi9Xcm/S7VSx7zb
         SH3ejppjodBHq4aIrRb7ELrxxkhHCPMfNk/UHTldPuJuzrdCw2kzb0wukZ/ZEj6Ly5Ib
         LHNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730594610; x=1731199410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pGLvLkcdLFVSoeiBjlwmwM6Qi8jMcLhmzQn2byV5v2M=;
        b=jap0qmfwqsmor9LG1erh9YH7xgkUWHMMQ0Gss0+4orZBZUeNwPARpCJSCEk6LOWvnt
         ZLeSvZnDwJebHKFLUy/2Gz7VZOCxLQN7pswqYfC4ZMfglpPHoZvhAfNVR+LpXj8r//rh
         6wBs0JkjwJZNegDoAi7V4IEhvTC85JOIEVTVdygDoF3ONFkg8AUoZxxPwn4beB/HJO4f
         AbgaMqEZNAQ0ZwakMDNSpJcVQ1hs8I7TrZZqNzKD1gglODXDoZzC4SFFvMeQI0hchF+D
         q3suQ0sm4+3A/5dx5OnorLBnOjrW/rGHnXBCPoO21Q+fDxs1jPdC0OnfshQZoQayQW7n
         S6Vw==
X-Forwarded-Encrypted: i=1; AJvYcCU64W95oclQYk6GQVrE3NkHZSKGIh8YQ09Hlltvl4QDBDexMym4ShtYni3WjtQyINDEGSc=@vger.kernel.org, AJvYcCUHYQ2Gn3Cdf6BJIQ7wfD+BjevPfoSMkH97RMedULGsSWJuc9zdj2I0HFHzm4y97MIOy6Yt4uoU@vger.kernel.org
X-Gm-Message-State: AOJu0YwOuYxlGnGkh1cH4U6TpSdhEUIO660IIodj5mGOdYWM3LYSKkfb
	VPTB7r/sY0RcJSt2NUrqKrPxA2QzuCixjEGxGMl9CuRnHC8mx90YlBTj58mLIgszFjJHBGuTZf8
	xE/2l8Qa5999TQ1wke0PTEzYfO2wZ9Q==
X-Google-Smtp-Source: AGHT+IHAI9vNaUOAn4luaTmqk7CJNTEa2Q22FPRk4ZjmVLbmOhnEW94tOI3YVKclQbPa97KPJMEvkuwdWY4o1GiuODE=
X-Received: by 2002:a05:6e02:2168:b0:3a6:c6d1:8c4b with SMTP id
 e9e14a558f8ab-3a6c6d18d07mr12727105ab.3.1730594609841; Sat, 02 Nov 2024
 17:43:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028110535.82999-1-kerneljasonxing@gmail.com>
 <20241028110535.82999-3-kerneljasonxing@gmail.com> <20241102134357.GK1838431@kernel.org>
In-Reply-To: <20241102134357.GK1838431@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sun, 3 Nov 2024 08:42:53 +0800
Message-ID: <CAL+tcoDP+ZRSHou881eLDss0QjNVsgHmQ-ezkR3oOOAwxSbj_w@mail.gmail.com>
Subject: Re: [PATCH net-next v3 02/14] net-timestamp: allow two features to
 work parallelly
To: Simon Horman <horms@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com, 
	willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, 
	ykolal@fb.com, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 2, 2024 at 9:44=E2=80=AFPM Simon Horman <horms@kernel.org> wrot=
e:
>
> On Mon, Oct 28, 2024 at 07:05:23PM +0800, Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > This patch has introduced a separate sk_tsflags_bpf for bpf
> > extension, which helps us let two feature work nearly at the
> > same time.
> >
> > Each feature will finally take effect on skb_shinfo(skb)->tx_flags,
> > say, tcp_tx_timestamp() for TCP or skb_setup_tx_timestamp() for
> > other types, so in __skb_tstamp_tx() we are unable to know which
> > feature is turned on, unless we check each feature's own socket
> > flag field.
> >
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> >  include/net/sock.h |  1 +
> >  net/core/skbuff.c  | 39 +++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 40 insertions(+)
> >
> > diff --git a/include/net/sock.h b/include/net/sock.h
> > index 7464e9f9f47c..5384f1e49f5c 100644
> > --- a/include/net/sock.h
> > +++ b/include/net/sock.h
> > @@ -445,6 +445,7 @@ struct sock {
> >       u32                     sk_reserved_mem;
> >       int                     sk_forward_alloc;
> >       u32                     sk_tsflags;
> > +     u32                     sk_tsflags_bpf;
>
> Please add sk_tsflags_bpf to the Kernel doc for this structure.
> Likewise for sk_tskey_bpf_offset which is added by a subsequent patch.

Oh, thanks for reminding me!

