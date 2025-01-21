Return-Path: <bpf+bounces-49388-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92470A17FB1
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 15:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F9DE7A256A
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 14:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248521F3D4F;
	Tue, 21 Jan 2025 14:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E8OaOaKq"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6625D1F37D0
	for <bpf@vger.kernel.org>; Tue, 21 Jan 2025 14:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737469534; cv=none; b=oFImCgy2Ghqt+d+zszQPtquJKioGpVLnoLXVu1FTYDYtVsXJ9r1P03Z6M53A7ie0RtEDz0vn3/JQ/m3dl7Z5Bt8QBHO+xLr6hYKnGqFMZHooLBGsv72g4uNHNYkk587eV60kUn4uV6Hym521oD39EKV6fRmf+2VoZAsYxbdOSz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737469534; c=relaxed/simple;
	bh=J7Vx3L310jAzxAh8q8+pNqO5NDwd9wWW5TXfltnQXI4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ij4v2yODKEnR+1xcq7AKjz8jp0Xx8OeSMNlH5OrWL1WqOXjjELhzkoo6JWdwU0zW6OTIjQ7kty25xwUccxmDDS8Z2pTns4rpE/3WUtybGH8+DfJtK0G0dm4wsDlY75XFKnaSu9HLyqv/zIsovbmeV8hY58HmDERDeDyWf62lowI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E8OaOaKq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737469531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vuGGo9UIaQnmFOwY4BK8JGBIoTzmm8Sq6jjvbqQ+D1Y=;
	b=E8OaOaKqqlWIPgt3AykRlWmCEUJDN+Z+Vl0lhdHmcrMVxA1izyt15rfMy30u7eDoBMOdEh
	bCtyQOSFB76cqYWRkwcoSA/z7eBXHI1vam/iOIKj1nZquH7fs8mlt8NnhzZYQj2Nnhye3u
	vfmTZLSpkaKZasu3w1rmgZezA45EO3s=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-PIzs4S8FMR2HDDGbc_NZhQ-1; Tue, 21 Jan 2025 09:25:30 -0500
X-MC-Unique: PIzs4S8FMR2HDDGbc_NZhQ-1
X-Mimecast-MFC-AGG-ID: PIzs4S8FMR2HDDGbc_NZhQ
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7b6f2515eb3so488634985a.0
        for <bpf@vger.kernel.org>; Tue, 21 Jan 2025 06:25:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737469529; x=1738074329;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vuGGo9UIaQnmFOwY4BK8JGBIoTzmm8Sq6jjvbqQ+D1Y=;
        b=dQidHRn0vOivYHoqVC6tWra7TBIYwGURSMNdWitzde5lmlV/rfQx6yEHbs4K9W3Xg0
         ynIex16H3zJRxOBYp+mFbcHURQuEs5z11ild8Y77x3UI2s2T/oJnKJtvjeGc+ibuYMtV
         Vhd/Qp7EAbYM0l3wYeArTVu7PQYdsMozMaS1/dU8QjemYpjEMVDQb/dyFaqHa+Nfv3j7
         HirkyhkW12fq2mMx4V5hjdBE+x9eQlAiZAFG98HOMj/7yeUBP7VS+BGpc8MeUkDr2EwP
         BV0tsHjv4yKvmJvnLmMrbAfJMIjTlPnsoDsrnAj3xYVUpGCczx4DhRVHrMsKbApAVUxH
         YXbg==
X-Gm-Message-State: AOJu0YzR1QZDf6Lg5kWM2pEK7aFfH7uATJiucxorj7KQbVBBEYDhwxfD
	wOHxab79o6SIVmE0+sFzyElIzs5/UnTtNBJCLKfBmOzCqeuR8RyXPGY/TJgoYUsGAtpb22Zcm8J
	Y8eRkZ8eVx2vv0Xf+hXBllw6UBlP3lKKiasNHZoxMOOxZglqYqbw2CrW439RB4bLsQpR/A2K/+1
	2e2QxO2JLepEW9ymYur07c5rwmG6xU9uYQDs4tSw==
X-Gm-Gg: ASbGncvJFhkqDYRzhktHU/rM/IrKJCcxi0vlsuWW0pmKWtrE4m0UeZVg53O51+wmY/d
	eZRejCVSENNWRfvO6+3S/ZtPszKYH5qgDbL2y/THYMNnv2REPbvW2FQ7iv//uCDSCRMz0wVEfhG
	SmKdNmQZ/5nZyo2riSwwdM99DNz/AZ832/RPZKY8+xTQ4ignEVDvhkUDUUW4eMoWwtDfns4qFUp
	TypZwcMMfrjzkEBQV88fhDEVY++uLeHyDDA7kuwQlB41OeGsfGrZfJpkvOAdPtt7wF1b184fP6W
	VIvXNnQqg5i6TNYzZ5GSxtnTyQ==
X-Received: by 2002:a05:622a:10b:b0:467:5016:57fa with SMTP id d75a77b69052e-46e12bb32cfmr270188981cf.44.1737469529375;
        Tue, 21 Jan 2025 06:25:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG7FJAOEYs9FmZzN/e90EyVdvrbsiJ/wWpfja5T6g83n9uMLKvVIf9zTACdtczzOkqk6hC5Aw==
X-Received: by 2002:a05:622a:10b:b0:467:5016:57fa with SMTP id d75a77b69052e-46e12bb32cfmr270188431cf.44.1737469528860;
        Tue, 21 Jan 2025 06:25:28 -0800 (PST)
