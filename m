Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95C4F59B98C
	for <lists+bpf@lfdr.de>; Mon, 22 Aug 2022 08:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233147AbiHVGcg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Aug 2022 02:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233144AbiHVGc3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Aug 2022 02:32:29 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DCFD286E8
        for <bpf@vger.kernel.org>; Sun, 21 Aug 2022 23:32:18 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id s23so5043125wmj.4
        for <bpf@vger.kernel.org>; Sun, 21 Aug 2022 23:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc;
        bh=o31t8HDG7QptfeLJ+04Jkz8j9NFHlDWTE2XxPfy4mY4=;
        b=irZObN1eltJOx3RhmXoVx+SqMw2ylRDjCL9UpnvBqOYkXsfa0zfc8gQMX++2ozeENA
         oUPBy1vKzLfnGYlo0m8FmoFZIftspFaobH80NatCz3HKITTnyeb/5+IussCPaM3ix+7C
         +drIiDFCd2uY35Q28zXDEE078jqZbb+d7onnkjnDcB3tIUcNAFotECVcVTV1Adn39/3U
         bUoWwrqoPFwFyoM8XHC4KX/I6DyvjmeDSNDar1AuAvv0HUORMLH7PxexW81lOj64C2/2
         ax/Ka+CI5+hlQdOq8/JhiLSd3WiKiZNhZdP+VPLuCEaaVasEQwZTviwCeL1qHeT2te/n
         KYTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc;
        bh=o31t8HDG7QptfeLJ+04Jkz8j9NFHlDWTE2XxPfy4mY4=;
        b=u/gsLMwJ9Y6weJHlwUAO0RvF/KAMxzZXsQNqIZR4J18bHPtY4S/zPpFqTs/UhzAico
         MdiQS84mS6d9IwlmykUV9xvVYmVQNf8YVW4pj2OBlCFZm5CoVnALEbyqJb9ksjTsCzku
         un8Iqlx1+GNKshiazydSbSO+FdMaVwW7j2sLIv1h7Q2Wiaz6cncf80fuK2qJ/1eapWDU
         1ojIjMLXvf2W+O+OTPE2rOWqd+bolMBkZeKxQCepBAC9pJkKmhiLzxsMHZaxay5IlW++
         75sZ5WMQuuzIqiJnOjau1w3Y8IeOwdltQPVrZsA5Z8A15qpfunZoiJJfJQyBEITlaZFf
         OtaQ==
X-Gm-Message-State: ACgBeo10zIsZa2m3YiluJLPS8HdRItCyV4lQP8AetEqFyKu9+9mhXkTA
        4mguzlbz+N0/bwrM/llsZZAhqlBNK5dLyz4PbNA=
X-Google-Smtp-Source: AA6agR5256tAvfVJJO0CQj9RF4tqybY0R03VAdi4u2vcjxkoZrb/NBSUotfOfLcq9p1Xs6FjvMmoSzFmOU8vM+F0gg8=
X-Received: by 2002:a05:600c:35cc:b0:3a6:f08:9b1 with SMTP id
 r12-20020a05600c35cc00b003a60f0809b1mr10838510wmq.22.1661149936586; Sun, 21
 Aug 2022 23:32:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5d:5444:0:0:0:0:0 with HTTP; Sun, 21 Aug 2022 23:32:15
 -0700 (PDT)
Reply-To: maddahabdwabbo@gmail.com
From:   Abd-jaafari Maddah <sheishenalyeshmanbetovichu@gmail.com>
Date:   Sun, 21 Aug 2022 23:32:15 -0700
Message-ID: <CALX-7+1qNb9UdqGCv4rX3wWOU+RrnU8o4moJ8+T0+0Vqx2_04w@mail.gmail.com>
Subject: Why No Response Yet?
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

-- 
Dear,
I had sent you a mail but i don't think you received it that's why am writing
you again,it's important we discuss.
Am waiting,
Abd-Jafaari Maddah
