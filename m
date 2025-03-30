Return-Path: <bpf+bounces-54912-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D23A75D5A
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 01:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9301188A6EE
	for <lists+bpf@lfdr.de>; Sun, 30 Mar 2025 23:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716B11BD9E3;
	Sun, 30 Mar 2025 23:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kOYHZ6xH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B6319D074;
	Sun, 30 Mar 2025 23:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743377355; cv=none; b=KXc94WfbiGNiUG2XzICf0MKXjRIrSQ0LvZGdDWVGBpM3Kr+LUGuOmWwjJvCkGabGO3odSjFrD9os//Qg1znPQjTbt34rirsHFvukiOBCzNMdwcD7XduPZIg1t+2oKfMkzQzBNWjQVtgg8HDKo9zfwQOkDfYHPGxTLZbR6jP0A2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743377355; c=relaxed/simple;
	bh=hxLHOo6kyERUZO3kQ/BGWhjwfTS+i2YDJevUnaDa2j8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=pvpCVr6I685zJAfdH8Q+v4jtXCamhDbdw159XPgqXAUWyyBg7n13GfWaqIIIfr/HcIffD4tf8WWcCJIa6HA7xuwmTR90zv0LSVZl8hORxSrenJgxOEuNRWElEGwsRxGfeNa5rDa+1d4XQGBdhyu2CrOucZW1W8D+poyp25ZHOfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kOYHZ6xH; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3912d2c89ecso3477827f8f.2;
        Sun, 30 Mar 2025 16:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743377351; x=1743982151; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9I+Xp8yRzQgrlV/+8pCg4bGECNRPu7ru1Ity71eMj/U=;
        b=kOYHZ6xHIMiBEQPgktD7Sj6aXrWcYzS5P6acCuT9L8BNAhJl2eIebB5Uc1obXhpNHv
         LIPAGym83vpRSgkBM7bYWMI4P7dZ6XB6vw0W+WpMaC4xyHPt3NDPPSsQWPyCZDNX9WyN
         70gw/XVMbdtM7ZJ+HOUJ+tyZH7bslCpREjxG+VIT9SW5a7Wsu9TO+Iug9lH6ot/LRK01
         64QKh6QktBThoYffqhuEATFUHj/Rw8IswHmGnMQ2EV9jL/RxF3/s3Yizdcq2PM08FrNe
         iTmN2XVRMpuKeW0tW9DE0gIkLSAQe6zjAjOryflO6Z44wMo+YoLEYrnop9yS4KzANV0H
         L7Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743377351; x=1743982151;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9I+Xp8yRzQgrlV/+8pCg4bGECNRPu7ru1Ity71eMj/U=;
        b=TJVsL9eJwH3jXhj0KUN8irx2sgOTn4PdULooyLxCHU87YvalPnkoAQOJnUvjOC6DVg
         Wd9rEMdQvuhg9x9XxtiBPxcGqfepvZ+3RiWXWuEmxQf9xlqmMtrxXWOXhxKlJIdlHWuq
         x12IjrUV+R5BOpsZCQDeb4HGTSf17YeOKZhqKdVXzO8JzGAcIQh7ehXLVPnry9DoFhAV
         M6DY3fer4sWOo7M0VaOmY8lZuozxHI2GUY464GtxvyvqkptQyg9TSe1kPhlBBDKXunKX
         mg69rKDMNLPcTxR1RFRFBGnj+AGsvz0XwBv4Ccn7pN8Acs51Xa3HXtvdep3o7P0MjpA/
         HnRg==
X-Forwarded-Encrypted: i=1; AJvYcCWw61uOzj8nXYkKKaDgOEvhZD5mbITh7UDUIB7xEZSGcOZhhccAfmrHk8cwAlEfrBDRR1NQ+aQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXvesW62ddvMmBVKVmUX40jhZdA8FXRsUBkfzJ2o+laGh1hNhX
	fkmKf0tdY171o19pUHyl4kqOg/ilIUQrJRF5+dc3mtAISmRXHZPNB0r6TJrDH8JbUCfJ4W0vWn3
	YzWfVjczU49c4KBxaVttsbrJ9IEFfTSae
