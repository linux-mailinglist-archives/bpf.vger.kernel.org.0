Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE9A587E27
	for <lists+bpf@lfdr.de>; Tue,  2 Aug 2022 16:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237284AbiHBOaG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Aug 2022 10:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237296AbiHBOaF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Aug 2022 10:30:05 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B8E29820
        for <bpf@vger.kernel.org>; Tue,  2 Aug 2022 07:30:03 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id q30so13709424wra.11
        for <bpf@vger.kernel.org>; Tue, 02 Aug 2022 07:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=npxCWy2DywcBQq9OCNxxK3fUiVjXtjApy10t54oASAI=;
        b=ffr0snM4pC6o8xS8+vD6fw0m7mTQsymDC5O42+FXJhQsqQZqOnTnvlf9dz1SzZi81q
         taJb9/Iy5Atb8cNttGWnqx5+lQcSevmclBgha5NxNlgmwsosxiV07Lg1Xpw7i9hQvB/6
         ROzY7pQf71Uhr5qGcUNM2HjhsdPBpbJt1w0VnJGAG2JP7CmYlJXy8klPTaw0b1FqCMQl
         BMDKFlnJ64edZ2I79BJ5wWeT8QW3g+vSJeRY7ZN7W6qOJqR/lvBjyTGGEXnMu/A7Putw
         rxqkGOeBecUQ8A7GissET/NzK+Ty4srDgxE/VOmNfdu5Wb/Un60fw1WTZtD+0Bj74CKG
         M0Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=npxCWy2DywcBQq9OCNxxK3fUiVjXtjApy10t54oASAI=;
        b=dGhgRl5E9xUCZpazH+rVcOZ6/4sh1RirAK6sETXTEi/GJ5ia+C3fA9E/cvylCmiHWv
         fpBjkYzHfCwX19iqNyxcnEhdbbOcQBdxlzDj7D5zygGT/DCUk1QGd1dhUMnKu6vDsxdJ
         BBfQVm/Bu36QV8XN1bvfcXuSHbB8ggCG80NFQfEobOnkOEr/nB1USQXuPPYf3DxdCz6g
         lEAMso20pxDDfYlR+77S/kWALpgELRSYqOz76EoZW2d6eAokKk5K7X96kNbPToGxP5CH
         WgO2iDDOPvi1t8AdEsqbNbpo0QxCXP0CqrZmcY6xFiYU/4NpcY71KhdeMh1oXQ4SZ9i7
         q5gQ==
X-Gm-Message-State: ACgBeo1LV9f9MBHl7LRma+MqKYj7z7hoEL8djARkp/XvGGjwW0mZrphS
        3VRteJ58P4LholtMBha2FCQzw49djCLtewFEheo=
X-Google-Smtp-Source: AA6agR7MHHsUtLFzLfZ6HG2DBmKWTWFz+40UKDijQtfvKfVN+wDJE+3ExFgQlB1Z2ffGqcnB+/QXXWtjXOY/6jk/uys=
X-Received: by 2002:a05:6000:785:b0:220:6d7f:dd1f with SMTP id
 bu5-20020a056000078500b002206d7fdd1fmr3310538wrb.578.1659450601384; Tue, 02
 Aug 2022 07:30:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:fb92:0:0:0:0:0 with HTTP; Tue, 2 Aug 2022 07:30:00 -0700 (PDT)
Reply-To: abrahammorrison443@gmail.com
From:   Abraham Morrison <okekeangel538@gmail.com>
Date:   Tue, 2 Aug 2022 07:30:00 -0700
Message-ID: <CA+q1MUD-d-cOYFtFb1-6+h=pT4FxhkunCRk4RZuJzsYXZxSa6w@mail.gmail.com>
Subject: Good day!
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:435 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5069]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [okekeangel538[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [okekeangel538[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [abrahammorrison443[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Aufmerksamkeit bitte,

Ich bin Mr. Abraham Morrison, wie geht es Ihnen, ich hoffe, Sie sind
wohlauf und gesund? Hiermit m=C3=B6chte ich Sie dar=C3=BCber informieren, d=
ass
ich die Transaktion mit Hilfe eines neuen Partners aus Indien
erfolgreich abgeschlossen habe und nun der Fonds nach Indien auf das
Bankkonto des neuen Partners =C3=BCberwiesen wurde.

Inzwischen habe ich mich entschieden, Sie mit der Summe von 500.000,00
=E2=82=AC (nur f=C3=BCnfhunderttausend Euro) f=C3=BCr Ihre bisherigen Bem=
=C3=BChungen zu
entsch=C3=A4digen, obwohl Sie mich auf der ganzen Linie entt=C3=A4uscht hab=
en.
Aber trotzdem freue ich mich sehr =C3=BCber den reibungslosen und
erfolgreichen Abschluss der Transaktion und habe mich daher
entschieden, Sie mit der Summe von 500.000,00 =E2=82=AC zu entsch=C3=A4dige=
n, damit
Sie die Freude mit mir teilen.

Ich rate Ihnen, sich an meine Sekret=C3=A4rin zu wenden, um eine
Bankomatkarte =C3=BCber 500.000,00 =E2=82=AC zu erhalten, die ich f=C3=BCr =
Sie
aufbewahrt habe. Kontaktieren Sie sie jetzt ohne Verz=C3=B6gerung.

Name: Linda Kofi
E-Mail: koffilinda785@gmail.com


Bitte best=C3=A4tigen Sie ihr die folgenden Informationen:

Ihr vollst=C3=A4ndiger Name:........
Deine Adresse:..........
Dein Land:..........
Ihr Alter: .........
Ihr Beruf:..........
Ihre Handynummer: ...........
Ihr Reisepass oder F=C3=BChrerschein:.........

Beachten Sie, dass, wenn Sie ihr die oben genannten Informationen
nicht vollst=C3=A4ndig gesendet haben, sie die Bankomatkarte nicht an Sie
herausgeben wird, da sie sicher sein muss, dass Sie es sind. Bitten
Sie sie, Ihnen den Gesamtbetrag (=E2=82=AC 500.000,00) der Bankomatkarte zu
schicken, die ich f=C3=BCr Sie aufbewahrt habe.

Mit freundlichen Gr=C3=BC=C3=9Fen,

Herr Abraham Morrison
