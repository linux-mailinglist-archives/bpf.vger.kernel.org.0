Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 007DB32B327
	for <lists+bpf@lfdr.de>; Wed,  3 Mar 2021 04:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352458AbhCCDsA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Mar 2021 22:48:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1838595AbhCBK5T (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Mar 2021 05:57:19 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A49BC061756
        for <bpf@vger.kernel.org>; Tue,  2 Mar 2021 02:56:39 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id n132so9358485iod.0
        for <bpf@vger.kernel.org>; Tue, 02 Mar 2021 02:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6rLqwZB5xbSUAV3WyeFBF0fUQcYgz+j/K6pjLnieVK0=;
        b=cBjmGlJjC10wyXN/0DSZpNYCUKd3C9me9zxAssvVNPHZemGumg4fsdgXnbEjzmrNZ3
         sUJS6PzkkeUtFH8Rxw9ApwGdBaisv0At9dinrJmMgzSulVg49nWXiext9GJeWa8Z3hRR
         2h1Ve/i6mFpohW3L+EzwTG8LXoyc8BEiSXnqHV/GJOfSIflvWNpM/z5R9PMrv0ozQSfh
         YULLn7LtTNuHEyEXVMfm5XJmWb3FgC6PjfNMoqoeKGDzcD5TjCvEsZiKy0ZIqboBLWFS
         VgKSSUKShrp6vkWgcM0NPUQ7iOsSUuSnW/atwc1793XZ+x2yEadUiR2TZ2WluNWOd0k6
         W/sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6rLqwZB5xbSUAV3WyeFBF0fUQcYgz+j/K6pjLnieVK0=;
        b=FJ5nCyLvdOx4cxWd0Y8wFjxXxE7xSDxXH+VSZiP2VkTSDx1IAUQCeW9LcJqcryzzIx
         jptE7N6FwoAFoQesnZJv/uLcvy/ryVbN7xNYOaHdRPjTluipFD7TcGDhdtusqV1MMkjI
         lsbxaAno/4l+eNE4+FpixNoyLBfG1s3/K6jz5Wiu01h8xBJ27RzCQdYe9R/DmDMSK4D1
         WS72s6jF8EL+G2Ze4jkN5myNV9bF47ZFCrCVdr2Mb6VJo2GolrwydurT79NmUm//EVau
         O76N8Jp7mIu2csjAqAW/GawMIV72oD15ZHTaNUIElulxAuHDfCOfNtspXoy8yY55BWBf
         Vgfg==
X-Gm-Message-State: AOAM530huF73EiRWynsm7WMaX4w4fRM7sAJhy2Gdqd/v4vpi67vwLoLg
        gvcG+WnPE7tDukO5FsmqwmfVeZpI0nIaR15t5ujG/rIVlOJ9vg==
X-Google-Smtp-Source: ABdhPJyZT1B2v+Pw3N5owmkt610mkpu2OCoPpZoiL1hp0N/H6TxTOBDYGn7f1SU5u+SFKFgEN1JWW5yQqMhSmFqtAx0=
X-Received: by 2002:a02:c894:: with SMTP id m20mr8910081jao.80.1614682598163;
 Tue, 02 Mar 2021 02:56:38 -0800 (PST)
MIME-Version: 1.0
References: <20210302105400.3112940-1-jackmanb@google.com>
In-Reply-To: <20210302105400.3112940-1-jackmanb@google.com>
From:   Brendan Jackman <jackmanb@google.com>
Date:   Tue, 2 Mar 2021 11:56:26 +0100
Message-ID: <CA+i-1C3C7di0uEtMQHTbes_+BF8g8ZCN-bykkJLFHM1dk1ShTQ@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next] bpf: Explicitly zero-extend R0 after 32-bit cmpxchg
To:     bpf <bpf@vger.kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Martin KaFai Lau <kafai@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 2 Mar 2021 at 11:54, Brendan Jackman <jackmanb@google.com> wrote:
> base-commit: f2cfe32e8a965a86e512dcb2e6251371d4a60c63

Oh yeah, this is based on Ilya's patch [1]. Is that OK or should I
just resend it once that one is merged?

[1] https://lore.kernel.org/bpf/20210301154019.129110-1-iii@linux.ibm.com/T/#u
