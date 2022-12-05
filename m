Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47601642CAB
	for <lists+bpf@lfdr.de>; Mon,  5 Dec 2022 17:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbiLEQTe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 5 Dec 2022 11:19:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbiLEQTd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 5 Dec 2022 11:19:33 -0500
Received: from mail-oa1-x42.google.com (mail-oa1-x42.google.com [IPv6:2001:4860:4864:20::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43DC61D0C2
        for <bpf@vger.kernel.org>; Mon,  5 Dec 2022 08:19:33 -0800 (PST)
Received: by mail-oa1-x42.google.com with SMTP id 586e51a60fabf-1445ca00781so7428280fac.1
        for <bpf@vger.kernel.org>; Mon, 05 Dec 2022 08:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O4WPtqOs6pYDke8VCfpzwsIX+8zN33o8tLS2XMy/lFU=;
        b=HFkrIq0moJZmzClqyLY3vKOBtHX1vx+c9Lmz3PVuRFus0dgIh3p+1+r+57xwgIvxGJ
         u6wSKxd7geaSqAqrlKDJ7OlDUTwSip0ilZpoDh4rKUFvdN1qA4+s65omj0mqhkwbYhoR
         nPG9Q8Hz4/WJOLgzP53toTdXQa4jhHLRwsIJB/Khf1rQ6Vhx3WHmxLDiWLfKu7n7tjP/
         ETDWhwqRw54QubQ916G9PVdV35ShsHaPIbuZIM5lWMxXiCrdTZeVg+ZuXNchYHGfzvJW
         Nz05EwYx4GMnh5StSVpj6RAnokd7Za2v/oXFLVAbjsF29emXjBYLMp8MwfZZzGoHmKbS
         9sEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O4WPtqOs6pYDke8VCfpzwsIX+8zN33o8tLS2XMy/lFU=;
        b=i6k/Mem+T/RLGkgv0EXMY5DouW8NeOeBakm1AkNk6gf3aGmmOwC8SVAkBL04+zQ6O1
         YQ0ABkZQWX2aI1Fr4zvzGQYq40gWfa3cSubFNgpIu/vZ8Chp5GmCyF128Lkg24nq3sHq
         V+/+7XOTtaoP3K3pIG08ot4XF59jkjDsWruMNNHJzk9our4cgNZ7tY+H9gsS6NMChL2b
         V4ca9HpsFdK2D1Ht8lAv0QFu3I4/Ylz02TkJ8VT1YuNvKesszSmQnNfdAM55xE7zda7G
         Ts5hy5F6qZRlBiovf9OaVuA7IE6zmV8pQ62pW4JL8q055UYp99llbTWjNAE0ZeGcrmQ3
         hOBw==
X-Gm-Message-State: ANoB5pn+kNYfOonXA2jbdTlM6SgmlcmRibZz2QZsb3f9itH/xNqQEwIA
        scerAkK86Wn44blY/S5ppg6NxuQorqIiW0lsCZk=
X-Google-Smtp-Source: AA0mqf6lhwBOaMZdn0XLh7k0l28F2jsvVN7Nz5AzJJRK6dvtxt7XY+EQi2p39luxNA8ti8bOr7GvxRLJHKXK0oeLU1E=
X-Received: by 2002:a05:6870:d608:b0:144:b4d9:4a37 with SMTP id
 a8-20020a056870d60800b00144b4d94a37mr1224059oaq.117.1670257172601; Mon, 05
 Dec 2022 08:19:32 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6870:5ccc:b0:143:84e0:abae with HTTP; Mon, 5 Dec 2022
 08:19:32 -0800 (PST)
Reply-To: phmanu212@hotmail.com
From:   Philip Manul <phmanu005@gmail.com>
Date:   Mon, 5 Dec 2022 08:19:32 -0800
Message-ID: <CAFKg=dbnbvTXMp7SoCeKJ8m5vdUGsz5_fZTZmLfwfeda9vuULQ@mail.gmail.com>
Subject: REP:
To:     in <in@proposal.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=2.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

--=20
Guten tag,
Mein Name ist Philip Manul. Ich bin von Beruf Rechtsanwalt. Ich habe
einen verstorbenen Kunden, der zuf=C3=A4llig denselben Namen mit Ihnen
teilt. Ich habe alle Papierdokumente in meinem Besitz. Ihr Verwandter,
mein verstorbener Kunde, hat hier in meinem Land einen nicht
beanspruchten Fonds zur=C3=BCckgelassen. Ich warte auf Ihre Antwort zum
Verfahren.
Philip Manul.
