Return-Path: <bpf+bounces-21650-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 43DAF84FD89
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 21:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7604B28A73
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 20:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1203F1272BB;
	Fri,  9 Feb 2024 20:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EySJEldr"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665682E632
	for <bpf@vger.kernel.org>; Fri,  9 Feb 2024 20:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707510321; cv=none; b=cb9EDCOppG3yHzT02VN7hKO3nC/Yzvb20bPFdBQvVlthKzbCAXBXaZRfkK3T2qvkRj7jkWfjBsm/+2wKJ+WfrXk+O8FGVxIwXe6BoPHacIR9AVR9v/ZcU/exN3m6vN3ip/vj6gZ7phRbbtuEx3SyARfR1fyDxNIyJVWWlyOSTX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707510321; c=relaxed/simple;
	bh=IcGgyIdQEelKLcXodFMWIwvGTqaHiaXh1N2bZxHZavo=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WgkAMEcHJnUzISvnvrmT6vRIlaOUBfIi+8jBfgV9Gj/cz+UFfgqP+qPHzqr9FEp5v3j23LpA7jmlmqGVD9jL8dM8avD2Y2jIY/oRYoNen+ozOWfH3/73seiDx8nB7ht1ayQZx8fLiK8PvNmBdMx/TmusHhDaggypxP13c213l08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EySJEldr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707510318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IcGgyIdQEelKLcXodFMWIwvGTqaHiaXh1N2bZxHZavo=;
	b=EySJEldrZRhXgYr8wvZnqxHCxiYhww/nu1imgTOXNgT/nj0+r8woNiWBesGK9kXp/eWh2o
	svDM5auLJH1+1W0AATm1MjxDC15F8EpaV7a8u43quk4P1lu+qJaibuTgSns9Iz99hQq6oX
	yWgJ4b4aaiLXyZzjrwhYNjn6Te9VrLY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-i9vAAVDPNfOAUom1wXbHZA-1; Fri, 09 Feb 2024 15:25:15 -0500
X-MC-Unique: i9vAAVDPNfOAUom1wXbHZA-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-55fcdc80ddbso854385a12.0
        for <bpf@vger.kernel.org>; Fri, 09 Feb 2024 12:25:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707510314; x=1708115114;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IcGgyIdQEelKLcXodFMWIwvGTqaHiaXh1N2bZxHZavo=;
        b=oYjXQL43qYB+MfmrhpTicGeOitXcTK2sFW+QEmpl+K7h3Ni4ZxPU90cK7zymY0BicY
         glcC1w5ygVQsRLJ7wd2/yr1wvIBn1Fw4K48pIbvATCEgUsmz0SUNyAOa6O6KdQEtRjN1
         XyRCNgrsa1spbSC6sXbxehul2BVJhNQcMb+LDa3GxsKs2M5Kql+N6EsmqnyFtlsu9xRh
         f9Ku3Vs57PBaH4k68cdiu+VVzNeaasGN5fcIv4sotn2b/5hYS/NM/Xf84LYb4LD1GmTM
         QNy2DrTshcUw5o6Qm2MpG99Ka9F/Zn4I75+5GFnN5XeYUWsWOC9TBCQJ/eNDO+uYhTok
         gDiQ==
X-Gm-Message-State: AOJu0YyJ2L8Da9eBeke8NICbnZ/YdgNotm8dyoGU3UGPOpjQ2YyhAVAW
	WVn718qkGXOeVFwCYtsxQfZJyaB30rPtXp/OaRy6hvy2f/cbRrgTVL8FicAhlmkkXnn8vDCbCOl
	fUXZNOQFMQS6TO/GUn1NVNm79qU+/zBZOxVOb3FKuaaCcs101ZkMqmhT4JnTt6pQQIc7tLxczj2
	o04gWHEDCTZdELPkAd7bkhZ7Ry
X-Received: by 2002:aa7:cf89:0:b0:560:7f1:9b26 with SMTP id z9-20020aa7cf89000000b0056007f19b26mr26214edx.10.1707510314751;
        Fri, 09 Feb 2024 12:25:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGZvU8kZLkqDzPpSEbApy6DRu6ME5EkBs/zv2sq4MfTYlsaOvTztjes67sC3vTsO85STA7SKmx1xJTxwtP/KgQ=
X-Received: by 2002:aa7:cf89:0:b0:560:7f1:9b26 with SMTP id
 z9-20020aa7cf89000000b0056007f19b26mr26205edx.10.1707510314490; Fri, 09 Feb
 2024 12:25:14 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 9 Feb 2024 12:25:13 -0800
From: Marcelo Ricardo Leitner <mleitner@redhat.com>
References: <20240122194801.152658-1-jhs@mojatatu.com> <20240122194801.152658-8-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240122194801.152658-8-jhs@mojatatu.com>
Date: Fri, 9 Feb 2024 12:25:13 -0800
Message-ID: <CALnP8ZaxqvV9nbWkMEjk8MhwauUBwBOWNo0jjKXLfv0S9A=4kw@mail.gmail.com>
Subject: Re: [PATCH v10 net-next 07/15] p4tc: add template API
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, deb.chatterjee@intel.com, anjali.singhai@intel.com, 
	namrata.limaye@intel.com, tom@sipanda.io, Mahesh.Shirshyad@amd.com, 
	tomasz.osinski@intel.com, jiri@resnulli.us, xiyou.wangcong@gmail.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	vladbu@nvidia.com, horms@kernel.org, khalidm@nvidia.com, toke@redhat.com, 
	mattyk@nvidia.com, daniel@iogearbox.net, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, Jan 22, 2024 at 02:47:53PM -0500, Jamal Hadi Salim wrote:
> Co-developed-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

Reviewed-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>


