Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0733D22B11F
	for <lists+bpf@lfdr.de>; Thu, 23 Jul 2020 16:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728632AbgGWOT2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Jul 2020 10:19:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60545 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726089AbgGWOT1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Jul 2020 10:19:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595513966;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=TPxJ6ecRZcUkmgqLd9QvSwuf9V9UOaIvEHGPITh1SwI=;
        b=VWAuYbDKvbf6ismsN/4I9KJXw8OFLzhVTaP+YI59Y3yI9T565CHszyxmnyIj5WOjwsWtZn
        eEakjIUtfHIy6MVMv/Xy9dmPkcSQUkkhX6jguCnqujLfE1iRM/e0bGSMR1dZFEeYyVztMu
        YDQRYsf684E3rNoU8rj39V3drjMYYLk=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-v6sskVWWPHqeNSsYrXrBIw-1; Thu, 23 Jul 2020 10:19:24 -0400
X-MC-Unique: v6sskVWWPHqeNSsYrXrBIw-1
Received: by mail-qv1-f72.google.com with SMTP id x37so3684940qvf.4
        for <bpf@vger.kernel.org>; Thu, 23 Jul 2020 07:19:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TPxJ6ecRZcUkmgqLd9QvSwuf9V9UOaIvEHGPITh1SwI=;
        b=m3l5TY9zafFFr6YoNeHutkK8zB7taCvalxpOy+9NKM/7mqDNH805BxJVDtbLetAB5k
         NDnABXfrpPg5+VNg0vGDAwA+LGBVITCZuAvKtw4imhNBCBFbcXvofazcGixkbKD5ijkQ
         p4mmVS0fyINM0efg/7nCLZN0EnZ9T85gJIg+3/9MApWHoIaiHgfmDBMiFZzl8aRbsj55
         cnDH2s17AffwIZnDmLfyo2vqbktg4xAIEGJ7qBX7xvtzCGC+RJw+KlWYH+xUCvXFW9QJ
         aUWTwNLWftjVLUR03IfwF+ZfMyEVXu43xo/l0Uz87AozJ3EmVD8/X2IGcx42GGjjzei7
         RrSQ==
X-Gm-Message-State: AOAM533TRVzM8PnUg7rJkNmdt3HL/lZgxdDguLneqeyFFGGSq1OoQr8/
        fv9LGdu9ZoRpVFxOoPxapnEVNlF4N9x+A/qw3eFEy/GtLTOml2l3sWyl4z/hB96St9qwbAzQsff
        9EcB9zlBDBBRv
X-Received: by 2002:ae9:dd41:: with SMTP id r62mr5425022qkf.327.1595513964220;
        Thu, 23 Jul 2020 07:19:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyor/sEuJ1ILiUvnXH2q/LutcM92n90ckKA+iXLKs3Ks/I7zdfJPzXs5YbSaHWhsPNDMTwjrA==
X-Received: by 2002:ae9:dd41:: with SMTP id r62mr5424974qkf.327.1595513963870;
        Thu, 23 Jul 2020 07:19:23 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id j9sm2626609qtr.60.2020.07.23.07.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 07:19:23 -0700 (PDT)
From:   trix@redhat.com
To:     ast@kernel.org, daniel@iogearbox.net, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, andriin@fb.com,
        john.fastabend@gmail.com, kpsingh@chromium.org,
        masahiroy@kernel.org, mhiramat@kernel.org, rostedt@goodmis.org,
        akpm@linux-foundation.org, will@kernel.org, krzk@kernel.org,
        patrick.bellasi@arm.com, dhowells@redhat.com,
        ebiederm@xmission.com, hannes@cmpxchg.org
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] bpf: BPF_SYSCALL depends INET
Date:   Thu, 23 Jul 2020 07:19:14 -0700
Message-Id: <20200723141914.20722-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A link error

kernel/bpf/net_namespace.o: In function `bpf_netns_link_release':
net_namespace.c: undefined reference to `bpf_sk_lookup_enabled'

bpf_sk_lookup_enabled is defined with INET
net_namespace is controlled by BPF_SYSCALL

So add a depends on INET to BPF_SYSCALL

Signed-off-by: Tom Rix <trix@redhat.com>
---
 init/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/init/Kconfig b/init/Kconfig
index 7b8ef43e7fb4..817f70e6023c 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1663,6 +1663,7 @@ config BPF_SYSCALL
 	bool "Enable bpf() system call"
 	select BPF
 	select IRQ_WORK
+	depends on INET
 	default n
 	help
 	  Enable the bpf() system call that allows to manipulate eBPF
-- 
2.18.1

