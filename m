Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFEF2CD55D
	for <lists+bpf@lfdr.de>; Thu,  3 Dec 2020 13:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728837AbgLCMU5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Dec 2020 07:20:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728609AbgLCMU4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Dec 2020 07:20:56 -0500
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02368C08E85E
        for <bpf@vger.kernel.org>; Thu,  3 Dec 2020 04:20:04 -0800 (PST)
Received: by mail-io1-xd42.google.com with SMTP id z5so1804668iob.11
        for <bpf@vger.kernel.org>; Thu, 03 Dec 2020 04:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=f/k9fXBGMIJ5lSOav2B3OpXFwXkr3+g5IjR2l36jK/Q=;
        b=MJnpmxgniHSWgbsn5ROhJ67dINHkKlo08/Y/qVabpAglTF+ohti0ozi+lGuH5JFVW6
         Kp7yaPH3ZSRB7UU98xmyM0YXlKy4uimhiUpErJZuLGiYG2jq0sv28VAVWMt5Y6pUuaLH
         IszVkIBy+/y+gZKLn6PKgMuZgP/TO9eiLgsXlqxRWSYYvkOXKyMNQ21f0Z4VkNzHp8A4
         Aj3mpZMrNiaJvl0JEAjgSADYu2Fr/P1EI9bAe6ZovfjM1A6fNUdUhAOZuMCKH4S24TRj
         bFPo7tDJRkXWWyi2MF99aBLdB1C5fcUvhK9xNH3zLWa8O8qsDI5KuR7FPnVL4tbwXp9M
         1p2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=f/k9fXBGMIJ5lSOav2B3OpXFwXkr3+g5IjR2l36jK/Q=;
        b=nZRzda2jEaDQkJHwxWrIubGK7jVgBw9n14+Qr1tX50iw7zRELKr3lcadlzqSBCGuG0
         WbrxnoWJjNKq5CN07Wir+wf7BtrbN5Vgg/SgERb1jhl7th/1LwS2xi0/WyhxFUbvnwiQ
         NLUxghvAEQCXUuxoI/46eJJ1/5P+EFoV7zRyGHuSRuZy3bBt3mNx8CGxIHDKjS2gZJKA
         74oEas9Jk0BtIF/rgs/3ChdNFc4V90VIy2Qnc67sgI2nlkR3VXS3uo0goDTmT+xDzAS9
         G9/26NiYqRdZEbd9jxoxy138YKNkiY7dRaQ4OANfQ+o2fSermBb6ddQuN7gFYohVG6ZJ
         z5IQ==
X-Gm-Message-State: AOAM531Wdp9cWfSLE4WDGPZsCyE4Jdqz/U8zzdPgZ/TmEaUYpGBY+TxF
        hZbWGM84EN9MwJNjYGJcbJsqaIifmHae+WFjfMX29aFPiFLFGw==
X-Google-Smtp-Source: ABdhPJwOKQRC0X4RbauzvT+ptgbJjxHn+Ww9gVrRaMWAPUng6Ytz0jMzgBaA2p5h2cWjX2GDH2LisPRAr0N2JTZGM24=
X-Received: by 2002:a02:c7c1:: with SMTP id s1mr3103155jao.94.1606998002952;
 Thu, 03 Dec 2020 04:20:02 -0800 (PST)
MIME-Version: 1.0
From:   David Marcinkovic <david.marcinkovic@sartura.hr>
Date:   Thu, 3 Dec 2020 13:19:51 +0100
Message-ID: <CAO__=G52s_=2E4wF8wDcgc3KwMU0kzmDfBQhDD3+LMZ8M3fZ8w@mail.gmail.com>
Subject: Problem with BPF_CORE_READ macro function
To:     bpf <bpf@vger.kernel.org>
Cc:     Juraj Vijtiuk <juraj.vijtiuk@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello everyone,

I am trying to run a simple BPF program that hooks onto
`mac80211/drv_sta_state` tracepoint. When I run the program on the arm
32 bit architecture,
the verifier rejects to load the program and outputs the following error
message:

Unrecognized arg#0 type PTR
; int tp__mac80211_drv_sta_state(struct trace_event_raw_drv_sta_state* ctx)
0: (bf) r3 =3D r1
1: (85) call unknown#195896080
invalid func unknown#195896080

This error does not seem to occur on the amd64 architecture. I am
using clang version 10 for both, compiling on amd64 and
cross-compiling for arm32.


I have prepared a simple program that hooks onto the
`mac80211/drv_sta_state` tracepoint.
In this example, `BPF_CORE_READ` macro function seems to cause the
verifier to reject to load the program.
I've been using this macro in various different programs and it didn't
cause any problems.
Also, I've been using packed structs and bit fields in other programs
and they also didn't cause any problems.

I tried to use BPF_CORE_READ_BITFIELD as stated in this patch [0] and
got a similar error.

Any input is much appreciated,

Best regards,
David Mar=C4=8Dinkovi=C4=87


[0] https://lore.kernel.org/bpf/20201007202946.3684483-1-andrii@kernel.org/=
T/#ma08db511daa0b5978f16df9f98f4ef644b83fc96


mac80211.c
-------------------

#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>

#include <bpf/libbpf.h>
#include <bpf/bpf.h>
#include "mac80211.skel.h"

void read_trace_pipe(void)
{
int trace_fd;

trace_fd =3D open("/sys/kernel/debug/tracing/trace_pipe", O_RDONLY, 0);
if (trace_fd < 0)
return;

while (1) {
static char buf[4096];
ssize_t sz;

sz =3D read(trace_fd, buf, sizeof(buf) - 1);
if (sz > 0) {
buf[sz] =3D 0;
puts(buf);
}
}
}

int main(int argc, char **argv)
{
struct mac80211_bpf *obj;
int err =3D 0;

obj =3D mac80211_bpf__open();
if (!obj) {
fprintf(stderr, "failed to open and/or load BPF object\n");
return 1;
}

err =3D mac80211_bpf__load(obj);
if (err) {
fprintf(stderr, "failed to load BPF object %d\n", err);
goto cleanup;
}

err =3D mac80211_bpf__attach(obj);
if (err) {
fprintf(stderr, "failed to attach BPF programs\n");
goto cleanup;
}

read_trace_pipe();

cleanup:
mac80211_bpf__destroy(obj);
return err !=3D 0;
}



mac80211.bpf.c
-------------------

#include "vmlinux.h"

#include <bpf/bpf_core_read.h>
#include <bpf/bpf_helpers.h>


SEC("tracepoint/mac80211/drv_sta_state")
int tp__mac80211_drv_sta_state(struct trace_event_raw_drv_sta_state* ctx)
{
        u32 old_state =3D BPF_CORE_READ(ctx, old_state);

        bpf_printk("Old state is %d\n", old_state);

        return 0;
}

char LICENSE[] SEC("license") =3D "GPL";
