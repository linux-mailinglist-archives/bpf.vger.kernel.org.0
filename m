Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 014ED41009B
	for <lists+bpf@lfdr.de>; Fri, 17 Sep 2021 23:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240383AbhIQVMY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Sep 2021 17:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238205AbhIQVMR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Sep 2021 17:12:17 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA84C061574
        for <bpf@vger.kernel.org>; Fri, 17 Sep 2021 14:10:55 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id t4so21627772qkb.9
        for <bpf@vger.kernel.org>; Fri, 17 Sep 2021 14:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YL2MafRhxOugSSRC4qheDkm60e9kGDfVJr78L6XpsLE=;
        b=K8VFqzImXDWONwltEYeOhiN3KQYMLsoUYddW7/tuKzB7ffjrvCGYx9n2InXGdEDnZ2
         x9u++CE2pOND4wlYFLOFjsCGrPt/0wxZ5owGX6dIu/v1sCvrsDESYl3U9XQLdizSpLSW
         bRxsm/XwHkZTahKHyakLFy3tNLK7cAampqgSsxB2/VzBlMMwA713au/8iRZTt+HHbIQV
         +5hnuvQ2K3e/kCPI1L05JqXek/wWt7bhOIdqoZHFuqld/G0QxMQz1o9U9jztwCzjXkB5
         4LXRkeKFw56kf6f3aD71BkXhiiddGM7BQtJJFQeSZk4sgK8T7QwkbU+1KtJpdxbed2ZW
         tFSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YL2MafRhxOugSSRC4qheDkm60e9kGDfVJr78L6XpsLE=;
        b=MhhI22B8oua3QHc5bygc25Ngf5cnQiM3YB+AhJuf94Xq2bLnsSAxgnFXcJGchXX8Ed
         VQeQhBUa0xaSyYVHFCBFVfCmkt4x550d9U4zonMr4/YfA8ZRC60SgEzY3ZcwFU5hRPWx
         DkC4fdL0uz3iYKeLa7E2wTQ1ScU8NFpU/r1jfE9MSWlCHtEnvp3YPAkiN9P/sZ0RHpdE
         7OaIDmeux6bQ5eu42lCI47ubAkzNZ3m3ZQjjUovN99KKld3463EqY1/E3xODbMtI/f7e
         vhTnvOYDk8D+ss78oZBeGAqyF14jV8bGzS43hJR8BJ+s3jbFnKWbotzNEbmD2EJEwBCW
         hCmw==
X-Gm-Message-State: AOAM533I2rVe2kvG2BWWzBxM28EIJdxSVBygroPMWlbnGa2r6vIbbh4J
        jw4NRnBZuERc9y+qYnsmUbswl6cStZNuTjh7l4q0lOV9
X-Google-Smtp-Source: ABdhPJyD/kAW4iMpHuw8k1F9BM7PiPN92VPDuL/PZ0opJTxxs91skP4aQeAgsv0G8ADXjY/H4Y5s5PjwCE/lqkHZqjQ=
X-Received: by 2002:a25:1bc5:: with SMTP id b188mr15850239ybb.267.1631913054057;
 Fri, 17 Sep 2021 14:10:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210916032641.1413293-1-fallentree@fb.com> <20210916032641.1413293-3-fallentree@fb.com>
In-Reply-To: <20210916032641.1413293-3-fallentree@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 17 Sep 2021 14:10:42 -0700
Message-ID: <CAEf4BzZ2JTH8cCVpNvtZuBF46upz9_yp5eNc8v_uHMaZ4fOy4Q@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 2/3] selftests/bpf: add per worker cgroup suffix
To:     Yucong Sun <fallentree@fb.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Yucong Sun <sunyucong@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 15, 2021 at 8:26 PM Yucong Sun <fallentree@fb.com> wrote:
>
> From: Yucong Sun <sunyucong@gmail.com>
>
> This patch allows each worker to use a unique cgroup base directory, thus
> allowing tests that uses cgroups to run concurrently.
>
> Signed-off-by: Yucong Sun <sunyucong@gmail.com>
> ---

What if we always set the prefix to be a PID of the process?

BTW, Daniel mentioned that this might need some rebasing and conflict
resolution due to his patch in bpf tree, which is now merged into
bpf-next tree.

>  tools/testing/selftests/bpf/cgroup_helpers.c | 5 +++--
>  tools/testing/selftests/bpf/cgroup_helpers.h | 1 +
>  tools/testing/selftests/bpf/test_progs.c     | 5 +++++
>  3 files changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/cgroup_helpers.c b/tools/testing/selftests/bpf/cgroup_helpers.c
> index 033051717ba5..a0429f0d6db2 100644
> --- a/tools/testing/selftests/bpf/cgroup_helpers.c
> +++ b/tools/testing/selftests/bpf/cgroup_helpers.c
> @@ -29,9 +29,10 @@
>  #define WALK_FD_LIMIT                  16
>  #define CGROUP_MOUNT_PATH              "/mnt"
>  #define CGROUP_WORK_DIR                        "/cgroup-test-work-dir"
> +const char *CGROUP_WORK_DIR_SUFFIX = "";
>  #define format_cgroup_path(buf, path) \
> -       snprintf(buf, sizeof(buf), "%s%s%s", CGROUP_MOUNT_PATH, \
> -                CGROUP_WORK_DIR, path)
> +       snprintf(buf, sizeof(buf), "%s%s%s%s", CGROUP_MOUNT_PATH, \
> +       CGROUP_WORK_DIR, CGROUP_WORK_DIR_SUFFIX, path)
>
>  /**
>   * enable_all_controllers() - Enable all available cgroup v2 controllers
> diff --git a/tools/testing/selftests/bpf/cgroup_helpers.h b/tools/testing/selftests/bpf/cgroup_helpers.h
> index 5fe3d88e4f0d..5657aba02161 100644
> --- a/tools/testing/selftests/bpf/cgroup_helpers.h
> +++ b/tools/testing/selftests/bpf/cgroup_helpers.h
> @@ -16,4 +16,5 @@ int setup_cgroup_environment(void);
>  void cleanup_cgroup_environment(void);
>  unsigned long long get_cgroup_id(const char *path);
>
> +extern const char *CGROUP_WORK_DIR_SUFFIX;
>  #endif
> diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
> index 36f130455b2f..77ed9204cc4a 100644
> --- a/tools/testing/selftests/bpf/test_progs.c
> +++ b/tools/testing/selftests/bpf/test_progs.c
> @@ -1157,6 +1157,11 @@ static int server_main(void)
>
>  static int worker_main(int sock)
>  {
> +       static char suffix[16];
> +
> +       sprintf(suffix, "%d", env.worker_id);
> +       CGROUP_WORK_DIR_SUFFIX = suffix;
> +
>         save_netns();
>
>         while (true) {
> --
> 2.30.2
>
