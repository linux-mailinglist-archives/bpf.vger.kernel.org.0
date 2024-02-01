Return-Path: <bpf+bounces-20984-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0838A8460A2
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 20:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B2F51C22E4C
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 19:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D5B85272;
	Thu,  1 Feb 2024 19:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hgTKd26j"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110F284FD8
	for <bpf@vger.kernel.org>; Thu,  1 Feb 2024 19:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706814447; cv=none; b=ALYzuTV5TQeMuG645htcdo+baKAwdaGZX36XZQLTjMTtvLo89XPdZ5kHPvfeoGoYS315CB9oD1ZMTqTnzye1aAWD/BMviI8pR7SSFWNPrakQI3hatbIc6tT+IqAB6jeK/vHH8HHZNiZ4f+dSeQUtdpZeIjffNtMfiZIV873ciE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706814447; c=relaxed/simple;
	bh=nd1xNacpJ7edmbB4vw12t/6SqODjNijtIQ+qQJkAn2I=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s8gFaE7o6z33C3k3CE7dnDl7ZEZ2KuZ9HR6WUaNsC7EqpTT6r4UpCu9Yxq1uHpvCBD1MoIxKjxNOENGPMcdqObg1F2LndCmapOfB2IH4GyrKmWZABp47jDFYYrkFBeYstoPXxaPwqjgvGaGtqROmf08ygIDNujM/WzzSNcDQuoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hgTKd26j; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706814445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Cx+1abgolFRi+4nasT0owtFSb2ulTA5ZS8PvE2Kg9TU=;
	b=hgTKd26jS62eIgX5Lxx4SraivxvpuWv+XOZBay2b4mwdcsPgKPGoOQE27KhbcYslPExEwx
	67sXqH9zeHkT5ExFggGoIX63C8h8TzTf3ljBGHcTZHxFsmyS3+EqiAnXlHR7btC6mDGagG
	qCAmCV4vlNErliFag2wCu0KjhAF10b0=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-rt4yNk2HOPWLx0mpIiZQ6A-1; Thu, 01 Feb 2024 14:07:23 -0500
X-MC-Unique: rt4yNk2HOPWLx0mpIiZQ6A-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-55d71ec6ef3so786320a12.0
        for <bpf@vger.kernel.org>; Thu, 01 Feb 2024 11:07:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706814442; x=1707419242;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cx+1abgolFRi+4nasT0owtFSb2ulTA5ZS8PvE2Kg9TU=;
        b=SL3/wea0doKf1Uv62kUk03V/5Xr+6jlO2DW+bJ6ZX/AWU1E1Uay7x8KPhnwHJMi6b6
         y93s/8ur1aiybiczGqukVm53iMWAYe4cihlcLI5s6q6u5sKeUd0MwbGvm6VjeqiSSA2y
         /9K12yQAm1g2/VIB/4Ijfozv9usj0ESxVo8dLCuoJgFz2bMg4GriJ4Le+W0D2sgkqDmS
         Ye4+14qg4AZR2cK/PM/tN+jemWAPlP8F7bAIAvKnveYEzaleR3JnOhRxseBhI/B+WSZr
         wnO8f0KFSvejP5EpjGhFnKGu/tzkyPCQcuncZ9CD2eKsLYFpG4jgX/Y57R5hBAVC0l0Z
         8sWw==
X-Gm-Message-State: AOJu0YwEd8pvgmU+uz2egNDZCuMpRDOIFJUPbdCmnrpuw2VP6nVFT9xG
	I9e+BW4z6NFDy1uazVH08PIbR23w8QQlIQPkWUwdWrcYJ/8scwLzSOa3WGS74CjfA24iQLn/IH5
	7V3XadbS3yVKkWbCg3INDJ0L9NQzk0bGi+3CnNQ1FKT6c/ufgFO/6r3cXHjRxGQe+9Sw+XpNAHg
	ChYtgiFr4mPzwUwMV2srMtZPC6
X-Received: by 2002:a05:6402:3402:b0:55e:ef54:a4dc with SMTP id k2-20020a056402340200b0055eef54a4dcmr4269484edc.23.1706814442618;
        Thu, 01 Feb 2024 11:07:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGZ8wz1J4znsp54tQfcT1PW1YBWiXRCYfSoLa5g1fFEFNKhu84EYm4M0xhWlmFnpH5WWH25rUVHhle4WSqoF7E=
X-Received: by 2002:a05:6402:3402:b0:55e:ef54:a4dc with SMTP id
 k2-20020a056402340200b0055eef54a4dcmr4269471edc.23.1706814442328; Thu, 01 Feb
 2024 11:07:22 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 1 Feb 2024 11:07:21 -0800
From: Marcelo Ricardo Leitner <mleitner@redhat.com>
References: <20240122194801.152658-1-jhs@mojatatu.com> <20240122194801.152658-6-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240122194801.152658-6-jhs@mojatatu.com>
Date: Thu, 1 Feb 2024 11:07:21 -0800
Message-ID: <CALnP8ZYtVXHbnvESkZpcVwpJAVJWe9NP1EtPQOzTKD3WUnqO3g@mail.gmail.com>
Subject: Re: [PATCH v10 net-next 05/15] net: sched: act_api: Add support for
 preallocated P4 action instances
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, deb.chatterjee@intel.com, anjali.singhai@intel.com, 
	namrata.limaye@intel.com, tom@sipanda.io, Mahesh.Shirshyad@amd.com, 
	tomasz.osinski@intel.com, jiri@resnulli.us, xiyou.wangcong@gmail.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	vladbu@nvidia.com, horms@kernel.org, khalidm@nvidia.com, toke@redhat.com, 
	mattyk@nvidia.com, daniel@iogearbox.net, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, Jan 22, 2024 at 02:47:51PM -0500, Jamal Hadi Salim wrote:
> $ tc -j actions ls action myprog/send_nh | jq .
>
> [
>   {
>     "total acts": 1
...
>         "not_in_hw": true

For a moment I was like "hmm, this is going to get tricky. Some times
space, sometimes _", but this is not introduced by this patch.


Reviewd-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>


