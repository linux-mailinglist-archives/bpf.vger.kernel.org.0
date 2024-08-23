Return-Path: <bpf+bounces-37949-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D73C995CDD3
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 15:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77BDE2809DB
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 13:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07A3187571;
	Fri, 23 Aug 2024 13:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="eOEteFvJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91270186E3B
	for <bpf@vger.kernel.org>; Fri, 23 Aug 2024 13:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724419789; cv=none; b=ZKO0STbqcVcmn+svPxCL8oIkkPkrpcXL75D2Ft1MPUImbKjbv8P5ZAdvkHdeOnBfSk3Tp/ds3sSTOxPJkYhdIqBu6WT8dxNfbY4Lur7kl4jEE5LtSPYwLBAfHepAkdpSLjb7HBU8yXHX2+Ja4+UrxlHZD1o8ZxlOWld7pbfbNPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724419789; c=relaxed/simple;
	bh=X9LwjPzhN+uJQCh4XWk9pbDdfJ5T1eZa5ETA6hy46Nc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GYTV4pBwIuU4Fzn3JnhHITs7gtCrgjeN77fGwM5mkoT1jyW2zCf++03teMRBFZJozGPyCh2B21TECtf3ghHmzZwy8kv+sFIPXCE4eJSrHHeZV5t5Hx7clah+xAYg6TOzxmogXTENKJgFxD9ro5lZwxifOFJd/cw/YWDdrIqrQrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=eOEteFvJ; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5bed83488b6so2589261a12.2
        for <bpf@vger.kernel.org>; Fri, 23 Aug 2024 06:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1724419785; x=1725024585; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=34ePrmT6ThCSMAVDOF/08UJdMTT0ZiO9ZyonmTHuBOo=;
        b=eOEteFvJIXchlLLKTVCuVUD8iR+ApTn2Qkg7MOqd3UwTgFRQ0YMaV6yAql6HdCvn2m
         +Gfeu2eYYOa5VxOuPCuv1Jp2v2j8bMq2QbHKIHR2X8Cufg/iDVsbaGaF7tl7Am2O/fOX
         RviJ2kfq8dL75PWmpdXQTxl9u3XBWzrww1nNZj8+eDMVV/Bb8LZUDkWborE8xXwyINNA
         FBlRoWri4HdpCsnRkWQx6sMlEF43xxGK23fZ8Cu3iOas6F+6SVvsPYe+T0yZ4Go8UqcI
         FMAi0c8pjUTWeMHKtbYwqi3fjCVwx5fbG0vsdkQX/yXMhyaouBG2KHq7LvZFcKqxHTWv
         Bqtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724419785; x=1725024585;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=34ePrmT6ThCSMAVDOF/08UJdMTT0ZiO9ZyonmTHuBOo=;
        b=mT75ssp0QKJfo7kLl+A+aunxu60vnBZMi+9RXdGV6PYkyKa2Zz1Ix4oO9SJSyJ3IeU
         yp1uRlmmi+Bh5lUt6jFsAXhpTdJyanfU9HnNv9NUlnfx6+bPbBQtidcqYdiIbVA3YY8d
         nRDOw/laZO8sq5fxgiEys6sYAe2w1vtnEtGiN0NCc7Gu8Fl3R8OvzP5pCQ7IlxwQAJEG
         /xOQ6aENy7bmJP9sWfuOXm2VZM74lEI6wB/P2Wv9Hsqsw+y0GTYFndgC/biLnqPX1ggF
         vF4Oj5Zab0NMiMQk6gtPoQ5R+wOLbShwVgNHYoG9AnEc0kj9148TdbghiuYF7oktzlw4
         5qqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXAO5afq8vjammd0z+JEKO9tOXxM0Gt6VrefR8KXQEFvWIznEcc3dOrMmXzLDa7isuUhFA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9qGz/utbsdEX5TGfCdxMjCYP2ENCNhlP60297Vi1hHmiQNJgz
	N8NsNeQXwStUjNFe/PIC6QA8nkz7I+JO4xz0WGyw7f2UxTZd2MR/ZWUQVQbrUwQ=
