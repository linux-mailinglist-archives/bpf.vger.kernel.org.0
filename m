Return-Path: <bpf+bounces-5523-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E4B75B5CE
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 19:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 763771C214B4
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 17:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2725174EB;
	Thu, 20 Jul 2023 17:41:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46972FA35
	for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 17:41:29 +0000 (UTC)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9DAB2D71
	for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 10:40:57 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fbfa811667so14203725e9.1
        for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 10:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1689874856; x=1690479656;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4SDPakw1mdQ05GnSGgOzVxv3Fa7cpqpj5ogcj0OpaCs=;
        b=ezHuPDd+lI74Yn0eXq51hnVyXyTCwa1t/kdI2D11dWE7Ou/boD8vjBYZ+EgkzOmnN+
         ur9+/8ckx6NM+7LYp9GDhSTkeRTFsU+nYWMnF1WCCHB0Bk1J/aXDFR0FSoneJAFHQmW9
         wjAGg/UP0S1ZlA8oGYRQXDyLEy4vAAYSd+agg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689874856; x=1690479656;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4SDPakw1mdQ05GnSGgOzVxv3Fa7cpqpj5ogcj0OpaCs=;
        b=SDfnshbi1gHc90P7YTiarEKHa8dekH+Tb6Kb3N3E6MAE4/uP82MCpQAdgl5cQpx2k7
         umfLWo2hKOrL9FjYBqJNMt6beKfxOsrC9FZ8INXbqIr+jbppz2XMpr+gPS8PjYlIIv9N
         HQFwfSic+TEmmAx8I+RNyK50s18qY/KqN89DQ2g0TDJQAbYCwHKBG7DdsCK4Ki6au5oe
         ajuKqvnno5jppXd4O/hfiM2/EDxJdYKyimVDs4e3gEAsCQe8aGYjH7Ld/MviD1do8kbG
         ksu2YrjtLW1Z1Ck1Ci3cmV3jBLIQw7RunbYc+I8cmGgyeyyGjkTtU3+DJsRan8R8/wo2
         PNvg==
X-Gm-Message-State: ABy/qLZeTJHlhsrauBmkKDzaj6LOahwXxMsbncNQJyKB06ybk7zDDVqQ
	35xKi+QdtqClAMD+1VJej1Bqjmhf0nbjj7U3tar0PfWwU7RwXi7UWtI=
X-Google-Smtp-Source: APBJJlHJv115BU2nacUnJxMcpxEUa3lP6tIWnpGJE2b+AmUe65Wu3Pk0+kkVmtWcsT8E5YU9FCAf64TTV+XTcKdAGuQ=
X-Received: by 2002:a5d:5386:0:b0:313:f3c0:62d8 with SMTP id
 d6-20020a5d5386000000b00313f3c062d8mr3423760wrv.21.1689874855743; Thu, 20 Jul
 2023 10:40:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ivan Babrou <ivan@cloudflare.com>
Date: Thu, 20 Jul 2023 10:40:45 -0700
Message-ID: <CABWYdi3iyagrnN=2uMbq_K0c4FzporQ1pbUmkUZKsiQ22srP3A@mail.gmail.com>
Subject: CAP_SYS_ADMIN required for BTF in modules
To: bpf <bpf@vger.kernel.org>
Cc: kernel-team <kernel-team@cloudflare.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>, 
	Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

I noticed that CAP_SYS_ADMIN is required to attach BTF enabled probes
for modules. Attaching them for compiled-in points works just fine
without it.

The reason is that libbpf calls into bpf_obj_get_next_id:

