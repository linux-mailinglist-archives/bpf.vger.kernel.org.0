Return-Path: <bpf+bounces-54966-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22897A766B6
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 15:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53A581888569
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 13:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCDDF2116FA;
	Mon, 31 Mar 2025 13:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bdFmwDFu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA05211299
	for <bpf@vger.kernel.org>; Mon, 31 Mar 2025 13:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743427192; cv=none; b=fu83xGgGTgT/PDlGBJN0C1adM7rhXbiP4huUoDYKYTj2O7bfuV0DAT7V1A+YOR3DC5OzuK4/HUdDg9Ty8pxTLE80HgoaagIi3OHhthu963Ic92b1XSpGz80KPMZnmoiLGvZ1OVNk07N53YFz0/cNSmxXa3hTPS3OqnPQY+5ZVqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743427192; c=relaxed/simple;
	bh=P6DCTUit0leEkPXg7yvciyfLzZCMNlz+axqKHwql/cg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UKvD058P+55nFV/unbJ4fPss3AZd0+XuNOsq9GLBMEI6tstoKxKFrgNZWoH/0cCWaenc+aTLFDr17j8lbEushf0TfoutGh2V5KxZ3XQPfOaUH9gjrcgdle3zcUjdfrWIoyaG/dJDEMY7PgDArZN0RbScHiWzvmZzo7XQtk6+2qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bdFmwDFu; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-43d04dc73b7so50823865e9.3
        for <bpf@vger.kernel.org>; Mon, 31 Mar 2025 06:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1743427188; x=1744031988; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YcmYk5PTzxCtOJOaVVP5nkeOuljxOTS0F0qSnk/8Fxg=;
        b=bdFmwDFuhB+0Gfw/nwoixHXAPnagSqngq0oFhy2OTzNvXJUcT0sNuoFCClUQw7uBuz
         KYkkxUpMQ+H3ShxhEUeJI6F60G59kUzJCwNBboyjzYLrbyihXmIwVodeSQz2j9U0IvN/
         zF1Aivt/B5O02E+hiCLTunMTIrj9e0kfF2Bafh95oUgsPZVqqcOYqL4xu+36mTrTv6cA
         sH5hF3AAX74wkDfaZ73JFf2ssrSIvIXT9UDDCjafcx0zbWkFkg8UvK47i/JDfqkbincz
         F8Gj8ccNJhtEYlT6HVf05ggMwyv/gzfd28sexlGo4qjUSra8fi2vHU9FWxfmB6Z2qJbB
         hK3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743427188; x=1744031988;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YcmYk5PTzxCtOJOaVVP5nkeOuljxOTS0F0qSnk/8Fxg=;
        b=T+Q41O59h/dhXnX0SmH9jxqvOf2hcO43jSzhE4YCGV8H8CZ+a0kiWUVuem0UGK4SeM
         tQvw0b29YAdsUkmIdT+Tn4mZnf/pf/NJYrl50TN+0zz2p1NpxZCnC0zxKsIOEzdgZkWN
         X70FtFnlzZipyRfMMc/UEzwKDWfWQBLXHWMS27qUnVo4geWvjGW4EA5xj/Q1tgjLt2LN
         uIx8Ef5SOciKJrHg16r5VZUD0oO0vi49poayn95geSUHudwCFV0lYGOlMWQNiL3+bp/m
         qUpDKytu9zQhmNciRPkDPSBO7EZQmbCmvYIDVwTBsr7yyCutL7LmfJu/mcDOUrWhBryf
         tM8A==
X-Forwarded-Encrypted: i=1; AJvYcCWpF9hQvsyyxC75QSY/vuQnOiPt2RkwLJbuoQwRvy/XjJgAPd/KDOgVrB7OclYgQsIp+eM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfK0J19LNdbSkO4+Texbr55u4nb1EUCq3eycTQk+vPFjwEYsEi
	+VN+NNo+cdLZ8ORYdPAxgAYTOHA8sCnUMhf0Hy1a9BCm+0dsChOqTstQA3a1oPg=
