Return-Path: <bpf+bounces-9132-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC3F790507
	for <lists+bpf@lfdr.de>; Sat,  2 Sep 2023 06:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45BAC2819F1
	for <lists+bpf@lfdr.de>; Sat,  2 Sep 2023 04:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B681864;
	Sat,  2 Sep 2023 04:42:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9AF15C1
	for <bpf@vger.kernel.org>; Sat,  2 Sep 2023 04:42:27 +0000 (UTC)
Received: from out203-205-251-59.mail.qq.com (out203-205-251-59.mail.qq.com [203.205.251.59])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C618C1707;
	Fri,  1 Sep 2023 21:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1693629738;
	bh=VDeJU94IWnvseyKaMxC4IUln27g8AmHmoNXDqEplCe8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LkVhl7Tw1XoBWDKsxT8iWaFBUDhACP8sUZDECEndI52B3TwNCAPJCjTUf/zx26KWm
	 t3mWgxVqoaIAJ5LDF8fR/PBPVEsjrLzmZbcQO75Rd5HQpx6We366cUHdJJL/JBWicA
	 smn82tgqDCRcq6rGDdFCuq8+agLvcNe072FduVak=
Received: from rtoax.lan ([120.245.114.63])
	by newxmesmtplogicsvrsza12-0.qq.com (NewEsmtp) with SMTP
	id A4223C8B; Sat, 02 Sep 2023 12:41:02 +0800
X-QQ-mid: xmsmtpt1693629710t5d0r7m38
Message-ID: <tencent_51C8597C97032AF5AFDAA30C887206014208@qq.com>
X-QQ-XMAILINFO: OUUXHEo9i1ukFJYgSO1dj9mwONQKPyftWMC5kUq9pKAIUP2tf+OHYc6I9HtYAo
	 0f/3PO0B89VA74pYjo2DdVEIauYDaRoTfC/fxGDITJPujGHJDeyNGhoELfvoSafZFrz8N0I1Iwx/
	 b5wnVASGROPcyRToyEOmu4Rz028wqnA91sDkamJRvqvJvToBng6ow7WFal2FSRl+iz4DHAekn27S
	 Y+Aev9kKWjxfNh1atT9Io/mpSrNg/0kJt8jZxG1jFnLlMT13jT0/nfcJ9zlaSEHNsrYCdkmbfAjo
	 uBsgsbn/tv04U5TqmT0zGJBMvSLOgS6iEcbL42cKYqeEVieSCrkTYZgb9J1aw5ZgRrAUyC1mxpOR
	 qJs9KF8nyVoMOTq0Jd/MJNXQjmwqQPENuk3/oeVwcWsU79j0AhKwWnYdDbF1z6AIEHDQZwamJ3Ek
	 b6I7Qs891Z6CYjheDKyVdJBourSAfgfnaWgQ3W6TCPa7F2LJdvndwY1fxm1v9zrT+i24FnxsKijV
	 47P+BPxXknxt5RgTMvkfHeWAdPyKw1crODvsOsEGU19La88qzRmwO24wussXD982sNjJTgf11jGY
	 m6He9LF8i6XHshm80wZCvObkHjBdStTOBcs/4qYBLZf1Wshi6+uOKj2aPVzRC1c5qp5BwfEnB9dZ
	 awYQEjtmuLXBglrdOLZzBLnHlgVEmhe38VTjqVNA3LA4+Mp8jXpQuawh1zvvtLyLzAI15Oyomg/1
	 nWl9De49ikMIlgXQCobvBWVPATu3h0eCf4W89BVufWF0xl6OX0NMwAaU+DN7LdhbS7QfD/JBXEh9
	 qXyQI6uSl4rCI+i8lBE10blxb+5WFO/IsECuJQnc1d3vBo646W4+sspxPh7MHZlt9AszkWq01rZP
	 wg1yWqZ7AoUx+54hGZ61gWlbaj42ncOHAF+xl+duHm7YkKvgFZtL+Yy+Q2Dl98tK7d69w+sIv2DW
	 crF9/kDKBIcbyZGxJDCldrA6qnI/E0o9n2Uqj+X5BbpGES4l3JNp10kQFsdZTLTxTHJavji3zW1n
	 IPf1Xi53Pw+YzJ+55e
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Rong Tao <rtoax@foxmail.com>
To: olsajiri@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	sdf@google.com
Cc: Rong Tao <rongtao@cestc.cn>,
	Alexei Starovoitov <ast@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Yafang Shao <laoar.shao@gmail.com>,
	bpf@vger.kernel.org (open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)),
	linux-kernel@vger.kernel.org (open list),
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
	linux-stm32@st-md-mailman.stormreply.com (moderated list:ARM/STM32 ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/STM32 ARCHITECTURE)
Subject: [PATCH bpf-next v10 2/2] selftests/bpf: trace_helpers.c: Add a global ksyms initialization mutex
Date: Sat,  2 Sep 2023 12:40:19 +0800
X-OQ-MSGID: <20230902044040.137804-3-rtoax@foxmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230902044040.137804-1-rtoax@foxmail.com>
References: <20230902044040.137804-1-rtoax@foxmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Rong Tao <rongtao@cestc.cn>

As Jirka said [0], we just need to make sure that global ksyms
initialization won't race.

[0] https://lore.kernel.org/lkml/ZPCbAs3ItjRd8XVh@krava/

Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
 tools/testing/selftests/bpf/trace_helpers.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/selftests/bpf/trace_helpers.c
index d64c4ef336e1..500b60226e5e 100644
--- a/tools/testing/selftests/bpf/trace_helpers.c
+++ b/tools/testing/selftests/bpf/trace_helpers.c
@@ -7,6 +7,7 @@
 #include <errno.h>
 #include <fcntl.h>
 #include <poll.h>
+#include <pthread.h>
 #include <unistd.h>
 #include <linux/perf_event.h>
 #include <sys/mman.h>
@@ -26,6 +27,7 @@ struct ksyms {
 };
 
 static struct ksyms *ksyms;
+static pthread_mutex_t ksyms_mutex = PTHREAD_MUTEX_INITIALIZER;
 
 static int ksyms__add_symbol(struct ksyms *ksyms, const char *name,
 							 unsigned long addr)
@@ -115,8 +117,10 @@ struct ksyms *load_kallsyms_local(void)
 
 int load_kallsyms(void)
 {
+	pthread_mutex_lock(&ksyms_mutex);
 	if (!ksyms)
 		ksyms = load_kallsyms_local();
+	pthread_mutex_unlock(&ksyms_mutex);
 	return ksyms ? 0 : 1;
 }
 
-- 
2.41.0


