Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0C7AE9A7
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2019 13:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731963AbfIJL4a (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Sep 2019 07:56:30 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36037 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731926AbfIJL4a (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 Sep 2019 07:56:30 -0400
Received: by mail-wr1-f66.google.com with SMTP id y19so19628214wrd.3
        for <bpf@vger.kernel.org>; Tue, 10 Sep 2019 04:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=erwaox0KQegjEF70k5TnX2qoDQuWlO/oZz7eu2CybDk=;
        b=U2yeuy49oz2xrU00CSc0L8N5m7pK1clPrglgIMpG4rwgHeb78qd5OYUi+5Q7cHdFdC
         XxpH8vL5J5D5B50U8ksPia+n2rOTT3Efl9AwBmd+S3oN5n1wwszlZixPpAUvXef3tmqJ
         lxvRnOTGcuHYY2hfs0yzy76NJ53p+Zmof1EQ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=erwaox0KQegjEF70k5TnX2qoDQuWlO/oZz7eu2CybDk=;
        b=I+k4vcfb+pKbu58MPV/IkeeFgiGymxkHJI3f2s72Uw+3XRdLCwTi9juYtGhDoJUyzV
         h3UUooB0nzF1w4kWxg8w9piifXHTL1wMeCVX/Z9nY78UGOytVggkGEI6/yjBPhG8u5BC
         vRr+YY25RKzCXb2EGiR2f5A3eF9P/MZYKr0ZAV9Ew7F8xHfpsq46sInr1f45CMBBB5ug
         r3XhWqswFn3K1TzGOoDq3i/qt8dgCyDFeBuXj0yG+DsKGUKKcvPZ7hGpifPiVdGmTeXD
         8TAXXSBgp0nW4wKh0VsJ+96/Gl+kmzgLgfF085XBBd3rWHtdqxtMG9zPhn55elOo6iuQ
         vFXQ==
X-Gm-Message-State: APjAAAWte66s2kvIQgP7W5x4Ng/JB6iGq3v99jWOEm3INHTpn4p+1OUI
        4j+yaIAHUHi6ui+iyISvTEMziQ==
X-Google-Smtp-Source: APXvYqwezaTQauLlYnnq67hLlLJ4sDXlgLRoqeO6CL/e/dXjtdzUMWZO0oPgM5a7vUghEl33WTHJVw==
X-Received: by 2002:adf:e947:: with SMTP id m7mr26845791wrn.178.1568116586919;
        Tue, 10 Sep 2019 04:56:26 -0700 (PDT)
Received: from kpsingh-kernel.c.hoisthospitality.com (110.8.30.213.rev.vodafone.pt. [213.30.8.110])
        by smtp.gmail.com with ESMTPSA id q19sm23732935wra.89.2019.09.10.04.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2019 04:56:26 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Garnier <thgarnie@chromium.org>,
        Michael Halcrow <mhalcrow@google.com>,
        Paul Turner <pjt@google.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Jann Horn <jannh@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Christian Brauner <christian@brauner.io>,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Florent Revest <revest@chromium.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Andrey Ignatov <rdna@fb.com>, Joe Stringer <joe@wand.net.nz>
Subject: [RFC v1 03/14] bpf: krsi: sync BPF UAPI header with tools
Date:   Tue, 10 Sep 2019 13:55:16 +0200
Message-Id: <20190910115527.5235-4-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190910115527.5235-1-kpsingh@chromium.org>
References: <20190910115527.5235-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

Signed-off-by: KP Singh <kpsingh@google.com>
---
 tools/include/uapi/linux/bpf.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index a5aa7d3ac6a1..32ab38f1a2fe 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -171,6 +171,7 @@ enum bpf_prog_type {
 	BPF_PROG_TYPE_CGROUP_SYSCTL,
 	BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE,
 	BPF_PROG_TYPE_CGROUP_SOCKOPT,
+	BPF_PROG_TYPE_KRSI,
 };
 
 enum bpf_attach_type {
@@ -197,6 +198,7 @@ enum bpf_attach_type {
 	BPF_CGROUP_UDP6_RECVMSG,
 	BPF_CGROUP_GETSOCKOPT,
 	BPF_CGROUP_SETSOCKOPT,
+	BPF_KRSI,
 	__MAX_BPF_ATTACH_TYPE
 };
 
-- 
2.20.1