X-Gm-Gg: ASbGncs8r/fyN5zYT4P1Rw7akzQKMo/xa3N/V8Bn1OtXXt35N4M8M4EeHJ0rp6+c8OG
	4gTpsotelCuOqnp2eav2nSbRJ/tTUwH87CaVfPJaBrxQeCsWqwKycmS3ARocGHN7cH7BLWANu3I
	sNdEfTNYkVdcR4QmbNMlv8edlotgfmeYBHSPd7orRnBoJ6qPE/8Cp+4TcsfRZ78P4qvJ+3ANDJf
	FSLlDYm/jS/6ZuJd9hZ5B+TNA+zzlsd9xW3DWOziNb+NSUgeNOuhKFbNcrak853eP5Zv73inrhW
	cdHZ8nPWPbSWMZclc0tgeFHHBg/3rvdi+iW70FQmjOAQWuCDz6i+VKNObQNXp/ouX5FbLQYchV2
	ZkoWwSUJXtQUZb+k9EO+EhVCTf95h29n3PcTsyQ==
X-Google-Smtp-Source: AGHT+IGZqmArJyrihK4euVLU0horXdZgOg53706JbhiZUWs5TDnkpgzuRWwj3lskoRyG6Hkk8G0VLA==
X-Received: by 2002:a05:6000:2b06:b0:399:6d26:7752 with SMTP id ffacd0b85a97d-39c12117ad8mr5124011f8f.38.1743427188556;
        Mon, 31 Mar 2025 06:19:48 -0700 (PDT)
Received: from u94a (2001-b011-fa04-3f62-b2dc-efff-fee8-7e7a.dynamic-ip6.hinet.net. [2001:b011:fa04:3f62:b2dc:efff:fee8:7e7a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291f1dedcfsm68393265ad.193.2025.03.31.06.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 06:19:47 -0700 (PDT)
Date: Mon, 31 Mar 2025 21:19:36 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: "Naveen N. Rao" <naveen@kernel.org>, 
	Hari Bathini <hbathini@linux.ibm.com>, bpf@vger.kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>, 
	Mark Rutland <mark.rutland@arm.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Masahiro Yamada <masahiroy@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Vishal Chourasia <vishalc@linux.ibm.com>, 
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Miroslav Benes <mbenes@suse.cz>, 
	Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-trace-kernel@vger.kernel.org, live-patching@vger.kernel.org
Subject: [BUG?] ppc64le: fentry BPF not triggered after live patch (v6.14)
Message-ID: <rwmwrvvtg3pd7qrnt3of6dideioohwhsplancoc2gdrjran7bg@j5tqng6loymr>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

On ppc64le (v6.14, kernel config attached), I've observed that fentry
BPF programs stop being invoked after the target kernel function is live
patched. This occurs regardless of whether the BPF program was attached
before or after the live patch. I believe fentry/fprobe on ppc64le is
added with [1].

Steps to reproduce on ppc64le:
- Use bpftrace (v0.10.0+) to attach a BPF program to cmdline_proc_show
  with fentry (kfunc is the older name bpftrace used for fentry, used
  here for max compatability)

    bpftrace -e 'kfunc:cmdline_proc_show { printf("%lld: cmdline_proc_show() called by %s\n", nsecs(), comm) }'

- Run `cat /proc/cmdline` and observe bpftrace output

- Load samples/livepatch/livepatch-sample.ko

- Run `cat /proc/cmdline` again. Observe "this has been live patched" in
  output, but no new bpftrace output.

Note: once the live patching module is disabled through the sysfs interface
the BPF program invocation is restored.

Is this the expected interaction between fentry BPF and live patching?
On x86_64 it does _not_ happen, so I'd guess the behavior on ppc64le is
unintended. Any insights appreciated.


Thanks,
Shung-Hsi Yu

1: https://lore.kernel.org/all/20241030070850.1361304-2-hbathini@linux.ibm.com/

