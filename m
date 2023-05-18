Return-Path: <bpf+bounces-923-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF80708B4C
	for <lists+bpf@lfdr.de>; Fri, 19 May 2023 00:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A1471C21150
	for <lists+bpf@lfdr.de>; Thu, 18 May 2023 22:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1D824127;
	Thu, 18 May 2023 22:08:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261203D38F
	for <bpf@vger.kernel.org>; Thu, 18 May 2023 22:08:44 +0000 (UTC)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4909BE7
	for <bpf@vger.kernel.org>; Thu, 18 May 2023 15:08:42 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-510d6e1f1abso4199472a12.2
        for <bpf@vger.kernel.org>; Thu, 18 May 2023 15:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684447721; x=1687039721;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AFmcxY0ZBscVylzHSm+szVQWxkHnBuajV1K/abarRag=;
        b=q+S/jlu51zCEuoehvBs2pGlJTXwcEA+P9zJfWLoXhbfwrU4iB2DN6VjMQN7Ydq+TB3
         OTptPzFKV+3OS9f+JoJQ3quljk8FrA6cmDtPQZje336yUA9xRJkEmRDBA2OVd/+AyzXe
         Cks6e1N97pb/y3zPNw0dgQTD8ROlar+xCQW7yAOAdFBOU6XCjUakFDwubLRV2gvTwb+E
         9QoUnp34pmhkjum4sUIJlVmyv731gAWEdHYRNOVRQkyj1sikKPicSXMVjxoaZFd+VaQ/
         aAIyY+LIl+7ALmC7eeMnnTvLxGZzgc1JqX1gF5K4pSpeS3UiI2WJmaNqJtLby9e8NUnV
         uoCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684447721; x=1687039721;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AFmcxY0ZBscVylzHSm+szVQWxkHnBuajV1K/abarRag=;
        b=FwGqtUvMZoz+YT7dT9hFstKTQgJqpNCisk8mvhelfc2f/xSJLPE9QQQRRTvamw31Cu
         3j86N+H0EnyrpjLthI1hQGXktgi3N39dff7UUGVQxZ7Mo3l5Au1tk035yO6MM6k6BHLi
         qA06lTIPXjc2Y9tE/Tsz4OadYElW27VK8qdG+UGgqVCurP+kHfT4X8418tmrwsrXWiwI
         +CHS8+FH0FBEoGOKoovuZPRieRWGika8PMWNJLGp/qjprVzgQxxSRLfVGmptO4KvTZ/V
         AC+wySNY5zgcV9prcBptWagXeiPjxlXUPZnu9Q95MKfcF0OENBLdp1aAoyoBfV2nptMc
         qqLw==
X-Gm-Message-State: AC+VfDwT1B+vpAAocFVQx189PUg1uiAny7ecr8LK6EnLe0KxIk6o9gR5
	JoEeCJM0kMzfsfR1jiIGA5WkWEtz8YkOWSiIhutMZm4Kv+I=
X-Google-Smtp-Source: ACHHUZ7qVwTiMLeGjONBKkWuVQN1D0C2sGSGPz847vc2Ym91JRegJWasHNQMhjvHotO1BaQVFjPiUuvoM6E1XMWf/4I=
X-Received: by 2002:a05:6402:1b0c:b0:50b:c72a:2b1b with SMTP id
 by12-20020a0564021b0c00b0050bc72a2b1bmr7615025edb.19.1684447720327; Thu, 18
 May 2023 15:08:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <704ea11a.31aa.1882d4a9b2c.Coremail.jiangyingfeng163@163.com>
In-Reply-To: <704ea11a.31aa.1882d4a9b2c.Coremail.jiangyingfeng163@163.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 18 May 2023 15:08:27 -0700
Message-ID: <CAEf4Bzbw6gpdHgw4eSPFBQ2EBJEr0XJxOOoM=TU45-Jks50LCw@mail.gmail.com>
Subject: Re: libbpf: bpf_prog_load failed, invalid argument
To: =?UTF-8?B?6JKL5bqU6ZSL?= <jiangyingfeng163@163.com>
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, May 17, 2023 at 10:17=E2=80=AFPM =E8=92=8B=E5=BA=94=E9=94=8B <jiang=
yingfeng163@163.com> wrote:
>
>
>
>
>
> when i test libbpf-bootstrap examples=EF=BC=8Cbpf syscall failed, errno i=
s 22, strace log as below:
>

