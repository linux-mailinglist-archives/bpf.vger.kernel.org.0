Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E156D600476
	for <lists+bpf@lfdr.de>; Mon, 17 Oct 2022 02:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbiJQAJg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 16 Oct 2022 20:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiJQAJg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 16 Oct 2022 20:09:36 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4BE25F6B
        for <bpf@vger.kernel.org>; Sun, 16 Oct 2022 17:09:34 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id k6so10049214vsp.0
        for <bpf@vger.kernel.org>; Sun, 16 Oct 2022 17:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aOC0/iZ3Xwg4q5fI2ithL9vv/LFBbM8Xd1CLHrIEq/M=;
        b=k/bDUxxhaOj2MNLH0g+FtBpNwxk3sOCdoc+29BnRaH1plSeJ/NH5PpaSHlAKS8CUVO
         JcBw2Vn8D5OBWTdBjaTvJBc7wtRKiwoOv9YM8vOqvhC4BPXPAskFePh27/g0DMMuXGur
         nvYDS/0hpDrZIBvdgP94Wcm+9al+CYTXsxuVPDHSB+C55eZ7Du5EtJrB0AM8q0msYS5p
         lABF9jVDWhAblUN3PNmZ5UOvT9JtkqD7mbOIMI2MWZ1Qz6Kb0jZRQm7Vff6I0gLT3Ecr
         DTqOwE8vq1l/N4auIFmf5T4XgO782Ss05vPLjVA+aE9V7n/uChKtb/M8ZoO1n0jHHd+O
         wMBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aOC0/iZ3Xwg4q5fI2ithL9vv/LFBbM8Xd1CLHrIEq/M=;
        b=e46WyhPuDMzoFhYI6fBJtw0sKVehVh/xnOB/dQ9l2cMm8FigBXobfaYawHaD+89Leq
         tXlRLQDIqzinoqVuqzFSRxeVclDGrYzHDOObYijnmofLiVdtXZ8WOibaIL5v0qxH8eze
         wiwQahactjZXVaYGny8tcIyjMNGsc/zW+mkmj3Cpe+AihQ2jmWqEQMSu6lEU47s3PAfi
         QtpLHy3g4BBSpF66lotbAl+znAPM7XZQjqFQ81ePLrxihZWw6hY0e/QDxRF3NIOm8jt0
         ypyng3J5QfMvRSLt8xRfoAXYVvNxlwCwaWxNn0ZWwc0eQBfTEOvsy8bWz867hxqrDXtz
         uW1w==
X-Gm-Message-State: ACrzQf1c1wiYqo3n5eLxN+mqGs8hgRy1uBUUEvXDajbf6J4gJCNexGk1
        ur72SBVvW2ALlM8c/6Ru9MZjgsA9WB8RYdu3OlA=
X-Google-Smtp-Source: AMsMyM4ccryq2AFw8G+oOjnQw7mYZcsqIEEdJrYkGdBt8azu8tXPmAJKnKmL/7+aQZz9zq59t7otbvmMSAl8tI5XEto=
X-Received: by 2002:a05:6102:3a4e:b0:3a6:e406:b3a5 with SMTP id
 c14-20020a0561023a4e00b003a6e406b3a5mr3129204vsu.61.1665965373782; Sun, 16
 Oct 2022 17:09:33 -0700 (PDT)
MIME-Version: 1.0
Sender: yaoy0328@gmail.com
Received: by 2002:ab0:5b10:0:b0:3d7:78ac:4954 with HTTP; Sun, 16 Oct 2022
 17:09:33 -0700 (PDT)
From:   Jessica Daniel <jessicadaniel7833@gmail.com>
Date:   Mon, 17 Oct 2022 00:09:33 +0000
X-Google-Sender-Auth: ty2-NpFFijobcb8g-qttpG_hrdQ
Message-ID: <CABio399EqLi_T4OrCZyTorZe13jX2nLAPH--rr4MXYQUq5f7dA@mail.gmail.com>
Subject: Hi
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

-- 
Hi Dear,
