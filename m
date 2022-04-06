Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D60A04F6AB8
	for <lists+bpf@lfdr.de>; Wed,  6 Apr 2022 21:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233135AbiDFUBr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Apr 2022 16:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233459AbiDFUBW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Apr 2022 16:01:22 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE600207CB2
        for <bpf@vger.kernel.org>; Wed,  6 Apr 2022 10:14:13 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id z6so3825493iot.0
        for <bpf@vger.kernel.org>; Wed, 06 Apr 2022 10:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=D1PIQapcDkBATRQ5KIkpg+isIy6zoi9Foj80zIF7ATU=;
        b=gxuThjz8edK/muePVCo+8qS+OkNAhjlwwAvY0FvNuyusDjQkq0alYfxvzFCGcOm5l3
         UQMUqmjUDzbpU1Ptag0yS/tH1zwHum6gZRYEWnvRuxe5fY/J+eFgNLk1TXRnRUo+Cq+h
         5qdgH40JXpnkc5WNTFJNoWXYnAgW/HB4djR6auht1zWJc/VFa0/T4olqbFGqtQyqI4E1
         x7N3Oed1UJCrNLATncJtAtd21jDalXNzHm0e5801z88po8QJtFj/PlC4WuVYXPf9a47i
         G5iyoeaK5kQU6kHGyvsQGDwbyD5YTUhOD/ULNOmk63S6eAxK2Y2huIlKvwSKrAxLPIu/
         NjRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=D1PIQapcDkBATRQ5KIkpg+isIy6zoi9Foj80zIF7ATU=;
        b=BbRCXeWFz6BCQM6Vju+Se9GOEGq5Ibe2a0bqHlGCBmqlVd41u5g42yPU9BYx5j1me/
         euHYF/eHK58KtbBcy3srMqX3jVw28pJ2J1Rp3W2Np4PVNiyYk5cRiVl8FCN2kW1hOGGu
         CIvpQBMazKGnNVidkCJ2DFee0CYqpZ4L+3Z7uVGhKymSzKX7ECBvDRpnCknH6haxCRfa
         vto8Meu3V0KQ+ckWaLX6iaC+QYe9C3jlfAM08u3uPqwY2fiLVfUXwRYhkHpNarf4loxw
         1QaPH0Gw4tPNGHlPcSWQVlPmoyUDBs+eRMnEFYfv5dAjzOA7n8Yuhw76w+uO07qvXDBU
         wMSg==
X-Gm-Message-State: AOAM530LRX+QeS9weCbgHcRVnmbqvDkhqm4/PpDHPfBAwq4+B9e0GfkL
        +fyeYkbbqrF9Xg3XvxVbYtTAYBseaLwTg8l4ulE=
X-Google-Smtp-Source: ABdhPJzogupI3cjcmQlAZ3Heu41JmvkYgJFRVmJApsztZ6fv/P48/Y5CfWyhxjldTwPiAryhJIaXuZkktT5wDLN93a0=
X-Received: by 2002:a05:6638:3395:b0:323:8a00:7151 with SMTP id
 h21-20020a056638339500b003238a007151mr5058543jav.93.1649265253177; Wed, 06
 Apr 2022 10:14:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220404083816.1560501-1-nborisov@suse.com> <CAEf4BzZrz42Ffe37n+NbiVsvzHX995=1P_tTun-bHzL8kXOpeg@mail.gmail.com>
 <414907a7-1447-6d1d-98a1-0827d07768fd@suse.com>
In-Reply-To: <414907a7-1447-6d1d-98a1-0827d07768fd@suse.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 6 Apr 2022 10:14:02 -0700
Message-ID: <CAEf4BzYASJB4H0WBqVAWoBC2zF-UyZ44Tgi17TDgVZH+D_g=cA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] Add btf__field_exists
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 5, 2022 at 11:41 PM Nikolay Borisov <nborisov@suse.com> wrote:
>
>
>
> On 6.04.22 =D0=B3. 2:37 =D1=87., Andrii Nakryiko wrote:
> > The problem is that what you've implemented is not a user-space
> > equivalent of bpf_core_xxx() macros. CO-RE has extra logic around
> > ___<flavor> suffixes, extra type checks, etc, etc. Helper you are
> > adding does a very straightforward strings check, which isn't hard to
> > implement and it doesn't have to be a set in stone API. So I'm a bit
> > hesitant to add this.
> >
> > But I can share what I did in similar situations where I had to do
> > some CO-RE check both on BPF side and know its result in user-space. I
> > built a separate very simple BPF skeleton and all it did was perform
> > various feature checks (including those that require CO-RE) and then
> > returned the result through global variables. You can then trigger
> > such BPF feature-checking program either through bpf_prog_test_run or
> > through whatever other means (I actually did a simple sys_enter
> > program in my case). See [0] for BPF program side and [1] for
> > user-space activation/consumption of that.
> >
> > The benefit of this approach is that there is no way BPF and
> > user-space sides can get "out of sync" in terms of their feature
> > checking. With skeleton it's also extremely simple to do all this.
> >
> >    [0]https://github.com/anakryiko/retsnoop/blob/master/src/calib_feat.=
bpf.c
> >    [1]https://github.com/anakryiko/retsnoop/blob/master/src/mass_attach=
er.c#L483-L529
> >
>
>
> That's indeed neat, however what is the minimum kernel version required
> to have global variables work ? AFAIU one requirement is to use a
> recent-enough libbpf which supports the skeleton functionality which is
> fine, userspace components can be updated somewhat easily than target
> kernels.

You need Linux 5.5 for global variables mapping into user-space (added
in [0]). But you don't need to use global variables to pass
information back to user-space. You can just do a trivial
BPF_MAP_TYPE_ARRAY for this. It's a bit more verbose to work with from
BPF and user-space side, but effectively is the same for this case.
Then you basically have no extra Linux version constraints just
because of this feature probing. Only the need to have vmlinux BTF.

  [0] fc9702273e2e ("bpf: Add mmap() support for BPF_MAP_TYPE_ARRAY")
