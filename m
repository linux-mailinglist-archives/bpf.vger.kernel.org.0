Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C120458AEA
	for <lists+bpf@lfdr.de>; Mon, 22 Nov 2021 09:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbhKVI77 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Nov 2021 03:59:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbhKVI77 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Nov 2021 03:59:59 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 450F3C061574
        for <bpf@vger.kernel.org>; Mon, 22 Nov 2021 00:56:53 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id h12-20020a056830034c00b0055c8458126fso27885282ote.0
        for <bpf@vger.kernel.org>; Mon, 22 Nov 2021 00:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=KAbhMQt4nCgWni6Pt6IcGkUBR1XzjBlAXekRoPKEnOo=;
        b=bnJk9BXBDIBwCHVMymSn+XZSXxXGkTDS26rAaw+t2tmPHCjM1BO5uEmmksaO1x63EP
         UQ3/d5XMcs7U0gIXjrA2VGOgouZwnkK+Ugdk8elkP/fgE3HDqSOP/KWE09Kb6FH24r2M
         enmJdAvpuEmWqlMbHJtMVGQ1QWHFek8tiSDxdlvRA96zHJXJ36vVefZhanUYOMXLRWG+
         IStesZwGFSKM6d+BN86t++1phv4Z6Pko82yxFCWvdt8WLpfw/ATmMHnTaHdCDd6eH1c+
         q9pXS8T0/Ro/rSizWxAOwFdqHVssyI1Uxn1mJ33qXG97VPx5z2yhTBv0ESd5BbyFP3Vu
         /JsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=KAbhMQt4nCgWni6Pt6IcGkUBR1XzjBlAXekRoPKEnOo=;
        b=CUeuE5TtEwopfvZQ0zVrHm849DF5Pj1Z5b+3OJozjTV8KDFqaYMWBcRLVMXM5dZAe6
         gBNSovV0hNoqZbnqGanIVnUFeGcOlxQAEay2u6zn4uONrltfbmaks0SU5AhcBMiQ991T
         g7lxCRt0tk2G/Nzk4YImqwauLDJJ/lYelvhs9nFRlKqKZg1HuyQ3kwg+iL4KCf4r6faX
         +vQ2ZWdMpnjP0QglOIg8ON6nNRQAu9P1HvoVBjEBdJgFlLUaZCA55XcVLetGyEJogDdy
         XEyX3YIKiXNTxrA6VFSxHuXc9O3w7FmDLB4Nx+qIcC7uBIPtnZh5QyHg/zDy0Z177T4I
         ayYg==
X-Gm-Message-State: AOAM5334OfPbh75Eczp3BZb1uR82qznmLFDd98RM469sQRcluaeYLON7
        nXu9m9jg/xVZr2EPGl4YHNtzPhQe7ALPVPYd07Y=
X-Google-Smtp-Source: ABdhPJzNWL0EX1n5YSx0w4mnRIokbe1AbOH12+SRJRqry0XBeWRDXpqotIDPQk9o2sXkl6Dc/x8fkCgcC4qXFxKNtio=
X-Received: by 2002:a05:6830:195:: with SMTP id q21mr22903584ota.355.1637571412553;
 Mon, 22 Nov 2021 00:56:52 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a4a:7a49:0:0:0:0:0 with HTTP; Mon, 22 Nov 2021 00:56:51
 -0800 (PST)
Reply-To: justinseydou@gmail.com
From:   Justin Seydou <hamidfaith031@gmail.com>
Date:   Mon, 22 Nov 2021 09:56:52 +0100
Message-ID: <CAFepVPoo4nr8LRjnba7Gwmqv5Mh-wsT53pT6s0oLCV1Gz38XYg@mail.gmail.com>
Subject: Proposal
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Estimado amigo,

Con mucha sinceridad de coraz=C3=B3n les escribo para informarles sobre un =
negocio
propuesta que tengo que me gustar=C3=ADa manejar con ustedes.

Indique amablemente su inter=C3=A9s para habilitar
Yo les doy m=C3=A1s detalles de la propuesta.

Esperando por tu respuesta.

Atentamente,

Se=C3=B1or Justin Seydou.




Dear friend,

With much sincerity of heart I write to inform you about a business
proposal I have which I would like to handle with you.

Kindly indicate your interest so as to enable
me give you more details of the proposal.

Waiting for your response.

Yours faithfully,

Mr.Justin Seydou.
