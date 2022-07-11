Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF30C570835
	for <lists+bpf@lfdr.de>; Mon, 11 Jul 2022 18:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbiGKQW5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 Jul 2022 12:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiGKQW4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Jul 2022 12:22:56 -0400
Received: from mail-oa1-x42.google.com (mail-oa1-x42.google.com [IPv6:2001:4860:4864:20::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351FE7A51A
        for <bpf@vger.kernel.org>; Mon, 11 Jul 2022 09:22:56 -0700 (PDT)
Received: by mail-oa1-x42.google.com with SMTP id 586e51a60fabf-10bd4812c29so7251088fac.11
        for <bpf@vger.kernel.org>; Mon, 11 Jul 2022 09:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=LVBstvf3Gb9iH3RXO0Q9cVD/U+AveT1cuq6cD0YiKNI=;
        b=f+hWHiRjM0G3qQM1Ty4L1Ra/K/6z8Uf3eeuC0sYhC/3jFWzjoeN1FP9x2s8ZTeX+Sb
         a72EHkvjhfiAGW3U/Ul8lGn0loU/cJtb+sgbxLH2d1HC+RAZ8i4nWmOqiHSnZ7cit8t6
         keR+siq0+B+o1YhnbIk5I+iko4d6KIp+/fb/qAIXJa7Yd5+Q+TKWb9F7qC8H70HnMjS8
         GL1pc8wZOgY6FAXoca8utpQc1S77NzS2yr2ULhVC3jUIZX98ve0JCr/76XcUr/Ql3eam
         DOEH4ubuW/l8bpcYI15540b3SBshOoGm/983CCf2zLx4ztWGLc1cnOHdz7k1LUXEldMk
         q+PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=LVBstvf3Gb9iH3RXO0Q9cVD/U+AveT1cuq6cD0YiKNI=;
        b=1OibLpbYwI+YvESAN6+1AGpJs/l+VGNmKc81ywtge8YtCfrMxo1wrYxUEa9cNpZpjp
         QF5rmLmpExkPvtss6SeX/GlvWtdoHDn51RpaN4XZyf3SBuwSUYlNmTJIoELZysv6LkmI
         qqAubXpnjeTpzKDN3FUYaU7UsXRdD5epxggTmlv3Qg/ffobI8hYvWU/lLu3CdmOO/K4W
         jFranvyBdc8a8xWiJ8XDOqF2TVyENN3qU4KNjFcKO7CRtDqjkkeGtuKriIxviE1A9RhM
         q/l4t7BSpBNScPPALzlsRuXg0WXF+8iJlYkq6bZYlz5HRyKeF0oUdxE7vtvDOj5gGwn9
         eEJQ==
X-Gm-Message-State: AJIora/j4Q5IwHngeO2WgXR8de2iB9aJJo0kfh9wQvmLWnhKQ1uGX8u9
        SgKh5AGUtPXBAaRBdOfmySCwxc6D7nIVLww9WQ==
X-Google-Smtp-Source: AGRyM1sK3S1RZk7XaKJWMEgK32FMNT4w7NfEXKI5OYqCOaglB5O6wKn8336ie7v/rEnkFN+mhIbHSLTDGSMl9uQectc=
X-Received: by 2002:a05:6870:b48f:b0:10b:fa5a:71f8 with SMTP id
 y15-20020a056870b48f00b0010bfa5a71f8mr8026735oap.290.1657556575587; Mon, 11
 Jul 2022 09:22:55 -0700 (PDT)
MIME-Version: 1.0
Sender: edwardjasmine52@gmail.com
Received: by 2002:a05:6808:3020:0:0:0:0 with HTTP; Mon, 11 Jul 2022 09:22:55
 -0700 (PDT)
From:   "Mrs. Rabi Affason Macus" <affasonrabi@gmail.com>
Date:   Mon, 11 Jul 2022 16:22:55 +0000
X-Google-Sender-Auth: uJ9Uh7EQLZPYKYHKkZsdjMNNSKI
Message-ID: <CAN9eyjDugJZrgAx=PBatdGvg746k+R-FvpjKOwPWc0Xeq+UHOQ@mail.gmail.com>
Subject: PLEASE CONFIRM MY PREVIOUS MY FOR MORE DETAILS.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi dear how are you doing today? My name is Rabi Affason Marcus and i
want to confirm if you received my previous mail?
