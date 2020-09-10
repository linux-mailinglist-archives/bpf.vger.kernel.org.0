Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 605332653B6
	for <lists+bpf@lfdr.de>; Thu, 10 Sep 2020 23:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgIJVjr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Sep 2020 17:39:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24105 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730618AbgIJNKq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Sep 2020 09:10:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599743399;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yw+OBp17cq1h1RyAy6dvNRDL5oF78jBZQhRd17iuPDs=;
        b=L5mFrcaeXuz27jPbtqb+kz9BHnHddOzaZgvA8qmGyCCqoz89W+eeotmr0WO/TZcbfzgCgY
        IKALmcETLK4WiU1mT4bRAL9cBCnQQYPD9ywP8y5iWX3O7mf/W+NT6AmS8TQPeC1TD6FUNO
        VnqnK5boOahTK3XY3OaF3FOrIjZ3bw4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-fu8Ou3nQMdWsnlbtQz5WTw-1; Thu, 10 Sep 2020 09:09:58 -0400
X-MC-Unique: fu8Ou3nQMdWsnlbtQz5WTw-1
Received: by mail-wr1-f69.google.com with SMTP id j7so2247362wro.14
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2020 06:09:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=Yw+OBp17cq1h1RyAy6dvNRDL5oF78jBZQhRd17iuPDs=;
        b=fjVw+/MwKqnScfllU94b5sRcIrgUln7LA6/6fnkpBgqx4a1uNL4UdtBpqsy87GaHOt
         LRj7OWLzXZSN2SLinAIHPUfersCYZWf7nlnohvANfoAgGMZ3Mk8RsiGZEzqFdmcr6HyK
         xt2QwCt0/aoDTamFcGdKBHRR/SSbIdCZQADUicclAPj0xWVoDhaGZg1wvy+aU2fcGwu9
         yXzAW107JrWaeTuHX7B/HVqNbfqABZnZJhFIj/a7PA9PbnhHy3PcoIDgBQO0Clhw+fbL
         vAa2bY0Dm40MNWP81XojOj9y0HJaOeulbr452s6nwKeCOS/HHeah0zrySEOGT34z6+rD
         1+QQ==
X-Gm-Message-State: AOAM531N4V8q2RmOXk7ieMiJfkEz8MK033gpk3aWG5JMG69TKoCPKw0T
        WmNsXgwREHvQ81S7fR55Ww5zvzTAnOeV+TIzPXbgz8KDZyUQdARGs5GyohSValCBB8GkWA2lBvk
        JrA86gxivJhPy
X-Received: by 2002:a7b:c111:: with SMTP id w17mr8183093wmi.109.1599743397122;
        Thu, 10 Sep 2020 06:09:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJycEaK5TE/MoXeqj+IsAcLh/p9SQZRnb7s/lYfqop6e2OFEVCKao3zw4umSy+u7dd9kI5Ompw==
X-Received: by 2002:a7b:c111:: with SMTP id w17mr8183071wmi.109.1599743396963;
        Thu, 10 Sep 2020 06:09:56 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 91sm9937489wrq.9.2020.09.10.06.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 06:09:56 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 203A91829D5; Thu, 10 Sep 2020 15:09:56 +0200 (CEST)
Subject: [PATCH bpf-next v3 6/9] tools: add new members to
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
Date:   Thu, 10 Sep 2020 15:09:56 +0200
Message-ID: <159974339603.129227.16169601282261093819.stgit@toke.dk>
In-Reply-To: <159974338947.129227.5610774877906475683.stgit@toke.dk>
References: <159974338947.129227.5610774877906475683.stgit@toke.dk>
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

