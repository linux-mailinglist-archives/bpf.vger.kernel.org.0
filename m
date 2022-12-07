Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAFFA645138
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 02:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbiLGB24 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Dec 2022 20:28:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiLGB2y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Dec 2022 20:28:54 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE61D5131C
        for <bpf@vger.kernel.org>; Tue,  6 Dec 2022 17:28:53 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id w23so15648637ply.12
        for <bpf@vger.kernel.org>; Tue, 06 Dec 2022 17:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KarI+E2rLuZgQVykI4oySCt24fT7jaC4hWN4EqAZZKU=;
        b=mbjCtjTBHx59vPMEw8aS/NUv9MrhGYjaYmZ2qj05c61O9Bu8WCxC97s+hUwm1Qhv+m
         BaFCLS6VBuCv9Y8RjW7gmAo7RYKKcW7I2T/4S+SoCIJYbEG2S1I2A2JbLqDlw4WBGK5v
         k3yi4KmL+gSx/NKYvrED3eq5a9a1kYK2sVPB7fL3uHfwvSzijZyloESZGS5GyH4Wnwwt
         v2nGQD7+bsCZPy5qZ602iL8a55N3UxABZqpidFujndEPUugl6iHyjyh2HaQIwv/Yg+Ay
         PbnoNMEmZ1Mk9nS/3Vv0isYv7hW6B/dEPky/2Rj58+McCIY5HBGSW/xq4k29tuWuTINs
         BKvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KarI+E2rLuZgQVykI4oySCt24fT7jaC4hWN4EqAZZKU=;
        b=0Fnc7rj8eJubv/LcOp9zbu4hyNiKhhhZx1i01lHVIBU69wlCbkg5dliabKOXVDCpaT
         NzrUsaJ00QehIq+cZXe88zPbZFg8RjDzwXKXSg9NwD5WvmFA1lKzMnhnC8FnCoJnon6U
         HB9+YMAR8G+wr6iSKDm4jjTspwcx11711LA+i4NGuPZHL25Mo3qYZTuh9B/6dx3FHVq+
         iCiELqOs1WeO0659HNrPxtpPyifKRpJ9e7ApgOugoiUpvXXZkq2VAG9klHRtWPHef/sY
         7wQZUl/5yWXfPCSP5Rqcr04oJtJB8+PvBMWJaBZgZC5zgqocilrEWmdk8fymbEBzXNWS
         7BGw==
X-Gm-Message-State: ANoB5pkFQCtNPcYq95KtNsnZRSaUugQoOj7jDbRzfjtgZCqJM7sIWIce
        F/A/K/+pvaK6P3/Te9Cg+Ktfbz48/JU=
X-Google-Smtp-Source: AA0mqf6mZIuQ8+k/fByi9ehz/jStwjk5ZVo89mpvRWtOsEJx0W9kbe3KmXqUt0eezXdwYAUCoAfeLA==
X-Received: by 2002:a17:903:2616:b0:189:57f1:b8ec with SMTP id jd22-20020a170903261600b0018957f1b8ecmr62202933plb.4.1670376533087;
        Tue, 06 Dec 2022 17:28:53 -0800 (PST)
Received: from localhost ([98.97.38.190])
        by smtp.gmail.com with ESMTPSA id p14-20020a17090a348e00b00212daa68b7csm4066pjb.44.2022.12.06.17.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 17:28:52 -0800 (PST)
Date:   Tue, 06 Dec 2022 17:28:51 -0800
From:   John Fastabend <john.fastabend@gmail.com>
To:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net
Cc:     andrii@kernel.org, kernel-team@fb.com
Message-ID: <638fec5317631_b86520813@john.notmuch>
In-Reply-To: <20221206233345.438540-4-andrii@kernel.org>
References: <20221206233345.438540-1-andrii@kernel.org>
 <20221206233345.438540-4-andrii@kernel.org>
Subject: RE: [PATCH v2 bpf-next 3/3] bpf: remove unnecessary prune and jump
 points
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko wrote:
> Don't mark some instructions as jump points when there are actually no
> jumps and instructions are just processed sequentially. Such case is
> handled naturally by precision backtracking logic without the need to
> update jump history. See get_prev_insn_idx(). It goes back linearly by
> one instruction, unless current top of jmp_history is pointing to
> current instruction. In such case we use `st->jmp_history[cnt - 1].prev_idx`
> to find instruction from which we jumped to the current instruction
> non-linearly.
> 
> Also remove both jump and prune point marking for instruction right
> after unconditional jumps, as program flow can get to the instruction
> right after unconditional jump instruction only if there is a jump to
> that instruction from somewhere else in the program. In such case we'll
> mark such instruction as prune/jump point because it's a destination of
> a jump.
> 
> This change has no changes in terms of number of instructions or states
> processes across Cilium and selftests programs.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---

Thanks.

Acked-by: John Fastabend <john.fastabend@gmail.com>