What does libbpf debug log say?


>
> 24400 bpf(BPF_PROG_LOAD, {prog_type=3DBPF_PROG_TYPE_SOCKET_FILTER, insn_c=
nt=3D2, insns=3D0x7fffe7489940, license=3D"GPL", log_level=3D0, log_size=3D=
0, log_buf=3DNULL, kern_version=3DKERNEL_VERSION(0, 0, 0), prog_flags=3D0, =
prog_name=3D"", prog_ifindex=3D0, expected_attach_type=3DBPF_CGROUP_INET_IN=
GRESS}, 116) =3D -1 EINVAL (Invalid argument)
> 24400 bpf(BPF_PROG_LOAD, {prog_type=3DBPF_PROG_TYPE_SOCKET_FILTER, insn_c=
nt=3D2, insns=3D0x7fffe7489ae0, license=3D"GPL", log_level=3D0, log_size=3D=
0, log_buf=3DNULL, kern_version=3DKERNEL_VERSION(0, 0, 0), prog_flags=3D0, =
prog_name=3D"", prog_ifindex=3D0, expected_attach_type=3DBPF_CGROUP_INET_IN=
GRESS}, 128) =3D 3
> 24400 bpf(BPF_BTF_LOAD, 0x7fffe74898e0, 28) =3D 3
> 24400 bpf(BPF_BTF_LOAD, 0x7fffe74898c0, 28) =3D -1 EINVAL (Invalid argume=
nt)
> 24400 bpf(BPF_BTF_LOAD, 0x7fffe74898b0, 28) =3D -1 EINVAL (Invalid argume=
nt)
> 24400 bpf(BPF_BTF_LOAD, 0x7fffe74898e0, 28) =3D -1 EINVAL (Invalid argume=
nt)
> 24400 bpf(BPF_BTF_LOAD, 0x7fffe74898c0, 28) =3D -1 EINVAL (Invalid argume=
nt)
> 24400 bpf(BPF_BTF_LOAD, 0x7fffe74898c0, 28) =3D -1 EINVAL (Invalid argume=
nt)
> 24400 bpf(BPF_BTF_LOAD, 0x7fffe74898c0, 28) =3D -1 EINVAL (Invalid argume=
nt)
> 24400 bpf(BPF_BTF_LOAD, 0x7fffe74898e0, 28) =3D -1 EINVAL (Invalid argume=
nt)
> 24400 bpf(BPF_BTF_LOAD, 0x7fffe74898f0, 28) =3D 3
> 24400 bpf(BPF_PROG_LOAD, {prog_type=3DBPF_PROG_TYPE_SOCKET_FILTER, insn_c=
nt=3D2, insns=3D0x7fffe7489850, license=3D"GPL", log_level=3D0, log_size=3D=
0, log_buf=3DNULL, kern_version=3DKERNEL_VERSION(0, 0, 0), prog_flags=3D0, =
prog_name=3D"libbpf_nametest"}, 64) =3D 4
> 24400 bpf(BPF_MAP_CREATE, {map_type=3DBPF_MAP_TYPE_ARRAY, key_size=3D4, v=
alue_size=3D4, max_entries=3D1, map_flags=3D0x400 /* BPF_F_??? */, inner_ma=
p_fd=3D0, map_name=3D"libbpf_mmap", map_ifindex=3D0}, 72) =3D -1 EINVAL (In=
valid argument)
> 24400 bpf(BPF_MAP_CREATE, {map_type=3DBPF_MAP_TYPE_ARRAY, key_size=3D4, v=
alue_size=3D32, max_entries=3D1, map_flags=3D0, inner_map_fd=3D0, map_name=
=3D"libbpf_global", map_ifindex=3D0}, 72) =3D 4
> 24400 bpf(BPF_PROG_LOAD, {prog_type=3DBPF_PROG_TYPE_SOCKET_FILTER, insn_c=
nt=3D5, insns=3D0x7fffe7489820, license=3D"GPL", log_level=3D0, log_size=3D=
0, log_buf=3DNULL, kern_version=3DKERNEL_VERSION(0, 0, 0), prog_flags=3D0, =
prog_name=3D"", prog_ifindex=3D0, expected_attach_type=3DBPF_CGROUP_INET_IN=
GRESS}, 128) =3D -1 EINVAL (Invalid argument)
> 24400 bpf(BPF_PROG_LOAD, {prog_type=3DBPF_PROG_TYPE_TRACEPOINT, insn_cnt=
=3D6, insns=3D0x7fffe74890d0, license=3D"GPL", log_level=3D0, log_size=3D0,=
 log_buf=3DNULL, kern_version=3DKERNEL_VERSION(0, 0, 0), prog_flags=3D0, pr=
og_name=3D"", prog_ifindex=3D0, expected_attach_type=3DBPF_CGROUP_INET_INGR=
ESS}, 128) =3D -1 EINVAL (Invalid argument)
> 24400 bpf(BPF_PROG_LOAD, {prog_type=3DBPF_PROG_TYPE_KPROBE, insn_cnt=3D18=
, insns=3D0x1b7b580, license=3D"Dual BSD/GPL", log_level=3D0, log_size=3D0,=
 log_buf=3DNULL, kern_version=3DKERNEL_VERSION(4, 19, 0), prog_flags=3D0, p=
rog_name=3D"do_unlinkat", prog_ifindex=3D0, expected_attach_type=3DBPF_CGRO=
UP_INET_INGRESS}, 128) =3D -1 EINVAL (Invalid argument)
> 24400 bpf(BPF_PROG_LOAD, {prog_type=3DBPF_PROG_TYPE_KPROBE, insn_cnt=3D18=
, insns=3D0x1b7b580, license=3D"Dual BSD/GPL", log_level=3D1, log_size=3D16=
777215, log_buf=3D"", kern_version=3DKERNEL_VERSION(4, 19, 0), prog_flags=
=3D0, prog_name=3D"do_unlinkat", prog_ifindex=3D0, expected_attach_type=3DB=
PF_CGROUP_INET_INGRESS}, 128) =3D -1 EINVAL (Invalid argument)
> 24400 +++ exited with 22 +++
>
>
> kernel information is "Linux admin-PC 4.19.0-amd64-desktop #5404 SMP Fri =
Dec 23 17:25:30 CST 2022 x86_64 GNU/Linux"
> ebpf source code:
> ```c
>
> // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
> /* Copyright (c) 2021 Sartura */
> #define BPF_NO_GLOBAL_DATA
> #define BPF_NO_PRESERVE_ACCESS_INDEX
> #include "vmlinux.h"
> #include <bpf/bpf_helpers.h>
> #include <bpf/bpf_tracing.h>
> #include <bpf/bpf_core_read.h>
>
>
> char LICENSE[] SEC("license") =3D "Dual BSD/GPL";
>
>
> SEC("kprobe/do_unlinkat")
> int BPF_KPROBE(do_unlinkat, int dfd, struct filename *name)
> {
>         pid_t pid;
>         const char *filename;
>
>
>         pid =3D bpf_get_current_pid_tgid() >> 32;
>         filename =3D BPF_CORE_READ(name, name);
>         bpf_trace_printk("KPROBE ENTRY pid =3D %d, filename =3D %s\n", pi=
d, filename);
>         return 0;
> }
>
>
> SEC("kretprobe/do_unlinkat")
> int BPF_KRETPROBE(do_unlinkat_exit, long ret)
> {
>         pid_t pid;
>
>
>         pid =3D bpf_get_current_pid_tgid() >> 32;
>         bpf_trace_printk("KPROBE EXIT: pid =3D %d, ret =3D %ld\n", pid, r=
et);
>         return 0;
> }
>
>
> ```

