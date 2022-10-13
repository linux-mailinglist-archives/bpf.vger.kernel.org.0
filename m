Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21D4C5FD757
	for <lists+bpf@lfdr.de>; Thu, 13 Oct 2022 11:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbiJMJum (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Oct 2022 05:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiJMJuk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 Oct 2022 05:50:40 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 693661142D8
        for <bpf@vger.kernel.org>; Thu, 13 Oct 2022 02:50:39 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id w3so646137qtv.9
        for <bpf@vger.kernel.org>; Thu, 13 Oct 2022 02:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PIqnGOnuCdILHCjBRH2XyEMbuxERKZxFFNMV5qYWuuE=;
        b=CjqRujYX7BwgIYOjri8AvMrG1rlyTfH4UrrnoC4rld9pgZ8UTeSMog4T6oM1oRVuxh
         pQwRu8Ts8TGOmRxYCci16RUaYxY8glC7dMBZa1mZpeLmI+/SAwpUoDvUOMWP9Ur53uyD
         1DkY0nRipNDeFbMTRTkcXJIOoVd3qlGZXUwiiyVe8i7FSexpZO7fewT3PnG4PssnIhdw
         6gi6asnOxKcg+f+YqT/zBDG2XH3ctFdWFhHcoAPtbQtYoi8TV4FP4TK8fwfA9HBdb3yJ
         VjUn6NdAq1qkheoIhn2hwC9WVaVpezR6q3q4avh5wIHfqcz2fr+JribBQe9fqcHk8/nA
         Ra2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PIqnGOnuCdILHCjBRH2XyEMbuxERKZxFFNMV5qYWuuE=;
        b=ZnKbS34Ara68ZDQeduJlTDN/AG5G6EYJQOd58/RyDAyMkPg3X4V0ndtgVc53ifrW7s
         V3KFhsaq/92oLvVCC08L/Fo0TDLlajWpZbR1Rj5nC+99O5mDLhpf6AY6+NGEOBucxllC
         mBa94HVc2vNukFLh/z7dDsoJGRyDMi6gvUmR0nbVq6VrcuPrqvRVmqpLu2yqnsoPuRpB
         ejWoyPvaNaaUcX9eeRBndJ+ydJdnatNwBBu0+7wanxea/1qzGSgSw/Xp1lo1WzrxB5/l
         BxcGLF99qY+DxI9O18+BX0tpayda8bEA1kP9v+QORj8qmDdlEuJDUYBsCBpyUcnI555a
         hC+Q==
X-Gm-Message-State: ACrzQf26UBO4CzZ3wqDkdZ0LmKCfMTS5yD+x8V4jAXELEh1Q5lcpIa2V
        YWRshwtDejX1J+sXS6KlOmeDSJ0X4vimmjR36MQ=
X-Google-Smtp-Source: AMsMyM6a9+cAmMoBAkmsrXsgYkz2jeBbf9LwmtRXQOl3AYfZIt+077ZrkQQ43gz1uzRM9HcP/KK+LHadk3Qtl6/8jSY=
X-Received: by 2002:a05:622a:3cf:b0:394:fc49:b4a8 with SMTP id
 k15-20020a05622a03cf00b00394fc49b4a8mr27196148qtx.249.1665654638539; Thu, 13
 Oct 2022 02:50:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:620a:4011:0:0:0:0 with HTTP; Thu, 13 Oct 2022 02:50:38
 -0700 (PDT)
Reply-To: financialdepartment024@gmail.com
From:   "Financial Department U.S" <jacklandon02q@gmail.com>
Date:   Thu, 13 Oct 2022 10:50:38 +0100
Message-ID: <CAJbZS9yy-_ndFaa8v4U6L=TtOv4EVVwbQ+fiqV=ZBSTtj=gn3Q@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

-- 
Dear Friend,

I have an important message just get back for more details.

Sincerely,
Mr Robert Liam
Deputy department of the treasury
United State.
