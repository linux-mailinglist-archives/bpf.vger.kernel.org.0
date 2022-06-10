Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5A054683A
	for <lists+bpf@lfdr.de>; Fri, 10 Jun 2022 16:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbiFJOYB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Jun 2022 10:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344905AbiFJOX7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Jun 2022 10:23:59 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8861C15E4B2
        for <bpf@vger.kernel.org>; Fri, 10 Jun 2022 07:23:56 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id o6so17813954plg.2
        for <bpf@vger.kernel.org>; Fri, 10 Jun 2022 07:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=ustad4Oit1LbdSHBANPMFYdxqbyRopb/4kSjojaTPVc=;
        b=OrgRGDm/dh2PW8HyRJ9FFqEEmhHOjNIlI10/GRr+lH7RQu29CIg5kawYFLj0GByn/z
         bkfl0rLBcMKLG7Jv2gonuUumAUlSDmY70l5C8JO0b0XffStMlhA2x6EH+ukil3abNF/D
         ekq9QvvOBGmNXV2KFhGadm0lS6Ht7WGEM6kGd3xH0K1aDXTZGtwic7PwQnGPFPVppBPQ
         PyNwWxHF8lD0H7xCzURFgECsrfHwo8y0nkpZLcFFYV3N94QjuNFDfJakxbsVi1S8dCWf
         3LDLC7RmOC+78AA+HgIg0vAFwd9cLzSSnORdtisGKdR3JtePH+ebrENxE9sbjIkolbgj
         9RoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=ustad4Oit1LbdSHBANPMFYdxqbyRopb/4kSjojaTPVc=;
        b=U7hPWJB9n/y+i12JdO1oztJq4a3QS2DFbjGs5IFTauGZLCPHfkqoDEge3fBcj6u6+w
         U+S2N8kpxaaeB1UinjfNsaZJE/tAIflxV5fL9tCC9nKndjVqr86QC5CvJGnNetYfOr14
         Akv9gR4c012160u4QbZ+rPEpr3u3PV1RW8ZBHaAWDva9gcrB3+XmJxkTiWNi+2e+pryO
         CUnDVYWL2x/IhI431g+2w7F6yOZwbF5x+UxC+jQ0FR1HfKY0dsNuY4Yv26+Rxpsh3h6h
         dmsvNULfC1jj2jZlhYP1iNUftw9XVG97V3ZkG78Yr3MIPxZPVTIMyc0t8x+V2O+AQBkS
         qUcw==
X-Gm-Message-State: AOAM5334y8NLDUWzUxlgC17uOZhG0gLlO8QZA6KMygHnVdTmZEXk7+/X
        w4KRe7jo2ezVg2va52L2gLVFHpTabgbsmTXHGtk=
X-Google-Smtp-Source: ABdhPJwx3RzALuJfV3enwvX2pQKkC9Yp61IsJMSiIlbX3ys58flRLOXHg9V+wJ483TgJu9+w28j26fPfuj8ntMFnZKA=
X-Received: by 2002:a17:902:9a49:b0:162:20d3:6756 with SMTP id
 x9-20020a1709029a4900b0016220d36756mr44502462plv.124.1654871036131; Fri, 10
 Jun 2022 07:23:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a21:3283:b0:83:f648:207 with HTTP; Fri, 10 Jun 2022
 07:23:55 -0700 (PDT)
Reply-To: rl715537@gmail.com
From:   Rebecca Lawrence <corrinc2017@gmail.com>
Date:   Fri, 10 Jun 2022 14:23:55 +0000
Message-ID: <CAAgAnQFo=oVcwMAyqgqeumj7vSn6tq_UTJh3n5w1OU2WCtrVrA@mail.gmail.com>
Subject: 
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

Hello Dear,
My name is Rebecca, I am a United States and a military woman who has
never married with no kids yet. I came across your profile, and I
personally took interest in being your friend. For confidential
matters, please contact me back through my private email
rl715537@gmail.com to enable me to send you my pictures and give you
more details about me. I Hope to hear from you soon.
Regards
Rebecca.
