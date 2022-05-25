Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F53B533A4B
	for <lists+bpf@lfdr.de>; Wed, 25 May 2022 11:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbiEYJyA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 May 2022 05:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiEYJx7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 May 2022 05:53:59 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C53783389E
        for <bpf@vger.kernel.org>; Wed, 25 May 2022 02:53:57 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id w14so35094990lfl.13
        for <bpf@vger.kernel.org>; Wed, 25 May 2022 02:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=exein.io; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=19ACUZNmVFF0eEBc/MLM0oKPVOi7r9yqDs83zxO2K3U=;
        b=OMGPUOeS3/M+klN/zfobP2ZVKCHtH10u3pI0jkXWknJ3DY/U69OWMGI4X81yIzlFBY
         zZvcGLEhPaFNEqyI6GO7WgfTV5f/g1QSI37yNA4ZIRA7e76rCGnterdEQFou+TGum8Iw
         tojS/bPd3tVonxnvpSKTE1Pm/8Tcjvdc2+DxQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=19ACUZNmVFF0eEBc/MLM0oKPVOi7r9yqDs83zxO2K3U=;
        b=Et26hfCi2rLLyk4CVXCI4Kp339iTaVxkJhl2RCb0ImxYTY+CN/p+1NNXX7EivrO07s
         e3JOzie3c9zNCIp+q7+SjD19x2G0mdOXCjF3N6Hz0sTxzcxcDVPTCPoDc6dJUmav/qbN
         zUiiH0D1O6k67Y1agoK37eseXJj5Nm/Um07S/+gFoP3mHDlVon4jtBid24FM0FeZhl1f
         EIQECoDhxadoJVvonZEWpM2vfRNe+l22BxRUJRUmtjeStPQRwkNo9/EtjULpkjtrhh7E
         SCqiPh/Y8w/pgbTfPxSfn++3a5RTkc0blcRtS6aiTr28pSA5BUZsDzea/Ek3gr1QvUor
         JDvQ==
X-Gm-Message-State: AOAM532KphL6cQpmyRkqoUWZ14NyhCC6gE/qo8NFm39zk0SbjO2HPnLW
        huCaHVCyWY1R7XmWGF5Ig1bnrN6u0eBxX7Rq6Ah3X2ANhJhozfhu
X-Google-Smtp-Source: ABdhPJzG7/QWK4QdUP9H43MVf1D7Q+tdu6tGhi+o24xEzN70Ha3F1wgqzSo8jmlNIPdMrXiFV0GUXsTY/mPMpiEHQlg=
X-Received: by 2002:a05:6512:50d:b0:478:5590:de00 with SMTP id
 o13-20020a056512050d00b004785590de00mr16846111lfb.644.1653472436128; Wed, 25
 May 2022 02:53:56 -0700 (PDT)
MIME-Version: 1.0
From:   Matteo Nardi <matteo@exein.io>
Date:   Wed, 25 May 2022 11:53:45 +0200
Message-ID: <CALo96CRkg4eH=Ee0qvx3YigyP9mPyzz6vhTtpqNN1n4mvUQUPA@mail.gmail.com>
Subject: Relocation error on 32 bit systems of longs from vmlinux.h
To:     bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This program will compile and run fine on my 64 bit system, but it
will fail with a relocation error on 32 bit systems:

SEC("tp/raw_syscalls/sys_enter")
int sys_enter(struct trace_event_raw_sys_enter *ctx) {
        long int n = ctx->id;
        bpf_printk("hello world %d", n);
        return 0;
}

```
libbpf: prog 'sys_enter': relo #0: insn #0 (LDX/ST/STX) accesses field
incorrectly. Make sure you are accessing pointers, unsigned integers,
or fields of matching type and size.
libbpf: prog 'sys_enter': BPF program load failed: Invalid argument
libbpf: prog 'sys_enter': -- BEGIN PROG LOAD LOG --
R1 type=ctx expected=fp
; long int n = ctx->id;
0: (85) call unknown#195896080
invalid func unknown#195896080
processed 1 insns (limit 1000000) max_states_per_insn 0 total_states 0
peak_states 0 mark_read 0
-- END PROG LOAD LOG --
libbpf: failed to load program 'sys_enter'
libbpf: failed to load object 'bootstrap_bpf'
libbpf: failed to load BPF skeleton 'bootstrap_bpf': -22
Failed to load and verify BPF skeleton
```

I'm cross-compiling using a Yocto build. I've reproduced this both
with arm and x86.

From my understanding, the issue comes from the `long int` in
`trace_event_raw_sys_enter`, which is 64 bit in the compiled eBPF
program, but 32 bit in the target kernel.

struct trace_event_raw_sys_enter {
        struct trace_entry ent;
        long int id;
        long unsigned int args[6];
        char __data[0];
} __attribute__((preserve_access_index));

Indeed, manually changing the `id` definition  in `vmlinux.h` will fix
the relocation error:

struct trace_event_raw_sys_enter {
        u32 id;
} __attribute__((preserve_access_index));


"Q: clang flag for target bpf?"[0] hints that using a native target
could help, but I guess that would completely break CORE relocations
since `preserve_access_index` is a `-target bpf`-specific attribute,
right?

Am I missing something? If I had to fix the issue right now I would
replace all long definitions in `vmlinux.h` to u32 when targeting 32
bit systems. Could `bpftool btf dump` handle this?
We're using eBPF on embedded systems, where 32 bit is still fairly common.

Thanks.

Best regards,
Matteo Nardi

[0] https://www.kernel.org/doc/html/latest/bpf/bpf_devel_QA.html#q-clang-flag-for-target-bpf