Received: from jkangas-thinkpadp1gen3.rmtuswa.csb ([2601:1c2:4301:5e20:98fe:4ecb:4f14:576b])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7be614ef1a5sm555999885a.102.2025.01.21.06.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 06:25:28 -0800 (PST)
From: Jared Kangas <jkangas@redhat.com>
To: bpf@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	martin.lau@kernel.org,
	jkangas@redhat.com,
	ast@kernel.org,
	johannes.berg@intel.com,
	kafai@fb.com,
	songliubraving@fb.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>
Subject: [PATCH bpf v2] bpf: remove unnecessary BTF lookups in bpf_sk_storage_tracing_allowed
Date: Tue, 21 Jan 2025 06:25:04 -0800
Message-ID: <20250121142504.1369436-1-jkangas@redhat.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When loading BPF programs, bpf_sk_storage_tracing_allowed() does a
series of lookups to get a type name from the program's attach_btf_id,
making the assumption that the type is present in the vmlinux BTF along
the way. However, this results in btf_type_by_id() returning a null
pointer if a non-vmlinux kernel BTF is attached to. Proof-of-concept on
a kernel with CONFIG_IPV6=m:

    $ cat bpfcrash.c
    #include <unistd.h>
    #include <linux/bpf.h>
    #include <sys/syscall.h>

    static int bpf(enum bpf_cmd cmd, union bpf_attr *attr)
    {
        return syscall(__NR_bpf, cmd, attr, sizeof(*attr));
    }

    int main(void)
    {
        const int btf_fd = bpf(BPF_BTF_GET_FD_BY_ID, &(union bpf_attr) {
            .btf_id = BTF_ID,
        });
        if (btf_fd < 0)
            return 1;

        const int bpf_sk_storage_get = 107;
        const struct bpf_insn insns[] = {
            { .code = BPF_JMP | BPF_CALL, .imm = bpf_sk_storage_get},
            { .code = BPF_JMP | BPF_EXIT },
        };
        return bpf(BPF_PROG_LOAD, &(union bpf_attr) {
            .prog_type            = BPF_PROG_TYPE_TRACING,
            .expected_attach_type = BPF_TRACE_FENTRY,
            .license              = (unsigned long)"GPL",
            .insns                = (unsigned long)&insns,
            .insn_cnt             = sizeof(insns) / sizeof(insns[0]),
            .attach_btf_obj_fd    = btf_fd,
            .attach_btf_id        = TYPE_ID,
        });
    }
    $ sudo bpftool btf list | grep ipv6
    2: name [ipv6]  size 928200B
    $ sudo bpftool btf dump id 2 | awk '$3 ~ /inet6_sock_destruct/'
    [130689] FUNC 'inet6_sock_destruct' type_id=130677 linkage=static
    $ gcc -D_DEFAULT_SOURCE -DBTF_ID=2 -DTYPE_ID=130689 \
        bpfcrash.c -o bpfcrash
    $ sudo ./bpfcrash

This causes a null pointer dereference:

    Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
    Call trace:
     bpf_sk_storage_tracing_allowed+0x8c/0xb0 P
     check_helper_call.isra.0+0xa8/0x1730
     do_check+0xa18/0xb40
     do_check_common+0x140/0x640
     bpf_check+0xb74/0xcb8
     bpf_prog_load+0x598/0x9a8
     __sys_bpf+0x580/0x980
     __arm64_sys_bpf+0x28/0x40
     invoke_syscall.constprop.0+0x54/0xe8
     do_el0_svc+0xb4/0xd0
     el0_svc+0x44/0x1f8
     el0t_64_sync_handler+0x13c/0x160
     el0t_64_sync+0x184/0x188

Resolve this by using prog->aux->attach_func_name and removing the
lookups.

Fixes: 8e4597c627fb ("bpf: Allow using bpf_sk_storage in FENTRY/FEXIT/RAW_TP")
Link: https://lore.kernel.org/bpf/20250116162356.1054047-1-jkangas@redhat.com
Suggested-by: Martin KaFai Lau <martin.lau@linux.dev>
Signed-off-by: Jared Kangas <jkangas@redhat.com>
---
V1 -> V2: Used Martin KaFai Lau's suggestion (see lore.kernel.org link),
          edited patch summary + description accordingly.

 net/core/bpf_sk_storage.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index 2f4ed83a75ae..72a0dc8b1646 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -352,11 +352,6 @@ const struct bpf_func_proto bpf_sk_storage_delete_proto = {
 
 static bool bpf_sk_storage_tracing_allowed(const struct bpf_prog *prog)
 {
-	const struct btf *btf_vmlinux;
-	const struct btf_type *t;
-	const char *tname;
-	u32 btf_id;
-
 	if (prog->aux->dst_prog)
 		return false;
 
@@ -371,13 +366,7 @@ static bool bpf_sk_storage_tracing_allowed(const struct bpf_prog *prog)
 		return true;
 	case BPF_TRACE_FENTRY:
 	case BPF_TRACE_FEXIT:
-		btf_vmlinux = bpf_get_btf_vmlinux();
-		if (IS_ERR_OR_NULL(btf_vmlinux))
-			return false;
-		btf_id = prog->aux->attach_btf_id;
-		t = btf_type_by_id(btf_vmlinux, btf_id);
-		tname = btf_name_by_offset(btf_vmlinux, t->name_off);
-		return !!strncmp(tname, "bpf_sk_storage",
+		return !!strncmp(prog->aux->attach_func_name, "bpf_sk_storage",
 				 strlen("bpf_sk_storage"));
 	default:
 		return false;
-- 
2.47.1


