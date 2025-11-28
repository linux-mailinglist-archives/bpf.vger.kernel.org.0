Return-Path: <bpf+bounces-75710-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CA949C9220F
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 14:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 48D833495D2
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 13:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354042FFDEC;
	Fri, 28 Nov 2025 13:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="de0Bh3ga";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="JGevnfS7"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E8E1684A4
	for <bpf@vger.kernel.org>; Fri, 28 Nov 2025 13:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764336616; cv=none; b=soJzAdYTXRZCzvUrdQO5iYNyZVO2zh7VtLn9F3+Av/QsGv/nyTNwtOWuJ4ej7Es6Syp+9l5XrFvRcKY9LFGnKPQ+oqhGaFXvIRFm5mChnXWVl8of9tVJQws/7rt3XIJ6t8aZD1+apYnCnyCm23JINafj62RCvBK3pq3nfJC4+34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764336616; c=relaxed/simple;
	bh=r7FouT1x2dRUs6nM6oG0TeKmKc+zDhX8H6XwS8+nAwQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kdPIXLG76h9gaB8zagXsgRXpVUVUnaiVRFngqLPF+h+xGdVLlhZEJswm0g6q1JJ9bbDUl740nJVXB3elSEAJ7RfkYQvcbQ7cmSTgvvJZ2Pqh26abkL0g3BMRFx/WR1VIQ6Zj1yfqPW9ndWRBt3/huO9G/qbOSaGpu44A3FyS1yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=de0Bh3ga; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=JGevnfS7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764336614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r7FouT1x2dRUs6nM6oG0TeKmKc+zDhX8H6XwS8+nAwQ=;
	b=de0Bh3ga846stEZoABwj7OelwkR4GZDujdfx+7PBSpwi+DLoWRjWgsh86r5GQ04ioANWgj
	crcOlbU7Ne0v1G9Yn3sVGp9pLYkjEIoDamH6ylDnWYQwlhJfp+JPEOLh5MRbInfEf18Vae
	+2zx55b17ZZFxTyz5RAMw8EmmEO0eew=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-xyKtqS6rP5u-3Kgr0ABOnA-1; Fri, 28 Nov 2025 08:30:12 -0500
X-MC-Unique: xyKtqS6rP5u-3Kgr0ABOnA-1
X-Mimecast-MFC-AGG-ID: xyKtqS6rP5u-3Kgr0ABOnA_1764336611
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b70b1778687so139570766b.0
        for <bpf@vger.kernel.org>; Fri, 28 Nov 2025 05:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764336611; x=1764941411; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=r7FouT1x2dRUs6nM6oG0TeKmKc+zDhX8H6XwS8+nAwQ=;
        b=JGevnfS7Q4zj8wXKdHxGGVePrgsrL0YbocLclI8+2P3stqTS8IAVOeFyyTpUI4TVkk
         loiEIWTxlJABf6zQQUCrXKg5J87b5qRIda71+WM6aEYFLHX/lj+B25D4/kTuMH4Qz+0a
         H12TVftf8z69Tzi1RY4leOOsvs6uz7t+Fhragr0zO2GWQiXph+lm8QXiMlRZqPQIZyHD
         XOawYiwv3pVFVKSKoTGx3qDGjLBxi3DNu+rWFMQsNshKr0Kutp9gxU2Jaigkvu9qc2J2
         dQmeJdd4hYaXAMSkmOCaB3+9g7evXUi18Uiyn0AwNk6c7RMswiHR6dx7A6oRO7nBO6aT
         B/FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764336611; x=1764941411;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r7FouT1x2dRUs6nM6oG0TeKmKc+zDhX8H6XwS8+nAwQ=;
        b=vYjcyl5IFengyqRx25L3WMZAR4/CJb79q9vhPtq4R5hqAdkRt2h9V10zdxG4q4c+eW
         eLsVwBk7uquGjoBUIJ2BcQb3cbxHnUCl0M84nQJQi9XP1bS1a0SyCZcikmv35jhhJJj+
         YpEln/SwbVx11L7S5/Kxj8Jyt261cww/g6PYNePvjmp3FnYlNeZvVSdNOXJIg80bmt1X
         7649g5xneXm6Mje3MOwXjk7OI7lK4wDP4h2Oe/MoqV9FEsKaIh4sl/yZHxKUuGV9xv8L
         8sSSAMgtQp2F/PrgXHckgO/i6p4JImkgRGk9eltlYgd44W6MQlRlGcTQy+TFAkx2bpkq
         yu+w==
