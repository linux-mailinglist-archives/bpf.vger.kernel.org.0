Return-Path: <bpf+bounces-31652-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2861490114D
	for <lists+bpf@lfdr.de>; Sat,  8 Jun 2024 13:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FF84282D34
	for <lists+bpf@lfdr.de>; Sat,  8 Jun 2024 11:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1D6176AB7;
	Sat,  8 Jun 2024 11:04:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C277513F450
	for <bpf@vger.kernel.org>; Sat,  8 Jun 2024 11:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717844676; cv=none; b=u8MGcNw26m7bxNhnQtAYt3RMCyEDi6Y8CVW0f+YWXjH4jz9PTeKawpvoytQmnwidYUbClY41lT77qzBA+fX5l9NS+nuYRtAzU6o/swb+5pacEmXiySUNicxSOaWn5ZN86j9dzGcpNY4MsAVjPgQL1Ks1uHJBkoNld+pn5RGlbwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717844676; c=relaxed/simple;
	bh=YTe2IFB0Vmhzw6LM+slaeAIcM2Fi+L9y0iGHzkNtQUU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZvzrphGDl5GcwFFuYAP76XRpSCHTeMxApMuRYrWqcYXxGQFmMUQYjV4PgVTMSocIoZeoHECkUSux9L9+QIqWVMjNF2tpkRmRnoAZ7xSniNct8wdRxbwWiBQE2j+fgn3TynbTIuDgsPkSxxXhaBKby9FKPxEyG41aKKuya6t42n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav415.sakura.ne.jp (fsav415.sakura.ne.jp [133.242.250.114])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 458B426T029104;
	Sat, 8 Jun 2024 20:04:02 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav415.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav415.sakura.ne.jp);
 Sat, 08 Jun 2024 20:04:02 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav415.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 458B41vZ029085
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 8 Jun 2024 20:04:01 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <3e9b2a54-73d4-48cb-a510-d17984c97a45@I-love.SAKURA.ne.jp>
Date: Sat, 8 Jun 2024 20:04:03 +0900
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bpf: don't call mmap_read_trylock() from IRQ context
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <4b875158-1aa7-402e-8861-860a493c49cd@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <4b875158-1aa7-402e-8861-860a493c49cd@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/06/08 19:53, Tetsuo Handa wrote:
> inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage.

Oops, "inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage." example was
found at https://syzkaller.appspot.com/text?tag=CrashReport&x=14f0179a980000 .

Then, do we want to

-	if (in_hardirq()) {
+	if (!in_task()) {

instead?


