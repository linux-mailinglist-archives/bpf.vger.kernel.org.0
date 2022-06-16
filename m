Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4F754D724
	for <lists+bpf@lfdr.de>; Thu, 16 Jun 2022 03:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356728AbiFPBhZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Jun 2022 21:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243323AbiFPBhX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Jun 2022 21:37:23 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218D8443E7
        for <bpf@vger.kernel.org>; Wed, 15 Jun 2022 18:37:21 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id v1so26431361ejg.13
        for <bpf@vger.kernel.org>; Wed, 15 Jun 2022 18:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=1kHhIidVOs0bZvu1mvilMjAHxoDp2iPxojmTkeNKlYM=;
        b=NKcNoAt8jX7PrmmXB0moefuQGhuQyILDYYhEoCQhdvhbHuxo9vFizPYY1biy0EJ6bt
         32R5JxGevu7vcisj2/jbnt7gpouGMtiYDwLImkrU7PpBSQGnOX0kpQaIYzmOGEfaHdD0
         YPv3rX94xExCgZska+yH0H3eFbMAhwbaiDFbuY+i1MkKfwg9kjU1JzqFTNNf8yG0wizM
         fnhyE8xkjGFutwQg7cBDnXiUDsD/GRt9FeJNNmbRtD4N6TG13mD0+grmrRCX77g1oowP
         m0MRknSNbW2uF7eX1HugZ3/9jQ0kFWqJ6tkkadsIfDlAwWzItNMV4osHCYClq/6omXRA
         Nj2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=1kHhIidVOs0bZvu1mvilMjAHxoDp2iPxojmTkeNKlYM=;
        b=inPAbWQgz4RGAkywNq/uBitcqiQeUh4nJqwwPftnLDMbpmi8mhpZy8uOqvnkGyHO/B
         Kx/zCJFP2DUEyeXxQXjkCqRsWK1ObUjs7htrAaGq5Apuj5CkphIon3PR7RzP32WYGG+t
         4TTV9Qn1AzJqKnoC/0Sfu8E6Ouwrd14S5f6QRlu4AO2VoSX/Y9yaAjgPp32Y7h/Q/CwJ
         Wyimx2bKfzWV0eeiULJQTFxyVhWz27EeIqvbKGloebGjjOTzzvtz1rri3U+K2/LaMwp0
         pJjNsSTtnlxbQVlBgnwASs3cBMFC5o3iJchBqaVYrrTfM/DNFl95rtA+zjmrk833/O7e
         CTng==
X-Gm-Message-State: AJIora+c+w3vEPAU8by4jgDkzwBSjL8v1jfW1qtgTYthN3AjUFpRT0vZ
        hsg4CsqWmiciHw7724XH7hdAG3WIIlVWx6CCp5M=
X-Google-Smtp-Source: AGRyM1umP8j2RgB1oBFCNeeIedLLns2SD10zLc7PHDkVqEbs0CCNg+psxOko6PBl88V9Cqkjt4k6/YFzbBFIRwJH+Ck=
X-Received: by 2002:a17:906:4d50:b0:70d:afd4:1e63 with SMTP id
 b16-20020a1709064d5000b0070dafd41e63mr2478130ejv.618.1655343439794; Wed, 15
 Jun 2022 18:37:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6402:35d0:0:0:0:0 with HTTP; Wed, 15 Jun 2022 18:37:19
 -0700 (PDT)
From:   Elizabeth Blaz <elizabethblaz06@gmail.com>
Date:   Thu, 16 Jun 2022 01:37:19 +0000
Message-ID: <CAPxMj5nbWZsZh2JXKfXN0aYBppnO82_K_ONySO6r46Jt90LZ_Q@mail.gmail.com>
Subject: 028
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

KINDLY  confirm to me that this is your correct email address.Thanks,
From
Mrs.Elizabeth Blaze
