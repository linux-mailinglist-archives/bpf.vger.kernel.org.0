Return-Path: <bpf+bounces-47323-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2359F7D78
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 15:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4FD3162325
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 14:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC66D22577A;
	Thu, 19 Dec 2024 14:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HkYACPaw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A902236EB;
	Thu, 19 Dec 2024 14:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734620386; cv=none; b=cgLWA9Ecj75bt9sE1OufUJXp/AIhrzPFAtsDM2S0ijgf+S3/xggGCkfCUztQvJzEWOEHOEcQ3gYHQRoSrpODPNgN07MnamepyUUhuM+uSJNHCuqWf5d7/e52GvuVkbc4pSWJN0Sc9jAwXO+6n69LK8rsbIa4eu6NUnfMKjzJY/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734620386; c=relaxed/simple;
	bh=89ywEt1rJIP1x3Wfquf6BNGHFA1Yk24ndfvOOCuFVxA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jA7AZLK/yqZ3cBcpeAn4aKM574CUUR/oKPSxbBS+LYXedgJ0Rw8ntXkR9Pt64ezUa6cxl0U+VQ8c6xgZ7xW57DZPCixmn+/ThE4OrYpqYxxV3UQQkQX3iGikPddPqFVlv4YYYkH3MwuElwvf79kEudGVa0qDeC903SRoN0EvY6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HkYACPaw; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5d3e6274015so1380081a12.0;
        Thu, 19 Dec 2024 06:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734620383; x=1735225183; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=87+kcOO3C3Z4QKqAY62FusTuyMx6XYIDBwnLh87k2V4=;
        b=HkYACPawY8O7sbk5j7C4k4X/Dl3dulfOkvIgrUQ9/PRzwBcm9OApQNnezQgCOcYEki
         Qb0vX5/AdOV+BGNNU7fMxmMyTxMhoVQ2VQjyxLriKb8Us0tC0wOWN7Q0l0geZZauAkQN
         ovlNoIImyy45dGWoASy5eUI3aueQPPkZ+9fLKTa1eJeLyCafRTnlMLIIiMHYlKs4QF8s
         IaEMCVTsMW/9aYRTBdSH4o3Hz34eWJ22zS49KGI31dwYP233a2+aJLwqflcIXt8zgJqd
         xVv3DiT1QuJapHl++ZAu0LBSjCoL3SFYHneyNDCnyKcAax342n2d3GYHXzSLX4K+lqZz
         oGzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734620383; x=1735225183;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=87+kcOO3C3Z4QKqAY62FusTuyMx6XYIDBwnLh87k2V4=;
        b=RpcBdluRTFQH9rbggSlVG0qJ89w9lIaYCRix9NJOGxql0J3rp9Sr/zDQXQ41k95uwp
         W+V5W3ENTLJNoCz28aALwQscsxu7uTxWkRn49qSA3eGQ5Q4H5Bd54+pkcMcp2N2dK55b
         qPIEsCY+b3MTMo89Qik5ecS1pr5aBsUEaJCDHM3YO7RAMwjd+pkIM70vW2relABuZWh8
         nZKcf9WHTY0nn/qzKXx7VJ/CXGQlDhFq6cok085jwpjMbOD8Vgg6QfjvMXFR1IpYkH1Y
         d/3Zo1+IJgXK2j4iTwdHVNlpauaU7Wqo40VT4kvp//8k7SEemZK7Zx4dx9z8KGBHjT8W
         KGyg==
X-Forwarded-Encrypted: i=1; AJvYcCUVqaIt6os2cGTc6ZQPCFl4Xh3gl11ddoCZOpZC8FrZywVNIw3yJvRJk+I3gvSzO0yTBH9R10785A==@vger.kernel.org, AJvYcCVmtMv9mR7R9/fGmi5m4JmysXOJBQKiuU4Fa5bRPIdOG4IoFJqJJOBQU0Rz30ma6lHmE1s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWrVibt1y+710dXmLPH+UxifIpuVsTYQ3aVnmtkQsQ4W3HWqmT
	epWQFhmg0tdi9HCteu6cciXQcyZHmtNkf0ddEoTgT6gwfyEZDDgBdzx14g==
