Return-Path: <bpf+bounces-62313-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F314BAF7E51
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 19:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C804E1C2379E
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 17:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454CA258CF8;
	Thu,  3 Jul 2025 17:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MEUzXbLh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FBA231845;
	Thu,  3 Jul 2025 17:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751562128; cv=none; b=JmCJPQMV/vDHboRc9NI4Fp7UpbWxeSYyKTtmU0yHD82V4zTI1zG2mmuNgy+WdHM95F/S4EOC+e2DFFQER3qZ0SC6WiStKSajYDWQHtFHySqL+KaBKCYQDbhwjdqfybPF339UfK7oI0f1C6cNUz4F3PXIEMYqHmPMpEZ1ASssamk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751562128; c=relaxed/simple;
	bh=E081HkjSbZ2WVbTMhej+f/g61ckEPDMEOWjg46KFsy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ku+RRCxC0yhCsRGLCOmMHXlnOPRH5jfaE5XNjwbj7LeFQJKmWKAAoatIDoiq8RdIWKnn0/ACOyrv+ORdi3MYGI0eHJ26dTRjDUSqA3LZ1Z8L0NHfzXSHnSw9OJ8QOlvmG3tTmqO9KhloiD/MWmPfK09wvYypa/ZhBoB83K4I3Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MEUzXbLh; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-450cb2ddd46so223275e9.2;
        Thu, 03 Jul 2025 10:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751562125; x=1752166925; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eTpy6b+dMaI05VegxIj+mrD8jjqA2iALPTWzs4HEaEE=;
        b=MEUzXbLhvvSmIGKQNxQEsVxSr5AoJe9KWry9oFUazTRUAyZ3q0hvaeVCXJ8QPeirQu
         /Jh8X7hfMTsxn7RUeRun9j+E3CdvNbM5nsuJmbNxFUKRAACK5+hWJn3fD1EtduiIp39p
         N+79xCAbIFJoYVTWuhXwoFEzn579W0DwCkDRMX46lkz/Jr5QIZ2HzHNfo1DhdtFJXPyV
         xNVw6TECX/6w045AylSjSD+1Yz4fArz5sRPKRuCNmEHZPnxnqH6PreFweNw89TWCPZzJ
         VTf3IWmkQU0M5JLaELGrgKkj9HtJdbB55rd3VLQfGSY8bdAJt3UwEya74VChr0Wb36NW
         m1HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751562125; x=1752166925;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eTpy6b+dMaI05VegxIj+mrD8jjqA2iALPTWzs4HEaEE=;
        b=btuhaoUIBNWgHL0bsToHph1UHJ7j4GKaWY65A/kdSx5EwMGFatLsrvGukdK9j4Inve
         0/gpMXTYT5yOZ/rNW9/x/fjPpw19pu1zq+Qb/xYrTfBm2jz8I5/CX8BuoOKqynOK2bzy
         SqIzjbSQqylorlFadJJ0rHz5SvY8RxYMHHr3xWFDAOlGPusjNtV8p5FBzyaKKaIV0zFi
         kYGzjEykP6LxSOoiVxpL4GgpNQVPb9xdFy6Z/DCL7PBMunr5e2rg7hiQCtJx5+U1huIw
         HlV2aUsKMgOitNYEyt3l0KSwVEePgdGQHuuW/3qmIpPM3WFvKCx1PqN4xqJp9XU1WPKJ
         MckQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZ87Nvg80T5hMAbUKAqtia7HIPoYtv5YRSJk0WXhmgJa9ADlFHZHfCC4yNKXw2Za4QWnG+KrQZxTT+iTxi@vger.kernel.org, AJvYcCVuXDQWzcq9u019sEiqdAZ7baPnGwf/zQw+w0Yuj50RsDqG5SaXBkwKcF9xPQjwWvdBFGM=@vger.kernel.org, AJvYcCVyd5qdJRMFpijBliRAYTHS987ZhfQzkVp4ZvpkNNvOe3Mt9s8h/v01nsMiCP/uH6i60Lz9N3/9@vger.kernel.org
X-Gm-Message-State: AOJu0YxFWI8uJ71S7B05c22hXaj1vFKM8huc/1JD9P3nlZKlMwDiLMqA
	erEGveMRjVndV2XGn2/Jrkh4wWSB9wEHHIaZLUXg8PyCGuInQin93mvh
