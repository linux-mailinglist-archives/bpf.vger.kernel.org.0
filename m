Return-Path: <bpf+bounces-22736-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01277867F81
	for <lists+bpf@lfdr.de>; Mon, 26 Feb 2024 19:04:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B053A2953A3
	for <lists+bpf@lfdr.de>; Mon, 26 Feb 2024 18:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32E012E1FF;
	Mon, 26 Feb 2024 18:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WtCH1nwq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D007212F382
	for <bpf@vger.kernel.org>; Mon, 26 Feb 2024 18:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708970648; cv=none; b=IfPaRPzlw8NS0UhvWE+xQ3Ei4Rfc3RaXIHjDbs91zc6GqaDgGV3gIUwAuWVbXJi5Bq3GS+H6/uNCwcdiXzfsp01d86GDoVYLUJw8EoHNC6A/TQoNXHrFrvmOPw0Q9NNXEYuAfNxhX8PfMnNbhRaHBX/n5/wZHhPp0oEKBbXHZsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708970648; c=relaxed/simple;
	bh=1o5Kqujg298VvN9Wi6kpa6sxG0RtBGRJWcSm3OLotxU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Ty5GHnHytLPydnN8GzghRDs/zjnA3V6eTez0/84fTc2lBGIgmcZtr73+1t0al8QuliIaKlgYwZRxJowch0GJP0SoMa8iyv/posq6mJEm5rQ6T/LUt+lnxBUr5tT0beUNwNQ11pJD69xvmV5z4ntwegHIgqxUOgOXPM/UFiRcgO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WtCH1nwq; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6092149eb55so1995837b3.0
        for <bpf@vger.kernel.org>; Mon, 26 Feb 2024 10:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708970646; x=1709575446; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1o5Kqujg298VvN9Wi6kpa6sxG0RtBGRJWcSm3OLotxU=;
        b=WtCH1nwquXKgGfwOzbAHJ5SdTAPP0fUp4XspkG/1OUenDPlDdIPHyWsEmi8LSWTouH
         K86licjjKFNFt736Rm2+KJ40TvbgPuzzbkQd5icAsfONzAKgCjwx2JPevw/J9aXRFbtd
         W3q0lolQDopiTUlzCnEb3oBM9utQS/glKI6KTS3bEXTdHK6bPWwo5yDrlP+EwsraTw5M
         93rXZrPS1hb42itoepB/wE8j6+89YsyR9ztAKzhQObqBP7NBVZWyQ40mUVWuG14zRegr
         2ozpnWg7W8BuaRHM8cXTahJuOyuj54asovvMF/t2xrmEBVSLZCot/9ooHVJYUHb0zKNH
         7R6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708970646; x=1709575446;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1o5Kqujg298VvN9Wi6kpa6sxG0RtBGRJWcSm3OLotxU=;
        b=JvheQNC1xT4z9f4FFDGzFp2OJ+7MDHMo6Cq7hqtSzx/LzZYMZc6SxUwA4zEm1/IM17
         KqcTye0DeXpOTypf4Rfz1miUaXUYRW5UDo1fnWRI6kt9jjmhACdZbXMcpxazYm5VhES0
         NoUNZa0DFbMO768bXUc9gwtW6pbpRDCC0l9gObJ4MAHxyQnZ7qzc9uQDFnwdaXE6sUEV
         VQCZGapugRkbyHkeIfs8dhLMDW7iGt6AwAGO5YD2mzMlP9nvujbrkHqTva2J4lHZBNZ/
         8zB9N/9Q51O0Ym52wiL2LxD7xk5u8/ftnXOcKLAf+H18DWtMJzwQxT1Eqz/DkenAMQDm
         8IGg==
X-Gm-Message-State: AOJu0YxxnhQc+07sI6QC5k3fcQgEYBW7k+wJ62ekQUil4deUsJtdwYIp
	ZXy4HnzxrQ6k68XIlEluJ7+hdSvTCqjlBZ2v7Sa+Y2BjgJxGGrSC6oz0S4fDH3yf9z9ynZNlx54
	FheOeqkoDYlWMNkv9fvvlk1K7UkT/Ev7eMpA=
X-Google-Smtp-Source: AGHT+IGvK0WNaPNkl8Ejq1O8ZTo+ljd/pAuzL9D126KorKGvkEhSgkkX2x7J62+zPnT3u6/joed46KjJf5IlIrAVIbA=
X-Received: by 2002:a81:b107:0:b0:607:d9f7:e4fc with SMTP id
 p7-20020a81b107000000b00607d9f7e4fcmr5128209ywh.5.1708970645774; Mon, 26 Feb
 2024 10:04:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Amery Hung <ameryhung@gmail.com>
Date: Mon, 26 Feb 2024 10:03:53 -0800
Message-ID: <CAMB2axOYHKLQhR9b50oVgvUDXeo573amqpiXRot51_JZQcFuiw@mail.gmail.com>
Subject: [LSF/MM/BPF TOPIC] bpf qdisc
To: lsf-pc@lists.linux-foundation.org
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi all,

I would like to discuss bpf qdisc in the BPF track. As we now try to
support bpf qdisc using struct_ops, we found some limitations of
bpf/struct_ops. While some have been discussed briefly on the mailing
list, we can discuss in more detail to make struct_ops a more
generic/palatable approach to replace kernel functions.

In addition, I would like to discuss supporting adding kernel objects
to bpf_list/rbtree, which may have performance benefits in some
applications and can improve the programming experience. The current
bpf fq in the RFC has a 6% throughput loss compared to the native
counterpart due to memory allocation in enqueue() to store skb kptr.
With a POC I wrote that allows adding skb to bpf_list, the throughput
becomes comparable. We can discuss the approach and other potential
use cases.

Thanks,
Amery

