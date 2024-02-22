Return-Path: <bpf+bounces-22495-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9376885F57F
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 11:18:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E670284D0F
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 10:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1181B59E;
	Thu, 22 Feb 2024 10:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQBK96hA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807E739FF0
	for <bpf@vger.kernel.org>; Thu, 22 Feb 2024 10:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708597119; cv=none; b=Kg4wGTAOzwGNqBKOwULJDPmJTrxqP7raxjgk4YIRyEKjcGEhUMnqmOTa0zm1rYF03DLhHEaDHUgDLBRFT5pajXbps8V5Lx1F0UMb7HXFRW1pr5vkdrHBQbAz0TvryYfycjU1k5WHLKyWfBBb5C2lwhBab2ayl+Sb8gOAgO9SFwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708597119; c=relaxed/simple;
	bh=3yd9APvrnglv5A1KSGXmHMAENtM2yNNRlvSlah5fGe4=;
	h=From:Date:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=seIERnYMXNhYuJkcE48xNT6MmuIFw7AT/dgEVnTrAfK34OgwWD2zGmmbCPwyLe3WgazIVGx2yW7ZA9hJTdPVbuAg4xhty6J8lvbKQxMCZqBBcesR0dwJWWZy3pjv4b97Nj2Q38zN8j+D8v7G7qjAF1p3vz+Qm2QiVcQ55ew67iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YQBK96hA; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-564e4df00f3so3097356a12.3
        for <bpf@vger.kernel.org>; Thu, 22 Feb 2024 02:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708597116; x=1709201916; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pWCrDso5/lkvnXbPDxi7h75VdYXX3PrF2jTFUGYgYI0=;
        b=YQBK96hAvJHJTwRPDOIOdOmYq1mQFz6L5IVLjvEh3wbDAQrR7ZbHR8XmqbBx+r2QXr
         vfZuj249bH8habftf4F2z3jhtVwy1TwHeCJMtZWY4ntRk37fPEUNWqKAkf43M7wPG0OT
         xRF3J91p/kWFpHiucB8w98l427Dd9Wnp3/LlacR7HSQkzHKccaKcU2PSuH6lPmKs3hIT
         oXb86YMlWsTlGi6MqXvYg67nv4XXgNLTYT+oKcoE8FezJ+fAfeG4mIVpD9bnU0c2KTfW
         sEXkbcoJJVlOv+mBdzvDTBqD3mYHtpX2mVQs2uvbdy9vmVOeiceJdMXSMP8nSIAUdik1
         bc1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708597116; x=1709201916;
        h=content-disposition:mime-version:message-id:subject:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pWCrDso5/lkvnXbPDxi7h75VdYXX3PrF2jTFUGYgYI0=;
        b=iktciWuJVbT+ullpHPoiTibxEB3/84IHLEIR1uqmz4bp5w5GPCbgdWTtmmgQ92an2u
         BpcVtyNxrRFoqsMpnD2JDdoqr52GTOFQTUwbD48ctq+SkCOGxPWb5r3oxat05f3fdW3/
         yWGWYl+TZ8F1vMd3R4Wls6qGPljxJRWnMAVplIsoGhF5m+0CMqn5Qct90K8yJOKPAWOn
         C1/MExO5lsK0rv0EwPtgyYAk6NtzqE7kCnGQ+DQjM8eO1BvMnHgiv3FuFgnSmWTnIhmQ
         e3DPHb+le55yl89j9HB4X6H89WG7VgMSk1JRSSh+yVwR/T6hdRc/GtApCoibJkqzdSGn
         wWHA==
X-Gm-Message-State: AOJu0Yy6FUptORsYR8HAZrT26iivMxCgBZU8I1RA1DeHnF/zpiGrfa3r
	5HYbJk+3fNO3sL7AxS2ujvWFMKXsaqPlMa7HHebopH5SnyZ/jZEeI8SWx5gB
X-Google-Smtp-Source: AGHT+IGe5RB4XUz9xvgjiI46gTq3EHZa/JJKL00qnwesR7TKk8H2jl9/qzG4WtmsTlcpFRsWeEbJew==
X-Received: by 2002:a17:906:f199:b0:a3f:5115:1840 with SMTP id gs25-20020a170906f19900b00a3f51151840mr2742277ejb.62.1708597115358;
        Thu, 22 Feb 2024 02:18:35 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id vh8-20020a170907d38800b00a3f28bf94f8sm1689681ejc.199.2024.02.22.02.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 02:18:35 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 22 Feb 2024 11:18:33 +0100
To: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	lsf-pc@lists.linux-foundation.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: [LSF/MM/BPF TOPIC] multi kprobe updates
Message-ID: <ZdcfedGHCwxOI29a@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

There's few ongoing kprobe multi features that I'd like to give an update
about and discuss.

- Support to execute bpf program for both entry and return probes. This
  way we don't need to create 2 links when we need to run bpf program on
  entry/return probes of the same function, first rfc posted [0].

- In addition to above feature introduce shared 'session' data between
  entry and exit probe accessible from bpf program, originally discussed
  in [1].

- Allow to use per program re-entry checks instead of current hard coded
  per cpu re-entry check, or just change to per program check directly.

- There's ongoing development of patchset moving fprobe implementation
  from function tracer on top of fgraph tracer by Masami Hiramatsu [2].
  As kprobe multi link is implemented via fprobe I'd like to give an
  update what this change means for kprobe multi link.


[0] https://lore.kernel.org/bpf/20240207153550.856536-1-jolsa@kernel.org/
[1] https://lore.kernel.org/bpf/CAEf4Bzb6sPXAtDVke=CtCXev0mxhfgEG_O-xUA-e9-8NnbBtJQ@mail.gmail.com/
[2] https://lore.kernel.org/bpf/170723204881.502590.11906735097521170661.stgit@devnote2/

