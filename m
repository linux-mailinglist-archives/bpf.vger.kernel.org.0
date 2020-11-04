Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3582A62D7
	for <lists+bpf@lfdr.de>; Wed,  4 Nov 2020 12:03:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbgKDLDy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Nov 2020 06:03:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbgKDLDy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Nov 2020 06:03:54 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC25C0613D3
        for <bpf@vger.kernel.org>; Wed,  4 Nov 2020 03:03:53 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id d24so22459912ljg.10
        for <bpf@vger.kernel.org>; Wed, 04 Nov 2020 03:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xEKEC0YlSgaEOnt38rltuqrha4RV8MJOHNAt5plznLs=;
        b=nIjqSgqzowbObFnifreTIMOTeoAVRfxRwndC6H73URjJbyOcvPONZ9sx7rJo1OtWEE
         YF9hjqvtZohF4FV3Ru1FdQv2v6Js21CnpaR/848bMrva15z64H85s3kUgfVV40eU6rlh
         w6fs/q8ZB4JPod/IG+iJljGM/vGFfFiMFklt4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xEKEC0YlSgaEOnt38rltuqrha4RV8MJOHNAt5plznLs=;
        b=eCFb7A2FI+lpvIkKR1PrcMitNNXSHl5KLGYMeIqKlXQFoRYgz2MoB8m/ij57sX3+LO
         v78q4agUxunyiU4JmB1gJDSMVeE3KtS5k86lk25X7lpjb1FeE42b23VT7936TOb0vTht
         zk6xkCmnShIRedLyNC+a+70OO1lyEuS1Tr+tkVdK1ZkXPFY0lxB7GUbQ9jm3gZmnsisR
         ZJDdV2otaJU0ws2SixdMGbk3xNIA/JUTUOnsvE+zAz62FVM5qnp35k6aLLbnKgI9sr5L
         SJwfpCEG0n1V2uK+qmUPU80FvvOPtoIM4/7I8IbodyfN2V4yDynNRBEGsVi2me0c726v
         kLUw==
X-Gm-Message-State: AOAM532mpz+mjvKdQrYf1UNXrvPImb+Bf6MTHir50lVKvvCcQbk3ZQKK
        1Gk1qa0AR9hI4KILBOb/GTpW36EneOEQEfGBDNe8DQ==
X-Google-Smtp-Source: ABdhPJzAP8gLIR4hlv3az1NgvZy0rqyvNG98vN6iT2JAuPWdOByImDV6bQO6Ccz6nKkMwkT1gWg9qwnchzHSjfQ4e9U=
X-Received: by 2002:a05:651c:1345:: with SMTP id j5mr11016574ljb.430.1604487832066;
 Wed, 04 Nov 2020 03:03:52 -0800 (PST)
MIME-Version: 1.0
References: <20201103153132.2717326-1-kpsingh@chromium.org>
 <20201103153132.2717326-8-kpsingh@chromium.org> <20201103184714.iukuqfw2byls3s4k@ast-mbp.dhcp.thefacebook.com>
 <CACYkzJ6A5GrQhBhv7GC8aeeLpoc7bnN=6Rn2UoM1P90odLZZ=g@mail.gmail.com>
 <CACYkzJ6D=vwaEhgaB2vevOo0186m=yfxeKBQ8eWWck8xjtczNA@mail.gmail.com>
 <CAADnVQ+DBHXkf8SFwnTKmSKi7mdAx56dWbpp5++Cc02CQjz+Ng@mail.gmail.com>
 <CACYkzJ6uc4fbRMNmj3kFeSu=V2JqWruJLFjMnPet_HXW-EdRng@mail.gmail.com>
 <CAADnVQLKhmA49RGH=SSCg3qHxZOzU5bHp+sw+Yw7M_7KB0zD4g@mail.gmail.com> <5fa24f72dd48e_9fa0e20871@john-XPS-13-9370.notmuch>
In-Reply-To: <5fa24f72dd48e_9fa0e20871@john-XPS-13-9370.notmuch>
From:   KP Singh <kpsingh@chromium.org>
Date:   Wed, 4 Nov 2020 12:03:41 +0100
Message-ID: <CACYkzJ7v4TNopZ0VhFezax-i3TF59Ok2mfgb_W+mTH52fd_gRw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 7/8] bpf: Add tests for task_local_storage
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

[...]

> > Ahh. Yes. That should do it. Right now I don't see concerns with safety
> > of the bpf_spin_lock in bpf_lsm progs.
>
> What about sleepable lsm hooks? Normally we wouldn't expect to sleep with
> a spinlock held. Should we have a check to ensure programs bpf_spin_lock
> are not also sleepable?

Thanks. Yes, I added that to my patch:

diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index 61f8cc52fd5b..93383df2140b 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -63,6 +63,10 @@ bpf_lsm_func_proto(enum bpf_func_id func_id, const
struct bpf_prog *prog)
                return &bpf_task_storage_get_proto;
        case BPF_FUNC_task_storage_delete:
                return &bpf_task_storage_delete_proto;
+       case BPF_FUNC_spin_lock:
+               return &bpf_spin_lock_proto;
+       case BPF_FUNC_spin_unlock:
+               return &bpf_spin_unlock_proto;
        default:
                return tracing_prog_func_proto(func_id, prog);
        }
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 314018e8fc12..8892f7ba2041 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9739,6 +9739,23 @@ static int check_map_prog_compatibility(struct
bpf_verifier_env *env,
                return -EINVAL;
        }

+       if (map_value_has_spin_lock(map)) {
+               if (prog_type == BPF_PROG_TYPE_SOCKET_FILTER) {
+                       verbose(env, "socket filter progs cannot use
bpf_spin_lock yet\n");
+                       return -EINVAL;
+               }
+
+               if (is_tracing_prog_type(prog_type)) {
+                       verbose(env, "tracing progs cannot use
bpf_spin_lock yet\n");
+                       return -EINVAL;
+               }
+
+               if (prog->aux->sleepable) {
+                       verbose(env, "sleepable progs cannot use
bpf_spin_lock\n");
+                       return -EINVAL;
+               }
+       }
+
