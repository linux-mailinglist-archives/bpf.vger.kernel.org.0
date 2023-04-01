Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9BB36D329E
	for <lists+bpf@lfdr.de>; Sat,  1 Apr 2023 18:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjDAQc7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 1 Apr 2023 12:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjDAQc6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 1 Apr 2023 12:32:58 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23708199E;
        Sat,  1 Apr 2023 09:32:57 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id bm1so7798074qkb.13;
        Sat, 01 Apr 2023 09:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680366776;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Es44EFEzf2PvUY8cLNSkgWEMnfW2iicQU8LTy598v64=;
        b=LjR06tAz6vYsVkEz8p7DJj3aBN15H099rcfDdrJQ7kYK3j029lQ9hFErrwpo5sswzj
         GNxwNXkUVICZXyHU2RK0UgdGs3SkN34BHAA8BgSsPpC19e8MtyZfvJDfT0pL/bsAMttC
         fHrpOR1b9FmkGGK5yH8ih/o1cE3XvxN04bwDIduEfjYJSKMT+OzeFwAg7IfHORqKVYg2
         g82tv5Rfpe3OPQlrF/YZZdlgQ1dSDrmQvfJfj2Ei8VlN65k+0aiPp8AI3teYrMQq/laO
         5hFePLMIcDZqb0AZnVhNymNGuyhBMBA2ojbXXR4TRlDZCVkmuX1trqo2Sl7yxqZhv67K
         7OBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680366776;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Es44EFEzf2PvUY8cLNSkgWEMnfW2iicQU8LTy598v64=;
        b=YujaKqa+ZOmovNps6AG5r10D3Rvd3w4W5H8nuFHVU0o8syODjrcqXOagsdjO/4jfOd
         cpdWgW6xxC5CHsgwKGCXoN77uYV8ZOP/WJMpnB4jr9hcNI4OUY1s7x5NZnXq+wPvvPeP
         FbMJpwG8zzn27DtBuOPmAF22Jrt//5Q4ygTU5HT6bw2unwt7HXLJcYElvlQaB/XCLKIt
         j1qCOqvhjGRDKjue/53XNMNIk5mFPiKFXuMoue7Yml1A/YlklxHTweVsPh94csZT0fHZ
         avZzikTm5e/nAWs3vPEzUnaoVmDZ4O/oB+D9Qw6Axv6Cqylpr+SwpiMmnif+TdfKw3fm
         I7wQ==
X-Gm-Message-State: AO0yUKWXMHTMAVsHX91mSaWAuOc3zKp6Za7yyYhqUHahqshSumXaYc9I
        omE8QCXWfX6cPrPeiJoao87m+0aM233yrah1Y6O4G/c5DoY=
X-Google-Smtp-Source: AK7set+o7sqQk0FKhQaFl3wQ6wPAREfl/ZYcLO6zVd/LeEMxwXmkOn2e7b0hhuIby/f/bPub4vKlUl5OiYOHjQrHXAM=
X-Received: by 2002:a37:6801:0:b0:746:7857:d28b with SMTP id
 d1-20020a376801000000b007467857d28bmr7995445qkc.14.1680366776224; Sat, 01 Apr
 2023 09:32:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230326092208.13613-1-laoar.shao@gmail.com> <CA+khW7ggt9f3U0zTQdneyxDOPGZC8fLc1aE4kS_12p_Qvhdqkw@mail.gmail.com>
In-Reply-To: <CA+khW7ggt9f3U0zTQdneyxDOPGZC8fLc1aE4kS_12p_Qvhdqkw@mail.gmail.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Sun, 2 Apr 2023 00:32:20 +0800
Message-ID: <CALOAHbDccCiOt6mHnLd6fqJzBF-R5b-0HOY76sbQTGV8u8oe1A@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 00/13] bpf: Introduce BPF namespace
To:     Hao Luo <haoluo@google.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        jolsa@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 31, 2023 at 1:52=E2=80=AFPM Hao Luo <haoluo@google.com> wrote:
>
> On Sun, Mar 26, 2023 at 2:22=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com=
> wrote:
> >
> <...>
> >
> > BPF namespace is introduced in this patchset with an attempt to remove
> > the CAP_SYS_ADMIN requirement. The user can create bpf map, prog and
> > link in a specific bpf namespace, then these bpf objects will not be
> > visible to the users in a different bpf namespace. But these bpf
> > objects are visible to its parent bpf namespace, so the sys admin can
> > still iterate and inspect them.
> >
> > BPF namespace is similar to PID namespace, and the bpf objects are
> > similar to tasks, so BPF namespace is very easy to understand. These
> > patchset only implements BPF namespace for bpf map, prog and link. In t=
he
> > future we may extend it to other bpf objects like btf, bpffs and etc.
> > For example, we can allow some of the BTF objects to be used in
> > non-init bpf namespace, then the container user can only trace the
> > processes running in his container, but can't get the information of
> > tasks running in other containers.
> >
>
> Hi Yafang,
>
> Thanks for putting effort toward enabling BPF for container users!
>
> However, I think the cover letter can be improved. It's unclear to me
> what exactly is BPF namespace, what exactly it tries to achieve and
> what is its behavior. If you look at the manpage of pid namespace [1],
> cgroup namespace[2], and namespace[3], they all have a very precise
> definition, their goals and explain the intended behaviors well.
>

Thanks for your suggestion. The covetter should be improved. I will
read the man pages of these namespaces and improve it as you
suggested.

> I felt you intended the BPF namespace to provide isolation of object
> ids. That is, different views of the bpf object ids for different
> processes. This is like the PID namespace. But somehow, you also
> attach CAPs on top of that. That, I think, is not a namespace's job.
>

Agree with you that it should be independent of CAPs.
After the bpf namespace is introduced, actually we don't need the CAPs
when the user iterates IDs or converts IDs to FDs in his bpf namespace
(except in the init bpf namespace), because these are all readonly
operations and the user can only read the bpf objects created by
himself. While the CAPs should be required when the user wants to
write something, e.g. creating a map, loading a prog. They are really
different things. I will change it in the next version.

> Well, I could be wrong, but would appreciate you adding more details
> as follow-up.
>
> Hao
>
> [1] https://man7.org/linux/man-pages/man7/pid_namespaces.7.html
> [2] https://man7.org/linux/man-pages/man7/cgroup_namespaces.7.html
> [3] https://man7.org/linux/man-pages/man7/namespaces.7.html



--=20
Regards
Yafang
