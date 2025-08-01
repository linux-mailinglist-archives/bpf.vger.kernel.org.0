Return-Path: <bpf+bounces-64877-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3199AB18006
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 12:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 421E81C249D0
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 10:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87112367DF;
	Fri,  1 Aug 2025 10:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eKF/9irT"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E483A23370F
	for <bpf@vger.kernel.org>; Fri,  1 Aug 2025 10:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754043295; cv=none; b=mMeinRgW1/dAsNtyKnBBsmlyWnZZ3CMg+YWbxWpNZXcaNEtDTALSnqq26XTcccvLdbpsLaqU/gU2GJrBVPi/b7cK8tw46AFh0gLUUoB8aAQKAb3gQVlJqdPPDFHjN5BGqJGcHc3JdcNM/fUdTz8HJWt3K3veWy7ha7JA1cQ2Dqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754043295; c=relaxed/simple;
	bh=NJyNuo+otNeF5GVRmFl2ZHZX4jKaO9xPyVc0ehBDVqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IvT9T+s+63Dio+5xh8yVedrbpI3bw1MKy8NwC5UsBBpKbSt6h0xJKTFwd0irMmH8F6F9dzjb/1J/eIxm0HKyF+Wy152jreUfhReWB8T8AbVkQVgBb3mwV/6jkxCvfDo6pSP9z1qBbr4+9pCKdZKcFMu+fEUOvMUnjdtk39wbVdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eKF/9irT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754043292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5f0ikHwLTTt3/O8uwlenMs9vmb7xQLN+kpZuqDeh9ZM=;
	b=eKF/9irTnqEqy3Z2XxkDx0h2PJN+VdijW6qliQ+3by1R+GH6Hc3deIYjMQZC0beLZZgiPP
	lVm2SrVwlGH594Ag93si6QhVMMn6J5Rq2Rz8nSFwbAAU2+8FFPudG/Od5DCKB6+tWGoyK7
	xBTB7ro8BJt2J13C3Wrx5Gb/A82Hvns=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-CVnBz29UM8ul6q3HTw2aCA-1; Fri, 01 Aug 2025 06:14:49 -0400
X-MC-Unique: CVnBz29UM8ul6q3HTw2aCA-1
X-Mimecast-MFC-AGG-ID: CVnBz29UM8ul6q3HTw2aCA_1754043288
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45626532e27so10340805e9.1
        for <bpf@vger.kernel.org>; Fri, 01 Aug 2025 03:14:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754043288; x=1754648088;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5f0ikHwLTTt3/O8uwlenMs9vmb7xQLN+kpZuqDeh9ZM=;
        b=cextiFbMMXp34c+AhoDLN1e9kA+pKVRI0bduLm5vb9QYtbSojQkRDM4aigsYdpkgdA
         Cahjmn0wP1VSzh17kfXl3oZNS7NBul2jq6mtGyBsKlgZ3ccGheucFNKcmTj/Y5AkWuss
         hWXCj5cjzPPRQPTI0JzLX++jN9YdxTEKGcZ7re0v3vzzb7NzsQgVZ32dlCY+UdHjDQMG
         RYKVo3wDEbGS1q/Sjloqbyaxvq+9ZELjduPgwLkinvZo4O/mnwNBNgXzxbcM8WU9iBka
         5qrdXg+iwTQYUMqGJ5JlHfT+gr8nIVtVEkdQNpEHp4e12b/f8+1FhEXS2xvW0btSpW6O
         NVRQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1psbQwDTSwoPi/VxC9L6DFn8EU3yVfAjmfmKMf7NPUXU+ru2EsMJm78cN7upglOFmUHA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcK7tX+BHLManeiaOU3k9iow7ZNRrJMNWOEtpDJRdmwR/8O/Ea
	5nhM540SEQG9kfRx3FbiOmF5hgTuy54Azpup1+KWlDkhIW3WZRmHxYFs8GlZza+EGhjERqBXUDY
	WDqILMyqkg7V7FDcPuenBX3CA7MjKHQAruFV8ucP5QRs4eviH2uBKOw==
