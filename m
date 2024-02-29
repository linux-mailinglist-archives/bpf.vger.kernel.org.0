Return-Path: <bpf+bounces-23056-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 278E286CEE7
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 17:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BFD51F25801
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 16:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2568970AD1;
	Thu, 29 Feb 2024 16:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P7c9YezP"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7B370AD4
	for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 16:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709223575; cv=none; b=evulqCmm8OaOgeZxIgQt6QwEFxMvvP0BFyYn2a0EEeDx4AuD0X9o6Kutaga6+enFDS6nFAIuyfcWUYVlA/r7bIWkvuVzbIbEp8tXEd5x+/+7B3Zj9LbgL03Ex3dkkkcG11z345odgXIPqvINL1N4YIE6BaFwWzP8CBxJFLxCJjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709223575; c=relaxed/simple;
	bh=QBa/wOClEp+2yPTYdwYoo6oCDpfcgDEt3eqn5qGQbBw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XkdJjNz3gVpEINYP67QmxDc1+6st1GVRfUU22Z5Se++r9lKn8C15BiwBpi8bwqG1uiHq6MuUjqslX5NRIxWZ1lHKnemxP3W6sd3EBmLbHKJksJ6BZ12Z+vug06YhBpS4frWBCwRXsKiy8jPj0/McNPaX+P2uB9ahDkZbBkIcFG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P7c9YezP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709223572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=wQOf5VIg+YJ18LjXaJznkIrd5x43ZtHVjkC8OKor1X0=;
	b=P7c9YezPTMx1QE0P9iOPYR8kquwwfpAPOymcGz3Go8RS+PPrm7EstWIifSV4Lg9NXBx6Hi
	xysQJlBUvUjqS0xC9PCkD6PEo+W8XPek/4Hkk+qb61YcpQmYlrDRIEHCXdbL0tt3nNmZ/T
	g5zVmpRW073Py1brdDOWL6MEdISGMsY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-3OqwLLMTP66XRALZqqt_jA-1; Thu, 29 Feb 2024 11:19:29 -0500
X-MC-Unique: 3OqwLLMTP66XRALZqqt_jA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-41293adf831so1780725e9.0
        for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 08:19:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709223568; x=1709828368;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wQOf5VIg+YJ18LjXaJznkIrd5x43ZtHVjkC8OKor1X0=;
        b=BTls/kFNaYu5LVVUJprL88FAZeNnXriDpsD9lpViS62BDIr7OyR+Abkonqk/clkwux
         xmaOWueHB4NHAaUtrfHiazjhictOjvzuERvIJU6PybZ2qEo3Au8kW3aJ6E9posMCJe/e
         w9Dj0AaqYh8mx7N5kHiXu8ZGp+nGovkXV0x3qY0J3RkDqNHJ2hOll6/wIw/+k3cG/ALH
         HKj7yvP7SYkBxMkacUE5d8SQBkwTwBg5LBp2HTYZ/XdCHqogWxyivZrylpzNN8ko75Lr
         5JtQoku7Na2yr2DglHYPHlkNOpksPkd7QU2CC4XwoZdkJfGjyYX3r4riN+una6aj42Se
         VOBw==
X-Forwarded-Encrypted: i=1; AJvYcCX94BM+TYMoBSRPaSDEIhF/PUtq1TrzXW3M3+GqoycjuQBWxMfbMf8pK5jeomfHq+UmILR8KG6+kkAFFMeX30v9BasZ
X-Gm-Message-State: AOJu0YzqVSTrytxCH0f7bcTKvNJ7bz9Maygj6CLAgNNk0FotcbhbNi1F
	u5zB5X7ranbta7EiGWHlJy6Sv4LA5bazw5cvWNBXe23g2WAI7t9F1stGUef4ZzC4zmwtyt6qrte
	UjcamHb/biYCKSzqGuwUIr5e+UDRHBW+FCMjebk2xLtRQn1F6Og==
X-Received: by 2002:a05:600c:3b82:b0:412:94ab:77c with SMTP id n2-20020a05600c3b8200b0041294ab077cmr2123569wms.3.1709223568667;
        Thu, 29 Feb 2024 08:19:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH4SCy2YajJeWNpTHxLBQzssbqrW0r39bNLFT7iOQIcuh7JhFu1Mcy87lNFubiNjWr3W3PMww==
