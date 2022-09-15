Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 839425BA29E
	for <lists+bpf@lfdr.de>; Fri, 16 Sep 2022 00:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbiIOWQB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Sep 2022 18:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiIOWQB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 15 Sep 2022 18:16:01 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD06085FBB
        for <bpf@vger.kernel.org>; Thu, 15 Sep 2022 15:15:56 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id u15-20020a05600c19cf00b003b4acef34b1so2046466wmq.4
        for <bpf@vger.kernel.org>; Thu, 15 Sep 2022 15:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date;
        bh=eZgsSC8XzBlKIexQoq+wNofxMPl+dfYAVWGbexaRn60=;
        b=Qz1ioE+YV9l2X4/dY4KvPcaPsf4N4TESv8cJoG6vEGhEzIdd0gXuHgMHNX4BsWY8mW
         8Ogt7biu1/HRNZCwm5MBCwT5fLQah10lP9VzvUI5V8zSRW5RyJsd9uQB3zyZwdtHOSyt
         IGKD4Kcnw70jCNLcKOcfeN1gwkyTRcG+UxKdmV9dDZ52ssuYERF/EsAjVhnP96w2l4v4
         XNPVEhV7Ql6tiYJ1ruhnF3yxZkAJzPH78afpOXtIRbn8UDpuiNi63hvnMql6zsjMh/ZF
         O6n6SJQBEpvMJXb1m+kK4T9nvtB5kCBfaqfsF1VwW8h8VusiHlYVglplVU9Y18oS4euY
         iWSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=eZgsSC8XzBlKIexQoq+wNofxMPl+dfYAVWGbexaRn60=;
        b=bEQEPwosz0c4VzWX9j9Bd7j0Gf8QWzTjrbGG2qIHeBAYUQ/rqDoj34uaMdv9m8/rPB
         uU9jPo1dVuoqAncDp+0y0v9LdiMmnUfq5vxNq/UwFH9iJ8k3L4HUQERSu5oANyNrNcDi
         7a0mlS2a66wxKWtBt4AStLkqYTtNUcsofSA0aiwcHAupbgj5xW5w+VNREejiczabCdCG
         ofNg13jJf6+okHjax2HBkomdzhd9RYT5WA3wNmxDNsfGpa9gvsTCt1BWkpMSqbd89s8E
         BF2honhQdcWprXEvAdy37hOuSarIThVvjYhP9FfO9vTOWB0sSJvbxz2gIgO2QAJLuygi
         8Z3w==
X-Gm-Message-State: ACrzQf0ddBTbm7M6pji4IW5V35CsKn8LBNWwRmEbCvyQSDzRWEf9e0MS
        NfdDDQ0Ix0vLFyjh6jh1nFk3KSEwV3CyDpMirwE=
X-Google-Smtp-Source: AMsMyM6VEeoi1nAdrvw/7ZMY5yplRVHYm49pixdlp6hi7/ehoQe1GwrjDIkPtgUNtp3fTjRiYIC98RtXMm6P7+7YUfI=
X-Received: by 2002:a7b:c303:0:b0:3b4:6e89:e5d5 with SMTP id
 k3-20020a7bc303000000b003b46e89e5d5mr1263787wmj.111.1663280155125; Thu, 15
 Sep 2022 15:15:55 -0700 (PDT)
MIME-Version: 1.0
Sender: gonibulama424@gmail.com
Received: by 2002:a05:6000:1365:0:0:0:0 with HTTP; Thu, 15 Sep 2022 15:15:54
 -0700 (PDT)
From:   "Mrs. Margaret Christopher" <mrsmargaretchristopher01@gmail.com>
Date:   Thu, 15 Sep 2022 15:15:54 -0700
X-Google-Sender-Auth: Z08dB7T5_q4Wx7KYxRhMeUshSEc
Message-ID: <CAG_A1py2DuxRukJhnN5g4+kfjce-wkRKLDpmnJBDBRVCD_dLNw@mail.gmail.com>
Subject: Humanitarian Project For Less Privileged.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

-- 
Hello Dear

  Am a dying woman here in the hospital, i was diagnose as a
Coronavirus patient over 2 months ago. I am A business woman who is
dealing with Gold Exportation, I Am 59 year old from USA California i
have a charitable and unfufilling  project that am about to handover
to you, if you are interested to know more about this project please reply me.

 Hope to hear from you

Best Regard

Yours Faithfully,
