Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35E3422A6DA
	for <lists+bpf@lfdr.de>; Thu, 23 Jul 2020 07:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbgGWFS4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Jul 2020 01:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbgGWFSz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Jul 2020 01:18:55 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A36AC0619E2
        for <bpf@vger.kernel.org>; Wed, 22 Jul 2020 22:18:55 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id b30so2572807lfj.12
        for <bpf@vger.kernel.org>; Wed, 22 Jul 2020 22:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:cc;
        bh=8YDwrten24ogOJDmaXeZKAXksHr1/n5UE74JWklLE1o=;
        b=OTk0yzh3FE+7NblgnSQ/xKhrT6ZyLvv7r1TuVYXU8DRAHgrRUrJlH15ReR6iz+K/Fv
         F7OqqukglcxSd2S/ppfvNHh7K5v5j6s8X7jhYZ7s1/Z9xteDNoDetQ8Ya+Zam8O0f5Mj
         KyzUyc2wZWpv3ojnOuPU3hFcHglLazR3Ksmx2LTqLch7UsRKLLs7gfg8XxKRAubuMchT
         kmBTGQiW8wDZXMaqdQkI3yGB1c7CPVQbuTgdd30LdGwjnPcXmyJ4a2qtO2tu3zL+7uRH
         sJeN47g+YXzSIPNCSnaKdqrjWgq5/o04oNETJfILPFf1ssCZYr0zaj2FA3f5EKqrEnfj
         F1jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:cc;
        bh=8YDwrten24ogOJDmaXeZKAXksHr1/n5UE74JWklLE1o=;
        b=NUwL+LhjDtJo3YpMWSdCFz+yQYa+e/5HF/NuL0apfZ5hTK91jvQA89djlm9uD0UYEi
         eWqezJTtIrVuoQ0IFrvukzQ2Z3iPlOxY2OkGfr29/CtwkRk2y829qp7Jydadq8Yl/7nC
         bp2/uQ3PaTFEIMqT3bJiZe1v5KynGNB+KpZOhNGkFF6Xs7MvuuhGz2R0KIj/cVrPDCET
         wZBt8lJqRvebVqWPP+hChrLs3Jv28qBrKGdywTxroFn2yNco71pT/M9kVdNmQ2BcLuHQ
         eWQavQXwihdDDADVkuyflgwepZguhmR+ze0oO34UY908lN2p7iow12fPFYYzPc1oug1T
         AJAA==
X-Gm-Message-State: AOAM533ngJref4K19WO5ZsBbtD+Vl22P8zUtrIjkD0DTmHErStvdrRTU
        zGThgpyOg2hClFgK3UyCC/zcPNMu5fYpfQ7tp88=
X-Received: by 2002:a19:cc3:: with SMTP id 186mt838091lfm.134.1595481533644;
 Wed, 22 Jul 2020 22:18:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200722171409.102949-6-kpsingh@chromium.org> <202007230807.y1gfvekv%lkp@intel.com>
In-Reply-To: <202007230807.y1gfvekv%lkp@intel.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 22 Jul 2020 22:18:42 -0700
Message-ID: <CAADnVQK=m18hgfuRZvykQiJPk_c+z=FR6Dpg0aRVvtJn6-Ckrw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 5/7] bpf: Implement bpf_local_storage for inodes
Cc:     KP Singh <kpsingh@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jul 22, 2020 at 5:22 PM kernel test robot <lkp@intel.com> wrote:
>

> All warnings (new ones prefixed by >>):
>
>    kernel/bpf/bpf_inode_storage.c: In function 'unlink_inode_storage':
> >> kernel/bpf/bpf_inode_storage.c:34:32: warning: variable 'smap' set but not used [-Wunused-but-set-variable]

KP,

feel free to resubmit as soon as you fix the build.
People typically ignore the patches when buildbot complains,
since they know that maintainers are not going to apply a set with
known build issue.
