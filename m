Return-Path: <bpf+bounces-20958-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7052F8458AB
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 14:17:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1349AB274D5
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 13:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778ED5CDD6;
	Thu,  1 Feb 2024 13:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e3srPL4y"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED035336D
	for <bpf@vger.kernel.org>; Thu,  1 Feb 2024 13:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706793412; cv=none; b=NgQtbIWlsaJvQtZkPC0JlP8FmMmLsbzNPuSog3DQIhOBNuRSnYrrUqxfi07bmzij0xpM8UbQnN6O8w1yL+hTqu3wkCmlnthinzhNwpYYiJQORQIywUTj8erC4RVg3yezCebTqOY569HitJi1584zPqbJ/lSRKjVJonZQBGBPKvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706793412; c=relaxed/simple;
	bh=kp30w78Rq5bZX+y50ufBKmK09jl8Hv+JuF1UyHLrc8w=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HmFGTWR1SamM56E+Y5lwzI7gYtQY0+tAQNl0GktmwrwNLGmVpoxl0j2SO4a773WwJtUFRjBVdnBVFVWXAN0Iaal7UkunymESIvLewR6Vpz831YX6OI8cCeM+aktpvkHQ9BITDfasZpMuAoef+fk26PunPULB1C4jAgUItQPDZ9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e3srPL4y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706793409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Rx3YGDek1dkgFQfek97R4ZJsp6pRFV2jfyZSf1J5oho=;
	b=e3srPL4ywbk91qRbvmwX3Ud8UpQ0xYA/FEceX1UT3F8KiT0yr6wbyBRF/5uphh/hiJf+4Y
	TitPW4SlkF0d7VAmGQ9cUg+7CcibbGLqCdkMFpkRz1wtHzmAux8DQFJCP/7j58hvuJAk7c
	ZSrP43Yey4h8AI5R6M7i7CJP+QjDZa4=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-JWpM0jRNPdeUl-TP1TyrVA-1; Thu, 01 Feb 2024 08:16:48 -0500
X-MC-Unique: JWpM0jRNPdeUl-TP1TyrVA-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2cf51cafaf9so8722761fa.2
        for <bpf@vger.kernel.org>; Thu, 01 Feb 2024 05:16:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706793406; x=1707398206;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rx3YGDek1dkgFQfek97R4ZJsp6pRFV2jfyZSf1J5oho=;
        b=tYw/U37Pjzj/x7KeibmZYU0gHTgSmmLwR1BbByIyeCrddxhdXwM/iUHEpgnjg168Zs
         jpu4zyAqkeoOFL1xP89h9DWuqFE5QJTJFIA8i/lPeNED4kqOvtNocRIottq5VGfMkpWj
         eqfi3fBqR7vULSgLurhY6aqsZv713g5QMlO3HODr43en/kWzh+Kcq/Bwkq5jFW42OF8n
         slHzBY4ucmCvGnDKV4jRfyI8aBYsxA5BLKhgr/dgPa4Elkh0cQSYZL1WrSlDPQjyCRdO
         vuD631WXx463oMAG4uXdh0TrVjBupXHBCImCZDa6U4YCXT+sG37rfOYsxG2lrQwMgHWh
         3WbQ==
X-Gm-Message-State: AOJu0YwkcyRed/YEk6me1LFTgDnpKlxiStzhdIvn+uAbSOEf8KJ2/tfi
	AA6Mpd/t+Zw9H8EKD4T1BCTwRkcIzmphU2MWunKBOLaLmWyhXfR7trm6lEnai305MjxJBNObxvw
	k7LivJwjwFv31SfTpPHYIQWrduTUepM7JoUaq9zgDuQQ/4azWVyv6yIzco3eazwHhpRjUuGPo81
	XHHJri8unbpZsYfqpU+mShQrH+
X-Received: by 2002:a2e:7812:0:b0:2d0:7d59:8cd8 with SMTP id t18-20020a2e7812000000b002d07d598cd8mr616044ljc.26.1706793406414;
        Thu, 01 Feb 2024 05:16:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH+FpNwdjZjvOJTr7RBctIaCKWgkh0x+YUNOXkVD53hEf04n+gK6yetRxJ1antMonLqcujrx/8ZDwBxw/z0pEI=
X-Received: by 2002:a2e:7812:0:b0:2d0:7d59:8cd8 with SMTP id
 t18-20020a2e7812000000b002d07d598cd8mr616028ljc.26.1706793406051; Thu, 01 Feb
 2024 05:16:46 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 1 Feb 2024 05:16:44 -0800
From: Marcelo Ricardo Leitner <mleitner@redhat.com>
References: <20240122194801.152658-1-jhs@mojatatu.com> <20240122194801.152658-3-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240122194801.152658-3-jhs@mojatatu.com>
Date: Thu, 1 Feb 2024 05:16:44 -0800
Message-ID: <CALnP8ZaPsOLK-Xc8vkXMO13NT4t52u6PH9v0PcKWX8Yy8gLCXw@mail.gmail.com>
Subject: Re: [PATCH v10 net-next 02/15] net/sched: act_api: increase action
 kind string length
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, deb.chatterjee@intel.com, anjali.singhai@intel.com, 
	namrata.limaye@intel.com, tom@sipanda.io, Mahesh.Shirshyad@amd.com, 
	tomasz.osinski@intel.com, jiri@resnulli.us, xiyou.wangcong@gmail.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	vladbu@nvidia.com, horms@kernel.org, khalidm@nvidia.com, toke@redhat.com, 
	mattyk@nvidia.com, daniel@iogearbox.net, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, Jan 22, 2024 at 02:47:48PM -0500, Jamal Hadi Salim wrote:
> @@ -1439,7 +1439,7 @@ tc_action_load_ops(struct net *net, struct nlattr *nla,
>  			NL_SET_ERR_MSG(extack, "TC action kind must be specified");
>  			return ERR_PTR(err);
>  		}
> -		if (nla_strscpy(act_name, kind, IFNAMSIZ) < 0) {
> +		if (nla_strscpy(act_name, kind, ACTNAMSIZ) < 0) {
>  			NL_SET_ERR_MSG(extack, "TC action name too long");
>  			return ERR_PTR(err);
>  		}

Subsquent lines here are:
        } else {
                if (strscpy(act_name, "police", IFNAMSIZ) < 0) {
		                                ^^^^^^^^
                        NL_SET_ERR_MSG(extack, "TC action name too long");

I know it won't make a difference in the end but it would be nice to
keep it consistent.


