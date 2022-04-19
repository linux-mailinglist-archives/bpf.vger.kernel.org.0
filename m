Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32C53506BD1
	for <lists+bpf@lfdr.de>; Tue, 19 Apr 2022 14:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242844AbiDSMLR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Apr 2022 08:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352037AbiDSMJN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Apr 2022 08:09:13 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC4691D0FB
        for <bpf@vger.kernel.org>; Tue, 19 Apr 2022 05:04:44 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id y11so2666762ljh.5
        for <bpf@vger.kernel.org>; Tue, 19 Apr 2022 05:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=0BD1YJUW4GE6y35SJ7GlRNiQgZaoN0rr8UQl3j8HsrE=;
        b=B+A+VCBQ6+hwiWgOiu+/tontW2tmxWIJxsDLt1eb8HvJbtLMpYZmYhn0W3Mjz3wUJD
         ML0E/S4iFJU5GMeJNmqYVBXb0Exm4LLl2p05Q2dI0N4RguAssamFwj3Tp+TATFygp6Sk
         ktmsOk1g/CXoHJnxD/m04Qy02quedt95Se6Ca4h7ua9LxkUJZ0aqcYDAWsYI8K+A9+2O
         AYKWHioe8S3mfy78ZO7hjXeGy5VHh3LhbIvYhB3NharD2Ndi1mLL21yYT9ro9z7VB8Ik
         lRMpt1xPhHeLFfrt0Oqw517sn3IVzoHbC12rsz38mv82Tn2vgPf8dB1pS4gmJ8JQNgN2
         4Kuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=0BD1YJUW4GE6y35SJ7GlRNiQgZaoN0rr8UQl3j8HsrE=;
        b=xDkfj89JcUzbXi8rNhcdRE70rojunNlZlYSMbnNk53H26M4aInZuZ/tRQSI58mbXK6
         vLgHNO/l8md9AQPhOmxlgBDr0KPn5NgNr4WWZ0HC66/l9+Lg2CAxQM3UwQUWxIv2QiZ0
         r8PhtkZxs4MbAvOqGlbNNY1oyGcSaaiHwp5cD8BYBuGgBvS+5EbGAGssVf50syMBLUsr
         f6Oz5qqJSrJJDzFnLMwMijnk8FgQPOwqbqk4nWMW5E5tteUy9JfseKd8/ZKYljZqBdwp
         3wqbEHtENvFKbZD35G5gNDkvQ2wROC4FwDSnpXFcTXKEhMMmrHJqMrN6flQloXcZIkvi
         +Huw==
X-Gm-Message-State: AOAM532yVFhYSgS0jHRarB92nIVO28/5Pw5KY3YQI5khsvPRTG/XFtCn
        RR68X3G/B250EKlEOLZqf2E8NcyNwdIyfVmgTag=
X-Google-Smtp-Source: ABdhPJxx1/q6MEGagZcWDJsimnTfGxCBm7khFyX373wXsF5tHpr1ys05M4GylT8TLLopitnQ4ifbxT+tJsdz2Yif7qM=
X-Received: by 2002:a2e:1542:0:b0:249:a4dd:8ca5 with SMTP id
 2-20020a2e1542000000b00249a4dd8ca5mr10046419ljv.303.1650369882274; Tue, 19
 Apr 2022 05:04:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6512:b27:0:0:0:0 with HTTP; Tue, 19 Apr 2022 05:04:41
 -0700 (PDT)
Reply-To: sandrina.omaru2022@gmail.com
From:   Sandrina Omaru <sandrinaomaru27@gmail.com>
Date:   Tue, 19 Apr 2022 14:04:41 +0200
Message-ID: <CADJWPHFO+UXDEYeXt5LmkV=r0i5vr5ic95yGZ1_HwK+sUgEJgA@mail.gmail.com>
Subject: Dagens komplimang
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:22c listed in]
        [list.dnswl.org]
        * -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0000]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [sandrina.omaru2022[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [sandrinaomaru27[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [sandrinaomaru27[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.6 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  0.0 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  2.1 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Dagens komplimang

Det =C3=A4r en respekt och en =C3=B6dmjuk inlaga, jag ber att ange f=C3=B6l=
jande
rader f=C3=B6r din v=C3=A4nliga =C3=B6verv=C3=A4gande, jag hoppas att du ko=
mmer att spara
n=C3=A5gra av dina v=C3=A4rdefulla minuter f=C3=B6r att l=C3=A4sa f=C3=B6lj=
ande v=C3=A4djan med
sympatiskt sinne. Jag m=C3=A5ste erk=C3=A4nna att det =C3=A4r med stora
f=C3=B6rhoppningar, gl=C3=A4dje och entusiasm som jag skriver detta
e-postmeddelande till dig som jag vet och tror av tro att det s=C3=A4kert
m=C3=A5ste hitta dig i gott tillst=C3=A5nd.

Jag =C3=A4r fr=C3=B6ken Sandrina Omaru, dotter till framlidne herr Williams
Omaru. Innan min far dog ringde han mig och informerade mig om att han
har summan av tre miljoner, sexhundratusen euro. (3 600 000 euro) han
satte in i privat bank h=C3=A4r i Abidjan Elfenbenskusten.

Han ber=C3=A4ttade f=C3=B6r mig att han satte in pengarna i mitt namn, och =
gav
mig ocks=C3=A5 alla n=C3=B6dv=C3=A4ndiga juridiska dokument ang=C3=A5ende d=
enna ins=C3=A4ttning
hos banken, jag =C3=A4r undergraduate och vet verkligen inte vad jag ska
g=C3=B6ra. Nu vill jag ha en =C3=A4rlig och gudfruktig partner utomlands so=
m jag
kan =C3=B6verf=C3=B6ra dessa pengar med hans hj=C3=A4lp och efter transakti=
onen
kommer jag att bo permanent i ditt land till en s=C3=A5dan tidpunkt att det
kommer att vara bekv=C3=A4mt f=C3=B6r mig att =C3=A5terv=C3=A4nda hem om ja=
g s=C3=A5 =C3=B6nskan.
Detta beror p=C3=A5 att jag har drabbats av m=C3=A5nga bakslag till f=C3=B6=
ljd av
oupph=C3=B6rlig politisk kris h=C3=A4r i Elfenbenskusten.

Sn=C3=A4lla, =C3=B6verv=C3=A4g detta och =C3=A5terkomma till mig s=C3=A5 sn=
art som m=C3=B6jligt. Jag
bekr=C3=A4ftar omedelbart din vilja, jag kommer att skicka min bild till
dig och =C3=A4ven informera dig om mer detaljer som =C3=A4r involverade i d=
enna
fr=C3=A5ga.

V=C3=A4nliga H=C3=A4lsningar,
Fr=C3=B6ken Sandrina Omaru
