Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5721F674939
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 03:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbjATCNw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Jan 2023 21:13:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjATCNw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Jan 2023 21:13:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF849F051
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 18:13:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B26561DC6
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 02:13:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99BDBC433D2
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 02:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674180829;
        bh=H1hUTPcbmeqP/FtUJWL5ptGLl6HgvbJfRHEoXmI7zcw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hjBT9DpbKJ0gBfHPIaw+jqXzQXNe7SfOnE+GgaW7O1QYYEl9j0vK5TF8zzMz3GkV8
         47m4DHi+XMeOUL5Xa7yv7FehqtOCkkwXlL0cLHOe3IYi4rEDWdT/UDeRDPzDGI7hTU
         ooEz1odE/OY2wRfG/NacCVjXXpOnfplBp/zuFRbXGin83QQQeKAM7NXXTw7EsTKW2s
         3U7gdFIeHlhascpp3/4sT5g62ar7JOBaIV8cVaF+Th/wEJ7ZiIUzACbLdu5MKo35Rx
         +G7foWP5q6Jg5xMIXT2vKvepCgRIe13f2KdUQvPCExxXg6Nj1wdgf4BM1hSgfE0BL6
         LXJTbLL/eJ61Q==
Received: by mail-ej1-f47.google.com with SMTP id ud5so10557490ejc.4
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 18:13:49 -0800 (PST)
X-Gm-Message-State: AFqh2kqU+q86ktbb4y/HH6dEPJj6qxxVkaVpjBpohroPvrOaoMsg9mIX
        36Bo5Fg9vZUQFyy6iT77YP/65YIoJUGOoW7wWCrNrw==
X-Google-Smtp-Source: AMrXdXtVEB7v3g54i4qZcBpHu/hJTwxjeU/PojO38kvLMKBOZ4HFa8eSfDXXvVbFds8ezL9F9nKbP42l53WfA74IXP0=
X-Received: by 2002:a17:906:d971:b0:84d:381c:bdaa with SMTP id
 rp17-20020a170906d97100b0084d381cbdaamr1446074ejb.79.1674180827832; Thu, 19
 Jan 2023 18:13:47 -0800 (PST)
MIME-Version: 1.0
References: <20230119231033.1307221-1-kpsingh@kernel.org> <20230119231033.1307221-4-kpsingh@kernel.org>
 <e13b9f8c-7fb1-64fe-e7f0-10eae9c0d6eb@schaufler-ca.com>
In-Reply-To: <e13b9f8c-7fb1-64fe-e7f0-10eae9c0d6eb@schaufler-ca.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Fri, 20 Jan 2023 03:13:37 +0100
X-Gmail-Original-Message-ID: <CACYkzJ4Kwg37uWi+n2_Wd4pYbjDawPQy_O3N7v27QggnFEsbyw@mail.gmail.com>
Message-ID: <CACYkzJ4Kwg37uWi+n2_Wd4pYbjDawPQy_O3N7v27QggnFEsbyw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/4] security: Replace indirect LSM hook calls
 with static calls
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, jackmanb@google.com,
        renauld@google.com, paul@paul-moore.com, song@kernel.org,
        revest@chromium.org, keescook@chromium.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 20, 2023 at 2:43 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> On 1/19/2023 3:10 PM, KP Singh wrote:
