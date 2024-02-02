Return-Path: <bpf+bounces-21042-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA12D846F1F
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 12:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 789941F286F9
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 11:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D10313E202;
	Fri,  2 Feb 2024 11:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qk8b9DsR"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422F113E20C
	for <bpf@vger.kernel.org>; Fri,  2 Feb 2024 11:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706873936; cv=none; b=ZALkGigFsVEbIiXB7ttmvE8OOZR8rYCdzR8gkUyIiMU7gYDVNlZGJqochDNEb8Cc9hwjaN8688xv5YrYyGeG/Etc3zyOAPe3oK2XwQ3FPs62jnK56SiyEa7L+Qt9VOOXhYjRtWaMF0I+zy3ZLC4wGucC2ZxgaiZgKDbH+lOm7iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706873936; c=relaxed/simple;
	bh=4hlLoxgVRubmdsXA/JOtymfDpB123MgdtvEfROpDl+0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Y3XII/ojoQQNTJSl0VuHh5C++TC94/SQ6H4XR2D4e4onYjKiKae+U5aubCgcvmGP0Ch/DTBGcwYq6G6yMGhUtBSFk5qzwPmEQZRCPE3p7Q6lbqDFdjK5CvFyTOkbPsOo1CR4aq8X+fIRnplG+36m5LqID7n9xtNtr3rJXZ4lQqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qk8b9DsR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706873933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4hlLoxgVRubmdsXA/JOtymfDpB123MgdtvEfROpDl+0=;
	b=Qk8b9DsRjIowGg31z9Q7pjkGn6fnq1Se8c3tLC5UcF+SOFkrit5twj+pdU2XW+6Lb2UKbM
	eFP4/Kr3PjpIASIMAqqm2JUoBLU+x0pPoicLImrCKOnFdugsm15B3M35u12564sl76ChFD
	9yZTwiVvskGCBhNY44dIJJpS3eLcRxE=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-o85PIx2QPW2o487spzqNlw-1; Fri, 02 Feb 2024 06:38:51 -0500
X-MC-Unique: o85PIx2QPW2o487spzqNlw-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-55fc940aa45so957991a12.1
        for <bpf@vger.kernel.org>; Fri, 02 Feb 2024 03:38:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706873930; x=1707478730;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4hlLoxgVRubmdsXA/JOtymfDpB123MgdtvEfROpDl+0=;
        b=qX23gz1uX5V0zX9XMdi5V7s3M+4ztqSt93iaAZx1y3c2TWWgKXunTm6ShBguiPSr9g
         /ZPLHtMbOnACIYPubEDRHpfY5b04r5ocop9lsSLm0yBr/IC7+8/RacjTj9zZfEsvb3gJ
         d7XtDtGgD9pdZSbrwnFctchSAUd27+I8fgd3IQuiTqfXsV8a376bAZZSl3VLhJzSV0Kk
         2HfDJS/O92TwQeWcMqNV2pauYWBQHOKsf1LShzYS/4DfBaKr9m1kERwM/Npm5F3k0+PU
         JoKMq4bJAZ4tKGU6kxJQBhKUqYRUoWJRvQ40BL178hpqsyRO3cmLUTXOreiOHrT6sCRB
         /XGw==
X-Gm-Message-State: AOJu0YzzcMhqNr3qaBNX/mkPR3AqwL7lpq43+9gEySiKdH2sYfOfc3oB
	nE7UHTrsnay0z5mvFSEmmDok+NpVZPKGGm9hQ5Kz3V50rJy37EWRHw7wupBxyfDuG8rlpwlhShn
	eWCvE1rMKeVl4mLgghQdhRvTy3reZEGp1eZd+/qiTAS7d6Gxp1w==
X-Received: by 2002:a17:906:15d8:b0:a31:f7e:8a53 with SMTP id l24-20020a17090615d800b00a310f7e8a53mr1343354ejd.26.1706873930320;
        Fri, 02 Feb 2024 03:38:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGxEAJunAEUW/L3MFJKR31vN1MxxW5woPZmhc5v2fwcaBQ9f38xfilE5aVLH0gmvNqQ5Q13ng==
X-Received: by 2002:a17:906:15d8:b0:a31:f7e:8a53 with SMTP id l24-20020a17090615d800b00a310f7e8a53mr1343337ejd.26.1706873929992;
        Fri, 02 Feb 2024 03:38:49 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX4/KG5Hy4D3W6/JBc0krwsLJY4D1i5j/cUA45VUdQFA8tENeMlpGHHU4/BGh8Doavma3fd6YuLy5krCvfSam1MQ6ieOolQu31kz+w9bOzMqgjjnOlS0WV98FTdIi7yI8uWyKkMfjmvKvhQcHI/ZvK86lCXe8ysA3qsQ+lJzdfh2CqUqUMaEdsKpEohirM+xL1Jru5nbR6kqL74hPuFynzdwyWuG8ySqcZbd14/2hfZUQRv71G34cZYhzRn2AQbUKx+2/Fld43qEetm7suF6p19LacOzQIMf+TsvrxrAGb3K513ShimALlA1LNZW/P3WYRqW+FbmC3Zi1gijZ5O6l/8BlI1GzBr5kUZMyzPxX6x1ZjB6fOdMscxhRRksaZ+fU/p1hgRxa12b802vyYGGkg8unF7ahM=
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id p4-20020a17090628c400b00a360239f006sm792261ejd.37.2024.02.02.03.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 03:38:49 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id CD464108A835; Fri,  2 Feb 2024 12:38:48 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>, netdev@vger.kernel.org
Cc: lorenzo.bianconi@redhat.com, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, bpf@vger.kernel.org,
 willemdebruijn.kernel@gmail.com, jasowang@redhat.com, sdf@google.com,
 hawk@kernel.org, ilias.apalodimas@linaro.org, linyunsheng@huawei.com
Subject: Re: [PATCH v7 net-next 1/4] net: add generic percpu page_pool
 allocator
In-Reply-To: <1d34b717f8f842b9c3e9f70f0e8ffd245a5d2460.1706861261.git.lorenzo@kernel.org>
References: <cover.1706861261.git.lorenzo@kernel.org>
 <1d34b717f8f842b9c3e9f70f0e8ffd245a5d2460.1706861261.git.lorenzo@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 02 Feb 2024 12:38:48 +0100
Message-ID: <87v877xfhz.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Lorenzo Bianconi <lorenzo@kernel.org> writes:

> Introduce generic percpu page_pools allocator.
> Moreover add page_pool_create_percpu() and cpuid filed in page_pool struct
> in order to recycle the page in the page_pool "hot" cache if
> napi_pp_put_page() is running on the same cpu.
> This is a preliminary patch to add xdp multi-buff support for xdp running
> in generic mode.
>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


