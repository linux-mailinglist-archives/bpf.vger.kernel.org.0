Return-Path: <bpf+bounces-45624-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 042449D9BE6
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 17:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 641A4162410
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 16:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D378E1D9A7E;
	Tue, 26 Nov 2024 16:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dzLhhl+f"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2541D8E16
	for <bpf@vger.kernel.org>; Tue, 26 Nov 2024 16:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732640070; cv=none; b=BvId9oKzcR2ZKTvl+aKWTotSafSkHKe5kBF65jg4zYFwImPV9gBb64gqmPkfbpMFJCw1vyZzvh2LHQ3OOT2q7qe9lqI1q1ovFTGb2qUvYpCtKH635afSiC6uR2l2PRUzgY80i3+AP9XnmupZcWsxTFfgmshO7bjVO7P6RMUurDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732640070; c=relaxed/simple;
	bh=DIp+sKw/YUR5DOvPGmLkXi+5hSkr25LLRbjXxJw9Sww=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=EmkvSn6n6AlcO8oHayFSzqHqfrHPVNfFHU04y0M9ztKzU9e4CWk+pt8N3BTmIEkg0piWcvJVYJVsc+GW6xg3fMxhKLuh7+W5opRKAd7v/sYIkvsX9m8MvQo5c69Ew2iFp21pKW5cz5VDe471J8uz8JXsXkJV3jN8JaICQvgPWQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dzLhhl+f; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-aa53914509eso173464666b.0
        for <bpf@vger.kernel.org>; Tue, 26 Nov 2024 08:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732640066; x=1733244866; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FVWAMpSCzHg3fGvJUBSfxRuCq7EFAuyV0JzFHGbmGlM=;
        b=dzLhhl+fcO+4h2td232vfisI8ogmKMBrkGUcsB3l/+wydHxr23LGzaeKxsv9SGyGSI
         T7oZjMBUPMDnsCxJjLi6nZECBIcQlL3pkJLYjHduZlNmJRg40qp6cv9OGDlFwYh+0ccU
         Q+Cyq1CaczL3FRLgnohbwX7rwqvxOtZ5SeMOx/Bpz9hn3/itQnfTKYJGhyObQ0H2xD3G
         NCZ4WSSB5N251y38GDYWEUTe8JZBRd+JaDX4wyvk0LCCdysYip/Pr6LTd1grv/c0ShXU
         KcLbplBEqVbxTTrOPgOzYrTuhTplRX+xThj0TkyYDNCXf9QqGJ3rtVjfGg5lwIBMrTcK
         +12w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732640066; x=1733244866;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FVWAMpSCzHg3fGvJUBSfxRuCq7EFAuyV0JzFHGbmGlM=;
        b=lx2j6jT1f9R89Alt2dTwQPVm783exZgbgw9C1MQfWsdpI1ZEO+3sei6jNoKdoeKWO1
         dQtZwwBWi3CDMRglWiWhIslXR79/uY7MZ56kMnOieB9stXQRT2DYVZr5Y4sHCci1rdk3
         AV1VWQv479op5vpBPRfuagUBphhM2cYm+s8uLO41TkwuSFqQ+BWkGPu/f8DHlyixtnRH
         xrOa1F58gHKHUnF0LExgbREwzVzwlEu92cuXHTD/fZnCsVX0McxPYheblLtRRxEEnehK
         6K2pnjVwYnRV4qN97O7KQbwWd+sMcrjOrKlKwp6LsVELUNBJ6GPorMfLOKSxfLA+UmFD
         b56Q==
X-Forwarded-Encrypted: i=1; AJvYcCVY23YlAOZOsnvH7y3E+DxgSf5fkkHXnrImWvFwlXnfCKPVHpf29nmbD5+AHJqmy/Qs254=@vger.kernel.org
X-Gm-Message-State: AOJu0YztLQeDdSEPzxt2zGVAPbw6hur4IcRD7T/Q1PmKlSMd42Kbe3LE
	MpqeyOgLRu24MoaI+r5cVavlKKMSZuqhChp+HOBHI0mH3cY/JiST31VFDPd264oDGLz328ealA=
	=
X-Google-Smtp-Source: AGHT+IGnQ1RVPZpYNr4V2vsGwSrr1TfgOgeHTUES9Lyk5V8C/M8niDnuj/9jgzaUoqUes4SWLxjdrGEpAg==
X-Received: from ejkk23.prod.google.com ([2002:a17:906:32d7:b0:aa5:1a39:9444])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:a17:906:30c9:b0:a9a:1739:91e9
 with SMTP id a640c23a62f3a-aa521fdce0emr1032268766b.24.1732640065788; Tue, 26
 Nov 2024 08:54:25 -0800 (PST)
Date: Tue, 26 Nov 2024 17:52:33 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241126165414.1378338-1-elver@google.com>
Subject: [PATCH bpf-next] bpf: Improve bpf_probe_write_user() warning message
From: Marco Elver <elver@google.com>
To: elver@google.com, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Nikola Grcevski <nikola.grcevski@grafana.com>
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

As such, the warning message can be improved:

1. The ominous "helper that may corrupt user memory!" offers no real
   benefit, and has been found to lead to confusion where the system
   administrator is loading programs with valid use cases.  Remove it.
   No information is lost, and administrators who know their system
   should not load eBPF programs that use bpf_probe_write_user() know
   what they are looking for.

2. If multiple programs with bpf_probe_write_user() are loaded by the
   same task/PID consecutively, only print the message once. If another
   task loads a program with the helper, the message is printed once
   more, and so on. This also makes the need for rate limiting
   redundant.

3. Every printk line needs to be concluded with "\n" to be flushed. With
   the old version the warning message only appeared after any following
   printk. Fix this.

Link: https://lore.kernel.org/lkml/20240404190146.1898103-1-elver@google.com/ [1]
Link: https://lore.kernel.org/r/lkml/CAAn3qOUMD81-vxLLfep0H6rRd74ho2VaekdL4HjKq+Y1t9KdXQ@mail.gmail.com/ [2]
Signed-off-by: Marco Elver <elver@google.com>
---
 kernel/trace/bpf_trace.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 630b763e5240..0ead3d66f8db 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -359,11 +359,16 @@ static const struct bpf_func_proto bpf_probe_write_user_proto = {
 
 static const struct bpf_func_proto *bpf_get_probe_write_proto(void)
 {
+	static pid_t last_warn_pid = -1;
+
 	if (!capable(CAP_SYS_ADMIN))
 		return NULL;
 
-	pr_warn_ratelimited("%s[%d] is installing a program with bpf_probe_write_user helper that may corrupt user memory!",
-			    current->comm, task_pid_nr(current));
+	if (READ_ONCE(last_warn_pid) != task_pid_nr(current)) {
+		pr_warn("%s[%d] is installing a program with bpf_probe_write_user\n",
+			current->comm, task_pid_nr(current));
+		WRITE_ONCE(last_warn_pid, task_pid_nr(current));
+	}
 
 	return &bpf_probe_write_user_proto;
 }
-- 
2.47.0.338.g60cca15819-goog


