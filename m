Return-Path: <bpf+bounces-20982-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B46B8846092
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 20:02:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DA1D289BE2
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 19:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C5485272;
	Thu,  1 Feb 2024 19:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aqq7tlgR"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9FC84FD3
	for <bpf@vger.kernel.org>; Thu,  1 Feb 2024 19:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706814162; cv=none; b=NboYJ1ezCjAkns+3EBQQGKErctfsLF1Ns3pmw+Hrvs8XaIhszWe/YvElVqR4HWcKITncr8NZd9g7hqw37NtdLDSVtUMNs1byZ2CLViS6nmWmobUCXvTnc5O+ELCS/kcybxAcZ5w4J22guTxD2Wk0mbdj6Z5yZBgWTE5R804seHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706814162; c=relaxed/simple;
	bh=cKSo+ZdocbAwsXGKGoY4JPKD8I5PhfWrpIDFndHCILI=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W7uoIqC9lsPVgcaJsb687UJDqg+nVkQDih5iCWMvijAdSM+JqNqM2Mh+G3GcIVw9U46AlclCGGC7chCjAhujr4BR6mk67ViJ5GzuHceirAcbVXx7XlVVEpYCx998RCQVy5k/b/G5BH3ssmL15IahCV/b0WUH3YdWOmgwNYaYA2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aqq7tlgR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706814159;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vla01HC5d18QbyC/g/NZpcu3TLjytQcHmvKQIYZFOjs=;
	b=aqq7tlgRaYhxiOH8Zf30Ls7jN8I7UAScKDY085I+NNc+cHaNZYUtTSYITUxI7cC4YarR4Z
	KgVzakKtsDdJYXzHhzI23nfRPhL2gLUIEY9OuZT2wGf/diDUsbb6xqbckXPOmHtXLCX0W7
	aFS7QlE/KAwBpEJKPGDYsPIGp4MLv20=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-sufjcSOeO4C2HOawsenn3w-1; Thu, 01 Feb 2024 14:02:36 -0500
X-MC-Unique: sufjcSOeO4C2HOawsenn3w-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-55fcdc80ddbso366518a12.0
        for <bpf@vger.kernel.org>; Thu, 01 Feb 2024 11:02:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706814155; x=1707418955;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vla01HC5d18QbyC/g/NZpcu3TLjytQcHmvKQIYZFOjs=;
        b=oP/1TnX54HXoQn5VHP2KSaZ4kESRkbQSFadG/5nlVUnCIsFqOE3+xxs30NZFetZg0C
         aPzH2pKl5rXXsHu+1c9rWbewD+reC4j2QM77+TSf6jBglRJsnsCl1BrurfbIQdAZj+V4
         BN+yS9/oi6dLucQUqt1uEonAU2FBDYqv8zErwde0VioggOl68W9alQ6sueJ1SHb7jyWL
         vRjbr81l5jtDGCGGrdrd+juMeKz6UMrGzwMsHajWaPt1FGounvFDCvYpmUG56+axClqc
         M1KiYV5A2xfG3i5UTCH9RWXVYhxozR0CPeNKFvkhac9VJ7NJTTKbrrhdTpEJEKjbn5YH
         j5oQ==
X-Gm-Message-State: AOJu0Yw0Xb8eeUkSu6sTbOxjTERD9cnjU+Mj670ZT+HowaI7aDxjI1NF
	PcTAlYMLpkC2g7Gg2EU3HOjStw3Nss2LIXB97YVTG7ODPJFYuPSv9KtACTwcxfwKWuluortgXD7
	HPKaAJ1EA4XvYwndIEA4D4UsZV+qiDCW5bILG+zjqb93VcMwgH9ffg633AHEWhkvG8M1skQtH9b
	D3p3QtrcGjHI41QjUoSG5I7uWQ
X-Received: by 2002:a05:6402:510f:b0:55f:8ddc:6c8b with SMTP id m15-20020a056402510f00b0055f8ddc6c8bmr5218408edd.10.1706814155556;
        Thu, 01 Feb 2024 11:02:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEhia/PVmPTEloaEh+gwGCMOBuqwr4n7Oh1M5KvukMHZ70h8TybR9X6aUiHp35O4XXN4HhiVpTzB+0M0WrB3Ps=
X-Received: by 2002:a05:6402:510f:b0:55f:8ddc:6c8b with SMTP id
 m15-20020a056402510f00b0055f8ddc6c8bmr5218377edd.10.1706814155236; Thu, 01
 Feb 2024 11:02:35 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 1 Feb 2024 11:02:34 -0800
From: Marcelo Ricardo Leitner <mleitner@redhat.com>
References: <20240122194801.152658-1-jhs@mojatatu.com> <20240122194801.152658-4-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240122194801.152658-4-jhs@mojatatu.com>
Date: Thu, 1 Feb 2024 11:02:34 -0800
Message-ID: <CALnP8ZYJhcQQMKgSgPK0D35zvB0r+S+=XL2zeS2tNx+DmkLpGA@mail.gmail.com>
Subject: Re: [PATCH v10 net-next 03/15] net/sched: act_api: Update
 tc_action_ops to account for P4 actions
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, deb.chatterjee@intel.com, anjali.singhai@intel.com, 
	namrata.limaye@intel.com, tom@sipanda.io, Mahesh.Shirshyad@amd.com, 
	tomasz.osinski@intel.com, jiri@resnulli.us, xiyou.wangcong@gmail.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	vladbu@nvidia.com, horms@kernel.org, khalidm@nvidia.com, toke@redhat.com, 
	mattyk@nvidia.com, daniel@iogearbox.net, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, Jan 22, 2024 at 02:47:49PM -0500, Jamal Hadi Salim wrote:
> The initialisation of P4TC action instances require access to a struct
> p4tc_act (which appears in later patches) to help us to retrieve
> information like the P4 action parameters etc. In order to retrieve
> struct p4tc_act we need the pipeline name or id and the action name or id.
> Also recall that P4TC action IDs are P4 and are net namespace specific and
> not global like standard tc actions.
> The init callback from tc_action_ops parameters had no way of
> supplying us that information. To solve this issue, we decided to create a
> new tc_action_ops callback (init_ops), that provies us with the
> tc_action_ops  struct which then provides us with the pipeline and action
> name. In addition we add a new refcount to struct tc_action_ops called
> dyn_ref, which accounts for how many action instances we have of a specific
> action.
>
> Co-developed-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Reviewed-by: Vlad Buslov <vladbu@nvidia.com>

Reviewed-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>


