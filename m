Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8F2D57F43F
	for <lists+bpf@lfdr.de>; Sun, 24 Jul 2022 11:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbiGXJDj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 24 Jul 2022 05:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGXJDi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 24 Jul 2022 05:03:38 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D01513EAC
        for <bpf@vger.kernel.org>; Sun, 24 Jul 2022 02:03:37 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id s204so10165957oif.5
        for <bpf@vger.kernel.org>; Sun, 24 Jul 2022 02:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=QpEaDxkG2LS1RZfC/NN515eixcplndk1/81tecigYbY=;
        b=H8+uJHEploRNua6p4DTXdPmDrNq5ECsL8aGpW9b9gJIfbGZJUZUwO28l7ZOLIA4YpE
         8Mp8ak5AJ2YJavFmbCIYPt2ipLeZN4aXw9e7wvkswrvuHMUpyrD1jUhT2IxvAX06TIPp
         hMOOsvV5KvlMyP6wD6l2up6e0HfrnU5ElQFtGZ/X6inji+fbo2uBlVSVogYY+/jR1EG9
         KP6NS15h0fGnQTrQmRNuceUDrKrK0bgL2PAy+HtuitmgC0fab9z8NI0ZV+ERkYF92X+Q
         rtee7s87RzWmK1a9NnF0VL+BlaQSQ0xSx5ubjXS9EV52CYqP5spe0kbncBXIqXr6ahCH
         EnvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=QpEaDxkG2LS1RZfC/NN515eixcplndk1/81tecigYbY=;
        b=i5k5izb1Fbjw0mmoFwlGzavHM+ps+Qdait6psP93rX40FaKhJKRtqo4cVXvP+goo56
         FkEGffkl1vG/e2KzbTB1emEfggawyPO1KaeDd4OGvLCrucLq9OQfRmqRlBRBsDTP5WmT
         tXpRwUpSoriGj1tWP9hZRC+IpexC+R6SB67hr6fX74zSfmV/NUi478x/xiCBLkfI88Af
         UGXnerayfATKyEG69Ia50XuBDNYAGI/q06KPcPoLm5MjMJk3frY9KDVPKNeBawDaTc8G
         wshXL7k9d62qNqUgzw3mD4A5gI/LX6fm26urrND30p29QU4kz7bQ4XXpTWBYnK4FUZnZ
         MoyQ==
X-Gm-Message-State: AJIora9diL7kB2pA7JvvuoFEXvF3WkNwrE2DNrcSs7BDM6e2CDatnSFe
        USCT84rsmoa8COpI3rR59Svd5VDLE+OUzTLs1Pk=
X-Google-Smtp-Source: AGRyM1vZqZBcYiyKvvc+MR05IwKsVIOVJyJ1y42N50mDjrzfslMC0C4j58vcYsoVVOP5c/zW1ZsNHxhWIGsNvDcfhrU=
X-Received: by 2002:a54:4411:0:b0:33a:6c6d:97fa with SMTP id
 k17-20020a544411000000b0033a6c6d97famr10615150oiw.30.1658653416603; Sun, 24
 Jul 2022 02:03:36 -0700 (PDT)
MIME-Version: 1.0
Reply-To: sgtkaylama@gmail.com
Sender: yakoubougourou90@gmail.com
Received: by 2002:a05:6358:2115:b0:ab:8d56:1c23 with HTTP; Sun, 24 Jul 2022
 02:03:35 -0700 (PDT)
From:   sgtkaylama <sgtkaylama@gmail.com>
Date:   Sun, 24 Jul 2022 09:03:35 +0000
X-Google-Sender-Auth: UsR4Q0uoWW73brz2R9W7q2M4GWg
Message-ID: <CANcDhOB4eYV7dhZXNRNVWmYZi3a-ocx2Wa=FLx9Mp=vC6JyhYA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

6Zeu5YCZ77yM5L2g5pS25Yiw5oiR5LmL5YmN55qE5Lik5p2h5raI5oGv5LqG5ZCX77yfDQo=
