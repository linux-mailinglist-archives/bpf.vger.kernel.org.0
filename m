Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37141543F1A
	for <lists+bpf@lfdr.de>; Thu,  9 Jun 2022 00:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232963AbiFHWYt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Jun 2022 18:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbiFHWYs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Jun 2022 18:24:48 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C6529CB5
        for <bpf@vger.kernel.org>; Wed,  8 Jun 2022 15:24:48 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id r200so14492079iod.5
        for <bpf@vger.kernel.org>; Wed, 08 Jun 2022 15:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=NMISyN+FxZ7s4toXYHIz7uHu2mGvH4LfRIG+wXe5SoM=;
        b=oiKAwa+FJJ3jyKvM/YzCfLXNJfkBbwhNQi5V4P/uZOSFdyQ5nK8huvS1+YVyfyPtH7
         BTMXe16S2T56gQxIB66AZ+aqB9/zlMB/WFDIU7HYeuqrnmiQRXOShe2Uqmx6oHOfeoAQ
         13lGETT9PtpUMVg3tubU0ARB6Ep1Jp8HTLb4We/mRS2TAvohlWSvtxO6KGx8G79XYTaR
         3+5SfKWNFi6MJmZ3KclE417WF2e39AYTVXM91NgDk1s1LTMi0mwR9EbIgK8OM1KNNij8
         SNV4DQXPgkVxVVZj3FWmyVOUwSed2KmxOl39NwEgKC4qWtg9zXfVsbDBLlBMyfYwgqxD
         ueLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=NMISyN+FxZ7s4toXYHIz7uHu2mGvH4LfRIG+wXe5SoM=;
        b=G0/UkEAsgaP/A5pVBozQhHSEAhOoe7UjWTK7QwtY2GT/yciljqTZzdORhsVlbPmHbk
         Qnm8KHvpoJPg34j/cSC/LXwbHewxCV0G4pXWXkqL5kQZW7X7s3pj1fIENk57oXwZpQmL
         Fh57kVJ6Cd0vcHHeTpAlIZwoWalz876H+/9CDL07tH3I31bV6uViW/oPYjRAWUYvmrFd
         BNGJ7N8wehQ12OSKO+JVBRbfx6SQxH2edXuWEgxCO/fAXLJ9Wzu2kWjfw3SLI79FxH0J
         3AAiJnhiIfeIQ0pzAkA0f28fvJnM2uVBai93GHY7v9v7sVeUdqvm2Vy/tH+FpLig/jl2
         vNjw==
X-Gm-Message-State: AOAM533dFTE5EHna3jYLGtt7dASjLj0cv4cU9HtTq0Zw3QKgvrgnIgXy
        /N00ym1gUCwQ5RMWlEXYb8y94mp7g+rwIEkcl9k=
X-Google-Smtp-Source: ABdhPJzXul2Q07b0/Qvypo74gwnjBzmwn7j6XHjpgSdt/ar4wVoDov8vZzs/eUZz76NbzyChjdUWp/3ibUE8ZQ0DiVE=
X-Received: by 2002:a05:6638:209:b0:331:bed4:ffff with SMTP id
 e9-20020a056638020900b00331bed4ffffmr7973462jaq.233.1654727087504; Wed, 08
 Jun 2022 15:24:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6e02:1bee:0:0:0:0 with HTTP; Wed, 8 Jun 2022 15:24:47
 -0700 (PDT)
Reply-To: wen305147@gmail.com
From:   Tony Wen <weboutloock@gmail.com>
Date:   Thu, 9 Jun 2022 06:24:47 +0800
Message-ID: <CAJD+KsWBf9rcbHu2uF3o7URkA3XudTuLmTeqJYa-tzhR76RPmg@mail.gmail.com>
Subject: work
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_60,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

can you work with me?
