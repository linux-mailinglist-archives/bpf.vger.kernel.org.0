Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 252BE46DC45
	for <lists+bpf@lfdr.de>; Wed,  8 Dec 2021 20:32:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239599AbhLHTg3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Dec 2021 14:36:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:29764 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239595AbhLHTg3 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 8 Dec 2021 14:36:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638991976;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YQ1E78Ne8vjALFP2xkCWPlT3pLBIYO8xU81gXWhpDuU=;
        b=Ss8EyJTyTvo9nOKOjbMKBEKwTTDdU3xH7JoFv4Ta3auu0rir9hLgJ1tx1mkxnUErzTOHsX
        m8Pds5My1os2KgjVdhCDbc6CvZXoxG3zrbfTu5Q4pOrWd+eV/xdPXUaG5eenghPNGXaBmE
        exy677iIiBgyIgHGMfKvOOe0CcVtYIg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-129-O0CJe-bLMdCUzcG--6fY-Q-1; Wed, 08 Dec 2021 14:32:55 -0500
X-MC-Unique: O0CJe-bLMdCUzcG--6fY-Q-1
Received: by mail-wr1-f69.google.com with SMTP id f3-20020a5d50c3000000b00183ce1379feso664728wrt.5
        for <bpf@vger.kernel.org>; Wed, 08 Dec 2021 11:32:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YQ1E78Ne8vjALFP2xkCWPlT3pLBIYO8xU81gXWhpDuU=;
        b=UNCsnRFP43xOD4/4njDVNrcHje5QBz9XsXIT5bmRgug8dtJWWW68KXDyzrPa4JJcDC
         OnL/0Ux54JbEAYI7YhH1XSMymLq7ShXCrGoxSYxSDoBpbziJQGhENNh24dkiUnbdAhkw
         4qxEu9T4gyNBP6Bv+5Fh27NKzssR78jyXcP10fdz122lJgjQUccZPDVaTcW03g3yLEBO
         K+uGR1Hpjpu9DvcIjBOkDJqllE66m8SHhrNgJUu+W6OfSzeVWEaGFMu/tHfosryF8fG2
         HxoJzenam5G54ixu7fUa7SOWV70JzM4pW8V1gCa2VM03sKUQUwq0YPtexm6bmCmmWK4L
         p+rA==
X-Gm-Message-State: AOAM533t5WIrqKobmskWVTy09ZLolV17jypcl+Q0MJZz4HbfQQfd2/mt
        1c4JQXH7vIZUP9N/IuPFxul+/h1FKptOFjTkDSKAcxlT1ynvddljyA+YY9o1KxVMt2yMS/UzaCS
        tp2O91lMJO3Jm
X-Received: by 2002:a7b:ca55:: with SMTP id m21mr921538wml.178.1638991974381;
        Wed, 08 Dec 2021 11:32:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwf1JmKxMS+ShochuP7Q0LlIlxnITOIcrKgvNRny3DBK05gXMQVdOsFNxRyq3o7taqCwiaDtA==
X-Received: by 2002:a7b:ca55:: with SMTP id m21mr921520wml.178.1638991974219;
        Wed, 08 Dec 2021 11:32:54 -0800 (PST)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id g13sm3497338wmk.37.2021.12.08.11.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 11:32:53 -0800 (PST)
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
Subject: [PATCHv2 bpf-next 1/5] bpf: Allow access to int pointer arguments in tracing programs
Date:   Wed,  8 Dec 2021 20:32:41 +0100
Message-Id: <20211208193245.172141-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211208193245.172141-1-jolsa@kernel.org>
References: <20211208193245.172141-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Adding support to access arguments with int pointer arguments
in tracing programs.

Currently we allow tracing programs to access only pointers to
string (char pointer), void pointers and pointers to structs.

If we try to access argument which is pointer to int, verifier
will fail to load the program with;

  R1 type=ctx expected=fp
  ; int BPF_PROG(fmod_ret_test, int _a, __u64 _b, int _ret)
  0: (bf) r6 = r1
  ; int BPF_PROG(fmod_ret_test, int _a, __u64 _b, int _ret)
  1: (79) r9 = *(u64 *)(r6 +8)
  func 'bpf_modify_return_test' arg1 type INT is not a struct

There is no harm for the program to access int pointer argument.
We are already doing that for string pointer, which is pointer
to int with 1 byte size.

Changing the is_string_ptr to generic integer check and renaming
it to btf_type_is_int.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/bpf/btf.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 01b47d4df3ab..8a79e906dabb 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -4826,7 +4826,7 @@ struct btf *bpf_prog_get_target_btf(const struct bpf_prog *prog)
 		return prog->aux->attach_btf;
 }
 
-static bool is_string_ptr(struct btf *btf, const struct btf_type *t)
+static bool is_int_ptr(struct btf *btf, const struct btf_type *t)
 {
 	/* t comes in already as a pointer */
 	t = btf_type_by_id(btf, t->type);
@@ -4835,8 +4835,7 @@ static bool is_string_ptr(struct btf *btf, const struct btf_type *t)
 	if (BTF_INFO_KIND(t->info) == BTF_KIND_CONST)
 		t = btf_type_by_id(btf, t->type);
 
-	/* char, signed char, unsigned char */
-	return btf_type_is_int(t) && t->size == 1;
+	return btf_type_is_int(t);
 }
 
 bool btf_ctx_access(int off, int size, enum bpf_access_type type,
@@ -4957,7 +4956,7 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 		 */
 		return true;
 
-	if (is_string_ptr(btf, t))
+	if (is_int_ptr(btf, t))
 		return true;
 
 	/* this is a pointer to another type */
-- 
2.33.1

