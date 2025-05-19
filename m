Return-Path: <bpf+bounces-58469-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A7DABB2B0
	for <lists+bpf@lfdr.de>; Mon, 19 May 2025 02:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C12CC1894CB1
	for <lists+bpf@lfdr.de>; Mon, 19 May 2025 00:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8745136672;
	Mon, 19 May 2025 00:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gAd8XvdY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE18D77104;
	Mon, 19 May 2025 00:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747614670; cv=none; b=shggGMYU56mXMqKhdWcBByEzciBcP8AP3dkLUFuolg14dcpqO8jbRmyNmvVC3ryCLkUn+5i88GdogaHkvTltNi+r5Pn6P2wo6jQk+k4qBfZBY6/8RwVzGFsGZCuGL7+F1ZuQELqU594a+wgCH4nqLbNdWppj1EGoOF7/Zs/ZUVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747614670; c=relaxed/simple;
	bh=JvQt+Obh5/8IUXFfYdqpkrzPyjGlWTFULxC9IZXs3j0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RrZgiLDKRh3gv6kmt79V4jdt6OFbrqhGgdaeu93dhcUt91A0riSXoylATovZQXhqvPMzEcEny+sX3qL0tWlxhaSvNOh4tqGP56aOn2V0hVVPS9q4YZlATflSdlPPMkDEQHw+Iwqak05jGiDea9MPXiDszGFTqutKlAEx5i81kIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gAd8XvdY; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-4e150f1ba9aso1288882137.2;
        Sun, 18 May 2025 17:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747614667; x=1748219467; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=33fgPI4IJajeIRdtDV/PTXtk5THHymOdpncHrnFNB2w=;
        b=gAd8XvdY971M4sZBYoYV+rV7UzldHsP2yqYC60cAH/bFDSNQFmASYvGhlyXG4vAIFc
         54Pohx8LwNV4eIJT4ZhqR4m2MqhvAJRmqzEXRbtcz7itIXplccpyuAEXyGHURU0jE8Nu
         y58ZtNfO4MDujRmod2TarUWEfWMVUDt55e4bgxEpJWyRnvF4ToNx5gmEg5L2EQhye9bV
         rMKZy2lJOR9Se3CW4qPnnc2Hry2dvJt3eKB0bd6Z6ahBmj0G0aPlEwYpHWptsK6bivXO
         BubgOaiG88t1mf3JfszyuxXl+gWEXm3o4AfUkNPnxIf11cEJSaaL0Kff5H+q1g6KnUEf
         5+GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747614667; x=1748219467;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=33fgPI4IJajeIRdtDV/PTXtk5THHymOdpncHrnFNB2w=;
        b=KM8zAGMUVCSVuX1l36Wi2hLVoEr/sWakh0VgmED/I2vGFH4Jv44Rez1I8ksaRGS0iE
         jJgHnz7KxBY0SqaFlD3MR8v0JqfFnDybNeGU3qFyzXgfN+uibiFUDOTMNXxnNjEX7+fZ
         O0fu5DtCcv4qe2mC2yIkvTeMmILGd7xhkSvjcOYAKm+Q7R+S3zBXKDXvdFGl9Ibkc/46
         5L+ToZm2sJwZctilJ1R9peSC8EifPFKjA15V7pYsN0udE9P/I3vmaw2gluyrVoLMPPj6
         HOvm9pgZjZnIct3AZqrMzq0gKneMDbntFRLcd5aVMLpXFA+DUSp3+dupz+GVqQXa1fTX
         rJRg==
X-Forwarded-Encrypted: i=1; AJvYcCU4U9rK5LzdFMXNnNjv96zGzWphM5i2G+fXg8HoJhvJCGNyJwhLGUaYEHuggdLzuPbZ7pc=@vger.kernel.org, AJvYcCW624YRP5jRGeuzDbBebFt1D5CS/e8X9mN0wKVMmgJohiowA0pzIH+29kztN2JJ5enSYo0a23aN@vger.kernel.org
X-Gm-Message-State: AOJu0YzmyTGHpP5VWjtIhemcPgDlpQ8/xe1O6NNpaI3IfiKUNzKqpthb
	BPx/ujM88xlD1Bwpt7nA8Ql/rcv3WqFAtW1yHsHUZuTo5mbP0GCIIWF2f0XEqHtqRA7fkRxDNJx
	Wwe4i27dnMTOBQfbdZggk6NMq+e/A5h8=
X-Gm-Gg: ASbGncsJVBEOyVVmeEQ6JhoxjRYhvUojR6WQzMIfvXX13MgA9uJ2fDbex99XU5xGMst
	39IcZkquUUq8kyaH4Ufmnb+Jx7wJHt/GIk+Or6XVhmnbJ+n2oQrkyCxc7rP6T1kG8SCwoH8QOsJ
	0rGab8JIbwq3gEnw9ibtqbqVW3MaNhnSW5ABpdyDCgpRMr9+ewAyvhe/CR811mfxhzpw==
