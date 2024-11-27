Return-Path: <bpf+bounces-45701-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E750B9DA69E
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 12:12:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F0BFB27038
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 11:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B311EE01A;
	Wed, 27 Nov 2024 11:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e/FVq7pw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C501EE00D
	for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 11:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732705829; cv=none; b=krbVkvjfGj7mwC4Ga0lDT9vs317+zCNzIFwEhQUfIrPcRrYxVpqbSy2DHYm1gGbDK62+0pLv65KEgVXd3QpJMZP0WmvlE6CLHhBi/xd9LfYIHueLTHrgJKXEfj3AMU4/d+ES3QNESCoSrADYPOLWKTlxLFsQcWYI6E4JnnyHKfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732705829; c=relaxed/simple;
	bh=IJhveSX3KT5NJJHEyEvzzpFxslyvOV2q8+XBWhlpYOw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=u3yoBCVhq0yVz+VZtNBrvl1h30LIIuOH3IqCffh8QGfKErhnddYGrTONjebu1i1AHuMsQ7xin5hi4nRXoH4it82pw8JxIwngRxyJlJVyeSVYfg1M/sq5Ac+tuo2K/j+MkdsZfUem3D6fEFNLMlRGTBChlAPlxqlv2KP8UGFfExU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e/FVq7pw; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-aa55354400eso71697866b.1
        for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 03:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732705826; x=1733310626; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=szUe4MlEoUScFGYRDGXKxGMjDAz2rhZoxsy6RiA0irg=;
        b=e/FVq7pwIriSau7yNAn21JGILV5et6I7tB1q93cewETI6/nX6xs7MDJxTz/+4G06CN
         J45HpG5pW1BUsjPyO0Q/Se2PT9f/DZ1k002Kn2wkS+gdgcp/mT8/suyYhLM/eDkrQlU9
         PCd61B+AIJc/CefY1lClYHFqRcyuBvaGjLHyJ/4PyAWTEMCbltQ/S/wbd4RijC0Vf7xG
         CN1BwvUa01UgLe0CEe6it+GgZMhB7WhxeiaApvg1UrZhZP+guO8xIsy2ouskb9lA13w6
         6L8qz+XmapFyKyfSsh4MDrtnh/9NBsnXiO5SXD9NK9+ZjZzXFKu8ELFWLW1vrQXPvXZ+
         tEMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732705826; x=1733310626;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=szUe4MlEoUScFGYRDGXKxGMjDAz2rhZoxsy6RiA0irg=;
        b=LrkkevZYT4s1s5Vi7TpWI94VWjlj7/IaZGM5sTJ/U+0ITsTgRiFzGJlKjSJAPSL9pl
         te+8etxmvR6qlU0BUF7+LKpojH4+2dzPWDvAdjZI9vljRMhirBQhNgtRD97xSLwXHBDk
         G2jmynqfcPpxKbnCLWh4yxrZ7qFb078bXXZFwS+IpT4CItYbONdu4o+fFnSN5ZqmqJ1C
         fh02j4EHTCpG/hJpOL6h0odlBIZxs3ILYz7ZmU7eeAMZrkJR8N08HiuYRr3tThsRtHZj
         l5y6bw8RRsBOI14jhkK1flnuMSvRYfQIVW7rTulv6uTU6H/SqLRT7hnx0HmM9obL+Fuz
         o6CA==
X-Forwarded-Encrypted: i=1; AJvYcCVasdHlkx/9M/DE4j08EgMfUFC8cTWS79ucd9QN1leEr9KgeR3g1X7cWHLJMJN68vOv1kU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGPolUwpVC/VDQ38M1Mpoi0znfmIyjcCNUiWvWKTSMMw8Mys+m
	dSNDAkp/1oaZPIP3bRA4h0XW7gfwCwgIb+ymwzKZPK284p0usSSdSQi2Qw5Wi/fqbd0FsfJ4mg=
	=
X-Google-Smtp-Source: AGHT+IHzvGLk0LstKl05NLYC6GFUNC2AmNlbWn6ck5NvXCTaNVLUbddTm1eBObZRbskWLgCarifJzxdcdA==
X-Received: from ejbz19.prod.google.com ([2002:a17:906:753:b0:aa5:47f8:b930])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:a17:906:7312:b0:a99:5587:2a1f
 with SMTP id a640c23a62f3a-aa5648a69c1mr719583666b.15.1732705826679; Wed, 27
 Nov 2024 03:10:26 -0800 (PST)
Date: Wed, 27 Nov 2024 12:10:00 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241127111020.1738105-1-elver@google.com>
Subject: [PATCH bpf-next v2 1/2] bpf: Remove bpf_probe_write_user() warning message
From: Marco Elver <elver@google.com>
To: elver@google.com, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Nikola Grcevski <nikola.grcevski@grafana.com>, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The warning message for bpf_probe_write_user() was introduced in
96ae52279594 ("bpf: Add bpf_probe_write_user BPF helper to be called in
tracers"), with the following in the commit message:

    Given this feature is meant for experiments, and it has a risk of
    crashing the system, and running programs, we print a warning on
    when a proglet that attempts to use this helper is installed,
    along with the pid and process name.

After 8 years since 96ae52279594, bpf_probe_write_user() has found
successful applications beyond experiments [1, 2], with no other good
alternatives. Despite its intended purpose for "experiments", that
doesn't stop Hyrum's law, and there are likely many more users depending
on this helper: "[..] it does not matter what you promise [..] all
observable behaviors of your system will be depended on by somebody."

The ominous "helper that may corrupt user memory!" has offered no real
benefit, and has been found to lead to confusion where the system
administrator is loading programs with valid use cases.

As such, remove the warning message.

Link: https://lore.kernel.org/lkml/20240404190146.1898103-1-elver@google.com/ [1]
Link: https://lore.kernel.org/r/lkml/CAAn3qOUMD81-vxLLfep0H6rRd74ho2VaekdL4HjKq+Y1t9KdXQ@mail.gmail.com/ [2]
Link: https://lore.kernel.org/all/CAEf4Bzb4D_=zuJrg3PawMOW3KqF8JvJm9SwF81_XHR2+u5hkUg@mail.gmail.com/
Signed-off-by: Marco Elver <elver@google.com>
---
v2:
* Just delete the message entirely (suggested by Andrii Nakryiko)
---
 kernel/trace/bpf_trace.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 630b763e5240..0ab56af2e298 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -362,9 +362,6 @@ static const struct bpf_func_proto *bpf_get_probe_write_proto(void)
 	if (!capable(CAP_SYS_ADMIN))
 		return NULL;
 
-	pr_warn_ratelimited("%s[%d] is installing a program with bpf_probe_write_user helper that may corrupt user memory!",
-			    current->comm, task_pid_nr(current));
-
 	return &bpf_probe_write_user_proto;
 }
 
-- 
2.47.0.338.g60cca15819-goog


