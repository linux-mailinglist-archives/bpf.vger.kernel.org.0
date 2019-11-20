Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E96B910441A
	for <lists+bpf@lfdr.de>; Wed, 20 Nov 2019 20:17:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbfKTTRE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Nov 2019 14:17:04 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41422 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbfKTTRD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Nov 2019 14:17:03 -0500
Received: by mail-qk1-f194.google.com with SMTP id m125so811180qkd.8;
        Wed, 20 Nov 2019 11:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aSUayV6E31Mgt282Ppz+wrLeqJYE34fJJfbBSA2SdsI=;
        b=ct815WvmwBfae6wt/g0tJMvuk13tjUep1c9KVb5Few7f+79eakaJsDUTNOb7oXoY91
         awJhRDM3TLsn5AGr16j+Uz9x6aYsAVrsa+w9uEjfOyvV4tegFdBHsN3+x2AFxWJgW+Wh
         im7nvWF+EqnpmiyyNAkljIVWXg0/Wi+DikwCio1YzDWaeZ7McZ/gwGQWcCpea3ixuM2R
         G8vyCP1KE0C29btC42YbZCA14+EyO+HHizRlkW1dhN4YL55eFH9+kDDysf8CCGiAe0FL
         t8LJs4mk7zFTRQKrca6xEl6U+bcpfcIVbQvbbkAXK5oRo1bndpIYOed2KtCOmNSxDrCJ
         D+2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aSUayV6E31Mgt282Ppz+wrLeqJYE34fJJfbBSA2SdsI=;
        b=oDTMBdO71/6HOdMn+0NyObPq/9rHXiw4eKjtBhfu1uVhVEJ/DcNOVWpfamPr4bXqOM
         RWCyStMf24Jm8O0JPcHfx1mKEUEUIx+5MfmqddQ3VO0NZd6OCMdsuic2Lfw/sKXUApmg
         ZkoN7H1UcIqBvrIoqFslwajMtKxIq3klnk1YneaBVr+S3ryxVh8QB5PbkbaiGlt3I8NV
         xW2f/4KM6kz8dLKtoN5xC0Jp27xmNuEiG6KENBBZDqiKgNaN8R/fh7gmv9J/PSCGhodO
         tMIGAu9uINs8zIQGTeyU9EBqFFm/3Rb1M8acpCS3BtRYio0eZfLk8KDSdj6x4qAgTnL6
         Gw9g==
X-Gm-Message-State: APjAAAULMVcWncoXaq2nOyYdXaJNZ5kiXGYWujgSK+8GLxaBc5+Wv9+T
        Ns8sUp+d6UWrTPENdN3MY7814V0+apq3yCXRgLXFBw==
X-Google-Smtp-Source: APXvYqz2npFrD+LlCF2uTl+Miht88iVFzzOl+TZ/0hvtJx7DNmsZkTg7Gs8NrghzicwDmseviqBgO2MiCO4xJVWkRjI=
X-Received: by 2002:a37:a685:: with SMTP id p127mr558460qke.449.1574277422194;
 Wed, 20 Nov 2019 11:17:02 -0800 (PST)
