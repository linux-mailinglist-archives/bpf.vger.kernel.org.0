Return-Path: <bpf+bounces-58991-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF74AAC5010
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 15:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF83116802D
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 13:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5611B270572;
	Tue, 27 May 2025 13:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dRYGWLX6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C8026F449
	for <bpf@vger.kernel.org>; Tue, 27 May 2025 13:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748353139; cv=none; b=LlvULrcn3Z9WTnYqgoayhRE4Ppo8AyOibmX8iV8LxhToGDsUCNqowNbBgxV95bbXniqSpDFhmmupMeCvkyCPiryzVZFIe9ZwG6CQ3v+ydB51vGjp1SyQcczUuGmMwqgDl6+1Zc2rTwyHrS+NumiNYadzU4QeSFHw48qOxEDj8wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748353139; c=relaxed/simple;
	bh=SJMIIIvzb0MZKStkb3IA1wGyVWx88w36WEUpDiWCYeM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=L7RMv43OVwVvhZvFDUrN7sEMR+yCeEfS8xyYZcZIIXVmryUZGfr1XcviNnguZBm3fGEiiHcU/B9fIrDoZ9CHck7vdH6FdP5O0brYZpMzvGZ3XgDJAimSo8N1W7r7WwbB20AEzmKCmh6a+2VZJiraD49qpjefd0NKUW1vjK5xU+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dRYGWLX6; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-4e45cfc3a26so879247137.0
        for <bpf@vger.kernel.org>; Tue, 27 May 2025 06:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748353137; x=1748957937; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SJMIIIvzb0MZKStkb3IA1wGyVWx88w36WEUpDiWCYeM=;
        b=dRYGWLX60ocFqTcOO5e50hxz42tdBzK4rUR52N1Pr8aP+UAawp84Bz6VchXO7MthbR
         LFj4MOzA3PAcaOScrxiM1BjtjEgiAe053H42wcWd+KqCsoegLI32yjCNqoJ/317l+m4x
         8hdbPBlOjMzwIZEGTf9kBBfYzPLFoyLj+cgwVznxwjRyKE/neLVQhpgVoYYsoM4egq3U
         +HKIuD7U5EPih9vpog6uPeqdnFxhVYSTsWPzA8ymwr2vEk5TicNKisU9btVbOFbHrwNb
         y/ZNqFetXDzrRpvl8CsuiqXgXRG/5kaXyiIPU8t88fw/39VdzQbw3+XQGq1sb+bswJoq
         NuXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748353137; x=1748957937;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SJMIIIvzb0MZKStkb3IA1wGyVWx88w36WEUpDiWCYeM=;
        b=ORRPo7xL3c2WW214eyvH/DmjnaNWWjxLiil+9ccd5c8+vQJFcCMfPQWqq3ZVnbd7O0
         5LVoobNCJr+g03HKSXdYiGd1GyYxBCAsnPrpt1u5LZjzmv04RoDVFLlX/wkfYWlVN+Vy
         j27zwSPFh+LKn35zwK/c3Khw47hGQhUumpnavWKVEQnLrrj916OgsldOb1BleNJdvgVa
         zeHj6Ot9C8HJ9BdzXTwsXucLFPVASrqAUZCXFtaGHcDWibGjxOKViSs4LhrqYrqHm8UJ
         jK4modWecITS3+JxrXQPY7E5tnbVaTMpn3Ybe45dWeQjXNpFDpRyCfFSxgeQTOwnuUig
         RIUQ==
X-Gm-Message-State: AOJu0YxTCmaMz631eaGPZTfV2Nnk7MpYgdLb1CxYZ41FtH8356XtcNPb
	L8oLy/ehMTLrpm6en9fXT80v5d3ifZTEB1nhByphNeeWFYqxxBLcIhbQjMljhU92Tlmy1wvEYCw
	UWHKl7ahcIOtkXCFjGdq2d/4H1GCs11M5wuWy
X-Gm-Gg: ASbGncuQTZWYLZzxI8n9c32Ge10FZRdvwOiBrZdw2855tMet/3QQLG5SkHev6dAXvJy
	OD1rhzw5mlgoAFbf41ZbpgqVI+moH/vEMuIuvpRNztJfvt+aNPMA2fWBu8/S1CczRCotO0NG+Hk
	5FpBg1TP8RopWnmJn+6iWNEKFMxAYF3cDkA94=
X-Google-Smtp-Source: AGHT+IFONBVng5ZPGkIWDTEoCKpuImFKPkzSEUnjr9nFUzYi2tdiHwxKKuAwvRJaWKgnwWBnEf1/5pXhMzyBxhEZwGU=
X-Received: by 2002:a67:bc09:0:b0:4e1:ec70:536 with SMTP id
 ada2fe7eead31-4e597c87dc5mr466262137.4.1748353137086; Tue, 27 May 2025
 06:38:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Nadav Strahilevitz <nd.strahilevitz@gmail.com>
Date: Tue, 27 May 2025 16:38:46 +0300
X-Gm-Features: AX0GCFvNq-h3A6eqfP9u7zVdDkoMNo1jgxoztKXi3GqJBMmArMmEPLj6h8HiUgY
Message-ID: <CAFZ-7nQuW-9ukOFjxfV6BxiF5Qyysrdf72B4DjMeX0PY6uwVLQ@mail.gmail.com>
Subject: Perf buffer lost events not reaching callback
To: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello!

I have recently encountered some strange behavior regarding perf
buffer lost events (the percpu kind, not the newer ring buffer). In
libbpfgo, we pass a callback written in go into the libbpf
perf_buffer__new constructor, which, when a lost event count is
generated, passes it into a channel exported for consumers. This has
been working well for a while now. However, we=E2=80=99ve recently encounte=
red
cases where bpf_perf_event_output will return a negative errno (ENOSPC
in this case), and no lost event will be reported. Further, when
adding some prints into that callback, none of them show up, which
indicates that the callback isn=E2=80=99t being triggered at all.
We only found this since we=E2=80=99ve introduced a separate counting map
which handles negative returns from the output call. Curiously, from
the source code I=E2=80=99ve found, this is just the errno currently return=
ed
when submit fails, also due to reasons of a full buffer (but also
sometimes when the rcu pointer dereference fails). But in any case,
the counter for lost events is always updated, at least as far as the
source code shows.

Has anyone encountered this kind of behavior before?

Thanks in advance!
Nadav Strahilevitz

