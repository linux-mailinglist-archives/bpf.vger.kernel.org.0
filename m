Return-Path: <bpf+bounces-72983-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4642EC1F212
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 09:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A0AE1A22A80
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 08:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2846338F24;
	Thu, 30 Oct 2025 08:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6avoOr9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586742EA749
	for <bpf@vger.kernel.org>; Thu, 30 Oct 2025 08:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761814248; cv=none; b=TfaPeVmG8EPhoRJhBz0vFhaZIML3e8ERbkxeiHR5UJMajZ8mwIB9wj1PaUufQn4tRcJBwFRQd6W4Q7eZCFhMBdoWdE+Qgl0mA4Kgi0FgwfD7aqUc/SgHb+76gI/oxtoQuG50Wpnv9k31Mgp9uAhmqItEUowcDqh9l1hGWwCdQ5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761814248; c=relaxed/simple;
	bh=DVcntdAE1+eE9IiI++3DdC1qH6gCJDxbfR+C8mUd/zQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fQYDh7gDYBNNForxJ2O/vouIXD+tS9Fb2/gf4kYg0ADS5EPttyrnl4ThpHus0nUOWVbFxcHugBQtwfv+U4H4mrgwwA5bX7s0Thj5QQIqEyG4K2KEtwgOFTtTaLAHsk21lrJnEA/Nuxl9j+GcIyQtyopLHPOqSBL6ha6tVAHQR88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C6avoOr9; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b6cee846998so508713a12.1
        for <bpf@vger.kernel.org>; Thu, 30 Oct 2025 01:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761814245; x=1762419045; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z1pTLwk/ZK1UUWX/fvkakTcVF7XXo+d6U6YjjAT98us=;
        b=C6avoOr9JRSY85RP4LKzHCyLraoj2fs2IPBzLNMCw4wEaRtDsBUFBihcW/+OPIJMmj
         Dxi2SOA1YlvOx4EPpXIu+8fLlhVwbh15TXUriFTqVWwTVT/cD5S5kJic8P8b/qyRDhYr
         ZWKH6xoppgr1jMIwhNCdEB6GwMMXXDc/Xjuux15pI/Fwz/Y5p3ye8HTSYPZStbIDPDaW
         m4l0ZBpktRx50TykcKLP4swCZUqxchbGEB/ysvVAXINc48MGShbdhFw0o4BQb9bBMMy8
         UG/bTuyT1jt7Vye5efJvmZABuAASrwUQ2D1h2yk2Olg3n7Ag5QHR5i/+AYpKqY8t41fS
         mAuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761814245; x=1762419045;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Z1pTLwk/ZK1UUWX/fvkakTcVF7XXo+d6U6YjjAT98us=;
        b=iQEMR1nWCVdCzuTxRhM6qnP+3RUBPSsWrG98AP22U79Tg6qT084MlnXeU/oY7ORM8X
         TpzqIkHSBPsTRKYFtcUEPg4bokxCxvbR+Vs/uETSPJ6VVTXf7uLI6mC0WYY9bORCwFL2
         mGqGpVwUhKxQ1/9cxhtJFULH1Bt6exzAYCjBy00hPgR8P2bGLF+CVC1IDZhCoIUWZP3p
         WX1vGFGzqHv3LYhDGchxqBGkSKwcEThxIGsquDVLKL3QePVltsjRLIZwr9vOrzqlCgpF
         DLeiiW+eq+5xlIbvQpygsGScW/kVcqUBnNjVztuP0q1MmCwftRAUIDqdaT2jo0MRlSNf
         T+Dg==
X-Forwarded-Encrypted: i=1; AJvYcCW1cWCy/iijBbyIlSDN3z8AY2DmXWgfoEcvZLHmcnFBkKFetahTL5nFw5rNQJTr/5BjDgI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb0TccUH8ouTScgQoUgaG5k4PUCNK2OpwT0AggWllA0xysS811
	sO/1OFKgmvVrQy4JgficmZcvGwpKppXCJJDHDK5/ppIGMFfmLJutQNFc
