Return-Path: <bpf+bounces-66497-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D3B6B351B3
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 04:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC6C65E0F9B
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 02:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5683221FF49;
	Tue, 26 Aug 2025 02:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GT5b4ZOE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8AC26E142;
	Tue, 26 Aug 2025 02:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756175423; cv=none; b=uWiHG7XBR/IAYCqtmns8Y47UP0VK7UPhx/jTp2ieaVNbACffr1ApC+G5a687GoTWTaAG9juifOqFnmde+b6b37igPbW7/vkjjRNCZ4MmEB8MxVvbaQ/Ds0BzsWwwgYG1+CtcbtwQXN7RB8FbiBmY7O5VHN2Fj/BsBlyRDkVbHJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756175423; c=relaxed/simple;
	bh=Yq3O4eFTa/FIInznqx2YptqjzklfwxAGKMOEMmUY8BM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XHXE/FfpuQ4eMUvQ47HpNqKTJVZNC+piNjRtN1HBgPvWg81ZFqFbLUd9pwLB66u23q01+4ZGwuRBvUEzlSOHYg70AlRmsbBHOoeakW72f8xxGKCNaTN2jHUt0raEfNhyjZ0FPltCY9lXKzB0CJGXGQToxDtktYcmYmaDtU9dpYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GT5b4ZOE; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b47174beb13so3524163a12.2;
        Mon, 25 Aug 2025 19:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756175421; x=1756780221; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KFX6DK/cmimSZ4xcXbMIGOlf83QbLIblOqr2/QMbhK4=;
        b=GT5b4ZOEkP69emzU+oaz8Yftkf02dKQj0OxqDh4yily7TfFRfDcM0ZhKrmeVkVA4uU
         YO94VkZawPJ4mlW94k1LrpXwSPIzoQfRZOZc5nGfAv4Nr4MIZ7ACyjyrjrlo2NmzyzbI
         FpadVlwd2EqwfLX2v4/Xl1+zXQv9lfeLKqC8Ix2LkWbGtb8/XJMRaDVboojitDLDjDSM
         /zOyA/EdD4qMt01DO2emkSTKeFj/1m0ckKe0fmwB6oQzry67kAZhzfkVf4s+VNzZESBe
         iXf/FUSgEabwT0sDrTDPsarQCdygZXJEbv6OTdDhd+bwNyCyDnfrGzL+X/BF4GM8+jdG
         hGCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756175421; x=1756780221;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KFX6DK/cmimSZ4xcXbMIGOlf83QbLIblOqr2/QMbhK4=;
        b=RFKrDUKBG1r8j4z92YVYFRbzG6QscUCSgj+SwvZpzklG3CuGzJYVgDY6dW7DzKxZaX
         KnOJDH0ldwVgomVN8rAfEuUD3yPLbfnlE3KknB2XvYX21gRLdD1dxPES74YNiQhevpAF
         JUn03iFqgyBcDp4Bpd9WAVoD50DsulBpw02dNcnJ3KlwpCYSDrG0EyLvlYmq1N81iCq9
         1v6vpO94m1iMRXGjbCg0SJY0pt+63w3tH8aRYfecWxDiYhuT/etEow72LWLfw+w61jiK
         0P6xGY97Z8H4ehkGeeVCrVjyuCClCe5SxyIJYM7kViDIztU5fNsqPjGi7Xx1ywYBd99v
         hVkA==
X-Forwarded-Encrypted: i=1; AJvYcCUnmxcqRtqk73gtGIrrj2l1wEPdSY3CAG4H9K98gyGaBllk/yZkBUdyzx9ASQTDMnLK0a0=@vger.kernel.org, AJvYcCWLIqYRmM7PApjK0mSsRdqwsVS3nrTM6ca1iYzjJI7a15r6WRTuGqzq4pI/QoMDLseHzn/YnsR5jLJuEby5@vger.kernel.org, AJvYcCXkD/WGqzfUojC63gK3pZ4nAaoxDj4ziHgMU1KFaaRudaJujzAKDaNRJC4Np3Y+frj8kKfaXaGY@vger.kernel.org
X-Gm-Message-State: AOJu0YyqpINRIBQeJHCVRkG0Yqc3MTFRpirFlvhyUjqhxRs0NeZEONR7
	nUzPOJCiOK+HC5xBo86+XiLbpaffOxiqR2yY2MMI24F0HPkSqAghe77k
