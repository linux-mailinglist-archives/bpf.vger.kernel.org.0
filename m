Return-Path: <bpf+bounces-21709-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE058504C4
	for <lists+bpf@lfdr.de>; Sat, 10 Feb 2024 15:38:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1DDC1F22174
	for <lists+bpf@lfdr.de>; Sat, 10 Feb 2024 14:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E7C5B69F;
	Sat, 10 Feb 2024 14:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LV6VPusQ"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5F554BEF
	for <bpf@vger.kernel.org>; Sat, 10 Feb 2024 14:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707575896; cv=none; b=ree5tvnI4eidHxKDoUTogQU1Y+DfErk8mEyZSHwx6YxJYWbwkYXssqn5C4xYPJuGbE+YWnBx8MGmo7flH0sCX+XMAVTtQzHU+mbymUEPTCqj2RIQHIIsDozLZiDSFA7HBHMdicGgpgrNV4/7DBldpOLPNZdJItrg96GOvqhbD70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707575896; c=relaxed/simple;
	bh=8KivXXELJEuxJ/VXJGLoFocpm/IMxD+P2YBpOFJi1/k=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=st0lc2W7reCH+dDxPH//VO0zNAOt/i8NVu4XSuCsxmxqhcBTEU/oJly3HzcrIBg2NhW22vfCWRZ4T5/O9u7OZS8NgnuWJlyAOibPjxosyRczBvqpbVLAzhbrLvJHKrQk90Maz1WJdFQhrhulpuikr6SDD+CpKbCpaKPnqvf/oNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LV6VPusQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707575893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8KivXXELJEuxJ/VXJGLoFocpm/IMxD+P2YBpOFJi1/k=;
	b=LV6VPusQWkXxFC8F0ZZwhPHsvKo5kZsql9CwqVkkzvpgmazhN/Vus8FTmRZZiB+4zVDFqe
	gLGdIeSan2610iNzWmkkHkcLN5TMfxuhoKxuQdsAj/VzC2afdWfGxfQyzkldO4pYKlfdBV
	JGsjtscooKuMZvbGAUcAY9zvlK7VMlw=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-5m1mdfLJOymOhkDETR_QYg-1; Sat, 10 Feb 2024 09:38:12 -0500
X-MC-Unique: 5m1mdfLJOymOhkDETR_QYg-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5597d3e0aa3so1392508a12.0
        for <bpf@vger.kernel.org>; Sat, 10 Feb 2024 06:38:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707575891; x=1708180691;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8KivXXELJEuxJ/VXJGLoFocpm/IMxD+P2YBpOFJi1/k=;
        b=mAKw+De0esdcqmVaEiLlSuhO1Q3qd6MlkcVKoKiVwub9SyfrZZCDJHkY83GEWhof9i
         J5h7ExBUVVCEzu/101fjaPQp2n8PpHv8Uh/ktzUesy/RQIyKp3sDc8MWqVe+zhy2p6u7
         aP+95+FrnYxbX7TOZKb0RFYWk30gqtPpRlZNNEeG94Q3H8GHsl/4AbqFjbD7VSMkqTOa
         hmyQU45x8J0dkkpvyqq0Q5+tsZe5zH+3ypqhUKMSRAdEAlLamclhOH+HvGukVCgbxMPy
         xVuQdIln4MoIjefZIE503Cun93hses6yx9pzs9al89OE+B8uJtOg1bmCinTtlQKFO3q6
         i4lg==
X-Forwarded-Encrypted: i=1; AJvYcCVnyE3g2f12BBYVwmzOnSlDbyek9I8pNToowQ+9JjtFnVxwpZNjyL0GIzSZVeB7dVNRj0ZGAjJxcVrMOnujOvGdYqfY
X-Gm-Message-State: AOJu0YzTfhGNUL+GSV2+Q240txcoidhYzrAjd5t3e5NXEFRME6U1FPk8
	cDR8sBUleEtmu1ovsy3qtQLAyQ6bHd9bneSCKoEj9DH2eyc23Z+13jXAmcD0k21ZrJgSwlDNFOu
	QgVIRCBdJhmUw22zWTc99x9OwHSAN3xpQtvQwCbH4uaaTMultKEpzvAaMfhdBUJwps/aC7GyODD
	+1Knwi8szfAgULYsBn225p7mrX
X-Received: by 2002:aa7:d306:0:b0:561:351b:7928 with SMTP id p6-20020aa7d306000000b00561351b7928mr1286492edq.35.1707575890914;
        Sat, 10 Feb 2024 06:38:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGIWqZ8jDST5MmR1Itvs2kMllfaNtEHIqZtP4JvfGvSX3S3bZh+9rYDneOtN20pkc/KK2hURjox2D3kucPrc8Q=
X-Received: by 2002:aa7:d306:0:b0:561:351b:7928 with SMTP id
 p6-20020aa7d306000000b00561351b7928mr1286477edq.35.1707575890720; Sat, 10 Feb
 2024 06:38:10 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 10 Feb 2024 06:38:09 -0800
From: Marcelo Ricardo Leitner <mleitner@redhat.com>
References: <20240122194801.152658-1-jhs@mojatatu.com> <20240122194801.152658-14-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240122194801.152658-14-jhs@mojatatu.com>
Date: Sat, 10 Feb 2024 06:38:09 -0800
Message-ID: <CALnP8ZZAh47_rTF-jiC4Hsd1dVSfJgsVAGJT_0b=DxHzqYucLQ@mail.gmail.com>
Subject: Re: [PATCH v10 net-next 13/15] p4tc: add runtime table entry get,
 delete, flush and dump
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, deb.chatterjee@intel.com, anjali.singhai@intel.com, 
	namrata.limaye@intel.com, tom@sipanda.io, Mahesh.Shirshyad@amd.com, 
	tomasz.osinski@intel.com, jiri@resnulli.us, xiyou.wangcong@gmail.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	vladbu@nvidia.com, horms@kernel.org, khalidm@nvidia.com, toke@redhat.com, 
	mattyk@nvidia.com, daniel@iogearbox.net, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, Jan 22, 2024 at 02:47:59PM -0500, Jamal Hadi Salim wrote:
> Co-developed-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

Reviewed-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>