X-Gm-Gg: ASbGncu2UzSFtyPsRdKQzioiTnfEifs/h+yKPMAo1E+1OZ+NW2x/dg3z+oducUhcjtl
	wZbkdyyCh/esDDwRdyhyt4FCqp+tlj5/WYd2z2aDSulvnWcmCJUY5MqPUHIXelBJBj0wQJqNgVb
	LkewJ1WAR+0pBfJSaW4VkkXz8S3iHKKyfTsF6Iavi3rj/1a0HOjt+VEBkCjXnAFlT9V39eKl4gj
	nVZ2v1lRO6cIfTWO5ziMVvo4vYOotnqXlQdsjLwok1hBO5ALMuZBp6MFmZF+yye9i6d48bihWuM
	9fMOe9Lo+JgsbQjp63hVBtR2h+/A/Q==
X-Google-Smtp-Source: AGHT+IHSRkTHXTfkPF9DMRgN77s5DN0RqXhbFR/g15P335bpBQZ32Z6lKXM3IqLuAyKUYuEtQHsgLQ==
X-Received: by 2002:a05:6402:35c6:b0:5d4:34a5:e317 with SMTP id 4fb4d7f45d1cf-5d7ee3ef4c8mr7349588a12.22.1734620383119;
        Thu, 19 Dec 2024 06:59:43 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d80679f112sm727450a12.52.2024.12.19.06.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 06:59:42 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 19 Dec 2024 15:59:40 +0100
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Ihor Solodrai <ihor.solodrai@pm.me>, dwarves@vger.kernel.org,
	acme@kernel.org, alan.maguire@oracle.com, andrii@kernel.org,
	mykolal@fb.com, bpf@vger.kernel.org
Subject: Re: [PATCH dwarves v2 07/10] btf_encoder: introduce
 btf_encoding_context
Message-ID: <Z2Q03NER6RXy7YWj@krava>
References: <20241213223641.564002-1-ihor.solodrai@pm.me>
 <20241213223641.564002-8-ihor.solodrai@pm.me>
 <09f6bc335380ca73d365566de7af8f2e73ac9cfd.camel@gmail.com>
 <735014fda88330d2124f4956cc9a0507f47176db.camel@gmail.com>
 <yKpaq5zO0TcrAm1v3p4yd2D9ic0jGUQM0CUSg6CU_31_S1mX7SDljMf36ayteEV2O_MTE2eJkUuu3JoJWPQyIxHibe2zz1W3Uq_RzqiyPVY=@pm.me>
 <CAEf4BzZ-chyzJzCdW0AwjaxhO+yfUCO=Dcu+7=m96Ccyq94Y8g@mail.gmail.com>
 <af9404ef750f152afb20b2883aad3b9fc5e5a2dc.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af9404ef750f152afb20b2883aad3b9fc5e5a2dc.camel@gmail.com>

On Tue, Dec 17, 2024 at 04:40:40PM -0800, Eduard Zingerman wrote:
> On Tue, 2024-12-17 at 16:03 -0800, Andrii Nakryiko wrote:
> 
> [...]
> 
> > I agree with Ihor. I think he invested a lot of time into these
> > improvements, and asking him to re-do the series just to shuffle a few
> > patches around is just an unnecessary overhead (which also delays the
> > ultimate outcome: faster BTF generation with pahole).
> 
> Patches #1-4 are good refactorings.
> Patches #5-7 introduce a global state and complication where this
> could be avoided. (These were necessary before Ihor figured out the
> trick with patch #10).
> E.g. 'elf_functions_list':
> - there is no reason for it to be global, it could be a part of the
>   encoder, as it is now;
> - there is no reason for it to be a list, encoding works with a single
>   function table and keeping it as a list just confuses reader.

agree, with just single encoder object I don't see a reason for the
btf_encoding_context, keeping functions in encoder will be simpler

thanks,
jirka

> 
> Same for btf_encoder_list_lock / btf_encoder_list.
> 
> > And as Ihor mentioned, we might improve upon this series by
> > parallelizing encoders to gain some further improvements, so I think
> > all the internal refactoring and preparations are setting up a good
> > base for further work.
> 
> Not really, the main insight found by Ihor is that parallel BTF
> encoding doesn't make much sense: constructing BTF is as cheap as
> copying it. I don't see much room for improvement here.
> 
> [...]
> 
> 