X-Gm-Gg: ASbGncuDOMEkPyDd5ERzRVC07WIJrU1jd8YQ8b6gV27smse78sAadQqhWZjrvLH/GYd
	q4i3bdVtxfe7V3P6SjH4u3Hc9WLr7TzipaIZRIwjPqJZ0JRp6CkflAdSfeM0ZuPPI6yzMkqWRPd
	SRiKODHOw757UwECGY/Xy1L8hsIQWBs3alb4q09EmGIQ==
X-Google-Smtp-Source: AGHT+IGN/zMqm5apAK2a4MFuXhS/3xtLrXO8M0lfjdfXyxeDc6BLrEGE5hFHWNndur0/0EdbSIH84oMcSOuEMJvMwPU=
X-Received: by 2002:a5d:6dab:0:b0:391:4559:876a with SMTP id
 ffacd0b85a97d-39c1211ccf7mr5585445f8f.46.1743377350768; Sun, 30 Mar 2025
 16:29:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 30 Mar 2025 16:28:59 -0700
X-Gm-Features: AQ5f1JrMOrsuhYGJ-9ptJEwEye7UCf5nsVU6XdYESxDNUNtm1HQYLK1B15QhF4c
Message-ID: <CAADnVQJFWn3dBFJtY+ci6oN1pDFL=TzCmNbRgey7MdYxt_AP2g@mail.gmail.com>
Subject: new splat
To: bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"

After bpf fast forward we see this new failure:

[  138.359852] BUG: using __this_cpu_read() in preemptible [00000000]
code: test_progs/9368
[  138.362686] caller is lwtunnel_xmit+0x1c/0x2e0
[  138.364363] CPU: 9 UID: 0 PID: 9368 Comm: test_progs Tainted: G
      O        6.14.0-10767-g8be3a12f9f26 #1092 PREEMPT
[  138.364366] Tainted: [O]=OOT_MODULE
[  138.364366] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[  138.364368] Call Trace:
[  138.364370]  <TASK>
[  138.364375]  dump_stack_lvl+0x80/0x90
[  138.364381]  check_preemption_disabled+0xc6/0xe0
[  138.364385]  lwtunnel_xmit+0x1c/0x2e0
[  138.364387]  ip_finish_output2+0x2f9/0x850
[  138.364391]  ? __ip_finish_output+0xa0/0x320
[  138.364394]  ip_send_skb+0x3f/0x90
[  138.364397]  udp_send_skb+0x1a6/0x3d0
[  138.364402]  udp_sendmsg+0x87b/0x1000
[  138.364404]  ? ip_frag_init+0x60/0x60
[  138.364406]  ? reacquire_held_locks+0xcd/0x1f0
[  138.364414]  ? copy_process+0x2ae0/0x2fa0
[  138.364418]  ? inet_autobind+0x41/0x60
[  138.364420]  ? __local_bh_enable_ip+0x79/0xe0
[  138.364422]  ? inet_autobind+0x41/0x60
[  138.364424]  ? inet_send_prepare+0xe7/0x1e0
[  138.364428]  __sock_sendmsg+0x38/0x70
[  138.364432]  ____sys_sendmsg+0x1c9/0x200
[  138.364437]  ___sys_sendmsg+0x73/0xa0
[  138.364444]  ? __fget_files+0xb9/0x180
[  138.364447]  ? lock_release+0x131/0x280
[  138.364450]  ? __fget_files+0xc3/0x180
[  138.364453]  __sys_sendmsg+0x5a/0xa0

and

[  124.853349] BUG: using __this_cpu_read() in preemptible [00000000]
code: ping/9212
[  124.856062] caller is lwtunnel_xmit+0x1c/0x2e0
[  124.857717] CPU: 5 UID: 0 PID: 9212 Comm: ping Tainted: G
O        6.14.0-10767-g8be3a12f9f26 #1092 PREEMPT
[  124.857720] Tainted: [O]=OOT_MODULE
[  124.857721] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[  124.857722] Call Trace:
[  124.857724]  <TASK>
[  124.857726]  dump_stack_lvl+0x80/0x90
[  124.857730]  check_preemption_disabled+0xc6/0xe0
[  124.857734]  lwtunnel_xmit+0x1c/0x2e0
[  124.857736]  ip_finish_output2+0x2f9/0x850
[  124.857740]  ? __ip_finish_output+0xa0/0x320
[  124.857743]  ip_push_pending_frames+0x63/0xb0
[  124.857746]  raw_sendmsg+0x7d8/0x1530

I couldn't find a responsible commit.
Not sure what changed.

