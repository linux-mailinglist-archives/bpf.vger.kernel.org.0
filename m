Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B452543BA6
	for <lists+bpf@lfdr.de>; Wed,  8 Jun 2022 20:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbiFHSnC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Jun 2022 14:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiFHSnB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Jun 2022 14:43:01 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E40E0E6
        for <bpf@vger.kernel.org>; Wed,  8 Jun 2022 11:42:59 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id m26so18047648wrb.4
        for <bpf@vger.kernel.org>; Wed, 08 Jun 2022 11:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=9R5J9eg4EELxB88aZvMRGu1DhKgT8eyBDGZVIvjCYOQ=;
        b=IJTvolbvDi+ZmLSUA88OBsS0+KhOSy151/kbB+pUWIhoQ6uTeuHO8o5C6vixqMxVKD
         ZwgYZlVzYszHcecstG+RsjG5VpqKBIr0/FKknLtk1hqSMHYlihRdpZ0LmajG69ttFAiX
         fGwYUgpZ+wY612ue9t/st7fvuiS+k5wbaPI9ECSgPQ39UfVix67la2SvI1ahJzyR+OVa
         JCmyAK4Hii1TSrK+ThYSctx/6/R23bXsQoGJUIqNUfzJqxRKMh2J4h149Xy4ZHHXdgYl
         zPJ9VgOjQcwCcKV0gknJAazsCRCg+rWASdHzuOMxKF/u8kGG4xOdYeU2knw/B34u0l/d
         LlZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=9R5J9eg4EELxB88aZvMRGu1DhKgT8eyBDGZVIvjCYOQ=;
        b=RK1+K6KWJRL+ziqRRX6Ez7borZr7PUdJ/Qe0WmpJ5EhlzHAi//n9AiXCuUY674kmTv
         zNtLOc2LG6f30FQLMm1RgACVIz8m+oajb8ECcagFrHseEP64Aa+itu9WqmuSiUCtROpB
         cBtwe+ljftxFBv+J9qw4S/zV3cNpLN3Z+69rIJh+m44FiyKUsik97KHRr5mzCF5rauGe
         u9QjavzcEG75o/RGBSzbG7NtkJdDwRXWLtOyY62Pb3l5Y6ghKrcoUGrltrd3VFNyWSwM
         +PmQGhg6Y/EQ0sMS0ZLLhxXf089Oc4TiJjgArbfrLAijuMXrjbleEGalMqRaIKOMwWH+
         ppLQ==
X-Gm-Message-State: AOAM531GCiIo3ONGfmrv4/7j3dzm2RRWoO3WM8Am0R5GBOPF0xJ8FuTl
        jfHMxYFH2czxGbQu6cUGeCtbSWslvDSXpROBqQE=
X-Google-Smtp-Source: ABdhPJwQsfwp7o/bXN/ABW4p+hA9DvchNor9DVjbWKOJdtZBIWGxjM0A+Rf7mERQIrmJ4Qj5dHnLkUImCgoQhd/zxQA=
X-Received: by 2002:a5d:6752:0:b0:214:c5d3:f3d0 with SMTP id
 l18-20020a5d6752000000b00214c5d3f3d0mr29355322wrw.429.1654713778228; Wed, 08
 Jun 2022 11:42:58 -0700 (PDT)
MIME-Version: 1.0
Sender: mrarnoldjohnson764@gmail.com
Received: by 2002:a05:6000:1acd:0:0:0:0 with HTTP; Wed, 8 Jun 2022 11:42:57
 -0700 (PDT)
From:   George Johnson <georjohns57@gmail.com>
Date:   Wed, 8 Jun 2022 19:42:57 +0100
X-Google-Sender-Auth: VcymmlIso85fJ63dNSF5KXxXUKg
Message-ID: <CAKNasccCtCGSQzzb2Hv0tfo7-uO_Rg93J9PyjZHWxTWNF8xN_g@mail.gmail.com>
Subject: Informartion for 08/06/2022
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SCC_BODY_URI_ONLY,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

-- 
Hello,
I have a very important transaction i would like to carry out with
you. do write me back on: georjohns57(at)gmail.com for more details.
Regards,
George Johnson
