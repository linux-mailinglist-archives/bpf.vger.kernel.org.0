Return-Path: <bpf+bounces-46972-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 147EE9F1B72
	for <lists+bpf@lfdr.de>; Sat, 14 Dec 2024 01:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F1B57A0480
	for <lists+bpf@lfdr.de>; Sat, 14 Dec 2024 00:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FFC6BE4A;
	Sat, 14 Dec 2024 00:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E59LhOKe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7C613FFC
	for <bpf@vger.kernel.org>; Sat, 14 Dec 2024 00:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734137217; cv=none; b=DIn5/HrZwL5AE/KTqEnqtlOC8/v3pK0Mf5HjVVJjsXGPvKbOnd6PtJOTB4nmbsq2mTviJN7mZv8Oad4VDaFr+EaFouo+UIrXz+sfNrhycUDscfou/5nJAEIOUtSCK18IaJTlke8XTGjzTCfPbmdTQ7+x+kWrCWSmqS+ZJc/1qVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734137217; c=relaxed/simple;
	bh=bfcNiGzRCOYtcCwCiwsVsmW/XP9anBs8Xsw+gbVx7fA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kl5lk3Pk9ZxHu1L+TgmW6zmkC67Ny4fKBkSBlumoFturAvThOwvEfQXX/i+65peSJj32XoQHBIMpohA5uHldIxlh5rCMVa9szseZtqqPddFyY7iwdLgZH5DS6MV5Czi5LVXpkClA8+7txpGkPZqoas0E+UedH2BRtUv9CoAVg7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E59LhOKe; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4362f61757fso11140905e9.2
        for <bpf@vger.kernel.org>; Fri, 13 Dec 2024 16:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734137214; x=1734742014; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VrsoBEg3feN0cvrzN/XtBd/ZkfHFgs/beTRYvUT+CqI=;
        b=E59LhOKe75WGjiTkfKsFctqxB6lq8y/MwrvAcDENEsDvbJKl9EMGGKfNJvkl+FtPyD
         GTBXdLm12DJ7Wv/ph5hkTrJU5hrFR1uegd/U/eKVPJP4G4FK07xxzRcIKxd7cV2wmZh3
         nSCgkbk+LWN7QG7KNK2k+YfDRLPkjTO9WT5Kcuz5iuJQNZhp6nHl1Pry+gK5pjZa4pgr
         TLHBiv/ut+vu34o2aQ/1KhlPHnyT8JJQ6bLvrnRzTTaccODzx5yiV/P84OdQFJOa0sJI
         QGyg+3jc5DNEjs+T29+AY7Zq9Y0PNMJVPmVnZuHHVH69wPc2X2Cj8fkAceyaXu9+UK4F
         CA3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734137214; x=1734742014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VrsoBEg3feN0cvrzN/XtBd/ZkfHFgs/beTRYvUT+CqI=;
        b=NdXWWa0qE/PhWGhp3IHnkeL9UWJ2jA6SEsSNa2FANpA99RGAAMH6/dhVFBtBNyJcaS
         KWcfaVYA39hmTbd+ZD7to5YnRA0fJeXF1t5INVYks7WkidqUqMNLvAX9kVaizxdJVXLw
         GYssJDc4kYwEoLEi9w6+0R5I9yQjhWZYUticguaD2hio1diFnP2zRpSSLkR/5GeqZNoj
         XePI0xy7GIDZaqcqbELb6PjXQZtOdMMhTO/ikdthc1Gef98J5OvSmd/ZDNV3m1iC9vsB
         stuxD6UHmYK14EhUfenmbUzNchXYE/6hiwRVkg7lFNp1PdV3ySjJiLgf5KuxUxWs64GS
         C1vQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWsGvkCuGs4AkDC1OuSFGtTtwiNgHDOgUVnDL0HWfE5WMuqRA0WjwBu8n5H32KeFt4rKU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqi2DHCRI969LGAX/TIN89aUV3TOGQ8aKK53lF3S870FrMmUgy
	hpBPnfaDClIhbH1ia8BMCqjBarCBsTyhaDZnLVyTFgL3khG3Ip0DO0frk+5J9FX+nOSf1gCq7AW
	WUoMdjoJVN2gA7kpiItkDZ/CSxlfO4aad
X-Gm-Gg: ASbGncsW8UwIX9KQBPtrupsNbpEN78acilYxZk7MBvFkydIIF6iFQOSucv5eeaXsbWV
	0zOOf6jtJWur6/sVOTT7/ps8/YvPn4sTYmqG7ruqi064//lkaxN3y5egfdqXmkqNNSEIeWA==
