Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0D904088B8
	for <lists+bpf@lfdr.de>; Mon, 13 Sep 2021 12:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238747AbhIMKGO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Sep 2021 06:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238945AbhIMKE0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Sep 2021 06:04:26 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 565FFC061762
        for <bpf@vger.kernel.org>; Mon, 13 Sep 2021 03:03:06 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id y6so16283749lje.2
        for <bpf@vger.kernel.org>; Mon, 13 Sep 2021 03:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PrgxQuCSSBiAu8Y2aqhmWSkEMMvodGI0oGRBuK+GHxg=;
        b=u+GzMYOzviZvatg0aoxXDV1HVZ//g5JcWs4AYESLKYtJx4//hvfWw6oF2dD3psAdG/
         r8rb/UMYdNO/ZTu3SpqaDD+H/FyqXsY4EFhZC8GfO+VK1wRPl4S3sM9pvyn+0BHZvuub
         /qeNMedXxhEXselFA+lDh206abkX8N10PhIDoPkBsIFO36p0utE0tRIKMLYSvIivZ76h
         hPmEP3/epbG2jKvx+IAWMr6L1qZhmgDhofovqIK5hip8NcV4dBV4vtMR9rw/bwdBd5RV
         t3e/IZ25STDX3RUJJwjtP07gLlJ4hkgUC4OjjDcLZ3T9Ata3TjJI7Sfaoc00hccptEqZ
         OFVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PrgxQuCSSBiAu8Y2aqhmWSkEMMvodGI0oGRBuK+GHxg=;
        b=DEGJq00TpN3EppUoYlkKq7bO7r8hOOPqK2MtaEV2dM5F2tMc/4+RThtnCOV4NZJSXl
         i4IAc3UmSCJ3C5FVlKiPBwosIuO22FavR5VRXRxUPB4688uXRr4v60EEOuhjVmZAJ74y
         1vozsODJfATva3t4odh2ueRX8CHy3zZUtquWPjp7jJNB2RyfOhNklBkq0avPQNsKw3Ga
         V5RYc31fZuHB8Kk5USCtWRIVIbPtPCBip4GTJA6tJXNHagszjO07BoUZ+HmnYqe0Y+VR
         OjzPhfvjU9R+DNauv8cx8T1Vxh9FXus2XgdVDhXXvWrRkQQnsvrV7n08GAkXkHGUn8Bx
         VX0Q==
X-Gm-Message-State: AOAM532C7vXpjBGF3caEZ6sr+V0/kEEzoHoEa7DrEQafH+Cb0LobsPvs
        SuiWTK7rOSbvtr1VBXUWZ3dEVF+V4rKC1lTkCl4shA==
X-Google-Smtp-Source: ABdhPJwupCbI/fKsHfFy5MHg1/FsTSjXvqT0WlcFJqrf1I7YmI89KDUk/Q2k+TNLlV/f+yOnnIPbySp4q3o3VqmMz30=
X-Received: by 2002:a2e:b708:: with SMTP id j8mr9753879ljo.488.1631527384648;
 Mon, 13 Sep 2021 03:03:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAOjtDRUnjONzDgtov-ugXejL-TUGwLgyQ50Q1uJqFSH=1q0QUg@mail.gmail.com>
 <c66fe63f-ee85-981b-ef2e-349c70f0cd7a@fb.com>
In-Reply-To: <c66fe63f-ee85-981b-ef2e-349c70f0cd7a@fb.com>
From:   Juraj Vijtiuk <juraj.vijtiuk@sartura.hr>
Date:   Mon, 13 Sep 2021 12:02:53 +0200
Message-ID: <CAOjtDRXLmz_SzY9+CPbNTHYvZFBi-Vsd+426i4yrCm07Z=ZguQ@mail.gmail.com>
Subject: Re: BPF_PROG_TYPE_CGROUP_SOCK bpf_sock ctx member direct access and
 BPF_CORE_READ return different values
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>,
        =?UTF-8?B?RGFyaW8gQmFyYcSH?= <dario.barac@sartura.hr>,
        David Marcinkovic <david.marcinkovic@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 10, 2021 at 7:45 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 9/10/21 8:36 AM, Juraj Vijtiuk wrote:
