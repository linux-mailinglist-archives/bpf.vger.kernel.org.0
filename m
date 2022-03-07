Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADD414CFF98
	for <lists+bpf@lfdr.de>; Mon,  7 Mar 2022 14:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235240AbiCGNJC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Mar 2022 08:09:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232885AbiCGNJB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Mar 2022 08:09:01 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17AE5BD17
        for <bpf@vger.kernel.org>; Mon,  7 Mar 2022 05:08:05 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id o6so20329293ljp.3
        for <bpf@vger.kernel.org>; Mon, 07 Mar 2022 05:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=S3JtR5HtN5TgHtZRkOpXh8ju3yrdK90cRx1M8SbEib4=;
        b=B5Dmilo6ujAlDZ6Wwc4TfaB2dpifzawGX8iIGwVktMbBHgwJB2n8nPe5mpAsj/aH8Q
         yqKQ6HvM5TjzzAiCHCqaEYStAE1ANAdfsHs+8XWyMbnkVYPfIINxypgR+FLJNugPRXtg
         OhQe4+nnsOuobLGis4BzmHdgamAgK8RHMqh0qP4ZvCOa2sGtcpaqt+6EF0YY1Uyg/+wv
         7e2KISQMCWaCMaKJXjmH8AqPJHRsppmT26LaXg4GGfGa4yaOlJjTkW/Cx867aZEcrqN1
         GPtINpgyQYYC1cZlb+PuAJAbc+/eo0DezZ8MJghVQ1CdN2WpPxzDhX+arlntjEOChbtL
         DT1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=S3JtR5HtN5TgHtZRkOpXh8ju3yrdK90cRx1M8SbEib4=;
        b=WtyVyCfr/tZZ75L9Kj2A7gzrOiBvFhAe1LVcI6weUqzOy7A/y/gL1pDAAS3Xv/XFlc
         y9158wbNcJCULz/c9qEpFSmd3oBSW+Q96dHbLaP7bud/wqNY6NOKXnsJxAMolUU/WVMq
         /oBq7mxAQhHtT0JU2xV0TcnNh5LHyDzrM0NugA1Dp1gB+5u8g29p0pJXc6sezNtVOsVr
         z6WRmfeFUFqUMnx+cZ6mBoZd8HigImYTAF/6MFAG8YFKvDUPvk8rhsXd2pHoOycg/rGN
         CAl5cVEs+oy/fMglMDv4CDsDfvSVU/WVLrzX9yQTdfdoWsXnEpmm442TauiJT6ua4Cr6
         /VPA==
X-Gm-Message-State: AOAM53307Nassk5EXbObAc2E/eCdeFIu5hqh9J4pTVOBbT+cStP4CYHy
        ju7yP71DU+Y34IvaJbdhTzFXjLPSeXghsF8WND4=
X-Google-Smtp-Source: ABdhPJxzc6HoyC7a/XKI/hpBPhVWM1wwX59BKWXCZic08p7TjBn5ySl4+PXNnIyazPaqUgCvpr+IewcO1x/ulFkEfe0=
X-Received: by 2002:a2e:a37c:0:b0:246:2ce9:5744 with SMTP id
 i28-20020a2ea37c000000b002462ce95744mr7390936ljn.76.1646658481934; Mon, 07
 Mar 2022 05:08:01 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a2e:b893:0:0:0:0:0 with HTTP; Mon, 7 Mar 2022 05:08:01 -0800 (PST)
Reply-To: fionahill.usa@outlook.com
From:   Fiona Hill <xaviergbesse.2020@gmail.com>
Date:   Mon, 7 Mar 2022 05:08:01 -0800
Message-ID: <CABEvWUJ=V6-p2_rATQnSECsyDneejOk7KO65ffY4j+48oSVmmg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

-- 
Please with honesty did you receive my message i send to you?
