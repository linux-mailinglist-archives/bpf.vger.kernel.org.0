Return-Path: <bpf+bounces-10169-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FAF57A24E9
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 19:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5252A1C20AFC
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 17:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB95415EB1;
	Fri, 15 Sep 2023 17:35:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3916ECA6F
	for <bpf@vger.kernel.org>; Fri, 15 Sep 2023 17:35:55 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 797DD30D4
	for <bpf@vger.kernel.org>; Fri, 15 Sep 2023 10:34:39 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59c081a44afso16004997b3.3
        for <bpf@vger.kernel.org>; Fri, 15 Sep 2023 10:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694799278; x=1695404078; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sJC1MpNA41XSWsvvv83w1mhfvF8TpSh3HYkxNC3IYos=;
        b=jgFa188BP2SILiAWR0B1X6XsgVn7BslM7Us/SDpdwusZSBp4uy5fa4ZWfRopAT4u0s
         SAbSQVVtOHZAdekCInESBcRinfCezDiagRudwdZzr6sfx2YnmOWO780oo5cNQjItwNZu
         vI4Efah3+uA29/9yQAucvuKOYPKkU23xhlAvyFxhb95D5dFCX0T3WgjKkKM1nJPfWPNu
         fhI/ZZiwKXYkgWbsSwJVaqK4dH61qq8WaGms2VBnhb0soPQeGPeS9xh/Kp4NS+S4kkcm
         DaqUJNBLgEFroMV4tPSOPEH/AUKlk+hQS/pkr2armRbxVfkSpASKcedhRvk1q9J+ZwBI
         atXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694799278; x=1695404078;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sJC1MpNA41XSWsvvv83w1mhfvF8TpSh3HYkxNC3IYos=;
        b=gh4lnnA6Xe7NQ1TZjhO72j15O3RzIAfG5pAVBhX6lAwJT7QijY0UlOlsdueG9gc/Vd
         luJZqx1BnxRrMhjDU+HJZ16q7LbhjCwSPJlda7IXpUMTrRyWF0JeXlb6rY/eJF44rOML
         UTdibD3/0hNyVeXMrA5z54UYDD8o1Qczz4tT2qw4TyJyQPMeKpOH0E/nn486mMmKRI6D
         RzRxAKuuY1HXDWrc5RrJKQ1vsJ1MIoXeQbvBIx0slevg05LL+WhDUrB/H8x+y6dW11ty
         9Z8HR0pXXRdvQAoY1Fm/tQDalXUQSAkivDgTRRFbPOQ1KJRe8HukdmFlp/CpkLaUu4P8
         iO+g==
X-Gm-Message-State: AOJu0YxEP0SJcY8krwGTscaHufE7NIykap+EuuXPAH2ZC4t0eILN7F7y
	w57b/C3hAhQ8t22QdiS1kl3sqAmftJys1KiTzME=
X-Google-Smtp-Source: AGHT+IE9UAT+K+q9ytinkFyMWYt0GrL3lw/3Oewo8P4+2sZ76QzEaJefM4cOvauekXpyLQEY5rvHcSIjPxsuBoor+qM=
X-Received: from ndesaulniers-desktop.svl.corp.google.com ([2620:15c:2d1:203:7f04:6b3:b482:dd2c])
 (user=ndesaulniers job=sendgmr) by 2002:a81:ac05:0:b0:59b:ea2e:23f0 with SMTP
 id k5-20020a81ac05000000b0059bea2e23f0mr60367ywh.2.1694799278777; Fri, 15 Sep
 2023 10:34:38 -0700 (PDT)
Date: Fri, 15 Sep 2023 10:34:28 -0700
In-Reply-To: <20230915-bpf_collision-v3-0-263fc519c21f@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230915-bpf_collision-v3-0-263fc519c21f@google.com>
X-Developer-Key: i=ndesaulniers@google.com; a=ed25519; pk=eMOZeIQ4DYNKvsNmDNzVbQZqpdex34Aww3b8Ah957X4=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694799273; l=1657;
 i=ndesaulniers@google.com; s=20230823; h=from:subject:message-id;
 bh=kgMWLZDqu9UqeTMmXyEC7cxyK+tytDiO2sXAmlSWnBI=; b=7Fop81vSJL23p4VMu5VzZxe8rIQuLhkNpBVhUlwKmPRY48Ma16klxeWZnl8lr8TXo/sQ0gPcx
 t/omK9dcidKAX6N/6NMBikRu7Gj1erxfAt6dZLA53bmu2mXDriFKJow
X-Mailer: b4 0.12.3
Message-ID: <20230915-bpf_collision-v3-2-263fc519c21f@google.com>
Subject: [PATCH  bpf  v3 2/2] bpf: Fix BTF_ID symbol generation collision in tools/
From: Nick Desaulniers <ndesaulniers@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Jiri Olsa <jolsa@kernel.org>
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Nick Desaulniers <ndesaulniers@google.com>, stable@vger.kernel.org, 
	Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>, Marcus Seyfarth <m.seyfarth@gmail.com>, 
	Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Marcus and Satya reported an issue where BTF_ID macro generates same
symbol in separate objects and that breaks final vmlinux link.

  ld.lld: error: ld-temp.o <inline asm>:14577:1: symbol
  '__BTF_ID__struct__cgroup__624' is already defined

This can be triggered under specific configs when __COUNTER__ happens to
be the same for the same symbol in two different translation units,
which is already quite unlikely to happen.

Add __LINE__ number suffix to make BTF_ID symbol more unique, which is
not a complete fix, but it would help for now and meanwhile we can work
on better solution as suggested by Andrii.

Cc: stable@vger.kernel.org
Reported-by: Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>
Reported-by: Marcus Seyfarth <m.seyfarth@gmail.com>
Closes: https://github.com/ClangBuiltLinux/linux/issues/1913
Debugged-by: Nathan Chancellor <nathan@kernel.org>
Co-developed-by: Jiri Olsa <jolsa@kernel.org>
Link: https://lore.kernel.org/bpf/CAEf4Bzb5KQ2_LmhN769ifMeSJaWfebccUasQOfQKaOd0nQ51tw@mail.gmail.com/
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 tools/include/linux/btf_ids.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/include/linux/btf_ids.h b/tools/include/linux/btf_ids.h
index 71e54b1e3796..2f882d5cb30f 100644
--- a/tools/include/linux/btf_ids.h
+++ b/tools/include/linux/btf_ids.h
@@ -38,7 +38,7 @@ asm(							\
 	____BTF_ID(symbol)
 
 #define __ID(prefix) \
-	__PASTE(prefix, __COUNTER__)
+	__PASTE(__PASTE(prefix, __COUNTER__), __LINE__)
 
 /*
  * The BTF_ID defines unique symbol for each ID pointing

-- 
2.42.0.459.ge4e396fd5e-goog