X-Google-Smtp-Source: AGHT+IEYo5sFGQI+9l4/IiJwriviRXNovEkCQk0pf3xWtH80ArYe1Esf/M6ITiX8QAhka73M1v+RLg==
X-Received: by 2002:a05:6402:3549:b0:5c0:8d62:bc9c with SMTP id 4fb4d7f45d1cf-5c08d62bea7mr1232778a12.6.1724419784285;
        Fri, 23 Aug 2024 06:29:44 -0700 (PDT)
Received: from localhost (37-48-50-18.nat.epc.tmcz.cz. [37.48.50.18])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c0515a6342sm2110246a12.79.2024.08.23.06.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 06:29:43 -0700 (PDT)
Date: Fri, 23 Aug 2024 15:29:42 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Feng zhou <zhoufeng.zf@bytedance.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	ast@kernel.org, hawk@kernel.org, john.fastabend@gmail.com,
	bigeasy@linutronix.de, lorenzo@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	yangzhenze@bytedance.com, wangdongdong.6@bytedance.com,
	Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Subject: Re: [PATCH bpf-next v2] net: Don't allow to attach xdp if bond slave
 device's upper already has a program
Message-ID: <ZsiOxkd5KbbIIB6k@nanopsycho.orion>
References: <20240823084204.67812-1-zhoufeng.zf@bytedance.com>
 <Zsh4vPAPBKdRUq8H@nanopsycho.orion>
 <6d38eaf5-0a13-9f85-3a5d-0ca354bc45d5@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6d38eaf5-0a13-9f85-3a5d-0ca354bc45d5@iogearbox.net>

Fri, Aug 23, 2024 at 02:07:45PM CEST, daniel@iogearbox.net wrote:
>On 8/23/24 1:55 PM, Jiri Pirko wrote:
>> Fri, Aug 23, 2024 at 10:42:04AM CEST, zhoufeng.zf@bytedance.com wrote:
>> > From: Feng Zhou <zhoufeng.zf@bytedance.com>
>> > 
>> > Cannot attach when an upper device already has a program, This
>> > restriction is only for bond's slave devices or team port, and
>> > should not be accidentally injured for devices like eth0 and vxlan0.
>> 
>> What if I attach xdp program to solo netdev and then I enslave it
>> to bond/team netdev that already has xdp program attached?
>> What prevents me from doing that?
>
>In that case the enslaving of the device to bond(/team) must fail as
>otherwise the latter won't be able to propagate the XDP prog downwards.

Yep, I don't see that in the code though.


>
>Feng, did you double check if we have net or BPF selftest coverage for
>that? If not might be good to add.
>
>> > Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
>> > Signed-off-by: Feng Zhou <zhoufeng.zf@bytedance.com>
>> > ---
>> > Changelog:
>> > v1->v2: Addressed comments from Paolo Abeni, Jiri Pirko
>> > - Use "netif_is_lag_port" relace of "netif_is_bond_slave"
>> > Details in here:
>> > https://lore.kernel.org/netdev/3bf84d23-a561-47ae-84a4-e99488fc762b@bytedance.com/T/
>> > 
>> > net/core/dev.c | 10 ++++++----
>> > 1 file changed, 6 insertions(+), 4 deletions(-)
>> > 
>> > diff --git a/net/core/dev.c b/net/core/dev.c
>> > index f66e61407883..49144e62172e 100644
>> > --- a/net/core/dev.c
>> > +++ b/net/core/dev.c
>> > @@ -9502,10 +9502,12 @@ static int dev_xdp_attach(struct net_device *dev, struct netlink_ext_ack *extack
>> > 	}
>> > 
>> > 	/* don't allow if an upper device already has a program */
>> > -	netdev_for_each_upper_dev_rcu(dev, upper, iter) {
>> > -		if (dev_xdp_prog_count(upper) > 0) {
>> > -			NL_SET_ERR_MSG(extack, "Cannot attach when an upper device already has a program");
>> > -			return -EEXIST;
>> > +	if (netif_is_lag_port(dev)) {
>> > +		netdev_for_each_upper_dev_rcu(dev, upper, iter) {
>> > +			if (dev_xdp_prog_count(upper) > 0) {
>> > +				NL_SET_ERR_MSG(extack, "Cannot attach when an upper device already has a program");
>> > +				return -EEXIST;
>> > +			}
>> > 		}
>> > 	}
>> > 
>> > -- 
>> > 2.30.2
>> > 
>> 
>

