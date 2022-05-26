Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3245353D0
	for <lists+bpf@lfdr.de>; Thu, 26 May 2022 21:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242960AbiEZTP6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 May 2022 15:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbiEZTP5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 May 2022 15:15:57 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E019CF52
        for <bpf@vger.kernel.org>; Thu, 26 May 2022 12:15:56 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id i74so2543258ioa.4
        for <bpf@vger.kernel.org>; Thu, 26 May 2022 12:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=w2dOZ6bp8A3fvOPrCxoccsER/gU+Zt9Vu0OlRdlnzVk=;
        b=ppMBVwF3Fl6aCd64fY0BRERkvagmDfo7gUlU6cKPwzUCzabLVvjAzKR50NREYxVjQJ
         kMqUVfUgvg6sH0DhgdPeRzDqB/ZS6Ny+jNAM4smOVkg8VjKg1ckMDdey6RsmSvh91m8S
         zw/7UxisRe1P5unNuUx4DsEa6R79bPrhe+1h0np1B06jrm3vdbMr6kwcanm+atdzyzy2
         X2zJlH1Yt/yFNIYaRIfSHy7SuimdM+J2RzeGr+X82MPdpf5ihE0PuRkvzGRgnED6zZoZ
         wSXjHwObRNXi10RYyKRHVXrIGYWx02ybgTFnS5HL3yJe7TUhyJ0SGW3N8fDIv0QMNswr
         wPuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=w2dOZ6bp8A3fvOPrCxoccsER/gU+Zt9Vu0OlRdlnzVk=;
        b=Oo7TbUOyCz1dKvTeY85hJJfADBN6SKfbxyH/V8udNoXpwm9Zkhmw/FdFQF0t2BBlIE
         KUV90RTaGYmhCPfDvw+ptaaGdZiC8JysOy/RZBtE1QklyGG/Lkq1V2dhPIVaWWaxMd3O
         Vhd5UeYsWW8VTBGa4I/EYbQd03yQ96w1Ez7EZC5fFVY6TSf6CU8aPmFvgSS8qx0KEBFv
         xOegeL5rEFEPitWLJMOL4TCoNPSKsJZCGPhMB3TvSM+D9qDy7UL4HbXQ4gLY04iQD/D4
         rzM/MnuhkhoVouoGtcGYOuY7oXnaIxFIGkJtNVEfqiEIRFh+71uZkOeY1/oUeyBrO8ch
         sd2w==
X-Gm-Message-State: AOAM533eE8dGpT4/wkZ8qNs87FONRj/q+1ohP+Me3kiudelD8sBNS7LT
        vAUryrOqih39UwT0IKlH9RSfbBnJC3sypHrXAZ9lAx7phNMs4Q==
X-Google-Smtp-Source: ABdhPJzSDKZ9E7b6WBTtlJaA2XJES04mKZ8iM3gar8qhaJxD2tF4SUTOGx27ZIuo07X/BEBOYPfdJIOX4TvDxpZ9/KI=
X-Received: by 2002:a05:6638:411f:b0:32e:a114:54e with SMTP id
 ay31-20020a056638411f00b0032ea114054emr15534111jab.82.1653592555258; Thu, 26
 May 2022 12:15:55 -0700 (PDT)
MIME-Version: 1.0
From:   John Mazzie <john.p.mazzie@gmail.com>
Date:   Thu, 26 May 2022 14:15:44 -0500
Message-ID: <CAPxVHd+hHXFjc3DvK0G5RWnLChOTbGXHZp_W-exCE6onCMSRuA@mail.gmail.com>
Subject: BPF_CORE_READ issue with nvme_submit_cmd kprobe.
To:     bpf <bpf@vger.kernel.org>,
        "John Mazzie (jmazzie)" <jmazzie@micron.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

While attempting to learn more about BPF and libbpf, I ran into an
issue I can't quite seem to resolve.

While writing some tools to practice tracing with libbpf, I came
across a situation where I get an error when using BPF_CORE_READ,
which appears to be that CO-RE relocation failed to find a
corresponding field. Compilation doesn't complain, just when I try to
execute.

Error Message:
---------------------------------------------
8: (85) call unknown#195896080
invalid func unknown#195896080

I'm using the Makefile from libbpf-bootstrap to build my program. The
other example programs build and execute properly, and I've also
successfully used tracepoints to trace the nvme_setup_cmd and
nvme_complete_rq functions. My issue appears to be when I attempt to
use kprobes for the nvme_submit_cmd function.

In the program I'm attempting to trace the nvme_command structure to
get the opcode of the command in the function nvme_submit_cmd. I'm
using Rocky Linux (RedHat based distro) with their kernel version of
4.18. I verified the structures and interfaces in the source code, vs
the default 4.18 version of the kernel and made the appropriate
changes.

traceopcode.bpf.c
---------------------------------------------
#include "vmlinux.h"
#include <bpf/bpf_helpers.h>
#include <bpf/bpf_tracing.h>
#include <bpf/bpf_core_read.h>
#include "traceopcode.h"

char LICENSE[] SEC("license") = "Dual BSD/GPL";

struct {
    __uint(type, BPF_MAP_TYPE_RINGBUF);
    __uint(max_entries, 1024 * 1024);
} ring_buffer SEC(".maps");

struct nvme_common_command {
    __u8         opcode;
} __attribute__((preserve_access_index));

struct nvme_command {
    union {
        struct nvme_common_command common;
    };
} __attribute__((preserve_access_index));

SEC("kprobe/nvme_submit_cmd")
int BPF_KPROBE(nvme_submit_cmd, void *nvmeq, struct nvme_command *cmd,
bool write_sq)
{
    struct opcode_event *e;

    e = bpf_ringbuf_reserve(&ring_buffer, sizeof(*e), 0);
    if (!e)
        return 0;

    e->opcode = BPF_CORE_READ(cmd, common.opcode);
    //e->opcode = cmd->common.opcode;
    bpf_ringbuf_submit(e, 0);

   return 0;
}


traceopcode.h
---------------------------------------------
#ifndef __TRACEOPCODE_H
#define __TRACEOPCODE_H

struct opcode_event {
    __u8 opcode;
};

#endif


My userspace code is basically the same as the bootstrap example, with
a modification to the handler that just prints out the opcode from the
opcode_event structure. My guess is that I have some problem with how
I'm defining the structs that I'm using for nvme_command, as they
aren't part of vmlinux and need to be defined in my bpf program.

Any help or guidance would be appreciated.

Thanks,
John Mazzie
