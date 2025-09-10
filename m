Return-Path: <bpf+bounces-68057-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CC082B52188
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 22:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3B6344E2602
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 20:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EDF82EC0B6;
	Wed, 10 Sep 2025 20:01:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from plesk.hostmyservers.fr (plesk.hostmyservers.fr [45.145.164.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D87E329F0E;
	Wed, 10 Sep 2025 20:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.164.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757534497; cv=none; b=MqxHWNVC3xpvNdHgkPc7dN+5Cw0g1u4U5aOOoxjbMK9LDN+FHbrC4KUsnSjmnE7PWlGh/j+WKNglRKDdJDY0MWK4U+4Fr3YAfWwOMUVaKeNg6nYZLaSuCKDsvZr12UjXfa+VV0eD9XSdi+BKQf4TBMRXkk1ts0i8Gh5ucdl6E4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757534497; c=relaxed/simple;
	bh=yoOLfOh/h7BDVNo/JIzPgcoOBchUki6MfnlHyuAyL0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qlmQgXkbWhRQk8v36wUHIqX51znD7WqsJRLaLElxTrLz/B4TYpbjGZHZNUHm5hecULoduR7AaXiXBszsA/kax0Er0SlPrPWL01mcWgZeHCrYteaYSgtVaTpRJ02Bul4FDoald5GDBI+aJmMbcmUUaxx/fOcy304ns9+iAx4f6Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com; spf=pass smtp.mailfrom=arnaud-lcm.com; arc=none smtp.client-ip=45.145.164.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arnaud-lcm.com
Received: from [IPV6:2a02:8084:255b:aa00:b6a1:4f64:4942:5f6f] (unknown [IPv6:2a02:8084:255b:aa00:b6a1:4f64:4942:5f6f])
	by plesk.hostmyservers.fr (Postfix) with ESMTPSA id C7E0941928;
	Wed, 10 Sep 2025 20:01:24 +0000 (UTC)
Authentication-Results: Plesk;
        spf=pass (sender IP is 2a02:8084:255b:aa00:b6a1:4f64:4942:5f6f) smtp.mailfrom=contact@arnaud-lcm.com smtp.helo=[IPV6:2a02:8084:255b:aa00:b6a1:4f64:4942:5f6f]
Received-SPF: pass (Plesk: connection is authenticated)
Message-ID: <30a74160-1798-4d77-9118-a46a5c7102e0@arnaud-lcm.com>
Date: Wed, 10 Sep 2025 21:01:23 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v8 3/3] bpf: fix stackmap overflow check in
 __bpf_get_stackid()
To: Song Liu <song@kernel.org>
Cc: alexei.starovoitov@gmail.com, yonghong.song@linux.dev, andrii@kernel.org,
 ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, haoluo@google.com, john.fastabend@gmail.com,
 jolsa@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org,
 martin.lau@linux.dev, sdf@fomichev.me,
 syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com
References: <20250905134625.26531-1-contact@arnaud-lcm.com>
 <20250905134833.26791-1-contact@arnaud-lcm.com>
 <CAPhsuW7Kmi9Q0z=RgLjzr2=0t+4OLQ31o=H5ET5xhnQnykKCYQ@mail.gmail.com>
Content-Language: en-US
From: Arnaud Lecomte <contact@arnaud-lcm.com>
In-Reply-To: 
 <CAPhsuW7Kmi9Q0z=RgLjzr2=0t+4OLQ31o=H5ET5xhnQnykKCYQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <175753448576.14805.7521436466844361315@Plesk>
X-PPP-Vhost: arnaud-lcm.com


On 09/09/2025 17:41, Song Liu wrote:
> On Fri, Sep 5, 2025 at 9:48 AM Arnaud lecomte <contact@arnaud-lcm.com> wrote:
>> From: Arnaud Lecomte <contact@arnaud-lcm.com>
>>
>> Syzkaller reported a KASAN slab-out-of-bounds write in __bpf_get_stackid()
>> when copying stack trace data. The issue occurs when the perf trace
>>   contains more stack entries than the stack map bucket can hold,
>>   leading to an out-of-bounds write in the bucket's data array.
>>
>> Reported-by: syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=c9b724fbb41cf2538b7b
>> Fixes: ee2a098851bf ("bpf: Adjust BPF stack helper functions to accommodate skip > 0")
>> Signed-off-by: Arnaud Lecomte <contact@arnaud-lcm.com>
>> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> Acked-by: Song Liu <song@kernel.org>
>
> With one nitpick below.
>
> [...]
>> @@ -390,15 +391,16 @@ BPF_CALL_3(bpf_get_stackid_pe, struct bpf_perf_event_data_kern *, ctx,
>>                  return -EFAULT;
>>
>>          nr_kernel = count_kernel_ip(trace);
>> +       elem_size = stack_map_data_size(map);
>> +       __u64 nr = trace->nr; /* save original */
> nit: I think all variable declarations should go to the beginning of
> the {} block.
> I am surprised ./scripts/checkpatch.pl doesn't complain this.
>
Good catch, thanks !
I should maybe wait for comments from other reviewers because raising
an other revision.
>>          if (kernel) {
>> -               __u64 nr = trace->nr;
>> -
> [...]
>
Thanks,
Arnaud


