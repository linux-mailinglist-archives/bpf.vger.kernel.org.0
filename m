Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA07B270DB6
	for <lists+bpf@lfdr.de>; Sat, 19 Sep 2020 13:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726159AbgISLtv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 19 Sep 2020 07:49:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60404 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726112AbgISLtv (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 19 Sep 2020 07:49:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600516189;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ip21qnHHS16Z3f+mJxexKMv0xWUpMEM596sNCwhn4Qs=;
        b=H+X+81/z2IRlduQjRrBPNdd0c7wV3bSsVYspWlHuyq1yCPmtxaPOrAU27SJyOPko/KwV+J
        EEFcT52OhJqJUYQw163uEpmOCuONGT63s1vlv9X1HuGWF3+oHAkCZrXkPZv7eA00N2zaKM
        v3l0s8VnkJC1kg+COxusVgSy0O+tLQs=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-21-gXdePnPoPNWop4fOZy7Vew-1; Sat, 19 Sep 2020 07:49:48 -0400
X-MC-Unique: gXdePnPoPNWop4fOZy7Vew-1
Received: by mail-ed1-f69.google.com with SMTP id x23so3272169eds.5
        for <bpf@vger.kernel.org>; Sat, 19 Sep 2020 04:49:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=Ip21qnHHS16Z3f+mJxexKMv0xWUpMEM596sNCwhn4Qs=;
        b=RMoCXVXvbekph6oU7A6uvKBPBRY7Qm3joDCCVqcE5U25t0Tk5bsYoCfNOvS5bzwtAe
         4VbKu6Dzgdqb6rK0AhL3OU5dnJI8OZX6XFKIu1+hV1sLl+hqfscirMPD4pyFuBEcBa2y
         /eSNCJI+/4QMq+dMEC6wGBIDxV4U+VgXAUt1QBJ0wdttEQCnNc2vK2ETm4SS69HICvEE
         6gLlP31iZIENjqXyo4IwnBQPZlOcXMiXcj2BCUEVjTBVhkSYcbVptMYJVq2LzJiapqEj
         7de96xzJXUbEprGND0kfxsOOQ2cT3IaZMk1kF4uNAQLYZ91E78LhxSf81cfQK+Il5EAA
         dhsg==
X-Gm-Message-State: AOAM530EwSXYiNO7b1xqWKvJIfMb6v5W8zCLoG6cOeE7qyyb+0SGnKJk
        jmJta29QSk3LhwCVXCWwarfZ59faiMP/XBVqipDnFcOd80lj355KpXbAZUFcgya4jX5I+aR5rQs
        5qYVuT2j+Z5kj
X-Received: by 2002:a50:fe07:: with SMTP id f7mr45183637edt.173.1600516186649;
        Sat, 19 Sep 2020 04:49:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx3Ujzxo+bmJuNBBCiVLNMDrlem1ZDBFJhLSOaS7snoBtysOe+HYC+esH2+6DLSIdwOx1GMpA==
X-Received: by 2002:a50:fe07:: with SMTP id f7mr45183618edt.173.1600516186248;
        Sat, 19 Sep 2020 04:49:46 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a15sm4233428eje.16.2020.09.19.04.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2020 04:49:44 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 14D30183A91; Sat, 19 Sep 2020 13:49:44 +0200 (CEST)
Subject: [PATCH bpf-next v7 01/10] bpf: disallow attaching modify_return
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
Date:   Sat, 19 Sep 2020 13:49:44 +0200
Message-ID: <160051618391.58048.12525358750568883938.stgit@toke.dk>
In-Reply-To: <160051618267.58048.2336966160671014012.stgit@toke.dk>
References: <160051618267.58048.2336966160671014012.stgit@toke.dk>
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
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 kernel/bpf/verifier.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 4161b6c406bc..cb1b0f9fd770 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11442,7 +11442,7 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 					prog->aux->attach_func_name);
 		} else if (prog->expected_attach_type == BPF_MODIFY_RETURN) {
 			ret = check_attach_modify_return(prog, addr);
-			if (ret)
+			if (ret || tgt_prog)
 				verbose(env, "%s() is not modifiable\n",
 					prog->aux->attach_func_name);
 		}

