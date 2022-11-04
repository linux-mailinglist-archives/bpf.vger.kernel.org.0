Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFAB5618FE8
	for <lists+bpf@lfdr.de>; Fri,  4 Nov 2022 06:16:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbiKDFQs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Nov 2022 01:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiKDFQq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Nov 2022 01:16:46 -0400
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AF250658C
        for <bpf@vger.kernel.org>; Thu,  3 Nov 2022 22:16:45 -0700 (PDT)
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id C2F4872C983;
        Fri,  4 Nov 2022 08:16:44 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id A03874A472A;
        Fri,  4 Nov 2022 08:16:44 +0300 (MSK)
Date:   Fri, 4 Nov 2022 08:16:44 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>
Subject: bpf: Is it possible to move .BTF data into a module
Message-ID: <20221104051644.nogfilmnjred2dt2@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,LOCALPART_IN_SUBJECT,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

We need to reduce kernel size for aarch64, because it does not fit into
U-Boot loader on Raspberry Pi (due to it having fdt_addr_r=0x02600000)
and one of big ELF sections in vmlinuz is .BTF taking around 5MB.
Compression does not help because on aarch64 kernels are
uncompressed[1].

Is it theoretically possible to make sysfs_btf a module?

Yes this will reduce tracing at boot times, but at least it will give
option for occasional tracing after boot.

Thanks,

[1] https://www.kernel.org/doc/Documentation/arm64/booting.txt #3.
