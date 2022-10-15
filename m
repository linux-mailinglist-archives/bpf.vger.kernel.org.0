Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5159F5FFB4D
	for <lists+bpf@lfdr.de>; Sat, 15 Oct 2022 18:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbiJOQxp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 15 Oct 2022 12:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiJOQxo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 15 Oct 2022 12:53:44 -0400
X-Greylist: delayed 336 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 15 Oct 2022 09:53:43 PDT
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A754CA08
        for <bpf@vger.kernel.org>; Sat, 15 Oct 2022 09:53:42 -0700 (PDT)
Message-ID: <3f82d342-1c0f-32c4-996e-cc063f872673@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
        t=1665852484;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=4HzSzG87ch7J3isCoCAj8oeTbGv/95dtF+ADbANpoo8=;
        b=PcZ4ON2FzZ/PszSuw1ENvKH2deE5aJEjuXIOzDmvV+E2jnR/9ZwaQNPfFCG18xYbCAB11a
        SOVJi+yOoOY7NSKD6g4zXOk3frUhAdbnybuiuJSv99rru3kKHFb0Cr06+zYQv6rTeSUlas
        nJ/bYefi7EoVyoX64e5RcfiKkwxaQC0eflIhH8D/COE/iKOSJhcmvGcV9UXvMctDB0dPAb
        L6fWwObVPe84ZHu9c2+3dqi4r64HluKdddYJQdact9FQRw+HX9q9ySNTAswsl4m9WOymcU
        0DlTSoSDgWaT96yWaojw282hNPkP8QQnEPOoOutdLWjzU8FcnjgG+PDLfPFWRQ==
Date:   Sat, 15 Oct 2022 18:48:03 +0200
MIME-Version: 1.0
Content-Language: en-US
To:     bpf@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Bernhard Landauer <bernhard@manjaro.org>
From:   =?UTF-8?Q?Philip_M=c3=bcller?= <philm@manjaro.org>
Subject: [kernel] 5.10.148 / 5.19.16 - pahole 1.24: BTFIDS vmlinux,FAILED:
 load BTF from vmlinux: Invalid argument
Organization: Manjaro Community
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=philm@manjaro.org smtp.mailfrom=philm@manjaro.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi all,

I just got the following error for 5.10.148 and 5.19.16 when compiling 
with pahole 1.24 on CONFIG_DEBUG_INFO_BTF=y:

   BTFIDS  vmlinux
FAILED: load BTF from vmlinux: Invalid argument
make: *** [Makefile:1168: vmlinux] Error 255
make: *** Deleting file 'vmlinux'

similar to: 
https://lore.kernel.org/bpf/20220825171620.cioobudss6ovyrkc@altlinux.org/t/

For 5.19 I applied the following patch:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/plain/releases/5.15.66/kbuild-add-skip_encoding_btf_enum64-option-to-pahole.patch

I wonder what is needed to get 5.10 kernel series compiled and if 5.19 
really doesn't support enum64.

-- 
Best, Philip
