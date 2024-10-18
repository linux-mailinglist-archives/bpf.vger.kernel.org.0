Return-Path: <bpf+bounces-42353-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0AC9A31C6
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 02:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A04C91F249CC
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 00:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB89481A3;
	Fri, 18 Oct 2024 00:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bn4GOA3b"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857B62A1D1;
	Fri, 18 Oct 2024 00:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729212388; cv=none; b=uUNmRdeppmVorp0ZHwJskEutWqCyK+ts7WWSG2DyOSgXkhIshQNT8xDggsrzlRZ+tQ689Xm2CfaeWZrD6E/e0Q1XXURSHOQFkET39tC37l6J/2elLxLYpUSN+D22Z4PaERpKwfWVNsPwTffSDeJe6OgqkqrhDasY3KQSAfrMWPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729212388; c=relaxed/simple;
	bh=A9W5BXqJLzSc6wqaDftNTLmM/XjPL1T+K9gE4lzY9eg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O8gtDiOliKKlFQXAg+lqVPz6xLDxev1IGy5lI6j6bUTKrzCZ2zV/4+cGChbiTS64NU6Rl99eE6mQdHk3ExBjftYdaSKWampbL/RQaxhU9adHLGxj8YTjW/UKzR5Jjauto8N1AgLH6U5HD8oTbdzmpqhgxFJgTott00kk0/NpGm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bn4GOA3b; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7ea784aea63so909546a12.3;
        Thu, 17 Oct 2024 17:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729212387; x=1729817187; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RVunuq3gbvj+AkSw28J9IAD2E6K6krV4ZjRY2oiq+QY=;
        b=Bn4GOA3bJHOvp7OuqZK5yyXMrwE37cypyWQ06BXwWvKRfSKaX6Xe8ag9CjjucE2Ylx
         HLfQ297Wz/3BknAkP/T7dqM9qUVDafjvf/x/KvWUUWbm2QckRl/NZG0f2OYMMhlTjDWp
         3qYy3lacBBarJmg295j/BwOVPi4ujOtnx6qPwR/tffSDJYYg+hhUzYlUwBqXNVJhlmsB
         +ZNY8/884aM1Zi3YSEJ463Z9SBLGWYNwJfnXS0q5pO4wMH/bwGa0Br8mdmdx7hKLxJvC
         Ri/5qJq5Vo1ZihR/AANC7vp/ABB72H2A22/GF9owJZF06q+u6lO4kEpYRQKuU7pTu6Hu
         w+nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729212387; x=1729817187;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RVunuq3gbvj+AkSw28J9IAD2E6K6krV4ZjRY2oiq+QY=;
        b=mk3voFCHNBqCD+aAHjzDWz/PmatIQhzvxSrIexw340aKB+yeF4e1740f7qsSR2WIoG
         V+76wsgU/L0qI+Nq/WadnpCVe5p9OpKcKX2t8nH9zkD3ZHBpJ4hZNIPDwF8zZSX0R1+n
         ke0pBOSFATE+hQaauU8uJvaOGN+ppxL+4kt2TaIFI1K1OVIFGio6KQ+1AjbGFhkPq9MG
         DsC11UyjbxZK7atsHObWI9BnJTExJyVuYN9jaVHy8vunBoVvSynSyBL4JmsjaL4St04Y
         Ugv59bUkz59QVpAkU39sFcjCFqy86uoHKLM8s3VttQedQ4pSCf3g0izY8OFuq7ySRocr
         5VPw==
X-Forwarded-Encrypted: i=1; AJvYcCUGrNUD7dYrsJ1ATSFlgvG549GSWMr0RLNYHUxSzl6iagvhUrt5RN5mJTyWp41e9FdzNjrOEJNBa+r0@vger.kernel.org, AJvYcCVSZFVc4N7kkWkyc+CHHU43yAV1quyfFIeOyou8o2cBJzWpWVYuWortRmpaXWB0VZMwt7zr5UQ/THAXMZ8/@vger.kernel.org, AJvYcCWdLBdoKQHPyE/Er52MyRYT2GrLlrjs7Ijbb5qdDu6FruhmNZ3B7arR9rJPw4FJp86tX14=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1+7TkMMeHKPztVjA52i8gLxi8Nb4TQ4AJHDlwY4OZCgCB638x
	lxS46uzz1uuROGWbp2XtD9QgVp4b97yzueoixDnS5pk57eIwaDJJLeF6zWWUCzo=
X-Google-Smtp-Source: AGHT+IHPg8DRZc4blkJt6M4jB9p7QkQPgZeoQK6vx6eapZG8GWX01nJC76zgSI/PBpyyXXHR6o9AUA==
X-Received: by 2002:a05:6a21:1693:b0:1cf:4ad8:83b9 with SMTP id adf61e73a8af0-1d92c5abf0dmr1004985637.43.1729212386730;
        Thu, 17 Oct 2024 17:46:26 -0700 (PDT)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ea3459abesm271817b3a.168.2024.10.17.17.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 17:46:26 -0700 (PDT)
Date: Fri, 18 Oct 2024 00:46:18 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrii Nakryiko <andriin@fb.com>, Jussi Maki <joamaki@gmail.com>,
	Jay Vosburgh <jv@jvosburgh.net>,
	Andy Gospodarek <andy@greyhouse.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: Re: [PATCHv2 net-next 2/3] bonding: use correct return value
Message-ID: <ZxGv2s4bl5VQV4g-@fedora>
References: <20241017020638.6905-1-liuhangbin@gmail.com>
 <20241017020638.6905-3-liuhangbin@gmail.com>
 <878qumzszs.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <878qumzszs.fsf@toke.dk>

On Thu, Oct 17, 2024 at 04:47:19PM +0200, Toke Høiland-Jørgensen wrote:
> > diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> > index f0f76b6ac8be..6887a867fe8b 100644
> > --- a/drivers/net/bonding/bond_main.c
> > +++ b/drivers/net/bonding/bond_main.c
> > @@ -5699,7 +5699,7 @@ static int bond_xdp_set(struct net_device *dev, struct bpf_prog *prog,
> >  		if (dev_xdp_prog_count(slave_dev) > 0) {
> >  			SLAVE_NL_ERR(dev, slave_dev, extack,
> >  				     "Slave has XDP program loaded, please unload before enslaving");
> > -			err = -EOPNOTSUPP;
> > +			err = -EEXIST;
> 
> Hmm, this has been UAPI since kernel 5.15, so can we really change it
> now? What's the purpose of changing it, anyway?

I just think it should return EXIST when the error is "Slave has XDP program
loaded". No special reason. If all others think we should not change it, I
can drop this patch.

Thanks
Hangbin