X-Gm-Gg: ASbGncsWVLSbt3BceYgoQzj5W3iJF19yPNX32wqmixtya2oqAOrICTJpmCSd59zz9Q2
	P2G9suzzq61+odSLVsbUFTVpl4AyS/AlVdf2vNElxBtLZmVe9etzcpajw32iEgsW/hRkD5xhFX/
	Vgi01e1oeOmPF5Z0/Vdk4SrHlXJSwlY9kdrS33jlKEnJpRbk15OpILmLzlDdja10m12I39Zxnan
	Pl14JHw3gw173xvUxuxjymmgiZipn5s8g+NWZmhhCLdHYSWitscFOCrdH08MJpXKuyg0ZK2ztjC
	zocafatrdYiWxhSWwI0cS6XhRAAaVFlibpU1kOfMdMS+1JoiTBj8eV11q6YRA3Ccm6aQiMBcUhI
	vnHXDCJXU5xF/nAxAxHYZmuOw39H3/f0SpuOMMRMn4vHYW4ueeUh57OGW92Y1hndBHkYE/upg
X-Google-Smtp-Source: AGHT+IFRaRq6I70RrjIkxE4Ueg8M4tLEQsawZVnAaI+sObqxcSuinFAxf/dv4kUTVAprmWbuT/lMxQ==
X-Received: by 2002:a17:902:e84e:b0:27e:f06b:ae31 with SMTP id d9443c01a7336-294edfa0c64mr28389005ad.61.1761814245205;
        Thu, 30 Oct 2025 01:50:45 -0700 (PDT)
Received: from [0.0.0.0] ([5.34.218.166])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d30030sm176594645ad.65.2025.10.30.01.50.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 01:50:44 -0700 (PDT)
Message-ID: <b9a8890e-9d0c-4ce3-8f10-eefd607b52fc@gmail.com>
Date: Thu, 30 Oct 2025 16:50:36 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [bpf?] WARNING in bpf_bprintf_prepare (3)
To: Yonghong Song <yonghong.song@linux.dev>,
 Sahil Chandna <chandna.sahil@gmail.com>
Cc: syzbot+b0cff308140f79a9c4cb@syzkaller.appspotmail.com, andrii@kernel.org,
 ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, haoluo@google.com, john.fastabend@gmail.com,
 jolsa@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org,
 listout@listout.xyz, martin.lau@linux.dev, netdev@vger.kernel.org,
 sdf@fomichev.me, song@kernel.org, syzkaller-bugs@googlegroups.com,
 linux-rt-devel@lists.linux.dev, bigeasy@linutronix.de
References: <68f6a4c8.050a0220.1be48.0011.GAE@google.com>
 <14371cf8-e49a-4c68-b763-fa7563a9c764@linux.dev>
 <aPklOxw0W-xUbMEI@chandna.localdomain>
 <8dd359dd-b42f-4676-bb94-07288b38fac1@linux.dev>
 <aP5_JbddrpnDs-WN@chandna.localdomain>
 <95e1fd95-896f-4d33-956f-a0ef0e0f152c@linux.dev>
 <aQH5EtKBbklfH0Wq@chandna.localdomain>
 <541b7765-28eb-4d1f-9409-863db6798395@linux.dev>
