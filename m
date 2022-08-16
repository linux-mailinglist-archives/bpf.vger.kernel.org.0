Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62F17595629
	for <lists+bpf@lfdr.de>; Tue, 16 Aug 2022 11:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233032AbiHPJ0d (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Aug 2022 05:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233269AbiHPJZ7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Aug 2022 05:25:59 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD4E626B
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 00:42:36 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id z25so13704179lfr.2
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 00:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :reply-to:mime-version:from:to:cc;
        bh=mTe6rsF1WlocKfWRCIawejpNJl6lRYSIlYxDz8jltlQ=;
        b=LvW9WZBe21vUlBeBQXbHfLd28qBTn7OYweibJYCCljp5vzhTPcRZ8VVV5oZtBjd7ae
         0gC3vsEC9thpoqmelNcVxjRJD/urKa4p32FPdvvyZSQHr87eA9zzMCcnI+eYoeTCvs5/
         QKw0isPMrMxEPx28M/pJxBQpiZyhw5aNFD0K3BYEKMttzBBOI+PjDj2TxcnnclcZjeov
         qI4vgSnBKskmdIY6PB/dRH9o4lRRgAZjEQZdA8py3BiRzPNUazUsQCnFst8Tr5OCXkB2
         4JGL3wj3K4meQAE8M808g1LXnxYLSsXw0CTXSJmXquvFavVDZVnZK/q+h1kSvMx/3Nxd
         574Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :reply-to:mime-version:x-gm-message-state:from:to:cc;
        bh=mTe6rsF1WlocKfWRCIawejpNJl6lRYSIlYxDz8jltlQ=;
        b=6JqI+/6GgE9OmDwXC8po+11PnbY22y3J9Ua3Lp/p5Yg7rKeQesogbHgXj08om/iVJ/
         LWFKdydPsnI2r+Dv0UDqIh2FlDc1aMsz+DtM2NgJuG1vyOqhahM5X9IrBXtuvQG3nDv2
         FlTI4Ai+2S1sxVZ2RYp1rMDk8OvlxRjRlFdMjeYN0mE7q0+ZeiMdICkQsSLINv+N2MVP
         /eLeWyWSZXmX7wUHBPdtlUiM502dMeMVfK/v2wcPXNrYhduINcWAVszCO/9/pMYdvn+q
         5npVroE5HW6Lmu4GS1OKlvCC2Sta0c+dI0HHAVzSdRK0obV5/H2U6ccn3X0ZL1dLgADN
         lIxA==
X-Gm-Message-State: ACgBeo0yvB5+UGjzDAVZDV5pVdANDLul+XTIzR59B0qO52shz5iIicI6
        9gSKz1c8PcJJZY2SkCXuJkxBQIritfQSNdTi4Q==
X-Google-Smtp-Source: AA6agR7NseVlkK0DLkru1pfIPQW/O3VPhk4ggLt18WKgwZHGJy8jOQegcY0WSHClhjWUH1Dnm2bkONYBTIZFVXwcGyc=
X-Received: by 2002:a05:6512:3a84:b0:48c:f59e:3bff with SMTP id
 q4-20020a0565123a8400b0048cf59e3bffmr7468806lfu.516.1660635754651; Tue, 16
 Aug 2022 00:42:34 -0700 (PDT)
MIME-Version: 1.0
Reply-To: zahirikeen@gmail.com
Sender: aliwattara1961@gmail.com
Received: by 2002:a05:6500:2109:b0:152:a956:cc09 with HTTP; Tue, 16 Aug 2022
 00:42:33 -0700 (PDT)
From:   Zahiri Keen <zahirikeen2@gmail.com>
Date:   Tue, 16 Aug 2022 07:42:33 +0000
X-Google-Sender-Auth: COGoLTtFf09keS4zvjYrmd0eBvY
Message-ID: <CAFX=yDMk4HLiWj9Ex1aaZV=mfnHLk6XHhwKACRR=JkmHud-uMA@mail.gmail.com>
Subject: Urgent Please.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Good Day,

I know this email might come to you as a surprise because is coming
from someone you haven=E2=80=99t met with before.

I am Mr. Zahiri Keen, the bank manager with BOA bank i contact you for
a deal relating to the funds which are in my position I shall furnish
you with more detail once your response.

Regards,
Mr.Zahiri
