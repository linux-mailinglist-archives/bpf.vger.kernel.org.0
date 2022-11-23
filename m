Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83382636A45
	for <lists+bpf@lfdr.de>; Wed, 23 Nov 2022 20:56:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235950AbiKWTzy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Nov 2022 14:55:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238799AbiKWTz0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Nov 2022 14:55:26 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1159C559C
        for <bpf@vger.kernel.org>; Wed, 23 Nov 2022 11:54:43 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id v81so20150656oie.5
        for <bpf@vger.kernel.org>; Wed, 23 Nov 2022 11:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eQl93HEhRmcc+8LTIdGNUusyREPeMDHDu6DRujzaCG0=;
        b=Q6fDIV1lSS5ZOfmdya8zwmVEVtif6Jifbx8zP/r8kQMv5WJJTZcDn6DMHuJWWgSusX
         trHqMUhcFipzLVFSi2OqytNqNK51xTjtP0KviNU5YbXX88kyHezFkVvAtX1LFhJ3LFhX
         Fn+i7NdeCsQzwxRv+KBkNuE4zYHYqpMTpFVjBmXDlUncsVEbZBFwmER64IGQMbxUsqRV
         VVZVm0QahLST99zs5UrpCr0tlw40vNPAoMUsh0Ovvl9YgOguOyhj+D++KsqDNRJitKI2
         mFefcpb+WbKYsHSwp4DpeYoQBpXGUPpJQ+2sGgeN5jsChMCrTEr4mspGYoo0BuTxscyD
         Z0cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eQl93HEhRmcc+8LTIdGNUusyREPeMDHDu6DRujzaCG0=;
        b=e1qO1K7EeSBjlO8XkOctNaZKUZuuKCC+Wh/M+M+bnzo15j+spdnMQIWkKJy41IHNvj
         IitvY7REkqtDYgk74oUl34O78xUbitQWAfmGPUyywRD3nqkySz7U7rPoXYSQSgxQK4YG
         ssmWx2+XIepnQQi8Ud6SEA0KTGRwsRQd+AyDLgP4DRbIy+Lqkp3TiKKHjP0R8cRWQ8D5
         l5lYHfVw206xJIggraRsV6vMw0dfgNXMUrYqigP6zm81DgKoa2PxOIZ0lAS+XLbs4xxE
         xmSxpBiG/lnpSpc0NyNXQtV1j6+x439wogb2vAlpO7ApJ7aoODyDuXRXaABhAPu+SPvu
         dhIg==
X-Gm-Message-State: ANoB5pkjcZ+Gr9mUzV4QsMAXgmCMdQmTBW8RBd1paYp5gtvfeGPdw7Jx
        ZRJdZXc5WGqIYnKoELPRKNHwSmhdGSed/7Ki9YeDUA==
X-Google-Smtp-Source: AA0mqf6WmcjvmwTSaoqaXCB2AQL4HovLythZstxlN8MyIxgcXujQXzUYC8KpyhbnqbhLloe9gp36GY8M/WU9YH89yzo=
X-Received: by 2002:aca:674c:0:b0:35b:79ca:2990 with SMTP id
 b12-20020aca674c000000b0035b79ca2990mr1938505oiy.125.1669233282262; Wed, 23
 Nov 2022 11:54:42 -0800 (PST)
MIME-Version: 1.0
References: <20221121180340.1983627-1-sdf@google.com> <20221121180340.1983627-2-sdf@google.com>
 <Y34QpET78/KX9JLh@krava> <34cb2b2f-ac3b-65c4-c479-0c4ed3dda096@meta.com>
 <Y35VrXvKBFg2RJ7y@google.com> <63b85917-a2ea-8e35-620c-808560910819@meta.com>
In-Reply-To: <63b85917-a2ea-8e35-620c-808560910819@meta.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Wed, 23 Nov 2022 11:54:31 -0800
Message-ID: <CAKH8qBsdzj=4k5jR3n2mncxRZAwB-qqNWLFTfGWS5EPun-0XjQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Make sure zero-len skbs
 aren't redirectable
