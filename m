Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA0CE545634
	for <lists+bpf@lfdr.de>; Thu,  9 Jun 2022 23:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232006AbiFIVKF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Jun 2022 17:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiFIVKF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Jun 2022 17:10:05 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2545EF551D
        for <bpf@vger.kernel.org>; Thu,  9 Jun 2022 14:10:04 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id s12so42664756ejx.3
        for <bpf@vger.kernel.org>; Thu, 09 Jun 2022 14:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=mZ3wqB4NmL7z6lpFr/h15h1rYqsZKafJnUpMVahbEPg=;
        b=l/a2f19eymqaWdEXJfYUqa/Af6S2KpiLT+ncVuIbXhRSCq92h816O2tUQLJbF5pGiJ
         1r1JNyIEaFKzCbVo+lp9MgYqFLSwpkymf6+gbGcK6NCxbg4aK++Mk84xEm1Bwjq0Bdgn
         KI9TDjJjbF48NlUuDjNCj1yH9AYqkXSudwV6jm8iffBA9oub6/OceO12MMSlVuE820+D
         y0f6JHjSGYKMTKw6e0jPIVIwJ3isfIm9N9kYKTry59V8qIYNJz04/v8Cn85+T7+kFKXc
         qbDdWfcM3aLbRuncdWWnLAsaauCnrn7OiQlJNwZda+KUk5Q2LmghiHFfQlLJgSW21M8V
         X21Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=mZ3wqB4NmL7z6lpFr/h15h1rYqsZKafJnUpMVahbEPg=;
        b=s7ctKy9s1McTmZzQBTKAZaVB07N/6ORB2oQ/taWIJ/9uzWXA2pkZOcv6CkVmy76mdb
         NlWPawAWHxTtTzwYQMLBYQy/xYiubmom1dAC4cyptDP/09NJ2f+oclf+9aq07DcNfbKL
         H3S9ULq/999QZx44chkLRPcVmdKC/BcMoD4TAX+Me2y1CkP8YozJ9uQQWYef5X7FjT54
         +4iMQDf8x1lTZaXLAacwnudKv13vDst7ViCpJTiaV4LWAH9RnsOobLV5mOacQz/RefRL
         AC8mQG8ZlBdc6qKwJbOI6JqghHxsY5bs02ZDFacRMrWrduCjhbsrU0BJX5TpDOdDKyvW
         IQ8A==
X-Gm-Message-State: AOAM532+dRA1ATRJ37H6jcUXdOtrHdUQnZUASdUSXDrQb8dwV+d1FOjq
        /v4Uj43NSZenLKZWxB+P/QVZtopWsb0GdHw23Uc=
X-Google-Smtp-Source: ABdhPJwtN8AMIrbKb1RWm8u3NqBYss90nXpxJ3fverwua0tOtb0JgXkGs6H+QKLSbmZS/9tkobgDETwaCLvAQhHkcQo=
X-Received: by 2002:a17:907:c26:b0:711:ca03:ab3c with SMTP id
 ga38-20020a1709070c2600b00711ca03ab3cmr22928072ejc.654.1654809002722; Thu, 09
 Jun 2022 14:10:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:906:5d12:0:0:0:0 with HTTP; Thu, 9 Jun 2022 14:10:02
 -0700 (PDT)
Reply-To: wen305147@gmail.com
From:   Tony Wen <weboutloock2@gmail.com>
Date:   Fri, 10 Jun 2022 05:10:02 +0800
Message-ID: <CAAPa9YB9BByNTZs+h9SPpm-TutpSEiMz3cMxYpjULV7uk1x+8Q@mail.gmail.com>
Subject: services
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Can I engage your services?
