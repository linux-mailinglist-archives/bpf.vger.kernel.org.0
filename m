Return-Path: <bpf+bounces-21706-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D42C8504BE
	for <lists+bpf@lfdr.de>; Sat, 10 Feb 2024 15:34:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CCC91C20FA8
	for <lists+bpf@lfdr.de>; Sat, 10 Feb 2024 14:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872E55B677;
	Sat, 10 Feb 2024 14:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N/9PM9wn"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F5853815
	for <bpf@vger.kernel.org>; Sat, 10 Feb 2024 14:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707575668; cv=none; b=RLeKQMuWnn3w/Oe3buNDy3mxN3c5TrS1/R0ocF4EntaDwi1HBCUbIRTR19NudJRWZ1qaIGVFr5IqZEhzs4UBP0GOVFTZqno9r8p9S1jqd6DP8tPXAsPFapGR9550JaFXrtpuE68RHDEeS9B2w6nyWHDZeeZrD/BATH0c6VIFNqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707575668; c=relaxed/simple;
	bh=hvgLSgmK9adtF1+vNKQz8hpPKcwl1X/SG40msaFAeFo=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mrsoubko4VXgPUz20RvKa8KuEgiQNXtpHgopzr7Y/C4huEmnfEEZYRSKU4iE3I2c4bM1kubeJ2uWXN6iFd0XQpvI/pZeQtFanbxgd/Z0Z0mms1cnwNZZRDtU0nappIyQl0LB0YHpR7YNSJ3IFmahairidetNw8C+a7JAO6SHctk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N/9PM9wn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707575665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hvgLSgmK9adtF1+vNKQz8hpPKcwl1X/SG40msaFAeFo=;
	b=N/9PM9wnjIkFsUvQhCIpWhQGox22W54opA76jlbUv/c/9/RcsPWKw30xCvzRGiSFkhWTq8
	Zra6UkdYNWMMF/DUO0QWgLzqjPCqoB+DURquLa08bBuEbwqS8Pb5wTMl+d+AdQD5WyeU6r
	9OWMrz5H1y+4kaRvuh+81yKoWhorOn8=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-rePJeVWoMF-GYbxkhw3IVA-1; Sat, 10 Feb 2024 09:34:21 -0500
X-MC-Unique: rePJeVWoMF-GYbxkhw3IVA-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-56001d4c9c8so1195768a12.0
        for <bpf@vger.kernel.org>; Sat, 10 Feb 2024 06:34:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707575660; x=1708180460;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hvgLSgmK9adtF1+vNKQz8hpPKcwl1X/SG40msaFAeFo=;
        b=tsjoXvdKOGegwtaqxoxCAYPi5+5qc3KoiuD8Zzl61KE/XKNrC7A5Z8c3ZPEFVMeVGi
         vIKb7rE/fhUBSAGoOrSSq0SEK9mvP5lU9JwTvQ25pTTmcv2khi4/8D9TSKEu4zDbiaFx
         yDCBQAyj1BtYyWRtDo1neADFi6XH1WJYC3bHyiEvKH9BamHDFfTtnPAhfWZWYcxjaakN
         /5l/Q7Bs3NcYoHA8u+uUIbTA2AEyv//wW9AmU5DlRDyOG8QTXt/cEKJJz7wheFCcbKGx
         MlrPCQyZPd6lcvlQ3fSyfJ17NW2NspgdxM7OKdu1mPrJ0noqg0kbBxuRASm8KhiD5kEd
         9+BA==
X-Forwarded-Encrypted: i=1; AJvYcCVD/7+i+HME4IrAXls4wSz4NRaUdXPB0XDvPmcZCxG+HXerjFXdltSHQ8dBWeTmc/2zZE6VT5kbR12IEeJ+S5/mI/y8
X-Gm-Message-State: AOJu0Yz/yo9O1R64cf+zOTOlmBGp/ZUzx//2dnLKzcS9bLLILoLOnD4+
	GFG41YtAXGftW5HxeqDhqoXnk9+e8cssySDfwgCUJt4okXrOp6P+jMMRAVE0/UV0E86NRHtkOzP
	XhqYDDkyqCMFb02Vc7kn/BwfAGNHWiCHWyvPdH5NNtEKuBrb7znGNGLmkB9oc20DyJcax4VrwUi
	Xkc3uCRW0m8qfthJz8VcniyDMQ
X-Received: by 2002:a05:6402:31a1:b0:561:8918:9f5f with SMTP id dj1-20020a05640231a100b0056189189f5fmr81210edb.24.1707575660667;
        Sat, 10 Feb 2024 06:34:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGBHOAwtKugsfYsGKKeGZrsPVvpwBB5CpbNM/FRN2T4jFDAKwBJ48tPPFnoRq9MUGR4eo08k2hq2qAT+MvcfjM=
X-Received: by 2002:a05:6402:31a1:b0:561:8918:9f5f with SMTP id
 dj1-20020a05640231a100b0056189189f5fmr81196edb.24.1707575660403; Sat, 10 Feb
 2024 06:34:20 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 10 Feb 2024 06:34:19 -0800
From: Marcelo Ricardo Leitner <mleitner@redhat.com>
References: <20240122194801.152658-1-jhs@mojatatu.com> <20240122194801.152658-11-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240122194801.152658-11-jhs@mojatatu.com>
Date: Sat, 10 Feb 2024 06:34:19 -0800
Message-ID: <CALnP8ZY7zNyn=r8_=ut7nivWwQCeUA_X+0_NXYEWR3dCh_ymig@mail.gmail.com>
Subject: Re: [PATCH v10 net-next 10/15] p4tc: add runtime action support
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, deb.chatterjee@intel.com, anjali.singhai@intel.com, 
	namrata.limaye@intel.com, tom@sipanda.io, Mahesh.Shirshyad@amd.com, 
	tomasz.osinski@intel.com, jiri@resnulli.us, xiyou.wangcong@gmail.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	vladbu@nvidia.com, horms@kernel.org, khalidm@nvidia.com, toke@redhat.com, 
	mattyk@nvidia.com, daniel@iogearbox.net, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, Jan 22, 2024 at 02:47:56PM -0500, Jamal Hadi Salim wrote:
> Co-developed-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

Reviewed-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>


