Return-Path: <bpf+bounces-69210-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CFC2B9053A
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 13:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4362118998E7
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 11:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF1F2FFDD7;
	Mon, 22 Sep 2025 11:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YpMc8bjP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25ED2219A79
	for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 11:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758539828; cv=none; b=RxomFd4Q9L8WmEQUIA83bULSUpNV++hObCoo2WT/8q835pH5e0vmsEf9bHnrb50sDKjZeuLRJNss84xBrmmg3dCsCu3xmfvkr1aJJLz0Xw8uWcSVTIqKTSdJNIOUEOt9hhj0HTwOeVWp0B38LSdfoHJx5Hy+Uw1RAmOZWeoOhk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758539828; c=relaxed/simple;
	bh=w6YwY5vmKus00bBj/e3FJTj7WCtO3igJ6hLmCin2MiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NW4lHCNINBcGzSmXM4Ra76IzOnaahxoP+FD03rbuk8jhn8YVymdWyUd02vmHOoZFJlOTN1GITgwAyk/HkO3LADi9VFPeYecn/fpuHmueBP2TSCRoIMCGqkdVjPJPOSDxaodXZ4dbAlAbVfz30rcwEX75QMG331MplbUAOV/IYAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YpMc8bjP; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-46c78a1784dso3284615e9.0
        for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 04:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758539825; x=1759144625; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YTlxhWqrZh7egDtJ3L2cCvngzXZ86KR/jKo3mxorcAk=;
        b=YpMc8bjPqLRh/orwj+xuxcilFOvxMXJnOMgsTtIsl+yucbF59FMpH4w8daCkDoebLw
         VJOyow8aY51cjAEwu+0NIdycyRD+OgyMmbdyH6/zrzzwu9WHNmK+X2exF/3fNTf99sgW
         EjL5cuKgzGWjs7+vjVfJAMqAYIQTdcxlP5m5SG0yvtx/8woy17nP0068VrzpvsBNyBFM
         qvorlLt8nuoWdDAqEwoXfGQk5a+PTQsYibDafZMn+oj4lsbDEcZJKT73PkV0b5kzfdJz
         hT6HgGTo1XKmtmXghhxZA8Y+/5Bx0VufiI9QiM9V1vLnfSfONJnoWlm3AcDspe1iDy6I
         Tjew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758539825; x=1759144625;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YTlxhWqrZh7egDtJ3L2cCvngzXZ86KR/jKo3mxorcAk=;
        b=bIrgS6BJUzkCZ5EcshB9hnCBGTuXHRbbNjvepmk5s/ArXri7KXe6GGvuQlhc6D0wUV
         ObxWj7ulTQx4ZDIfTTb5F1gJ5ei9Ss1C2mSAgkHk0Jlldf8nvyxSpQGamCzsSI5UN0x9
         TPQmRV3D/Au8FEpqjigfm7IVrKXZ74+f6pGpDJ4RjVgru5WRVZbla9n0+aV3v9XmozGe
         8HbXtcexrUDpA+zInTJ5evt+hVyGhVgauwVCwBAOk5SY1PjNRqbXOEPUTVnLPJ/OqByB
         MyBRmFWMJ9oUgH0yh2Kqi/YlpsNFm6Cf4DaTaA2X+En33/PUUsFNoPSSs2/S8e747+3W
         U0vw==
X-Forwarded-Encrypted: i=1; AJvYcCXfYQo3Qw87htNTcrkgvYOijsCoxAccuPo6wqc1VsKPnWBafidq2pbm63RnmaBoxMO9VMk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaUGZ0EQ08yOrMZDYwM/zgKlz3CS7fNoyI1jKWvB2UMqWGJP6o
	IjdzfTtzzQlceDbQuikAh9ldApQDTzQYIy+YFTr6JGWVwKiDokPns8bZ
X-Gm-Gg: ASbGncs5gK6GvPTUaUMfverviGfUHH9E76Geayr/ze/fvskJbeXbpAPyB565R9FNvFi
	iuAejVQzzbt4d49FDOClvgoFsB4yMPvZplvXy6W6Bv/itcYAXyfPZvOk/ICXRl0wjSvO/4QusN5
	ybex32nE2ll2vjFSaxvzBkawitzTiQODUcipvIjqPfWKIs47aPpd8yvx+3ptHuXJvhVjFj+/ciT
	rOeu8e5pCsKpe5leuDvqhqUnfrhCH8F6XStbHsieywOldVe/DxbjDi0/poId5dq2eRmRMhBZ3ZE
	gQhmGpeF0/QZWr4BmVJji3fqFsh2Owf/gQlW8QLK5Nn8qiVcWsKB8CvdlunsI9M/uziMf6Gi7eS
	fARLf+jhMH3nUAtytu1VpbaIoze/dtZ3jVgYTQAgL/rB7xYJ1CXxLMkZ6hOD+W4nd5B3E47kM2b
	NNQVnYBC9p0mGTZLDaCq4SM9avNcc8hGE=
X-Google-Smtp-Source: AGHT+IF3Msd8ZoPMJEs7K/zv+zF43VhoJYGAT779uFAi/spPfWjaRb9gxGyuHHyUSSki7SqM8rn4Gw==
X-Received: by 2002:a05:600c:1c03:b0:46d:fe0b:d55a with SMTP id 5b1f17b1804b1-46dfe0bd756mr14051695e9.33.1758539825257;
        Mon, 22 Sep 2025 04:17:05 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e006cf0c3fccad951b0.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:6cf0:c3fc:cad9:51b0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464f0d8a2bfsm205116075e9.2.2025.09.22.04.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 04:17:04 -0700 (PDT)
Date: Mon, 22 Sep 2025 13:17:02 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: syzbot <syzbot+e1fa4a4a9361f2f3bbd6@syzkaller.appspotmail.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com,
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@fomichev.me,
	song@kernel.org, syzkaller-bugs@googlegroups.com,
	yonghong.song@linux.dev
Subject: Re: [syzbot] [bpf?] WARNING in do_check (2)
Message-ID: <aNEwLpylAfkgj3L-@mail.gmail.com>
References: <aM1moP0fr7GrlbWZ@mail.gmail.com>
 <68cd7300.050a0220.13cd81.0000.GAE@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68cd7300.050a0220.13cd81.0000.GAE@google.com>

#syz dup: [syzbot] [bpf?] WARNING in maybe_exit_scc

On Fri, Sep 19, 2025 at 08:13:04AM -0700, syzbot wrote:
> Hello,
> 
> syzbot has tested the proposed patch and the reproducer did not trigger any issue:
> 
> Reported-by: syzbot+e1fa4a4a9361f2f3bbd6@syzkaller.appspotmail.com
> Tested-by: syzbot+e1fa4a4a9361f2f3bbd6@syzkaller.appspotmail.com
> 
> Tested on:
> 
> commit:         a3c73d62 bpf: dont report verifier bug for missing bpf..
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git
> console output: https://syzkaller.appspot.com/x/log.txt?x=13928d04580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=4d8792ecb6308d0f
> dashboard link: https://syzkaller.appspot.com/bug?extid=e1fa4a4a9361f2f3bbd6
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> 
> Note: no patches were applied.
> Note: testing is done by a robot and is best-effort only.

