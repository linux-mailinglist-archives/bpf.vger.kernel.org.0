Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1695638BA8
	for <lists+bpf@lfdr.de>; Fri, 25 Nov 2022 14:55:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbiKYNzf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Nov 2022 08:55:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbiKYNz0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Nov 2022 08:55:26 -0500
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C221C110
        for <bpf@vger.kernel.org>; Fri, 25 Nov 2022 05:55:21 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-3b48b139b46so41959587b3.12
        for <bpf@vger.kernel.org>; Fri, 25 Nov 2022 05:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3MHP8OlkfxXa9JVggF6QfPWs+9t1TPv4X6gHTD4e2X4=;
        b=iKBEa5UUzsTwmQOGGn0hBAPv3wD+THnkq5eBrmsLB4uParX0kxaniw5rIjkGpwCY44
         zHch67zh4zxms4hbQn6+umQB9JapjvoNfAHwkInm/NKRv9RL/W6qR0KygT/tnZUW5Ehw
         sWwRC4pmDP0B0Mtwhs/JC+6+RMfJPheexHTREs6a0XrL+dh8WcQmiVqRNCkohlAOR4es
         gPL/OS5DwQnNC9SSTjFUlRN4Q05OnapfQ1umHKbhW/cNzepvsZzwk3Pbb1epzBsiIKwa
         5pNvCq9EfEBqLdTp99ULdNNYdD6M0g2c9kQ0BpQPXyRuhA3GEQYD5HJNp3Gt8Ez8YQP9
         +brQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3MHP8OlkfxXa9JVggF6QfPWs+9t1TPv4X6gHTD4e2X4=;
        b=LuyVOsRquNb9hhEeEoAGVErP1Xg+tLHvnY0HDHK8Y3IHsQi/quybgmkDCyyC2rGP1H
         3TxogG3b1x+Gdgf1vPC5WeL3oKcWZcnIndcyVkGo88VuSb/0JhAulmLCfZGRsH8cDENN
         Ys9WRY6lvDinfABKAivJ3moKwTW4Vtx2scUN/36jDp8DG7KTDyh9ZBC1bNoghYjo7Jf4
         UTxxXQFoakLiyUGqol97wXnns6IdXxu22p1JlokrCmIsqbLiw67zuhf9kp9Gp0e7JI2U
         9VSevLAbFO+NPLTqFV9MTtRVVCsSJ4XXn1m66gE65KHA31Gas0gQLfIS3IdaU3AkZTZf
         g3zg==
X-Gm-Message-State: ANoB5pmm3SMEGiBlagwjy4n6TWzBjLYdPFRfGdgtBaReKrCpvibeYhlU
        A4qYWLcTXsoQr2QGkK3eNUBK1iNW/ZQheZuRVwBGqSVTovr0OZTt
X-Google-Smtp-Source: AA0mqf7B5ClTcCd3FjXbo299mZA01GKXUK2T4Pr+bXWk/+Afj+KoUcj+JdKrPhPRp17oY4GE/aAlZ17m+ShPjCrPwFA=
X-Received: by 2002:a0d:eb4d:0:b0:3a1:6fbb:9249 with SMTP id
 u74-20020a0deb4d000000b003a16fbb9249mr23546280ywe.223.1669384520492; Fri, 25
 Nov 2022 05:55:20 -0800 (PST)
MIME-Version: 1.0
References: <CAC=wTOiGHC-j9AFetOtd9j_8ZD6CwYDN_741tyx31nNrzuku_w@mail.gmail.com>
In-Reply-To: <CAC=wTOiGHC-j9AFetOtd9j_8ZD6CwYDN_741tyx31nNrzuku_w@mail.gmail.com>
Reply-To: tjcw@cantab.net
From:   Chris Ward <tjcw01@gmail.com>
Date:   Fri, 25 Nov 2022 13:55:09 +0000
Message-ID: <CAC=wTOgRSG49H=jpo8H_r3Xqai217FR9G8n7s-4FUgtJdVypkA@mail.gmail.com>
Subject: Re: First packet going missing in a bpf-examples test case
To:     bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

I have found and fixed the reason for the first packet going missing;
it is due to 'reverse path filtering', and this can be turned off with
for device in /proc/sys/net/ipv4/conf/*
do
  echo 0 >${device}/rp_filter
done
in the test case run script. So
https://github.com/tjcw/bpf-examples/tree/tjcw-integration-0.3/AF_XDP-filter
is ready for review and integration.

Chris Ward, IBM
