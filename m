Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1216A9038
	for <lists+bpf@lfdr.de>; Fri,  3 Mar 2023 05:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjCCEXv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Mar 2023 23:23:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjCCEXu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Mar 2023 23:23:50 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC05199FB
        for <bpf@vger.kernel.org>; Thu,  2 Mar 2023 20:23:49 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id h9so1143169ljq.2
        for <bpf@vger.kernel.org>; Thu, 02 Mar 2023 20:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1677817427;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MfL2QvkAJzNgbvi/osoEikIgTgS3uEXHQQqSdtIhs4s=;
        b=jRHcA20z2HRLyE51/ZO0eugpEPMMdEkSfpPJf+nr8W8/Iv7zc3/C/kralIsQbDCQtr
         ULMLuOHznGbvUHcAoc8Zx3rJpHDtFWCklicvmqBb0yN+1KpD2XFduiFFcvPFnyOKd9H3
         kmVH5PiH63TFRJJI/ouXKz6Nq2UnS02iBLwrE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677817427;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MfL2QvkAJzNgbvi/osoEikIgTgS3uEXHQQqSdtIhs4s=;
        b=0eF4Nq+ahUY4hz8ZOf+5ud3ZVId87YmFnVhqWwi/2wM8ZM8gP4nalFnSeNFdUwZnBh
         NP5xP9ri39Q9L44QuA9ExpXEfKFCIC2uuAmYNaF/hxa0AxExvAQXtZhEJ/9xbKp//Mea
         LReLYELhbOzyPQ1F7ZY0T3CkHGH50CKyVM8ojrdmzI2YPH0V7WW8Yszfk6wbH3x6Q+Cq
         vzO885+KnZGoYzhUG4xJ83P68wFOe8n3CDBfvdgjY0rOWMqsQdDmbbk8NLLLNnZE/6Dz
         ElhbCtDaBYHtWDNAMYdhT1D4e6tcSvVbdOV9KN4yW2AqLRFVFo8n/oiN0x1/34KVR89T
         Akaw==
X-Gm-Message-State: AO0yUKU+y6k9BnXxLuNEUTFjdEsDMOPBN8mHKydyQudFUQbBJcKoRYUm
        VQjPTrsvQIpgh1nmwbEksxffw2EAd/7g4koIuwWt6PphjFYd5vPy
X-Google-Smtp-Source: AK7set/l5GGDLgxV1Q4O8nMPLPGxZmF8oX+zj34dJZ39SuRwE1foWzE0zFV3bHsysqvKGTk3sTH0CY0RUNG9qXqnHS0=
X-Received: by 2002:a05:651c:ba3:b0:295:a8d1:8a28 with SMTP id
 bg35-20020a05651c0ba300b00295a8d18a28mr130731ljb.3.1677817427034; Thu, 02 Mar
 2023 20:23:47 -0800 (PST)
MIME-Version: 1.0
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 2 Mar 2023 23:23:35 -0500
Message-ID: <CAEXW_YSAQcNaX3wB-H8Xt65hom2ZY1_NQAtcXxS-7z4o+LNb9g@mail.gmail.com>
Subject: 
To:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_TONAME_EQ_TOLOCAL_VSHORT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

unsubscribe bpf
