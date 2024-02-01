Return-Path: <bpf+bounces-20981-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B098384608D
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 20:02:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D038289BFD
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 19:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25A084FDF;
	Thu,  1 Feb 2024 19:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UN3PW0GS"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B468484FBF
	for <bpf@vger.kernel.org>; Thu,  1 Feb 2024 19:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706814113; cv=none; b=Lu8qXfOHdTqsQpX2C3fJdFqJcPco/GQ1CY8fBtKpURarHN3swaNvBISXdMhwjhXVSDboL+/SM/QEH+dGzUl9wP6Otv7fX8rHnWZB1keyS6fqCjHcc8WWcqB54Kh1xC3Ll3QQdLwLz9N9WgkuaMeL7UkkX++lFOaG/SYJGCLmX1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706814113; c=relaxed/simple;
	bh=pmt9hG2QGZL/zqHnnAhqZNv520tGKDaKr2CFiXadY88=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ptKYPPCrCKwsG4PKpadxIjXDqZnRxQLzcNfENCEb4Hda4UnmjPc96oI3BmEQv9kKmYDlT7CptmGsqT0ReRghjq0RjIQJ/Fy1QZqpzxIobLKOwP+E9GDZYa5EB7/Sq8fCs2raV2l9adfk29lNK/2QawGLdyxe4PMLllMlVMrI1EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UN3PW0GS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706814110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hXjF+P5a//40aojS9/M5jWJc+UF8Q6Ck1Ukhw35QwMs=;
	b=UN3PW0GSzGvduO2sU4i4Vn8quOVPDNinVXwWFeL/gYanYI3jqFjkSdqW+mrJW6gnc3O0fE
	ElnV0lXIIKELLU38OcvX1a0mpYt4k2QMFaTYWMs8QOqFgMX3ijXgDuUWFR9DyrOAs8rDhV
	pal9Lmt8mOFvfJb72aznlETf3tf99vU=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-ZwpJWuMvMginmXkbvF8Dgg-1; Thu, 01 Feb 2024 14:01:48 -0500
X-MC-Unique: ZwpJWuMvMginmXkbvF8Dgg-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5597da35ebbso877698a12.2
        for <bpf@vger.kernel.org>; Thu, 01 Feb 2024 11:01:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706814107; x=1707418907;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hXjF+P5a//40aojS9/M5jWJc+UF8Q6Ck1Ukhw35QwMs=;
        b=b8OMw6fKTZpWEDOGCvsFl25w1whknDJjoxxSH6YyQlEjzNpHsCVjvul0+1YsoY4yF/
         16mNaohpSKUZ8saLyxrPopsJ6cwDjU0H96CSA9lYc6beEGJwG3GiHkMHYva3uCNtMm5g
         pTUiwav+0gfeep0nT2T0uChYLqGeYA/m3ISF7p2Y1uaVNoTPcxROiZB2bnYKKbA790N5
         Tzi8hA8G0JqkqorUTMGfm03TZXGX+dOhq4pihistnN7ABLMmHvksmyCKuai/SuRtZC1/
         eAyk3Pl6e0Y0yTWNRVU7/F3069wyQfeNS0gD4FYeEyEnIST+IEA6sXargi7oQDzLrI7V
         9faA==
X-Gm-Message-State: AOJu0YweaGzsBjFHtrOqbr8DdPWv8p7cAYqMH+mpARTacKjVb2Qje1dj
	++cq4qSu4nznADDAv7HpSZ9DFi5yfHqTTXPK00nFlTf1pu2M3xAOG9k77mGsDRRhiej5FxdgtWc
	O9UJXy4aMW7GhJunbn7Nn7VL2ShaBZrCTe2E9qlzxsEVsDlfwy7YHXn49DHRCd9X8VmJhfPNUqs
	NYcSBS+pEd1HQ3xdN4mXB1iXgh
X-Received: by 2002:a05:6402:f93:b0:55e:ed35:ffce with SMTP id eh19-20020a0564020f9300b0055eed35ffcemr3564782edb.37.1706814107466;
        Thu, 01 Feb 2024 11:01:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHYzSFvK89MFlYCpuwbqUmRN+TweZauFcH382Mkey7YxA8GDuIW5OnFdjWmZAquYsgvP3jsZDqq2BtCzvDcypA=
X-Received: by 2002:a05:6402:f93:b0:55e:ed35:ffce with SMTP id
 eh19-20020a0564020f9300b0055eed35ffcemr3564758edb.37.1706814107171; Thu, 01
 Feb 2024 11:01:47 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 1 Feb 2024 11:01:46 -0800
From: Marcelo Ricardo Leitner <mleitner@redhat.com>
References: <20240122194801.152658-1-jhs@mojatatu.com> <20240122194801.152658-3-jhs@mojatatu.com>
 <CALnP8ZaPsOLK-Xc8vkXMO13NT4t52u6PH9v0PcKWX8Yy8gLCXw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CALnP8ZaPsOLK-Xc8vkXMO13NT4t52u6PH9v0PcKWX8Yy8gLCXw@mail.gmail.com>
Date: Thu, 1 Feb 2024 11:01:46 -0800
Message-ID: <CALnP8ZZ+=L0gWRc-kJUH51gfPW-aO0M16SDRk7O_qD=D3LreVw@mail.gmail.com>
Subject: Re: Re: [PATCH v10 net-next 02/15] net/sched: act_api: increase
 action kind string length
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, deb.chatterjee@intel.com, anjali.singhai@intel.com, 
	namrata.limaye@intel.com, tom@sipanda.io, Mahesh.Shirshyad@amd.com, 
	tomasz.osinski@intel.com, jiri@resnulli.us, xiyou.wangcong@gmail.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	vladbu@nvidia.com, horms@kernel.org, khalidm@nvidia.com, toke@redhat.com, 
	mattyk@nvidia.com, daniel@iogearbox.net, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, Feb 01, 2024 at 05:16:44AM -0800, Marcelo Ricardo Leitner wrote:
> On Mon, Jan 22, 2024 at 02:47:48PM -0500, Jamal Hadi Salim wrote:
> > @@ -1439,7 +1439,7 @@ tc_action_load_ops(struct net *net, struct nlattr *nla,
> >  			NL_SET_ERR_MSG(extack, "TC action kind must be specified");
> >  			return ERR_PTR(err);
> >  		}
> > -		if (nla_strscpy(act_name, kind, IFNAMSIZ) < 0) {
> > +		if (nla_strscpy(act_name, kind, ACTNAMSIZ) < 0) {
> >  			NL_SET_ERR_MSG(extack, "TC action name too long");
> >  			return ERR_PTR(err);
> >  		}
>
> Subsquent lines here are:
>         } else {
>                 if (strscpy(act_name, "police", IFNAMSIZ) < 0) {
> 		                                ^^^^^^^^
>                         NL_SET_ERR_MSG(extack, "TC action name too long");
>
> I know it won't make a difference in the end but it would be nice to
> keep it consistent.
>

Despite this, please add my tag in the next iteration:

Reviewed-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>


