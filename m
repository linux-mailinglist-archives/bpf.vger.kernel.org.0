Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 998E9492544
	for <lists+bpf@lfdr.de>; Tue, 18 Jan 2022 12:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241107AbiARL4m (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Jan 2022 06:56:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237808AbiARL4j (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Jan 2022 06:56:39 -0500
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0369C061574
        for <bpf@vger.kernel.org>; Tue, 18 Jan 2022 03:56:38 -0800 (PST)
Received: by mail-yb1-xb44.google.com with SMTP id 23so799457ybf.7
        for <bpf@vger.kernel.org>; Tue, 18 Jan 2022 03:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=rF60vm/8dNwvA4UcIattIMqMmIBYqOWiYQ4XAq5dQ6E=;
        b=XhQoz/0fJEaNMbFMy17FjV/yTc5n2ZM4dlwLFg59dSkFDLn3jHuCG8QNAwfoMxar6u
         nK8MPqTZH4tkVsDjtvMzltNC1sWIKdPKYz4iaDQwbzuqIeZTl4X0fdXjPijEwk/+ohmq
         UTglJvr4da05iOS9mLZ8G5Ixrz4kh8Pkja0i2bf1mhBwWRzC0N6yUf90+PSJO804OFB+
         SfMPgcfM0sIJ2gBwyT1TDmoxMlEPBhBc7pNGNxEAGIibkYKqPPcS9d/Ew1aS40sL02Ei
         ZcMGdDCOnHUQmYZXj7n6af6OUIx1XvydbP2MAdW/Tf/qIBFeiFpVW2ZFwxYF893Q3XgW
         Tj7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=rF60vm/8dNwvA4UcIattIMqMmIBYqOWiYQ4XAq5dQ6E=;
        b=JNJbrusBe/e7U+9I28acfErpEaCT04oTadSUWkDCNo0jQABxVHs9T6wuksVofxhmUW
         zaL2pyebMQOw+03vIff85Mcqj5F3nUI8DX2z9OKEOcXvadzwQ4E5LYyYjggTsO64/L/i
         4jy4eQetKh0SrX0OUUGIiBXYGBU4bxFdAfzX6aHWeWyFDar55oxT/ewsrSOcKFq3rVTM
         XM7ynkDbHYTMTVNHYzC3UkaYjfL9aOqsGQSbD/6eP1FvBBUhN688Ih04NIieotok8EHt
         6sJjsXDCTs5gEJfxqtPQiIFdhzmUbOjGnp3EZHQRS0IXIXyW+KKSmNkgtAK8hjs+W/Lr
         e8yg==
X-Gm-Message-State: AOAM533+cno2XEc45YxVw4yuNi9fsyKZ402jCxl2rYf0aBt5wUmw1yC+
        TAB/J4L3S9BW+VqZR7fRMavqSl8fo5fJ20jn1iM=
X-Google-Smtp-Source: ABdhPJzNcSg0c3oxrTb0DY5hGcQG5W3ER5iMH2UI3nKG7E158eQ+vorkpjLboTLUvCmaVlhLD4bstiXCvYi+Y6WG/M8=
X-Received: by 2002:a25:268a:: with SMTP id m132mr6770605ybm.508.1642506997368;
 Tue, 18 Jan 2022 03:56:37 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7000:a30a:0:0:0:0 with HTTP; Tue, 18 Jan 2022 03:56:36
 -0800 (PST)
Reply-To: djene.conde2022@gmail.com
From:   =?UTF-8?B?TWlzcyBEamVuw6kgQ29uZMOp?= <sandrine.tagro205@gmail.com>
Date:   Tue, 18 Jan 2022 11:56:36 +0000
Message-ID: <CAHnAOcFKfuBJreyVCQ=bfp1M9ZG3DBX+_S3D30O5Brdzx=NTqA@mail.gmail.com>
Subject: Good Morning my good friend.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

--=20
Hello,
I am sorry that my letter may come to your mailbox as spam because of
internet exchange. I am Djene Cond=C3=A9, the daughter to the former
president of the Republic of Guinea who as toppled in a military coup
on the 5th septembre 2021. I solicit your assistance for a fund
transfer to your country for urgent investment on important projects.,
If you are interested to help me i will accord you twenty percent of
the total fund. Please contact me here: (conde.djene2022@gmail.com)
Rgds
Djene
