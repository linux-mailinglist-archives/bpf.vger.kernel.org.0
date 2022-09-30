Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD1B5F1043
	for <lists+bpf@lfdr.de>; Fri, 30 Sep 2022 18:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbiI3QuV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Sep 2022 12:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiI3QuU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 30 Sep 2022 12:50:20 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C64C5BDE
        for <bpf@vger.kernel.org>; Fri, 30 Sep 2022 09:50:17 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id lh5so10184396ejb.10
        for <bpf@vger.kernel.org>; Fri, 30 Sep 2022 09:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=7WBDbmMtJnYv60tUXwGUUG1IdayB4PaLUeaQlJLLBwI=;
        b=BA8a/KSfTGF3q1tx8Tf27oqwzCFi7PU0h3EB9+tBtPeZKr+4x80tx/gwy29ytw/Bac
         Xvq9Cc/3yKvXoKB9D3zxvb+NIyaXJs9twgivEQ7qC5y5mxkdftTESytPIo4dGH2GdVX7
         saWDW95vYMbVnVcgFwvNTeHJeRq7ftAKzcM3OHkYQLUoUqGbrJC9Ky5b50dtZODXtZgL
         dYGXS4lg/9x3PsK/Yub52u+paSNxTgQDuO386AxL7efIBvaSlzDWapCQdYfwS9qM7b5J
         3/buMGCuflT4U00ElIXMwWIY9QDYaAmZB+WRO5dRNnbGdvnjEa2ZG9WMGzIBZYZff3hd
         tEZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=7WBDbmMtJnYv60tUXwGUUG1IdayB4PaLUeaQlJLLBwI=;
        b=pEsiIyeBqthNIbD6sUXOOkM9m+eJns4LIrZjK+wd8j1oQ2xNl4qwq5KjPAfkrdWVrG
         gwiHAfydumHVUvMtVj5gUqp58eR/KsFqxFUmr6YZWhbO5PMdyHkki/mx/xVgddxhCNF3
         wNAY87/3p5dIiiaunq2k8JS8D4CU+M5Cuj2XUvjuF9K4tkYdLSC/zDxfgOM6NeH1524M
         3Cy3zlC0wMPHDQ+wfYOcaibd6AxgGv+1dBGfs8FpUp+SzK/UtTMrplEvAOJDwJzX0u0V
         ONbItyg/wCFvpCZtoP6F9G1okGC0Ip3HS9+oAyLSjexi1jE5YCUBjEHIX4yTtyISPpSD
         l7BQ==
X-Gm-Message-State: ACrzQf1jfkYkyL7oE5Ln6VAtx8xPTK6fj/aVSTXGkX+wFvCsE5tu3HhH
        HWY4SfGcJHAcOMVTBXN72dhfEkLqT+q/nQ==
X-Google-Smtp-Source: AMsMyM7xR9nd0Cm15CgszDrYcxBL28XFWAQryl95+0lant2IKNWhvtweUFS3yRqIyUTiD3jDCx/J/g==
X-Received: by 2002:a17:907:980b:b0:783:6e65:c0c7 with SMTP id ji11-20020a170907980b00b007836e65c0c7mr6829925ejc.355.1664556615724;
        Fri, 30 Sep 2022 09:50:15 -0700 (PDT)
Received: from badger.. (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id d7-20020a170906304700b0073d9630cbafsm1395021ejd.126.2022.09.30.09.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 09:50:15 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
Cc:     Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 0/2] bpftool: fix newline for struct with padding only fields
Date:   Fri, 30 Sep 2022 19:49:16 +0300
Message-Id: <20220930164918.342310-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Everyone,

a small fix for bpftool, copying commit message from the first patch
as it explains the modification.

An update for `bpftool btf dump file ... format c`.
Add a missing newline print for structures that consist of
anonymous-only padding fields. E.g. here is struct bpf_timer from
vmlinux.h before this patch:

 struct bpf_timer {
 	long: 64;
	long: 64;};

And after this patch:

 struct bpf_dynptr {
 	long: 64;
	long: 64;
 };

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>

Eduard Zingerman (2):
  bpftool: fix newline for struct with padding only fields
  selftests/bpf: verify newline for struct with padding only fields

 tools/lib/bpf/btf_dump.c                         | 15 +++++++++------
 .../bpf/progs/btf_dump_test_case_padding.c       | 16 ++++++++++++++++
 2 files changed, 25 insertions(+), 6 deletions(-)

-- 
2.37.3

