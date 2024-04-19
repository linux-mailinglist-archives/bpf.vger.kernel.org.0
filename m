Return-Path: <bpf+bounces-27244-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1CB88AB47A
	for <lists+bpf@lfdr.de>; Fri, 19 Apr 2024 19:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCB681C2131F
	for <lists+bpf@lfdr.de>; Fri, 19 Apr 2024 17:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B9A13AA53;
	Fri, 19 Apr 2024 17:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sg4d27iS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14B7139CE8
	for <bpf@vger.kernel.org>; Fri, 19 Apr 2024 17:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713548331; cv=none; b=sqirUVd+kecWhcjwWuSDnllk45vNXqF3bx8PckHDJyCdw6QamzZO/mW6zZrHO1ImzeQudtVOSZTGCVlDGEVrLTkmF4pAVpHD5g/YHKaPK4jSp1PfpycFN7q8fDlyhEl1SHev1GuDWJNQKnpYBqoJkopes/o8C3LFNjmgwzQAdgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713548331; c=relaxed/simple;
	bh=P58Ybi2vCMmroX3ancSNu1b9TONgvzLIbGloRdd0GCU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=umL1LtvFEm4Jl9rkfQksf0+I/NwN9uvOx6740PxoojsvXHfmLwrr2dOh4ZJ0SD7S7GhMtFPLa7stj+VHb+XWbeChTFP8iLw2YNUVA2n2+LD2G8ez17h6G4fJrgVRFZeatfW3Lup41UidVBBcOcHRVG6q7+skRnb3kyMJVsMIvGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sg4d27iS; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6ed9fc77bbfso1847182b3a.1
        for <bpf@vger.kernel.org>; Fri, 19 Apr 2024 10:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713548329; x=1714153129; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=P58Ybi2vCMmroX3ancSNu1b9TONgvzLIbGloRdd0GCU=;
        b=Sg4d27iS7FIyFMO/SIqpDcPJasLQr+bJ702gQvvgMyBV4xQKWLxz+FPZjK7Mv31bvh
         noYk3ndx8A+nLu3OpJ0b2McKjkCSBhOUVHbxx2cIQDhrRA2maetM5YVIKn/hstAFNj7k
         CtJ6M9e2IIMAD0xXD06wBPgwH2H5ZRfo1q/VpuYzDs7sKDC6CR0t9ejVwtputLXtm9+H
         4J519xUYvyFdslgQVd3noLOyPyEdRyLQuL08GvY3PtHGFk5bIBFAfMFkWF7HhfJaFL0/
         lEDrIKhECHT1C8cmJjA6RqZz3UGCM3FKgsNin5wKdMsJ8wEfvSEdcFZm6c1KOpgTVBxN
         dU4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713548329; x=1714153129;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P58Ybi2vCMmroX3ancSNu1b9TONgvzLIbGloRdd0GCU=;
        b=r5hcWjzsBns3ckU6Y167Z4G/0VSHKcN1sxWEy0MIUB6zf9/2ChqaKUlQNuv6sqPg6S
         h7DTAarsmeUC5jEip5r+8Lub5MwOt3XPFKsyDYDyRM7Qrc7tNITpuxcEyPEajmPI5Mwn
         JowmdoxK0JCBai2y3/PZ4Kadk5KveFp8ynHDw3GPWjhEOQ2XPFWAveQcLH0qQnq33yra
         xmNkkVVVuGfPEMQr8O24dGuwBQZp8W2XjdbGmqnkXNO4lLgQi/iUI4/3+EMQynCUUT9d
         d1mM040YMZTC+FCJut863Bi8f8LUasmZ1ilLSLiCFb42jy979z4oyLvr8GWaEG8RJfm9
         sUjQ==
X-Gm-Message-State: AOJu0YxZytsdPusyrUH9oWEnz4CifJdLDldyv3naBSx23CckL4gldPnx
	QC9VrILqnoyM35qMQ8QyXh/JsJYv8uvaUqfpel5sfBi3nWMt5DYK
X-Google-Smtp-Source: AGHT+IHGUQw53b312jW2wJIktP2tOHYRs7iEo897lyF5C+9AYT6X3DSrSH4BA83wJwwDyGJ6u0jrkA==
X-Received: by 2002:a05:6a21:4988:b0:1a7:6ea0:e562 with SMTP id ax8-20020a056a21498800b001a76ea0e562mr2932269pzc.44.1713548328930;
        Fri, 19 Apr 2024 10:38:48 -0700 (PDT)
Received: from ?IPv6:2604:3d08:9880:5900:6673:872c:757f:1acc? ([2604:3d08:9880:5900:6673:872c:757f:1acc])
        by smtp.gmail.com with ESMTPSA id b9-20020a056a00114900b006eaaaf5e0a8sm3485266pfm.71.2024.04.19.10.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 10:38:48 -0700 (PDT)
Message-ID: <047c972f71bf89a7d4004f1852fe498d3e2ad010.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/5] bpf/verifier: refactor checks for range
 computation
From: Eduard Zingerman <eddyz87@gmail.com>
To: Cupertino Miranda <cupertino.miranda@oracle.com>
Cc: bpf@vger.kernel.org, Yonghong Song <yonghong.song@linux.dev>, Alexei
 Starovoitov <alexei.starovoitov@gmail.com>, David Faust
 <david.faust@oracle.com>, Elena Zannoni <elena.zannoni@oracle.com>
Date: Fri, 19 Apr 2024 10:38:47 -0700
In-Reply-To: <878r19k812.fsf@oracle.com>
References: <20240417122341.331524-1-cupertino.miranda@oracle.com>
	 <20240417122341.331524-2-cupertino.miranda@oracle.com>
	 <f347d6ea9a0d8ecb77fe13a89470195735c706d2.camel@gmail.com>
	 <878r19k812.fsf@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-04-19 at 10:37 +0100, Cupertino Miranda wrote:

[...]

> I was proud of the initial boolean implementation that was very clean
> and simple, although like Yonghong said, not truly a refactor.
> If everyone agrees that it is Ok, I will be happy to change it back.

Yes, I liked it more than v2 as well :)
Let's wait and see what Yonghong would say.

