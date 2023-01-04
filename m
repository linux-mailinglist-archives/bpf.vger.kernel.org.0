Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10EBD65E0AD
	for <lists+bpf@lfdr.de>; Thu,  5 Jan 2023 00:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234795AbjADW6t (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Jan 2023 17:58:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbjADW6g (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Jan 2023 17:58:36 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF9213E95
        for <bpf@vger.kernel.org>; Wed,  4 Jan 2023 14:58:02 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id i19so24146776ljg.8
        for <bpf@vger.kernel.org>; Wed, 04 Jan 2023 14:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:references:in-reply-to:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XppnWxwUDd4VKlDQMnttNa0YhBi85GdHW05upV3mZfc=;
        b=fJM+bXf1CCW0+0edI2hk1VwRp1Om2TirjIk0wHeI+o2Fip0lBU0Jjm1kxWHjazNp4o
         U7EA36Jujv5wauB3KRLyhGE8X4dAqB+USfoatgowcTJX9nD3cULCxd8wyNaXl0CzG4KB
         q1HcvnOvh5jlGaNrj21gzpE7HMEp4pjmsP7U0gdGn3U2nrzuXjbw3rvKt+or7s2te/za
         cTZsWqT7aLlUTptqj0nR+jGau8aTt5qffhq0az4zHRkJrZ/+KF+czgYl+KjqDUkMbpwm
         8Z2dOoumlMeioBUESsiAN7mNa9ZlBhrKhuH62S0BQ34rCGnox6tZmLwDQqkVGFpc5ukr
         1eyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:references:in-reply-to:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XppnWxwUDd4VKlDQMnttNa0YhBi85GdHW05upV3mZfc=;
        b=P/6xRhNFhXjZn5ceWnd1wbJbsnn2qZEY82PkkA8bKEvNa3YM0db990mjTGfVQ4kg1U
         BDRenUwKjuebOUC8YRvJtIhvXvRK/mVkm2nUGv1hr55oc8uvih5gu+8fYGM2n2AW1n2N
         Kbo+FrQ0xfQhhVOeWXoG4Z48j8K3K6Zfj+Pmb4V2fJYiqSWjq2qU7ZaI7qQ3ED1DDgHu
         PB1PHmK5a9LfUN1gJ4w0QYNq1NNBHUPpPnE0V8rRpxi4BtH7mPxaj/u6xKhY1gGwg/rs
         6/fuy5nsA5lee/fsjJVzjm6+q4xBu1pJcbSjQqcM9QSoJWtpQDxvocy/oZQz6UuZ3q7B
         kxZw==
X-Gm-Message-State: AFqh2kqIzQUS1f+tb0VGmwXlUgMrdO5WZHGOCzmzuNGUipTyU/wQAl7a
        2D2GaWb87VkxRLM4K0xAfIu0RnY7eNQ/nDXIym8C7sRGt13e7g==
X-Google-Smtp-Source: AMrXdXs+eVvyiCxCKe24ziuU8uM070gry+IFf5pBWvFzFx3rMu2JixMyHB0JlUgCGg9QAI/vgJPYEC8PADaLxGNXkoc=
X-Received: by 2002:a17:906:7ac8:b0:840:758a:9157 with SMTP id
 k8-20020a1709067ac800b00840758a9157mr2678444ejo.434.1672872652893; Wed, 04
 Jan 2023 14:50:52 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6f02:81b:b0:27:37f1:bc15 with HTTP; Wed, 4 Jan 2023
 14:50:51 -0800 (PST)
Reply-To: lisaarobet@gmail.com
In-Reply-To: <CAJ8KLPZKUxDZq39GHC=jv+B5FtcA3dQoRwAozXyT7mpDqtT2MA@mail.gmail.com>
References: <CAJ8KLPauCfukWsXYV4A=eUrGM8=Aa0FFD3dUDvGJt=CZTLaKVw@mail.gmail.com>
 <62eb867e.050a0220.0cc7.16e7.GMR@mx.google.com> <CAJ8KLPa5uwGGTPzicNhFHwz-0rZdKfrDTSwNBWxdF--Mfc8t2g@mail.gmail.com>
 <CAJ8KLPZKUxDZq39GHC=jv+B5FtcA3dQoRwAozXyT7mpDqtT2MA@mail.gmail.com>
From:   Lisa <smithgrace507@gmail.com>
Date:   Wed, 4 Jan 2023 22:50:51 +0000
Message-ID: <CAJ8KLPa5V8mMkqJ5HrpQXy=DunsCNFEus7aiLDDOTEgH4NQXmA@mail.gmail.com>
Subject: Re: Delivery Status Notification (Failure)
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

Just wanted to check in and see if you receive my request?

Thanks
