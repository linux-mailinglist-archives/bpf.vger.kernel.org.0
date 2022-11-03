Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44EB1617C3E
	for <lists+bpf@lfdr.de>; Thu,  3 Nov 2022 13:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbiKCMMz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Nov 2022 08:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbiKCMMy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Nov 2022 08:12:54 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EAFF10F7
        for <bpf@vger.kernel.org>; Thu,  3 Nov 2022 05:12:50 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id a11-20020a05600c2d4b00b003cf6f5fd9f1so1060162wmg.2
        for <bpf@vger.kernel.org>; Thu, 03 Nov 2022 05:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:date:subject:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HdCS2Cyug92ZaoildN1oakf4WSLajPHqZNlQJx4j49g=;
        b=ZSItUGIQ52KsQeKgoLXU/ZQlM2zX9PL4HqByO4wXQIiPn1qufFLs47d0pbJbRnA6e9
         9dli3sxQy0y7S4QZHOe8dhfXOLNGz5nEv3Ds1poNQ0s69Bf0+mK/r5EL2jhCf6P1MjyI
         0r2rRXMnkv9Sp//kwkdOggN7yx+Bwn2UFSe3I4nd5hx1bVGUWZSCRVtNQoz9xjXLnl99
         ZA6hnjvZOazt+wLZIrt18pPb89wZMWAwXEO8jzTuTBQc2fMWyKhgdH2vuQAk2H6s8VKj
         iqNPnjDv5Eg6DNyUDwbx5/2OjDcxCgr+3UB/4jM2MTZAD50YK7t8yZKEMNr+eMy7raqX
         XzSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:subject:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HdCS2Cyug92ZaoildN1oakf4WSLajPHqZNlQJx4j49g=;
        b=MBQuAl0PR2rAcn/7ETQirO273YbOJQdwW4SBJ+RAlAQ8f3lcp65LfnbulSQoVOVWKA
         kEXeD495ACwi7HFKX/nVORZE1ytU9WXy9TF6Ae/udG44VkF+GbAYQqHtxTEbdM+0xmyX
         2Nism4Ca5yySuMn5exxKTxFG/cCxBDVzDhcPgkJ5fs1iUyNcLRFlDzulxa5wopkNP65n
         HC4G81czWcwtn6+CiTGnqSu4UIcLSROgMG2sKItcnoMBUYQ1mR30Oz0HKtbpaV3Vea0d
         KtEotMY6cVSm4vD8ZikakNA7jb3zwNFoa2j6X73ZBa8RFQDiI2tFjOTCJIqD2+lPqz5W
         aLdg==
X-Gm-Message-State: ACrzQf1Pwj958NKjTgp9MrXVMqJYK5AOFMzsr0sYjV8Ikba15BWl1BQZ
        q3hPcuBn1MD1yd45LTJIHQJf9GkwwtY=
X-Google-Smtp-Source: AMsMyM7OL1lY7jzHEpaWGoi/znZyThxx7G/LLQOdvv+cp4vSXw9/s8kOTdP5nBWp7HkvpxEwb3WkRA==
X-Received: by 2002:a7b:cc13:0:b0:3cf:8297:d61 with SMTP id f19-20020a7bcc13000000b003cf82970d61mr7983165wmh.160.1667477569025;
        Thu, 03 Nov 2022 05:12:49 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:b0e4:331f:74b1:5cc8])
        by smtp.gmail.com with ESMTPSA id bt12-20020a056000080c00b00236576c8eddsm747769wrb.12.2022.11.03.05.12.48
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 05:12:48 -0700 (PDT)
From:   Donald Hunter <donald.hunter@gmail.com>
To:     bpf@vger.kernel.org
Subject: Question: __u32 or u32 in BPF code
Date:   Thu, 03 Nov 2022 12:12:31 +0000
Message-ID: <m24jvgtexc.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (darwin)
MIME-Version: 1.0
Content-Type: text/plain
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

Should BPF code be using UAPI types such as __u32 or is it considered
acceptable to use kernel types such as u32? I ask because the helper
definitions that come from libbpf use the UAPI __u32 style types, but
the bpf-helpers(7) man page refers to the kernel u32 style types.

As I understand it, u32 et al are kernel internal type definitions that
should not leak into userspace which I believe extends to BPF
code. In order to use a kernel internal type, the BPF programmer would
need to define it themselves, or use a BTF generated vmlinux.h? Please
correct me if I am wrong, or oversimplifying things.

I think it would be useful to include a statement about UAPI types and
usage in BPF code somewhere in the documentation. Once I have an answer
to the question above, I am happy to work on a contribution to the
documentation.

A follow-on question is how to make things consistent across the UAPI
header files and the bpf-helpers(7) documentation. 
