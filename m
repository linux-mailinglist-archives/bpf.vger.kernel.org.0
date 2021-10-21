Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F680436075
	for <lists+bpf@lfdr.de>; Thu, 21 Oct 2021 13:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbhJULoN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Oct 2021 07:44:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55825 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230372AbhJULoJ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 21 Oct 2021 07:44:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634816513;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=srAxXppIvHz+myMAl+rb3OMXLAjwG2sT2dL0Sifr8SY=;
        b=Ml8QgT+qYdLA+R3BA2kYMTfFaMksbXnT1bZRAL+QxEgw/H2Ap3yA1pk9qDmv75PI1SjFXW
        TlMkD+b0I1evLxaxgfL7A7TOLELIZioJ2zfMPtTXuhYDZtsio83rs0DJK+JkDKPzZRCCZ9
        MSnyDgb2tHmITvcLwyr3jmoArS0Asec=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-586-CeHn1C9CPTSfY7JNuYP6vg-1; Thu, 21 Oct 2021 07:41:52 -0400
X-MC-Unique: CeHn1C9CPTSfY7JNuYP6vg-1
Received: by mail-ed1-f71.google.com with SMTP id g28-20020a50d0dc000000b003dae69dfe3aso36212edf.7
        for <bpf@vger.kernel.org>; Thu, 21 Oct 2021 04:41:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=srAxXppIvHz+myMAl+rb3OMXLAjwG2sT2dL0Sifr8SY=;
        b=o36hmjZmDLfnj+yE49lu/buF8XaBG5CYJ2zKBrjA+2O/gpLf8Fho/XKYPx0sqh+jth
         zDDuDGdI7/Zl9E6kT06gOJKR01YlrlBsmqiODDOQU1e9K03KbCmgTQ3uTkIslPp+5jAa
         o7eNIj4726rz2XcoVTwlB40rbtj6x1qUGfCkdyAcrLiRl1dnImTuePiJSbINaw2MkFIM
         gRoK8bSXeeV354aLNJRyKga0ba5mZKY576gFwitaXm7u10TEUpmD/87MZXUJRJQTpxc7
         71w7WRDnhxSGyy5s1f7S9ADvB1tGiXOMoQ6K9T0LU7kVe44GpmuWBKtejY9YxP5putiT
         Hpng==
X-Gm-Message-State: AOAM530gpC7s0/6E+kBrce4u9b0q+pAteqHK2X90uNRcqZsnE5CFdl+T
        UgmtT7mXqDqdIjzqNs0OV09bRSFq137PrOIEoPx2hoYz6xR17koEGwxM1tE5IycHjSA/yzPRV2h
        SUUWEFWIHSPae
X-Received: by 2002:a05:6402:50d4:: with SMTP id h20mr7009037edb.112.1634816511345;
        Thu, 21 Oct 2021 04:41:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwNkiRG6MQhchj2BPeZhgF7KMFN9UW11wQbBPpenEdGJRKXrqcz/xS8eCT3E+oZ38nmMtm6RQ==
X-Received: by 2002:a05:6402:50d4:: with SMTP id h20mr7009009edb.112.1634816511158;
        Thu, 21 Oct 2021 04:41:51 -0700 (PDT)
Received: from krava.cust.in.nbox.cz ([83.240.63.48])
        by smtp.gmail.com with ESMTPSA id u23sm2747922edr.97.2021.10.21.04.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 04:41:50 -0700 (PDT)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>
Subject: [PATCH bpf-next 3/3] selftests/bpf: Use nanosleep tracepoint in perf buffer test
Date:   Thu, 21 Oct 2021 13:41:32 +0200
Message-Id: <20211021114132.8196-4-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211021114132.8196-1-jolsa@kernel.org>
References: <20211021114132.8196-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The perf buffer tests triggers trace with nanosleep syscall,
but monitors all syscalls, which results in lot of data in the
buffer and makes it harder to debug. Let's lower the trace
traffic and monitor just nanosleep syscall.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/testing/selftests/bpf/progs/test_perf_buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/test_perf_buffer.c b/tools/testing/selftests/bpf/progs/test_perf_buffer.c
index d37ce29fd393..a08874c5bdf2 100644
--- a/tools/testing/selftests/bpf/progs/test_perf_buffer.c
+++ b/tools/testing/selftests/bpf/progs/test_perf_buffer.c
@@ -12,7 +12,7 @@ struct {
 	__type(value, int);
 } perf_buf_map SEC(".maps");
 
-SEC("tp/raw_syscalls/sys_enter")
+SEC("tp/syscalls/sys_enter_nanosleep")
 int handle_sys_enter(void *ctx)
 {
 	int cpu = bpf_get_smp_processor_id();
-- 
2.31.1

