Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F338F651FE2
	for <lists+bpf@lfdr.de>; Tue, 20 Dec 2022 12:45:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiLTLpq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Dec 2022 06:45:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbiLTLpp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Dec 2022 06:45:45 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872A92632
        for <bpf@vger.kernel.org>; Tue, 20 Dec 2022 03:45:44 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id v126so12671996ybv.2
        for <bpf@vger.kernel.org>; Tue, 20 Dec 2022 03:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cbLZxwj1suWvLzcAmclqCemqFHlImZOdGCCJJQp5PcM=;
        b=AyOhdTXBrvLBDL7ryziaj3Rj6PGMFE124s/iC1JzbH8sm66vdIq1jsBhOwGHbOcY0v
         ksQdRXjgFJ6Ej5yxdPK1TDrTkJknyH/J0B63w9hlCemZa1QGjD7gdI+upYwvON0EgjyK
         JPjO04uaroVmmKx4r6Zcs9ztw7r4nKHwaiZ5OMn9JIN0unZsmG/VBcKAa4xL0IQn1fbu
         DG+Bn4O8UUFB9bT6rs+GmdUSSmE9qezRrewd8xzyx+5/c3C9D46Q+cYn8XmNJwnyitxz
         b03R38v+TChr6uxnr1OefdWlLMneBzLEQiIFTeG8IttzqV62gCIE6/Ttsd2y+K2Yhk0J
         vckg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cbLZxwj1suWvLzcAmclqCemqFHlImZOdGCCJJQp5PcM=;
        b=G7zV3HePqhEcNBQaYz26NE197b4XrRXHfA/X2Db5fhbjeZKiM7EvRfpIzlBGKpoLoC
         K+uEZxD3N43T8FPnOB+pBdxiq4bQE8sQveCTLzlPNzJ0wKt/lkKJDfylLNGqGNCDpiVC
         c7K0GYC05nVpCAHhD8oO/W7UCSCtWe59lPJeiCYHpky0JthHyHlv/Cxg/KX8aPcyuY3E
         5d0c0lQJqcvwJdIryxm4OhtoPp9ecwg3xUzNjYeW96Clc38N0FxMawO0JspdPN89mD30
         S35zD5WFhv+qcA71wR7YeKm6zZO7nrflFG6XhKsQHlzyPib+crQwvdSwr+E9vEV2CGPu
         P+Dw==
X-Gm-Message-State: AFqh2kqurX0auUd8n6w83fWmJpX4RhrGvodKCfqtmamsv5c5E+lfRKGp
        S5Muhd6Zi6CvXlRPMUn+muEKjjyBRCaDv0Ofob0hCmipPnjDT/Kj
X-Google-Smtp-Source: AMrXdXvK4fqXeDst8MA/krmpvlT3l2cjq4P3WbMg9QHP+s4O/mXfhT/2TgnALvt8DfQrJV7YTKEjcZLRiYeJuMROuYQ=
X-Received: by 2002:a25:31d7:0:b0:73f:fb7d:400 with SMTP id
 x206-20020a2531d7000000b0073ffb7d0400mr1572507ybx.352.1671536743465; Tue, 20
 Dec 2022 03:45:43 -0800 (PST)
MIME-Version: 1.0
From:   SuHsueyu <anolasc13@gmail.com>
Date:   Tue, 20 Dec 2022 19:45:31 +0800
Message-ID: <CAEc2n-vmWk6+hG-fcqvMdeG-hSyuFoHv9R79U5MjnOU7nXQSpw@mail.gmail.com>
Subject: Support for gcc
To:     bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello, I use gcc 12.1.0 to compile a source file:
t.c
struct t {
  int a:2;
  int b:3;
  int c:2;
} g;
with gcc -c -gbtf t.c
and try to use libbpf API btf__parse_split, bpf_object__open, and
bpf_object__open to parse and load into the kernel, but it failed with
"libbpf: elf: /path/to/t.o is not a valid eBPF object file".

Is it wrong for me to do so? Due to some constraint, I cannot use
clang but gcc. How to parse and load gcc compiled object file with
libbpf?
