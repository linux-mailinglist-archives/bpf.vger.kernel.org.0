Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5EC15ED274
	for <lists+bpf@lfdr.de>; Wed, 28 Sep 2022 03:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbiI1BIm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Sep 2022 21:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiI1BIl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Sep 2022 21:08:41 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A52D10976B
        for <bpf@vger.kernel.org>; Tue, 27 Sep 2022 18:08:39 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id lh5so24045332ejb.10
        for <bpf@vger.kernel.org>; Tue, 27 Sep 2022 18:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=lBNNoFrE6jjTHCLkhgBuxtMV4n7ljdBOpeAFbApFLcc=;
        b=WYyTgxJ1+gPwXyf7vq+clMwPRknyz2+fnhA2lsRTyNyS6bhocyvmx/HSPjnJuJ/MS7
         f6CjSMDNJimVdizwatf7ziXTN4VafJFtHsiSRbVI9YTl3PFLzo9br1Z7knJswCPznvpS
         19VfTzv6DEXz77f4KS0cUUGNleE6Yj64bM2waXgmCjWcybtiQ/39JrBNcWdM095lJQ6m
         cdoKisHHFfdQnVLJK9HyJH0V1j5f1T/tYRZoxdsZOfux5n3hoJ29x1VTep6Myj5ST4LF
         JAslVLDsnSg1ZpuZORuepZymUrAxgsJbu2+6l3KM3zbS92DUIWAeCZdvBg5zt2dBO3P+
         WttQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=lBNNoFrE6jjTHCLkhgBuxtMV4n7ljdBOpeAFbApFLcc=;
        b=UVWKUFKrJ9xYG4DFMk0pc5qJIjqqTbuKyZsZBH6k2//jQZGJl2hbG8M2dLviJ5ipUT
         3grOQzO4kSZe0B+6Zz4arB5IhmF/QlP13ye6RWwXaxFOgYo4AcYKB+OsQ+pRzoEJ9R6R
         rEFDgk++AUjHTpwlTNRuPG9f8lekmRlFzPhPcmDLSHnuf3UkdouVEcrRDIoRPtyVRvsP
         O/cj6qywrmfLJblAPMqQntUmg5qmKQHjvQqHJtqHb6Y3hvLfzciLdlpB9dQ0bAGFd5X9
         5sP1KN4VpTuG0a7HMAcXS11D4c7N7RL1dGjexlbyr2YdRO2YfA1RnFxMaa2uxj1i2r3T
         dHAg==
X-Gm-Message-State: ACrzQf3rEKkNAccta17vHmH2LrwPzg/17WFECInB7CdJcLdusffsZmPi
        UqJ1vhetn5rXNkQ/DFs8/H906F8vzRd9GjLrrTI=
X-Google-Smtp-Source: AMsMyM4cB0Lg+ZHUrxkYKXo5mqNjVI8P9+jrZNEJhvVdnFLzKNhoFHIUcd0SkpJO5UTlpGitts9a3Ggm9hHkJ7oHjxo=
X-Received: by 2002:a17:907:7b94:b0:731:1b11:c241 with SMTP id
 ne20-20020a1709077b9400b007311b11c241mr25623131ejc.676.1664327317552; Tue, 27
 Sep 2022 18:08:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220924133620.4147153-1-houtao@huaweicloud.com>
 <20220926012535.badx76iwtftyhq6m@MacBook-Pro-4.local> <ca0c97ae-6fd5-290b-6a00-fe3fe2e87aeb@huaweicloud.com>
 <20220927011949.sxxkyhjiig7wg7kv@macbook-pro-4.dhcp.thefacebook.com>
 <3c7cf1a8-16f2-5876-ff92-add6fd795caf@huaweicloud.com> <CAADnVQL_fMx3P24wzw2LMON-SqYgRKYziUHg6+mYH0i6kpvJcA@mail.gmail.com>
 <2d9c2c06-af12-6ad1-93ef-454049727e78@huaweicloud.com>
In-Reply-To: <2d9c2c06-af12-6ad1-93ef-454049727e78@huaweicloud.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 27 Sep 2022 18:08:26 -0700
Message-ID: <CAADnVQLWQcjYypR2+6UxhKrLOnpRQtB3PZ0=xOtjGpkEhWbH3g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 00/13] Add support for qp-trie with dynptr key
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     bpf <bpf@vger.kernel.org>, Martin KaFai Lau <kafai@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>, Hao Luo <haoluo@google.com>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Hou Tao <houtao1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 27, 2022 at 7:08 AM Hou Tao <houtao@huaweicloud.com> wrote:
>
> A quick benchmark show the performance is bad when using subtree lock for=
 lookup:
