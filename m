Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6EBF5A532A
	for <lists+bpf@lfdr.de>; Mon, 29 Aug 2022 19:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiH2RbZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Aug 2022 13:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiH2RbY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Aug 2022 13:31:24 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD5267B7AB
        for <bpf@vger.kernel.org>; Mon, 29 Aug 2022 10:31:23 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id n17so11097068wrm.4
        for <bpf@vger.kernel.org>; Mon, 29 Aug 2022 10:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=6dZvHbb8IWueLS4eFstq1vaFfQHUYChceiQvahnGWHU=;
        b=cqoVFEaZpeJD8EjNsoLJ56vZYmVurORt4hKHbg5R3LIFg2MPYs9W9NyBzZJkO2Oxaf
         wbD4TpbwyAA2cTNYtWJJ+0bHscp0QXqLghWLQzaihARVQXFbGamD/y+wT7uiaBbIMUNk
         IVcoC++0s7an6V+WAZu0yKjuQWtiHUBYPm2UNNnR/UE4ORHA6YhRMrm4knhOzp0OGr47
         bvzrpTWLtfX0Bn0PTH4HHg8r3omAX828OO3edjzOICn6IY4eGH9PQhxQwPDxHAtllPBH
         ncEYOgWP7jsLmEWXULP94ZnYf+pkVq8pn2BhQh5lYmSlUPV5koIisqeachjraxEBVBaf
         OmNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=6dZvHbb8IWueLS4eFstq1vaFfQHUYChceiQvahnGWHU=;
        b=YBAnNGHHYWmctl6jM8tzaiohKoTMoJs8BFmYdfJy+Heqr3c0PENyZOBbJ2PRcz4o+O
         6LlgeFAJCjH7Gng4ZBTwrClJIRi19IVDMC1nbSiRAawOr6iUPORfqhNcFY7gdJASBkYz
         LHd7+Jg9WfRdJsuaBJOpO1g8+vd/h37Ax8a0dVaL0X+wKEdUE7OvgOm/+AoPpuqF0Idm
         cX6w2AB10QqfHmHQzD68NUufN5KnNNzu1GCTp9N6Q4J3ArYdm7UN1KSnMKpxYoRF3upV
         tSPpNMsum9HGzRDLL046lRbwpRmbkyDusgywfHIi3IXkL8QPUnY+maaPt0xqNA23z3Ae
         thWQ==
X-Gm-Message-State: ACgBeo0I+nIZEh62I177qmotS2NAFt52bM3dYNVKFy3lTqmoLoe/tQJf
        JLjBzWpfMa5Pjn7zRrzA7INtGRLHeUQPn6n0/VCwqA==
X-Google-Smtp-Source: AA6agR5PMAaW7CWgNC3xjNhmK4ZVCby/7FxoZWwKdWYyXUS94EaAlNQe/fRHGAz2ieW8uX0a+ZjjO/2nncCysdRfGEA=
X-Received: by 2002:a5d:6609:0:b0:226:ced9:be58 with SMTP id
 n9-20020a5d6609000000b00226ced9be58mr6644307wru.80.1661794282111; Mon, 29 Aug
 2022 10:31:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220826165238.30915-1-mkoutny@suse.com> <20220826165238.30915-5-mkoutny@suse.com>
 <CAJD7tkZZ6j6mPfwwFDy_ModYux5447HFP=oPwa6MFA_NYAZ9-g@mail.gmail.com> <20220829125957.GB3579@blackbody.suse.cz>
In-Reply-To: <20220829125957.GB3579@blackbody.suse.cz>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 29 Aug 2022 10:30:45 -0700
Message-ID: <CAJD7tkZySzWgJgp4xbkpSstc_RMN_tJqt83-FFrxv6jASeg8CA@mail.gmail.com>
Subject: Re: [PATCH 4/4] cgroup/bpf: Honor cgroup NS in cgroup_iter for ancestors
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>, Aditya Kali <adityakali@google.com>,
        Serge Hallyn <serge.hallyn@canonical.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Yonghong Song <yhs@fb.com>,
        Muneendra Kumar <muneendra.kumar@broadcom.com>,
        Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 29, 2022 at 6:00 AM Michal Koutn=C3=BD <mkoutny@suse.com> wrote=
:
>
> On Fri, Aug 26, 2022 at 10:41:37AM -0700, Yosry Ahmed <yosryahmed@google.=
com> wrote:
> > I understand that currently cgroup_iter is the only user of this, but
> > for future use cases, is it safe to assume that cgrp will always be
> > inside ns? Would it be safer to do something like:
>
> I preferred the simpler root_cgrp comparison to avoid pointer
> arithmetics in cgroup_is_descendant. But I also made the assumption of
> cgrp in ns.
>
> Thanks, I'll likely adjust cgroup_path_ns to make it more robust for
> an external cgrp.
>

Great, thanks!

>
> I'd like to clarify, if a process A in a broad cgroup ns sets up a BPF
> cgroup iterator, exposes it via bpffs and than a process B in a narrowed
> cgroup ns (which excludes the origin cgroup) wants to traverse the
> iterator, should it fail straight ahead (regardless of iter order)?
> The alternative would be to allow self-dereference but prohibit any
> iterator moves (regardless of order).
>

imo it should fail straight ahead, but maybe others (Tejun? Hao?) have
other opinions here.

>
> Thanks,
> Michal
