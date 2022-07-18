Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 166945786E5
	for <lists+bpf@lfdr.de>; Mon, 18 Jul 2022 18:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235486AbiGRQB3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 18 Jul 2022 12:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235551AbiGRQBY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 18 Jul 2022 12:01:24 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 451EA25E86
        for <bpf@vger.kernel.org>; Mon, 18 Jul 2022 09:01:22 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id va17so22172096ejb.0
        for <bpf@vger.kernel.org>; Mon, 18 Jul 2022 09:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=2X8HXtEcU/ZehxuPCgIPz4aOGr6MXTRGr5kvCe3jveI=;
        b=Mu3qC8/ZG6eHc2t/BCs0zZo3apl4tnMOBxVO+xJVXWGEPED5rh9EL4HZXeUbcMKTAl
         9mrizSwl+zaZdjTPduV8uG+zOhiU4ugvQlTWNE4MKVSwOPIq3yvNlg8aFz+8iB/jwVrW
         A4W6YMWALzZzuzswVEeX1IoNp8dsyLs9EflSYweiaTTVdH8fbTs8FMLxM+pdt7z/pTnr
         N/k6lqXr2jyMebsGxHebzWS7SC0wd3LU0okV04IhstFrqzctnMgAzuA4KqCfecMwTSAk
         5vNCJQjl3oEkvzF2ExcdnHv9ACUBntPgcSy9jmyFH2slNh+fKganDqacULrcBHCIrJpM
         K8WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=2X8HXtEcU/ZehxuPCgIPz4aOGr6MXTRGr5kvCe3jveI=;
        b=UD1IuPjdEJRJoIZ5xSGV3sh3QAaqVTEsqxKznSvNxshjwwJDDTXgV/T9OGyoqM//1+
         7N06apVb5MbjNyxcQLktiI/5a87WjePTQLdnB4HXHuwrga+4kcbQG8rkJn6IwjQXOGwS
         YzJRAiKHSsVqDEYwWzFC6z5/JNfreNNnXLPkq0WUcK3DVoDMTlUTNNTTfG7ho04AZo2p
         +WO5hSRs6ZDlF5taa1LZG3WTgz3NU6l/6Z6Jc1Og1d6puspwPWTQtEX6/Vj1cKJHuLHD
         lwyCKZE3fZYDm/kaVJc622sawuB5v3deqpc09FXpr9OH6hZ0K9jQWtv0+TGHcMqvLGUQ
         Sknw==
X-Gm-Message-State: AJIora/bW3xMKvLbVFjNxOB27WIwT7Y9OXDbUSgx9Gt0iB2GRchfzt7B
        2v38kBkCrssBnNYsuvR8iclbQd5MhRxkH3DvEQM=
X-Google-Smtp-Source: AGRyM1txY24+Sdc2MK0NXOySsIiXMakdNIIVEHSfOZwjAj7OYX5VJIM/hNWf9ApOZvAZD6PH4e1AvOqZjWt4T+MBepI=
X-Received: by 2002:a17:907:970d:b0:72b:3589:a22c with SMTP id
 jg13-20020a170907970d00b0072b3589a22cmr27123363ejc.621.1658160080882; Mon, 18
 Jul 2022 09:01:20 -0700 (PDT)
MIME-Version: 1.0
Reply-To: sgtkaylama@gmail.com
Sender: oudounassirou@gmail.com
Received: by 2002:a17:906:c08c:0:0:0:0 with HTTP; Mon, 18 Jul 2022 09:01:20
 -0700 (PDT)
From:   sgtkaylama <sgtkaylama@gmail.com>
Date:   Mon, 18 Jul 2022 16:01:20 +0000
X-Google-Sender-Auth: jCaha363L6eSOCbvR4-7ulut4Gc
Message-ID: <CAHxo4-uOeuwtvSow=jW-DR=WT6d5u3TWgOfrGESRgfE0+bPaYA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

5L2g5aW977yM5L2g5pS25Yiw5oiR5LmL5YmN55qE5Lik5p2h5raI5oGv5LqG5ZCX77yfDQo=