MIME-Version: 1.0
References: <cover.1574126683.git.daniel@iogearbox.net> <a7bb65cc04934cdac5b9e085c6b7b4a85bd5f7ad.1574126683.git.daniel@iogearbox.net>
In-Reply-To: <a7bb65cc04934cdac5b9e085c6b7b4a85bd5f7ad.1574126683.git.daniel@iogearbox.net>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 20 Nov 2019 11:16:51 -0800
Message-ID: <CAEf4BzYPLVHpc=EifKZP7wcfeWpzbENsD9MOb_UN=_48wpW24Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 7/8] bpf, x86: emit patchable direct jump as tail call
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        john fastabend <john.fastabend@gmail.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 18, 2019 at 5:38 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> Add initial code emission for *direct* jumps for tail call maps in
> order to avoid the retpoline overhead from a493a87f38cf ("bpf, x64:
> implement retpoline for tail call") for situations that allow for
> it, meaning, for known constant keys at verification time which are
> used as index into the tail call map. In case of Cilium which makes
> heavy use of tail calls, constant keys are used in the vast majority,
> only for a single occurrence we use a dynamic key.
>
> High level outline is that if the target prog is NULL in the map, we
> emit a 5-byte nop for the fall-through case and if not, we emit a
> 5-byte direct relative jmp to the target bpf_func + skipped prologue
> offset. Later during runtime, we patch these 5-byte nop/jmps upon
> tail call map update or deletions dynamically. Note that on x86-64
> the direct jmp works as we reuse the same stack frame and skip
> prologue (as opposed to some other JIT implementations).
>
> One of the issues is that the tail call map slots can change at any
> given time even during JITing. Therefore, we have two passes: i) emit
> nops for all patchable locations during main JITing phase until we
> declare prog->jited = 1 eventually. At this point the image is stable,
> not public yet and with all jmps disabled. While JITing, we collect
> additional info like poke->ip in order to remember the patch location
> for later modifications. In ii) bpf_tail_call_direct_fixup() walks
> over the progs poke_tab, locks the tail call maps poke_mutex to
> prevent from parallel updates and patches in the right locations via
> __bpf_arch_text_poke(). Note, the main bpf_arch_text_poke() cannot
> be used at this point since we're not yet exposed to kallsyms. For
> the update we use plain memcpy() since the image is not public and
> still in read-write mode. After patching, we activate that poke entry
> through poke->ip_stable. Meaning, at this point any tail call map
> updates/deletions are not going to ignore that poke entry anymore.
> Then, bpf_arch_text_poke() might still occur on the read-write image
> until we finally locked it as read-only. Both modifications on the
> given image are under text_mutex to avoid interference with each
> other when update requests come in in parallel for different tail
> call maps (current one we have locked in JIT and different one where
> poke->ip_stable was already set).
>
> Example prog:
>
>   # ./bpftool p d x i 1655
>    0: (b7) r3 = 0
>    1: (18) r2 = map[id:526]
>    3: (85) call bpf_tail_call#12
>    4: (b7) r0 = 1
>    5: (95) exit
>
> Before:
>
>   # ./bpftool p d j i 1655
>   0xffffffffc076e55c:
>    0:   nopl   0x0(%rax,%rax,1)
>    5:   push   %rbp
>    6:   mov    %rsp,%rbp
>    9:   sub    $0x200,%rsp
>   10:   push   %rbx
>   11:   push   %r13
>   13:   push   %r14
>   15:   push   %r15
>   17:   pushq  $0x0                      _
>   19:   xor    %edx,%edx                |_ index (arg 3)
>   1b:   movabs $0xffff88d95cc82600,%rsi |_ map (arg 2)
>   25:   mov    %edx,%edx                |  index >= array->map.max_entries
>   27:   cmp    %edx,0x24(%rsi)          |
>   2a:   jbe    0x0000000000000066       |_
>   2c:   mov    -0x224(%rbp),%eax        |  tail call limit check
>   32:   cmp    $0x20,%eax               |
>   35:   ja     0x0000000000000066       |
>   37:   add    $0x1,%eax                |
>   3a:   mov    %eax,-0x224(%rbp)        |_
>   40:   mov    0xd0(%rsi,%rdx,8),%rax   |_ prog = array->ptrs[index]
>   48:   test   %rax,%rax                |  prog == NULL check
>   4b:   je     0x0000000000000066       |_
>   4d:   mov    0x30(%rax),%rax          |  goto *(prog->bpf_func + prologue_size)
>   51:   add    $0x19,%rax               |
>   55:   callq  0x0000000000000061       |  retpoline for indirect jump
>   5a:   pause                           |
>   5c:   lfence                          |
>   5f:   jmp    0x000000000000005a       |
>   61:   mov    %rax,(%rsp)              |
>   65:   retq                            |_
>   66:   mov    $0x1,%eax
>   6b:   pop    %rbx
>   6c:   pop    %r15
>   6e:   pop    %r14
>   70:   pop    %r13
>   72:   pop    %rbx
>   73:   leaveq
>   74:   retq
>
> After; state after JIT:
>
>   # ./bpftool p d j i 1655
>   0xffffffffc08e8930:
>    0:   nopl   0x0(%rax,%rax,1)
>    5:   push   %rbp
>    6:   mov    %rsp,%rbp
>    9:   sub    $0x200,%rsp
>   10:   push   %rbx
>   11:   push   %r13
>   13:   push   %r14
>   15:   push   %r15
>   17:   pushq  $0x0                      _
>   19:   xor    %edx,%edx                |_ index (arg 3)
>   1b:   movabs $0xffff9d8afd74c000,%rsi |_ map (arg 2)
>   25:   mov    -0x224(%rbp),%eax        |  tail call limit check
>   2b:   cmp    $0x20,%eax               |
>   2e:   ja     0x000000000000003e       |
>   30:   add    $0x1,%eax                |
>   33:   mov    %eax,-0x224(%rbp)        |_
>   39:   jmpq   0xfffffffffffd1785       |_ [direct] goto *(prog->bpf_func + prologue_size)
>   3e:   mov    $0x1,%eax
>   43:   pop    %rbx
>   44:   pop    %r15
>   46:   pop    %r14
>   48:   pop    %r13
>   4a:   pop    %rbx
>   4b:   leaveq
>   4c:   retq
>
> After; state after map update (target prog):
>
>   # ./bpftool p d j i 1655
>   0xffffffffc08e8930:
>    0:   nopl   0x0(%rax,%rax,1)
>    5:   push   %rbp
>    6:   mov    %rsp,%rbp
>    9:   sub    $0x200,%rsp
>   10:   push   %rbx
>   11:   push   %r13
>   13:   push   %r14
>   15:   push   %r15
>   17:   pushq  $0x0
>   19:   xor    %edx,%edx
>   1b:   movabs $0xffff9d8afd74c000,%rsi
>   25:   mov    -0x224(%rbp),%eax
>   2b:   cmp    $0x20,%eax               .
>   2e:   ja     0x000000000000003e       .
>   30:   add    $0x1,%eax                .
>   33:   mov    %eax,-0x224(%rbp)        |_
>   39:   jmpq   0xffffffffffb09f55       |_ goto *(prog->bpf_func + prologue_size)
>   3e:   mov    $0x1,%eax
>   43:   pop    %rbx
>   44:   pop    %r15
>   46:   pop    %r14
>   48:   pop    %r13
>   4a:   pop    %rbx
>   4b:   leaveq
>   4c:   retq
>
> After; state after map update (no prog):
>
>   # ./bpftool p d j i 1655
>   0xffffffffc08e8930:
>    0:   nopl   0x0(%rax,%rax,1)
>    5:   push   %rbp
>    6:   mov    %rsp,%rbp
>    9:   sub    $0x200,%rsp
>   10:   push   %rbx
>   11:   push   %r13
>   13:   push   %r14
>   15:   push   %r15
>   17:   pushq  $0x0
>   19:   xor    %edx,%edx
>   1b:   movabs $0xffff9d8afd74c000,%rsi
>   25:   mov    -0x224(%rbp),%eax
>   2b:   cmp    $0x20,%eax               .
>   2e:   ja     0x000000000000003e       .
>   30:   add    $0x1,%eax                .
>   33:   mov    %eax,-0x224(%rbp)        |_
>   39:   nopl   0x0(%rax,%rax,1)         |_ fall-through nop
>   3e:   mov    $0x1,%eax
>   43:   pop    %rbx
>   44:   pop    %r15
>   46:   pop    %r14
>   48:   pop    %r13
>   4a:   pop    %rbx
>   4b:   leaveq
>   4c:   retq
>
> Nice side-effect is that this also shrinks the code emission quite a
> bit for for every tail call invocation.

