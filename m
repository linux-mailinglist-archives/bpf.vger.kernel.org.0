Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB16E584A46
	for <lists+bpf@lfdr.de>; Fri, 29 Jul 2022 05:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbiG2DnE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Jul 2022 23:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbiG2DnC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Jul 2022 23:43:02 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B1761132
        for <bpf@vger.kernel.org>; Thu, 28 Jul 2022 20:43:01 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id bp15so6331868ejb.6
        for <bpf@vger.kernel.org>; Thu, 28 Jul 2022 20:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=vI4HCnffdrDmImtIppEl6KGtFFJV3X77yRmXj9S8m88=;
        b=crfcQGVlbusoW1fCPqxOGCLfxfdDImyQU9nC4kCMFKQVi1NLXs5SBn/hCrwfsHRaGo
         xY3TYAkWaVT7cEmNIR45TELcUDPNRCAV7jBrGokijzmZPIDB5knuRC/yp+61qmVLXO68
         ++N/hBL62mwYPwHNs61rmEidVknBWnZ/Bg5fq554QkdqNIBYLOQq+xrhe45+8jfFerCV
         wKf5FEBLL+vRCA+C8+IzFahNBRGN1frvpAtZpribt4kQob8CUFSkvpCz3hQLUtwJMmtt
         rvECtQglBRA4Rg4j8IHw0KPY99og9K5SOhIwHmJNuxqQLtyLOScUm0r9MX2NWPLUc2xj
         9nkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=vI4HCnffdrDmImtIppEl6KGtFFJV3X77yRmXj9S8m88=;
        b=sVjOBdXje9yhtGddmLtUJWap8tPy6eaYfu3bjmZzSsZM2JalPzmSCrT7KGxxmhgisb
         XpUshkO70OGLtHNnpZiEsX9zJvKwXmSkX4nOTFzcnNynCjUO/nqmbT4FGs1nGEIn05ZJ
         cqimKOag7Yfx4Z5vUWE2+WteYYGSS/DttlaiNQEIa1RkMh+pK74lTDa75Yzm2UfaZM0o
         dF+9Uj03C9Ect4rXuXRYDn5HRammnDdDbxK+XvHu+kOktEt7pJTNkNrbAuvb2o30EuB6
         kKUqxYsp4vDtyp1nze5usrnD72dH9hpvK3mvx4ZIRMn5v1Y/y3uAHgAE9Xqr7IqrwrId
         IMIw==
X-Gm-Message-State: AJIora+7Ot1E9yq2XaC2WiGLUUEbTZwZ3iYzVdHK1thp4GGXBIARSPg3
        eLYaAMmy7DY7cmUvPec/Zt+wIjpwYOtRZ/cCfEY=
X-Google-Smtp-Source: AGRyM1sam4LP2zAfOlHqYl4kPghNVe0rGOmU53Ym7vMTAFhAN3ABfvkZbDC/7zyEXC5q3T6C82uXzxadW6Wp6IsPgpI=
X-Received: by 2002:a17:906:9b8e:b0:72f:c504:461 with SMTP id
 dd14-20020a1709069b8e00b0072fc5040461mr1442246ejc.655.1659066180113; Thu, 28
 Jul 2022 20:43:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a98:b5c1:0:b0:179:8016:7acd with HTTP; Thu, 28 Jul 2022
 20:42:57 -0700 (PDT)
Reply-To: joseph_anya39@yahoo.com
From:   DR JOSEPH ANYA <jigarpatel808080@gmail.com>
Date:   Thu, 28 Jul 2022 15:42:57 -1200
Message-ID: <CAOeg64R_s-vU+-SJHn3PCSuwfLyO62tPiAjp=03QFC74hDTTnw@mail.gmail.com>
Subject: =?UTF-8?B?55u45LqS55CG6Kej?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: Yes, score=7.4 required=5.0 tests=BAYES_95,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:62a listed in]
        [list.dnswl.org]
        *  3.0 BAYES_95 BODY: Bayes spam probability is 95 to 99%
        *      [score: 0.9824]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [jigarpatel808080[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [joseph_anya39[at]yahoo.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [jigarpatel808080[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

LS0gDQrkurLniLHnmoTmnIvlj4vvvIwNCuaIkeaYryBKb3NlcGggQW55YSDlhYjnlJ/vvIzlrqHo
rqHlkozkvJrorqHnu4/nkIYNCuS6muihjOmTtuihjOWcqOilv+mdnuOAgiDmiJHmraPlnKjogZTn
s7vmgqjkuI7miJHlkIjkvZwNCuWPquWPluWbnu+8iDM5NTAg5LiH576O5YWD77yJ55qE5oC75ZKM
44CCIOWtmOasvueUsQ0K5oiR5Lus5bey5pWF55qE5a6i5oi35LmU5rK744CCIOWwj+eahOOAgiDm
iJHlu7rorq7ljaDmgLvmlbDnmoQgNDAlDQrmiJDlip/mlLbliLDotYTph5HlkI7nu5nkvaDph5Hp
op3vvIzmiJHlkJHkvaDkv53or4ENCuivpeS6pOaYk+aYryAxMDAlIOaXoOmjjumZqeS4lOWQiOaz
leeahOOAgiDmiJHlr7vmsYLkvaDnmoQNCuWQiOS8meimgeaxgui/meS6m+i1hOmHkeS7pemBv+WF
jeiiq+ayoeaUtg0K6ZO26KGM44CCIOWbnuWkjeaIkeS6huino+abtOWkmuivpuaDheOAgg0KDQrm
iJHmnJ/lvoXmgqjnmoTntKfmgKXlm57lpI0NCg0K5q2k6Ie044CCDQrljZrlo6vjgIIg57qm55Gf
5aSrwrflronpm4XjgIINCg==