X-Gm-Gg: ASbGncsm0EmuLttanpSSuGclZqVFR8HnAJEjO3U5VpWMuV9RG9r/f7CPjKC7ANZXuG1
	IQQO62oUE66Oug5EtPjl7mi5FALeb9FAJGLuTVQ3DT1v1uFpb19S0wI9ZhaTjxmmjpfugpUrPYp
	uczXaKIOLf3tb6YGZ65n1UR/AP2JrJflsmhwc2dS31AhMoet7NasuDV5/gSMNirm97sN0eoqW3t
	q0qyXNG1O1/CEWC3cy6hc+SOJ9VIiOA8MqfABr5swfxJwprRiIZvpF9FVg1lHLCE9PYBsXXxHVQ
	VDofHilvGbmHA3fPoSdsto5ih+KK1opqRpzbqBvyZ5WHH28zqg48FE6ZY4HEUK4x3UKESNbbbil
	T4A9ZH4tPjNaQ/IXY9S/u/Nr5grNoShJVMwTiedJQZBpQoA==
X-Google-Smtp-Source: AGHT+IFYbwQ4ThKLqR/ADOl5mb9A0UFXuLsqDsBbY4JxLNT3nY4gbdteSvJ2uMj+wIBa2xGr2msL2Q==
X-Received: by 2002:a17:902:f645:b0:240:3915:99d8 with SMTP id d9443c01a7336-2462ef542d9mr186482545ad.47.1756175420788;
        Mon, 25 Aug 2025 19:30:20 -0700 (PDT)
Received: from [10.22.65.172] ([122.11.166.8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24668779feesm80834895ad.34.2025.08.25.19.30.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Aug 2025 19:30:19 -0700 (PDT)
Message-ID: <b6d1c35b-0db6-4d4d-9586-0d0ee0475e36@gmail.com>
Date: Tue, 26 Aug 2025 10:30:14 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [bpf?] possible deadlock in __bpf_ringbuf_reserve (2)
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: syzbot <syzbot+fa5c2814795b5adca240@syzkaller.appspotmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Eduard <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>,
 John Fastabend <john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
 KP Singh <kpsingh@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Network Development <netdev@vger.kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Song Liu <song@kernel.org>,
 syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
 Yonghong Song <yonghong.song@linux.dev>
References: <68ac9fd3.050a0220.37038e.0096.GAE@google.com>
 <50f069c5-d962-4743-a8b0-dc1bc4811599@gmail.com>
 <CAADnVQ+p76vYLjs9zivq694PSqiPPjv7LJOSXCHsLGuMwgG1jw@mail.gmail.com>
From: Leon Hwang <hffilwlqm@gmail.com>
In-Reply-To: <CAADnVQ+p76vYLjs9zivq694PSqiPPjv7LJOSXCHsLGuMwgG1jw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 26/8/25 10:23, Alexei Starovoitov wrote:
> On Mon, Aug 25, 2025 at 7:20 PM Leon Hwang <hffilwlqm@gmail.com> wrote:
>>
>>
>>
>> On 26/8/25 01:39, syzbot wrote:
>>> Hello,
>>>
>>> syzbot found the following issue on:
>>>
>>> HEAD commit:    dd9de524183a xsk: Fix immature cq descriptor production
>>> git tree:       bpf
>>> console output: https://syzkaller.appspot.com/x/log.txt?x=102da862580000
>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=c321f33e4545e2a1
>>> dashboard link: https://syzkaller.appspot.com/bug?extid=fa5c2814795b5adca240
>>> compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
>>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=142da862580000
>>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1588aef0580000
>>>
>>> Downloadable assets:
>>> disk image: https://storage.googleapis.com/syzbot-assets/5a3389c1558f/disk-dd9de524.raw.xz
>>> vmlinux: https://storage.googleapis.com/syzbot-assets/c97133192a27/vmlinux-dd9de524.xz
>>> kernel image: https://storage.googleapis.com/syzbot-assets/3ae5a1a88637/bzImage-dd9de524.xz
>>>
>>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>>> Reported-by: syzbot+fa5c2814795b5adca240@syzkaller.appspotmail.com
>>>
>>> ============================================
>>> WARNING: possible recursive locking detected
>>> syzkaller #0 Not tainted
>>> --------------------------------------------
>>> syz-execprog/5866 is trying to acquire lock:
>>> ffffc900048c10d8 (&rb->spinlock){-.-.}-{2:2}, at: __bpf_ringbuf_reserve+0x1c7/0x5a0 kernel/bpf/ringbuf.c:423
>>>
>>> but task is already holding lock:
>>> ffffc900048e90d8 (&rb->spinlock){-.-.}-{2:2}, at: __bpf_ringbuf_reserve+0x1c7/0x5a0 kernel/bpf/ringbuf.c:423
>>>
>>> other info that might help us debug this:
>>>  Possible unsafe locking scenario:
>>>
>>>        CPU0
>>>        ----
>>>   lock(&rb->spinlock);
>>>   lock(&rb->spinlock);
>>>
>>>  *** DEADLOCK ***
>>>
>>>  May be due to missing lock nesting notation
>>
>> Confirmed.
>>
>> I can reproduce this deadlock issue and will work on a fix.
> 
> Don't.
> 
> It's due to revert.
> Once rqspinlock is fixed the revert will be reverted.

OK. I'll test it after the fixing.

Thanks,
Leon