> > LSM hooks are currently invoked from a linked list as indirect calls
> > which are invoked using retpolines as a mitigation for speculative
> > attacks (Branch History / Target injection)  and add extra overhead which
> > is especially bad in kernel hot paths:
> >
> > security_file_ioctl:
> >    0xffffffff814f0320 <+0>:   endbr64
> >    0xffffffff814f0324 <+4>:   push   %rbp
> >    0xffffffff814f0325 <+5>:   push   %r15
> >    0xffffffff814f0327 <+7>:   push   %r14
> >    0xffffffff814f0329 <+9>:   push   %rbx
> >    0xffffffff814f032a <+10>:  mov    %rdx,%rbx
> >    0xffffffff814f032d <+13>:  mov    %esi,%ebp
> >    0xffffffff814f032f <+15>:  mov    %rdi,%r14
> >    0xffffffff814f0332 <+18>:  mov    $0xffffffff834a7030,%r15
> >    0xffffffff814f0339 <+25>:  mov    (%r15),%r15
> >    0xffffffff814f033c <+28>:  test   %r15,%r15
> >    0xffffffff814f033f <+31>:  je     0xffffffff814f0358 <security_file_ioctl+56>
> >    0xffffffff814f0341 <+33>:  mov    0x18(%r15),%r11
> >    0xffffffff814f0345 <+37>:  mov    %r14,%rdi
> >    0xffffffff814f0348 <+40>:  mov    %ebp,%esi
> >    0xffffffff814f034a <+42>:  mov    %rbx,%rdx
> >
> >>>> 0xffffffff814f034d <+45>:  call   0xffffffff81f742e0 <__x86_indirect_thunk_array+352>
> >     Indirect calls that use retpolines leading to overhead, not just due
> >     to extra instruction but also branch misses.
> >
> >    0xffffffff814f0352 <+50>:  test   %eax,%eax
> >    0xffffffff814f0354 <+52>:  je     0xffffffff814f0339 <security_file_ioctl+25>
> >    0xffffffff814f0356 <+54>:  jmp    0xffffffff814f035a <security_file_ioctl+58>
> >    0xffffffff814f0358 <+56>:  xor    %eax,%eax
> >    0xffffffff814f035a <+58>:  pop    %rbx
> >    0xffffffff814f035b <+59>:  pop    %r14
> >    0xffffffff814f035d <+61>:  pop    %r15
> >    0xffffffff814f035f <+63>:  pop    %rbp
> >    0xffffffff814f0360 <+64>:  jmp    0xffffffff81f747c4 <__x86_return_thunk>
> >
> > The indirect calls are not really needed as one knows the addresses of
> > enabled LSM callbacks at boot time and only the order can possibly
> > change at boot time with the lsm= kernel command line parameter.
> >
> > An array of static calls is defined per LSM hook and the static calls
> > are updated at boot time once the order has been determined.
> >
> > A static key guards whether an LSM static call is enabled or not,
> > without this static key, for LSM hooks that return an int, the presence
> > of the hook that returns a default value can create side-effects which
> > has resulted in bugs [1].
> >
> > With the hook now exposed as a static call, one can see that the
> > retpolines are no longer there and the LSM callbacks are invoked
> > directly:
> >
> > security_file_ioctl:
> >    0xffffffff814f0dd0 <+0>:   endbr64
> >    0xffffffff814f0dd4 <+4>:   push   %rbp
> >    0xffffffff814f0dd5 <+5>:   push   %r14
> >    0xffffffff814f0dd7 <+7>:   push   %rbx
> >    0xffffffff814f0dd8 <+8>:   mov    %rdx,%rbx
> >    0xffffffff814f0ddb <+11>:  mov    %esi,%ebp
> >    0xffffffff814f0ddd <+13>:  mov    %rdi,%r14
> >
> >>>> 0xffffffff814f0de0 <+16>:  jmp    0xffffffff814f0df1 <security_file_ioctl+33>
> >     Static key enabled for selinux_file_ioctl
> >
> >>>> 0xffffffff814f0de2 <+18>:  jmp    0xffffffff814f0e08 <security_file_ioctl+56>
> >    Static key enabled for bpf_lsm_file_ioctl. This is something that is
> >    changed to default to false to avoid the existing side effect issues
> >    of BPF LSM [1]
> >
> >    0xffffffff814f0de4 <+20>:  xor    %eax,%eax
> >    0xffffffff814f0de6 <+22>:  xchg   %ax,%ax
> >    0xffffffff814f0de8 <+24>:  pop    %rbx
> >    0xffffffff814f0de9 <+25>:  pop    %r14
> >    0xffffffff814f0deb <+27>:  pop    %rbp
> >    0xffffffff814f0dec <+28>:  jmp    0xffffffff81f767c4 <__x86_return_thunk>
> >    0xffffffff814f0df1 <+33>:  endbr64
> >    0xffffffff814f0df5 <+37>:  mov    %r14,%rdi
> >    0xffffffff814f0df8 <+40>:  mov    %ebp,%esi
> >    0xffffffff814f0dfa <+42>:  mov    %rbx,%rdx
> >
> >>>>   0xffffffff814f0dfd <+45>:        call   0xffffffff814fe820 <selinux_file_ioctl>
> >    Direct call to SELinux.
> >
> >    0xffffffff814f0e02 <+50>:  test   %eax,%eax
> >    0xffffffff814f0e04 <+52>:  jne    0xffffffff814f0de8 <security_file_ioctl+24>
> >    0xffffffff814f0e06 <+54>:  jmp    0xffffffff814f0de2 <security_file_ioctl+18>
> >    0xffffffff814f0e08 <+56>:  endbr64
> >    0xffffffff814f0e0c <+60>:  mov    %r14,%rdi
> >    0xffffffff814f0e0f <+63>:  mov    %ebp,%esi
> >    0xffffffff814f0e11 <+65>:  mov    %rbx,%rdx
> >
> >>>>  0xffffffff814f0e14 <+68>: call   0xffffffff8123b7d0 <bpf_lsm_file_ioctl>
> >    Direct call to bpf_lsm_file_ioctl
> >
> >    0xffffffff814f0e19 <+73>:  test   %eax,%eax
> >    0xffffffff814f0e1b <+75>:  jne    0xffffffff814f0de8 <security_file_ioctl+24>
> >    0xffffffff814f0e1d <+77>:  jmp    0xffffffff814f0de4 <security_file_ioctl+20>
> >    0xffffffff814f0e1f <+79>:  endbr64
> >    0xffffffff814f0e23 <+83>:  mov    %r14,%rdi
> >    0xffffffff814f0e26 <+86>:  mov    %ebp,%esi
> >    0xffffffff814f0e28 <+88>:  mov    %rbx,%rdx
> >    0xffffffff814f0e2b <+91>:  pop    %rbx
> >    0xffffffff814f0e2c <+92>:  pop    %r14
> >    0xffffffff814f0e2e <+94>:  pop    %rbp
> >    0xffffffff814f0e2f <+95>:  ret
> >    0xffffffff814f0e30 <+96>:  int3
> >    0xffffffff814f0e31 <+97>:  int3
> >    0xffffffff814f0e32 <+98>:  int3
> >    0xffffffff814f0e33 <+99>:  int3
> >
> > There are some hooks that don't use the call_int_hook and
> > call_void_hook. These hooks are updated to use a new macro called
> > security_for_each_hook
>
> There has got to be a simpler way to do this. Putting all the code
> for an extraordinary hook into a macro scares the bedickens out of me.
> The call_{int,void}_hook macros work fine for the simple cases, but
> that's because they are the simple cases. What would the hooks that use
> your new macro look like if you coded them directly?