From: Tao Chen <chen.dylane@gmail.com>
In-Reply-To: <541b7765-28eb-4d1f-9409-863db6798395@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2025/10/29 23:26, Yonghong Song 写道:
> 
> 
> On 10/29/25 4:22 AM, Sahil Chandna wrote:
>> On Mon, Oct 27, 2025 at 08:45:25PM -0700, Yonghong Song wrote:
>>>
>>>
>>> On 10/26/25 1:05 PM, Sahil Chandna wrote:
>>>> On Wed, Oct 22, 2025 at 12:56:25PM -0700, Yonghong Song wrote:
>>>>>
>>>>>
>>>>> On 10/22/25 11:40 AM, Sahil Chandna wrote:
>>>>>> On Wed, Oct 22, 2025 at 09:57:22AM -0700, Yonghong Song wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 10/20/25 2:08 PM, syzbot wrote:
>>>>>>>> Hello,
>>>>>>>>
>>>>>>>> syzbot found the following issue on:
>>>>>>>>
>>>>>>>> HEAD commit:    a1e83d4c0361 selftests/bpf: Fix redefinition of 
>>>>>>>> 'off' as d..
>>>>>>>> git tree:       bpf
>>>>>>>> console output: https://syzkaller.appspot.com/x/log.txt? 
>>>>>>>> x=12d21de2580000
>>>>>>>> kernel config: https://syzkaller.appspot.com/x/.config? 
>>>>>>>> x=9ad7b090a18654a7
>>>>>>>> dashboard link: https://syzkaller.appspot.com/bug? 
>>>>>>>> extid=b0cff308140f79a9c4cb
>>>>>>>> compiler:       Debian clang version 20.1.8 (+ 
>>>>>>>> +20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian 
>>>>>>>> LLD 20.1.8
>>>>>>>> syz repro: https://syzkaller.appspot.com/x/repro.syz? 
>>>>>>>> x=160cf542580000
>>>>>>>> C reproducer: https://syzkaller.appspot.com/x/repro.c? 
>>>>>>>> x=128d5c58580000
>>>>>>>>
>>>>>>>> Downloadable assets:
>>>>>>>> disk image: https://storage.googleapis.com/syzbot- 
>>>>>>>> assets/2f6a7a0cd1b7/disk-a1e83d4c.raw.xz
>>>>>>>> vmlinux: https://storage.googleapis.com/syzbot- 
>>>>>>>> assets/873984cfc71e/vmlinux-a1e83d4c.xz
>>>>>>>> kernel image: https://storage.googleapis.com/syzbot- 
>>>>>>>> assets/16711d84070c/bzImage-a1e83d4c.xz
>>>>>>>>
>>>>>>>> The issue was bisected to:
>>>>>>>>
>>>>>>>> commit 7c33e97a6ef5d84e98b892c3e00c6d1678d20395
>>>>>>>> Author: Sahil Chandna <chandna.sahil@gmail.com>
>>>>>>>> Date:   Tue Oct 14 18:56:35 2025 +0000
>>>>>>>>
>>>>>>>>     bpf: Do not disable preemption in bpf_test_run().
>>>>>>>>
>>>>>>>> bisection log: https://syzkaller.appspot.com/x/bisect.txt? 
>>>>>>>> x=172fe492580000
>>>>>>>> final oops: https://syzkaller.appspot.com/x/report.txt? 
>>>>>>>> x=14afe492580000
>>>>>>>> console output: https://syzkaller.appspot.com/x/log.txt? 
>>>>>>>> x=10afe492580000
>>>>>>>>
>>>>>>>> IMPORTANT: if you fix the issue, please add the following tag to 
>>>>>>>> the commit:
>>>>>>>> Reported-by: syzbot+b0cff308140f79a9c4cb@syzkaller.appspotmail.com
>>>>>>>> Fixes: 7c33e97a6ef5 ("bpf: Do not disable preemption in 
>>>>>>>> bpf_test_run().")
>>>>>>>>
>>>>>>>> ------------[ cut here ]------------
>>>>>>>> WARNING: CPU: 1 PID: 6145 at kernel/bpf/helpers.c:781 
>>>>>>>> bpf_try_get_buffers kernel/bpf/helpers.c:781 [inline]
>>>>>>>> WARNING: CPU: 1 PID: 6145 at kernel/bpf/helpers.c:781 
>>>>>>>> bpf_bprintf_prepare+0x12cf/0x13a0 kernel/bpf/helpers.c:834
>>>>>>>
>>>>>>> Okay, the warning is due to the following WARN_ON_ONCE:
>>>>>>>
>>>>>>> static DEFINE_PER_CPU(struct 
>>>>>>> bpf_bprintf_buffers[MAX_BPRINTF_NEST_LEVEL], bpf_bprintf_bufs);
>>>>>>> static DEFINE_PER_CPU(int, bpf_bprintf_nest_level);
>>>>>>>
>>>>>>> int bpf_try_get_buffers(struct bpf_bprintf_buffers **bufs)
>>>>>>> {
>>>>>>>        int nest_level;
>>>>>>>
>>>>>>>        nest_level = this_cpu_inc_return(bpf_bprintf_nest_level);
>>>>>>>        if (WARN_ON_ONCE(nest_level > MAX_BPRINTF_NEST_LEVEL)) {
>>>>>>>                this_cpu_dec(bpf_bprintf_nest_level);
>>>>>>>                return -EBUSY;
>>>>>>>        }
>>>>>>>        *bufs = this_cpu_ptr(&bpf_bprintf_bufs[nest_level - 1]);
>>>>>>>
>>>>>>>        return 0;
>>>>>>> }
>>>>>>>
>>>>>>> Basically without preempt disable, at process level, it is possible
>>>>>>> more than one process may trying to take bpf_bprintf_buffers.
>>>>>>> Adding softirq and nmi, it is totally likely to have more than 3
>>>>>>> level for buffers. Also, more than one process with 
>>>>>>> bpf_bprintf_buffers
>>>>>>> will cause problem in releasing buffers, so we need to have
>>>>>>> preempt_disable surrounding bpf_try_get_buffers() and
>>>>>>> bpf_put_buffers().
>>>>>> Right, but using preempt_disable() may impact builds with
>>>>>> CONFIG_PREEMPT_RT=y, similar to bug[1]? Do you think local_lock() 
>>>>>> could be used here
>>>>>
>>>>> We should be okay. for all the kfuncs/helpers I mentioned below,
>>>>> with the help of AI, I didn't find any spin_lock in the code path
>>>>> and all these helpers although they try to *print* some contents,
>>>>> but the kfuncs/helpers itself is only to deal with buffers and
>>>>> actual print will happen asynchronously.
>>>>>
>>>>>> as nest level is per cpu variable and local lock semantics can work
>>>>>> for both RT and non rt builds ?
>>>>>
>>>>> I am not sure about local_lock() in RT as for RT, local_lock() could
>>>>> be nested and the release may not in proper order. See
>>>>>  https://www.kernel.org/doc/html/v5.8/locking/locktypes.html
>>>>>
>>>>>  local_lock is not suitable to protect against preemption or 
>>>>> interrupts on a
>>>>>  PREEMPT_RT kernel due to the PREEMPT_RT specific spinlock_t 
>>>>> semantics.
>>>>>
>>>>> So I suggest to stick to preempt_disable/enable approach.
>>>>>
>>>>>>>
>>>>>>> There are some kfuncs/helpers need such preempt_disable
>>>>>>> protection, e.g. bpf_stream_printk, bpf_snprintf,
>>>>>>> bpf_trace_printk, bpf_trace_vprintk, bpf_seq_printf.
>>>>>>> But please double check.
>>>>>>>
>>>>>> Sure, thanks!
>>>>
>>>> Since these helpers eventually call bpf_bprintf_prepare(),
>>>> I figured adding protection around bpf_try_get_buffers(),
>>>> which triggers the original warning, should be sufficient.
>>>> I tried a few approaches to address the warning as below :
>>>>
>>>> 1. preempt_disable() / preempt_enable() around 
>>>> bpf_prog_run_pin_on_cpu()
>>>> diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
>>>> index 1b61bb25ba0e..6a128179a26f 100644
>>>> --- a/net/core/flow_dissector.c
>>>> +++ b/net/core/flow_dissector.c
>>>> @@ -1021,7 +1021,9 @@ u32 bpf_flow_dissect(struct bpf_prog *prog, 
>>>> struct bpf_flow_dissector *ctx,
>>>>                (int)FLOW_DISSECTOR_F_STOP_AT_ENCAP);
>>>>       flow_keys->flags = flags;
>>>>
>>>> +    preempt_disable();
>>>>       result = bpf_prog_run_pin_on_cpu(prog, ctx);
>>>> +    preempt_enable();
>>>>
>>>>       flow_keys->nhoff = clamp_t(u16, flow_keys->nhoff, nhoff, hlen);
>>>>       flow_keys->thoff = clamp_t(u16, flow_keys->thoff,
>>>> This fixes the original WARN_ON in both PREEMPT_FULL and RT builds.
>>>> However, when tested with the syz reproducer of the original bug 
>>>> [1], it
>>>> still triggers the expected 
>>>> DEBUG_LOCKS_WARN_ON(this_cpu_read(softirq_ctrl.cnt)) warning from 
>>>> __local_bh_disable_ip(), due to the preempt_disable() interacting 
>>>> with RT spinlock semantics.
>>>> [1] [https://syzkaller.appspot.com/bug?extid=1f1fbecb9413cdbfbef8
>>>> So this approach avoids the buffer nesting issue, but re-introduces 
>>>> the following issue:
>>>> [  363.968103][T21257] 
>>>> DEBUG_LOCKS_WARN_ON(this_cpu_read(softirq_ctrl.cnt))
>>>> [  363.968922][T21257] WARNING: CPU: 0 PID: 21257 at kernel/ 
>>>> softirq.c:176 __local_bh_disable_ip+0x3d9/0x540
>>>> [  363.969046][T21257] Modules linked in:
>>>> [  363.969176][T21257] Call Trace:
>>>> [  363.969181][T21257]  <TASK>
>>>> [  363.969186][T21257]  ? __local_bh_disable_ip+0xa1/0x540
>>>> [  363.969197][T21257]  ? sock_map_delete_elem+0xa2/0x170
>>>> [  363.969209][T21257]  ? preempt_schedule_common+0x83/0xd0
>>>> [  363.969252][T21257]  ? rt_spin_unlock+0x161/0x200
>>>> [  363.969269][T21257]  sock_map_delete_elem+0xaf/0x170
>>>> [  363.969280][T21257]  bpf_prog_464bc2be3fc7c272+0x43/0x47
>>>> [  363.969289][T21257]  bpf_flow_dissect+0x22b/0x750
>>>> [  363.969299][T21257] bpf_prog_test_run_flow_dissector+0x37c/0x5c0
>>>>
>>>> 2. preempt_disable() inside bpf_try_get_buffers() and bpf_put_buffers()
>>>>
>>>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>>>> index 8eb117c52817..bc8630833a94 100644
>>>> --- a/kernel/bpf/helpers.c
>>>> +++ b/kernel/bpf/helpers.c
>>>> @@ -777,12 +777,14 @@ int bpf_try_get_buffers(struct 
>>>> bpf_bprintf_buffers **bufs)
>>>>  {
>>>>         int nest_level;
>>>>
>>>> +       preempt_disable();
>>>>         nest_level = this_cpu_inc_return(bpf_bprintf_nest_level);
>>>>         if (WARN_ON_ONCE(nest_level > MAX_BPRINTF_NEST_LEVEL)) {
>>>>                 this_cpu_dec(bpf_bprintf_nest_level);
>>>>                 return -EBUSY;
>>>>         }
>>>>         *bufs = this_cpu_ptr(&bpf_bprintf_bufs[nest_level - 1]);
>>>> +       preempt_enable();
>>>>
>>>>         return 0;
>>>>  }
>>>> @@ -791,7 +793,10 @@ void bpf_put_buffers(void)
>>>>  {
>>>>         if (WARN_ON_ONCE(this_cpu_read(bpf_bprintf_nest_level) == 0))
>>>>                 return;
>>>> +
>>>> +       preempt_disable();
>>>>         this_cpu_dec(bpf_bprintf_nest_level);
>>>> +       preempt_enable();
>>>>  }
>>>> This *still* reproduces the original syz issue, so the protection 
>>>> needs to be placed around the entire program run, not inside the 
>>>> helper itself as
>>>> in above experiment.
>>>
>>> This does not work. See my earlier suggestions.
>>>
>>>> Basically without preempt disable, at process level, it is possible
>>>> more than one process may trying to take bpf_bprintf_buffers.
>>>> Adding softirq and nmi, it is totally likely to have more than 3
>>>> level for buffers. Also, more than one process with bpf_bprintf_buffers
>>>> will cause problem in releasing buffers, so we need to have
>>>> preempt_disable surrounding bpf_try_get_buffers() and
>>>> bpf_put_buffers().
>>>
>>> That is,
>>>  preempt_disable();
>>>  ...
>>>  bpf_try_get_buffers()
>>>  ...
>>>  bpf_put_buffers()
>>>  ...
>>>  preempt_enable();
>>>
>>>>
>>>> 3. Using a per-CPU local_lock
>>>> Finally, I tested with a per-CPU local_lock around 
>>>> bpf_prog_run_pin_on_cpu():
>>>> +struct bpf_cpu_lock {
>>>> +    local_lock_t lock;
>>>> +};
>>>> +
>>>> +static DEFINE_PER_CPU(struct bpf_cpu_lock, bpf_cpu_lock) = {
>>>> +    .lock = INIT_LOCAL_LOCK(),
>>>> +};
>>>> @@ -1021,7 +1030,9 @@ u32 bpf_flow_dissect(struct bpf_prog *prog, 
>>>> struct bpf_flow_dissector *ctx,
>>>>                      (int)FLOW_DISSECTOR_F_STOP_AT_ENCAP);
>>>>         flow_keys->flags = flags;
>>>>
>>>> +       local_lock(&bpf_cpu_lock.lock);
>>>>         result = bpf_prog_run_pin_on_cpu(prog, ctx);
>>>> +       local_unlock(&bpf_cpu_lock.lock);
>>>>
>>>> This approach avoid the warning on both RT and non-RT builds, with 
>>>> both the syz reproducer. The intention of introducing the per-CPU 
>>>> local_lock is to maintain consistent per-CPU execution semantics 
>>>> between RT and non-RT kernels.
>>>> On non-RT builds, local_lock maps to preempt_disable()/enable(),
>>>> which provides the same semantics as before.
>>>> On RT builds, it maps to an RT-safe per-CPU spinlock, avoiding the
>>>> softirq_ctrl.cnt issue.
>>>
>>> This should work, but local lock disable interrupts which could have
>>> negative side effects on the system. We don't want this.
>>> That is the reason we have 3 nested level for bpf_bprintf_buffers.
>>>
>>> Please try my above preempt_disalbe/enable() solution.
>>>
>> I tried following patch with reproducer from both syzbot [1] and [2]
>> and issue *did not reproduce* with them.
>>
>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>> index 8eb117c52817..4be6dde89d39 100644
>> --- a/kernel/bpf/helpers.c
>> +++ b/kernel/bpf/helpers.c
>> @@ -777,9 +777,11 @@ int bpf_try_get_buffers(struct 
>> bpf_bprintf_buffers **bufs)
>>  {
>>         int nest_level;
>>
>> +       preempt_disable();
>>         nest_level = this_cpu_inc_return(bpf_bprintf_nest_level);
>>         if (WARN_ON_ONCE(nest_level > MAX_BPRINTF_NEST_LEVEL)) {
>>                 this_cpu_dec(bpf_bprintf_nest_level);
>> +               preempt_enable();
>>                 return -EBUSY;
>>         }
>>         *bufs = this_cpu_ptr(&bpf_bprintf_bufs[nest_level - 1]);
>> @@ -792,6 +794,7 @@ void bpf_put_buffers(void)
>>         if (WARN_ON_ONCE(this_cpu_read(bpf_bprintf_nest_level) == 0))
> 
> For completeness, we need to add preempt_enable() here as well.
> 
>> return;
>>         this_cpu_dec(bpf_bprintf_nest_level);
>> +       preempt_enable();
>>  }
>>
>> [1] https://syzkaller.appspot.com/bug?extid=1f1fbecb9413cdbfbef8
>> [2] https://syzkaller.appspot.com/bug?extid=b0cff308140f79a9c4cb
>>>>
>>>> Let me know if you’d like me to run some more experiments on this.
>>>
>> Shall I submit a patch with your suggested changes ?
> 
> Please. The change looks good to me.
> 
>>
>> Regards,
>> Sahil
> 
> 

Hi Yonghong, Sahil

Previously, I removed preempt_disable from bpf_try_get_buffers,
In my understanding, it is safe
to access this_cpu_inc_return(bpf_bprintf_nest_level), can we just
remove the WARN_ON_ONCE? It seems that BPF allows preemption after
run under migration disabled. Is it right?

https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/commit/?id=4223bf833c8495e40ae2886acbc0ecbe88fa6306

-- 
Best Regards
Tao Chen