X-Gm-Gg: ASbGncs3OfKIVXIgXBMGU61EPcex4taZTjOMOAO+tLysciwJmcqtXM0/xiBytBv4lLG
	G3sJeb3W9ET3BNal0vYOtbrDkz6jonqF6uxlE2yDDzskcAS3658KyZ5SuTMKUi+gZCZKp7j2slC
	0+xsVNz3ho4rZfbDvFlGTH+PkQ5f5OBL3TPYGnXXUMWwrBH/l57CkKLhbUJejaXEYfbYEKZzvER
	u0msRzBXSkBxEiXGZpQeJnjAyPaddrpLOxbpBXrcNHxOKBiUEaZhKCetWfQyvIFkTJS/vi38Kyg
	yD58UvMcHPTV6Lj6VL/qMdbR+FymHXCcy2/1t1dGMBu/gcV8rE3lu3y/1MNurYEbw0Gszu0amMy
	cHAudKxpdW8yI9fc90tXGqaFjeBccEKJv7KyyM0AN2RltbeIGiC5tBcGFElDFMBGk
X-Received: by 2002:a05:600c:810a:b0:43c:fbba:41ba with SMTP id 5b1f17b1804b1-45892bd1ecfmr88340675e9.28.1754043288086;
        Fri, 01 Aug 2025 03:14:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcNW9A99gwbz1/XGrQLX0CryukwzOCxu8d/MxqztwNcsfV6vrQMa1DlM86ZeUVO2ntIikTPg==
