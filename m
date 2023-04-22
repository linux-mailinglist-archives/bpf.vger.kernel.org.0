Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B44616EBACF
	for <lists+bpf@lfdr.de>; Sat, 22 Apr 2023 19:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjDVR6m (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 22 Apr 2023 13:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjDVR6k (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 22 Apr 2023 13:58:40 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CFB3212C
        for <bpf@vger.kernel.org>; Sat, 22 Apr 2023 10:58:40 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4ec8eca56cfso3072414e87.0
        for <bpf@vger.kernel.org>; Sat, 22 Apr 2023 10:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682186318; x=1684778318;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ud2Qp+0j+JXG+xzOTKtAs0iVLtO4HhzSJ3v0hgygifc=;
        b=p/3+IXWKInERkEjCl550CCb5lBU7DczS81HQ38x08UEQStuxsZmET2YPQVGWFaBJZC
         o4tQwfJnBC/agy7cegp62h32U8EdjsV0ppHJJAVVMh4B1G9v+BUoO4A3wyZB1p7MoFje
         IZzYeHd/kozBg7tp2XiYIapcNm0pd9hZYgUgEupauc+iGyqBeF26VkgEDHOTP1Pp5lAA
         hiIcn+5Wks93wrJvV229cqn6NdD+Nuy4dcNVk4gFlzGsRbrNowFBvremrJaSz0FWTBk4
         1AK+/Rlk6fg/Y8zJUbk6IJBlXqNAz/Za+jfU1caWXHKFFVizCxUWCBiPCe0EDBchcp+t
         orYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682186318; x=1684778318;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ud2Qp+0j+JXG+xzOTKtAs0iVLtO4HhzSJ3v0hgygifc=;
        b=iXKdPb96gtUVcMI1WY1FUCh/ro4YJeyMMT2OnyzLVCK7AQmeKMpgnIQ7aGKaX+JcZg
         sJC9pbBSQi6UFFLa+fA8MaHnpDAkYTrfNhSZpT5J3A3C5CHVsCxZhBbhtWhrSeuj9rfp
         1bcPRHZPTKPh/HC37s1BNW0i5uS+dWUiMVELWTWAR77T2Y50j7f8eZxDTAMAg3eiLqWK
         unyg+Cyv/UIF6OpfNwKoaI7C53O9DYxCCETY7QSqBADeLRZYhq2mWHQpN6HwPLgzWzfd
         DajiaU2veqfmxj4YtTHfi/Ml7RMfNBD7RJ+HuPYnJqvaeUEBM9G9RbJGIg4tM6ZyMxLz
         ya8A==
X-Gm-Message-State: AAQBX9dCUXrOJFuoQ5fyyUq31YA5F8e8NiPPNb9XLz8KddQeSKuk49ml
        ujRL5B/oSBCaU3cFwc3k5NT0e2gE+6keB70kxTE=
X-Google-Smtp-Source: AKy350Y8QVLee0g+OaXal/sS+O1sKc4S/7JBhJVgpl0alwdt7R12D5j/IUpxFUaUSb3PhCx5W07odD1o0cSUnn6BZ4k=
X-Received: by 2002:a05:6402:3ca:b0:506:8da7:fab7 with SMTP id
 t10-20020a05640203ca00b005068da7fab7mr7759899edw.10.1682185917565; Sat, 22
 Apr 2023 10:51:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a54:2012:0:b0:20b:da13:9ec7 with HTTP; Sat, 22 Apr 2023
 10:51:56 -0700 (PDT)
Reply-To: akiraharuto@yahoo.com
From:   Abd-Jafaari Maddah <dongy7442@gmail.com>
Date:   Sat, 22 Apr 2023 10:51:56 -0700
Message-ID: <CAGnEuTvjzLi61+HVQ+6UT=YaJ44NLsrBqExtdJ39R2FPPK0zJg@mail.gmail.com>
Subject: Did you get my mail
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

-- 
Dear,
I had sent you a mail but i don't think you received it that's why am
writing you again.It is important you get back to me as soon as you can.
Am waiting,
Abd-Jafaari Maddah
