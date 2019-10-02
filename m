Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B706C87CE
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2019 14:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728345AbfJBMEO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Oct 2019 08:04:14 -0400
Received: from mail-lf1-f54.google.com ([209.85.167.54]:41007 "EHLO
        mail-lf1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbfJBMEO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Oct 2019 08:04:14 -0400
Received: by mail-lf1-f54.google.com with SMTP id r2so12496833lfn.8
        for <bpf@vger.kernel.org>; Wed, 02 Oct 2019 05:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QRH9ZC+8Ny/msHWcjGNR4E0iaqUnOOF/L6UnfzfPUco=;
        b=f23rjIBkvLQp+jBBwDivqvjjR/UzmHdWYZ4YuKB85ScWs9VNgvA4l82vxQfSKKcZEP
         itqjeh+PE4szh6m8AkdQaJJxl6kUhJ8wJOarb5IdXg9vbAtL1XMIVR5GAnhstXFNND9/
         Tp4gkIs5PllRsdkpY0tfIKPIgCcuc2Jev1sSRm073Mp01icxsgnlr84wDdLUSQaXMP+k
         gdZUX1vY5UU14Jlni8T57B/T5LsGEjD7zT/IkovAMyovfrbBrh+A7DWt3m3hHZSCotdE
         2TdjRXRHjDwrrJHQpJb0i4AzX8eAXPkFYyS996qsFqApNUZqWLy6/4AJfn9J38+jDwIq
         Z0Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QRH9ZC+8Ny/msHWcjGNR4E0iaqUnOOF/L6UnfzfPUco=;
        b=gAxdgzeDpBRaKVYyBNdFAOuDHFqiM+DIdMpmvdqLiu9octqTMSlc+bNh4/e2/Wz6ji
         HrOin/cdpzzup1fKaQYdoIwU2Od/ali0E/3wbJlU+Tzet+fUVs7sp88E6QGz6Xi2Vdwy
         s76/E/977M+dK73tvLD7XZB2Nzq8L3WYJjfiQHy5oQNRg6tOImIlAHHLgSK4NjpjdCYs
         xJY/9tNRGzrvg5u00kfEZJEUjCQtvg/QnrPurv74suI1XN974AVUoQ9jfHXfUZskawdM
         4QdnLfyA/m0qFCCbUnLpfyD9/LuSQcLPz/yy75O09dCRbwNH+gGYp2rftlRycBKy1Upd
         IROQ==
X-Gm-Message-State: APjAAAU0HaEDosdwYDxdDjqhP2DJ1mHUUXNcGsRejCE4DmBieaPpLD4+
        92JDBFn78bzx1hgaPU9lzuEZcn4EGZY=
X-Google-Smtp-Source: APXvYqyyyNzF3fRohqc2QWfIhha0eeknjrB2f4OKPHr3+Ot91a5QKrvaEtH0TD3WHGORsSn1/bsxrg==
X-Received: by 2002:ac2:5925:: with SMTP id v5mr2150152lfi.8.1570017852633;
        Wed, 02 Oct 2019 05:04:12 -0700 (PDT)
Received: from localhost.localdomain (168-200-94-178.pool.ukrtel.net. [178.94.200.168])
        by smtp.gmail.com with ESMTPSA id x2sm4833827ljj.94.2019.10.02.05.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 05:04:11 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     shuah@kernel.org, ast@kernel.org, daniel@iogearbox.net
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH bpf-next 0/2] selftest/bpf: remove warns for enable_all_controllers
Date:   Wed,  2 Oct 2019 15:04:02 +0300
Message-Id: <20191002120404.26962-1-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This micro series fixes annoying warn described in patches
while samples/bpf build. Second patch fixes new warn that
comes after fixing warn of first patch, that was masked.

Ivan Khoronzhuk (2):
  selftests/bpf: add static to enable_all_controllers()
  selftests/bpf: correct path to include msg + path

 tools/testing/selftests/bpf/cgroup_helpers.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.17.1

