Return-Path: <bpf+bounces-21708-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3862E8504C2
	for <lists+bpf@lfdr.de>; Sat, 10 Feb 2024 15:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD70C1F22213
	for <lists+bpf@lfdr.de>; Sat, 10 Feb 2024 14:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F915B694;
	Sat, 10 Feb 2024 14:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QDshMMaB"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB6137153
	for <bpf@vger.kernel.org>; Sat, 10 Feb 2024 14:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707575858; cv=none; b=Hlh8gP06RNBGCGOsP/8YshFTW1SnmcwOk7DK6hpnSeP0jUf7/+T+vF3I+kEHh/5S2gUqWCNDd4Gdjxc5K4xioisGu4+vGZKDEU7KsTCrDzqGM1DlhQkUKdDd3q9sUKdusCAsk+hljB7v52Q+lU7J/SJRCzop/s45fpuxnhHZ5cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707575858; c=relaxed/simple;
	bh=pcaKJPAQrWYnh5Tex6k4bAAQOTVLi1Mlp6lIgQdGlXs=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b/Kds1oWrAfCb4Ou+3nR44T/nRpJDsJ7S5/fPoMPVefRrNac19YzNaFKm4T9LKacdfCm04VCmcgupImkRKhZzO7LaVWyDFmqNkXyC+/joIIYE1hLfKz9zYZBS2d++Hf9JUOLyKdMQBrIl2LwL5bBA+hf6EUKb+xarkSAwUlwr3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QDshMMaB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707575855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pcaKJPAQrWYnh5Tex6k4bAAQOTVLi1Mlp6lIgQdGlXs=;
	b=QDshMMaBV9V16kqLsM2L74/OjHgLllv466+qfHZKcrchpxAaRY4SG4y1jJuL1GYGChd1b+
	UuHWRd132F9GV5fo9Yr4mXbuLKawzoHb1dlmTGFAVN3LXIkncX3dzhs0KRksDJDk8LodGw
	tg15ztl/LSUBJqafK+4Yvz75Rx3Tdow=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-vnKj4nbYM_SjcMVUGJ_-HA-1; Sat, 10 Feb 2024 09:37:27 -0500
X-MC-Unique: vnKj4nbYM_SjcMVUGJ_-HA-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-560d6fb3b7aso1001030a12.2
        for <bpf@vger.kernel.org>; Sat, 10 Feb 2024 06:37:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707575846; x=1708180646;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pcaKJPAQrWYnh5Tex6k4bAAQOTVLi1Mlp6lIgQdGlXs=;
        b=LZM7ZxFNJ0/Te1OaAuitg3SS9/Il6Xusy78DXVwKJd5Rj/hD0J/0G/dvM3gpIuUvIF
         TFz2U/LMmLz4BMHVYHf5r2Ld0j9NY8Vxfj6oNy6nO0xJAgrhjFBkD/y0xem5WCKjmVpr
         cJRPiwINYzasDWv5iTnPJx3bxfngtnV3N2YF3XzpJGM9/0zYvJTViQC1cQpzfywpgdK3
         XOuXJ7VChE73qS3VowhHtW99RlZ7PQTAhYkC/S18fKbVTBh3m6ye5M8y2BuH7+9nM72S
         L6ZAmiNkcThZZdTncpjsPBmYvv132fLZiQ+1Dp1OQBvBOPcRa0C1eLdrB8eRo1sDkG3g
         PXMw==
X-Forwarded-Encrypted: i=1; AJvYcCUQ6FB+997dTdHVWPrKxTZEuph090K/02bQ4Twgg6CGZ9kbPotCQlvaUBbWUuv9SNiLuCQGWgGdYrGAXp7uQOJHv8Rj
X-Gm-Message-State: AOJu0YxkR/HJ3pORRZJFIJUR8BIebl3USP9bkzgYzGuL5ASeUuZ0PfJ/
	YF0CfL11xVXGx8tD3Sz/1D3GVJAkBM0ZUsz1ZHYH1V8//kxkgV7eiCspSvbCPsO6l0tB6QxHaGL
	Xhmol5yJQMwm//+kP4ni6mpFaFMep7dpGtpcm7q3cyQ1y7W/4zr0itKEUJV22gdO62m5qoHbbQi
	BOLzpviiaYOR1OWHwF1NkhzEjO
X-Received: by 2002:a50:fb98:0:b0:561:199a:3304 with SMTP id e24-20020a50fb98000000b00561199a3304mr1295802edq.39.1707575846656;
        Sat, 10 Feb 2024 06:37:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFfl18hXRoevzJYNEa+uuAZsx0VHrEQrKx37BOkP/jOngpqgXS94QQGk6D22T5hiMwjARbVxpboZYNpLAGcKQw=
X-Received: by 2002:a50:fb98:0:b0:561:199a:3304 with SMTP id
 e24-20020a50fb98000000b00561199a3304mr1295786edq.39.1707575846367; Sat, 10
 Feb 2024 06:37:26 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 10 Feb 2024 06:37:25 -0800
From: Marcelo Ricardo Leitner <mleitner@redhat.com>
References: <20240122194801.152658-1-jhs@mojatatu.com> <20240122194801.152658-13-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240122194801.152658-13-jhs@mojatatu.com>
Date: Sat, 10 Feb 2024 06:37:25 -0800
Message-ID: <CALnP8Za9T2hkZ_HMQu2FkuVkSR6azs0WrfT=m1MmOxDWDehZEg@mail.gmail.com>
Subject: Re: [PATCH v10 net-next 12/15] p4tc: add runtime table entry create
 and update
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, deb.chatterjee@intel.com, anjali.singhai@intel.com, 
	namrata.limaye@intel.com, tom@sipanda.io, Mahesh.Shirshyad@amd.com, 
	tomasz.osinski@intel.com, jiri@resnulli.us, xiyou.wangcong@gmail.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	vladbu@nvidia.com, horms@kernel.org, khalidm@nvidia.com, toke@redhat.com, 
	mattyk@nvidia.com, daniel@iogearbox.net, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, Jan 22, 2024 at 02:47:58PM -0500, Jamal Hadi Salim wrote:
> Co-developed-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

Reviewed-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>


