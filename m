Return-Path: <bpf+bounces-20491-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2CB83EF8F
	for <lists+bpf@lfdr.de>; Sat, 27 Jan 2024 19:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1212EB22BB6
	for <lists+bpf@lfdr.de>; Sat, 27 Jan 2024 18:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C082D043;
	Sat, 27 Jan 2024 18:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="TcHOO0pM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D0C11185
	for <bpf@vger.kernel.org>; Sat, 27 Jan 2024 18:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706381405; cv=none; b=nkRIJ7UcEvu7tPZn3SntLA3FJ48NTLUV+K542I6yWhmor+fK4oKOcb2+s8lPtOcn7+hgPl2HEEMOlroQ+krTmhsyUaEw/e+HCRz6poCWs0/19sDgUTH6jk4SvviEq6znuVIIBzdg7Jh0gkUiAcaYRrreGHp1YYSiYazaNm5Hiwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706381405; c=relaxed/simple;
	bh=hFIWfEJtppVlW8q7QlTZSNW9/neLK9wj1OlzvOsuvh4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=i2ehrSIMWh/0TUIMupAFtZmgQLfq7jKK8nmFARMnzIznDNQ127X5Q1gvNYAhoEQt5LsRobUpAn0/ShIeoxo3kd/GM8wxucVRADU43uy0ddFaMFOs3vVJDEVlwHl+IdqdIK/YQ1jQbevOgr+sprn2/lu0A7VqJwjBizy9kW0CiJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=TcHOO0pM; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5d8b887bb0cso491700a12.2
        for <bpf@vger.kernel.org>; Sat, 27 Jan 2024 10:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1706381403; x=1706986203; darn=vger.kernel.org;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FmSxRIxxEVrSN2b2xD7MZrQdByOFmfJtEY+7wtSfGn4=;
        b=TcHOO0pMga+dmZr5zmMwHPeC7+OsV7GZqXRdUvxXa0fqj7EWkp5rM+Rl7E2UJ7zgQV
         XcpRR4MiqadFrgDh5N2NQuL2bV9e+ZlkPbSmfSB13ZetuCe0t0ByO73DZ0uBgklHtUgV
         0D8Q6fPji4+8z2bhntxJRXaTq1+/M/KuVQbisUXWR3ejFuB0GJ3EJHcbXJ0vOKjtc7rK
         oLeoqyfrs3L0AmqLadI2PyeJnKRLNXQvdQQdr+8UwhfMkANYEzk9v/DHoznZd8zAtp+p
         6XrNYCwHm28gB3m43rN6fl3P+bwvsc86rNbOaPNH8xh76zgqv1Rf2u34t5z380LDrn1r
         vwnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706381403; x=1706986203;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FmSxRIxxEVrSN2b2xD7MZrQdByOFmfJtEY+7wtSfGn4=;
        b=uxaYlYYU/fLUY7pexw8A/uaGiOh6WxdNOPXuxvy7Dc2DCPWgTtq7GIO+cExAWY1O8b
         UL1WjypIZKTt58wGupy8nSSoqUJ0+Z7JgyLTrf5nKNuHngPiNGuclpnqV3EaHf5js44d
         1IS1v0Ft/aVieIRpKo+goriY0TYVr2SwLLyibGFsN6bZmlM9rryrAUI8TNMhgGJAarBn
         GdmUAjtgKl6fI8XCWE5+jO8n/o9thkN9eOIJLQOMOIg6VB0ptLSBCxmjLyLG3Gm1CQZ6
         4WmwlzFm800WjfdXCXCCWhFzlYOHEAXdGH/P3OA+v2K+rh8FsmB4MqgnbMcIyGxB24R2
         He9g==
X-Gm-Message-State: AOJu0YxSqcyyOsR0Nw51UDgYwjkwBSTE7Waw3MkGmtL1pHYPu41vZ/QD
	kesT9+Srj0N0MD8moKwibeHCthAYPxgX+pBhR4v0uQ6jqpood1UlJEG5be+evp0=
X-Google-Smtp-Source: AGHT+IGLvSJS1CsAz7tLOBBec5fNhI3I8VIaYDe7nUxtT27CQKy0sTZN0mkn9Oo0L6TGIC8taxQ9Rg==
X-Received: by 2002:a05:6a20:9282:b0:19c:61eb:132f with SMTP id q2-20020a056a20928200b0019c61eb132fmr2025956pzg.15.1706381402855;
        Sat, 27 Jan 2024 10:50:02 -0800 (PST)
Received: from ArmidaleLaptop (c-67-170-74-237.hsd1.wa.comcast.net. [67.170.74.237])
        by smtp.gmail.com with ESMTPSA id a8-20020a62d408000000b006dbdac1595esm3309019pfh.141.2024.01.27.10.50.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Jan 2024 10:50:02 -0800 (PST)
From: dthaler1968@googlemail.com
X-Google-Original-From: <dthaler1968@gmail.com>
To: "'Yonghong Song'" <yonghong.song@linux.dev>
Cc: <bpf@ietf.org>,
	<bpf@vger.kernel.org>
Subject: ISA: BPF_MSH and deprecated packet access instructions
Date: Sat, 27 Jan 2024 10:50:00 -0800
Message-ID: <006601da5151$a22b2bb0$e6818310$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AdpRUTXsbObYInj9R7O7W5hyfIwmTw==

Under "Load and store instructions", various mode modifiers are documented.
I notice that BPF_MSH (0xa0) is not documented, but appears to be in use in 
various projects, including Linux, BSD, seccomp, etc. and is even documented
in various books such as
https://www.google.com/books/edition/Programming_Linux_Hacker_Tools_Uncovere
d/yqHVAwAAQBAJ?hl=en&gbpv=1&dq=%22BPF_MSH%22&pg=PA129&printsec=frontcover

Should we document it as deprecated and add it to the set of deprecated
instructions (the legacy conformance group) like BPF_ABS and BPF_IND
already are?

Also, for purposes of the IANA registry of instructions where we list which
opcodes are "(deprecated, implementation-specific)", I currently list all
possible BPF_ABS and BPF_IND opcodes regardless of whether they were
ever used (I didn't check which were used and which might not have been),
so I could just list all possible BPF_MSH opcodes similarly.  But if we know
that some were never used then I don't need to do so, so I guess I should
ask:
do we have a list of which combinations were actually used or should we
continue to just deprecate all combinations?

As an example,
https://github.com/seccomp/libseccomp/blob/main/tools/scmp_bpf_disasm.c#L68
lists 6 variants of BPF_MSH: LD and LDX, for B, H, and W (but not DW).
Other sources like the book page referenced above, and the BSD man page,
list only BPF_LDX | BPF_B | BPF_MSH, which is in Linux sources such as
https://elixir.bootlin.com/linux/v6.8-rc1/source/lib/test_bpf.c#L368

So, should we list the DW variants as deprecated, or never assigned?
Should we list the H, W, and LD variants as deprecated, or never assigned?

What about DW and LDX variants of BPF_IND and BPF_ABS?

Dave



