Return-Path: <bpf+bounces-40286-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DB5985692
	for <lists+bpf@lfdr.de>; Wed, 25 Sep 2024 11:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 208D8285C37
	for <lists+bpf@lfdr.de>; Wed, 25 Sep 2024 09:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2653D1411DE;
	Wed, 25 Sep 2024 09:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="E7duChX0"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8857915C131
	for <bpf@vger.kernel.org>; Wed, 25 Sep 2024 09:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727257505; cv=none; b=VyKunOfAEaGuHRAm8ixdPeR1T9qRtYKXkP9ZVLohHRHZBLvQAYVaDnpNDYwaPFMZP9AlNhpDhEASqHzgefLhhfJtxuylaCELPvFc6UOT/qeCgDwe9lCxo0vueZWeksvhZg/X3CIYrVQH2OVctnkoOwLAjR/rzqoA+e0g3bJqU0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727257505; c=relaxed/simple;
	bh=OWmp47jZUsQ8hPST0o9aci7PbX2LVJynvtxa1GwfP5E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bYQ5nsfL4ABWRe72fut6xpoqDMsFTtyWF6LcvNsrwnepVAzkVa+y2bYc+lnlAI3W+xdjYoF2UNaoh0dLeJedim8uGRtuz0iOBY/2/C/4A0Qr2CvG9/SJD6khQYcdcYfH/KIPKAp+kbHsuvCFqWsHLcwOVEKTDDaYBpbuKed/PgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=E7duChX0; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=85B8KFq8Ontej4r5iZLc/1/7e8tMnYQxK6knmWD9MBc=; b=E7duChX0qeS2Q1G4o0JWNdp/qA
	k3atd8toQbQjUZ+AV+1QCnrXgLAxJG6RIz2wN8BCGxozqHkqmlpQRrs871wfLHGERosU+PA+y8xgF
	e1FNF56mphIjjyselwav+2VPSpQJ7W0cQJgdGHvIvXUkl8Mo3x5KGpVvDAeYKD4xW8z2+ev3glNHR
	2nTzj9pLkKAoVI+o1elC6P3uyoeLnKQ7fAlWL0CFT909ODodA4nl6BJxc0cBIVNnGChIVrvUWm/t4
	3rJsB7rpUedKNOP3kFbmyOJudYIVoQH1/N7XSpzZzHFLzT4KGBn1UWeTsg9jJT8ykE40eYBB1cJJU
	fqr8+VMw==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1stOZc-00088y-GW; Wed, 25 Sep 2024 11:44:40 +0200
Received: from [178.197.249.20] (helo=[192.168.1.114])
	by sslproxy03.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1stOZb-000DPP-12;
	Wed, 25 Sep 2024 11:44:39 +0200
Message-ID: <88488499-771a-4179-b959-37a3d8f0cf51@iogearbox.net>
Date: Wed, 25 Sep 2024 11:44:39 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v1 1/2] bpf: sync_linked_regs() must preserve
 subreg_def
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, ast@kernel.org
Cc: andrii@kernel.org, martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev, Lonial Con <kongln9170@gmail.com>
References: <20240924210844.1758441-1-eddyz87@gmail.com>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
In-Reply-To: <20240924210844.1758441-1-eddyz87@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27408/Tue Sep 24 10:34:28 2024)

On 9/24/24 11:08 PM, Eduard Zingerman wrote:
> Range propagation must not affect subreg_def marks, otherwise the
> following example is rewritten by verifier incorrectly when
> BPF_F_TEST_RND_HI32 flag is set:
>
>    0: call bpf_ktime_get_ns                   call bpf_ktime_get_ns
>    1: r0 &= 0x7fffffff       after verifier   r0 &= 0x7fffffff
>    2: w1 = w0                rewrites         w1 = w0
>    3: if w0 < 10 goto +0     -------------->  r11 = 0x2f5674a6     (r)
>    4: r1 >>= 32                               r11 <<= 32           (r)
>    5: r0 = r1                                 r1 |= r11            (r)
>    6: exit;                                   if w0 < 0xa goto pc+0
>                                               r1 >>= 32
>                                               r0 = r1
>                                               exit
>
> (or zero extension of w1 at (2) is missing for architectures that
>   require zero extension for upper register half).
>
> The following happens w/o this patch:
> - r0 is marked as not a subreg at (0);
> - w1 is marked as subreg at (2);
> - w1 subreg_def is overridden at (3) by copy_register_state();
> - w1 is read at (5) but mark_insn_zext() does not mark (2)
>    for zero extension, because w1 subreg_def is not set;
> - because of BPF_F_TEST_RND_HI32 flag verifier inserts random
>    value for hi32 bits of (2) (marked (r));
> - this random value is read at (5).
>
> Reported-by: Lonial Con <kongln9170@gmail.com>
> Closes: https://lore.kernel.org/bpf/7e2aa30a62d740db182c170fdd8f81c596df280d.camel@gmail.com/
> Signed-off-by: Lonial Con <kongln9170@gmail.com>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Do we have a Fixes tag for stable?

