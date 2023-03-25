Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A61316C8D82
	for <lists+bpf@lfdr.de>; Sat, 25 Mar 2023 12:35:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjCYLft (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 25 Mar 2023 07:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbjCYLfs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 25 Mar 2023 07:35:48 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B01F86B0
        for <bpf@vger.kernel.org>; Sat, 25 Mar 2023 04:35:48 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id t14so4218234ljd.5
        for <bpf@vger.kernel.org>; Sat, 25 Mar 2023 04:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679744146;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pVHMuj1PrmtWZRhnvOVtdrRVQ3tW6zC3uQC3tqF8Edo=;
        b=fiF1x9w1f6cEOe2bOv8tdEilIJa9379Tgobe0TEtj59xmmx+vBweE/5nzZSidLlxIZ
         ow3CDgRC2E2+n0qcVzaWP+WvJ2YeEclMfNR4K8SXl8w4ICPhgRiqZfha07m2GivsZEOE
         BA4nHV50pc+Y7I+6CdImyx4+1v5YDWJ1Jq4EJCDqFgagHPthXPKNS+fCmAopsNT3rpDJ
         mNKO+hJF8qdAZecVrhDkFtFyD69XNxT3Bh8/WXU8I/962WbQdHjnHPcQ+P3ZyFONlCCU
         bxGhK56OXYQG3pcB0Ja61tj8OIJKNiTpdGdEmtAfAAvT217QhccoVt3F2fj2XAAJq2NN
         fO9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679744146;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pVHMuj1PrmtWZRhnvOVtdrRVQ3tW6zC3uQC3tqF8Edo=;
        b=ERrR/bPQWHFO4bYYauLJXbai8ogUTaUH9i6VauAwGhk+KuG90jUYMh5rH965lGutOO
         2ZXOWkByGz17HnqE9qZtYe+wyQa3KZPBXXyzifx2cVUJKuB/Z86kqq04hmv02hLttqeS
         jgXQhmIHvsT5KoVM9g6OTYelMfn9O8Fu9D9jgdA8ZMaB11Awbkmxqx8Z6Y3et96REXFv
         L30uz7DyiM+eag+rQ3g2kzKKciCgKoZqeic4MHLTDGTbmVCT2clsDhAYVpjy3XVazCiw
         al7gLrQpaOQW0L32BYheb9R8esfmZSvOvQ0Gynk7d/VRUzFDIGSZM+bGuhEySB1jUhGG
         KAZQ==
X-Gm-Message-State: AAQBX9fuDicqdnZqpcr5I3KYUz/7RP+ZY4yLX68DbbY7FiiIH4ZuBGUS
        koXDHBO2l64Pmim8tWNl34GlUaXZyrh3WWNqJzM=
X-Google-Smtp-Source: AKy350bpB0TW4P/l6b0o8qNmL7MzYGTRtC++7AL5IXwk7ijYEI8KOkR6YM0fRyUxxvrYObghl4goXKy+h4li7I+H6Io=
X-Received: by 2002:a2e:3203:0:b0:298:b337:c11f with SMTP id
 y3-20020a2e3203000000b00298b337c11fmr1740234ljy.7.1679744146278; Sat, 25 Mar
 2023 04:35:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:2e0d:0:b0:2a0:7451:d2d6 with HTTP; Sat, 25 Mar 2023
 04:35:45 -0700 (PDT)
Reply-To: hitnodeby23@yahoo.com
From:   Hinda Itno Deby <kwamebedu1989@gmail.com>
Date:   Sat, 25 Mar 2023 04:35:45 -0700
Message-ID: <CAG1Da7L=fZm+bHg5UuGQaMj=PrvxySiiMahicvW8=4AmOEsFVw@mail.gmail.com>
Subject: Reply
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM,UNDISC_MONEY,URG_BIZ autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:243 listed in]
        [list.dnswl.org]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [kwamebedu1989[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [kwamebedu1989[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [hitnodeby23[at]yahoo.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.9 URG_BIZ Contains urgent matter
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  2.0 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello

My name is Hinda Itno Deby Please I want us to discuss Urgent Business
Proposal, if you are interested kindly reply to me so i can give you
all the details.

Thanks and God Bless You.
Ms Hinda Itno Deby
