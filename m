Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB8C611F70
	for <lists+bpf@lfdr.de>; Sat, 29 Oct 2022 04:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiJ2Cy6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Oct 2022 22:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbiJ2Cy5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 Oct 2022 22:54:57 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225481E3F9
        for <bpf@vger.kernel.org>; Fri, 28 Oct 2022 19:54:36 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id r61-20020a17090a43c300b00212f4e9cccdso11459631pjg.5
        for <bpf@vger.kernel.org>; Fri, 28 Oct 2022 19:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YX4+zXrHLSUDOZtVTTXj1VQzXyk0Zm4BhmJdhw8un24=;
        b=fynUubfTZ8SafzvcZvxZ+2+GX5QxkJX9NJP8KsPcJdS7ZcCj83/1FGIVWV5MXvV+qV
         pmfYWeDWeCAe5Wi2JUbVYjyfnNHWYl3f+Bc8Q5a/gbfpeMY3BkoACN4LlDXDcNmDPF87
         Kdb0jDSeVH6Zt8IUpOQPF+ny6StrHyUNYq0b8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YX4+zXrHLSUDOZtVTTXj1VQzXyk0Zm4BhmJdhw8un24=;
        b=OWYfuuQ8YogHNJR1hM4JOft9fLIfc0wi4u7r8BJzPGJLE8EEZ0HTNvq6DnIdnvKgTN
         dEdB3IfyYN1zRj2b+6E2FnzwPD8pURMzk5chx+VBaWSu76WrNyrN1XOf1YMfp3cATi0I
         3gTK7L1Q5/UzVnFEy+8eCCrfXCkefacsEPc1Z/EHXDNWeT55hv5zrENbkxv7O0/63G+m
         rzo3PaWUgus5/8uiFep+z3NWZSckI8fHoD0B7f8PfwSZNv9FDPA0wphY48wYoA9LcSq9
         wTpjdmZDG53oQtOAmmZysCV9XF7KpqQcRqZExQ3jjxBE3siOl7YrY+I1K43Ub4AHLFbG
         d4JQ==
X-Gm-Message-State: ACrzQf1MhTf6hAkrWs1mQbWtAgIYeXXvXE/4ukCArIXGi15mokN66W+3
        WwJoTj6S0fxjyUVa0syDWgsQJA==
X-Google-Smtp-Source: AMsMyM7RiSWbxRfUm06YG5BuJb7jdUGJtVtDJ9wEcGnOrrzrrPdaqMLhz86wOCVSAJ0IVVDAQBAA8w==
X-Received: by 2002:a17:902:f60b:b0:178:6a49:d4e3 with SMTP id n11-20020a170902f60b00b001786a49d4e3mr2238922plg.75.1667012075543;
        Fri, 28 Oct 2022 19:54:35 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id ik23-20020a170902ab1700b0017f9021ddc6sm141780plb.289.2022.10.28.19.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 19:54:34 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Alexei Starovoitov <ast@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH bpf-next v2 0/3] bpf/verifier: Use kmalloc_size_roundup() to match ksize() usage
Date:   Fri, 28 Oct 2022 19:54:29 -0700
Message-Id: <20221029024444.gonna.633-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=754; h=from:subject:message-id; bh=COoV4ApxIFfLjQV4Uq9UDDy9n43aEowo1/u4sSSUlM0=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjXJXnisow53qKBRmTKpeDkic5OqEw6GUEFED/OkoF VPV4MXOJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY1yV5wAKCRCJcvTf3G3AJvbTD/ 9xgG8uV/hht3vZTOfBNQDP8C7KbswriI2w6jtaQJlGBfPolO+pAUigJKOKKMyNPPsRTSwy9EEh5kwl LntURGjmAwizAMziagVoEbzAI1ZwFg5lQGarc9fQyzgSq5g8MLgmQdr4432lPAquZewMw8tLliGyQ4 wlNw5z3mT5YbqK+dlGknMzyCTekduRVvZcgfgQ7WDUkTOZo3wiYc7TnoWoyZMalzTSKV0qzjvwzh/g oMsk8MMqBFLqolctDpGRLQayRlYZFFQOa04ILGeTeuSDE10GK1+FI7jYdaFknOI+7SmBO6I7FAPrv7 FV6SMHQs0SEx59Efl2SMd9+cntGC9uoHuMxJi62O407mKxQa3WgWaFHeHUKcZkpq9B2OnPEbqZdJsC mR5xhfWI5fWh4HgBkeTYdIFr5nj4arQCajsEP8JCNhRl8C+IHXNA+LQ4QL/nQWTisW+NhKIng4pOs+ kP8yC3G+OvR2c5hjt2X+fwsReF1fENxkrwDAgEP9TNBUq1hrExgVKfBu3IizHtHVnmPTI6tQZZVipj kDzK1cjfSzjN+FdSZugnAcJvnuWJsnSLorzKVxvJ1m8F/6o0TimObU6Q2WukIBtE59hfENhityULJn yMQGu1HjAcRPfWYfoIGNX6FwcE9jb5A1WAnztNVo1K7kGCaZbMlSr9DUKS6Q==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

v2:
- split up patch into logical changes
- simplify copy_array, which can use ksize() directly
v1: https://lore.kernel.org/all/20221018090550.never.834-kees@kernel.org/

Hi,

Here's the next version of removing the BPF verifier's dependency on the
side-effects of ksize(), so we can remove the special handling needed
for KASAN, UBSAN_BOUNDS, nor FORTIFY_SOURCE in ksize().

Thanks,

-Kees

Kees Cook (3):
  bpf/verifier: Fix potential memory leak in array reallocation
  bpf/verifier: Use kmalloc_size_roundup() to match ksize() usage
  bpf/verifier: Take advantage of full allocation sizes

 kernel/bpf/verifier.c | 44 ++++++++++++++++++++++++++++---------------
 1 file changed, 29 insertions(+), 15 deletions(-)

-- 
2.34.1

