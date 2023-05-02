Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 550786F4D46
	for <lists+bpf@lfdr.de>; Wed,  3 May 2023 00:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjEBWzb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 May 2023 18:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbjEBWz1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 May 2023 18:55:27 -0400
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706B640DE
        for <bpf@vger.kernel.org>; Tue,  2 May 2023 15:54:51 -0700 (PDT)
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1aaec9ad820so31539645ad.0
        for <bpf@vger.kernel.org>; Tue, 02 May 2023 15:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1683067954; x=1685659954;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r2pX6kGZYCdJUOyaHXAbCJD9MjqXC+7diD5tQkc+KIY=;
        b=KCieo0kz0DYFicmTnvJ/wZWMDUAp82OnLNQQwC6x6vYnQBWdNdy+kiNyfef/Chqaki
         stQyULFiM/TMo2XUweuFtdvf7ej+MsRY4LsYuHyF/s/h1aCzeCdmUiP/yZQPnvVVRu77
         rSmVoYBTeypM9QYFkPZIg0I3Hr6JXtXYg1smJOsB0hI/z7YEoGgsFw6aH6C6CYY4Vxm2
         A/5OH1TYp/t+Siq/ZRLEYv7dTUIVkiv7hI3fxS0Pk2zLKYyYRTElrF0sNe3Jq65Qvifc
         86pfTzLWH4YNCFYBkIjLPE2bMOLgEHGsjOciUlclQxFrJSKHyHAsDgztHN2DnU3H65jN
         rciw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683067954; x=1685659954;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r2pX6kGZYCdJUOyaHXAbCJD9MjqXC+7diD5tQkc+KIY=;
        b=BkI5OMx3P/wbXYAkzZhugxR95pTPjAQGknNxp5Q5865+5F8qMyoY7kmc3oUySTIUOX
         CfxYW5fEGXbRGGux1a5RG89IV3HHejwfVd3F2v7VaJHWg+tUKz30951wPdGlPNv4F+Nm
         corBjP9LNsRtpMlCt67Y1AKsgjARcbEcZXFfq5RpCY59rMQsXCJFcWqkszhmm3I5cJKd
         K6qY6LEdWvKANRh1UF1JINMPI2qB1ft104E/Diqge3MaekiSKGNiYWc0G9UFxxnwsROF
         CtGkkYnccLLjFn8Qm1dN2MUlVKCvMmgxCHaUqzBeC9onEYlPr+/E44NtKCIdO/x87d8Z
         p/3Q==
X-Gm-Message-State: AC+VfDzDv1T8FPGaAEvHF4uEc/u+vabbwjuhbF2V0T3YA1E811YskXKT
        gA/xftwLwp4zK2GCjZh1fE4olA==
X-Google-Smtp-Source: ACHHUZ6MtTCURvfqv1NroGmXYAhxbNSz3klbGx8K8MnI8n9e2Pz2VP+mtVI7MATIUrSyhsuY1luZ5w==
X-Received: by 2002:a17:902:ecc5:b0:1a6:81fc:b585 with SMTP id a5-20020a170902ecc500b001a681fcb585mr65812plh.41.1683067954345;
        Tue, 02 May 2023 15:52:34 -0700 (PDT)
Received: from ?IPv6:2601:647:4900:1fbb:ec67:e52b:8070:1b56? ([2601:647:4900:1fbb:ec67:e52b:8070:1b56])
        by smtp.gmail.com with ESMTPSA id w17-20020a1709027b9100b001a980a23804sm14519192pll.4.2023.05.02.15.52.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 May 2023 15:52:34 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.7\))
Subject: Re: [PATCH v6 bpf-next 0/7] bpf: Add socket destroy capability
From:   Aditi Ghag <aditi.ghag@isovalent.com>
In-Reply-To: <E6DB96AE-A7FA-4462-A0ED-4C53F3625BB1@isovalent.com>
Date:   Tue, 2 May 2023 15:52:33 -0700
Cc:     Stanislav Fomichev <sdf@google.com>, edumazet@google.com,
        bpf@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <2249BAC9-E23F-42CD-9F33-F09ABE24BAF6@isovalent.com>