X-Forwarded-Encrypted: i=1; AJvYcCWw24SGl22u9OvWcQDJG8/gSAoFtC6r7avDK2SiIdC510gNFFqFy8QuuCqR59ruZCkZsAw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwl39HwrB4U8MDwrpTekrHH0iBGPjntBnLgs79+sgPo8b39fL7
	+Vp8D7fCb2L5yx3uqmRWAJnvRV8xlz5rYvqMB7Js76GdW9suMJr0iysDiJkjcjnhkjPCe/bK1fL
	1ACa5zy3hJwQqshgiR2PoON42NZ6Zpx7H/jkudzFTvVHAo6IpRCaiRCklGi1ieOnbwuGD+9XLqO
	WyVmk2xjtfWQi4YbGhv0bnOzbpve+Z
X-Gm-Gg: ASbGncvB9akcC4Ku95IqkjlQho2xe5pqmVdBOCZ7jXG6MJ75G468z7zRipZSW6ckQGz
	354Egpw3V936us9vpk+dfR698bfue+DlLXbAXIIlivKPufCKy0DFNQtrF2m8meqhIRAfolreMrP
	LBdt1c0hQ3frLZszFJZDvz+uTlBVFJlAhylKSry1FiPhNr/Ryr4VYdVJGm6Y/Vl0+WHGRpf0pNQ
	1JSpr0pU39UNnCbI+z2vkwR2VwV
X-Received: by 2002:a17:907:3f9c:b0:b6d:5bc3:e158 with SMTP id a640c23a62f3a-b76715abd36mr3024375466b.17.1764336611324;
        Fri, 28 Nov 2025 05:30:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEQBMc+jdR6VKe7qvu+OoNY3CTuO3aeqFl+E2pE3HNfuJdzO5dLePN/skocMuCUXp+HXT3tyPTBQ5sE12XnkZc=
X-Received: by 2002:a17:907:3f9c:b0:b6d:5bc3:e158 with SMTP id
 a640c23a62f3a-b76715abd36mr3024371466b.17.1764336610818; Fri, 28 Nov 2025
 05:30:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251117184409.42831-1-wander@redhat.com> <20251117184409.42831-2-wander@redhat.com>
In-Reply-To: <20251117184409.42831-2-wander@redhat.com>
From: Costa Shulyupin <costa.shul@redhat.com>
Date: Fri, 28 Nov 2025 15:29:34 +0200
X-Gm-Features: AWmQ_bke2XaKTo8AW04BHiRxXmDpA26pbLYoxGuxq-b6dvmBNgbC2XPMHD4669I
Message-ID: <CADDUTFwK=TuhMcfr9C4NXOEQc89wBvdZtv+DtYFuHfc9wh5R=A@mail.gmail.com>
Subject: Re: [rtla 01/13] rtla: Check for memory allocation failures
To: Wander Lairson Costa <wander@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Tomas Glozar <tglozar@redhat.com>, 
	Ivan Pravdin <ipravdin.official@gmail.com>, Crystal Wood <crwood@redhat.com>, 
	John Kacur <jkacur@redhat.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	"open list:Real-time Linux Analysis (RTLA) tools" <linux-trace-kernel@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:BPF [MISC]:Keyword:(?:b|_)bpf(?:b|_)" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 17 Nov 2025 at 20:54, Wander Lairson Costa <wander@redhat.com> wrote:
> Add checks for the return value of memory allocation functions
> and return an error in case of failure. Update the callers to
> handle the error properly.

Would you like to consider using fatal("Out of memory") instead of
returning an error code?
Anyway there is no work around for out of memory.

Costa


