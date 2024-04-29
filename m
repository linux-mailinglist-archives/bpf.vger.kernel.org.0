Return-Path: <bpf+bounces-28100-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB1308B5B15
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 16:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 281421C212F3
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 14:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF5778B4E;
	Mon, 29 Apr 2024 14:18:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192B09468;
	Mon, 29 Apr 2024 14:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714400295; cv=none; b=MWMdSZ77hgSrm+fhGt63i306lzJDwWm2VXU1wHmJuZfz9Lesp9nyYBWSzBBbpZbliix+A8oV5M6rUdyxb1hCY0qed8IkcFkRenJUq/Jowk1g2VUA1lryLfm8f0eCEy6XWmrXsHcUVgNLDB7smCvAW1BcI3Cpv/U6ZRPYmigI4h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714400295; c=relaxed/simple;
	bh=RSyoegxOAHlaigWqquK1Q28wHOKIdTh91Kmqtql0UaU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Go4+Avwlf/sdRscJEMiDc5wL3pffUxaNg0+SO54M8zS292dMBgiUSXDniRsq17r2zMxjv7d7MAS3064qYNf1+P8ikpq2zVey3sLn85U8mnGOD3SLqVRC+D+HbXoOGyw6zqghJQzIf8Cq9t9D9MTsjQjOrVgWuCaL7khbDp7KXyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav116.sakura.ne.jp (fsav116.sakura.ne.jp [27.133.134.243])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 43TEHkSt090647;
	Mon, 29 Apr 2024 23:17:46 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav116.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav116.sakura.ne.jp);
 Mon, 29 Apr 2024 23:17:46 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav116.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 43TEHkwr090644
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 29 Apr 2024 23:17:46 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <8dc01a83-1bea-4e3c-a04d-9a9bd422a5b3@I-love.SAKURA.ne.jp>
Date: Mon, 29 Apr 2024 23:17:42 +0900
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [bpf?] [trace?] possible deadlock in
 force_sig_info_to_task
To: Linus Torvalds <torvalds@linux-foundation.org>,
        Hillf Danton <hdanton@sina.com>
Cc: syzbot <syzbot+83e7f982ca045ab4405c@syzkaller.appspotmail.com>,
        andrii@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
References: <0000000000009dfa6d0617197994@google.com>
 <20240427231321.3978-1-hdanton@sina.com>
 <CAHk-=wjBvNvVggy14p9rkHA8W1ZVfoKXvW0oeX5NZWxWUv8gfQ@mail.gmail.com>
 <20240428232302.4035-1-hdanton@sina.com>
 <CAHk-=wjma_sSghVTgDCQxHHd=e2Lqi45PLh78oJ4WeBj8erV9Q@mail.gmail.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CAHk-=wjma_sSghVTgDCQxHHd=e2Lqi45PLh78oJ4WeBj8erV9Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/04/29 9:50, Linus Torvalds wrote:
> On Sun, 28 Apr 2024 at 16:23, Hillf Danton <hdanton@sina.com> wrote:
>>
>> So is game like copying from/putting to user with runqueue locked
>> at the first place.
> 
> The runqueue lock is irrelevant. As mentioned, it's only a symptom of
> something else going wrong.
> 
>> Plus as per another syzbot report [1], bpf could make trouble with
>> workqueue pool locked.
> 
> That seems to be entirely different. There's no unexplained page fault
> in that case, that seems to be purely a "take lock in the wrong order"

Another example is at https://lkml.kernel.org/r/00000000000041df050616f6ba4e@google.com .
Since many callers might hold runqueue lock while holding some other locks, allowing
BPF to run code which can hold one of such locks while runqueue lock is held is asking
for troubles. BPF programs are unexpected lock grabber for built-in code. I think that
BPF should not run code which might hold one of such locks when an atomic lock is
already held.


