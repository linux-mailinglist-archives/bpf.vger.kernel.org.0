Return-Path: <bpf+bounces-1294-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B64307122D1
	for <lists+bpf@lfdr.de>; Fri, 26 May 2023 10:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 714C21C20FE4
	for <lists+bpf@lfdr.de>; Fri, 26 May 2023 08:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A44E101FC;
	Fri, 26 May 2023 08:58:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6F1101F4
	for <bpf@vger.kernel.org>; Fri, 26 May 2023 08:58:51 +0000 (UTC)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1297E9C
	for <bpf@vger.kernel.org>; Fri, 26 May 2023 01:58:49 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-51403554f1dso661742a12.1
        for <bpf@vger.kernel.org>; Fri, 26 May 2023 01:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685091527; x=1687683527;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JOZuMNVIw06Nk96LzlXy6TQ2FOHkSLNBLtIb5kXig5E=;
        b=ca5csqIGGbmt44nRTw81SgzQV/jgc4PkiQ4A6WE7f+5B/a7fuRpdUqWMoXifTm4MqR
         feB0BRsOis2auGUXMn8KL8++BnMSxooGCuPUrQL6KBS1Lj21OhQkkwKwApyfuv6/MJn7
         dB1AvUg9ZtuoYvJEawYjXL+N4UmpX9mlIlcvzzrzdpYlQuSqx1xF+sF7gnzbUohOYCLW
         cHnKn4R6yfn5oLbuiwmvWnMI1Eyae3KN4qiT1FXjry8j0Ap6Q1Ru8IOmx0ZQv2/A3Cgx
         cfEEcr3OTiJ3dAVBxFEar1Bq6SoSjFvpaH6laHHOlsdIefprxoJ4HdpSPPi03FI3mfpl
         xt0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685091527; x=1687683527;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JOZuMNVIw06Nk96LzlXy6TQ2FOHkSLNBLtIb5kXig5E=;
        b=hzeIbSH+oKVtdUKf36pfkWPNhpF5d9L+NbAT9azdE6qtsZ1xPn5KNMLzUOWSgRifXp
         TeaVb9J21CHtmqV3LdZ3/wXS+aNWJApGAT9bi1nmeA/l3LkrQKgl5PssKQ++w+kZdZdJ
         ZBVOwH5Kwuvt/Ldi9eSKnMMI+/99TA6nQap7/qnA4Wqkhy+2veDqvP2WbE8IJGX9cgaX
         JRKd6ATSid5t916HnNb0gPH79xzD0fDpNezUmxE5MrfCJWD5uCxx8WGhq8JKpCGwRUjl
         f2X9LJD+0dczDTCafcjKmOBrRDg0vlARPJ9NZ5I8cM/BSVEWMFuKcLmDXqVdbZ038EmJ
         58/Q==
X-Gm-Message-State: AC+VfDx3PwkUVw+ciHwJ8xM/668h7a8tLCgy9yPFjUYD+dwFtv2Zq4QT
	jfkcUder06yNVktm9ym2W+g=
X-Google-Smtp-Source: ACHHUZ7Qa9+Fe/FWjLnRsiYqC/AMd8MGrjHFVK636mC0x46XnUIcu/AJCSEbRq43to1piY+twQAQyA==
X-Received: by 2002:aa7:dad1:0:b0:510:f3a6:d50 with SMTP id x17-20020aa7dad1000000b00510f3a60d50mr1008754eds.36.1685091527198;
        Fri, 26 May 2023 01:58:47 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id ay9-20020a056402202900b0050690bc07a3sm1322281edb.18.2023.05.26.01.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 01:58:46 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 26 May 2023 10:58:44 +0200
To: Jackie Liu <liu.yun@linux.dev>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, olsajiri@gmail.com,
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
	yhs@fb.com, bpf@vger.kernel.org, liuyun01@kylinos.cn
Subject: Re: [PATCH v4] libbpf: kprobe.multi: Filter with
 available_filter_functions
Message-ID: <ZHB0xNEbjmwHv18d@krava>
References: <ZG8f7ffghG7mLUhR@krava>
 <20230525102747.68708-1-liu.yun@linux.dev>
 <CAEf4Bzae7mdpCDBEafG-NUCPRohWkC8EBs0+twE2hUbB8LqWJA@mail.gmail.com>
 <b2273217-5adb-8ec6-288b-4f8703a56386@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b2273217-5adb-8ec6-288b-4f8703a56386@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, May 26, 2023 at 09:38:15AM +0800, Jackie Liu wrote:
> Hi Andrii.
> 
> 在 2023/5/26 04:43, Andrii Nakryiko 写道:
> > On Thu, May 25, 2023 at 3:28 AM Jackie Liu <liu.yun@linux.dev> wrote:
> > > 
> > > From: Jackie Liu <liuyun01@kylinos.cn>
> > > 
> > > When using regular expression matching with "kprobe multi", it scans all
> > > the functions under "/proc/kallsyms" that can be matched. However, not all
> > > of them can be traced by kprobe.multi. If any one of the functions fails
> > > to be traced, it will result in the failure of all functions. The best
> > > approach is to filter out the functions that cannot be traced to ensure
> > > proper tracking of the functions.
> > > 
> > > Use available_filter_functions check first, if failed, fallback to
> > > kallsyms.
> > > 
> > > Here is the test eBPF program [1].
> > > [1] https://github.com/JackieLiu1/ketones/commit/a9e76d1ba57390e533b8b3eadde97f7a4535e867
> > > 
> > > Suggested-by: Jiri Olsa <olsajiri@gmail.com>
> > > Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
> > > ---
> > >   tools/lib/bpf/libbpf.c | 92 +++++++++++++++++++++++++++++++++++++-----
> > >   1 file changed, 83 insertions(+), 9 deletions(-)
> > > 
> > 
> > Question to you and Jiri: what happens when multi-kprobe's syms has
> > duplicates? Will the program be attached multiple times? If yes, then
> > it sounds like a problem? Both available_filters and kallsyms can have
> > duplicate function names in them, right?
> 
> If I understand correctly, there should be no problem with repeated
> function registration, because the bottom layer is done through fprobe
> registration addrs, kprobe.multi itself does not do this work, but
> fprobe is based on ftrace, it will register addr by makes a hash,
> that is, if it is the same address, it should be filtered out.

it won't get through the kprobe_multi symbols resolve code, because we
check that the number of resolved addresses matches the number of
provided symbols

also found test bug (hunk#2) when checking on that (hunk#1) ;-)

jirka


---
diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
index 2173c4bb555e..e78362354bd3 100644
--- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
@@ -124,7 +124,7 @@ static void test_link_api_syms(void)
 		"bpf_fentry_test5",
 		"bpf_fentry_test6",
 		"bpf_fentry_test7",
-		"bpf_fentry_test8",
+		"bpf_fentry_test7",
 	};
 
 	opts.kprobe_multi.syms = syms;
@@ -477,9 +477,9 @@ void test_kprobe_multi_test(void)
 	if (test__start_subtest("skel_api"))
 		test_skel_api();
 	if (test__start_subtest("link_api_addrs"))
-		test_link_api_syms();
-	if (test__start_subtest("link_api_syms"))
 		test_link_api_addrs();
+	if (test__start_subtest("link_api_syms"))
+		test_link_api_syms();
 	if (test__start_subtest("attach_api_pattern"))
 		test_attach_api_pattern();
 	if (test__start_subtest("attach_api_addrs"))

