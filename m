Return-Path: <bpf+bounces-50131-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73655A23224
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 17:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B6623A3D95
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 16:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF5384D34;
	Thu, 30 Jan 2025 16:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bg6Al8qW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791B21DA5F
	for <bpf@vger.kernel.org>; Thu, 30 Jan 2025 16:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738255419; cv=none; b=k/MMFEyWkRrPrq4tzE16VlQCKNVd4BXDVwnGGNhfc3xRLWEuOCor176wmiFBv+O3XZt4q4PPPgikieyvb1/pVOj/irB5T7kS4PnduePA/FnzFMswKFNWZ56V8kL6izVcTM+bBXejGAb03D1QvRzpOvI0xcY4RZDf5TRUB8ZIPA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738255419; c=relaxed/simple;
	bh=wm/GjTYZmSoQIdMarvhxBrtJ0uNjvcCc+5oIO1kYldE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FVZ2tjv8r4Hv/9KTdLBi4ZkD0CfWvAqjdxmLyo6dsYrGW4ol1Sjg3Ke1h5HVoPZUJg2DCQU8FKHS/GGAyi7rTDyN3bCADwHruzwGii9kESu7H4uGW0wE71VCngJrbsOilr54I4Rq5/5jBl8kdN7E3yW+scaCylmzuqaMFVa10e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=bg6Al8qW; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5dc10fe4e62so1910317a12.1
        for <bpf@vger.kernel.org>; Thu, 30 Jan 2025 08:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1738255415; x=1738860215; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fuEDpAnG1sazTNLQRV+DgH04oKDY04Gu9xv5BY6PwaA=;
        b=bg6Al8qWNjOIsIkYn32MqsFgVKXQfWjbc8i6LeupsbUbgqV4HgRfmV5xyoYn0sLgog
         0IAZWOicR26UtEHlQZUYTG5iNfTZqNv+W4M/+4jfe8ViCZsZ/1mKmoi8UrDL2iwYTt61
         dRml0PZyMGOoo8tNtO2c8Nk+rg3gtes46CWT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738255415; x=1738860215;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fuEDpAnG1sazTNLQRV+DgH04oKDY04Gu9xv5BY6PwaA=;
        b=xR4yIb1SqcGVolYpl0Y9hawHVlDwzIuzeCOQhiuz7J13SvUk7foEq0orLafirx+9YI
         VayIk7q9A5QMcYfJ1/vGQU7sGGavVeoBqwX8oQZp8LurgnoOfuevS1cxw7KPJgJIABpo
         1thx5kHXLI5eOPordf4C7BWyzuhlI0YKHmHuJFRSBIT082VgCRN593fL9HB+8dO0mh7s
         4WZJIUlARrCwLNk73ar9b4WS/ECXHCuk6/82t30kD7H/mel/LoY9P5IpOkBzBNCppQ02
         jnXy/U9wYqq66fXx0+ZTjZ28TRaZHtV229Hsij39w95RJRgcnbMiSe+phe92wJP+AdVO
         hSbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqp67UWJ+a1KG8+ch1cawXIjkMW3FufwrBQ/3mulBUbmAfdpJsK9G+baamTXk3x/7HiiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPuTpPZYn7J8Di+aDt5ja3yy31LJ58DT0xZePHEgxi/eJmDa6u
	UiCPdq33MyPZ5n76mLjWh1QoGLkdGRsx7QBZWzH4PBp8sZVkDa/pbVGiymyDvFxS5jvPFmVGMmE
	TYx8=
X-Gm-Gg: ASbGnctrIwctMudMgKX39fkPnCtOlIo7En/7blKQNbnNWs1ecqFRKINaqDeLRBWgsrB
	JLY92MMunzHByGaBSEr0/eln+7v66k8jfXAQZWE87Rf4IkZt2NkRgutbREKjBdUVoudAehzmteQ
	q9ui115qQ1HCVI1bpGHOTtb6AU6PiYsy3Lz+fLDakjPZCFnSIe3jpn/Al5PyNpGcx+tWKr661Fr
	9dOuQE5N2iB6gDYbIgY6Le1lHVFUdLyE3ulYWlYkGhsnln25xO8jO7DcL874Qsxlno9AAm7iysq
	BFKeiRoR3yTcYFb1ne000uWhZv8gACSLJ/vpkvY/+7XereJovRCzmegWNejncMTFLQ==
X-Google-Smtp-Source: AGHT+IGWtDxLwf4XHhh/7f9yTTISlozsMokZzUIdM0bEmAzOkiHgcrM6FXA7mpACriUzYdH9W7yjUw==
X-Received: by 2002:a05:6402:a001:b0:5dc:7f72:5eae with SMTP id 4fb4d7f45d1cf-5dc7f726000mr370147a12.23.1738255415518;
        Thu, 30 Jan 2025 08:43:35 -0800 (PST)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dc723cff7dsm1325987a12.11.2025.01.30.08.43.35
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jan 2025 08:43:35 -0800 (PST)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ab651f1dd36so218769666b.0
        for <bpf@vger.kernel.org>; Thu, 30 Jan 2025 08:43:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUAjE2KYfT8RU9KwlwVZ778X99rmKMjmeZI17+I5BRfaijgfaO67Iiqmniz/5cZ+tXUC7I=@vger.kernel.org
X-Received: by 2002:a05:6402:50c9:b0:5db:e7eb:1b4a with SMTP id
 4fb4d7f45d1cf-5dc5efbd32amr6334804a12.10.1738254929601; Thu, 30 Jan 2025
 08:35:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AM6PR03MB50801990BD93BFA2297A123599EC2@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <AM6PR03MB50802EA81C89D22791CCF09099EC2@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <20250130-hautklinik-quizsendung-d36d8146bc7b@brauner>
In-Reply-To: <20250130-hautklinik-quizsendung-d36d8146bc7b@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 30 Jan 2025 08:35:13 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjLWFa3i6+Tab67gnNumTYipj_HuheXr2RCq4zn0tCTzA@mail.gmail.com>
X-Gm-Features: AWEUYZneNxaHhpPSYfPAUA_rUTrk891uuSVIWZIkTE-aPADGZkPCsAjzruuXyrc
Message-ID: <CAHk-=wjLWFa3i6+Tab67gnNumTYipj_HuheXr2RCq4zn0tCTzA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 1/5] bpf: Introduce task_file open-coded
 iterator kfuncs
To: Christian Brauner <brauner@kernel.org>
Cc: Juntong Deng <juntong.deng@outlook.com>, Alexander Viro <viro@zeniv.linux.org.uk>, ast@kernel.org, 
	daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, memxor@gmail.com, snorcht@gmail.com, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 30 Jan 2025 at 08:04, Christian Brauner <brauner@kernel.org> wrote:
>
> I deeply dislike that this allows bpf programs to iterate through
> another tasks files more than what is already possible with the
> task_file_seq_* bpf api.

Ack. This needs to just die.

There is no excuse for this, and no, CRIU is absolutely *not* that excuse.

In fact, CRIU is a huge red flag, and has caused endless issues before.

We should absolutely not add special BPF interfaces for CRIU. It only
leads to pain and misery.

           Linus

