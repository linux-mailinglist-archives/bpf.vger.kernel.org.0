Return-Path: <bpf+bounces-1801-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED58722191
	for <lists+bpf@lfdr.de>; Mon,  5 Jun 2023 10:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E45D028103E
	for <lists+bpf@lfdr.de>; Mon,  5 Jun 2023 08:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F80134B6;
	Mon,  5 Jun 2023 08:57:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78660804
	for <bpf@vger.kernel.org>; Mon,  5 Jun 2023 08:57:50 +0000 (UTC)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEAB0F2
	for <bpf@vger.kernel.org>; Mon,  5 Jun 2023 01:57:48 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-53404873a19so2222726a12.3
        for <bpf@vger.kernel.org>; Mon, 05 Jun 2023 01:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685955468; x=1688547468;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FaHv+GqIuupfkrZUyUWk5Q4hx0WfnhqmWCBGMeHIKLU=;
        b=KeqlD1aRIsDdM6Vqb4akcJ6zcHhsL9ilA7kuJStql37FzHCIKmjFm/Jn+j4TItsmc1
         D1Hh8CqYkJk1EViC7NfSnKpn++JEkbeCyx2rPig9TO9bEtL2bAlKJP9EscH77aKClu64
         KIKiFbaLoCt+H+FsdyGy0HxP+EbvqlEaTPg0XsTMwsUtE5r3NpyNGXEc88Z1DmDwQKqp
         jkWG8roq/gVLvo8OPgzQ81+b3x56lbc9+VFsW2e0ikjQNlxA8UU7IxppXnXFU2to3v6B
         n5W5ySoJ33mvPpjwmDZmM9QK52Wb272wMfnxs04AmvOy0tgsT5xGc6UvNB0/cwNXdKX8
         0uEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685955468; x=1688547468;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FaHv+GqIuupfkrZUyUWk5Q4hx0WfnhqmWCBGMeHIKLU=;
        b=CgCTEvOezobUmZLMYOKjpUy2+n3HkwXqk9B8eIZfMCHM03zysjZo6hwZ79qOORbDt4
         Gr27gtpu9jjcOlm3vWjeeh8gYLkk4nboz5jddr4NafhGqgvkg4ymuFt9OxBfDtbfWelw
         KiShHJ1xj4ryau3ExqNmolYZOfvv4GcTnqFGdnb8SDx9P7cnrXo/AvJb1V2T/6gsVdKu
         Vh1Pv+4OTfVgcNZrftCcDp531fZ7LjymN/y9mIioHUI5FT/zcTol0Oy9spe47Q6skcFX
         otweDgQ36xvV3S68ZH9d4eFHL7Mdpb9rN6wLMNG7ENyMqJG0nGc9+XYav8QF58S/hT/E
         LtPw==
X-Gm-Message-State: AC+VfDzQfP104P4Aj3QHAR37DX7weLa0T0eLKrLJpv5mi+V9vuMPkWjN
	t9bbo1u75AVwGSl0a6CUDm4XTTrsfKM=
X-Google-Smtp-Source: ACHHUZ4fNchsr8TsS3+zd1hpNU/yW7WfoRC3DF0t1G0hg+esIXbE66paMXNH6KGHLjufqn9Qv7HUOQ==
X-Received: by 2002:a17:90a:181:b0:256:dbfb:9b5e with SMTP id 1-20020a17090a018100b00256dbfb9b5emr2418000pjc.29.1685955467794;
        Mon, 05 Jun 2023 01:57:47 -0700 (PDT)
Received: from localhost.localdomain ([120.26.165.80])
        by smtp.gmail.com with ESMTPSA id mv7-20020a17090b198700b0024dfb8271a4sm5503901pjb.21.2023.06.05.01.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 01:57:47 -0700 (PDT)
From: Yang Bo <yyyeer.bo@gmail.com>
X-Google-Original-From: Yang Bo <yb203166@antfin.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	Yang Bo <bo@hyper.sh>
Subject: [PATCH 0/2] Add api to manipulate global varaible
Date: Mon,  5 Jun 2023 16:57:31 +0800
Message-Id: <20230605085733.1833-1-yb203166@antfin.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
	HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Yang Bo <bo@hyper.sh>

We (the antgroup) has a requirement to manipulate global variables. 
The platform to manage bpf bytecode has no idea about varaibles'
type/size/address. It only has some strings (like key = value) passed
from admin. We find a way to parse BTF and then query/update the 
variables. There may be better ways to do it. This approach is what
we can find for now.

Yang Bo (2):
  Add api to manipulate global variable
  mini test case.

 tools/lib/bpf/bpf.c         | 808 ++++++++++++++++++++++++++++++++++++
 tools/lib/bpf/bpf.h         |   9 +
 tools/lib/bpf/libbpf.map    |   2 +
 tools/lib/bpf/mini/Makefile |   2 +
 tools/lib/bpf/mini/main.c   | 130 ++++++
 5 files changed, 951 insertions(+)
 create mode 100644 tools/lib/bpf/mini/Makefile
 create mode 100644 tools/lib/bpf/mini/main.c

-- 
2.40.0


