Return-Path: <bpf+bounces-67546-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 237BEB45389
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 11:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 575F8480070
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 09:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5132285057;
	Fri,  5 Sep 2025 09:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ay8n49Yf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B632459E7;
	Fri,  5 Sep 2025 09:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757065211; cv=none; b=aeDquasLVYMF7HtJcBXDSORs2hWv2x8K6xKbrb1cbn+6T/DzGc0k0LWxMBRuie7vJWlEraaZvoXWtUq2/BKsmJkFZYgDqz7YdpddlCc4f459fS19Ls8xjwcUJSlM8dzOrHuVYZoaN113LVrt05Ep0A6XM4lLZd3NosiXpzj8SSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757065211; c=relaxed/simple;
	bh=T7Dn+UMP6guluDBFGXIXjtR5pTQmj81vr55vFFP2Sd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z/Zf72/hElYJK17chnM2EyQoFJ/QJtNc3dNkYg9RlmjCNfOGRRZiUCA9C67dvot7/Lposmjwy7fu2s8FQoI6136JsgXFLLOObUcD58rG+0bHEG6bAahfpIoz2kIs0OCGd42khEHJXFbOQrsgwT0mKBxP6dbnJXygV962dA3gCxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ay8n49Yf; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45dd513f4ecso8279255e9.3;
        Fri, 05 Sep 2025 02:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757065208; x=1757670008; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cDXueAm94KqHBVVmI3hMHAqXI/fD3/tN6fLM/2JMEZg=;
        b=Ay8n49YfweTArLPddO4VUsOmm4nHKi3qiH/F75D6EnXZmcl3rBGNjMPnsGNvPUuSVT
         FZLdgvPFkAT1nQ0YfHQKg6TiZ+bYqjWCL7xfJUlxwIZ39kUpICdJjINsOQ9Wa0ZZ7ac4
         nyFRzMBTTunvmfVEYezzcsVGwQg3v9yoDBI2JBgJPQCZ/bG2eEx/HRXttamGh7ZB6mvl
         pLoZ5qCkdddRP2kHWa4tlE4fdxXdn1iu9c3gshfU6dTDJ0c65LlsxniK90Onc0aByMPM
         t9Pd/Pu+D7m2rB+KAxBGmwHMmQUhGtQv5bMr78/GfJVdnSeV6/2G7Gc3YKVmTguVNnSB
         39gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757065208; x=1757670008;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cDXueAm94KqHBVVmI3hMHAqXI/fD3/tN6fLM/2JMEZg=;
        b=OIMKOBZujG07/gZvZOl/7tDlV9dhaLuWiTgr2YCZXH+t0K6NghYa8MJFfPN1bLt22M
         ZtMHYB+rFZs++F04cItdM3V1FhPr6F+SPeC4wOfEQbmule8yTBDw9EitIl9cxXhbmOch
         K+i5UHSlYlmLkqGgWmgMv1Z8jkSTq3zEsjwvnWmy83HBxOOCpDjAsaiwQXOg/B+Li/Io
         jydkEKplKwP56HLmBh0uNm3CUWxdVBOgqLF7fQBBJbyI0uoFFObyR6Se5AsEuWgAi/PC
         yWiLU5VehuKwHPDwwLb4tRZQTm8LZRue6hr8HXVDTQzKCmDdvjaX9e87NaWt1sl7c+du
         pEBQ==
X-Forwarded-Encrypted: i=1; AJvYcCV65iDFu7sVaQ7gOHO4oVHZX25Py3wFMQM5DmStrbZknCm5YVPIBgZx759W6fGzR0ojyaHDZEKCkKveIf6s@vger.kernel.org, AJvYcCVshanDlwf2JlZW/BkkmiALNiNXX2OP++WJ3wQVHCKgeerSqn9rHLEWwxL5hjopSW6p0CM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJoswPumg2ov6/UJVAOWHu5omDJVtiQQkic6ZFxBQ92V8+EWbn
	1yjl2iiB/EN/chVDy+k9akg5Vne8rgoAWbJZPEa4whE9IQp78Ks3iE6H