>
> Randomly-generated binary data (key size=3D255, max entries=3D16K, key le=
ngth
> range:[1, 255])
> * no lock
> qp-trie lookup   (1  thread)   10.250 =C2=B1 0.009M/s (drops 0.006 =C2=B1=
 0.000M/s mem
> 0.000 MiB)
> qp-trie lookup   (2  thread)   20.466 =C2=B1 0.009M/s (drops 0.010 =C2=B1=
 0.000M/s mem
> 0.000 MiB)
> qp-trie lookup   (4  thread)   41.211 =C2=B1 0.010M/s (drops 0.018 =C2=B1=
 0.000M/s mem
> 0.000 MiB)
> qp-trie lookup   (8  thread)   82.933 =C2=B1 0.409M/s (drops 0.031 =C2=B1=
 0.000M/s mem
> 0.000 MiB)
> qp-trie lookup   (16 thread)  162.615 =C2=B1 0.842M/s (drops 0.070 =C2=B1=
 0.000M/s mem
> 0.000 MiB)
>
> * subtree lock
> qp-trie lookup   (1  thread)    8.990 =C2=B1 0.506M/s (drops 0.006 =C2=B1=
 0.000M/s mem
> 0.000 MiB)
> qp-trie lookup   (2  thread)   15.908 =C2=B1 0.141M/s (drops 0.004 =C2=B1=
 0.000M/s mem
> 0.000 MiB)
> qp-trie lookup   (4  thread)   27.551 =C2=B1 0.025M/s (drops 0.019 =C2=B1=
 0.000M/s mem
> 0.000 MiB)
> qp-trie lookup   (8  thread)   42.040 =C2=B1 0.241M/s (drops 0.018 =C2=B1=
 0.000M/s mem
> 0.000 MiB)
> qp-trie lookup   (16 thread)   50.884 =C2=B1 0.171M/s (drops 0.012 =C2=B1=
 0.000M/s mem
> 0.000 MiB)

That's indeed significant.
But I interpret it differently.
Since single thread perf is close enough while 16 thread
suffers 3x it means the lock mechanism is inefficient.
It means update/delete performance equally doesn't scale.

> Strings in /proc/kallsyms (key size=3D83, max entries=3D170958)
> * no lock
> qp-trie lookup   (1  thread)    4.096 =C2=B1 0.234M/s (drops 0.249 =C2=B1=
 0.014M/s mem
> 0.000 MiB)
>
> * subtree lock
> qp-trie lookup   (1  thread)    4.454 =C2=B1 0.108M/s (drops 0.271 =C2=B1=
 0.007M/s mem
> 0.000 MiB)

Here a single thread with spin_lock is _faster_ than without.
So it's not about the cost of spin_lock, but its contention.
So all the complexity to do lockless lookup
needs to be considered in this context.
Looks like update/delete don't scale anyway.
So lock-less lookup complexity is justified only
for the case with a lot of concurrent lookups and
little update/delete.
When bpf hash map was added the majority of tracing use cases
had # of lookups =3D=3D # of updates =3D=3D # of deletes.
For qp-trie we obviously cannot predict,
but should not pivot strongly into lock-less lookup without data.
The lock-less lookup should have reasonable complexity.
Otherwise let's do spin_lock and work on a different locking scheme
for all operations (lookup/update/delete).

> I can not reproduce the phenomenon that call_rcu consumes 100% of all cpu=
s in my
> local environment, could you share the setup for it ?
>
> The following is the output of perf report (--no-children) for "./map_per=
f_test
> 4 72 10240 100000" on a x86-64 host with 72-cpus:
>
>     26.63%  map_perf_test    [kernel.vmlinux]                            =
 [k]
> alloc_htab_elem
>     21.57%  map_perf_test    [kernel.vmlinux]                            =
 [k]
> htab_map_update_elem

Looks like the perf is lost on atomic_inc/dec.
Try a partial revert of mem_alloc.
In particular to make sure
commit 0fd7c5d43339 ("bpf: Optimize call_rcu in non-preallocated hash map."=
)
is reverted and call_rcu is in place,
but percpu counter optimization is still there.
Also please use 'map_perf_test 4'.
I doubt 1000 vs 10240 will make a difference, but still.
