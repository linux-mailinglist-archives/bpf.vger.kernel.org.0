Return-Path: <bpf+bounces-42889-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC25F9ACA92
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 14:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07D001C24A40
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 12:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4384D1AC88A;
	Wed, 23 Oct 2024 12:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="bxBUguhD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D88130AF6
	for <bpf@vger.kernel.org>; Wed, 23 Oct 2024 12:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729687895; cv=none; b=ns4rfUKpEDzTHbGl5Ua/2l+PhU3ok9HN+R/MrD5taoop6jxH/nxxdXrkrqRrC1pG5QylL1pS26fYrZkMsxp6+IwyVczJiBDgwybsfzt5DPI7NCwK+0GUSbG+8uAy1nlmNR5USuG/7kmMinMYcY/ZggChSIg8rsUap7QVYFMzZFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729687895; c=relaxed/simple;
	bh=TovBOQATkiwwKIxO4H3TUcSLMe8jpyrG3L3TRxI6sN0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ptGw+o7uhAXGvXgoQyZizpW18syUGr84DUCB2/K2jn5JKQhIKF7+yxESr+4PsMHXD7lBigwdDUJURaL1RNvoQhwXgST7qo1i4LHYOICKRBrzOapCVZiqDpmKAdrIWGFIqVdumqQKHfn9/NKi3y9+meue3CSedDnQIg24Xldnhu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=bxBUguhD; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a9aa8895facso349147366b.2
        for <bpf@vger.kernel.org>; Wed, 23 Oct 2024 05:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1729687893; x=1730292693; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=TovBOQATkiwwKIxO4H3TUcSLMe8jpyrG3L3TRxI6sN0=;
        b=bxBUguhDf4cIVtUUuTF1BtqHyITSNCNjf3kMgKC/oEb9sIFm6DaycAIDvIpPembEEF
         9VdMpOckCGDwcj18VAnsNE0Xh49Nz6V9w+zdaQxNH5eL/5yGcMS6zfv4sRB4Lxau61/j
         K+nBvS3ABuyIDZCfkGnp3C0TfHjDZSp1lERBb/IdaZAFHxhZAQwIT/G3ulc6ACUnNTuM
         LadfeCzl58HgEM4rNtkJhjm+QZHHrdsryjjAfqMo2mljgSWfYqoFZeDDa4MJ6usnO+2x
         tFNvzGMP2ckWGMoeWNm/yOEcScqqCX+n9ZEjzid9AkOo9KqhquUsPHtIasAxA8BWq4y/
         91eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729687893; x=1730292693;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TovBOQATkiwwKIxO4H3TUcSLMe8jpyrG3L3TRxI6sN0=;
        b=lbAAumKB3VbrEwVsCvBbxFaDlm+FzecRGg2lSFyAlH8T3TWxV1PdtY5SNMwxytVlqq
         R6PEZ8prPpD4pINsVSILDnPQFpA7tsSPNGsIfLhEKcjv8lHhVBii3xFxC5j6eKHBMdr3
         241Ysq9jQ++6xUR/6GvN2JZUz74d8zPJvFqLRipfA/7EP0hHXKrw1jcypp5xAcI9imHa
         b7si8Khvny+X6xQmSyUYjkbmEeoXYeTsnRyZPODmq3P8HX828ymtZ0Zr5PIA+l415GAw
         5osRqhynZ0B6EwRe64htBjnTIc8zWG3XrmsQZhxpG40aQkJ3nQSD9cgGUTMLTOocYzrc
         n/wA==
X-Forwarded-Encrypted: i=1; AJvYcCUeXO1fyyIojfxjLKPVj/1MteA4RRzqknV7e2y/KG4OXIWXUZyqZpSAYpXM7yFR8dKgCxA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxftSEXTgSwe4H0fApxFMBAHxV8zjbbOfDfWZYJNInZaQW29TL0
	gUs4FRzia4M9L3wU1Io9Y7Gnke9CSAa6//gZJgGBXtsscjaK8yR5qFe0U9Ot2II=
X-Google-Smtp-Source: AGHT+IHrjgt4Dkx3BECaxc7v3qZRq6Rtql9zV1QQu5ZkLvd+JW8V+GyN3sCO1/kMf+Iws8Ie9m0gSA==
X-Received: by 2002:a17:907:7b85:b0:a99:7676:ceb7 with SMTP id a640c23a62f3a-a9abf86e15emr233239366b.26.1729687892600;
        Wed, 23 Oct 2024 05:51:32 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:506b:2432::39b:12])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912d6597sm486590666b.14.2024.10.23.05.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 05:51:31 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Ruan Bonan <bonan.ruan@u.nus.edu>
Cc: "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
  "davem@davemloft.net" <davem@davemloft.net>,  "edumazet@google.com"
 <edumazet@google.com>,  "kuba@kernel.org" <kuba@kernel.org>,
  "pabeni@redhat.com" <pabeni@redhat.com>,  "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>,  "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
  "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
  "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>
Subject: Re: [BUG] general protection fault in sock_map_link_update_prog -
 Reproducible with Syzkaller
In-Reply-To: <TYZPR06MB680739AC616DD61587BE380AD94C2@TYZPR06MB6807.apcprd06.prod.outlook.com>
	(Ruan Bonan's message of "Tue, 22 Oct 2024 02:36:23 +0000")
References: <TYZPR06MB680739AC616DD61587BE380AD94C2@TYZPR06MB6807.apcprd06.prod.outlook.com>
Date: Wed, 23 Oct 2024 14:51:30 +0200
Message-ID: <877c9z9e3x.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Oct 22, 2024 at 02:36 AM GMT, Ruan Bonan wrote:
> I used Syzkaller and found that there is KASAN: null-ptr-deref (general protection fault in
> sock_map_link_update_prog) in net/core/sock_map.c in v6.12.0-rc2, which also causes a KASAN:
> slab-use-after-free at the same time. It looks like a concurrency bug in the BPF related subsystems. The
> reproducer is available, and I have reproduced this bug with it manually. Currently I can only reproduce this
> bug with root privilege.
>
> The detailed reports, config file, and reproducer program are attached in this e-mail. If you need further
> details, please let me know.

Thanks for the report. I was also able to reproduce the KASAN splat with
the attached repro locally and will investigate futher.

I have a small ask - please use plain text for mailing the list in the
future - https://useplaintext.email/

-jkbs

