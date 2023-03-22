Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22E796C495E
	for <lists+bpf@lfdr.de>; Wed, 22 Mar 2023 12:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjCVLm2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Mar 2023 07:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjCVLm1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Mar 2023 07:42:27 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E3495D253
        for <bpf@vger.kernel.org>; Wed, 22 Mar 2023 04:42:12 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id p203so20556854ybb.13
        for <bpf@vger.kernel.org>; Wed, 22 Mar 2023 04:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679485331;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sw5nTUUaX1EXv/6sxqkS3B9alHkCodiHIeZRdSCQnCU=;
        b=JJH/rGuOQHWK/Txyl6k5KWLi5ikcFzs/+63VUr8Fv375T/UzWkOwAl6gsn+YhHlpbF
         54jI1VOxPGQv1Str/mN93hvhgiguOISh+2dNhh3+ZIGXSK7HWpK/t9YsPDLTAUsi+Aw2
         PKEpVKASqOdQy2a0XWjTLU7w8/4eWL/9olY/aQ6an+bomwdUo9yi5jT9ZE0b6Xx03HfB
         ulyF9LMwppXxXXWer1742krwnyefcM5PfvgmkaOxjM2lYVkl7gjO7L68rs5hXXzApMu4
         BcufZ/w/0vtFv3ow+kyn8LQlPRYiR6ahvMaJXz2nP49ED2fwsr1kBBM2V60cf11XtmIX
         kChA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679485331;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sw5nTUUaX1EXv/6sxqkS3B9alHkCodiHIeZRdSCQnCU=;
        b=uqdNsezr53nQc91ytn68x8b67bfQKuVSfpHBbk5CSubdC+IdcdcJxp0vMn4vPhlU87
         PffQfJUqySBmwT2xbB2WivhA92c0OSu2eirj5gYQjDnIEGSHMp3YdnwSS3K4Sxc334m+
         qNpHY7cfMVAW4Tc4pSpDO15oK2DLAsA0K+7nmUsW7uIG3uXE8284yK61Ga4+Yh5Yw5/D
         yPdQFCiOTUNKXg/V8uP1RQ5mP/4MBOXa6+RkBgUyZ/V/CUgeePWGuCRp4E6zBVvjzRHy
         uJGU04X/x1iM+4DN7upOTjqwKXkwaDVGb5Bq6HwQNZrFmGLoAjpupplXdIZuNm2G6flu
         7OeA==
X-Gm-Message-State: AAQBX9cHNlKSErAIsrZEUPLud/MlsnEo6YdjYQpfAvUenm5Jc3tSBo2F
        wSmClwoDJ3MM9Fkg2riEi+L1Ma7IIgQYm22Ek3w=
X-Google-Smtp-Source: AKy350ZfjbDK0dHu01ZE9qG3iCKre/N2pW6V75mHoem22zAf/IqI8tiCkuziVHjlf7Y4ZSXBAzbGjrNjSdfd+8i0OUk=
X-Received: by 2002:a05:6902:1083:b0:a8f:a6cc:9657 with SMTP id
 v3-20020a056902108300b00a8fa6cc9657mr3150273ybu.7.1679485331129; Wed, 22 Mar
 2023 04:42:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7110:a289:b0:1f7:76de:98a9 with HTTP; Wed, 22 Mar 2023
 04:42:09 -0700 (PDT)
Reply-To: wormer.amos@aol.com
From:   Wormer Amos <babyloveme20112@gmail.com>
Date:   Wed, 22 Mar 2023 11:42:09 +0000
Message-ID: <CAHKSb4XZ8a8GefN95c1ZKtCGQM7XC8StQs1XZkr=FcCUdpR0+Q@mail.gmail.com>
Subject: I WANT TO KNOW YOU BETTER
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        SUBJ_ALL_CAPS,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Are you willing for investment project in your country. i
need serious investment partnership with good background, kindly reply
me to discuss details immediately. i will appreciate you to contact me
on this email address Thanks and awaiting your quick response,

Sincerely
Amos?
