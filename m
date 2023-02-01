Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1AD0685FB5
	for <lists+bpf@lfdr.de>; Wed,  1 Feb 2023 07:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbjBAGRB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Feb 2023 01:17:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjBAGRA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Feb 2023 01:17:00 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A578310F9
        for <bpf@vger.kernel.org>; Tue, 31 Jan 2023 22:16:59 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id m7so16239027wru.8
        for <bpf@vger.kernel.org>; Tue, 31 Jan 2023 22:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Kel+mityrC9eNLIRxaecNWULDYsgmoq8gcjtounsZM8=;
        b=jwqwkMFoOJOS2Z4fUJrIiZCm3qs/ffjDnZu/45tfIpLX/fcCPuYTGgKM7fi61z95Q/
         VEVEbQ4gvBedUGO3hNaQg5pJg9+P2T4MpnLMqeYDryWsqGMmhBneN38p1Bualb8AVS+e
         gf5/iYEA5twZ9E1Ogc0kcH3TacRkrYIQSYMcbJP85GZMD21OxssilNuoUwRW7s5vsKeF
         Kqam38y+9uyz0gGsmsLcvu50I1w6Dh9wgui81gyNtztsZEDfUVWBNeftghv1unzLdH+x
         fa4Po0AHidr+sNoDa3mp6HIrhFhn0gDIjwOkr/qUl9BazoDwjx4vFu8KjbFB1MW5f0kZ
         DgTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kel+mityrC9eNLIRxaecNWULDYsgmoq8gcjtounsZM8=;
        b=6HeJ64VvUk8uhu0SnlB+2OuZiSM7rwNbFbiuDAcPuZnSXOgD6tF67eoEMALG9ty5x0
         OzGlqCu8xR9Z352L3B1kERl2wCQW4mlYgk+zLdjS4JSk2KftKwSLtJ5h9V1Z0IlInmAw
         NcMlYgpM31WZo1NZ++m31KtFSfwRT34jqBwk4b7kEX6T7zz2/TZAvfLv5XDeUJVpdsfL
         zXG3cc69g6crZ10MoI7/eTn8BA+bblMs2Xs2RcixiDZ7z3oNTBs9Zum2eP+ZIwTD9t5N
         5HwUufDFdNUDTpI4wL/tuHIYd/KJU7V9oU4owFnKtlkQZfV0N4qVA3NENdL6yVB1NKyw
         PsyA==
X-Gm-Message-State: AO0yUKWV5SRJ0Mn1Jwsfata9BkqVgWd2XwJfig4k9Q62YB/q/pSFDs6u
        e+opuJVIFDaAaJumaP6eZ6e/PYnYPh1QM5swKSpT5XBx
X-Google-Smtp-Source: AK7set9hIwLJ/D+w0bEjiWWDuZeBgKOhczCVHjt3Qg5N7xFfvyQOJHWroXZQDeNrg/hcCrLV0zmc+fy5ZM7VjaIv1EY=
X-Received: by 2002:a5d:4e45:0:b0:2bf:f7c0:f94c with SMTP id
 r5-20020a5d4e45000000b002bff7c0f94cmr66334wrt.128.1675232217611; Tue, 31 Jan
 2023 22:16:57 -0800 (PST)
MIME-Version: 1.0
From:   Dushyant Behl <myselfdushyantbehl@gmail.com>
Date:   Wed, 1 Feb 2023 11:46:45 +0530
Message-ID: <CAHF350LaCGPZL_e__5s04PO466eGnA9uM61rc1eQAu-0N8jhJA@mail.gmail.com>
Subject: Adding map read write API to bpftool gen skeleton sub command.
To:     bpf@vger.kernel.org, Quentin Monnet <quentin@isovalent.com>
Cc:     palani.kodeswaran@in.ibm.com, sayandes@in.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi folks,

I have been testing the use of BTF to generate read/write API on maps
with specific key value types which can be extracted from the BTF
info.
I have already developed a small tool to test this which uses the BTF
information in the ebpf binary to automatically generate map
type-specific CRUD APIs. This can be built on top of the libbpf api in
the sense that it can provide key and value type info and type
checking on top of the existing api.

Our goal is to ease the development of ebpf user space applications
and was wondering if this feature could be integrated to "bpftool gen
skeleton" sub command.=E2=80=A8I was wondering if you think that such a
feature will be inline with the intent of bpftool and will be of value
to its users.
I am happy to have more discussion or a meeting on how this could be
approached and implemented and if it would be a good addition to
bpftool.

Please let me know.

Thanks,
Dushyant