X-Received: by 2002:a05:600c:810a:b0:43c:fbba:41ba with SMTP id 5b1f17b1804b1-45892bd1ecfmr88340295e9.28.1754043287521;
        Fri, 01 Aug 2025 03:14:47 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f20:7500:5f99:9633:990e:138? (p200300d82f2075005f999633990e0138.dip0.t-ipconnect.de. [2003:d8:2f20:7500:5f99:9633:990e:138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4533e6sm5570881f8f.35.2025.08.01.03.14.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 03:14:46 -0700 (PDT)
Message-ID: <e9f2e391-5c83-481a-9fa4-727c25922f1c@redhat.com>
Date: Fri, 1 Aug 2025 12:14:42 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [mm?] WARNING in trace_suspend_resume
To: syzbot <syzbot+99d4fec338b62b703891@syzkaller.appspotmail.com>,
 Liam.Howlett@oracle.com, akpm@linux-foundation.org, andrii@kernel.org,
 ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 lorenzo.stoakes@oracle.com, mhocko@suse.com, rppt@kernel.org,
 surenb@google.com, syzkaller-bugs@googlegroups.com, vbabka@suse.cz,
 Sasha Levin <sashal@kernel.org>
References: <688c9223.a00a0220.26d0e1.0068.GAE@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <688c9223.a00a0220.26d0e1.0068.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01.08.25 12:08, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    f2d282e1dfb3 Merge tag 'bitmap-for-6.17' of https://github..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=11709cf0580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c686e0c98d241433
> dashboard link: https://syzkaller.appspot.com/bug?extid=99d4fec338b62b703891
> compiler:       arm-linux-gnueabi-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> userspace arch: arm
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15e0e2a2580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12a439bc580000
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/98a89b9f34e4/non_bootable_disk-f2d282e1.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/25cab46afcee/vmlinux-f2d282e1.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/77cd04442f1b/zImage-f2d282e1.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+99d4fec338b62b703891@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 4155 at mm/highmem.c:622 kunmap_local_indexed+0x20c/0x224 mm/highmem.c:622
> Modules linked in:
> Kernel panic - not syncing: kernel: panic_on_warn set ...
> CPU: 0 UID: 0 PID: 4155 Comm: syz.1.17 Not tainted 6.16.0-syzkaller #0 PREEMPT
> Hardware name: ARM-Versatile Express
> Call trace:
> [<80201a24>] (dump_backtrace) from [<80201b20>] (show_stack+0x18/0x1c arch/arm/kernel/traps.c:257)
>   r7:00000000 r6:8281f77c r5:00000000 r4:8224bc00
> [<80201b08>] (show_stack) from [<8021fb00>] (__dump_stack lib/dump_stack.c:94 [inline])
> [<80201b08>] (show_stack) from [<8021fb00>] (dump_stack_lvl+0x54/0x7c lib/dump_stack.c:120)
> [<8021faac>] (dump_stack_lvl) from [<8021fb40>] (dump_stack+0x18/0x1c lib/dump_stack.c:129)
>   r5:00000000 r4:82a76d18
> [<8021fb28>] (dump_stack) from [<80202624>] (vpanic+0x10c/0x360 kernel/panic.c:440)
> [<80202518>] (vpanic) from [<802028ac>] (trace_suspend_resume+0x0/0xd8 kernel/panic.c:574)
>   r7:804be014
> [<80202878>] (panic) from [<802548c4>] (check_panic_on_warn kernel/panic.c:333 [inline])
> [<80202878>] (panic) from [<802548c4>] (get_taint+0x0/0x1c kernel/panic.c:328)
>   r3:8280c684 r2:00000001 r1:822326d8 r0:8223a0a0
> [<80254850>] (check_panic_on_warn) from [<80254a28>] (__warn+0x80/0x188 kernel/panic.c:845)
> [<802549a8>] (__warn) from [<80254ca8>] (warn_slowpath_fmt+0x178/0x1f4 kernel/panic.c:872)
>   r8:00000009 r7:82266338 r6:df985d14 r5:840d5400 r4:00000000
> [<80254b34>] (warn_slowpath_fmt) from [<804be014>] (kunmap_local_indexed+0x20c/0x224 mm/highmem.c:622)
>   r10:00000000 r9:ded86c30 r8:deb6caa4 r7:00a00000 r6:00000003 r5:840d5400
>   r4:ffefd000
> [<804bde08>] (kunmap_local_indexed) from [<8053ace8>] (__kunmap_local include/linux/highmem-internal.h:102 [inline])
> [<804bde08>] (kunmap_local_indexed) from [<8053ace8>] (move_pages_pte mm/userfaultfd.c:1457 [inline])
> [<804bde08>] (kunmap_local_indexed) from [<8053ace8>] (move_pages+0xb1c/0x1a00 mm/userfaultfd.c:1860)
>   r7:00a00000 r6:00000000 r5:8490d6ac r4:ffefb000
> [<8053a1cc>] (move_pages) from [<805c401c>] (userfaultfd_move fs/userfaultfd.c:1923 [inline])
> [<8053a1cc>] (move_pages) from [<805c401c>] (userfaultfd_ioctl+0x1254/0x2408 fs/userfaultfd.c:2046)
>   r10:8425d6c0 r9:df985e98 r8:00000001 r7:21000000 r6:00000000 r5:20000040
>   r4:8486d000
> [<805c2dc8>] (userfaultfd_ioctl) from [<8056c4d4>] (vfs_ioctl fs/ioctl.c:51 [inline])
> [<805c2dc8>] (userfaultfd_ioctl) from [<8056c4d4>] (do_vfs_ioctl fs/ioctl.c:552 [inline])
> [<805c2dc8>] (userfaultfd_ioctl) from [<8056c4d4>] (__do_sys_ioctl fs/ioctl.c:596 [inline])
> [<805c2dc8>] (userfaultfd_ioctl) from [<8056c4d4>] (sys_ioctl+0x130/0xba0 fs/ioctl.c:584)
>   r10:840d5400 r9:00000003 r8:8572d780 r7:20000040 r6:8572d780 r5:00000000
>   r4:c028aa05
> [<8056c3a4>] (sys_ioctl) from [<80200060>] (ret_fast_syscall+0x0/0x1c arch/arm/mm/proc-v7.S:67)
> Exception stack(0xdf985fa8 to 0xdf985ff0)
> 5fa0:                   00000000 00000000 00000003 c028aa05 20000040 00000000
> 5fc0: 00000000 00000000 002f6300 00000036 00000000 002f62d4 00000938 00000000
> 5fe0: 7eb28780 7eb28770 000193dc 001321f0
>   r10:00000036 r9:840d5400 r8:8020029c r7:00000036 r6:002f6300 r5:00000000
>   r4:00000000
> Rebooting in 86400 seconds..

Probably fixed by

	https://lore.kernel.org/r/20250731144431.773923-1-sashal@kernel.org/

#syz test

--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -1453,10 +1453,15 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
  		folio_unlock(src_folio);
  		folio_put(src_folio);
  	}
-	if (dst_pte)
-		pte_unmap(dst_pte);
+	/*
+	 * Unmap in reverse order (LIFO) to maintain proper kmap_local
+	 * index ordering when CONFIG_HIGHPTE is enabled. We mapped dst_pte
+	 * first, then src_pte, so we must unmap src_pte first, then dst_pte.
+	 */
  	if (src_pte)
  		pte_unmap(src_pte);
+	if (dst_pte)
+		pte_unmap(dst_pte);
  	mmu_notifier_invalidate_range_end(&range);
  	if (si)
  		put_swap_device(si);
-- 
2.39.5



-- 
Cheers,

David / dhildenb