References: <20230418153148.2231644-1-aditi.ghag@isovalent.com>
 <76dcba72-4e52-9ea1-cabd-b4c9f431c556@linux.dev>
 <E6DB96AE-A7FA-4462-A0ED-4C53F3625BB1@isovalent.com>
To:     Martin KaFai Lau <martin.lau@linux.dev>
X-Mailer: Apple Mail (2.3608.120.23.2.7)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On May 1, 2023, at 4:32 PM, Aditi Ghag <aditi.ghag@isovalent.com> =
wrote:
>=20
>=20
>=20
>> On Apr 24, 2023, at 3:15 PM, Martin KaFai Lau <martin.lau@linux.dev> =
wrote:
>>=20
>> On 4/18/23 8:31 AM, Aditi Ghag wrote:
>>> This patch adds the capability to destroy sockets in BPF. We plan to =
use
>>> the capability in Cilium to force client sockets to reconnect when =
their
>>> remote load-balancing backends are deleted. The other use case is
>>> on-the-fly policy enforcement where existing socket connections =
prevented
>>> by policies need to be terminated.
>>=20
>> If the earlier kfunc filter patch =
(https://lore.kernel.org/bpf/1ECC8AAA-C2E6-4F8A-B7D3-5E90BDEE7C48@isovalen=
t.com/) looks fine to you, please include it into the next revision. =
This patchset needs it. Usual thing to do is to keep my sob (and author =
if not much has changed) and add your sob. The test needs to be broken =
out into a separate patch though. It needs to use the '__failure =
__msg("calling kernel function bpf_sock_destroy is not allowed")'. There =
are many examples in selftests, eg. the dynptr_fail.c.
>>=20
>=20
> Yeah, ok. I was waiting for your confirmation. The patch doesn't need =
my sob though (maybe tested-by).
> I've created a separate patch for the test.=20


Here is the patch diff for the extended test case for your reference. =
I'm ready to push a new version once I get an ack from you.=20

diff --git a/tools/testing/selftests/bpf/prog_tests/sock_destroy.c =
b/tools/testing/selftests/bpf/prog_tests/sock_destroy.c
index a889c53e93c7..afed8cad94ee 100644
--- a/tools/testing/selftests/bpf/prog_tests/sock_destroy.c
+++ b/tools/testing/selftests/bpf/prog_tests/sock_destroy.c
@@ -3,6 +3,7 @@
 #include <bpf/bpf_endian.h>

 #include "sock_destroy_prog.skel.h"
+#include "sock_destroy_prog_fail.skel.h"
 #include "network_helpers.h"

 #define TEST_NS "sock_destroy_netns"
@@ -207,6 +208,8 @@ void test_sock_destroy(void)
                test_udp_server(skel);


+       RUN_TESTS(sock_destroy_prog_fail);
+
 cleanup:
        if (nstoken)
                close_netns(nstoken);
diff --git a/tools/testing/selftests/bpf/progs/sock_destroy_prog_fail.c =
b/tools/testing/selftests/bpf/progs/sock_destroy_prog_fail.c
new file mode 100644
index 000000000000..dd6850b58e25
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/sock_destroy_prog_fail.c
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+
+#include "bpf_misc.h"
+
+char _license[] SEC("license") =3D "GPL";
+
+int bpf_sock_destroy(struct sock_common *sk) __ksym;
+
+SEC("tp_btf/tcp_destroy_sock")
+__failure __msg("calling kernel function bpf_sock_destroy is not =
allowed")
+int BPF_PROG(trace_tcp_destroy_sock, struct sock *sk)
+{
+       /* should not load */
+       bpf_sock_destroy((struct sock_common *)sk);
+
+       return 0;
+}

>=20
>=20
>> Please also fix the subject in the patches. They are all missing the =
bpf-next and revision tag.
>>=20
>=20
> Took me a few moments to realize that as I was looking at earlier =
series. Looks like I forgot to add the tags to subsequent patches in =
this series. I'll fix it up in the next push.