X-Received: by 2002:a05:600c:3b82:b0:412:94ab:77c with SMTP id n2-20020a05600c3b8200b0041294ab077cmr2123546wms.3.1709223568327;
        Thu, 29 Feb 2024 08:19:28 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-250-174.dyn.eolo.it. [146.241.250.174])
        by smtp.gmail.com with ESMTPSA id bs19-20020a056000071300b0033daaef7afcsm2181930wrb.83.2024.02.29.08.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 08:19:27 -0800 (PST)
Message-ID: <327b473d9f6ae5e44391f75a022e4dca90a20c43.camel@redhat.com>
Subject: Re: [PATCH net-next v12  03/15] net/sched: act_api: Update
 tc_action_ops to account for P4 actions
From: Paolo Abeni <pabeni@redhat.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>, netdev@vger.kernel.org
Cc: deb.chatterjee@intel.com, anjali.singhai@intel.com, 
 namrata.limaye@intel.com, tom@sipanda.io, mleitner@redhat.com, 
 Mahesh.Shirshyad@amd.com, Vipin.Jain@amd.com, tomasz.osinski@intel.com, 
 jiri@resnulli.us, xiyou.wangcong@gmail.com, davem@davemloft.net, 
 edumazet@google.com, kuba@kernel.org, vladbu@nvidia.com, horms@kernel.org, 
 khalidm@nvidia.com, toke@redhat.com, daniel@iogearbox.net,
 victor@mojatatu.com,  pctammela@mojatatu.com, bpf@vger.kernel.org
Date: Thu, 29 Feb 2024 17:19:25 +0100
In-Reply-To: <20240225165447.156954-4-jhs@mojatatu.com>
References: <20240225165447.156954-1-jhs@mojatatu.com>
	 <20240225165447.156954-4-jhs@mojatatu.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2024-02-25 at 11:54 -0500, Jamal Hadi Salim wrote:
> The initialisation of P4TC action instances require access to a struct
> p4tc_act (which appears in later patches) to help us to retrieve
> information like the P4 action parameters etc. In order to retrieve
> struct p4tc_act we need the pipeline name or id and the action name or id=
.
> Also recall that P4TC action IDs are P4 and are net namespace specific an=
d
> not global like standard tc actions.
> The init callback from tc_action_ops parameters had no way of
> supplying us that information. To solve this issue, we decided to create =
a
> new tc_action_ops callback (init_ops), that provies us with the
> tc_action_ops  struct which then provides us with the pipeline and action
> name.=C2=A0

The new init ops looks a bit unfortunate. I *think* it would be better
adding the new argument to the existing init op

> In addition we add a new refcount to struct tc_action_ops called
> dyn_ref, which accounts for how many action instances we have of a specif=
ic
> action.
>=20
> Co-developed-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Reviewed-by: Vlad Buslov <vladbu@nvidia.com>
> Reviewed-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
> ---
>  include/net/act_api.h |  6 ++++++
>  net/sched/act_api.c   | 14 +++++++++++---
>  2 files changed, 17 insertions(+), 3 deletions(-)
>=20
> diff --git a/include/net/act_api.h b/include/net/act_api.h
> index c839ff57c..69be5ed83 100644
> --- a/include/net/act_api.h
> +++ b/include/net/act_api.h
> @@ -109,6 +109,7 @@ struct tc_action_ops {
>  	char    kind[ACTNAMSIZ];
>  	enum tca_id  id; /* identifier should match kind */
>  	unsigned int	net_id;
> +	refcount_t p4_ref;
>  	size_t	size;
>  	struct module		*owner;
>  	int     (*act)(struct sk_buff *, const struct tc_action *,
> @@ -120,6 +121,11 @@ struct tc_action_ops {
>  			struct nlattr *est, struct tc_action **act,
>  			struct tcf_proto *tp,
>  			u32 flags, struct netlink_ext_ack *extack);
> +	/* This should be merged with the original init action */
> +	int     (*init_ops)(struct net *net, struct nlattr *nla,
> +			    struct nlattr *est, struct tc_action **act,
> +			   struct tcf_proto *tp, struct tc_action_ops *ops,

shouldn't the 'ops' argument be 'const'?

Thanks,

Paolo


