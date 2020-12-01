Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CBA42C9690
	for <lists+bpf@lfdr.de>; Tue,  1 Dec 2020 05:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgLAEmP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Nov 2020 23:42:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbgLAEmO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Nov 2020 23:42:14 -0500
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9940DC0613CF
        for <bpf@vger.kernel.org>; Mon, 30 Nov 2020 20:41:28 -0800 (PST)
Received: by mail-qv1-xf41.google.com with SMTP id dm12so267590qvb.3
        for <bpf@vger.kernel.org>; Mon, 30 Nov 2020 20:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MbejTzN2AoaC0fZmxVnDviiEA6VLhv3i8JMsXe1AiIs=;
        b=QGxzfhaF30zkdPCH0ae51Df+DlPUHIskuvilRZZmHlb8GK3qf5IY39GfzRufwSPemS
         wuYoNylKfLfXgANLNKWAVymYkILoChjBCiICr7tEuby12bTO2zqHXx15ZGs7iSnwjiDh
         MSQqOoNT6SEh9Y6tEavLwkuFTKXlpDFA7Lh+JpI/sAjBwhkCzoSsNaXvYxOH1ywb/L0r
         SitpZ+ZIDA8434f6fQUOBEL2NgxhkIvCjPkGHACSgkgbvul4lroyQz3zQetfY4yZDE0j
         lNvj7jLtGOMZf0aZfZ31H6AHrtO+LfwpzVVIHIWC+aayvMtnxli1ZxGxCY/XJm0vMQFp
         i6/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MbejTzN2AoaC0fZmxVnDviiEA6VLhv3i8JMsXe1AiIs=;
        b=giTILlgC26Dw9Y9KQyiEe1ozJMf2LI1kn1FbaU/3GsYuwgmjRo2FYUCqflTO0mrEYq
         0+YMrcA4iVI3hW/9Ip4dCStyhowIjXR2OV3CdzwO5rPnlMTyUEJtEnSkf9S44+mHF1Da
         hn3SHS5EF0/78/7by3dOHbswbcK0vyPNbTr6uH1cCGMp7GbstvM+IFgk95iVB1p1FeMR
         tBK0tmpaNIgq8o9xbCf0u3CaxMbE2ZvKnqDBHHDHECAcjeOiOlK2PHnikFp6ZEsgxYdt
         Sjf6nnQNdBKv3Nk4mmpXiKRZ/kgQswN7ej2mMd/g0wgmCCnCI1YXXzxXc/8DvZ6GG3l8
         Eiig==
X-Gm-Message-State: AOAM533SqXjpcNjt8x91yfrUkfrzFPbFAqY3AZFeeuGSRxoZGbUUTNh9
        mnd5QAseg6GwKfCMV5ja4JGxIj/WbL0U6w==
X-Google-Smtp-Source: ABdhPJwwEbU09jn25yA+p0bmluoQ1hXKcMefNklt7wmHyyGN8r3n6+qYDOmYyJOFsDqgTN/JVi/t1w==
X-Received: by 2002:a0c:f951:: with SMTP id i17mr1297411qvo.22.1606797686974;
        Mon, 30 Nov 2020 20:41:26 -0800 (PST)
Received: from localhost (pool-96-239-57-246.nycmny.fios.verizon.net. [96.239.57.246])
        by smtp.gmail.com with ESMTPSA id d140sm676821qke.59.2020.11.30.20.41.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Nov 2020 20:41:25 -0800 (PST)
From:   Andrei Matei <andreimatei1@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Andrei Matei <andreimatei1@gmail.com>
Subject: [PATCH bpf-next 0/1] libbpf: fail early when loading programs with unspecified type
Date:   Mon, 30 Nov 2020 23:41:03 -0500
Message-Id: <20201201044104.24948-1-andreimatei1@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch should help people who misunderstand the importance of using
proper prefixes to their ELF sections in bpf object files. The patch
assumes that programs with type BPF_PROG_TYPE_UNSPEC are always invalid,
as indicated by `man 2 bpf`. Please let me know if that is not accurate.

Andrei Matei (1):
  libbpf: fail early when loading programs with unspecified type

 tools/lib/bpf/libbpf.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

-- 
2.27.0

