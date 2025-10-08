Return-Path: <bpf+bounces-70621-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E8698BC6A4A
	for <lists+bpf@lfdr.de>; Wed, 08 Oct 2025 23:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 42E164EF221
	for <lists+bpf@lfdr.de>; Wed,  8 Oct 2025 21:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96FC424EA81;
	Wed,  8 Oct 2025 21:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UYptFm/h"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A542BD5B4
	for <bpf@vger.kernel.org>; Wed,  8 Oct 2025 21:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759957712; cv=none; b=XYzr3LnUfBdVQhopE8Uk1j1abJGznYZ5SzkXmWN++e0wZQ2ZI6ItjZSnF8LFjq9N0WDuJYtAlCdT9vv32R/7qzps1eE+vYOHZXecvPVdSNGDcvnBSr73qsaYJBkE43pd2/tVJAq3wqwamr2NgN1AbZBec7+iu2dh9Ifbm+MyzgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759957712; c=relaxed/simple;
	bh=JBsfr1aesD7Pm/tSoQN2ISv7AGsns6r4d51ITiT2a1U=;
	h=From:Date:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MpfOOtwwZEgM1GumNDx7WTh7kqFhGG0MQ55IwKVNwc31L2L2njztLbFJ0dhDvZPkcLSemSbyFWy/SzcIz2LzMcV/UqFMtAwrbCDTG2MQOjQthvGIY76cFt48LOulJlj90GJCKuPku1Hmhu2QCzNXJ37tCQIiFHlfkAhxqQ/vjbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UYptFm/h; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3ee1381b835so309260f8f.1
        for <bpf@vger.kernel.org>; Wed, 08 Oct 2025 14:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759957709; x=1760562509; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TGvtU6ztqZrVUzflDHPqEVh6RTR0jNPWQnV/VMSP+Ko=;
        b=UYptFm/hQwRJyQCImWQVwhdhEznFDuyJtajmOwo2x1XxwUtcxPUHEWjDvPI7zA0ymg
         6IofvdFUaDp870MFiUMH+5zd64LEYNHr2jFFUn3RTGzVn8KF1tuHxmWUtpGyEEyMrr7M
         0kPjjOGc9nuWNATb++5LWezEroKgyQz/ffR8PmCLVHCFYofNPWwizm55UlMGmHdjSmIN
         rpjd/ddyQSQTb7ygtl7XGKNTtK2qSx2lCqJQiP6pwV0c46fT0olF1Ik8vITp74mZjde/
         Sgzfv3BneqXeVpgOb6pHM5FJC+T63fFevi+m6Vwp/6hm8a3DgY36Ldzv198kZVPxnFqg
         RCzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759957709; x=1760562509;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TGvtU6ztqZrVUzflDHPqEVh6RTR0jNPWQnV/VMSP+Ko=;
        b=ctXBQhXINKSe5MBpt+c7nMuGD/AVm62ll1DMWYFh47L1ebFqlu8FNLpUTNoKETDdFk
         dlOAgmanhHFjePUQT7JjoJyllLbn0HVts4pHuMDwRXwAJeDPR8sj94Cla8+HG0+bMpnQ
         SsHCDascDMkigzDH4cQ/U6SM95SxKx35SMqyoD9efxRG7v92XOUQn64N/7u4DNC8ikj+
         KMpTOyUn0ux5PudZZ0WZr5KJQoStm9N/N3GuQqkasjpVeRobVWxLjQsl43kUEodg04Mv
         SsSZl0Cw2bFSVBQn9k+FxLcmEMLJde2k3r+zmSwFOoiR9+AmKEP2dLi/Fu7fm4gzGzQi
         52wQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWQfBKEHhDnhJAffFFvqSC3TTpjOUvD4S/BKeCYpn46hUGekab0s2y593dsSf/VncC4zA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhUTkNmux8PyZqU61rjxaCiuBuPc/G5XGuzjZm+gHIhFEET9z2
	qvWg+Oe74CNtvUpAi3u0+OqXWg40xLVPGef+pVoOUoPKem/q7cgd+95z
X-Gm-Gg: ASbGncsk2J9sddCRaMMMPNkArx38GTvSQP6MAbGIk22hd7NzFa3sZKm/pX4o6RvS4oe
	0oq/+orPXcpVF5mTWdWcmDLUGdz3ylJ0gJ63sBBZw3yKQVpYRRzwAw+RZB4bQyK1j2YFKru4b2f
	WpFcJwJErDAcidFtZxdL+GTGrIm8KQUhHpqsBiits45cPYubyfm7vcUaWSMGg0pdhXJz/xRHq7U
	7Q7618K3+iVZ5PDrvAq9uLc2qRaPochtzxSlIx7TCb4R3w24f8622hBqIs5CjVKdyDj+Ldk84Nh
	39VsDpdpUWY9zLj6nymEjHjjw4FSZIhCg8z1qME44RJGjxZn8gdYf9U9JrIvxsXfLPiiwvpgdw6
	npw54XNf2l5EaUEBppC5aLiG68eoUMQHq3vQ=
X-Google-Smtp-Source: AGHT+IHP+VP0VqlOlba/K/aTPk7nK05CBsQlGJMqinsVgs5zeUQOJt/inVq7nvGWwAfjrSQmZurPhg==
X-Received: by 2002:a5d:5c8a:0:b0:3eb:a237:a051 with SMTP id ffacd0b85a97d-4267b3395acmr3188701f8f.58.1759957708613;
        Wed, 08 Oct 2025 14:08:28 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fab3d2c1asm21539275e9.1.2025.10.08.14.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 14:08:28 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 8 Oct 2025 23:08:26 +0200
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, x86@kernel.org,
	Yonghong Song <yhs@fb.com>
Subject: [BUG] no ORC stacktrace from kretprobe.multi bpf program
Message-ID: <aObSyt3qOnS_BMcy@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

hi,
I'm getting no stacktrace from bpf program attached on kretprobe.multi probe
(which means on top of return fprobe) on x86.

I think we need some kind of treatment we do for rethook, AFAICS the ORC unwind
stops on return_to_handler, because the stack and the function itself are not
adjusted for unwind_recover_ret_addr call

If it's any help I pushed the bpf/selftest for that in here:
  https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/log/?h=stacktrace_test

just execute:
  # test_progs -t stacktrace_map/kretprobe_multi

thanks,
jirka