> > Hello,
> >
> > while developing some cgroup socket programs, we have noticed that
> > some BPF_PROG_TYPE_CGROUP_SOCK programs return different values when
> > the bpf_sock context is accessed, depending on how they are accessed.
> > One example of the issue would be access to ctx->family in programs
> > that attach to BPF_CGROUP_INET6_POST_BIND and
> > BPF_CGROUP_INET4_POST_BIND. A direct ctx->family access returns the
> > correct value, while BPF_CORE_READ(ctx, family) returns random values.
> > The BPF C program and an example userspace C loader are attached
> > below, with an example trace_pipe output.
> >
> > So far we have looked at the generated BPF byte code with llvm-objdump
> > and everything looked fine there, the main difference being in the way
> > the access is done, as expected. The BPF_CORE_READ macro expands into
> > a bpf_probe_read_kernel() call with arguments wrapped in
> > __builtin_preserve_access_index. bpf_probe_read_* helper calls are
> > supported for BPF_PROG_TYPE_CGROUP_SOCKS so that shouldn't be an
> > issue. Next, we looked at libbpf debug output, where everything looked
> > ok too. The part of the output with relocations is attached below.
>
> This is an incorrect usage of CORE. See below.
>
> >
> > We have tested this with various kernel versions, including 5.10, 5.11
> > and 5.13 on x86_64 and 5.11 on 32 bit ARM. The issue appeared on all
> > of those kernels and architectures.
> >
> > At this point we're not sure what to look at next so any ideas on what
> > might cause the issues or suggestions on what to test next would be
> > greatly appreciated.
> >
> > Regards,
> > Juraj Vijtiuk
> >
> > example.bpf.c
> > ----------------------------------------
> >
> > #include "vmlinux.h"
> > #include <bpf/bpf_helpers.h>
> > #include <bpf/bpf_core_read.h>
> >
> > SEC("cgroup/post_bind4")
> > int cgroup_post_bind4_prog(struct bpf_sock *ctx)
> > {
> >      u32 family1 = 0;
> >      u32 family2 = 0;
> >
> >      family1 = ctx->family;
> >      family2 = BPF_CORE_READ(ctx, family);
> >      bpf_printk("family1 = %u, family2 = %u\n", family1, family2);
>
> We have assembly code below:
>         0:       b7 02 00 00 04 00 00 00 r2 = 4
>         1:       bf 13 00 00 00 00 00 00 r3 = r1
>         2:       0f 23 00 00 00 00 00 00 r3 += r2
>         3:       61 16 04 00 00 00 00 00 r6 = *(u32 *)(r1 + 4)
>         4:       bf a1 00 00 00 00 00 00 r1 = r10
>         5:       07 01 00 00 e0 ff ff ff r1 += -32
>         6:       b4 02 00 00 04 00 00 00 w2 = 4
>         7:       85 00 00 00 71 00 00 00 call 113
>         8:       61 a4 e0 ff 00 00 00 00 r4 = *(u32 *)(r10 - 32)
>
> Looks like they are the same one insn #3 read context + 4
> and another insn #7 also read context + 4.
>
> But for insn #3, the verifier will rewrite it proper kernel field,
>          case offsetof(struct bpf_sock, family):
>                  *insn++ = BPF_LDX_MEM(
>                          BPF_FIELD_SIZEOF(struct sock_common, skc_family),
>                          si->dst_reg, si->src_reg,
>                          bpf_target_off(struct sock_common,
>                                         skc_family,
>                                         sizeof_field(struct sock_common,
>                                                      skc_family),
>                                         target_size));
>                  break;
>
> and this is not the same for insn #7.
> That is why they have different results. The CORE is used for accessing
> kernel data structures, the "ctx" is not really a kernel data structure
> (rather a UAPI interface) in most cases.
>

This makes sense and seems obvious now, after reading the explanation above.
Thank you very much for the quick and detailed response.

> >
> >      return 0;
> > }
> >
> > char LICENSE[] SEC("license") = "GPL";
> >
> > example.c
> > ----------------------------------------
> > #include <sys/types.h>
> > #include <sys/stat.h>
> > #include <fcntl.h>
> > #include <unistd.h>
> > #include <sys/resource.h>
> > #include <argp.h>
> >
> > #include <bpf/libbpf.h>
> > #include <bpf/bpf.h>
> >
> > #include "example.skel.h"
> >
> > void read_trace_pipe(void)
> > {
> >      int trace_fd;
> >
> >      trace_fd = open("/sys/kernel/debug/tracing/trace_pipe", O_RDONLY, 0);
> >      if (trace_fd < 0)
> >          return;
> >
> >      while (1) {
> >          static char buf[4096];
> >          ssize_t sz;
> >
> >          sz = read(trace_fd, buf, sizeof(buf) - 1);
> >          if (sz > 0) {
> >              buf[sz] = 0;
> >              puts(buf);
> >          }
> >      }
> > }
> >
> > int libbpf_print_fn(enum libbpf_print_level level,
> > const char *format, va_list args)
> > {
> >      return vfprintf(stderr, format, args);
> > }
> >
> > int main(int argc, char **argv) {
> >      struct example_bpf *obj;
> >      int err = 0;
> >      struct rlimit rlim = {
> >          .rlim_cur = 512UL << 20,
> >          .rlim_max = 512UL << 20,
> >      };
> >
> >      err = setrlimit(RLIMIT_MEMLOCK, &rlim);
> >      if (err) {
> >          fprintf(stderr, "failed to change rlimit\n");
> >          return 1;
> >      }
> >
> >      libbpf_set_print(libbpf_print_fn);
> >      obj = example_bpf__open();
> >      if (!obj) {
> >          fprintf(stderr, "failed to open and/or load BPF object\n");
> >          return 1;
> >      }
> >
> >      err = example_bpf__load(obj);
> >      if (err) {
> >          fprintf(stderr, "failed to load BPF object %d\n", err);
> >          goto cleanup;
> >      }
> >
> >      const char *cgroup_path = "/sys/fs/cgroup";
> >      int cgroup_fd = open(cgroup_path, O_DIRECTORY | O_RDONLY);
> >
> >      struct bpf_program *prog = obj->progs.cgroup_post_bind4_prog;
> >      obj->links.cgroup_post_bind4_prog =
> > bpf_program__attach_cgroup(prog, cgroup_fd);
> >      err = libbpf_get_error(obj->links.cgroup_post_bind4_prog);
> >      if (err) {
> >          fprintf(stderr, "failed to attach BPF program %d\n", err);
> >          goto cleanup;
> >      }
> >
> >      read_trace_pipe();
> >
> > cleanup:
> >      example_bpf__destroy(obj);
> >      return err != 0;
> > }
> >
> > trace_pipe output
> > ----------------------------------------
> > Chrome_IOThread-26477   [006] d..2 385580.114654: bpf_trace_printk:
> > family1 = 2, family2 = 1747691712
> > <...>-144100  [004] d..2 385594.936690: bpf_trace_printk: family1 = 2,
> > family2 = 0
> >
> > libbpf relocation log
> > ----------------------------------------
> > libbpf: loading kernel BTF '/sys/kernel/btf/vmlinux': 0
> > libbpf: sec 'cgroup/post_bind4': found 2 CO-RE relocations
> > libbpf: prog 'cgroup_post_bind4_prog': relo #0: kind <byte_off> (0),
> > spec is [2] struct bpf_sock.family (0:1 @ offset 4)
> > libbpf: CO-RE relocating [2] struct bpf_sock: found target candidate
> > [24518] struct bpf_sock
> > libbpf: prog 'cgroup_post_bind4_prog': relo #0: matching candidate #0
> > [24518] struct bpf_sock.family (0:1 @ offset 4)
> > libbpf: prog 'cgroup_post_bind4_prog': relo #0: patched insn #9
> > (ALU/ALU64) imm 4 -> 4
> > libbpf: prog 'cgroup_post_bind4_prog': relo #1: kind <byte_off> (0),
> > spec is [2] struct bpf_sock.family (0:1 @ offset 4)
> > libbpf: prog 'cgroup_post_bind4_prog': relo #1: matching candidate #0
> > [24518] struct bpf_sock.family (0:1 @ offset 4)
> > libbpf: prog 'cgroup_post_bind4_prog': relo #1: patched insn #12
> > (LDX/ST/STX) off 4 -> 4
> >