It cannot be coded directly, the number of possible LSMs is determined
at compile time using CONFIG_* macros, so directly coding the slots
would become even more cumbersome and error prone (e.g. missing out
stuff when a new hook is added etc) and updating the static calls at
boot time without a compile time enforced macro would make the logic
even more complex.

Also note, what I dumped here is assembly at runtime, this looks very
different at compile time: Here's the compile time assembly:

ecurity_file_ioctl:
   0xffffffff814f0e90 <+0>: endbr64
   0xffffffff814f0e94 <+4>: push   %rbp
   0xffffffff814f0e95 <+5>: push   %r14
   0xffffffff814f0e97 <+7>: push   %rbx
   0xffffffff814f0e98 <+8>: mov    %rdx,%rbx
   0xffffffff814f0e9b <+11>: mov    %esi,%ebp
   0xffffffff814f0e9d <+13>: mov    %rdi,%r14
   0xffffffff814f0ea0 <+16>: xchg   %ax,%ax
   0xffffffff814f0ea2 <+18>: xchg   %ax,%ax
   0xffffffff814f0ea4 <+20>: xor    %eax,%eax
   0xffffffff814f0ea6 <+22>: xchg   %ax,%ax
   0xffffffff814f0ea8 <+24>: pop    %rbx
   0xffffffff814f0ea9 <+25>: pop    %r14
   0xffffffff814f0eab <+27>: pop    %rbp
   0xffffffff814f0eac <+28>: jmp    0xffffffff81f767c4 <__x86_return_thunk>
   0xffffffff814f0eb1 <+33>: endbr64
   0xffffffff814f0eb5 <+37>: mov    %r14,%rdi
   0xffffffff814f0eb8 <+40>: mov    %ebp,%esi
   0xffffffff814f0eba <+42>: mov    %rbx,%rdx
   0xffffffff814f0ebd <+45>: call   0xffffffff81f784f0
<__SCT__lsm_static_call_file_ioctl_0>
   0xffffffff814f0ec2 <+50>: test   %eax,%eax
   0xffffffff814f0ec4 <+52>: jne    0xffffffff814f0ea8 <security_file_ioctl+24>
   0xffffffff814f0ec6 <+54>: jmp    0xffffffff814f0ea2 <security_file_ioctl+18>
   0xffffffff814f0ec8 <+56>: endbr64
   0xffffffff814f0ecc <+60>: mov    %r14,%rdi
   0xffffffff814f0ecf <+63>: mov    %ebp,%esi
   0xffffffff814f0ed1 <+65>: mov    %rbx,%rdx
   0xffffffff814f0ed4 <+68>: call   0xffffffff81f784f8
<__SCT__lsm_static_call_file_ioctl_1>
   0xffffffff814f0ed9 <+73>: test   %eax,%eax
   0xffffffff814f0edb <+75>: jne    0xffffffff814f0ea8 <security_file_ioctl+24>
   0xffffffff814f0edd <+77>: jmp    0xffffffff814f0ea4 <security_file_ioctl+20>
   0xffffffff814f0edf <+79>: endbr64
   0xffffffff814f0ee3 <+83>: mov    %r14,%rdi
   0xffffffff814f0ee6 <+86>: mov    %ebp,%esi
   0xffffffff814f0ee8 <+88>: mov    %rbx,%rdx
   0xffffffff814f0eeb <+91>: pop    %rbx
   0xffffffff814f0eec <+92>: pop    %r14
   0xffffffff814f0eee <+94>: pop    %rbp
   0xffffffff814f0eef <+95>: jmp    0xffffffff81f78500
<__SCT__lsm_static_call_file_ioctl_2>


>
> >  where the lsm_callback is directly invoked as an
> > indirect call. Currently, there are no performance sensitive hooks that
> > use the security_for_each_hook macro. However, if, some performance
> > sensitive hooks are discovered, these can be updated to use
> > static calls with loop unrolling as well using a custom macro.
>
> Or how about no macro at all? I would really like to see what the code
> would look like without this level of macro processing.
>

One can inline the static slot generation logic, but the code would
become quite complex and tricky to write without macros. Open for
suggestions.
