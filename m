Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4ED54B06D
	for <lists+bpf@lfdr.de>; Tue, 14 Jun 2022 14:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbiFNMSM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Jun 2022 08:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232361AbiFNMSI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Jun 2022 08:18:08 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549402E68E
        for <bpf@vger.kernel.org>; Tue, 14 Jun 2022 05:18:05 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id d129so8342831pgc.9
        for <bpf@vger.kernel.org>; Tue, 14 Jun 2022 05:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=cayK0H6IQy1d0QUC88HsF24/yaLJdFvFfYMkqrp9K4s=;
        b=E2SUOZJCz6pmLMYz4zN0KVs/xs8taCZDuWAjO+i+ynuuP8makTTK/dEmFq+NoXOq67
         NvUKfTDGvvKb9HRQfnjjcIS64ix/PG2g8T0nMhuEc05KesPqwOaEMlk7MPtfAmZICxPr
         wPu4f42ICtqWKVDixRj8Na7vXQHtQfH2nKkJYKdWI8Ag79G6VidEfi9NgUbVDK3WyZIz
         jpmVqMRBsSOzBfLxxAOqEhEjhtB+mhUrjXIEQXBlOYeVLTp6H3qlTivvpx2OgzlBbh4x
         u98FWuS6OBhpHXLv5UNULUEt8U8OJZsffbS5QmWXyZnDdvVKp0HOcyqezwcW32+cnpKx
         97dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=cayK0H6IQy1d0QUC88HsF24/yaLJdFvFfYMkqrp9K4s=;
        b=wSnXIqz0/HXejdEtihBdTgDvy0Ad+QhbDcbqERhqoUA167rUzVPteQ+J+JpU1QmqxR
         PqMpBXVCaF8c8mHa+zTEvQ9U/fklFLUzT2UNACGz+IA0JALkTrt+d92wVnnk0YvuNGFo
         Sh4H30SiRvlhBbcKm6rzMmpAb3/thZlzR1qV65YSwyJ6MasJc9cClOdxY+3iAU00z/Bp
         yspSfck1KVf2x7LSvaJUY/xZEgDale4hmbmVMzNf1mw4OO4VIK1QO5GW2t7uzA1lDr3y
         QvF2Q4nhePhysSQVgman3KJQDo4jMuwFSkFCZi3irWBqGtFec/QLMB7gHYUhlPqJ7F3+
         PVHQ==
X-Gm-Message-State: AOAM532oQrB0/830LB9qzXDscXZf26mCd+J660ZN5pMbXImexY+3xf6u
        Qo5dCZ6fCJgaRmVTOcseCyPcHXgDKB+Z2nSpuJk=
X-Google-Smtp-Source: ABdhPJwu1iOD3+9BARY+VAs97lESwSzL7kaa9T8lYgTf89GdFHBUl8dpVSt40qCxVdx4RMjk1CRWxRsXtTdiO6F41Ag=
X-Received: by 2002:a63:f253:0:b0:400:14af:760f with SMTP id
 d19-20020a63f253000000b0040014af760fmr4296509pgk.221.1655209084960; Tue, 14
 Jun 2022 05:18:04 -0700 (PDT)
MIME-Version: 1.0
Sender: rosekipkalya934@gmail.com
Received: by 2002:a05:7300:8b84:b0:68:2780:ebea with HTTP; Tue, 14 Jun 2022
 05:18:04 -0700 (PDT)
From:   Ibrahim idewu <ibrahimidewu4@gmail.com>
Date:   Tue, 14 Jun 2022 13:18:04 +0100
X-Google-Sender-Auth: tev7PCQPzmswgxiEzD2OfGQPa70
Message-ID: <CAMUcbaN0Tk56JPpxg=JcA2Na_L7nXp0Tkh1tmP_y7FGSfzX_WA@mail.gmail.com>
Subject: GREETINGS
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.4 required=5.0 tests=ADVANCE_FEE_2_NEW_FRM_MNY,
        BAYES_60,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FILL_THIS_FORM,FILL_THIS_FORM_LONG,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,MONEY_FORM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_MONEY_PERCENT,T_SCC_BODY_TEXT_LINE,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

I have a business proposal to the tune of $19.3m USD for you to handle
with me. I have opportunity to transfer this abandon fund to your bank
account in your country which belongs to our client.

I am inviting you in this transaction where this money can be shared
between us at ratio of 50/50% and help the needy around us don=E2=80=99t be
afraid of anything I am with you I will instruct you what you will do
to maintain this fund.

Please kindly contact me with your information if you are interested
in this transaction for more details(ibrahimidewu4@gmail.com)

1. Your Full Name.....................
2. Your Address......................
3. Your Country of Origin.............
4. Your Age..........................
5. Your ID card copy and telephone number for easy communication...........=
....

Best regards,
Mr.Ibrahim Idewu.
