Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BBF44BF643
	for <lists+bpf@lfdr.de>; Tue, 22 Feb 2022 11:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbiBVKkO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Feb 2022 05:40:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbiBVKkN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Feb 2022 05:40:13 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10ED15B3C7
        for <bpf@vger.kernel.org>; Tue, 22 Feb 2022 02:39:43 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id w3so35827466edu.8
        for <bpf@vger.kernel.org>; Tue, 22 Feb 2022 02:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iSZ7owB2gUuqOrSqvnpRK+2UIoaov15FmTrWLpUdGKE=;
        b=ezrQQ0W18t+88vELRZuAPmyecKY2TVWWgdYURraKAuvYvLclD/RKXmGOrkxagO9yjq
         absYQsrUxUB61LU5NB5HWOd5rd2Ntz1FJ7ki0VsyrnTqH+iuSGvAB3i95Uh5n3hy1VLc
         GcVTA49M/jNaKtZaATBRgU+qwBYrd0C2361d4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iSZ7owB2gUuqOrSqvnpRK+2UIoaov15FmTrWLpUdGKE=;
        b=PoNUqUQYnjF8ZEAUDo94l2S8F+crrLlfg6u4fbKt80xUcGhpZz1CCUdXEdReZhqUpf
         BtvdrGH41XYdVQIKvEcWVaw3ruct+4n2ln+pVvHIFpgkP8wHYhwZnx/z1zPPNuhEp0cJ
         RPrOQ5yq6BokTGwRvKXgtK+0lvuiskMcA2Ef6T3eISGgwBLsn9gAkbRf8j0Pl3T7of18
         GmMYga9z1v4RjiBcHZ6u+PFzvIsKFwXIZK9ptUtbGQyzmu2QbIa+KZvpHIpsy//BBQhu
         7MbJSY5WMNv7sNQfHoSltoAPTUartLANdmxXQ4nrYMqUp9lOuGjIPY9BmDaiQLhaSkBT
         7TQA==
X-Gm-Message-State: AOAM533j9+u9q3+FPuNSqAiVtiQ83jJ6jcevpbW/NQpTFa5YNys/5Vgg
        h8V26+8qa51fr8MEMjb5UccX6g==
X-Google-Smtp-Source: ABdhPJwDvYUWhq2ou8TklkGmlXxt6MGo3BDRBHbetAFHiRtS/B84a9HtS2IX40IK3CYlOhLVnzi5QQ==
X-Received: by 2002:a50:9d06:0:b0:410:befc:dda7 with SMTP id v6-20020a509d06000000b00410befcdda7mr25787624ede.443.1645526381951;
        Tue, 22 Feb 2022 02:39:41 -0800 (PST)
Received: from altair.lan (7.e.a.a.9.9.f.b.0.5.5.2.a.2.1.a.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:a12a:2550:bf99:aae7])
        by smtp.googlemail.com with ESMTPSA id p4sm6144203ejm.47.2022.02.22.02.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 02:39:41 -0800 (PST)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     kernel-team@cloudflare.com, Lorenz Bauer <lmb@cloudflare.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH 0/2] Update L7 BPF maintainers / mailmap
Date:   Tue, 22 Feb 2022 10:39:23 +0000
Message-Id: <20220222103925.25802-1-lmb@cloudflare.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

I'm leaving my position at Cloudflare, so I'm stepping down from the
sockmap maintainership. I'm also adding a new email address where people
can reach me.

Best
Lorenz

Lorenz Bauer (2):
  bpf: remove Lorenz Bauer from L7 BPF maintainers
  mailmap: update Lorenz Bauers address

 .mailmap    | 1 +
 MAINTAINERS | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

-- 
2.32.0

