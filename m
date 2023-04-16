Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 261556E3B5D
	for <lists+bpf@lfdr.de>; Sun, 16 Apr 2023 21:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjDPTCe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 16 Apr 2023 15:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjDPTCe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 16 Apr 2023 15:02:34 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EEDD1BD8;
        Sun, 16 Apr 2023 12:02:33 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-2f86ee42669so907346f8f.2;
        Sun, 16 Apr 2023 12:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681671751; x=1684263751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vw8K9fe+BlHCUVCEUNteZqDUg2w+tCDi6+6HkvyhbCY=;
        b=qrWTzF5KSXiFBNT9RZSsE4u8rkHU1SLZoG9HmEBWLts7+VDVVjuHPlXTjsrUko1edj
         0p+/DTS3DUXa8ea71PjBKND7xExmptK/sGPhhOZsuAJoh5Q1xBpgKmXoLYJ8OdD/Iqsj
         5iknGE0ZRsIsqWZktZNSBqaSWLWnWdS31BfEKTmwW/7RZ08PIZKbz/Xa5VQrFoXNWdjW
         hbVsRzzXeoD+x5Adn48gI4CQKnrO0LFjUZxrLz00DvhMn0ETFWLIG+DhsABJhLYMYR48
         LVSpJRp+KUXHl5CwMIQWVFdZr5FwJxv8eNaQgqo6+hoE6P3JBmw7SJ0Yt+PgJsJ3gQ1+
         tadw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681671751; x=1684263751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vw8K9fe+BlHCUVCEUNteZqDUg2w+tCDi6+6HkvyhbCY=;
        b=bmcFXDPeMHGVgnh/TdNYLAxuJIixALNmJmovYpAuF2g5WihzUemiJt+l/T5+KMw4h0
         /8NNcisx+5lprEoK1a+d5UzL/J1OJLx+OwdWnG60oV3GC2JZnJh+lcUQkOysTAbmtBAv
         os8BB9QFl2XI9oapzUY4HX3Dqz3OCoOlbOuiZSUYfuGjz/MxRn7aWmAoJHjVZPm9Z856
         hQOnqCUIbI2xkgJzbHSk7fVfoaEfDZMoEgdw4JlhwqRW7/VPysR8kBS6jUogJ3U+DJE7
         k+Gmtwf3xuLwpCeoLPjSt+3LAix6xRA9iteR/EckQloQe8CYlOno/hU0Je/zxGmPjo47
         yxkQ==
X-Gm-Message-State: AAQBX9chOkr0MXhX2+6yg/LXMfAs20L106iA2fwtYcQE8xRIFxYZQzNv
        uYt5F6nduUmRErfQmTIVU6A=
X-Google-Smtp-Source: AKy350Yhb2/Ost8B4BG2zSTY73BCtmMjq4hc5FDXGK8LYQdOinL90QqSnSxJifZrD2T+f8FHgnN1Wg==
X-Received: by 2002:a5d:5141:0:b0:2f8:a8de:1a with SMTP id u1-20020a5d5141000000b002f8a8de001amr3870906wrt.42.1681671751572;
        Sun, 16 Apr 2023 12:02:31 -0700 (PDT)
Received: from solpc.. (67.pool90-171-92.dynamic.orange.es. [90.171.92.67])
        by smtp.gmail.com with ESMTPSA id y18-20020adff6d2000000b002daf0b52598sm8685421wrp.18.2023.04.16.12.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 12:02:31 -0700 (PDT)
From:   =?UTF-8?q?Joan=20Bruguera=20Mic=C3=B3?= <joanbrugueram@gmail.com>
To:     jpoimboe@kernel.org
Cc:     i.pear@outlook.com, acme@kernel.org, alan.maguire@oracle.com,
        alexandref75@gmail.com, bpf@vger.kernel.org, dxu@dxuuu.xyz,
        jforbes@redhat.com, linux-kernel@vger.kernel.org,
        olsajiri@gmail.com, peterz@infradead.org, ptalbert@redhat.com,
        yhs@fb.com
Subject: [PATCH] vmlinux.lds.h: Discard .note.gnu.property section
Date:   Sun, 16 Apr 2023 19:02:19 +0000
Message-Id: <20230416190219.2600911-1-joanbrugueram@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230413185922.ufmollqlnlghwyvy@treble>
References: <20230413185922.ufmollqlnlghwyvy@treble>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Two small nitpicks:

> Link: https://lkml.kernel.org/lkml/57830c30-cd77-40cf-9cd1-3bb608aa602e@app.fastmail.com

This link is "semi-broken", it should go to /bpf/ instead of /lkml/.

>  	/DISCARD/ : { *(.note.GNU-stack) }				\
> +	/DISCARD/ : { *(.note.gnu.property) }				\

Both discards can go in the same DISCARD block.
(just style; it's how it's most often done in other linker scripts)