typo: for for

>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>  arch/x86/net/bpf_jit_comp.c | 268 +++++++++++++++++++++++-------------
>  1 file changed, 173 insertions(+), 95 deletions(-)
>

[...]

> +       ret = -EBUSY;
> +       mutex_lock(&text_mutex);
> +       switch (t) {
> +       case BPF_MOD_NOP_TO_CALL:
> +       case BPF_MOD_NOP_TO_JUMP:
> +               if (memcmp(ip, nop_insn, X86_PATCH_SIZE))
> +                       goto out;
> +               text_live ?
> +                       text_poke_bp(ip, new_insn, X86_PATCH_SIZE, NULL) :
> +                       (void)memcpy(ip, new_insn, X86_PATCH_SIZE);

why is this ternary? we are not using expression result so if/else
would be more natural?

> +               break;
> +       case BPF_MOD_CALL_TO_CALL:
> +       case BPF_MOD_JUMP_TO_JUMP:
> +               if (memcmp(ip, old_insn, X86_PATCH_SIZE))
> +                       goto out;
> +               text_live ?
> +                       text_poke_bp(ip, new_insn, X86_PATCH_SIZE, NULL) :
> +                       (void)memcpy(ip, new_insn, X86_PATCH_SIZE);
> +               break;
> +       case BPF_MOD_CALL_TO_NOP:
> +       case BPF_MOD_JUMP_TO_NOP:
> +               if (memcmp(ip, old_insn, X86_PATCH_SIZE))
> +                       goto out;
> +               text_live ?
> +                       text_poke_bp(ip, nop_insn, X86_PATCH_SIZE, NULL) :
> +                       (void)memcpy(ip, nop_insn, X86_PATCH_SIZE);
> +               break;
> +       }
> +       ret = 0;
> +out:
> +       mutex_unlock(&text_mutex);
> +       return ret;
> +}
> +

[...]

> +       for (i = 0; i < prog->aux->size_poke_tab; i++) {
> +               poke = &prog->aux->poke_tab[i];
> +               if (poke->reason != BPF_POKE_REASON_TAIL_CALL)
> +                       continue;
> +
> +               bpf_map_poke_lock(poke->tail_call.map);
> +               target = container_of(poke->tail_call.map, struct bpf_array,
> +                                     map)->ptrs[poke->tail_call.key];

nit: split container_of into separate var?

> +               if (target) {
> +                       /* Plain memcpy is used when image is not live yet
> +                        * and still not locked as read-only. Once poke
> +                        * location is active (poke->ip_stable), any parallel
> +                        * bpf_arch_text_poke() might occur still on the
> +                        * read-write image until we finally locked it as
> +                        * read-only. Both modifications on the given image
> +                        * are under text_mutex to avoid interference.
> +                        */
> +                       ret = __bpf_arch_text_poke(poke->ip, type, NULL,
> +                                                  (u8 *)target->bpf_func +
> +                                                  poke->adj_off, false);
> +                       BUG_ON(ret < 0);
> +               }
> +               WRITE_ONCE(poke->ip_stable, 1);
> +               bpf_map_poke_unlock(poke->tail_call.map);
> +       }
> +}
> +

[...]
