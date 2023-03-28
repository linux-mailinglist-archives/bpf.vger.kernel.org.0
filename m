Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE436CB918
	for <lists+bpf@lfdr.de>; Tue, 28 Mar 2023 10:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbjC1IM1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Mar 2023 04:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjC1IM0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Mar 2023 04:12:26 -0400
X-Greylist: delayed 382 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 28 Mar 2023 01:12:24 PDT
Received: from mail.simsborovin.com (mail.simsborovin.com [89.40.118.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C87A3B1
        for <bpf@vger.kernel.org>; Tue, 28 Mar 2023 01:12:24 -0700 (PDT)
Received: by mail.simsborovin.com (Postfix, from userid 1001)
        id 3DF6685BC8; Tue, 28 Mar 2023 09:05:58 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=simsborovin.com;
        s=mail; t=1679990763;
        bh=so3xiFooQ9N0D/cd/+ivPaO6nnHsd9cY/G2xa/w5Tfg=;
        h=Date:From:To:Subject:From;
        b=UaVw3/g4eaN6lXsPrcyhs6PA3oG+K74fPebGmQuBA9kqEDbzpqfEPmlAkz06mDs1L
         ZJSFdNOBR9/vgnnz7es4Ujvz8vH+R827a7rHFHaPOC1sz0J8mfWnUz0PPVFQv4wYCb
         bM/1P0n8l5dOCYP6Wfz3XTR/3uSBL3xPUpIDBGRyMfRUssUNfCoFGiQKNwRAwH7lxF
         rHH4ERLTuSTQ1jm2xxDUNnwhLeRgoSfGRuwXizIdR6EXdZxz0kzJ3kyiKTuHJKmHdF
         2eULbBC2diwbB6NmmNRzK6p7eOuaFpLtyYX39ITJsKvnT4z8xtsrxSZZUZ7tGauABt
         ZVwvNd5hWovKw==
Received: by mail.simsborovin.com for <bpf@vger.kernel.org>; Tue, 28 Mar 2023 08:05:53 GMT
Message-ID: <20230328074502-0.1.2m.3lgx.0.04lhejbol8@simsborovin.com>
Date:   Tue, 28 Mar 2023 08:05:53 GMT
From:   "Konrad Trojanowski" <konrad.trojanowski@simsborovin.com>
To:     <bpf@vger.kernel.org>
Subject: W sprawie samochodu
X-Mailer: mail.simsborovin.com
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_SBL_CSS,RCVD_IN_VALIDITY_RPBL,
        SPF_HELO_NONE,SPF_PASS,URIBL_CSS_A,URIBL_DBL_SPAM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: *  2.5 URIBL_DBL_SPAM Contains a spam URL listed in the Spamhaus DBL
        *      blocklist
        *      [URIs: simsborovin.com]
        *  3.6 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
        *      [89.40.118.18 listed in zen.spamhaus.org]
        *  0.1 URIBL_CSS_A Contains URL's A record listed in the Spamhaus CSS
        *      blocklist
        *      [URIs: simsborovin.com]
        *  1.3 RCVD_IN_VALIDITY_RPBL RBL: Relay in Validity RPBL,
        *      https://senderscore.org/blocklistlookup/
        *      [89.40.118.18 listed in bl.score.senderscore.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Dzie=C5=84 dobry,

chcieliby=C5=9Bmy zapewni=C4=87 Pa=C5=84stwu kompleksowe rozwi=C4=85zania=
, je=C5=9Bli chodzi o system monitoringu GPS.

Precyzyjne monitorowanie pojazd=C3=B3w na mapach cyfrowych, =C5=9Bledzeni=
e ich parametr=C3=B3w eksploatacyjnych w czasie rzeczywistym oraz kontrol=
a paliwa to kluczowe funkcjonalno=C5=9Bci naszego systemu.=20

Organizowanie pracy pracownik=C3=B3w jest dzi=C4=99ki temu prostsze i bar=
dziej efektywne, a oszcz=C4=99dno=C5=9Bci i optymalizacja w zakresie pono=
szonych koszt=C3=B3w, maj=C4=85 dla ka=C5=BCdego przedsi=C4=99biorcy ogro=
mne znaczenie.

Dopasujemy nasz=C4=85 ofert=C4=99 do Pa=C5=84stwa oczekiwa=C5=84 i potrze=
b organizacji. Czy mogliby=C5=9Bmy porozmawia=C4=87 o naszej propozycji?


Pozdrawiam
Konrad Trojanowski
