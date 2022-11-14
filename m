Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4F93628BA1
	for <lists+bpf@lfdr.de>; Mon, 14 Nov 2022 22:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236375AbiKNVy7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Nov 2022 16:54:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236128AbiKNVy6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Nov 2022 16:54:58 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AEE1E089
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 13:54:57 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id u7so8640800qvn.13
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 13:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=M9wvXa0+gkI3GP7IAXAzoJWVN3BZ6VG9Ukc2BUOIvbI=;
        b=hHT8k4aqbcWRal8nE1xl1s7t5Bt1U0OyMgTNqX0IoEwHx8aMIq+V68probfGfXI9vn
         kdr2UTrI8zWasvbo4ogth8qWKW4LwrJikbTH2zoqs7TZcvrTmRJSCfACnBzZ6+lXDMAg
         XP76+AsqehReZuJ8n1vcUKIbxKLSX3RqydBV/joc3RhNnLn2rQs+H9t4Dj/7A8sgfLx8
         cDhSWqJET37XlcvZM/FD0XoRZoFFYCIrGbk8XipT3mwRI5cKwzsMJ7XpnQWruDJXTB6z
         EcgXyIpWDTNqpRVV4OEhGBk9EpJTgcWte25F93ygjaVna73vjksFrW/gnutmoDZLAyEP
         7+Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M9wvXa0+gkI3GP7IAXAzoJWVN3BZ6VG9Ukc2BUOIvbI=;
        b=4nnnHfX/VSM/eubEH464u7JSD0/NPAn+FIPnGk/CeCmwkz71/ePYro62LkubBHD8xa
         hacGKWJvMu80g9QcsLJj1rdq2PDxiIxv/3ZgQl1fpQ8W9e6es8/KLOIrKhWxzeufPslK
         09P89sFUYYKCFTUsBql7EHyuDVgEjRHlBLhoqRfoeuNMe7xO3IbuGaDzwfUhRJvN3b56
         5p3KlBP9qIzeLhiiRic2cZy1rOO4jjlZM1USL+VmDiZllD7wvNunI8j2TK5TKUPAnneA
         JCDlbHssA53mFKx4j1TN26+SqyaKlzfRGmk/QxACHyqtKDYBGhI+XA15O1hpUxJZUkVP
         PUHw==
X-Gm-Message-State: ANoB5plfCUBUewpp/9wuGNYbAzukSPtZgDZIdDQR5KJEHeCIJHjE5bvd
        kdmox5dfURkzxXIzDPPsC8bi9K+epHx6mJ0dIChUHg==
X-Google-Smtp-Source: AA0mqf4CDnImmrRmj/CL0H7ee6DcB7BZv1k2SlS4grKWuSFnrFa+gMtI5JJaoAWnZmNHrYPNaO2FEsRMpJCFQ2Hn5o4=
X-Received: by 2002:a05:6214:5a07:b0:4bb:70d5:5b15 with SMTP id
 lu7-20020a0562145a0700b004bb70d55b15mr13923036qvb.12.1668462896209; Mon, 14
 Nov 2022 13:54:56 -0800 (PST)
MIME-Version: 1.0
References: <20221113101438.30910-6-sahid.ferdjaoui@industrialdiscipline.com>
In-Reply-To: <20221113101438.30910-6-sahid.ferdjaoui@industrialdiscipline.com>
From:   Quentin Monnet <quentin@isovalent.com>
Date:   Mon, 14 Nov 2022 21:54:45 +0000
Message-ID: <CACdoK4JcXpTKCnUOHm9uNj6nC51U_uyWPYCDNYcAVMsL4hyugA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 5/5] bpftool: remove function free_btf_vmlinux()
To:     Sahid Orentino Ferdjaoui 
        <sahid.ferdjaoui@industrialdiscipline.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, yhs@fb.com, martin.lau@linux.dev,
        song@kernel.org, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, 13 Nov 2022 at 10:17, Sahid Orentino Ferdjaoui
<sahid.ferdjaoui@industrialdiscipline.com> wrote:
>
> The function contains a single btf__free() call which can be
> inlined. Credits to Yonghong Song.

In such case, you can credit with:

Suggested-by: Yonghong Song <yhs@fb.com>

>
> Signed-off-by: Sahid Orentino Ferdjaoui <sahid.ferdjaoui@industrialdiscipline.com>
> Acked-by: Yonghong Song <yhs@fb.com>

Reviewed-by: Quentin Monnet <quentin@isovalent.com>

Thanks!
