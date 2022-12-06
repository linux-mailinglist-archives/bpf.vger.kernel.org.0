Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79AB0644E4B
	for <lists+bpf@lfdr.de>; Tue,  6 Dec 2022 23:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbiLFWBS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Dec 2022 17:01:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiLFWBP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Dec 2022 17:01:15 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1712F442E1
        for <bpf@vger.kernel.org>; Tue,  6 Dec 2022 14:01:11 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id p24so15299698plw.1
        for <bpf@vger.kernel.org>; Tue, 06 Dec 2022 14:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F/a12WuVc45CsZYGdjEA91y3kHsxVaVY+N/WBiSFo08=;
        b=HPOZ6daMNEfApkOVpHtQi8kwy+j4CkH72HLoDhUB0ULz11Y4XPBey7c1+5AAD4vlFQ
         c+sTjnM5sKv5dZX9SKDhoVL3wAkWQM8UUFes0BKoYHTtaO7D72p4FtWXj5gW+1yBoXAu
         6ijd2LpZhrcp3Pvlm17fwOaGSIjBdsvXqFrANVqwhksY6v4PnvhiEXGnWNHLCD3c+Jyi
         1sP6kql3qoM/dYm1E6UVP+zN/5GTUMO3inR4H+qiKPBdvMNFT1ms0Z0TnaOaozg+Xzb/
         WwA2+HyT6tTYGUNGyjCYFpqZKzN3hNQNBqPJHfmO1Z/qh37I0j3YxEeOSz0oHGwAIuLr
         BpoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=F/a12WuVc45CsZYGdjEA91y3kHsxVaVY+N/WBiSFo08=;
        b=TLytErL7xxly3h0/0vb+Opxf9BqKMCkMJQj3HTZthOqn/F3Fh6fc6qFgVIUxajAI2p
         6S35v9LiFr6ZJn7s3IizFJ0Mf0u+/JF1RHQikkkXUeMAKglJ1f0oq4q7bMnn9q8TdqDB
         UQDVYBFOXDI/0mtbf4OZbzpVD0AUxfM/6pmRoqt5PO1pT4X1uJ9u97liNys9vrd/mpWp
         h42EXq4lmhtUmzgInCNfr0y7Y6Sk6ZAkih6KkCt9U/hje9gNUPZ+t2RxyiansotDfS/C
         3MHH/4skmnE6SEAPJQT6G3gxoza5q+f6goIfadnSi/fK7B8FIeYbbclr2fqUG4gb7qsk
         GGaA==
X-Gm-Message-State: ANoB5pn6/DolZ82XT/kxIHkqs4TVPDH4SJPUnFldr602YWIxqkHdV/oq
        l85EhUOpCut7VZert8FWCEU=
X-Google-Smtp-Source: AA0mqf5n3jDEAjEMxyU1lXcWjPTGuwYWRXieHyPwpqq0YY4Nz+Xa/3DAYZmGsqtVpvHOsIkrlgnl7Q==
X-Received: by 2002:a17:90a:5305:b0:219:2d33:9504 with SMTP id x5-20020a17090a530500b002192d339504mr48580247pjh.171.1670364070540;
        Tue, 06 Dec 2022 14:01:10 -0800 (PST)
Received: from localhost ([129.95.247.247])
        by smtp.gmail.com with ESMTPSA id w64-20020a17090a6bc600b00219025945dcsm13154951pjj.19.2022.12.06.14.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 14:01:09 -0800 (PST)
Date:   Tue, 06 Dec 2022 14:01:08 -0800
From:   John Fastabend <john.fastabend@gmail.com>
To:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net
Cc:     andrii@kernel.org, kernel-team@fb.com
Message-ID: <638fbba496dd9_8a912082f@john.notmuch>
In-Reply-To: <20221202051030.3100390-3-andrii@kernel.org>
References: <20221202051030.3100390-1-andrii@kernel.org>
 <20221202051030.3100390-3-andrii@kernel.org>
Subject: RE: [PATCH bpf-next 2/3] bpf: mostly decouple jump history management
 from is_state_visited()
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
> Jump history updating and state equivalence checks are conceptually
> independent, so move push_jmp_history() out of is_state_visited(). Also
> make a decision whether to perform state equivalence checks or not one
> layer higher in do_check(), keeping is_state_visited() unconditionally
> performing state checks.
> 
> push_jmp_history() should be performed after state checks. There is just
> one small non-uniformity. When is_state_visited() finds already
> validated equivalent state, it propagates precision marks to current
> state's parent chain. For this to work correctly, jump history has to be
> updated, so is_state_visited() is doing that internally.
> 
> But if no equivalent verified state is found, jump history has to be
> updated in a newly cloned child state, so is_jmp_point()
> + push_jmp_history() is performed after is_state_visited() exited with
> zero result, which means "proceed with validation".
> 
> This change has no functional changes. It's not strictly necessary, but
> feels right to decouple these two processes.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---

Acked-by: John Fastabend <john.fastabend@gmail.com>
