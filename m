Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6E74616303
	for <lists+bpf@lfdr.de>; Wed,  2 Nov 2022 13:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbiKBMss (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Nov 2022 08:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiKBMsq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Nov 2022 08:48:46 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F988C17
        for <bpf@vger.kernel.org>; Wed,  2 Nov 2022 05:48:43 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id d6so28031556lfs.10
        for <bpf@vger.kernel.org>; Wed, 02 Nov 2022 05:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sz/uTvOc0gNmc74MGKA7yKeLqyFqD/joiI1SxwVZLms=;
        b=FqR0QeEiB2XkiMCLPdFxi+z4XcVgQxKvw6bgHn3f3xPkbDZZRRzN24dytdenTe6b8l
         ch99MRl7hpPOd5pq0FxAC7Hpx3Hf9L0GVIJfBGmDmF0zB1aCfSy+0jGSjRbNdxlXdPPJ
         FzLgWoXBC+7DkA84YLFbDBj2NoWfp/0jXSY5OiGPxzUhrAn6RPAKx+0cfp9GDJjiMK6r
         pMgjx0mlbOPZ/K8KoxL9SpwPeqxDga0QKdNI4mp1RY1Zu1w2rXbW2n0dtdvEiqjaSbNr
         3qHHG83/qDEd2etMN+qai0vsvj+MVcIrYoO0uZJEI5HwJFre/IMLZTcSftT2BQVKsYPh
         PVqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sz/uTvOc0gNmc74MGKA7yKeLqyFqD/joiI1SxwVZLms=;
        b=Lfk1RR2+GlT8s8y0j80K8nyO+crH7sKtwukyjXD7DhxQf9kvjOtbmOJKuAJN9Q7pwE
         nfx4Kz9cbxepPX6CIHy+VCUwyns8+fvn30Rci8pEJ7FNnqdsrZluT/PCchaJ4ZlTeGFO
         xn8i8DARL1RHKJWtOFK50BbxLLyhvZRPaYkuSHoz3+riHBnmbPDVXLn3AZZOJOtJbeeO
         zt3+wSkXuEo1i9a8knyt7Wj74KMAUkweUPR9h8jZTYuWfwoD1r0A+NrsGmnJ4WNxo+o6
         jlQA6+wrtUUry9NPX8gkK6qyjQV2APXF3sDavVe5adJ8TbHeIaWAgN2aDhyBLBqw9QTx
         QMWw==
X-Gm-Message-State: ACrzQf3MAOZzIuMAzEJBvZlxP/3jxdpekZJ8q15d+o8XZsxmsKtoLH2j
        nYJbvp32QJwSXCi3SmNa6zbJSd+sXb2Z+WcMMKQ=
X-Google-Smtp-Source: AMsMyM7/FLs+utVIQxapsGZ8q2BsAvRjzJUNJuePM8AVHc/il67Sc/dKq8vDyAXfW2derLPPwsbq56bqP7LT15bWbbk=
X-Received: by 2002:ac2:4986:0:b0:4a2:7b62:747 with SMTP id
 f6-20020ac24986000000b004a27b620747mr8754273lfl.92.1667393321545; Wed, 02 Nov
 2022 05:48:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6520:40ee:b0:220:4267:3735 with HTTP; Wed, 2 Nov 2022
 05:48:40 -0700 (PDT)
Reply-To: rihabmanyang1993@gmail.com
From:   Rihab Manyang <bassiroundaw77@gmail.com>
Date:   Wed, 2 Nov 2022 12:48:40 +0000
Message-ID: <CAMQfp2i3wveLe1jZUDK9auNy5ghsaAOzXQwOrUeprk0LLwtUQw@mail.gmail.com>
Subject: HI DEAR..
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:130 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5050]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [bassiroundaw77[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [rihabmanyang1993[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [bassiroundaw77[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  3.0 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

-- 
My name is Rihab Manyang,i am here to search for a business partner and
friend who will help me to invest my fund in his country.