X-Gm-Gg: ASbGncuqtB80fidNE+OESPr8dWftI5GnZ+L00S12lZjh/XlPByJSgSAVOl19VaMp+g6
	B+cp7uNc5MQoji1TPYpB+ft1F8s9kLqzvRpbIh1SilwqvC8tmPOwSmTTjs+31upUqMLV/2rHuHL
	Afh73oIO8d2JbxFYG2J8hKF0LAt7Lj6xG30S+GYqGPHc3MDUiZx5eKFMpVkD4G+L7yK/TRQINyA
	UlQ5P+eYUmR7nW0iy2gfX8feTaMQzOYbAykRbhbnLO7ACrC3uXHfPJCvF+mrvsCEWUflFaM0klA
	QwNVwiMU4x4qBasdxOqvmZNHHhh/z8T/CFCkkv37azBZqPlkkRtl1G2DVtPHJv0hK8OXVkhgdW5
	A/KN4Ou8jxkri9cenV+QPqNk2/ImWZPVixVu+sWSeSqi5IS71Rg==
X-Google-Smtp-Source: AGHT+IFgS8GFDbEAQf0pLtvMHddhEATQh6Bqp1PqtKuIxHKmd3pGWfdVKkXex9M1RgYdiMj6ncONeQ==
X-Received: by 2002:a05:600c:348e:b0:450:d386:1afb with SMTP id 5b1f17b1804b1-454a36e35f0mr87729745e9.9.1751562124529;
        Thu, 03 Jul 2025 10:02:04 -0700 (PDT)
Received: from Tunnel (2a01cb089436c000639c506ed789b424.ipv6.abo.wanadoo.fr. [2a01:cb08:9436:c000:639c:506e:d789:b424])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b471b97698sm256977f8f.54.2025.07.03.10.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 10:02:03 -0700 (PDT)
Date: Thu, 3 Jul 2025 19:02:00 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: syzbot <syzbot+c711ce17dd78e5d4fdcf@syzkaller.appspotmail.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com,
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
	linux-kernel@vger.kernel.org, martin.lau@linux.dev,
	netdev@vger.kernel.org, sdf@fomichev.me, song@kernel.org,
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Subject: Re: [syzbot] [bpf?] WARNING in reg_bounds_sanity_check
Message-ID: <aGa3iOI1IgGuPDYV@Tunnel>
References: <68649190.a70a0220.3b7e22.20e8.GAE@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68649190.a70a0220.3b7e22.20e8.GAE@google.com>

On Tue, Jul 01, 2025 at 06:55:28PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    cce3fee729ee selftests/bpf: Enable dynptr/test_probe_read_..
> git tree:       bpf-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=147793d4580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=79da270cec5ffd65
> dashboard link: https://syzkaller.appspot.com/bug?extid=c711ce17dd78e5d4fdcf
> compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1594e48c580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1159388c580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/f286a7ef4940/disk-cce3fee7.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/e2f2ebe1fdc3/vmlinux-cce3fee7.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/6e3070663778/bzImage-cce3fee7.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+c711ce17dd78e5d4fdcf@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> verifier bug: REG INVARIANTS VIOLATION (false_reg1): range bounds violation u64=[0x0, 0x0] s64=[0x0, 0x0] u32=[0x1, 0x0] s32=[0x0, 0x0] var_off=(0x0, 0x0)(1)
> WARNING: CPU: 1 PID: 5833 at kernel/bpf/verifier.c:2688 reg_bounds_sanity_check+0x6e6/0xc20 kernel/bpf/verifier.c:2682

I'm unsure how to handle this one.

One example repro is as follows.

  0: call bpf_get_netns_cookie
  1: if r0 == 0 goto <exit>
  2: if r0 & Oxffffffff goto <exit>

The issue is on the path where we fall through both jumps.

That path is unreachable at runtime: after insn 1, we know r0 != 0, but
with the sign extension on the jset, we would only fallthrough insn 2
if r0 == 0. Unfortunately, is_branch_taken() isn't currently able to
figure this out, so the verifier walks all branches. As a result, we end
up with inconsistent register ranges on this unreachable path:

  0: if r0 == 0 goto <exit>
    r0: u64=[0x1, 0xffffffffffffffff] var_off=(0, 0xffffffffffffffff)
  1: if r0 & 0xffffffff goto <exit>
    r0 before reg_bounds_sync: u64=[0x1, 0xffffffffffffffff] var_off=(0, 0)
    r0 after reg_bounds_sync:  u64=[0x1, 0] var_off=(0, 0)

I suspect there isn't anything specific to these two conditions, and
anytime we start walking an unreachable path, we may end up with
inconsistent register ranges. The number of times syzkaller is currently
hitting this (180 in 1.5 days) suggests there are many different ways to
reproduce.

We could teach is_branch_taken() about this case, but we probably won't
be able to cover all cases. We could stop warning on this, but then we
may also miss legitimate cases (i.e., invariants violations on reachable
paths). We could also teach reg_bounds_sync() to stop refining the
bounds before it gets inconsistent, but I'm unsure how useful that'd be.

Paul

[...]


