Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9A74198FF
	for <lists+bpf@lfdr.de>; Mon, 27 Sep 2021 18:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235498AbhI0Qja (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Sep 2021 12:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235467AbhI0Qj3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Sep 2021 12:39:29 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B4BCC061575
        for <bpf@vger.kernel.org>; Mon, 27 Sep 2021 09:37:51 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id me5-20020a17090b17c500b0019af76b7bb4so15786692pjb.2
        for <bpf@vger.kernel.org>; Mon, 27 Sep 2021 09:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:84;0;0cto;
        bh=W4UI0OBsxL6jKF6nHhmkAW9pNeP3B5YW2iK36vrVoQo=;
        b=ZWtAnakqw7DDXhvTout3g1E1sROChRkVE4nTLW5tjkEr1hxmor5slxhOrzZalKlT18
         z+VO19Ud327qZ8057khIK9s7e4HO6hsfpms04o/lBLgsAxz3AhCHwEH2Q0m7lFqKJpCB
         5l55KkC06nIEM0D47BQKoGh/l2RlUMPlCKr/m+JOC6vkpfL0bd+TIatphj2pu/PV823K
         OEXLlmyGb+AyDBM7OP5nMq82xipLEmsBm+3hlR4Ul+X6VWMsXh457jTaHD+aZiwdUxjT
         eBWhV0FWGawLQTuF00Pd2JLWguvnZfg+VvUHGoPyR1cRNj5uWUc/Zu3U83JcYGeqYZ8K
         TyYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:84;0;0cto;
        bh=W4UI0OBsxL6jKF6nHhmkAW9pNeP3B5YW2iK36vrVoQo=;
        b=OK5Ap4hPZ7EqI/CRYDEUJchuUL0/PzDb1IgDKlf84SNfAqOzpHmygGLQnc9htlVUXp
         v8wPbR17jpt6mLFrzbe7XCbf3QBb9juUaQbOS7rOcpmw5cxs+aY6oaXSEzljRlaf/Rfd
         bdBnkGKHMLhattTpzF8Hxs3Hjnjiqae/gjaV2Z4Y133iTmEr+1znMoTHdu6ie4NdH3d9
         +D7w8dsQIjpXl9qC5tMEkBGpTjttwf7Ycy2K4/ptANh2F7CIT43Q09dX5LJowZ2SvLNM
         WsLjHkjJEojMy84jaq3halgaGQD4L07GVsaIRPmtkx3bKQ6ztEIeKa1spJsxco+o65hA
         MNig==
X-Gm-Message-State: AOAM532LBOHumnn9sYWLOEbVeIPcUW/l4itCQZIdltvdKOGY1fZkxtWP
        7DIduE2YdVKEMJarJWbDmU56gj+5mh4=
X-Google-Smtp-Source: ABdhPJzjvwI31UfYviKldfiMExYJpkj3v4JSr8JCBdPGbHHBSnby/qJ9U+HhiuQl/+r8iGGXb8NEWg==
X-Received: by 2002:a17:90a:191a:: with SMTP id 26mr975405pjg.79.1632760670800;
        Mon, 27 Sep 2021 09:37:50 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id z17sm17905169pfa.148.2021.09.27.09.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 09:37:50 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 27 Sep 2021 06:37:48 -1000
From:   Tejun Heo <tj@kernel.org>
Cc:     alexei.starovoitov@gmail.com, andrii@kernel.org,
        bpf@vger.kernel.org,
        syzbot+df709157a4ecaf192b03@syzkaller.appspotmail.com,
        syzbot+533f389d4026d86a2a95@syzkaller.appspotmail.com,
        Stanislav Fomichev <sdf@google.com>
Subject: Re: [PATCH bpf v2 1/2] bpf, cgroup: Assign cgroup in cgroup_sk_alloc
 when called from interrupt
Message-ID: <YVHzXPfIWxMWlT6D@slm.duckdns.org>
References: <20210927123921.21535-1-daniel@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927123921.21535-1-daniel@iogearbox.net>
84;0;0cTo: Daniel Borkmann <daniel@iogearbox.net>
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Sep 27, 2021 at 02:39:20PM +0200, Daniel Borkmann wrote:
> If cgroup_sk_alloc() is called from interrupt context, then just assign the
> root cgroup to skcd->cgroup. Prior to commit 8520e224f547 ("bpf, cgroups:
> Fix cgroup v2 fallback on v1/v2 mixed mode") we would just return, and later
> on in sock_cgroup_ptr(), we were NULL-testing the cgroup in fast-path, and
> iff indeed NULL returning the root cgroup (v ?: &cgrp_dfl_root.cgrp). Rather
> than re-adding the NULL-test to the fast-path we can just assign it once from
> cgroup_sk_alloc() given v1/v2 handling has been simplified. The migration from
> NULL test with returning &cgrp_dfl_root.cgrp to assigning &cgrp_dfl_root.cgrp
> directly does /not/ change behavior for callers of sock_cgroup_ptr().
> 
> syzkaller was able to trigger a splat in the legacy netrom code base, where
> the RX handler in nr_rx_frame() calls nr_make_new() which calls sk_alloc()
> and therefore cgroup_sk_alloc() with in_interrupt() condition. Thus the NULL
> skcd->cgroup, where it trips over on cgroup_sk_free() side given it expects
> a non-NULL object. There are a few other candidates aside from netrom which
> have similar pattern where in their accept-like implementation, they just call
> to sk_alloc() and thus cgroup_sk_alloc() instead of sk_clone_lock() with the
> corresponding cgroup_sk_clone() which then inherits the cgroup from the parent
> socket. None of them are related to core protocols where BPF cgroup programs
> are running from. However, in future, they should follow to implement a similar
> inheritance mechanism.
> 
> Additionally, with a !CONFIG_CGROUP_NET_PRIO and !CONFIG_CGROUP_NET_CLASSID
> configuration, the same issue was exposed also prior to 8520e224f547 due to
> commit e876ecc67db8 ("cgroup: memcg: net: do not associate sock with unrelated
> cgroup") which added the early in_interrupt() return back then.
> 
> Fixes: 8520e224f547 ("bpf, cgroups: Fix cgroup v2 fallback on v1/v2 mixed mode")
> Fixes: e876ecc67db8 ("cgroup: memcg: net: do not associate sock with unrelated cgroup")
> Reported-by: syzbot+df709157a4ecaf192b03@syzkaller.appspotmail.com
> Reported-by: syzbot+533f389d4026d86a2a95@syzkaller.appspotmail.com
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Tested-by: syzbot+df709157a4ecaf192b03@syzkaller.appspotmail.com
> Tested-by: syzbot+533f389d4026d86a2a95@syzkaller.appspotmail.com
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Stanislav Fomichev <sdf@google.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