To:     Yonghong Song <yhs@meta.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 23, 2022 at 11:07 AM Yonghong Song <yhs@meta.com> wrote:
>
>
>
> On 11/23/22 9:17 AM, sdf@google.com wrote:
> > On 11/23, Yonghong Song wrote:
> >
> >
> >> On 11/23/22 4:23 AM, Jiri Olsa wrote:
> >> > On Mon, Nov 21, 2022 at 10:03:40AM -0800, Stanislav Fomichev wrote:
> >> > > LWT_XMIT to test L3 case, TC to test L2 case.
> >> > >
> >> > > v2:
> >> > > - s/veth_ifindex/ipip_ifindex/ in two places (Martin)
> >> > > - add comment about which condition triggers the rejection (Martin)
> >> > >
> >> > > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> >> >
> >> > hi,
> >> > I'm getting selftest fails and it looks like it's because of this test:
> >> >
> >> >     [root@qemu bpf]# ./test_progs -n 62,98
> >> >     #62      empty_skb:OK
> >> >     execute_one_variant:PASS:skel_open 0 nsec
> >> >     execute_one_variant:PASS:my_pid_map_update 0 nsec
> >> >     libbpf: failed to determine tracepoint 'raw_syscalls/sys_enter'
> >> perf event ID: No such file or directory
> >> >     libbpf: prog 'handle_legacy': failed to create tracepoint
> >> 'raw_syscalls/sys_enter' perf event: No such file or directory
> >> >     libbpf: prog 'handle_legacy': failed to auto-attach: -2
> >> >     execute_one_variant:FAIL:skel_attach unexpected error: -2 (errno 2)
> >> >     test_legacy_printk:FAIL:legacy_case unexpected error: -2 (errno 2)
> >> >     execute_one_variant:PASS:skel_open 0 nsec
> >> >     libbpf: failed to determine tracepoint 'raw_syscalls/sys_enter'
> >> perf event ID: No such file or directory
> >> >     libbpf: prog 'handle_modern': failed to create tracepoint
> >> 'raw_syscalls/sys_enter' perf event: No such file or directory
> >> >     libbpf: prog 'handle_modern': failed to auto-attach: -2
> >> >     execute_one_variant:FAIL:skel_attach unexpected error: -2 (errno 2)
> >> >     #98      legacy_printk:FAIL
> >> >
> >> >     All error logs:
> >> >     execute_one_variant:PASS:skel_open 0 nsec
> >> >     execute_one_variant:PASS:my_pid_map_update 0 nsec
> >> >     libbpf: failed to determine tracepoint 'raw_syscalls/sys_enter'
> >> perf event ID: No such file or directory
> >> >     libbpf: prog 'handle_legacy': failed to create tracepoint
> >> 'raw_syscalls/sys_enter' perf event: No such file or directory
> >> >     libbpf: prog 'handle_legacy': failed to auto-attach: -2
> >> >     execute_one_variant:FAIL:skel_attach unexpected error: -2 (errno 2)
> >> >     test_legacy_printk:FAIL:legacy_case unexpected error: -2 (errno 2)
> >> >     execute_one_variant:PASS:skel_open 0 nsec
> >> >     libbpf: failed to determine tracepoint 'raw_syscalls/sys_enter'
> >> perf event ID: No such file or directory
> >> >     libbpf: prog 'handle_modern': failed to create tracepoint
> >> 'raw_syscalls/sys_enter' perf event: No such file or directory
> >> >     libbpf: prog 'handle_modern': failed to auto-attach: -2
> >> >     execute_one_variant:FAIL:skel_attach unexpected error: -2 (errno 2)
> >> >     #98      legacy_printk:FAIL
> >> >     Summary: 1/0 PASSED, 0 SKIPPED, 1 FAILED
> >> >
> >> > when I run separately it passes:
> >> >
> >> >     [root@qemu bpf]# ./test_progs -n 98
> >> >     #98      legacy_printk:OK
> >> >     Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
> >> >
> >> >
> >> > it seems that the open_netns/close_netns does not work properly,
> >> > and screw up access to tracefs for following tests
> >> >
> >> > if I comment out all the umounts in setns_by_fd, it does not fail
> >
> >> Agreed with the above observations.
> >> With the current bpf-next, I can easily hit the above perf event ID
> >> issue.
> >
> >> But if I backout the following two patches:
> >> 68f8e3d4b916531ea3bb8b83e35138cf78f2fce5 selftests/bpf: Make sure
> >> zero-len
> >> skbs aren't redirectable
> >> 114039b342014680911c35bd6b72624180fd669a bpf: Move skb->len == 0
> >> checks into
> >> __bpf_redirect
> >
> >
> >> and run a few times with './test_progs -j' and I didn't hit any issues.
> >
> > My guess would be that we need to remount debugfs in setns_by_fd?
> >
> > diff --git a/tools/testing/selftests/bpf/network_helpers.c
> > b/tools/testing/selftests/bpf/network_helpers.c
> > index bec15558fd93..1f37adff7632 100644
> > --- a/tools/testing/selftests/bpf/network_helpers.c
> > +++ b/tools/testing/selftests/bpf/network_helpers.c
> > @@ -426,6 +426,10 @@ static int setns_by_fd(int nsfd)
> >       if (!ASSERT_OK(err, "mount /sys/fs/bpf"))
> >           return err;
> >
> > +    err = mount("debugfs", "/sys/kernel/debug", "debugfs", 0, NULL);
> > +    if (!ASSERT_OK(err, "mount /sys/kernel/debug"))
> > +        return err;
> > +
> >       return 0;
> >   }
>
> Ya, this does fix the problem. Could you craft a patch for this?

Sure, give me a second..
