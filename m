Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 213B54BF047
	for <lists+bpf@lfdr.de>; Tue, 22 Feb 2022 05:10:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234518AbiBVDoI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Feb 2022 22:44:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbiBVDoH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Feb 2022 22:44:07 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4E1245B8
        for <bpf@vger.kernel.org>; Mon, 21 Feb 2022 19:43:43 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id h125so15937939pgc.3
        for <bpf@vger.kernel.org>; Mon, 21 Feb 2022 19:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=vvkswdZF6O2TUzFPMsuepKOYPFrp4RKzRRPGXGNl7Ic=;
        b=Hz3t+A4w8mHUZkuEp6s1vIkIqnC31Oj4dBKBG2EoZPFDL6aIy6DtbrR/j9NNo8lEnL
         q4ZAIseJBBEq4ukVNRvYk7AdYC6aQ26EX4GnwyeTWdhlLsu6t5RKNEkxKBknFmGG6vfI
         CmxRzXVBR59du+yButKlX5DX+0AKvokqTySo3wKWTmW8rWXxy7xvIpH46k7C7vzAYLjm
         IeIvLFsyZ1vAl+VQ8ajKBQ0NEi5hKHL68fWVkeEMi8a/6Ypz0KDSaoFgK3hdidbKvH1z
         tyKCJWCdnKeuM4+KjzcIXL0ThuqZHjCfHBEBtWqcGxk4Sj+sPMyGlBuvaNFoOHrOpctM
         kwNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=vvkswdZF6O2TUzFPMsuepKOYPFrp4RKzRRPGXGNl7Ic=;
        b=6t+h2Ri6zhqjsE4rrOu3a4MlfU5WdXB9isr8EKeOyVW6XXCmqTDhrYhfZTVqA3tVtA
         nkv+gJJV9/vuZwNWfrJ19hf8GSOYZvMNXPLQnx/4Ef8rgb3GNEKyvx6XO+RdWCesoFgE
         1vnoJYAs6A8tskSPH+RYKCoKvps/W3Jqm3dpIw1vcnVBRp2eX6LFNKhFf7D5qbUe5DjQ
         iIUyefIxJo8ZJ96dTxJBKxocCQZaLZuCm90oNairKN4laU7qZbqVp/tAR5aGfqGZbPMu
         YiCN3LuUV2u6IC9pTxc/wITPIktIt+bCTYOAMZOj+Ejl/StpJrykKLoFcuc7HTgeiFrN
         hYzg==
X-Gm-Message-State: AOAM533R56bFnTT4OuvWSqq5O2OzEX/bREYwSpFOTFGXVDtAS8ulCz45
        7R1n0TETIDQbU69GActk1IoQDIHRU598u9QNoFVHq0HAGr7rt3pz
X-Google-Smtp-Source: ABdhPJxmLuTHwoRjPIUfxHW+Z3FF77kuvtIrl7rwaYhOpMBa19wuzhJngKveGPuCx3bVbvZdCe1QOGhkEiiYjmgE6jE=
X-Received: by 2002:a63:1760:0:b0:374:6621:9236 with SMTP id
 32-20020a631760000000b0037466219236mr2971419pgx.7.1645501422958; Mon, 21 Feb
 2022 19:43:42 -0800 (PST)
MIME-Version: 1.0
From:   Li Qiang <liq3ea@gmail.com>
Date:   Tue, 22 Feb 2022 11:43:06 +0800
Message-ID: <CAKXe6S+B9+uH3R4qiNx68yZwX32iaAC6g92x7jS9JodNRjaAyg@mail.gmail.com>
Subject: How to get the device number of 'bpf_get_ns_current_pid_tgid' helper
To:     bpf@vger.kernel.org
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

Hello all,

As we know, to call 'bpf_get_ns_current_pid_tgid' helper we need dev
and inode number. The inode number is quite easy to get by 'ls -lh
/proc/xx/ns/'. So how can we get the device number easily in practice?
the kernel test just uses 0 to test.

Thanks,
Li Qiang
