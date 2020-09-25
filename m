Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9ED27935D
	for <lists+bpf@lfdr.de>; Fri, 25 Sep 2020 23:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729260AbgIYVZI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Sep 2020 17:25:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54674 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729522AbgIYVZH (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 25 Sep 2020 17:25:07 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601069106;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=it5ErVQ9w78IEwPzrMsZouVB/NLpxKqq/aiTiBgHUus=;
        b=Zy6Uq+Sz4Id5GsjytSeCVKwnx4dlVvOsr7mkdu4lYqvOR/cuQOfjFtVIefXlD/nLlUsBRr
        KnK0PhVv5vIDDKfKhAv5b+o2Rk4gG8T3ES0+oTfqWUZmWDuyN5iUKf/VzwvlZZcnesew1G
        WHnbzuE4kNcLGKmP8YTv1dgrSJ3/mWg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394--jDVvJvrMv-2b36PuMNDgw-1; Fri, 25 Sep 2020 17:25:04 -0400
X-MC-Unique: -jDVvJvrMv-2b36PuMNDgw-1
Received: by mail-wr1-f69.google.com with SMTP id a12so1580271wrg.13
        for <bpf@vger.kernel.org>; Fri, 25 Sep 2020 14:25:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=it5ErVQ9w78IEwPzrMsZouVB/NLpxKqq/aiTiBgHUus=;
        b=lhPb44R6ReENwiyCFezvVYDOrrZR0N6K7fse4TW1qMz7dcV9YoGxzLU5a7BYHakBFL
         RFt2RB7e3/zJY7Y6V9mRqHxrsrtX5eLtGc8tFpndDCwfQpBKHPwBVLgJ10ZTkqv4I3IM
         5hj00crziPyirCNNOXwwbA4lXe+D16b1pioIdHzjD2WpRP/EX3l6/EYRnUSnXBzCJn7I
         JrvZtksTa5n+Zkrtpm7X4mhk3f+m+XM3wCb9CRHuADGx3MmatLOzD8sC4tWJbcLwpJwj
         5OTYPVuXa0OEBwyOJ4j33ww5yV2ZFNg8TNKx0cgZ9bx5sUXzxsYP8RNa8kZzWWNrM5EC
         g2Yg==
X-Gm-Message-State: AOAM531Utm0G/yE3gW/OiZ2YsJ5R3aA+BlC9U78IEd82Xw/XbMz6Nz98
        6+RY82GNOHzAz1Zxb+VFuPOTrnyZUe/sh82N85wYgSDrVogWSVSkoH2cO39DRAQ6LlSbRfbs8HK
        MpVibCmNDPt59
X-Received: by 2002:adf:a3d8:: with SMTP id m24mr6395132wrb.418.1601069103150;
        Fri, 25 Sep 2020 14:25:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzPId+IZEsxZEWRovMUxoRBAzvDuFPYsRnMS78OlD1ckoyGcyrMSWRp0AJk3IQ3p0TdIrZ7Bg==
X-Received: by 2002:adf:a3d8:: with SMTP id m24mr6395109wrb.418.1601069102684;
        Fri, 25 Sep 2020 14:25:02 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id m18sm289873wmg.32.2020.09.25.14.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 14:25:02 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id B28A4183C5C; Fri, 25 Sep 2020 23:25:00 +0200 (CEST)
Subject: [PATCH bpf-next v9 01/11] bpf: disallow attaching modify_return
 tracing functions to other BPF programs
From:   =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <ast@kernel.org>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Eelco Chaudron <echaudro@redhat.com>,
        KP Singh <kpsingh@chromium.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Date:   Fri, 25 Sep 2020 23:25:00 +0200
Message-ID: <160106910067.27725.5163435783598211744.stgit@toke.dk>
In-Reply-To: <160106909952.27725.8383447127582216829.stgit@toke.dk>
References: <160106909952.27725.8383447127582216829.stgit@toke.dk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Toke Høiland-Jørgensen <toke@redhat.com>

From the checks and commit messages for modify_return, it seems it was
never the intention that it should be possible to attach a tracing program
with expected_attach_type == BPF_MODIFY_RETURN to another BPF program.
However, check_attach_modify_return() will only look at the function name,
so if the target function starts with "security_", the attach will be
allowed even for bpf2bpf attachment.

Fix this oversight by also blocking the modification if a target program is
supplied.

Fixes: 18644cec714a ("bpf: Fix use-after-free in fmod_ret check")
Fixes: 6ba43b761c41 ("bpf: Attachment verification for BPF_MODIFY_RETURN")
Acked-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 kernel/bpf/verifier.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 42dee5dcbc74..66b6714b3fd7 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11470,6 +11470,11 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 				verbose(env, "%s is not sleepable\n",
 					prog->aux->attach_func_name);
 		} else if (prog->expected_attach_type == BPF_MODIFY_RETURN) {
+			if (tgt_prog) {
+				verbose(env, "can't modify return codes of BPF programs\n");
+				ret = -EINVAL;
+				goto out;
+			}
 			ret = check_attach_modify_return(prog, addr);
 			if (ret)
 				verbose(env, "%s() is not modifiable\n",