X-Google-Smtp-Source: AGHT+IENxOuvAMnZmhYeKmdpE04/XduMuUo7yssFlKK3SAmTIcrL5dOqz+DuxWUrh8P5SAQOcr92wb9Iaq6zceF3pBU=
X-Received: by 2002:a05:6102:3c92:b0:4cb:5d6c:9942 with SMTP id
 ada2fe7eead31-4dfa6b5857emr11251965137.10.1747614667485; Sun, 18 May 2025
 17:31:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aAmIi0vlycHtbXeb@pop-os.localdomain> <90f887391cff690e883e40cbb67a9614e7757295@linux.dev>
 <978f0f1e4ab0c8f46820af305f5efb00cf94ffd2@linux.dev>
In-Reply-To: <978f0f1e4ab0c8f46820af305f5efb00cf94ffd2@linux.dev>
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Sun, 18 May 2025 17:30:56 -0700
X-Gm-Features: AX0GCFvkbHMX11PHczkBtMhgDOi0P8b7dIXT_hVh5KpsEKpTKxN4WACHYhPEaq8
Message-ID: <CAM_iQpU7=4xjbefZoxndKoX9gFFMOe7FcWMq5tHBsymbrnMHxQ@mail.gmail.com>
Subject: Re: test_sockmap failures on the latest bpf-next
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Linux Kernel Network Developers <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Jiayuan,

Thanks for fixing the kernel warning, however, it looks like the
sockmap selftests
still fail on the latest bpf-next, see below.

Do you mind taking a look? ;-)

[root@localhost bpf]# ./test_sockmap
# 1/ 6  sockmap::txmsg test passthrough:OK
# 2/ 6  sockmap::txmsg test redirect:OK
# 3/ 2  sockmap::txmsg test redirect wait send mem:OK
# 4/ 6  sockmap::txmsg test drop:OK
# 5/ 6  sockmap::txmsg test ingress redirect:OK
# 6/ 7  sockmap::txmsg test skb:OK
# 7/12  sockmap::txmsg test apply:OK
# 8/12  sockmap::txmsg test cork:OK
[  347.904830] test_sockmap (676) used greatest stack depth: 24712 bytes left
# 9/ 3  sockmap::txmsg test hanging corks:OK
#10/11  sockmap::txmsg test push_data:OK
#11/17  sockmap::txmsg test pull-data:OK
#12/ 9  sockmap::txmsg test pop-data:OK
#13/ 6  sockmap::txmsg test push/pop data:OK
#14/ 1  sockmap::txmsg test ingress parser:OK
#15/ 1  sockmap::txmsg test ingress parser2:OK
#16/ 6 sockhash::txmsg test passthrough:OK
#17/ 6 sockhash::txmsg test redirect:OK
#18/ 2 sockhash::txmsg test redirect wait send mem:OK
#19/ 6 sockhash::txmsg test drop:OK
#20/ 6 sockhash::txmsg test ingress redirect:OK
#21/ 7 sockhash::txmsg test skb:OK
#22/12 sockhash::txmsg test apply:OK
#23/12 sockhash::txmsg test cork:OK
#24/ 3 sockhash::txmsg test hanging corks:OK
#25/11 sockhash::txmsg test push_data:OK
#26/17 sockhash::txmsg test pull-data:OK
#27/ 9 sockhash::txmsg test pop-data:OK
#28/ 6 sockhash::txmsg test push/pop data:OK
#29/ 1 sockhash::txmsg test ingress parser:OK
#30/ 1 sockhash::txmsg test ingress parser2:OK
#31/ 6 sockhash:ktls:txmsg test passthrough:OK
[  408.408666] perf: interrupt took too long (12003 > 12002), lowering
kernel.perf_event_max_sample_rate to 16500
#32/ 6 sockhash:ktls:txmsg test redirect:OK
#33/ 2 sockhash:ktls:txmsg test redirect wait send mem:OK
#34/ 6 sockhash:ktls:txmsg test drop:OK
#35/ 6 sockhash:ktls:txmsg test ingress redirect:OK
#36/ 7 sockhash:ktls:txmsg test skb:OK
#37/12 sockhash:ktls:txmsg test apply:OK
#38/12 sockhash:ktls:txmsg test cork:OK
#39/ 3 sockhash:ktls:txmsg test hanging corks:OK
#40/11 sockhash:ktls:txmsg test push_data:OK
#41/17 sockhash:ktls:txmsg test pull-data:OK
recv failed(): Invalid argument
rx thread exited with err 1.
recv failed(): Invalid argument
rx thread exited with err 1.
recv failed(): Bad message
rx thread exited with err 1.
#42/ 9 sockhash:ktls:txmsg test pop-data:FAIL
recv failed(): Bad message
rx thread exited with err 1.
recv failed(): Bad message
rx thread exited with err 1.
#43/ 6 sockhash:ktls:txmsg test push/pop data:FAIL
#44/ 1 sockhash:ktls:txmsg test ingress parser:OK
#45/ 0 sockhash:ktls:txmsg test ingress parser2:OK
Pass: 43 Fail: 5


Thanks!
Cong

