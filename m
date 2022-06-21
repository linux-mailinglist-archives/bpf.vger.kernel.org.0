Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5811C55293E
	for <lists+bpf@lfdr.de>; Tue, 21 Jun 2022 04:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235637AbiFUCJU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Jun 2022 22:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245706AbiFUCJT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Jun 2022 22:09:19 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19281EAE1
        for <bpf@vger.kernel.org>; Mon, 20 Jun 2022 19:09:18 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id w19-20020a17090a8a1300b001ec79064d8dso8990282pjn.2
        for <bpf@vger.kernel.org>; Mon, 20 Jun 2022 19:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=hXyvm21Km9+Ubuu/B7UwWptspXexbq1fGQvRwZRgWsQ=;
        b=l6tis0g9SqArrmZndxUles/PAxKpblzVmTLr+cZjBHMSzEMBbaOLM5saKdYcu/uZiK
         ZPXast3fAYjB/6jFwgXw5xTamMx2cEaf+QVVc0Qt3oOs3EmTKDwwR7jQRg7Et5tQYo/c
         742T6ucg79YDV2CJx2I4/UwW/FNx7G7iA/WSbtIWif8l5NFo62i0YNb97CIWaMf+o8FU
         /2wVEU1edwZu05/+0BciYQNI7pxwcES1MUL2ZMCOtBwcm5FBvOG9xYq+9yUrSdbVZJBy
         xJh8cJBp1KWV3OUAgaHE0xyKLkt+w4YNwHZFAHqGjEgladkhL/i1fQys+up1dkR2st9M
         sX1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=hXyvm21Km9+Ubuu/B7UwWptspXexbq1fGQvRwZRgWsQ=;
        b=yXzB5qgklK3Jyr85x80Y1zzcBY96+qc5p+KL3AH59bHOYw2gZqS3otcnqz89A/tvaN
         k3lhNpZzqAIZbPoF1GdFBq+i/yKEwdm8QES2vWlL3PN1jgCgZ1TmlLeKCHfi9+EaAniZ
         mI+6NuhKX6f6HwCxOrxqAU78o+GcwlVqzCKyVJI1PmEGbEZryM3UTYJOdTPNhSGcFrWN
         G04WdSKjhR7bR9OArqwOa1OygJgH95kdf9rhEISGyeaTe00vVHQjBrl1zvXwmKbBnJG9
         0bC/lqRCEMDa3BbKwME0xPYNDr6g98ejp9LK70hHpsy5wXPRS+gKJ1np3m9MnEldn1Zt
         9j1g==
X-Gm-Message-State: AJIora83eIfhu/Zn8VJs+gRJzSRyA+cnnYT7+AlGYI+xKNR7bpSymq2l
        pNI7iyTVoOPL6rdhHT9lr80ZBM3HNhU=
X-Google-Smtp-Source: AGRyM1s/K0ACIWcZRiu/krsa7DUs7uxJPKoYq/BlADh4qrI/GpYJ/C2FJofcZggsv5Pnm3seRYTqpg==
X-Received: by 2002:a17:902:b597:b0:168:d8ce:4a63 with SMTP id a23-20020a170902b59700b00168d8ce4a63mr27017402pls.57.1655777358230;
        Mon, 20 Jun 2022 19:09:18 -0700 (PDT)
Received: from Laptop-X1 ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id z14-20020aa7990e000000b00525184bad54sm4233564pff.126.2022.06.20.19.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 19:09:17 -0700 (PDT)
Date:   Tue, 21 Jun 2022 10:09:11 +0800
From:   Hangbin Liu <liuhangbin@gmail.com>
To:     Quentin Monnet <quentin@isovalent.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jesper Dangaard Brouer <jbrouer@redhat.com>,
        Yauheni Kaliuta <ykaliuta@redhat.com>,
        Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Subject: How about adding a name for bpftool self created maps?
Message-ID: <YrEoRyty7decoMhh@Laptop-X1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Quentin,

When I using `bpftool map list` to show what maps user using. bpftool will
show maps including self created maps. Apart from the "pid_iter.rodata",
there are also array maps without name, which makes it hard to filter out
what maps user using. e.g.

# bpftool map list
63: array  flags 0x0
         key 4B  value 32B  max_entries 1  memlock 4096B
65: array  name pid_iter.rodata  flags 0x480
         key 4B  value 4B  max_entries 1  memlock 4096B
         btf_id 98  frozen
         pids bpftool(10572)
66: array  flags 0x0
         key 4B  value 32B  max_entries 1  memlock 4096B

So do you have plan to add a special name for the bpftool self created maps?
Or do you know if there is a way to filter out these maps?

Thanks
Hangbin
