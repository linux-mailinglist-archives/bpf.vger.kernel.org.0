Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33A0E672AA4
	for <lists+bpf@lfdr.de>; Wed, 18 Jan 2023 22:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjARViQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 Jan 2023 16:38:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbjARVh7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 Jan 2023 16:37:59 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D763193F6
        for <bpf@vger.kernel.org>; Wed, 18 Jan 2023 13:37:41 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id 20so420812plo.3
        for <bpf@vger.kernel.org>; Wed, 18 Jan 2023 13:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uci-edu.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t88PdcaW1Av8fLqRcJKlKv/cbQEKaKEYne46qBO5+ko=;
        b=Tpc/otL0uQa5gXvnGNbWyo6g4f8ipth4ARF+Z3/yGoNZxvb7Zga1KdFMCUGjEcsZO3
         OARPYyTqo8GRL5gzayA5VSj90VDuMJobzTc7SOSV2QL7fMfArnN74yoSu2VMJIIn8iFG
         2fwP2jU4a4kpHQBnDrhdIw1u3kTtpY3nw8WDp+d60usyHrbqF8C/lXJhmtEVmmOIarai
         Wl2syVD/BsG2hiYGkNmWUBRLT+wBp6s5K5ogsXW8nnuWwHd0aHuQwNYsQLQxR1VM5wcj
         Z68NSE1xO+X/kNkfLkEYLKCkvnQ8LOULaANeL8dT9+jQi3FD2e4cJfmi5V5wLBy2HCNv
         wq5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t88PdcaW1Av8fLqRcJKlKv/cbQEKaKEYne46qBO5+ko=;
        b=Txcwpkqb1QsgeH9jtvmmmBmPJCWvvo0ys+xww1YvjK8w7uBTVnWdn8MSLndsK6/n07
         HkS80XE73Ni5f/17CQBBdU1KOcH993WvgqgTleSletUnkqY5LMsUxSXtqPk6/VP8Pr7U
         dyJHNVpw8hz5OCyv6b3QAGLp2ITizeasElshZmds4meGUfDw651ZKw+LTo9+IqlCUiZW
         9poaHXptfjCZt5EaTIOluNepTZmluy70u14mBcOT9lhohZNvls93ZCIaFPKJtpc8zuu6
         iOmVUeLcYk7D3k76mpgnseIwcO70JEIbOM7q1vUWCD0JXVjfAqTG2Ju3D/6cOzOAHeSY
         hfRg==
X-Gm-Message-State: AFqh2kqKeYtCQ1a3+jZ2EBZc3/9kFBxbNTeOPapm8AygvD8azacmuTCX
        Dvm4V1J7xejMxdH9a4MuVZx81w==
X-Google-Smtp-Source: AMrXdXsyZgodnBWi9AKe9Efd5FCxEgFOvloCOqvrprqGog92BdNGAIeRZc/fAPaAxCbgxEsFCEIRiA==
X-Received: by 2002:a17:902:d3c9:b0:189:4bf4:2cfc with SMTP id w9-20020a170902d3c900b001894bf42cfcmr8986503plb.31.1674077860696;
        Wed, 18 Jan 2023 13:37:40 -0800 (PST)
Received: from trusslab-Super-Server.ics.uci.edu (truss.ics.uci.edu. [128.195.4.119])
        by smtp.gmail.com with ESMTPSA id k6-20020a170902c40600b0017f8094a52asm6563468plk.29.2023.01.18.13.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 13:37:40 -0800 (PST)
From:   Hsin-Wei Hung <hsinweih@uci.edu>
To:     alexei.starovoitov@gmail.com
Cc:     alan.maguire@oracle.com, andrii@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, davem@davemloft.net, dylany@meta.com,
        gregkh@linuxfoundation.org, hsinweih@uci.edu,
        keescook@chromium.org, kernel-team@fb.com, peterz@infradead.org,
        riel@surriel.com, rostedt@goodmis.org, tglx@linutronix.de,
        torvalds@linuxfoundation.org, vegard.nossum@oracle.com,
        x86@kernel.org
Subject: Re: [PATCH bpf 1/2] mm: Fix copy_from_user_nofault().
Date:   Wed, 18 Jan 2023 13:32:02 -0800
Message-Id: <20230118213202.3859786-1-hsinweih@uci.edu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230118051443.78988-1-alexei.starovoitov@gmail.com>
References: <20230118051443.78988-1-alexei.starovoitov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

After applying the patches, running the fuzzer with the BPF PoC program no 
longer triggers the warning.

Tested-by: Hsin-Wei Hung <hsinweih@uci.edu>
