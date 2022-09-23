Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94E445E85E7
	for <lists+bpf@lfdr.de>; Sat, 24 Sep 2022 00:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbiIWWcy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 23 Sep 2022 18:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiIWWcx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Sep 2022 18:32:53 -0400
Received: from mail-yw1-x1144.google.com (mail-yw1-x1144.google.com [IPv6:2607:f8b0:4864:20::1144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF0D121127
        for <bpf@vger.kernel.org>; Fri, 23 Sep 2022 15:32:53 -0700 (PDT)
Received: by mail-yw1-x1144.google.com with SMTP id 00721157ae682-3452214cec6so13653287b3.1
        for <bpf@vger.kernel.org>; Fri, 23 Sep 2022 15:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=InBjFEKTHbPX5Dd0F3o2or/MjP7qgqX5pNvRGqdx+Wg=;
        b=B7x+sso47zGlP2GGaHE7jontTQM32XayNvwH1YxH1L093GTlvG3ocxrXAcfVr9CLPH
         FnYriyrlw1omytZe4ldaM29CEuWPr/OMjplCZwLQZqSr4KQGHyG4hYeK5JMvnuTL6rzW
         YSY6jLyqv7gqtTVmky2ixY2Bo23zYRx8gJ0X4R+E7I+bDn4yBMGrM89ritjq8bw7Ct9Z
         TBai97o2yJi+2eGxs9nRdHrWuX48s0wJk7qq1T2n7H61PdjPCPlsX8pvPE71JLHyxglx
         4eqvN+I1CC+tkWz2oj0o8HvmY5O8cbai5j9IloLQGWgGCA/nZMUoZS1ASIrSpr35BCwD
         4DvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=InBjFEKTHbPX5Dd0F3o2or/MjP7qgqX5pNvRGqdx+Wg=;
        b=h2qzJbXHMxLUYK/GDF/rTXOflyt2tEvwIBOcsRr9aqsSc8J7BKMObIAVmw6JJpClGT
         8RXaH+q638j7HZvPmq7anPFBZAlq5k+FcIH0wsMe0RilIl5iT/A9lASrusCsfHuQpkCq
         v5FuxTJ+ObI+wpCocGvSqHJ55v5NkoqyIyEO3mcmkEHJ70Ip0gY6mbzqiVo+gHVMYz1Q
         AvkHjeMBtWH3QUNdU9hc1npZniR3J03wzKO2JI/57tp7IzSyYzAEnYqnUAklCtJmxr/z
         EsXuy1sh/WyEOxLQAVlwLr5xCINT3gbEUSVPcJRL7rB5dzgzNXu8eAQ8RM/zt0o1CD+D
         +MSg==
X-Gm-Message-State: ACrzQf2L0YxmzQvEZd5ZNTz+Q53nO3CmYckE/Hv7RmJ6mI/xAlRnrKzl
        uKuBbCUPBXjHDaXAVftDy0qpy1sl3YgNLFPxD+wGeYlfDws=
X-Google-Smtp-Source: AMsMyM7Asc5SVpw4jRF4Vhfg23jKsi1PWLjV83nREAJjgtGsD5pgoIQXASc0WNExGMbffUYDB/IQH0LUgAP0mo0LQBk=
X-Received: by 2002:a81:3844:0:b0:344:bbce:3e23 with SMTP id
 f65-20020a813844000000b00344bbce3e23mr10376992ywa.8.1663972372137; Fri, 23
 Sep 2022 15:32:52 -0700 (PDT)
MIME-Version: 1.0
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Sat, 24 Sep 2022 00:32:16 +0200
Message-ID: <CAP01T752ZOX68V0hnCDAXT0tso7+i0BV0kDbXdvjYHNGM18Y2g@mail.gmail.com>
Subject: Possible bugs in generated DATASEC BTF
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, "yhs@fb.com" <yhs@fb.com>, andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,
For the following example:

kkd@Legion ~/src/linux
 ; cat bpf.c
#define tag __attribute__((btf_decl_tag("tag")))

int a tag;
int b tag;

int main() {
        return a + b;
}

--

When I compile using:
clang -target bpf -O2 -g -c bpf.c

For the BTF dump, I see:
[1] FUNC_PROTO '(anon)' ret_type_id=2 vlen=0
[2] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
[3] FUNC 'main' type_id=1 linkage=global
[4] VAR 'a' type_id=2, linkage=global
[5] DECL_TAG 'tag' type_id=4 component_idx=-1
[6] VAR 'b' type_id=2, linkage=global
[7] DECL_TAG 'tag' type_id=6 component_idx=-1
[8] DATASEC '.bss' size=0 vlen=2
        type_id=4 offset=0 size=4 (VAR 'a')
        type_id=6 offset=0 size=4 (VAR 'b')

There are two issues that I hit:

1. The component_idx=-1 makes it a little inconvenient to correlate
the tag applied to a VAR in a DATASEC. In case of structs the index
can be matched with component_idx, in case of DATASEC we have to match
VAR's type_id. So the code has to be different. If it also had
component_idx set it would be possible to make the code same for both
inside the kernel's field parsing routine.

2. The second issue is that the offset is always 0 for DATASEC VARs.
That makes it difficult to ensure proper alignment of the variables.

I would like to know if these are expected behaviors or bugs?
Thanks
--
 ; clang --version
Ubuntu clang version
16.0.0-++20220813052912+eaf0aa1f1fbd-1~exp1~20220813173018.344
