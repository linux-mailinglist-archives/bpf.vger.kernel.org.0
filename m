Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCCE6CB555
	for <lists+bpf@lfdr.de>; Tue, 28 Mar 2023 06:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232853AbjC1EKb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Mar 2023 00:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232858AbjC1EKa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Mar 2023 00:10:30 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB701AC
        for <bpf@vger.kernel.org>; Mon, 27 Mar 2023 21:10:29 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id y35so6445083pgl.4
        for <bpf@vger.kernel.org>; Mon, 27 Mar 2023 21:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679976629;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/krrOzf32PMDRBi/P9qe9m671OONK8NSr+9AstJjJkE=;
        b=Xa+nmwt6WzNaeIYDK7D6L1hZQI3GqYstVQFrWniMM4YCqmBTO4RqNxyPptAwAFRpP0
         JjDbJrp14f8DT3KfOVxBqrrskONV9Q0flbxLr+MlOJWFv1PZu9yfJIgM3L4PMy7nSEpV
         IINMxuuKz2tQWc1cQs3dnwGBbIpx3AD/MMC01BXIM1WWSkyZSKiQf5Q7iCgx7xvuseOW
         2FaMjfpiU2aLRUjC7s7sg3amTpihY/c7VFoBwtEogd20IniVLnUhmYQFDVLwONVsfJWf
         Oe9p2d5grR7ZpCSaIuQgPtkVTnHGwNt4TJ7omBBqUuLLVFkf91fZ+YhOS4otP1PQNSZH
         TgrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679976629;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/krrOzf32PMDRBi/P9qe9m671OONK8NSr+9AstJjJkE=;
        b=jGd6jCHz/QpklQaF7ZCCpgBFv61ZQBsQkcUFpKi32xaNPXqlMThTT7LkkxXvzdszVM
         J8DY9VEdXQ3slPOzNlYt0PXbD7kCczVMFo/TaJmX2g5KygndpuBFcjoVICLhqbfvaYha
         pFuwPnyOwcMvKcOolHFmjEZ3Fqp3TIowYAr6xgXJNNFJqJt4n4j1DAKQJuqgtlZM13cD
         wb/IxHjSsvFbIli6+p4u72xW+xVNYsfbA4cYsG9GXjkP6/9YT5RC6BFN60mkcFJaNerJ
         Tf0A05z7vdayqCLUPqq27EdJYnRGWFn6ZmhXPW9Nb2k9VbfQIxDbk1CyAvOUkViZ6ZzV
         OoFw==
X-Gm-Message-State: AAQBX9d+lGBymuvPNF+kVppciWIHFsO3xtO1KUNFv8v6Vh0NY+9Ddx9b
        cvIrpYrcOm2ScUoseRNSNnmtk8bODf5aZSyEB/E=
X-Google-Smtp-Source: AK7set9pS9KIfJJ2i2mTutGiU/9KqKOveuCn2ZhSPLVPcVaMPmiDQL/sMv2SQfEqSQ2YI12zI9gtqoxuQCgGEy69SL8=
X-Received: by 2002:a05:6a00:1a0b:b0:625:4ff8:3505 with SMTP id
 g11-20020a056a001a0b00b006254ff83505mr7575097pfv.1.1679976628709; Mon, 27 Mar
 2023 21:10:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7300:730b:b0:b2:95a5:a804 with HTTP; Mon, 27 Mar 2023
 21:10:27 -0700 (PDT)
Reply-To: avamedicinemed3@gmail.com
From:   Dr Ava Smith <captraymondjpierce@gmail.com>
Date:   Tue, 28 Mar 2023 06:10:27 +0200
Message-ID: <CAAcDt7GVVjp_EOAu32NKh37sLAzuG=GxAT_JpBciz6MM1Aav=Q@mail.gmail.com>
Subject: From Dr Ava Smith from United States
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

-- 
Hello Dear
My name is Dr Ava Smith,a medical doctor from United States.
I have Dual citizenship which is English and French.
I will share pictures and more details about me as soon as i get
a response from you
Thanks
Ava
