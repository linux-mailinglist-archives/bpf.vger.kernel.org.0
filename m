Return-Path: <bpf+bounces-21707-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F1D8504C1
	for <lists+bpf@lfdr.de>; Sat, 10 Feb 2024 15:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88D881C20DE0
	for <lists+bpf@lfdr.de>; Sat, 10 Feb 2024 14:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671BF5BAC1;
	Sat, 10 Feb 2024 14:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AwcTQOmx"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DA83D554
	for <bpf@vger.kernel.org>; Sat, 10 Feb 2024 14:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707575751; cv=none; b=ubhiKT55fs+Pzt1LP9k8zOE++GRVyR4PZZFAj9inArbe1tBjn21eT8yU/gD1oQ+dajNL2COH3AR3zqNRJ/4G/ImR6AA1KPzGqsu6XugPOI9du6V1um6DnLk30JrcAZ2C/zMAXmvnHUnqERQbbTeHTppxLGDp1XD+pedZOF18AE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707575751; c=relaxed/simple;
	bh=065mOA8gk1fr4YoBODRGT+71mMfL81JgnvEfwqK7iVc=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IIwAfkl9I+A24dsSOjkRyLuhvYgjF8AEuYD3BuEj5Ij+zUM5euIQmII7iRGVBA/aRQl35YLzrEm0luTmXL6+QzVZwgI2W7MowpPgcuxaWuGQ5RnQU3xYmJjVgpsnFynudfWU1dV5p24HLKsH2c5BqfaPjpVGBhpSlGJzhdAizqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AwcTQOmx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707575748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=065mOA8gk1fr4YoBODRGT+71mMfL81JgnvEfwqK7iVc=;
	b=AwcTQOmxPXz5eOJ2FFrEA8UuJTN2wXDgggCi0cF7kNosCW+ZIfrNaPO7Ev51+k+5GCFIqm
	Tz1L/993QMXObTS/2fVgUNRi5ctBK6oMXE1zZX6tFDT8dsA4dEL4613spSZZ6n7OdE27TU
	kpF39C26zw33wLIxuk70PmNACvD6VrA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-bCavrpXBN1y3RnqZPwtSCA-1; Sat, 10 Feb 2024 09:35:46 -0500
X-MC-Unique: bCavrpXBN1y3RnqZPwtSCA-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-561623cf639so192792a12.2
        for <bpf@vger.kernel.org>; Sat, 10 Feb 2024 06:35:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707575746; x=1708180546;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=065mOA8gk1fr4YoBODRGT+71mMfL81JgnvEfwqK7iVc=;
        b=dDkRlKUoFWqMXuD1Swj1QfThbQ2NE6sKwHUnS5qWPumxdLyYr1HFiF7o9mTxroEaLY
         BqyECRMPxL3Qzl8ohpt9GKIwAIW3+haEROvyfq8cbonHKRM/IEfzjaOjmEyUtCYYt2L0
         +327kk638/NvRVqs8iYC3BPxAaIxd5jYERFEfJ0b98/uwwnUircQYUDFOKLjHY5bAqah
         2+YHQvqt5syLwLHhHqUD9v8vlCE7RVVy4jTUZPhqJ9fcjpzJYx1Kij0IqH2EdS7Avf7s
         pCzCuB9XkhBHRpF23LkqtaFBjVUgk18NuBlfw1dR1z483DlwmJWHA3pYgImy3eiZ71Ug
         nCNw==
X-Forwarded-Encrypted: i=1; AJvYcCVtprjiT2MItQ2PH7aDjuMVz6MZYL8WlwpaUWelYpLBYkj9C+X+YEe0l/9fgkwMI5noqvu89k+KbhKQxlTQvKeJ4SwZ
X-Gm-Message-State: AOJu0YzAys3ZbDF3BiKBiotnlq1/eS0lpw/ro9vTzXexoifvB32IWdX9
	6N1FSF7pYrXPwF78tcWm4e0lx929sIadvs1iqmrTB+od7+JDgw/Lcy7K5ARvct2SSGuKfhxBNaW
	Ifr8HPTbXvRqsTj5FPypnQirBpYY8LxbdlPNGO77QAV1aDIP8527WXS+tnEiyYdMN5Y8XdjSwfp
	DUH3It6zukRf3LRT8VpLQ8Z1Jb
X-Received: by 2002:a05:6402:1a45:b0:560:79a:11d5 with SMTP id bf5-20020a0564021a4500b00560079a11d5mr1284537edb.9.1707575745846;
        Sat, 10 Feb 2024 06:35:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IES8vikUfOPkS22sVebWCSm8Tn9Nv2RDKgS2EBKWU4t4rbMniayUavbKOBe2+VhAVGc3fm/s3abpDFuVQYxT1s=
X-Received: by 2002:a05:6402:1a45:b0:560:79a:11d5 with SMTP id
 bf5-20020a0564021a4500b00560079a11d5mr1284526edb.9.1707575745561; Sat, 10 Feb
 2024 06:35:45 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 10 Feb 2024 06:35:44 -0800
From: Marcelo Ricardo Leitner <mleitner@redhat.com>
References: <20240122194801.152658-1-jhs@mojatatu.com> <20240122194801.152658-12-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240122194801.152658-12-jhs@mojatatu.com>
Date: Sat, 10 Feb 2024 06:35:44 -0800
Message-ID: <CALnP8ZZiBh8w6yoiNPx-Oyj9+zosRVpOKzH8DaVpQC=xr3itFQ@mail.gmail.com>
Subject: Re: [PATCH v10 net-next 11/15] p4tc: add template table create,
 update, delete, get, flush and dump
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, deb.chatterjee@intel.com, anjali.singhai@intel.com, 
	namrata.limaye@intel.com, tom@sipanda.io, Mahesh.Shirshyad@amd.com, 
	tomasz.osinski@intel.com, jiri@resnulli.us, xiyou.wangcong@gmail.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	vladbu@nvidia.com, horms@kernel.org, khalidm@nvidia.com, toke@redhat.com, 
	mattyk@nvidia.com, daniel@iogearbox.net, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, Jan 22, 2024 at 02:47:57PM -0500, Jamal Hadi Salim wrote:
> Co-developed-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

Reviewed-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>


