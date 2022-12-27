Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5E3E656C41
	for <lists+bpf@lfdr.de>; Tue, 27 Dec 2022 15:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiL0O4Q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Dec 2022 09:56:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiL0O4O (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Dec 2022 09:56:14 -0500
X-Greylist: delayed 2097 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 27 Dec 2022 06:56:11 PST
Received: from zproxy110.enst.fr (zproxy110.enst.fr [IPv6:2001:660:330f:2::c0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 195531005
        for <bpf@vger.kernel.org>; Tue, 27 Dec 2022 06:56:10 -0800 (PST)
Received: from localhost (localhost [IPv6:::1])
        by zproxy110.enst.fr (Postfix) with ESMTP id B133581863
        for <bpf@vger.kernel.org>; Tue, 27 Dec 2022 15:56:09 +0100 (CET)
Received: from zproxy110.enst.fr ([IPv6:::1])
        by localhost (zproxy110.enst.fr [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id MJ6kPXc_AMNk for <bpf@vger.kernel.org>;
        Tue, 27 Dec 2022 15:56:06 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
        by zproxy110.enst.fr (Postfix) with ESMTP id B2D2B8186D
        for <bpf@vger.kernel.org>; Tue, 27 Dec 2022 15:56:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 zproxy110.enst.fr B2D2B8186D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ip-paris.fr;
        s=DC645FAA-A815-11EB-B77D-7E405BEDA08B; t=1672152966;
        bh=ia7W5a6j8PLRZengpqY9tGesEfbcdOI7324QfaYeF2g=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=gD84oMicvCR/OwSTpbqAX3e6AeHMr5Qe2zILMjN5GmcXVXAkEVpAB/IH1sJcd2fMY
         iE4ilILmb+S51IPlZnP1xsPshlsYOI+zH2YAylC3irgiuSY08bNEIHWEnVFy/pF0g0
         54+GNGH3cSGk/kRAn/aTDLQtuon34aS5lS9UeD2CUks8nCBllOofLlkhuM7bkcDdfI
         AYYIMefXJVJ+5ezSR5nu/57v1Gvz7ptS/4Xr9Z0kDhLQXPgreGZkHxeyxpRpHNiW6W
         jF2B5PM2nDaCdChnlKJRVAVFq7KxV4fw0FmUEuathhQzhN9jekMonMA6uybl9HzMQE
         BaPIu5QdqpCCg==
X-Virus-Scanned: amavisd-new at zproxy110.enst.fr
Received: from zproxy110.enst.fr ([IPv6:::1])
        by localhost (zproxy110.enst.fr [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id IW38CV_Kb36U for <bpf@vger.kernel.org>;
        Tue, 27 Dec 2022 15:56:06 +0100 (CET)
Received: from zmail-ipp1.enst.fr (zmail-ipp1.enst.fr [137.194.2.209])
        by zproxy110.enst.fr (Postfix) with ESMTP id 9C2CA8186C
        for <bpf@vger.kernel.org>; Tue, 27 Dec 2022 15:56:06 +0100 (CET)
Date:   Tue, 27 Dec 2022 15:56:06 +0100 (CET)
From:   Victor Laforet <victor.laforet@ip-paris.fr>
To:     bpf@vger.kernel.org
Message-ID: <346230382.476954.1672152966557.JavaMail.zimbra@ip-paris.fr>
Subject: bpf_probe_read_user EFAULT
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [2a01:e0a:167:4b30:59f4:d29b:492c:23ec]
X-Mailer: Zimbra 9.0.0_GA_4485 (ZimbraWebClient - GC108 (Mac)/9.0.0_GA_4478)
Thread-Index: CTh8SLVBo7JCNuVixQsLX+5F99+EQA==
Thread-Topic: bpf_probe_read_user EFAULT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi all,

I am trying to use bpf_probe_read_user to read a user space value from BPF.=
 The issue is that I am getting -14 (-EFAULT) result from bpf_probe_read_us=
er. I haven=E2=80=99t been able to make this function work reliably. Someti=
mes I get no error code then it goes back to EFAULT.

I am seeking your help to try and make this code work.
Thank you!

My goal is to read the variable pid on every bpf event.
Here is a full example:
(cat /sys/kernel/debug/tracing/trace_pipe to read the output).

sched_switch.bpf.c
```
#include "vmlinux.h"
#include <bpf/bpf_helpers.h>

int *input_pid;

char _license[4] SEC("license") =3D "GPL";

SEC("tp_btf/sched_switch")
int handle_sched_switch(u64 *ctx)
{
  int pid;
  int err;

  err =3D bpf_probe_read_user(&pid, sizeof(int), (void *)input_pid);
  if (err !=3D 0)
  {
    bpf_printk("Error on bpf_probe_read_user(pid) -> %d.\n", err);
    return 0;
  }

  bpf_printk("pid %d.\n", pid);
  return 0;
}
```

sched_switch.c
```
#include <stdio.h>
#include <unistd.h>
#include <sys/resource.h>
#include <bpf/libbpf.h>
#include "sched_switch.skel.h"
#include <time.h>

static int libbpf_print_fn(enum libbpf_print_level level, const char *forma=
t, va_list args)
{
  return vfprintf(stderr, format, args);
}

int main(int argc, char **argv)
{
  struct sched_switch_bpf *skel;
  int err;
  int pid =3D getpid();

  libbpf_set_print(libbpf_print_fn);

  skel =3D sched_switch_bpf__open();
  if (!skel)
  {
    fprintf(stderr, "Failed to open BPF skeleton\n");
    return 1;
  }

  skel->bss->input_pid =3D &pid;

  err =3D sched_switch_bpf__load(skel);
  if (err)
  {
    fprintf(stderr, "Failed to load and verify BPF skeleton\n");
    goto cleanup;
  }

  err =3D sched_switch_bpf__attach(skel);
  if (err)
  {
    fprintf(stderr, "Failed to attach BPF skeleton\n");
    goto cleanup;
  }

  while (1);

cleanup:
  sched_switch_bpf__destroy(skel);
  return -err;
}
```
