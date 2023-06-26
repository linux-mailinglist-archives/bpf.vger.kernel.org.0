Return-Path: <bpf+bounces-3490-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF0773ECD2
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 23:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 787C31C209EC
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 21:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A08514ABD;
	Mon, 26 Jun 2023 21:25:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1265515482
	for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 21:25:27 +0000 (UTC)
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF97B1
	for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 14:25:25 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-55ac8fffd76so1606630a12.3
        for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 14:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687814725; x=1690406725;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=URKMjv+4ZtdGwvZBU33A6vWxznm0yMyIs6Mq7HWvLFg=;
        b=L7TkrqzjCcf99z+IJI8Dt+jEd919atFzHt8TaYM7OeOpabS6fA14/VUcUskXMoa0eW
         Po2xWE7Js7xNS3wPUey+QPyAxMmeGx6Dnwh71Y2lfxIMLbFVHGJRVsxO7GG2FV/tSo0Z
         ihKia2UWnjdAIp4qKEuXDJJqzVio5RBwiD6lcXx467lLXWo2oiZZ7TVojwWfO/B9gRlX
         37v2CzDOq87fK33Cl2kj2l0hhkNIlhI/9oKmSshE5J16zKw9Sj8MMQ0YhWt/cGDbA6/Q
         ohgkVTetXRisDRUcYsC7TcKHzjPrqUFsbUxxJLSlxXcDbDS01cOq3ewAlj6VzhMe7/MB
         0Msg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687814725; x=1690406725;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=URKMjv+4ZtdGwvZBU33A6vWxznm0yMyIs6Mq7HWvLFg=;
        b=fDhgDgZVMrlKgi3thq3ihiAyNiyHFqkQyiY/+ETNVpjqnemC1JQTV0/qVZM0irYXlA
         SaoiOTf9zPnqYHBWEtMNANkdevJVqpFY1n6H0LV/4euJBWPJ9c9EqMyPonkcBbFBs9K5
         ETe4bD0roqhdPVBRwNu8FN1u/zGpnj+2qE5kyBuy92NkrLFQHkg+n0JkY3b/gYaIM7Vy
         xaH3npTbMuegv/9da1Hq3ZFxU4VhdFUSnUYvc6XqDHW+868UwAhCX5v9sUajIH1VqE92
         2Cdm6if9zEA5ctw9MhWTvbY+c6kNrKXtjqjrMT2lQjgiBr/AWz0g8tRwLBCJP2IK5yMD
         8QJw==
X-Gm-Message-State: AC+VfDyUS6gxb15vM7MobWlX/E1hyuuxYlCral84DBAxdCRGfNSw2WWk
	4GY2nAIv41MbD3DXBgeywtV1vRaSZpMsuiwkdwHLyAiMmGN38+ouvlH6dDr6Pzt9UUi16m4nY6M
	gjEQmMcdthrSQ84nCsdYfpwSR5xHmKbKvPJOSepGt+XDPWApf6w==
X-Google-Smtp-Source: ACHHUZ5okIdqQBURMBQVRkAlE6oPFYAm8uNsAuwUmFGBDYYLq+CjwwPjPRxzJNpNcW+EZJ4OmPyOryQ=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:902:d193:b0:1b7:ef3f:5ed3 with SMTP id
 m19-20020a170902d19300b001b7ef3f5ed3mr1119081plb.5.1687814724703; Mon, 26 Jun
 2023 14:25:24 -0700 (PDT)
Date: Mon, 26 Jun 2023 14:25:21 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230626212522.2414485-1-sdf@google.com>
Subject: [PATCH bpf-next 1/2] bpf: Resolve modifiers when walking structs
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

It is impossible to use skb_frag_t in the tracing program.
Resolve typedefs when walking structs.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 kernel/bpf/btf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 29fe21099298..3dd47451f097 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6135,6 +6135,8 @@ static int btf_struct_walk(struct bpf_verifier_log *log, const struct btf *btf,
 
 	*flag = 0;
 again:
+	if (btf_type_is_modifier(t))
+		t = btf_type_skip_modifiers(btf, t->type, NULL);
 	tname = __btf_name_by_offset(btf, t->name_off);
 	if (!btf_type_is_struct(t)) {
 		bpf_log(log, "Type '%s' is not a struct\n", tname);
-- 
2.41.0.162.gfafddb0af9-goog


