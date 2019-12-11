Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 096CD11BFDA
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2019 23:34:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbfLKWeb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Dec 2019 17:34:31 -0500
Received: from mail-pg1-f201.google.com ([209.85.215.201]:54524 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727045AbfLKWea (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Dec 2019 17:34:30 -0500
Received: by mail-pg1-f201.google.com with SMTP id i21so181228pgm.21
        for <bpf@vger.kernel.org>; Wed, 11 Dec 2019 14:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=32U3png4dzMqFX2eRDO2dCbQbOL/7+0IfZtgOUFBf0A=;
        b=Jtn/gEWQD7EIy6Bjrl5YvoRO959WbqPKaUQlDLnoRDEImaXWJvFLaFqaEeczCp0g9h
         7qyyodzuklWb9l1hpaUI1/sdZZRc7dsnKtExMT64sUgQhCFVbqZrNq3CZ+SNciD/FRA6
         hk+P2/9MSu8NHmKYd5U0kpnfbWAJGHYVCoRPCmCmrifHLSqosXIA31Ys2Y5NGUXN3vqQ
         f89DvdMylPXXnvTdWbhHX85RVDNujkBbCF2JxyC2tNfESxA8XkHtCOyrQQZ98A3U9a4+
         CDOL1MkRE10kDhOJbY05MpuIEGothGjv5rkbv8d+AzZjvXEzkIkn4sr4H73emfkNVN2P
         Z3Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=32U3png4dzMqFX2eRDO2dCbQbOL/7+0IfZtgOUFBf0A=;
        b=hEhJBWx/Uwwxvhm9FuKLODutw2TUvzMKRBODna4gHtb5upxWJpovub6rPYtfA5K/AM
         o3Ke9RuVttazJWN6Ix9sRf9WDfwPx2t6W5DWPokpzuSpYqBy6yU/HLAZEECKlyuuzA3t
         PvUqII7kA+ORpdA3aU94DTbvp4D1YJoGifh23Q473InuzAHYYEtASgp26gLhRNseCu3O
         duYXZwIc6f7YI8PDAvXCM1uNb15IbBOzvzWnIWUQQLGU73HNyitiy0fF1ZJb6+dH5z/U
         X3MvE/Ya94r3+pmx1mftNwxXmf5k6hAUxTAu2lhvRvhjs2Xx0SvtKbj+4N2pVrcsMHXV
         3PaQ==
X-Gm-Message-State: APjAAAVcD4CDF9MyLyE0kj/T/K3m8QSQEga/tffu4Aq8UczR0gM80zDZ
        RLmIVPPa1oh6flbkavtUFJChRr2hnlUZ
X-Google-Smtp-Source: APXvYqwY81AwnzuaarejlQK1EoJNAtQ4xSv07K5q/7brfr2nih2yEfDd7UoNKLARUKM2GsTStuOuoB67BlyQ
X-Received: by 2002:a63:647:: with SMTP id 68mr6839227pgg.202.1576103669219;
 Wed, 11 Dec 2019 14:34:29 -0800 (PST)
Date:   Wed, 11 Dec 2019 14:33:37 -0800
In-Reply-To: <20191211223344.165549-1-brianvv@google.com>
Message-Id: <20191211223344.165549-5-brianvv@google.com>
Mime-Version: 1.0
References: <20191211223344.165549-1-brianvv@google.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH v3 bpf-next 04/11] bpf: add lookup and updated batch ops to arraymap
From:   Brian Vazquez <brianvv@google.com>
To:     Brian Vazquez <brianvv.kernel@gmail.com>,
        Brian Vazquez <brianvv@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S . Miller" <davem@davemloft.net>
Cc:     Yonghong Song <yhs@fb.com>, Stanislav Fomichev <sdf@google.com>,
        Petar Penkov <ppenkov@google.com>,
        Willem de Bruijn <willemb@google.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This adds the generic batch ops functionality to bpf arraymap, note that
since deletion is not a valid operation for arraymap, only batch and
lookup are added.

Signed-off-by: Brian Vazquez <brianvv@google.com>
---
 kernel/bpf/arraymap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index f0d19bbb9211e..95d77770353c9 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -503,6 +503,8 @@ const struct bpf_map_ops array_map_ops = {
 	.map_mmap = array_map_mmap,
 	.map_seq_show_elem = array_map_seq_show_elem,
 	.map_check_btf = array_map_check_btf,
+	.map_lookup_batch = generic_map_lookup_batch,
+	.map_update_batch = generic_map_update_batch,
 };
 
 const struct bpf_map_ops percpu_array_map_ops = {
-- 
2.24.1.735.g03f4e72817-goog

