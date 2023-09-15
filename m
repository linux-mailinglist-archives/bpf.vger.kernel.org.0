Return-Path: <bpf+bounces-10168-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0EC7A24E4
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 19:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 158FC1C20ABB
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 17:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7EEA15EB2;
	Fri, 15 Sep 2023 17:35:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18129CA6F
	for <bpf@vger.kernel.org>; Fri, 15 Sep 2023 17:35:30 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20FA2D7F
	for <bpf@vger.kernel.org>; Fri, 15 Sep 2023 10:34:37 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d81873bf443so2524628276.1
        for <bpf@vger.kernel.org>; Fri, 15 Sep 2023 10:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694799277; x=1695404077; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XJJJkdYQoV+TuxyICMmymuiRvcaqdo/oW6N/B153WLE=;
        b=Hz8jyX9trB5SbK12NzI2q1kW8Cf/npNWwmFvDkY+H9qRrI4zEJ2hTZqhmA6ki3V85n
         gXXHSCi2mR3seK/b7NF9GXcCvkBZT1vhiPcmsYvx8iV7+e8YxV0IHvgJ3/jsNS1wlAUH
         FPJpwifjOuHdQeHeMefLGDqcd232Ad/3yDAsvsDN4fuFZ65t6EAe2bHH4gmoXDiobC4A
         LZSQsAS5O+bN2wRTQEJRzD0NNUE6nbimgOFZQv+DEs+5J4TP32JEPrtAksm2kKShh+b1
         Sf4EPVxAV7c8ln1fa25+5xJ5k1ZWRtsw8QTGo8uUVOP6hRvBd10dfC0sx46izelumbaU
         bCIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694799277; x=1695404077;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XJJJkdYQoV+TuxyICMmymuiRvcaqdo/oW6N/B153WLE=;
        b=idYqAgV2SXERBe1k3JOVWYBvep5l//aXqi7wddd3uV7aN6eryJd54fE0zwkAcP8NwQ
         Q/RV9Y89rk6E5fI6izHofZ/8C/qCY8y9lHUINIANao1OWONLF226OUrFVMglP9wufyGJ
         SYwWdgqcBi4mfgzLz0n333pERd3k3h0IZOI1FtB7cEQv4CtXfVWShk0uxk2eg2VIXf1Q
         URMkxjrn/ZbUyYZdTwU5JyxY3S/iy6BAalFmojkJTVbGpkIIfTB+wr5KXuA8iEvo9+vC
         375Z5jtBbHymYwGgXJ3NuZQhgwNxNUP292ToDGX+VxIbU2ec4hifFNOrGCJ8kN41fJJR
         PQ7w==
X-Gm-Message-State: AOJu0YxVDAlnfMxfb/HgoKxn6rJcyH9GV+28BdxMpBGrEJqtCp15i1QQ
	eCuRvDbsIl6/b+jyq+41Nh0GqR5DkgTkDwVHvg8=
X-Google-Smtp-Source: AGHT+IEAHmjL5dTMrhswiFhjsYks3tmeFWHVYfPFl5tpcAmcDOUwNVDZ9Oub8FCz1WrA9lAgdMaDDhBi7ijkvR//Z9s=
X-Received: from ndesaulniers-desktop.svl.corp.google.com ([2620:15c:2d1:203:7f04:6b3:b482:dd2c])
 (user=ndesaulniers job=sendgmr) by 2002:a25:804f:0:b0:d81:7f38:6d69 with SMTP
 id a15-20020a25804f000000b00d817f386d69mr56369ybn.0.1694799276916; Fri, 15
 Sep 2023 10:34:36 -0700 (PDT)
Date: Fri, 15 Sep 2023 10:34:27 -0700
In-Reply-To: <20230915-bpf_collision-v3-0-263fc519c21f@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230915-bpf_collision-v3-0-263fc519c21f@google.com>
X-Developer-Key: i=ndesaulniers@google.com; a=ed25519; pk=eMOZeIQ4DYNKvsNmDNzVbQZqpdex34Aww3b8Ah957X4=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694799273; l=1627;
 i=ndesaulniers@google.com; s=20230823; h=from:subject:message-id;
 bh=Un0BK6Kn/Y9x5wHtdOd6qUrWjso13vQumzj2rjmjBdg=; b=5rueaC75pOHuA1brjat1Uh1IHpP8UpGk090yWGibirzkwVfVTSK3QKijrRtvJGvRfelm2Ou2H
 XSO66QfARkFC4DnKw4VJgK1+C1hdJdgOulmLsUL76zhBZiawI1HpDVv
X-Mailer: b4 0.12.3
Message-ID: <20230915-bpf_collision-v3-1-263fc519c21f@google.com>
Subject: [PATCH  bpf  v3 1/2] bpf: Fix BTF_ID symbol generation collision
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
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jiri Olsa <jolsa@kernel.org>

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
Link: https://lore.kernel.org/bpf/CAEf4Bzb5KQ2_LmhN769ifMeSJaWfebccUasQOfQKaOd0nQ51tw@mail.gmail.com/
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 include/linux/btf_ids.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
index a3462a9b8e18..a9cb10b0e2e9 100644
--- a/include/linux/btf_ids.h
+++ b/include/linux/btf_ids.h
@@ -49,7 +49,7 @@ word							\
 	____BTF_ID(symbol, word)
 
 #define __ID(prefix) \
-	__PASTE(prefix, __COUNTER__)
+	__PASTE(__PASTE(prefix, __COUNTER__), __LINE__)
 
 /*
  * The BTF_ID defines unique symbol for each ID pointing

-- 
2.42.0.459.ge4e396fd5e-goog


