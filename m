Return-Path: <bpf+bounces-61310-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C01AE4D2B
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 20:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19C997AE921
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 18:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8EC2D4B4E;
	Mon, 23 Jun 2025 18:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="qyOC02ZZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E03275855
	for <bpf@vger.kernel.org>; Mon, 23 Jun 2025 18:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750704664; cv=none; b=d1Awb/c28mUz4kzXT1HeabcUF9KcKTz3rgJ/VU3e6kkV5olp0Tc5KOVqBIJNHjpxmANmOpwVQHHMpu8k2Wp8t3QT9Uhxv99OTY1PNpRHpASv9RVlBKLrFSaAlMhmdqrZbQspDY7/ROcBYN2aTJrcglFa0YP+7sJ5t00dieyxFg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750704664; c=relaxed/simple;
	bh=MENNiB47ARfrRof7zF+FTgET8QudttwxIgBicUQaruw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kGcohvCjEK/tw+c9CyzHatio4i9JnUybsMloViQRQ+1pM56PqQR5yXHmaVcenyRvROMnmRLwf1vUmAI4Nyi67nx0ZYDPkYYQMjjs1BRkTEbV3WpNRKdEfgNhG5pLaznF9dQN/BqNIa5/Z1A1sZ/oINnEY9amD7GAFZ4N286T5uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=qyOC02ZZ; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6f2b58f0d09so5208036d6.3
        for <bpf@vger.kernel.org>; Mon, 23 Jun 2025 11:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1750704661; x=1751309461; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MENNiB47ARfrRof7zF+FTgET8QudttwxIgBicUQaruw=;
        b=qyOC02ZZANMrjm2mvJF9cCDKNqk277i65QEU97t3fdX1+IxrNVG2KCbJFhPv5vEjvM
         g4uf6iZ1facAwK8a+XYE5COVzQDHvqlBxnDiIyZDqfl/oTQdoL8KuMPTHxGGBzSqQmhY
         9BxDCK7Lv8qiBZVPhoXGPatraEO4gXCJf0bmMlBZyKuwiDXAnK9FMzjwEBm8/EG5IHzn
         uVTsr462T6sw4ncMx0OHyWnpQ5hWalD85pwrSTlx/udlsspQr1geuk1j3zpsvZHQrRKS
         QYReC6yX6p6c2Qe+M71TTu+5gvYJssfz2TiDFBxGZEJiT0ZDn//Kr2xH5gFG2jWUr6LP
         +Zog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750704661; x=1751309461;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MENNiB47ARfrRof7zF+FTgET8QudttwxIgBicUQaruw=;
        b=sy4HlwhjWOAAJKcLNjLv/tFqJNmhX/sfOz5/igx7ESQ6Zo5IjSaRH+DwbELFrCMWUd
         S6h21jInC0/zLMDvjKgQoEMi+WXZ+9wbaAzuTwMVPsBOUBtajpyEQoCv1mpQmF9D1Z7j
         p6nq1YAYtx/FlsTpU3AWT6fqY6Lr1AvwYrB7qdCw26TNjDMM0+Op57sMXwdkdV6XW9gk
         80DZJkxWv34+V1EFqiVMUAbMFRCTG/Hur1YWxCo8h/g+kTOEaGXcR9tTI54ali8XNqP8
         XgIQf7CcVzT1sFRR1b13bKCYP66dNdSlEirzhVC224ioxfObeUmBZDwG81OC7bUXwr/y
         EzPA==
X-Forwarded-Encrypted: i=1; AJvYcCVmYaAVUUvBNajao8GYWV5elMPOHJZoVxfsjS9yldpbEwjj6rI3MIp3SNQHbbpFNVPOi9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9+8Y3EDFujTQdwptueIEClVL80EJfguLE8+adHMpNf3Lz1GZT
	VANHSwXaxty7lW1IxRN5rfO1iTlCPb8uOczZmDhkUBavcWTOnOoe47tyhJvH35yo5ZPqW+7nF7m
	ZvUsweg+xu1ZSvGHDfo9NaPKlgBF2/fRi8LymGzT/pQ==
X-Gm-Gg: ASbGncsZQMr+m/d4gTTUeaLRk1m2f+IvZQ3L3Yry4e9rNWZ6tVL0dETRozdsTXxjYQv
	L6eNFdB4nGRwCX0GjJarxjLFxZUsUng/jNqm9ZVCYTY4t4/Lx/d6buD+9/c+2IU5cG9frRe6UEz
	SaBFoDXveUpa7lgiPbev5PuPvBAqzHzf/sedFdWCzHE6lp1M9f+d9AaGamotcfBqFZzmE2O/2uV
	g==
X-Google-Smtp-Source: AGHT+IFjRTyh3BhNQGSpDJwA4Y8k5h4VTdSAkddD34WQYt8I1CVULAUJbWZ4lMMErL0OuM80ZNKTzEio4ZwKmW8lvT0=
X-Received: by 2002:a05:6214:cc8:b0:6fa:c83b:3ccb with SMTP id
 6a1803df08f44-6fd0a550185mr89910746d6.10.1750704661260; Mon, 23 Jun 2025
 11:51:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618162545.15633-1-jordan@jrife.io> <20250618162545.15633-3-jordan@jrife.io>
 <aFMJHoasszw3x2kX@mini-arch>
In-Reply-To: <aFMJHoasszw3x2kX@mini-arch>
From: Jordan Rife <jordan@jrife.io>
Date: Mon, 23 Jun 2025 11:50:50 -0700
X-Gm-Features: Ac12FXzpceQbsVnaTghml0crzRGQqb1zNzsIys7npUCZYInuQ8PhEKrgKf6o8x8
Message-ID: <CABi4-ohShEVsXfNhMBHqsBFJ4NQUP9zq_Pq26WvFNohjoWFj9g@mail.gmail.com>
Subject: Re: [RESEND PATCH v2 bpf-next 02/12] bpf: tcp: Make sure iter->batch
 always contains a full bucket snapshot
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset="UTF-8"

> Untested code to illustrate the idea below. Any reason it won't work?

In theory, I like the idea of unrolling the code a bit here to make
the flow more clear (and to make it clear what's happening to the
locks!). IIRC there was some reason this was hard, but I will think
about it a bit again.

I also want to make sure things stay relatively consistent between the
UDP and TCP socket iterator code structure. The UDP socket iterators
already do the `goto fill_batch` and `goto again` thing, which is
where I borrowed this from. If we end up diverging here, I'd want to
go back and update the UDP code as well.

Thanks for the suggestion. I'll take a closer look a bit later and see
if I can work this in. In the meantime, hopefully Martin can chime in
as well. We went back and forth on the code structure quite a bit in
the patch series for UDP socket iterators, so he might have some
opinions here.

-Jordan

