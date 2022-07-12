Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 258A8571805
	for <lists+bpf@lfdr.de>; Tue, 12 Jul 2022 13:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232294AbiGLLIn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jul 2022 07:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbiGLLIm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jul 2022 07:08:42 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B03538AB
        for <bpf@vger.kernel.org>; Tue, 12 Jul 2022 04:08:39 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id cb12-20020a056830618c00b00616b871cef3so5868718otb.5
        for <bpf@vger.kernel.org>; Tue, 12 Jul 2022 04:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=TmMTJURCMUjheDExJe1NkQWxkP/4d22JJlbuAbsY4Jk=;
        b=XZCGpjQFTD34lMsDnDktJxa9DhgLqjU+2K+4dLfPG5Og9yA7+fx0OnpvpB4rvNZuCn
         t6drmhUhlrJnWrFkJyJdsHXqtYRsGLBxSCZY9vDlkeO5iw8yv2f0k2JNinmsZeyr8mYS
         fuBPlGAZgQ8+lGMMQ6yQWmkXnG4mkKwyIKZSAOxDMRlLjB5VrDiCGf+4PrMPuwkfhtF7
         cRc2FlQB4V3ppKjhlhAJmFxaj/c42qR4wGWumvJ+EyKpyWHvmY+7SoHA7YwtsHJClwvh
         bbRoN0BF7qsL/xCMyXldrOYPeUm2ZUADWzF1tYL7GijN3btt0ZjS2VQRGBRHyoMuZODv
         Htbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=TmMTJURCMUjheDExJe1NkQWxkP/4d22JJlbuAbsY4Jk=;
        b=iJ0ogjXe9YqOfg9n3ghcO9ay9iJIFpRktcMQIJoS3AICAiUtWL+sUdzgossbDvb2We
         7/1EDUMeApP/7P8tS/W7FitLIJnTjGl1YOsLEP6lHAA+WtqD/RgCU96aDtFN1rTyApsf
         MFkVp9PCUfc3RbYWp8z0AxsXrn07TTFBOKRSgtV89y//e0uM4zuZJ92Ghgju+k5GqLS2
         u7k6Jna3UJoyXC4Cj1BOCtGRzZJgea7DE289KNPO6l6WOLztkWCI4UCZu5UKb4pyAUbg
         GrtrZAySfRVjqnszBKj6dKl1zbdpJTQprv5wcqwpJrqngZRw8AkcUlOJ0o9ttLAVoYtk
         M19w==
X-Gm-Message-State: AJIora/RxMhZXXV4G+fZTK5mPUv//Fsg4QemU1MuWoJ44AruzdoP2fuF
        y3DsKunBD+GF1STy4F6KrTj+p5/2TK7HTM4lrDA=
X-Google-Smtp-Source: AGRyM1sdw67nhwFeAGbShqy6Xt7cSBO283MY3oZM10K0TwWfOzgv9D5VGdOBJlwned7cc6SQ0JvQKUp0FlY/d1CXJcg=
X-Received: by 2002:a9d:7f88:0:b0:61c:3593:fec9 with SMTP id
 t8-20020a9d7f88000000b0061c3593fec9mr6843332otp.33.1657624118559; Tue, 12 Jul
 2022 04:08:38 -0700 (PDT)
MIME-Version: 1.0
Sender: cynthialee854@gmail.com
Received: by 2002:a05:6808:1404:0:0:0:0 with HTTP; Tue, 12 Jul 2022 04:08:38
 -0700 (PDT)
From:   Christina Jose <christinajose2828@gmail.com>
Date:   Tue, 12 Jul 2022 04:08:38 -0700
X-Google-Sender-Auth: FMxqVr3yMcZ7GTKP0CFvluIlJ-M
Message-ID: <CAD2aC9V5dXe+FkDNaLYBqmFUUtwqeos9GQt-S6_bpPPoB8NBpg@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Good day.my name is Christina Joshua I am from Togo a country in west
Africa, please i need your help urgently, Its about my fathers health.
He has an injury for years now and the wound has developed to
something else, and need urgent operation of kidney replacement and
the doctor said we need to fly him to India for such replacement, now
i am the only child of my father and i lost my mother during my tender
age, please i need your financial support and prayers i can't afford
to loose my father because he is the only one i have i this world.

Best regard
Christina Joshua
daughter of Joshua Eli
+228 98339985
