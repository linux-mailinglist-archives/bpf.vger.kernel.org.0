Return-Path: <bpf+bounces-71435-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3838CBF2C50
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 19:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E6B93A2BB4
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 17:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F50331A65;
	Mon, 20 Oct 2025 17:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GyAzErk3"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771C931B10F
	for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 17:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760982054; cv=none; b=k5qvv1quyGXlJ+FeBdvPU0YIjI8M6TFmlUDoc0fuB0WwbxV+ZePHKkd9I04J05FYYCepx6TUYouL33E/CjhkGUw4Zz7T6NQVwvrb0Kme0e7xSiOWp1Xe9XxWo51aSgvGfk6N/Ho2chUjPS+crt5yPk6KxfJZiBAYC+q2X0+kN7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760982054; c=relaxed/simple;
	bh=33JwkN0c4OxqCnWyYrR5XwpQI3m0GzMLZfEtCy3F2AA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=LACyzlDnHQzk+06JSMZeywRpcxOaROnETO1lyjGlfVWnrvzRs6DQsKCePkftft3WDW3Oh+LLoaxk/L6lbEuxwdjqw+D6B4fdm2xwx0DEmmAP+9DasEeJbzZw/DpR4TKmwsreq3rAc8v77LhBTK/vBjj5QSsmSM+x0HmVRFr3Ct8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GyAzErk3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58853C4CEFE
	for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 17:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760982054;
	bh=33JwkN0c4OxqCnWyYrR5XwpQI3m0GzMLZfEtCy3F2AA=;
	h=From:Date:Subject:To:Cc:From;
	b=GyAzErk3DqKkGQVP5y8IqdFQQR0p+Jt7cjXmAVpnaPJaTLNSb/KnyCp5VMDDPJrWH
	 LdsZ3AsrrmhZCZv6RaE5HKIUgZJm2dPym2x35D6djAoCZoMWTY2lIbmIR8PsbMzyMN
	 ni/XWy5uK70yJPfyGVR8bL4vD9s5Pw5skZgpca2+nVoIzreePL/KDznP/FLLeVL5qb
	 HgH7YQBCxGx+PdwdH9lzOABwcyhoND7j0fOIdXv7/dAmX3yitGOFt0Uj4xggxLLcji
	 dwDgdNCTAOEoJe6BdKiq0AdXauI7gtEmaX+QfyzAkcp4gN/h3zfWishajtGyybQPa6
	 A7JMgF7q56kJw==
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-87de60d0e3eso6247506d6.3
        for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 10:40:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXT1k/Ioggi7FqIimmFPurTsoC361qbvr5fA2/0DlhwVG6jo0lS3SgJKIe+hQFDJ1+YicE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqmop7FExgelettJoch2FYkLJbBnFi/45Op6eP82NOY5ukz3Xx
	ngYVfmaIcbmXf1sDjuOgT9ZI6T/e8WEEqeiboX3r9IxGsAChkhPAtxYcRM4/M9mbFRQ9X/3l9fi
	0OyFRCnEHwWIKsJrFzP/ce2376e053AA=
X-Google-Smtp-Source: AGHT+IE6Vzd16FcbeBOMBXPpUL2dqpcIdH6E3O/h6H6m9noF6wP/3iJIflxKEQq6Niz27yWjaCr8FYpDB5Q6K7aMsis=
X-Received: by 2002:a0c:f089:0:b0:87c:2213:ed28 with SMTP id
 6a1803df08f44-87c2213ee5bmr178472016d6.27.1760982053553; Mon, 20 Oct 2025
 10:40:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Song Liu <song@kernel.org>
Date: Mon, 20 Oct 2025 10:40:42 -0700
X-Gmail-Original-Message-ID: <CAHzjS_u_SYdt5=2gYO_dxzMKXzGMt-TfdE_ueowg-Hq5tRCAiw@mail.gmail.com>
X-Gm-Features: AS18NWCP_xGl6IEii37L-2PXQXikvOE4GhujqkkZXqmMWsUBdnESg39dTP4v_eM
Message-ID: <CAHzjS_u_SYdt5=2gYO_dxzMKXzGMt-TfdE_ueowg-Hq5tRCAiw@mail.gmail.com>
Subject: 9P change breaks bpftrace running in qemu+9p?
To: v9fs@lists.linux.dev, Tingmao Wang <m@maowtm.org>
Cc: Eric Van Hensbergen <ericvh@kernel.org>, Dominique Martinet <asmadeus@codewreck.org>, 
	Latchesar Ionkov <lucho@ionkov.net>, Christian Schoenebeck <linux_oss@crudebyte.com>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

I noticed a new error in the upstream kernel when I run bpftrace with
vmtest [2]:

$ vmtest -k arch/x86/boot/bzImage "bpftrace.real -e
'fexit:cmdline_proc_show {exit();}'"
=> bzImage
===> Booting
===> Setting up VM
===> Running command
[    5.610741] id (178) used greatest stack depth: 11592 bytes left
Parse error: Input/output error
Command failed with exit code: 2
[root@(none) /]#

git bisect points to patch 1/3 of this set [1].

Any idea what is happening here?

Thanks,
Song

[1] https://lore.kernel.org/v9fs/cover.1743956147.git.m@maowtm.org/
[2] https://github.com/danobi/vmtest