X-Gm-Gg: ASbGncvu8K38SyNkD3ujtED8Yl4RFOLcbIq9sK9LM/mmoMH3kz2IPW/NTCgwaaEYHTr
	hVvgdlKv/8FaZoP4VL1AiHgmGQVPg0/Q4N6n1ZdQfedpc87SuMGGc/xkd/Kfqf4IOIdvEaJwLKQ
	Z2RGClPXMToLIxyo3K6bnc5Pq1nEDnlVvEnB8VtZswbqQazy1n7V5aoI17/otm87bwhnyK/TPFE
	jO5LdpUdgMFq8fvpPHfPo3ixlVuGG186RkgXwpOfjxLC/Yq/7D7r7ZvsxQGHXILH5OwVbdTm9CK
	W0ee4yigzQct11vtkV7GjPTogIzFwkxQWIue4Wzzzrm7/PJLl1HibYe19wXIwbvVYzAs7RR5Jaq
	oVRQ43L52/Rq3Ao/yB2sTXFB+eYH3u5JQc/KP1WITzDE6rj3jCJ+XmSc6Vy5I9KAt4P9bCZQzNF
	pA8gQhAocQsrsSsNZy95IY
X-Google-Smtp-Source: AGHT+IFLdFLDnkXmyR9//mdmtR2QUfWftcs/5AQACkI3TrR2yNt4BWtpKvaLdxjNPbOmqvVSW4pAig==
X-Received: by 2002:a05:600c:8b42:b0:45b:7e86:7378 with SMTP id 5b1f17b1804b1-45b8558be6emr167500725e9.34.1757065207644;
        Fri, 05 Sep 2025 02:40:07 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00d0182e7ce2f9547e.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:d018:2e7c:e2f9:547e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dd296ed51sm61343195e9.3.2025.09.05.02.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 02:40:06 -0700 (PDT)
Date: Fri, 5 Sep 2025 11:40:05 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: syzbot <syzbot+27689b73d9cffb8c6bca@syzkaller.appspotmail.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com,
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@fomichev.me,
	song@kernel.org, syzkaller-bugs@googlegroups.com,
	yonghong.song@linux.dev
Subject: Re: [syzbot] [bpf?] WARNING in bpf_check (5)
Message-ID: <aLqv9eV-wDfZj-gI@mail.gmail.com>
References: <68ba3053.a00a0220.eb3d.000d.GAE@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68ba3053.a00a0220.eb3d.000d.GAE@google.com>

On Thu, Sep 04, 2025 at 05:35:31PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    8f5ae30d69d7 Linux 6.17-rc1
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> console output: https://syzkaller.appspot.com/x/log.txt?x=10dc087c580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=8c5ac3d8b8abfcb
> dashboard link: https://syzkaller.appspot.com/bug?extid=27689b73d9cffb8c6bca
> compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
> userspace arch: arm64
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16342134580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10e75a42580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/18a2e4bd0c4a/disk-8f5ae30d.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/3b5395881b25/vmlinux-8f5ae30d.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/e875f4e3b7ff/Image-8f5ae30d.gz.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+27689b73d9cffb8c6bca@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> verifier bug: not inlined functions bpf_perf_event_read#22 is missing func(1)
> WARNING: CPU: 1 PID: 6725 at kernel/bpf/verifier.c:22840 do_misc_fixups kernel/bpf/verifier.c:22838 [inline]
> WARNING: CPU: 1 PID: 6725 at kernel/bpf/verifier.c:22840 bpf_check+0x1559c/0x15d8c kernel/bpf/verifier.c:24742

This one was already reported as
https://syzkaller.appspot.com/bug?extid=a9ed3d9132939852d0df and fixed
in e4414b01c1cd ("bpf: Check the helper function is valid in
get_helper_proto") (in bpf tree).

#syz dup: [syzbot] [bpf?] WARNING in do_misc_fixups

[...]

