Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2ECC6D1707
	for <lists+bpf@lfdr.de>; Fri, 31 Mar 2023 07:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjCaFwp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 31 Mar 2023 01:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjCaFwp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 31 Mar 2023 01:52:45 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4162BDF6
        for <bpf@vger.kernel.org>; Thu, 30 Mar 2023 22:52:43 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id x15so19447108pjk.2
        for <bpf@vger.kernel.org>; Thu, 30 Mar 2023 22:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680241963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HMRYET6mndTBhSrpwGOpNCzFgKo7/YFDVfCXZMGR3/A=;
        b=J+hOkkzTR2g36Uq0InHDWozThaVNOljEQX1jPZ232799bY/DoljfZSuBdvCwBGg27U
         cm3F4cw0MRCt34+2SuZO0RtTZbgJmtEyUNKl0wf4utb05UQ0WZa90rzO/lX97UwvnH6k
         +83dTv9ir7UjjHbxHt6OlrGkeWJ5tRDWbXhv8Ef3kbW0J3BoVTngqjxLtR1pPElZZ/w3
         pWX4pVunWGOKlf48mqiblw9P4Q4cbO4wddUvBPUArmM/d6gtUr7T/Xr4wSsUTB6OAvMI
         XusrJYYYqUyynnMIIeWcRjHsNMPx95fkTGjCmjm2w++3aMCuRaBKnUclbbjf/HygzB/3
         6Yiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680241963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HMRYET6mndTBhSrpwGOpNCzFgKo7/YFDVfCXZMGR3/A=;
        b=Y5OTMi2YO/XHENpi5oDKarv4jx0KVNAcCRKVFtnFSumxeH79z+3+DlLQWjI1+lDhkv
         +LeYdyLsbwKxlzK7WTyvfZIFMLptmuIYtXrZ+2PQ/tV7crYPbqlcMAm7yZ5dWzlbKXCN
         1Ni90rK5Ab6ZIyi6MD8DMkN7kER7hC6jqMVd8+JjH+lDutz3RGp/sWPE/eCqGA8AcEPw
         uMmo4iuZNj7SKgutceh5MkOkFpGnLRYmCurSW2A9zgvOeMymkZPrQaalYNHGrkWHp3qg
         rMej2eYUcNyt1nIBfx40GP+shKPtmtZhC3rLiXgzHwoQUIhspWlIfYNOs0EzGUAxLcv4
         pBkg==
X-Gm-Message-State: AAQBX9fki/yERa/Dl34tAzEOsVCVui8+fWA9JVzwvxAbnVQ/pj52XDF3
        C3E+K56BRBB48xdXFGL+skI+YKKHf4ZU/a/2YqMsLA==
X-Google-Smtp-Source: AKy350YeUt4FesVmsY4OyoKajDnzpFCs1Gx+xttRt5jpmpSvAKbsO2YZQnd4JplpwhmTqH55Gfvmr5te518mzgEmdTw=
X-Received: by 2002:a17:90a:3049:b0:23b:36cc:f347 with SMTP id
 q9-20020a17090a304900b0023b36ccf347mr7622012pjl.9.1680241963183; Thu, 30 Mar
 2023 22:52:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230326092208.13613-1-laoar.shao@gmail.com>
In-Reply-To: <20230326092208.13613-1-laoar.shao@gmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Thu, 30 Mar 2023 22:52:31 -0700
Message-ID: <CA+khW7ggt9f3U0zTQdneyxDOPGZC8fLc1aE4kS_12p_Qvhdqkw@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 00/13] bpf: Introduce BPF namespace
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        jolsa@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Mar 26, 2023 at 2:22=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
<...>
>
> BPF namespace is introduced in this patchset with an attempt to remove
> the CAP_SYS_ADMIN requirement. The user can create bpf map, prog and
> link in a specific bpf namespace, then these bpf objects will not be
> visible to the users in a different bpf namespace. But these bpf
> objects are visible to its parent bpf namespace, so the sys admin can
> still iterate and inspect them.
>
> BPF namespace is similar to PID namespace, and the bpf objects are
> similar to tasks, so BPF namespace is very easy to understand. These
> patchset only implements BPF namespace for bpf map, prog and link. In the
> future we may extend it to other bpf objects like btf, bpffs and etc.
> For example, we can allow some of the BTF objects to be used in
> non-init bpf namespace, then the container user can only trace the
> processes running in his container, but can't get the information of
> tasks running in other containers.
>

Hi Yafang,

Thanks for putting effort toward enabling BPF for container users!

However, I think the cover letter can be improved. It's unclear to me
what exactly is BPF namespace, what exactly it tries to achieve and
what is its behavior. If you look at the manpage of pid namespace [1],
cgroup namespace[2], and namespace[3], they all have a very precise
definition, their goals and explain the intended behaviors well.

I felt you intended the BPF namespace to provide isolation of object
ids. That is, different views of the bpf object ids for different
processes. This is like the PID namespace. But somehow, you also
attach CAPs on top of that. That, I think, is not a namespace's job.

Well, I could be wrong, but would appreciate you adding more details
as follow-up.

Hao

[1] https://man7.org/linux/man-pages/man7/pid_namespaces.7.html
[2] https://man7.org/linux/man-pages/man7/cgroup_namespaces.7.html
[3] https://man7.org/linux/man-pages/man7/namespaces.7.html