#0  bpf_obj_get_next_id (start_id=start_id@entry=0,
next_id=next_id@entry=0x7fffcbffe578, cmd=cmd@entry=23) at bpf.c:908
#1  0x00000000008bc08a in bpf_btf_get_next_id
(start_id=start_id@entry=0, next_id=next_id@entry=0x7fffcbffe578) at
bpf.c:930
#2  0x00000000008ca252 in load_module_btfs
(obj=obj@entry=0x7fffc4004a40) at libbpf.c:5365
#3  0x00000000008ca508 in find_kernel_btf_id
(btf_type_id=0x7fffcbffe73c, btf_obj_fd=0x7fffcbffe738,
attach_type=BPF_TRACE_FENTRY, attach_name=0xf8b647
"nfnetlink_rcv_msg", obj=0x7fffc4004a40) at libbpf.c:9057
#4  find_kernel_btf_id (obj=0x7fffc4004a40, attach_name=0xf8b647
"nfnetlink_rcv_msg", attach_type=BPF_TRACE_FENTRY,
btf_obj_fd=0x7fffcbffe738, btf_type_id=0x7fffcbffe73c) at
libbpf.c:9042
#5  0x00000000008ca755 in libbpf_find_attach_btf_id
(btf_type_id=0x7fffcbffe73c, btf_obj_fd=0x7fffcbffe738,
attach_name=0xf8b647 "nfnetlink_rcv_msg", prog=0x7fffc401d5b0) at
libbpf.c:9109
#6  libbpf_prepare_prog_load (prog=0x7fffc401d5b0,
opts=0x7fffcbffe7c0, cookie=<optimized out>) at libbpf.c:6668
#7  0x00000000008c3eb5 in bpf_object_load_prog
(obj=obj@entry=0x7fffc4004a40, prog=prog@entry=0x7fffc401d5b0,
insns=0x7fffc400ccc0, insns_cnt=87,
license=license@entry=0x7fffc4004a50 "GPL",
    kern_version=<optimized out>, prog_fd=0x7fffc401d628) at libbpf.c:6741
#8  0x00000000008d0294 in bpf_object__load_progs (log_level=<optimized
out>, obj=<optimized out>) at libbpf.c:7085
#9  bpf_object_load (extra_log_level=0, target_btf_path=0x0,
obj=<optimized out>) at libbpf.c:7656
#10 bpf_object__load (obj=<optimized out>) at libbpf.c:7703
#11 0x00000000008b90e7 in _cgo_58a414c63447_Cfunc_bpf_object__load
(v=0xc000237bd8) at cgo-gcc-prolog:1232
#12 0x000000000046c224 in runtime.asmcgocall () at
/usr/local/go/src/runtime/asm_amd64.s:848
#13 0x00007fffcbfff260 in ?? ()
#14 0x000000000041020e in runtime.persistentalloc.func1 () at
/usr/local/go/src/runtime/malloc.go:1393
#15 0x000000000046a3a9 in runtime.systemstack () at
/usr/local/go/src/runtime/asm_amd64.s:496
#16 0x00007fffffffdf6f in ?? ()
#17 0x0100000000000000 in ?? ()
#18 0x0000000000800000 in
github.com/golang/protobuf/ptypes/timestamp.file_github_com_golang_protobuf_ptypes_timestamp_timestamp_proto_init
()
    at /home/builder/go/pkg/mod/github.com/golang/protobuf@v1.5.2/ptypes/timestamp/timestamp.pb.go:57
#19 0x0000000000000000 in ?? ()

Here it is in code, where it happens after vmlinux does not find the
requested id:

* https://github.com/libbpf/libbpf/blob/v1.2.0/src/libbpf.c#L9219

And in turn bpf_obj_get_next_id requires CAP_SYS_ADMIN here:

* https://elixir.bootlin.com/linux/v6.5-rc1/source/kernel/bpf/syscall.c#L3790

The requirement comes from commit 34ad558 ("bpf: Add
BPF_(PROG|MAP)_GET_NEXT_ID command") from v4.13:

* https://github.com/torvalds/linux/commit/34ad558

There's also this in the commit message: It is currently limited to
CAP_SYS_ADMIN which we can consider to lift it in followup patches.

Later in v5.4 commit 341dfcf ("btf: expose BTF info through sysfs")
exposed BTF info via sysfs:

* https://github.com/torvalds/linux/commit/341dfcf

This info is world readable and it doesn't require any special capabilities:

static struct bin_attribute bin_attr_btf_vmlinux __ro_after_init = {
  .attr = { .name = "vmlinux", .mode = 0444, },
  .read = btf_vmlinux_read,
};

$ ls -l /sys/kernel/btf/vmlinux
-r--r--r-- 1 root root 4438336 Jul 13 06:33 /sys/kernel/btf/vmlinux

My question is then: do we still need CAP_SYS_ADMIN? Should it be
CAP_BPF / CAP_PERFMON (available since v5.8) or should we drop the
requirement completely, since we expose vmlinux btf without any
restrictions?

I'm happy to submit a patch.