X-Google-Smtp-Source: AGHT+IGPKfd4k43iNuflln1RPDuytLV9lF2rrSbclPpQg2v0IIx07J+aEpQMtbvig6VpmDmvDiDXWrECG9RtwJ8JxH0=
X-Received: by 2002:a05:6000:481e:b0:385:e9c0:c069 with SMTP id
 ffacd0b85a97d-3889ad37dc4mr3463929f8f.57.1734137213396; Fri, 13 Dec 2024
 16:46:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPPBnEYn-CiWVTuRq_Fq=TP0f-W+_hcJVU61xwnxqpFr3jRcyQ@mail.gmail.com>
In-Reply-To: <CAPPBnEYn-CiWVTuRq_Fq=TP0f-W+_hcJVU61xwnxqpFr3jRcyQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 13 Dec 2024 16:46:42 -0800
Message-ID: <CAADnVQL0B1bkr-=Tm7Mia9G4vtvFCX7oEMXpM1ak9hyDcQFhkA@mail.gmail.com>
Subject: Re: [PATCH] bpf: Avoid deadlock caused by nested kprobe and fentry
 bpf programs
To: Priya Bala Govindasamy <pgovind2@uci.edu>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Ardalan Amiri Sani <ardalan@uci.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 3:58=E2=80=AFPM Priya Bala Govindasamy <pgovind2@uc=
i.edu> wrote:
>
> BPF program types like kprobe and fentry can cause deadlocks in certain
> situations. If a function takes a lock and one of these bpf programs is
> hooked to some point in the function's critical section, and if the
> bpf program tries to call the same function and take the same lock it wil=
l
> lead to deadlock. These situations have been reported in the following
> bug reports.
>
> In percpu_freelist -
> Link: https://lore.kernel.org/bpf/CAADnVQLAHwsa+2C6j9+UC6ScrDaN9Fjqv1WjB1=
pP9AzJLhKuLQ@mail.gmail.com/T/
> Link: https://lore.kernel.org/bpf/CAPPBnEYm+9zduStsZaDnq93q1jPLqO-PiKX9jy=
0MuL8LCXmCrQ@mail.gmail.com/T/
> In bpf_lru_list -
> Link: https://lore.kernel.org/bpf/CAPPBnEajj+DMfiR_WRWU5=3D6A7KKULdB5Rob_=
NJopFLWF+i9gCA@mail.gmail.com/T/
> Link: https://lore.kernel.org/bpf/CAPPBnEZQDVN6VqnQXvVqGoB+ukOtHGZ9b9U0OL=
JJYvRoSsMY_g@mail.gmail.com/T/
> Link: https://lore.kernel.org/bpf/CAPPBnEaCB1rFAYU7Wf8UxqcqOWKmRPU1Nuzk3_=
oLk6qXR7LBOA@mail.gmail.com/T/
>
> Similar bugs have been reported by syzbot.
> In queue_stack_maps -
> Link: https://lore.kernel.org/lkml/0000000000004c3fc90615f37756@google.co=
m/
> Link: https://lore.kernel.org/all/20240418230932.2689-1-hdanton@sina.com/=
T/
> In lpm_trie -
> Link: https://lore.kernel.org/linux-kernel/00000000000035168a061a47fa38@g=
oogle.com/T/
> In ringbuf -
> Link: https://lore.kernel.org/bpf/20240313121345.2292-1-hdanton@sina.com/=
T/
>
> Prevent kprobe and fentry bpf programs from attaching to these critical
> sections by removing CC_FLAGS_FTRACE for percpu_freelist.o,
> bpf_lru_list.o, queue_stack_maps.o, lpm_trie.o, ringbuf.o files.
>
> The bugs reported by syzbot are due to tracepoint bpf programs being
> called in the critical sections. This patch does not aim to fix deadlocks
> caused by tracepoint programs. However, it does prevent deadlocks from
> occurring in similar situations due to kprobe and fentry programs.
>
> Signed-off-by: Priya Bala Govindasamy <pgovind2@uci.edu>
> ---
>  kernel/bpf/Makefile | 7 +++++++
>  1 file changed, 7 insertions(+)

Applying: bpf: Avoid deadlock caused by nested kprobe and fentry bpf progra=
ms
Using index info to reconstruct a base tree...
M    kernel/bpf/Makefile
error: patch failed: kernel/bpf/Makefile:52
error: kernel/bpf/Makefile: patch does not apply
error: Did you hand edit your patch?

Pls make sure that patch applies before sending it.
After than pls respin with [PATCH bpf-next] bpf: ...
in the subject, so CI knows what tree to use to test it.

