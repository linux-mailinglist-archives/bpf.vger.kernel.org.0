Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1EB22D618
	for <lists+bpf@lfdr.de>; Sat, 25 Jul 2020 10:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbgGYIbM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 25 Jul 2020 04:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgGYIbM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 25 Jul 2020 04:31:12 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 261E2C0619D3
        for <bpf@vger.kernel.org>; Sat, 25 Jul 2020 01:31:12 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id v4so2577024ljd.0
        for <bpf@vger.kernel.org>; Sat, 25 Jul 2020 01:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S998CRHW3RlaPZvEFvb883sNLLbQNow5ochuhpqEuwE=;
        b=lhFZhjs2kNnCj7GFHv23REwOHQR0+P1XLzwwn0d61QD+/CdUNVb94XsywrK5DL2JJM
         wyc/akBl5xw6KYZIjfVklCJRT2pxp8hjn+mRPBP5d/mvr0sVoHaynWc1pEkTpO9z7pNl
         z4m6m2Tw4VyUMel/MAVOg555nBY8jbK2L0j87WVXJ47qofCWZpMLP1UxlFMmjqNXxaYz
         jdYPbT9BVy9MS9FA4cWRRHDsuFqZyerrEO9fV2sEPD+GmEYJKUdQNsBjRqtEhSCGjq1J
         a4P5edUOHVcPAXl4gRHJfa6gdy/D2/A2K2kk8kBIgOV6WdjPnQGo88YeW6ywWKxSw5Xx
         S2ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S998CRHW3RlaPZvEFvb883sNLLbQNow5ochuhpqEuwE=;
        b=MDVP5xtpQN6rUlYhl+oqqQuE2ELIRMTe+IE4JZK6RG0VL3vT+viRCDqwdd6qKWg9wh
         nWkza2CUR9L24K5gGvhCLcpk3rZX+mTLagRvWLBfHFuR/3yL6B6ky6k2UinuFBUJSG2+
         QiikxlfY9f+cDydcJZsP3uHMX6j4UF157UCAmRQmaH85j1Lc8VLrP6vhs+yKsC9g8JEu
         WByVg4JyQ6nKCjMM8/MdtFLpu4zR0zdKhb7KLh1RibHyP795A7fylO0hGNJXOVCh8eCo
         nsp1q2t72nG3c/SAn2cpCBePdWB7m4YmhR+IiIHAb7dePjzNeQJ8aXWQDgLtJfgkM8Z5
         TnYw==
X-Gm-Message-State: AOAM5333ByAOh/hSgXsKHKGQE8qstCD+VtMQ31RCmfy7BKAIaX47lQxj
        pvTwX3tL8ZQExrDXMeaQfh4M9PZWCGpoZbBpQwA=
X-Google-Smtp-Source: ABdhPJz+phQoIyFUeRE6EWJ98XfT7iKv0737k+bIFxVWJ4kOVr+wFjA6G5PHK+ZchuCxhxN5a7ZcwqYulpFMs2wfLuw=
X-Received: by 2002:a2e:90da:: with SMTP id o26mr6110827ljg.91.1595665870592;
 Sat, 25 Jul 2020 01:31:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200724211753.902969-1-zhuyifei1999@gmail.com>
In-Reply-To: <20200724211753.902969-1-zhuyifei1999@gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sat, 25 Jul 2020 01:30:59 -0700
Message-ID: <CAADnVQK6RCme1ipL31s+PC4H=di51p20LOxggOxpe38mm=t3nA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf/local_storage: Fix build without CONFIG_CGROUP
To:     YiFei Zhu <zhuyifei1999@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>,
        Martin KaFai Lau <kafai@fb.com>,
        YiFei Zhu <zhuyifei@google.com>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jul 24, 2020 at 2:18 PM YiFei Zhu <zhuyifei1999@gmail.com> wrote:
>
> From: YiFei Zhu <zhuyifei@google.com>
>
> local_storage.o has its compile guard as CONFIG_BPF_SYSCALL, which
> does not imply that CONFIG_CGROUP is on. Including cgroup-internal.h
> when CONFIG_CGROUP is off cause a compilation failure.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: f67cfc233706 ("bpf: Make cgroup storages shared between programs on the same cgroup")
> Signed-off-by: YiFei Zhu <zhuyifei@google.com>

Applied. Thanks
