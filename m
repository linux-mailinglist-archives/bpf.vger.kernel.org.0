Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6920E5A4D23
	for <lists+bpf@lfdr.de>; Mon, 29 Aug 2022 15:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbiH2NMJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Aug 2022 09:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiH2NLx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Aug 2022 09:11:53 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C8322BD9
        for <bpf@vger.kernel.org>; Mon, 29 Aug 2022 06:11:33 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id h22so6038881qtu.2
        for <bpf@vger.kernel.org>; Mon, 29 Aug 2022 06:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=8+4bnTKYSEomgov0fN4WSzB8Yls69bRxwVLBV1+X8+k=;
        b=bcuehKlCdOm3eWyNOCRblmWweQVcy01naG/UvIjW+TPtbGmEXCyXQmDOn01gzTDW6q
         GSG4QvvWHRme+fw+aLDPLKjsQ53jmR+sTIdOBwx0XPPLfTeuGWuOIuLnssPjnejDVrPu
         zDvbgqBH/eTQwUNsBIPsrnXlcFSkE2gAhjhadSa/PaFaCqeq4YGaGFmTGgn4+mbvYWV/
         w3HFa7jPqxaJxvR8jZyfkKopo1ktLYnDmS23wonIY65i8nle7tgiDAhMRI/MYlMibBCa
         OqM09J6QdW999bxB7JZCyzwmlzI0KkZTvU2+UO1RHmkH8mjOEbVa96gMYYd9dDexUgi7
         uQXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=8+4bnTKYSEomgov0fN4WSzB8Yls69bRxwVLBV1+X8+k=;
        b=wIObQkVz+dZ6W7VCIC4olEijh6zty/fm4ArE908NX3xx8EHyMUXa6/6xwmSKMaX7cs
         /VAtEhawELOp6Oh4c4rsD0hi3H5cLGs69ZFt+xzbmOGUtzNHxDvbxZM7gM2PBT4PaH7R
         wmi3w4K64/BDriaPd6rIRvluF6s0QonIreWojz2F6l9bEVZkS5dY4jkis+BhurPbIwy/
         1A2gRzMj2MekRl+7sdQkDyVD5n91XAT5tqcrtYox8D15o6Qy/iH5cIka7ZFeoaax34eE
         9x1KdcPYqm7SBfOChUtMNczTzjh16MhW8O8XqfYkiAeDv63MNzc5rhs2ezIMcEKyCRD6
         k36w==
X-Gm-Message-State: ACgBeo3grMx4Em8petCo+CPt/uFdAVXnP3dpTl1l6Le+eBP148bndBgf
        +eQmBpArCdM5Vf3JbdJIPOkHIaaPshYWJR1vkCU=
X-Google-Smtp-Source: AA6agR7zgDXMAB7ceKlQJG37JjChhstNlbBffPyDhrx8pO+gcuTT/5RhjBtiabRrhNyuoC0wNxaJ5mhzUd/YX03z3r0=
X-Received: by 2002:ac8:5bc9:0:b0:343:7c69:4a0e with SMTP id
 b9-20020ac85bc9000000b003437c694a0emr10090534qtb.487.1661778692325; Mon, 29
 Aug 2022 06:11:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:4291:0:0:0:0:0 with HTTP; Mon, 29 Aug 2022 06:11:32
 -0700 (PDT)
From:   Ulrica Mica <ulricamica771@gmail.com>
Date:   Mon, 29 Aug 2022 06:11:32 -0700
Message-ID: <CAHHQOPfF1eXk40O0t=0A93JmW7M8mJn9COGHaC62=Xj+J5xY3A@mail.gmail.com>
Subject: good morning
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

-- 
Hello dear
Can i talk to you please?
Ulrica
