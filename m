Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67EAF265D3A
	for <lists+bpf@lfdr.de>; Fri, 11 Sep 2020 12:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725864AbgIKKAf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Sep 2020 06:00:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26027 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725870AbgIKJ7e (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Sep 2020 05:59:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599818372;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yw+OBp17cq1h1RyAy6dvNRDL5oF78jBZQhRd17iuPDs=;
        b=R+dTyeIYsf8TBsaMI1k/B+PDkGNYLBB70WWjzVIlqY4UDI6Z8DvOq4WXfrXN1IVy56ASTM
        dq9jur1OoLo7v1QR3gd0NAaBjJBzs7f4fJgWSjyR2H1tgSezdyx7wG109MjRfaaygS6XDH
        BpUEx7EJK14SMBxuGiwmTeuReDhJt5g=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-193-H-urjTjJMk6HwdrRSOf7ow-1; Fri, 11 Sep 2020 05:59:25 -0400
X-MC-Unique: H-urjTjJMk6HwdrRSOf7ow-1
Received: by mail-wm1-f72.google.com with SMTP id 189so1164886wme.5
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2020 02:59:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=Yw+OBp17cq1h1RyAy6dvNRDL5oF78jBZQhRd17iuPDs=;
        b=mlfQn3utDKurYUJ05tEYplXn2oK2sl1cK5KGwfJOqseZnjWerYtIkm0mWNPVxmk39g
         rFVRnAZASpTb5DlVUAAgZNHBo/q9N5rM67rtmLIJK+aARtG+IFuPOkmXsYltan9Do/x3
         Qy4kZniIalh99rVwW175UmbHm9Jf1l1gaDsaM/L7M/cBGNhcJ/ex2VIxbO64v5xE6ufE
         bOj4AaIARnpMckMQDsPvhp+wF7cePlI5610wWWbS7rVZOZ62y+J/1HQ1dHvUW7L78NtE
         ehqJLPNxdnbOhwsq6G1MKw5W/BOYadeULXi/Nny5P4WjVdvT1XBHZqy4gCAVngCfxuyZ
         d3+Q==
X-Gm-Message-State: AOAM532R1nStVEQBSa/6hIUPWtRFj3ibIGmbCvfmnMVSOn7WQO5pv6Iv
        Y2xuUooHSJ2ak3Qpy7vDbU+lOvezobYpZWpm3130aXn5nMuwVwA2lRKSzsFc1fmGRkl7kYtsl40
        7CLv4oED9bUNo
X-Received: by 2002:a1c:9950:: with SMTP id b77mr1475241wme.5.1599818364015;
        Fri, 11 Sep 2020 02:59:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwjaevFM/brwL7/zuHm2kxWloBn0Sj5bnN9U4Gj7kpUU/NNGgl2Pm5K8v/TX3DGYFrLk8jrtg==
X-Received: by 2002:a1c:80d7:: with SMTP id b206mr1378348wmd.161.1599818362098;
        Fri, 11 Sep 2020 02:59:22 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id l8sm3602001wrx.22.2020.09.11.02.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 02:59:21 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 5E6381829D4; Fri, 11 Sep 2020 11:59:21 +0200 (CEST)
Subject: [PATCH RESEND bpf-next v3 6/9] tools: add new members to
 bpf_attr.raw_tracepoint in bpf.h
From:   =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <ast@kernel.org>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Eelco Chaudron <echaudro@redhat.com>,
        KP Singh <kpsingh@chromium.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Date:   Fri, 11 Sep 2020 11:59:21 +0200
Message-ID: <159981836129.134722.13602310042777114855.stgit@toke.dk>
In-Reply-To: <159981835466.134722.8652987144251743467.stgit@toke.dk>
References: <159981835466.134722.8652987144251743467.stgit@toke.dk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Toke Høiland-Jørgensen <toke@redhat.com>

Sync addition of new members from main kernel tree.

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/include/uapi/linux/bpf.h |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 90359cab501d..0885ab6ac8d9 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -595,8 +595,10 @@ union bpf_attr {
 	} query;
 
 	struct { /* anonymous struct used by BPF_RAW_TRACEPOINT_OPEN command */
-		__u64 name;
-		__u32 prog_fd;
+		__u64		name;
+		__u32		prog_fd;
+		__u32		tgt_prog_fd;
+		__u32		tgt_btf_id;
 	} raw_tracepoint;
 
 	struct { /* anonymous struct for BPF_BTF_LOAD */

