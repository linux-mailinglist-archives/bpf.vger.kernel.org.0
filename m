Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92EAE56FE1C
	for <lists+bpf@lfdr.de>; Mon, 11 Jul 2022 12:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbiGKKEr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 Jul 2022 06:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234520AbiGKKDc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Jul 2022 06:03:32 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC2348E9B
        for <bpf@vger.kernel.org>; Mon, 11 Jul 2022 02:29:34 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id q194so2140374vkb.6
        for <bpf@vger.kernel.org>; Mon, 11 Jul 2022 02:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=DBXVr+2yQA4Yc+mJwCPapHs1PcqJSd/+SbzdjhsE7eQ=;
        b=TUGrmjBkxC9L+1InG7C1fgHmy3w5jYPm5vo+MdupAIWyQB9+geJahel8A84QiOoefj
         +RmHtyiH1zoG9Cxa8fa/pVc84mC8ChpeUQlSYiLq+0RMtkIZjirNmtWbSdg0ZwXCZUOP
         QQ16TAfZxZkFuWLnq/rd7foQpsnVXxbo2eOCqe5LBj76sqAUIgIMLRz1DQCaw0Lqdjai
         /wSOZJbhfqxenLlqWMz72YK1wDa4b5fJhRzgtt/kkc0J9hD2CkajSTbhvrXAtHttb6Ox
         jB4FkzwdctJgCzME4FQOkoTofGiTQEvOmYw6QDpiph7zM9o1YfeA6TzE8Z5V8CTE9lvL
         2XUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=DBXVr+2yQA4Yc+mJwCPapHs1PcqJSd/+SbzdjhsE7eQ=;
        b=kXPlhYuSmv//pbyb/6tW1PMy3vQ/7x062S9Z+z/rebwNBijkgAwqx4rcHH2eewua7U
         oXGzZA+LLD/J3sM+79nLBO6YfL459LPcKxkuo7366owUI/pMko7oQ7LNaNJ/TxUHc+BD
         WcW30irKOaE1xmiICOwCkc0HMe72AK57cWZMna56FhfaoFZU/uiGw/M3+VsD0FMsxW2z
         eOXJgxxBSlYjsm6XxzB7ofYHpHt+leOzU7P6vNcsfqblGuozp+X1JR7Cn57q15JXXoMq
         i9+o5+irrAWqqOU2+lFMGho5xmcOdgdEu4SXp93k9AsqQdB3+zmdpOlKa12XfgkdjI0p
         hEzg==
X-Gm-Message-State: AJIora9/bOC4xLz70v8kwfVXZIRlpT/R9pXWA5nghtQzFiMGYItoY/Ug
        T192LwarMb/HcT30qOzWm2pxfeA8K6DA5SEB19M=
X-Google-Smtp-Source: AGRyM1uXt7J0tB22tlgi9dBrtsHjl7gC4Z8CwqWLtyk/Q9KKNicOZg+8Vvq2ZLdsz3mJSPcM2cn5MrrOC8x4jDd21U0=
X-Received: by 2002:a1f:9e92:0:b0:374:cefe:51f5 with SMTP id
 h140-20020a1f9e92000000b00374cefe51f5mr282705vke.7.1657531773033; Mon, 11 Jul
 2022 02:29:33 -0700 (PDT)
MIME-Version: 1.0
Sender: myofficeada@gmail.com
Received: by 2002:ab0:a94:0:0:0:0:0 with HTTP; Mon, 11 Jul 2022 02:29:32 -0700 (PDT)
From:   Chevronoil Corporation <corporationchevronoil@gmail.com>
Date:   Mon, 11 Jul 2022 10:29:32 +0100
X-Google-Sender-Auth: 6dmRjkb4TpRVF15T_q10_IrcB4A
Message-ID: <CACvfspQSrnm3jFaDi1DiP_JfGdAPQdhhR7hGXQwy-Z=FgSwEvA@mail.gmail.com>
Subject: re u interested
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

BEWARE, Real company doesn't ask for money, Chevron Oil and Gas United
States is employing now free flight ticket, if you are interested
reply with your Resume/CV.

Regards,
Mr Jack McDonald.
Chevron Corporation United USA.
