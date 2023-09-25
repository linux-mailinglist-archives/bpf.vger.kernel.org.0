Return-Path: <bpf+bounces-10729-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 584FD7ACEA4
	for <lists+bpf@lfdr.de>; Mon, 25 Sep 2023 05:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 15E342814BA
	for <lists+bpf@lfdr.de>; Mon, 25 Sep 2023 03:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D945672;
	Mon, 25 Sep 2023 03:19:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AE07F
	for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 03:19:07 +0000 (UTC)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C15A3
	for <bpf@vger.kernel.org>; Sun, 24 Sep 2023 20:19:06 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-d77ad095f13so6213497276.2
        for <bpf@vger.kernel.org>; Sun, 24 Sep 2023 20:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695611945; x=1696216745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FxkGnDTXDrXQcaPK0msgbRMLMh6g/ncWpCZCy/3Gr6o=;
        b=TdveWuNoAPMHDLjsIeQfG4uYBxIS8F7AVB23svahdhYSzjLes8se9qRjx1H5csIqH7
         S2XqxMQAjd22BcKgVRyDEpowaTG4ShUpfMXVYz1Y/VYhGtAStaGcsBArvVk9iOs8r5YO
         dRJOyV6OSCNnD0KZPxobSqbUeuIZVd1P1RtCjBj0QckwGeyPRjOTqKpGQCiuqdPLQ6ZO
         u5GMKhxPeeYVaykfL+9l8i8CZQjoPcBCnzXs347eWpRsOEFdPN8hYhRrlmUrJbA7o4bN
         7BWrO1dbbghuXy3bZVP2xFKypmDR2fPcljaz7Zs0WNyGkz1Vhkdj3385f1K/n8UTVaJZ
         mUwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695611945; x=1696216745;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FxkGnDTXDrXQcaPK0msgbRMLMh6g/ncWpCZCy/3Gr6o=;
        b=S8ZGWiDLD2D3xVII3Qx2UgLnpJ3XBM8L11ynG9htDjGInqCGN+497i+CO0p0w2lBga
         sP/7m0gQLEhP2evUiSZ+RYBXB5rVmQJZeOyTLaTNotrwZ71FpPS9Eqj6eMN32Jlil3MG
         0m7q41CiCV0AF3o+SSwu3++F03Iz/kwCPfnzLqfDPXJ0FF/CYKlAPFd7NSbYC+kVC1ge
         W5FPcZyzSF93iybYoJ6/yq2lXi+QoPkfDXDxwlK/5U50XWaC6WD4P9huQ7gijkjF6Zcv
         /p4eyl1lvkLItVoVSgRm3rg+Ovm3wBklnyboZaRdl0UXD/ziv/hz0YdoxYTvoFvqTBdY
         zwQw==
X-Gm-Message-State: AOJu0Yw/m+62I4N99uZdq4y2tpAeHITKCz7KgebMW0TwJVMCYdfVUiI9
	f8RLhsQiYRvh+ZA7jXPynL2cFt1JYl655w==
X-Google-Smtp-Source: AGHT+IGtUg9Q4ykqaBFkpTuc2/OGldlZ4oCuO3muIyzt7XfP3iupOaGSpCTmhvfWsZ8gyo3jsZcOoA==
X-Received: by 2002:a25:d1c5:0:b0:d32:cd49:2469 with SMTP id i188-20020a25d1c5000000b00d32cd492469mr4926807ybg.24.1695611945275;
        Sun, 24 Sep 2023 20:19:05 -0700 (PDT)
Received: from ubuntu.. ([120.229.73.42])
        by smtp.googlemail.com with ESMTPSA id z186-20020a6333c3000000b00581048ffc13sm2158739pgz.81.2023.09.24.20.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Sep 2023 20:19:04 -0700 (PDT)
From: Hengqi Chen <hengqi.chen@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	hengqi.chen@gmail.com,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH bpf-next] libbpf: Allow Golang symbols in uprobe secdef
Date: Mon, 25 Sep 2023 02:57:22 +0000
Message-Id: <20230925025722.46580-1-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Golang symbols in ELF files are different from C/C++
which contains special characters like '*', '(' and ')'.
With generics, things get more complicated, there are
symbols like:

  github.com/cilium/ebpf/internal.(*Deque[go.shape.interface {
   Format(fmt.State, int32); TypeName() string;
  github.com/cilium/ebpf/btf.copy() github.com/cilium/ebpf/btf.Type
  }]).Grow

Add " ()*,-/;[]{}" (in alphabetical order) to support matching
against such symbols. Note that ']' and '-' should be the first
and last characters in the %m range as sscanf required.

A working example can be found at this repo ([0]).

  [0]: https://github.com/chenhengqi/libbpf-go-symbols

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 tools/lib/bpf/libbpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index b4758e54a815..de0e068195ab 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -11630,7 +11630,7 @@ static int attach_uprobe(const struct bpf_program *prog, long cookie, struct bpf
 
 	*link = NULL;
 
-	n = sscanf(prog->sec_name, "%m[^/]/%m[^:]:%m[a-zA-Z0-9_.@]+%li",
+	n = sscanf(prog->sec_name, "%m[^/]/%m[^:]:%m[]a-zA-Z0-9 ()*,./;@[_{}-]+%li",
 		   &probe_type, &binary_path, &func_name, &offset);
 	switch (n) {
 	case 1:
-- 
2.34.1


