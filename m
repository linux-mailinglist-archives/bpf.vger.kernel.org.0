Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3CF557F5AE
	for <lists+bpf@lfdr.de>; Sun, 24 Jul 2022 17:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbiGXPQI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 24 Jul 2022 11:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbiGXPQH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 24 Jul 2022 11:16:07 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B09F6DF90
        for <bpf@vger.kernel.org>; Sun, 24 Jul 2022 08:16:06 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id n185so5389206wmn.4
        for <bpf@vger.kernel.org>; Sun, 24 Jul 2022 08:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=U1hEasta6NC0Fhws0/3UxCRL1y11e+6zcIcC0np0f/U=;
        b=pr0+dly+aD6yUenqfG1g5MV6kHsAkZU2T3avAn+uw0oBzQjdQRg9u7soDq+LrDMJOb
         PQoTbWfNyeOSUYE02yXWTQnBhrAG3Gcgqw5lOvLMjDpCIz2TB+QXpcGlj9kRrOQa93jx
         5fNzj7GXYN5B759rCd+Ag5vF2i+9FXTwqrOIXsRzwd7dlf+9XuPlpTtaBZBZw1bS6O78
         LTHLMrLN/B+LecrfS5a0OJx60PnnlrUeEfAFc9paSrqdxf6i0SmhM5iKcHkjxYEMgVWE
         gqFeaP1Dc36aSeueHA9PdbYhvVpXXfuc9N0TGiAD3eoaI9qrpwKY9WruBokEj2s6rg1X
         XUVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=U1hEasta6NC0Fhws0/3UxCRL1y11e+6zcIcC0np0f/U=;
        b=AAjalgVGyRyXHs59lBpEviH0JhUGYQlEeZAkkTx3jlSj8IR/Z/hp3XbPRon7o8ATrJ
         Yp914DLXkPhkkbtyAiUSAXUpdd2JPfvfjFce2LN05p2grs2CYHcQQ32A28BqYwimoNpD
         YIIG2vuo469Z7cA+myKBXv2n8HdQgcJf8CrIjXPWof37o7bLJomGcvIWWGJr+Sw6IJKZ
         z1Nt9sBxBLjjdSCEX0ewt1kJq2QsXd7refgFOndBwzGbbVZOBnHtGu2zSfpy5mIfF2x/
         rE2FcROaKfvnzGeJqyzh4HoGw59vIf7BAAD2iTUQVaZ+kUyqQ15asPH1yju9pCKiA5vZ
         2EYQ==
X-Gm-Message-State: AJIora9jcd5jBjVAbh74aOW5rPcLVaYLU380qaG6EaJKcYt7SdkdgCMB
        5PM57Ih44xfeEXxGEmO0Hgq88+G+bzK+KRUb//k=
X-Google-Smtp-Source: AGRyM1uUpaPhv6buYTriG+kiy6kJem7IxffDEd7ky9Hv4w4XPZIKvVZoStMc1j9XVLQHlTny5XX0UbZ6GrgZYoKuZGw=
X-Received: by 2002:a1c:7213:0:b0:3a3:155a:dd5d with SMTP id
 n19-20020a1c7213000000b003a3155add5dmr5580381wmc.178.1658675765089; Sun, 24
 Jul 2022 08:16:05 -0700 (PDT)
MIME-Version: 1.0
Sender: gb676779@gmail.com
Received: by 2002:a7b:c5d5:0:0:0:0:0 with HTTP; Sun, 24 Jul 2022 08:16:04
 -0700 (PDT)
From:   "Mrs. Linda Harakan" <haralinda549@gmail.com>
Date:   Sun, 24 Jul 2022 08:16:04 -0700
X-Google-Sender-Auth: kkyyiZNdyAlw0dnBLyE1naz_uUk
Message-ID: <CAO9H84MXq7K561ky5=UPVTAqZSZeWb0MPtAueASGBrLi=9SfTQ@mail.gmail.com>
Subject: PLEASE CONFIRM MY PREVIOUS MAIL FOR MORE DETAILS.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        T_HK_NAME_FM_MR_MRS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

Recently i forwarded you an important message and i have expecting
your response, please confirm my previous message and get back to me.

Mrs. Linda Harakan.
