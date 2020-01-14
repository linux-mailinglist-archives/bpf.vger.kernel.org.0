Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3A2313AFD0
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2020 17:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbgANQqs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Jan 2020 11:46:48 -0500
Received: from mail-ua1-f74.google.com ([209.85.222.74]:33058 "EHLO
        mail-ua1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728998AbgANQqr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Jan 2020 11:46:47 -0500
Received: by mail-ua1-f74.google.com with SMTP id z7so2313912uai.0
        for <bpf@vger.kernel.org>; Tue, 14 Jan 2020 08:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bTzv6GNpgfrRZmeHOV0jVc+oFdZ9HuTWtPYHIUcg/W4=;
        b=S70B1gZPy/hQdsMI3k2PIeDncvGnKD4+33/gDuZ4XKA2/sUizILM7mWuAQp/UGsq0K
         Sfx74WC6dkf9O7Puh8BR1bYEp8OD4mkhSouiJOzM/dPBybExzOAawG+QKta2BE0fFC4L
         I3Gk14zSgsFpw3ui1F2HWlvm4O0pXiolI38oHwk1hGpNZB2ETWyyLs2tuDBePt0sAhUJ
         6DhRs703GqXiGt+kXnPPo6fmu4rjMUVsBqR6xpHb9E/o2RGXL3vk7Tfk9kuxnNYP9es5
         UNhxKPbhCp7cr2KWhFgTaRjXS1A2GrzW0eErqULc325gA0Xk8dZeFvJttcpxcJaUExnb
         hnaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bTzv6GNpgfrRZmeHOV0jVc+oFdZ9HuTWtPYHIUcg/W4=;
        b=fNawPgVobpTrm0hGvDVIZc/oVWIgkiA1WrekoOYMWEBv5XqBN5yH2d2BxRm8kKqMtK
         eoryH1Nb0bvN92vFJyPeaZv9EZUL09e1W3sJ2biXhphLGDxzp8AjS0Hlamvq1Qse0XjV
         cRQ6ib8YIoSmgOPsP/dcTFhheHMkIk/KmIQ9ikvpgKwpASCltu3bk0k2Fi1sSsO6JeiW
         B1OnlzA3yOPwg1L7pDv8aoelcnOYrY+o89w17oli1ybScVMbe++bflYGEnh0zUsIoMnp
         m6W13v1hNa8mW6SVd/Jy+qtkECD+I3TleVx+QzngtvLDbyHXQwZiJCqH+OBGQuHvn0/5
         NjwQ==
X-Gm-Message-State: APjAAAWxL/4METW16NhQ80FK3lMYZMJnQFdmKryVDJYu75Ql5TSpquhq
        gh41fWGHfKifx0cuqxjCThP8jNSGm//C
X-Google-Smtp-Source: APXvYqzZQBV7AbWitZ2PB2oSQE21EANy/WfEvZSvsFN3/ZWYfM6BaTau/5PBcwtYNhP1qRudj1jff6eSnd0u
X-Received: by 2002:a67:be13:: with SMTP id x19mr1832482vsq.20.1579020406547;
 Tue, 14 Jan 2020 08:46:46 -0800 (PST)
Date:   Tue, 14 Jan 2020 08:46:09 -0800
In-Reply-To: <20200114164614.47029-1-brianvv@google.com>
Message-Id: <20200114164614.47029-6-brianvv@google.com>
Mime-Version: 1.0
References: <20200114164614.47029-1-brianvv@google.com>
X-Mailer: git-send-email 2.25.0.rc1.283.g88dfdc4193-goog
Subject: [PATCH v4 bpf-next 4/9] bpf: add lookup and updated batch ops to arraymap
From:   Brian Vazquez <brianvv@google.com>
To:     Brian Vazquez <brianvv.kernel@gmail.com>,
        Brian Vazquez <brianvv@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S . Miller" <davem@davemloft.net>
Cc:     Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Stanislav Fomichev <sdf@google.com>,
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
Acked-by: Yonghong Song <yhs@fb.com>
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
2.25.0.rc1.283.g88dfdc4193-goog

